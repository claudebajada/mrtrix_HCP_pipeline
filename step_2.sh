# average RF generation

mkdir GroupMRtrix3

average_response ./*/MRtrix3/RF_WM.txt ./GroupMRtrix3/group_average_response_wm.txt
average_response ./*/response_gm.txt ./GroupMRtrix3/group_average_response_gm.txt
average_response ./*/response_csf.txt ./GroupMRtrix3/group_average_response_csf.txt

