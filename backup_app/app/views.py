from django.shortcuts import render

# Create your views here.

from django.http import JsonResponse
import subprocess

def trigger_backup(request):
    try:
        # Run kubectl apply -f job.yaml
        subprocess.run(["kubectl", "apply", "-f", "manifests/backup_job.yaml"])
        return JsonResponse({"message": "Manual backup triggered successfully"})
    except Exception as e:
        return JsonResponse({"error": str(e)})
