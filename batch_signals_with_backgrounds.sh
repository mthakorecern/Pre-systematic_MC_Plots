# PVs
python3 norm.py --year 2024 --variables "PV_npvs"        --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_PV_npvs.txt &
python3 norm.py --year 2024 --variables "PV_npvsGood"    --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_PV_npvsGood.txt &

# Leading FatJet
python3 norm.py --year 2024 --variables "FatJet_pt[0]"   --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_FatJet_pt_leading.txt &
python3 norm.py --year 2024 --variables "FatJet_eta[0]"  --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_FatJet_eta_leading.txt &
python3 norm.py --year 2024 --variables "FatJet_phi[0]"  --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_FatJet_phi_leading.txt &
python3 norm.py --year 2024 --variables "FatJet_mass[0]" --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_FatJet_mass_leading.txt &
python3 norm.py --year 2024 --variables "FatJet_msoftdrop[0]" --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_FatJet_msoftdrop_leading.txt &
python3 norm.py --year 2024 --variables "FatJet_particleNetLegacy_mass[0]" --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_FatJet_particleNetLegacy_mass_leading.txt &

# Electrons
python3 norm.py --year 2024 --variables "nElectron"      --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_nElectron.txt &
python3 norm.py --year 2024 --variables "Electron_pt" --cuts "1" --weights "genWeight" --set_maximum 1e9 --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_Electron_pt_leading.txt &
python3 norm.py --year 2024 --variables "Electron_eta" --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_Electron_eta_leading.txt &
python3 norm.py --year 2024 --variables "Electron_phi" --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_Electron_phi_leading.txt &
python3 norm.py --year 2024 --variables "nFatJet" --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_Electron_phi_leading.txt &

# Muons
python3 norm.py --year 2024 --variables "nMuon"          --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_nMuon.txt &
python3 norm.py --year 2024 --variables "Muon_pt"     --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_Muon_pt_leading.txt &
python3 norm.py --year 2024 --variables "Muon_eta"    --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_Muon_eta_leading.txt &
python3 norm.py --year 2024 --variables "Muon_phi"    --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_Muon_phi_leading.txt &

# Taus
python3 norm.py --year 2024 --variables "nTau"           --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_nTau.txt &
python3 norm.py --year 2024 --variables "Tau_pt"      --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_Tau_pt_leading.txt &

# Boosted Taus
python3 norm.py --year 2024 --variables "nboostedTau"    --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_nboostedTau.txt &
python3 norm.py --year 2024 --variables "boostedTau_pt"  --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_boostedTau_pt.txt &

# PuppiMET
python3 norm.py --year 2024 --variables "PuppiMET_pt"    --cuts "1" --weights "genWeight" --Channel all --luminosity 109.08  &> log_2024_signal_with_background_PuppiMET_pt.txt &
python3 norm.py --year 2024 --variables "PuppiMET_phi"   --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_PuppiMET_phi.txt &

# Leading AK4 Jet
python3 norm.py --year 2024 --variables "nJet"           --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_nJet.txt &
python3 norm.py --year 2024 --variables "Jet_pt[0]"      --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_Jet_pt_leading.txt &
python3 norm.py --year 2024 --variables "Jet_eta[0]"     --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_Jet_eta_leading.txt &
python3 norm.py --year 2024 --variables "Jet_phi[0]"     --cuts "1" --weights "genWeight" --set_maximum 1e9 --Channel all --log_scale --luminosity 109.08  &> log_2024_signal_with_background_Jet_phi_leading.txt &
