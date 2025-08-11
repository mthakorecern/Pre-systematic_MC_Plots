import ROOT
ROOT.ROOT.EnableImplicitMT()
ROOT.gROOT.SetBatch(True)  # To ensure that there's no GUI displayed in b/w while plotting
ROOT.TH1.AddDirectory(False)
ROOT.TH1.SetDefaultSumw2(True)

import argparse
import os
import glob
from samples import redirector, signal, backgrounds
from variable_dictionaries import variableAxisTitleDictionary, variableFileNameDictionary, variableSettingDictionary
import time

#############################################################################################

def create_cut_string(weights, base_cut, additional_cuts, is_observed=False):
    '''
    This is similar to what Ganesh has in his code.
    '''
    if additional_cuts is None:
        additional_cuts = []

    if is_observed:
        cut_string = "("
    else:
        cut_string = f"{weights} * ("

    all_cuts = []
    if base_cut:
        all_cuts.append(base_cut)
    if additional_cuts:
        all_cuts.extend(additional_cuts)

    cut_string += " && ".join([f"({cut})" for cut in all_cuts])
    cut_string += ")"
    return cut_string

def group_key_from_name(name):
    '''
    After reading the histogram, group them.
    '''
    if any(s in name for s in ["WW","WZ","ZZ"]):
        return "DiBoson"
    if any(s in name for s in ["TWminus","TbarWplus","TbarBQ","TBbarQ"]):
        return "STop"
    if "TT"   in name:
        return "TTbar"
    if "QCD"  in name:
        return "QCD"
    if "Wto"  in name:
        return "WJets"
    if "DYto" in name:
        return "Drell-Yan"
    return "Other"

#############################################################################################

# Command-line argument parsing
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate histograms from ROOT files.")
    #parser.add_argument("--path", required=True, help="Path to directory containing ROOT files.")
    parser.add_argument('--year',
                        nargs='?',
                        choices=['2024'],
                        help='Use the file\'s fake factor weightings when making plots for these files.',
                        required=True)
    parser.add_argument("--variables", nargs="+", required=True, help="Variables to plot.")
    parser.add_argument("--cuts", default="", help="Standard cut string.")
    parser.add_argument("--additional_cuts", nargs="+", default=[], help="Additional selection cuts.")
    parser.add_argument("--weights", default="FinalWeighting", help="Event weight expression.")
    parser.add_argument("--set_maximum", type=float, default=350, help="Set the maximum value for the Y-axis.")
    parser.add_argument("--log_scale", action="store_true", help="Enable logarithmic Y-axis scaling.")
    parser.add_argument('--Channel',choices=["tt","et","mt","all","lt"], required=True)
    parser.add_argument("--luminosity", type=float, required=True, help="Integrated luminosity in /fb")

    start = time.time()
    args = parser.parse_args()
    variable = args.variables[0]
    weights = args.weights
    base_cut = args.cuts
    additional_cuts_o = args.additional_cuts
    set_maximum = args.set_maximum 
    log_scale = args.log_scale      

    bins = variableSettingDictionary.get(variable, "21,0,1000")  
    bin_values = tuple(map(float, bins.split(',')))  

    canvas = ROOT.TCanvas("canvas", "Stacked Histograms", 1250, 800)
    canvas.SetRightMargin(0.30)  
    theLegend = ROOT.TLegend(0.72, 0.2, 0.99, 0.9, "", "brNDC")

    hists = {}
    observed_data = {}
    integral_values = []
    hist_stack = ROOT.THStack("hist_stack", "")

    hists['DiBoson'] = ROOT.TH1F("DiBoson", "DiBoson",  int(bin_values[0]), bin_values[1], bin_values[2])
    hists['DiBoson'].Sumw2()
    hists['DiBoson'].SetDirectory(0)
    
    hists['STop'] = ROOT.TH1F("STop",    "STop",     int(bin_values[0]), bin_values[1], bin_values[2])
    hists['STop'].Sumw2()
    hists['STop'].SetDirectory(0)
    
    hists['TTbar'] = ROOT.TH1F("TTbar",   "TTbar",    int(bin_values[0]), bin_values[1], bin_values[2])
    hists['TTbar'].Sumw2()
    hists['TTbar'].SetDirectory(0)
    
    hists['QCD'] = ROOT.TH1F("QCD",     "QCD",      int(bin_values[0]), bin_values[1], bin_values[2])
    hists['QCD'].Sumw2()
    hists['QCD'].SetDirectory(0)
    
    hists['WJets'] = ROOT.TH1F("WJets",   "WJets",    int(bin_values[0]), bin_values[1], bin_values[2])
    hists['WJets'].Sumw2()
    hists['WJets'].SetDirectory(0)

    hists['Drell-Yan'] = ROOT.TH1F("Drell-Yan","Drell-Yan",int(bin_values[0]), bin_values[1], bin_values[2])
    hists['Drell-Yan'].Sumw2()
    hists['Drell-Yan'].SetDirectory(0)

    hists['Other'] = ROOT.TH1F("Other",   "Other",    int(bin_values[0]), bin_values[1], bin_values[2])
    hists['Other'].Sumw2()
    hists['Other'].SetDirectory(0)

    hist_title = variableAxisTitleDictionary.get(variable, variable)

    hists_by_proc = {}  
    ngen_by_proc  = {}

    # unweighted selection (no per-event weights here), still applying the same kinematic cuts
    cut_unw = create_cut_string("", base_cut, additional_cuts_o, is_observed=True)
    print(f"Unweighted selection: {cut_unw}")

    for category, sample_type in backgrounds.items():
        for proc_name, proc_info in sample_type.items():
            xsec_pb = proc_info.get("xsec", None)
            if xsec_pb is None:
                print(f"No xsec for {proc_name}, skipping.")
                continue

            hists_by_proc.setdefault(proc_name, [])
            ngen_by_proc.setdefault(proc_name, 0.0)

            for path in proc_info["files"]:
                print(f"Processing {path}")
                print(f"Histogram bins and ranges are {int(bin_values[0]), bin_values[1], bin_values[2]}")
                hist_name = f"{os.path.basename(path.replace('.root', ''))}_{variable}"
                full_path = os.path.join(redirector, path)

                root_file = ROOT.TFile.Open(full_path, 'READ')
                if not root_file or root_file.IsZombie():
                    print(f"Could not open {full_path}")
                    continue

                cutflow_hist = root_file.Get("cutflow")
                if not cutflow_hist:
                    print(f"No cutflow in {full_path}")
                    root_file.Close()
                    continue

                total_events = cutflow_hist.GetBinContent(2) # Get the total number of generated events before skimming
                print(f"Total number of events before any cuts are: {total_events}")
                if total_events <= 0:
                    print(f"Total_events<=0 for {full_path}")
                    root_file.Close()
                    continue

                ngen_by_proc[proc_name] += total_events

                tree = root_file.Get("Events")
                if not tree:
                    print(f"No Events tree in {full_path}")
                    root_file.Close()
                    continue

                # create unweighted histograms
                h = ROOT.TH1F(hist_name, hist_title, int(bin_values[0]), bin_values[1], bin_values[2])
                h.Sumw2()
                h.SetDirectory(ROOT.gDirectory)
                h.Reset()

                tree.Draw(f"{variable} >> {hist_name}", cut_unw)
                h.SetDirectory(0)
                hists_by_proc[proc_name].append(h)
                print(f"Stored unweighted hist {hist_name} with entries={h.GetEntries()} and integral={h.Integral(0, h.GetNbinsX()+1)}")
                root_file.Close()

    # scale per-process and add to category sums
    lumipb = args.luminosity * 1000.0  # fb^-1 -> pb^-1
    for category, sample_type in backgrounds.items():
        for proc_name, proc_info in sample_type.items():
            if proc_name not in hists_by_proc or len(hists_by_proc[proc_name]) == 0:
                continue
            xsec_pb = proc_info.get("xsec", None)
            if xsec_pb is None:
                continue
            Ngen = ngen_by_proc.get(proc_name, 0.0)
            if Ngen <= 0:
                print(f"[{proc_name}] Ngen<=0 after loop, skipping scaling.")
                continue

            w_proc = (xsec_pb * lumipb) / Ngen
            print(f"[{proc_name}] weight = {w_proc}  (xsec={xsec_pb} pb, L={lumipb} pb^-1, No. of events generated={Ngen})")

            for h in hists_by_proc[proc_name]:
                h.Scale(w_proc)
                key = group_key_from_name(h.GetName())
                hists[key].Add(h)

    # styling for category-sum histograms
    hists["DiBoson"].SetLineColor(ROOT.TColor.GetColor("#9d99bd"))
    hists["DiBoson"].SetFillColor(ROOT.TColor.GetColor("#9d99bd"))
    print("Diboson background Integral is:")
    print(hists["DiBoson"].Integral(0, hists["DiBoson"].GetNbinsX()+1))

    hists["STop"].SetLineColor(ROOT.TColor.GetColor("#a5e7fa"))
    hists["STop"].SetFillColor(ROOT.TColor.GetColor("#a5e7fa"))
    print("STop background Integral is:")
    print(hists["STop"].Integral(0, hists["STop"].GetNbinsX()+1))

    hists["TTbar"].SetLineColor(ROOT.TColor.GetColor("#92cfe0"))
    hists["TTbar"].SetFillColor(ROOT.TColor.GetColor("#92cfe0"))
    print("TTbar background Integral is:")
    print(hists["TTbar"].Integral(0, hists["TTbar"].GetNbinsX()+1))

    hists["QCD"].SetLineColor(ROOT.TColor.GetColor("#f29b6f"))
    hists["QCD"].SetFillColor(ROOT.TColor.GetColor("#f29b6f"))
    print("QCD background Integral is:")
    print(hists["QCD"].Integral(0, hists["QCD"].GetNbinsX()+1))

    hists["WJets"].SetLineColor(ROOT.TColor.GetColor("#fcd068"))
    hists["WJets"].SetFillColor(ROOT.TColor.GetColor("#fcd068"))
    print("WJets background Integral is:")  
    print(hists["WJets"].Integral(0, hists["WJets"].GetNbinsX()+1))

    hists["Drell-Yan"].SetLineColor(ROOT.TColor.GetColor("#d8ed79"))
    hists["Drell-Yan"].SetFillColor(ROOT.TColor.GetColor("#d8ed79"))
    print("Drell-Yan background Integral is:")  
    print(hists["Drell-Yan"].Integral(0, hists["Drell-Yan"].GetNbinsX()+1))

    hists["Other"].SetLineColor(ROOT.TColor.GetColor("#ffff00"))
    hists["Other"].SetFillColor(ROOT.TColor.GetColor("#ffff00"))
    print("Other background Integral is:")  
    print(hists["Other"].Integral(0, hists["Other"].GetNbinsX()+1))

    backgrounds_sum = (
        hists["DiBoson"].Integral(0, hists["DiBoson"].GetNbinsX()+1)
        + hists["STop"].Integral(0, hists["STop"].GetNbinsX()+1)
        + hists["TTbar"].Integral(0, hists["TTbar"].GetNbinsX()+1)
        + hists["QCD"].Integral(0, hists["QCD"].GetNbinsX()+1)
        + hists["WJets"].Integral(0, hists["WJets"].GetNbinsX()+1)
        + hists["Drell-Yan"].Integral(0, hists["Drell-Yan"].GetNbinsX()+1)
    )

    print(f"Sum of background Integrals is: {backgrounds_sum}")
    hist_stack.Add(hists["DiBoson"])
    hist_stack.Add(hists["STop"])
    hist_stack.Add(hists["TTbar"])
    hist_stack.Add(hists["QCD"])
    hist_stack.Add(hists["WJets"])
    hist_stack.Add(hists["Drell-Yan"])
    # hist_stack.Add(hists["Other"])

    # legend header
    if (args.Channel == "tt"):
        theLegend.SetHeader("#tau-#tau Channel","C")
    elif (args.Channel == "et"):
        theLegend.SetHeader("l-#tau Channel","C")
    elif (args.Channel == "mt"):
        theLegend.SetHeader("#mu-#tau Channel","C")
    elif (args.Channel == "lt"):
        theLegend.SetHeader("l-#tau Channel","C")
    elif (args.Channel == "all"):
        theLegend.SetHeader("all Channels","C")
    else:
        print ("Enter a valid channel")

    theLegend.SetNColumns(1)
    theLegend.SetTextSize(0.02)
    theLegend.SetLineWidth(0)
    theLegend.SetLineStyle(1)
    theLegend.SetFillStyle(1001)
    theLegend.SetFillColor(0)
    theLegend.SetBorderSize(0)
    theLegend.SetTextFont(40)
    theLegend.SetMargin(0.2)
    theLegend.AddEntry(hists["DiBoson"], "DiBoson", "f")
    theLegend.AddEntry(hists["STop"], "STop", "f")
    theLegend.AddEntry(hists["TTbar"], "TTbar", "f")
    theLegend.AddEntry(hists["QCD"], "QCD", "f")
    theLegend.AddEntry(hists["WJets"], "WJets", "f")
    theLegend.AddEntry(hists["Drell-Yan"], "Drell-Yan", "f")

##############################################################################

##############################################################################

    # selection with event weights for signals
    cut_sig = create_cut_string(weights, base_cut, additional_cuts_o, is_observed=False)

    # Signal weights (xsec * L / Ngen)
    lumipb = args.luminosity * 1000.0  # fb^-1 -> pb^-1

    # Signal 1
    sig_info = signal["GluGlutoRadiontoHHto2B2Tau_M-1000"]
    sig_file = sig_info["files"][0]
    hist_name_1 = f"{os.path.basename(sig_file.replace('.root', ''))}_{variable}"
    root_file_1 = ROOT.TFile.Open(os.path.join(redirector, sig_file), 'READ')
    cutflow_1 = root_file_1.Get("cutflow")
    total_events_1 = cutflow_1.GetBinContent(2)
    sig_weight_1 = (sig_info["xsec"] * lumipb) / total_events_1
    tree_1 = root_file_1.Get("Events")
    signal_1 = ROOT.TH1F(hist_name_1, hist_title, int(bin_values[0]), bin_values[1], bin_values[2])
    #signal_1.SetDirectory(0)
    signal_1.Sumw2()
    
    ROOT.gDirectory.Delete(f"{hist_name_1};*")   # optional but safe
    signal_1.SetDirectory(ROOT.gDirectory)
    tree_1.Draw(f"{variable} >> {hist_name_1}", cut_sig)
    signal_1.SetDirectory(0)
    signal_1.Scale(sig_weight_1)
    print(f"Integral of {hist_name_1} is {signal_1.Integral()}")
    print(f" - Entries: {signal_1.GetEntries()} | Mean: {signal_1.GetMean():.4f} | Std Dev: {signal_1.GetStdDev():.4f}")
    root_file_1.Close()

    # Signal 2
    sig_info = signal["GluGlutoRadiontoHHto2B2Tau_M-2000"]
    sig_file = sig_info["files"][0]
    hist_name_2 = f"{os.path.basename(sig_file.replace('.root', ''))}_{variable}"
    root_file_2 = ROOT.TFile.Open(os.path.join(redirector, sig_file), 'READ')
    cutflow_2 = root_file_2.Get("cutflow")
    total_events_2 = cutflow_2.GetBinContent(2)
    sig_weight_2 = (sig_info["xsec"] * lumipb) / total_events_2
    tree_2 = root_file_2.Get("Events")
    signal_2 = ROOT.TH1F(hist_name_2, hist_title, int(bin_values[0]), bin_values[1], bin_values[2])
    #signal_2.SetDirectory(0)
    signal_2.Sumw2()
    ROOT.gDirectory.Delete(f"{hist_name_2};*")
    signal_2.SetDirectory(ROOT.gDirectory)
    tree_2.Draw(f"{variable} >> {hist_name_2}", cut_sig)
    signal_2.SetDirectory(0)
    signal_2.Scale(sig_weight_2)
    print(f"Integral of {hist_name_2} is {signal_2.Integral()}")
    print(f" - Entries: {signal_2.GetEntries()} | Mean: {signal_2.GetMean():.4f} | Std Dev: {signal_2.GetStdDev():.4f}")
    root_file_2.Close()

    # Signal 3
    sig_info = signal["GluGlutoRadiontoHHto2B2Tau_M-3000"]
    sig_file = sig_info["files"][0]
    hist_name_3 = f"{os.path.basename(sig_file.replace('.root', ''))}_{variable}"
    root_file_3 = ROOT.TFile.Open(os.path.join(redirector, sig_file), 'READ')
    cutflow_3 = root_file_3.Get("cutflow")
    total_events_3 = cutflow_3.GetBinContent(2)
    sig_weight_3 = (sig_info["xsec"] * lumipb) / total_events_3
    tree_3 = root_file_3.Get("Events")
    signal_3 = ROOT.TH1F(hist_name_3, hist_title, int(bin_values[0]), bin_values[1], bin_values[2])
    #signal_3.SetDirectory(0)
    signal_3.Sumw2()
    ROOT.gDirectory.Delete(f"{hist_name_3};*")
    signal_3.SetDirectory(ROOT.gDirectory)
    tree_3.Draw(f"{variable} >> {hist_name_3}", cut_sig)
    signal_3.SetDirectory(0)
    signal_3.Scale(sig_weight_3)
    print(f"Integral of {hist_name_3} is {signal_3.Integral()}")
    print(f" - Entries: {signal_3.GetEntries()} | Mean: {signal_3.GetMean():.4f} | Std Dev: {signal_3.GetStdDev():.4f}")
    root_file_3.Close()

    # Signal 4
    sig_info = signal["GluGlutoRadiontoHHto2B2Tau_M-4000"]
    sig_file = sig_info["files"][0]
    hist_name_4 = f"{os.path.basename(sig_file.replace('.root', ''))}_{variable}"
    root_file_4 = ROOT.TFile.Open(os.path.join(redirector, sig_file), 'READ')
    cutflow_4 = root_file_4.Get("cutflow")
    total_events_4 = cutflow_4.GetBinContent(2)
    sig_weight_4 = (sig_info["xsec"] * lumipb) / total_events_4
    tree_4 = root_file_4.Get("Events")
    signal_4 = ROOT.TH1F(hist_name_4, hist_title, int(bin_values[0]), bin_values[1], bin_values[2])
    #signal_4.SetDirectory(0)
    signal_4.Sumw2()
    ROOT.gDirectory.Delete(f"{hist_name_4};*")
    signal_4.SetDirectory(ROOT.gDirectory)
    tree_4.Draw(f"{variable} >> {hist_name_4}", cut_sig)
    signal_4.SetDirectory(0)
    signal_4.Scale(sig_weight_4)
    print(f"Integral of {hist_name_4} is {signal_4.Integral()}")
    print(f" - Entries: {signal_4.GetEntries()} | Mean: {signal_4.GetMean():.4f} | Std Dev: {signal_4.GetStdDev():.4f}")
    root_file_4.Close()

    if log_scale:
        canvas.SetLogy()

    # Create a total background histogram by summing all components
    total_bkg_hist = hists["DiBoson"].Clone("total_bkg")
    total_bkg_hist.Add(hists["STop"])
    total_bkg_hist.Add(hists["TTbar"])
    total_bkg_hist.Add(hists["QCD"])
    total_bkg_hist.Add(hists["WJets"])
    total_bkg_hist.Add(hists["Drell-Yan"])
    #total_bkg_hist.Add(hists["Other"])
    print("Final stacked background (total_bkg_hist) stats:")
    print(f" - Entries: {total_bkg_hist.GetEntries()}")
    print(f" - Mean: {total_bkg_hist.GetMean():.4f}")
    print(f" - Std Dev: {total_bkg_hist.GetStdDev():.4f}")
    if total_bkg_hist.GetMean() != 0:
        print(f" - Resolution: {total_bkg_hist.GetStdDev() / total_bkg_hist.GetMean():.4f}\n")
    else:
        print(" - Resolution: Undefined (mean is zero)\n")

    # Create the error band
    bkg_errors = ROOT.TGraphAsymmErrors(total_bkg_hist)

    # Fill the error band with statistical uncertainties
    for b in range(1, total_bkg_hist.GetNbinsX() + 1):
        bin_content = total_bkg_hist.GetBinContent(b)
        bin_error = total_bkg_hist.GetBinError(b)  # Poisson sqrt(N) uncertainty
        bkg_errors.SetPoint(b - 1, total_bkg_hist.GetBinCenter(b), bin_content)
        bkg_errors.SetPointError(b - 1, total_bkg_hist.GetBinWidth(b)/2, total_bkg_hist.GetBinWidth(b)/2, bin_error, bin_error)

    # Style the error band
    bkg_errors.SetLineColor(0)
    bkg_errors.SetFillStyle(3008)  # Shaded band style
    bkg_errors.SetFillColor(ROOT.TColor.GetColor("#545252"))  # Gray color
    bkg_errors.SetMarkerStyle(0)
    bkg_errors.SetLineWidth(0)

    # draw stack
    hist_stack.Draw("hist")
    hist_stack.GetXaxis().SetTitle(hist_title)
    hist_stack.GetYaxis().SetTitle("Events")
    max_bkg = max(h.GetMaximum() for k,h in hists.items())
    hist_stack.SetMaximum(1.5*max(max_bkg, signal_1.GetMaximum(), signal_2.GetMaximum(),
                                  signal_3.GetMaximum(), signal_4.GetMaximum()))

    signal_1.SetLineColor(ROOT.kRed)
    signal_1.SetLineWidth(2)
    signal_2.SetLineColor(ROOT.kBlue+2)
    signal_2.SetLineWidth(2)
    signal_3.SetLineColor(ROOT.kViolet+3)
    signal_3.SetLineWidth(2)
    signal_4.SetLineColor(ROOT.kCyan+4)
    signal_4.SetLineWidth(2)

    signal_1.Draw("hist SAME")
    signal_2.Draw("hist SAME")
    signal_3.Draw("hist SAME")
    signal_4.Draw("hist SAME")

    theLegend.AddEntry(signal_1, '1TeV (1pb x 0.073 (bbtt BR))', "f")
    theLegend.AddEntry(signal_2, '2TeV (1pb x 0.073 (bbtt BR))', "f")
    theLegend.AddEntry(signal_3, '3TeV (1pb x 0.073 (bbtt BR))', "f")
    theLegend.AddEntry(signal_4, '4TeV (1pb x 0.073 (bbtt BR))', "f")

    # Draw the background error band
    bkg_errors.Draw("E2 SAME")

    # also draw the preliminary warnings
    cmsLatex = ROOT.TLatex()
    cmsLatex.SetTextSize(0.025)
    cmsLatex.SetNDC(True)
    cmsLatex.SetTextFont(61)
    cmsLatex.SetTextAlign(11)
    cmsLatex.DrawLatex(0.10,0.91,"CMS")
    cmsLatex.SetTextFont(52)
    cmsLatex.DrawLatex(0.10+0.035,0.91,"Preliminary")

    cmsLatex.SetTextAlign(31)
    cmsLatex.SetTextFont(42)
    if args.year == '2024':
        lumiText = '109.08 fb^{-1}, 13.6 TeV (2024)'
    elif args.year == '2016APV':
        lumiText = '19.52 fb^{-1}, 13 TeV'
    cmsLatex.DrawLatex(0.700,0.91,lumiText)

    theLegend.SetNColumns(1)
    theLegend.SetTextSize(0.025)
    theLegend.SetX1NDC(0.70)
    theLegend.SetX2NDC(0.1)
    theLegend.SetY1NDC(0.15)
    theLegend.SetY2NDC(0.1)
    theLegend.Draw()
    canvas.Draw()
    canvas.SaveAs(f"{args.year}_{args.Channel}_{variable}.png")
    end = time.time()
    print(f"Execution time: {end - start:.2f} seconds")
