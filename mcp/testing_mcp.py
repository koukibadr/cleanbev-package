from mcp.cleanbev_mcp.server import verify_flutter_project

# Should pass — point to your real flutter project
print(verify_flutter_project("/Volumes/Data-BK/Projects/Kinetic"))

# Should fail — point to a random folder
#print(find_project_root("/tmp"))