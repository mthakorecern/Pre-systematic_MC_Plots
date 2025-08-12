# PVs
python3 norm.py --year 2024 --variables "PV_npvs"        --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_PV_npvs.txt &
python3 norm.py --year 2024 --variables "PV_npvsGood"    --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_PV_npvsGood.txt &

# Leading FatJet
python3 norm.py --year 2024 --variables "FatJet_pt[0]"   --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_FatJet_pt_leading.txt &
python3 norm.py --year 2024 --variables "FatJet_eta[0]"  --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_FatJet_eta_leading.txt &
python3 norm.py --year 2024 --variables "FatJet_phi[0]"  --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_FatJet_phi_leading.txt &
python3 norm.py --year 2024 --variables "FatJet_mass[0]" --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_FatJet_mass_leading.txt &
python3 norm.py --year 2024 --variables "FatJet_msoftdrop[0]" --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_FatJet_msoftdrop_leading.txt &
python3 norm.py --year 2024 --variables "FatJet_particleNetLegacy_mass[0]" --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_FatJet_particleNetLegacy_mass_leading.txt &

# Electrons
python3 norm.py --year 2024 --variables "nElectron"      --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_nElectron.txt &
python3 norm.py --year 2024 --variables "Electron_pt" --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_Electron_pt_leading.txt &
python3 norm.py --year 2024 --variables "Electron_eta" --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_Electron_eta_leading.txt &
python3 norm.py --year 2024 --variables "Electron_phi" --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_Electron_phi_leading.txt &

# Muons
python3 norm.py --year 2024 --variables "nMuon"          --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_nMuon.txt &
python3 norm.py --year 2024 --variables "Muon_pt"     --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_Muon_pt_leading.txt &
python3 norm.py --year 2024 --variables "Muon_eta"    --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_Muon_eta_leading.txt &
python3 norm.py --year 2024 --variables "Muon_phi"    --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_Muon_phi_leading.txt &

# Taus
python3 norm.py --year 2024 --variables "nTau"           --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_nTau.txt &
python3 norm.py --year 2024 --variables "Tau_pt"      --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_Tau_pt_leading.txt &

# Boosted Taus
python3 norm.py --year 2024 --variables "nboostedTau"    --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_nboostedTau.txt &
python3 norm.py --year 2024 --variables "boostedTau_pt"  --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_boostedTau_pt.txt &

# PuppiMET
python3 norm.py --year 2024 --variables "PuppiMET_pt"    --cuts "1" --weights "genWeight" --Channel all --luminosity 109.08 --signals_only &> log_2024_signals_PuppiMET_pt.txt &
python3 norm.py --year 2024 --variables "PuppiMET_phi"   --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_PuppiMET_phi.txt &

# Leading AK4 Jet
python3 norm.py --year 2024 --variables "nJet"           --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_nJet.txt &
python3 norm.py --year 2024 --variables "Jet_pt[0]"      --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_Jet_pt_leading.txt &
python3 norm.py --year 2024 --variables "Jet_eta[0]"     --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_Jet_eta_leading.txt &
python3 norm.py --year 2024 --variables "Jet_phi[0]"     --cuts "1" --weights "genWeight" --Channel all --log_scale --luminosity 109.08 --signals_only &> log_2024_signals_Jet_phi_leading.txt &
