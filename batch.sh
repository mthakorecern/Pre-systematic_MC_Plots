python3 norm.py \
  --year 2024 \
  --variables 'PV_npvsGood' \
  --cuts 'PuppiMET_pt > 0 ' \
  --additional_cuts 'PV_npvsGood > 0' \
  --weights '1' \
  --Channel all \
  --log_scale \
  --luminosity 109.08 \
  &> log_2024_all_PV_npvsGood.txt &

python3 norm.py \
  --year 2024 \
  --variables 'FatJet_pt' \
  --cuts 'PuppiMET_pt > 0 ' \
  --additional_cuts 'PV_npvsGood > 0' \
  --weights '1' \
  --Channel all \
  --log_scale \
  --luminosity 109.08 \
  &> log_2024_all_FatJet_pt.txt &

python3 norm.py \
  --year 2024 \
  --variables 'nFatJet' \
  --cuts 'PuppiMET_pt > 0 ' \
  --additional_cuts 'PV_npvsGood > 0' \
  --weights '1' \
  --Channel all \
  --log_scale \
  --luminosity 109.08 \
  &> log_2024_all_nFatJet.txt &

python3 norm.py \
  --year 2024 \
  --variables 'nJet' \
  --cuts 'PuppiMET_pt > 0 ' \
  --additional_cuts 'PV_npvsGood > 0' \
  --weights '1' \
  --Channel all \
  --log_scale \
  --luminosity 109.08 \
  &> log_2024_all_nJet.txt &

python3 norm.py \
  --year 2024 \
  --variables 'nTau' \
  --cuts 'PuppiMET_pt > 0 ' \
  --additional_cuts 'PV_npvsGood > 0' \
  --weights '1' \
  --Channel all \
  --log_scale \
  --luminosity 109.08 \
  &> log_2024_all_nTau.txt &

python3 norm.py \
  --year 2024 \
  --variables 'nboostedTau' \
  --cuts 'PuppiMET_pt > 0 ' \
  --additional_cuts 'PV_npvsGood > 0' \
  --weights '1' \
  --Channel all \
  --log_scale \
  --luminosity 109.08 \
  &> log_2024_all_nboostedTau.txt &

python3 norm.py \
  --year 2024 \
  --variables 'nElectron' \
  --cuts 'PuppiMET_pt > 0 ' \
  --additional_cuts 'PV_npvsGood > 0' \
  --weights '1' \
  --Channel all \
  --log_scale \
  --luminosity 109.08 \
  &> log_2024_all_nElectron.txt &

python3 norm.py \
  --year 2024 \
  --variables 'Jet_pt' \
  --cuts 'PuppiMET_pt > 0 ' \
  --additional_cuts 'PV_npvsGood > 0' \
  --weights '1' \
  --Channel all \
  --log_scale \
  --luminosity 109.08 \
  &> log_2024_all_Jet_pt.txt &

python3 norm.py \
  --year 2024 \
  --variables 'PuppiMET_pt' \
  --cuts 'PuppiMET_pt > 0 ' \
  --additional_cuts 'PV_npvsGood > 0' \
  --weights '1' \
  --Channel all \
  --log_scale \
  --luminosity 109.08 \
  &> log_2024_all_PuppiMET_pt.txt &

python3 norm.py \
  --year 2024 \
  --variables 'PuppiMET_phi' \
  --cuts 'PuppiMET_pt > 0 ' \
  --additional_cuts 'PV_npvsGood > 0' \
  --weights '1' \
  --Channel all \
  --log_scale \
  --luminosity 109.08 \
  &> log_2024_all_PuppiMET_phi.txt &

python3 norm.py \
  --year 2024 \
  --variables 'nMuon' \
  --cuts 'PuppiMET_pt > 0 ' \
  --additional_cuts 'PV_npvsGood > 0' \
  --weights '1' \
  --Channel all \
  --log_scale \
  --luminosity 109.08 \
  &> log_2024_all_nMuon.txt &