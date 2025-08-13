#!/usr/bin/env bash
set -u

YEAR=2024
LUMI=109.08
WEIGHTS="genWeight"
CHANNEL="all"
MAX=1e8

# Common selection used everywhere
CUTS='FatJet_msoftdrop > 30 && Tau_pt > 20 && abs(Tau_eta) < 2.5 && abs(Tau_dz) < 0.2 && abs(boostedTau_eta) < 2.5 && Electron_pt > 10 && abs(Electron_eta) < 2.4 && abs(Muon_eta) < 2.5 && Muon_pt > 15 && PuppiMET_pt > 100 && abs(FatJet_eta) < 2.5 && FatJet_pt > 200 && abs(Jet_eta) < 2.5 && Jet_pt > 30'

# # --- PVs ---
# python3 norm.py --year "$YEAR" --variables "PV_npvs"     --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_PV_npvs.txt &
# python3 norm.py --year "$YEAR" --variables "PV_npvsGood" --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_PV_npvsGood.txt &

# --- FatJet ---
python3 norm.py --year "$YEAR" --variables "nFatJet"                      --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_nFatJet.txt &

# python3 norm.py --year "$YEAR" --variables "FatJet_pt"                      --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_FatJet_pt.txt &
# python3 norm.py --year "$YEAR" --variables "FatJet_eta"                     --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_FatJet_eta.txt &
# python3 norm.py --year "$YEAR" --variables "FatJet_phi"                     --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_FatJet_phi.txt &
# python3 norm.py --year "$YEAR" --variables "FatJet_mass"                    --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_FatJet_mass.txt &
# python3 norm.py --year "$YEAR" --variables "FatJet_msoftdrop"               --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_FatJet_msoftdrop.txt &
# python3 norm.py --year "$YEAR" --variables "FatJet_particleNetLegacy_mass"  --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_FatJet_particleNetLegacy_mass.txt &

# # --- Electrons ---
# python3 norm.py --year "$YEAR" --variables "nElectron"   --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_nElectron.txt &
# python3 norm.py --year "$YEAR" --variables "Electron_pt" --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_Electron_pt.txt &
# python3 norm.py --year "$YEAR" --variables "Electron_eta" --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_Electron_eta.txt &
# python3 norm.py --year "$YEAR" --variables "Electron_phi" --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_Electron_phi.txt &

# # --- Muons ---
# python3 norm.py --year "$YEAR" --variables "nMuon"    --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_nMuon.txt &
# python3 norm.py --year "$YEAR" --variables "Muon_pt"  --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_Muon_pt.txt &
# python3 norm.py --year "$YEAR" --variables "Muon_eta" --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_Muon_eta.txt &
# python3 norm.py --year "$YEAR" --variables "Muon_phi" --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_Muon_phi.txt &

# # --- Taus ---
# python3 norm.py --year "$YEAR" --variables "nTau"   --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_nTau.txt &
# python3 norm.py --year "$YEAR" --variables "Tau_pt" --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_Tau_pt.txt &

# # --- Boosted Taus ---
# python3 norm.py --year "$YEAR" --variables "nboostedTau"  --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_nboostedTau.txt &
# python3 norm.py --year "$YEAR" --variables "boostedTau_pt" --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_boostedTau_pt.txt &

# # --- PuppiMET ---
# python3 norm.py --year "$YEAR" --variables "PuppiMET_pt"  --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_PuppiMET_pt.txt &
# python3 norm.py --year "$YEAR" --variables "PuppiMET_phi" --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_PuppiMET_phi.txt &

# # --- AK4 Jets ---
# python3 norm.py --year "$YEAR" --variables "nJet"   --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_nJet.txt &
# python3 norm.py --year "$YEAR" --variables "Jet_pt" --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_Jet_pt.txt &
# python3 norm.py --year "$YEAR" --variables "Jet_eta" --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_Jet_eta.txt &
# python3 norm.py --year "$YEAR" --variables "Jet_phi" --cuts "$CUTS" --weights "$WEIGHTS" --set_maximum "$MAX" --Channel "$CHANNEL" --log_scale --luminosity "$LUMI" &> log_${YEAR}_signals_with_backgrounds_Jet_phi.txt &

# echo "All jobs launched"
