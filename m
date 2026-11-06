Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793953623;
	b=auH2fFPnS0yPuxz7HySNNFexVWf5tuTUw/YyV1sPSpYVjYYHjfJg08URKB8kIwqy2Rhe
	 AXdkQY4mPD5tGcJTCc3JbaYwR2aAaOzhDdbhtVSRFZaGG+mQXOdla7cIXjPzGY3FXGfty
	 iFA238noSQS68s1KDkMlPC06NStOr25Ia8QwL4xu1h8lc5qMoobCC51veu38zUqhy9OR6
	 sdA/rCUHfJU829cr900Ppa5dTpkZzxrDJxutMZ/36IZ59PziE0xi535JnwdmhXxyy0hsA
	 SKb66HVqTSI3wp2qMpKOLv05JUEHTlC8zNy0W70+Jd2KofT0rHpCth8R/53PTcFPEBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953623;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=WTplfK3CeLU4amsy6yd4ZzKwUbptVYSg85LuEM2OtXE=;
	b=aAyOaSEZDpVqUmhAdsFDDSGNJWOtK1QOlpUGdUvQpyouvOX6qSBtBvNlCxOCJtn273zL
	 YdrfN2EVT9Y+gdQX0POgZn03YI/MMKFBMINplMceqyJTZnPcRfIrUeEC2HQ4Q+hv2TR+m
	 3gEauwvJD0h+jCUOeGGBjPX9COJxWFZZtczkiYImxi2FDSvzdnEpwMJEyFlnag627Jt1E
	 bfi055PxgBOYldf8AZiqJ5cu355dlocstn4hNP7Nwp4gMav2rFtk1gWnTH2LENIviqxUX
	 WucA6m+O7agTktacF14E38SLwevOUkaG++AaLuiKhw9AOEoFPHKSf+IVDNgIJcH/3Mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="5B0ReqA/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.13
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5175C606A332
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5175C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5B0ReqA/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUi17mWIGufAv693Z2b1q/2ub1onkKB+OkCZgOve6XLLxFUytoZgYSED9nZ2SW1bwiN4ZOQ8lqt+e6/Qn2So7lJ6WNW1sh3lZk2cqvT1b+7Gw6iK+YDS6stopovDcywHUShVtecDsrQnQHhaijyrsUBiSqsu0LKC4GA6agkG2eayPE7dFbS3Jd4+lX3a0Oqn2gHZ1QjQMtzAxKOZxYOnFpVfNC7S2AeCNvOcOGWv4WuS1QPEWfJF6QCrM57/k5FJRepCVc7ukiJWXyvNjVwrufGXzn03mmv90FowRqzSCrmbRILJuOhFedIjDEupW843FEDnh9sZWt//UW77gB1Ckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTplfK3CeLU4amsy6yd4ZzKwUbptVYSg85LuEM2OtXE=;
 b=dnbr1JgGz4ajLq8hDQEjXkEJB4gpEDaLy4/VCODaOyo4orALis3pJmRjA5vMFpuyY4I39b/VSNk2/m9hdy9gYsErNo6NiSJ2yFVkwARTkhRyn/X0zOcRo3tgr06SvM0YlfK/dCOCnN/uW2DW8QUfR0LuWR1PV49tYB/fxIlYDTxoUKkQqxtXHI+KebwpJpMAd+LMdXP7aeZaTOxNKXkLsLWncuiKAGvE6gryJQ1K8zSJBIFQmCW9GOq94qOoHnyu68aZQls6vrcqC3YVqdJwzLGiS+6XwZVSDW1yDPcxSbJDXhPqWGZXa1jdycJ/aosRbMKpn6XsdPuu0MtXzZGeSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTplfK3CeLU4amsy6yd4ZzKwUbptVYSg85LuEM2OtXE=;
 b=5B0ReqA/6QWXDzIaCGQjC0qMEcDoRUobhfK4EykL3TSZGbliUqpA4RjRdTnKKb4Jea8uWEBBcZvE3WhupWR/hyMRDIYSPHll8xmH5CokjjnXtIzOCXJ0weMFgDbyHjrEyvtf2nAJ4hHvAmPQF89VHL/ayTYKRetAsI+HFW18mfg=
Received: from MW4PR04CA0321.namprd04.prod.outlook.com (2603:10b6:303:82::26)
 by DM4PR12MB6422.namprd12.prod.outlook.com (2603:10b6:8:b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 08:26:57 +0000
Received: from CO1PEPF0001885D.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::45) by MW4PR04CA0321.outlook.office365.com
 (2603:10b6:303:82::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 08:26:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001885D.mail.protection.outlook.com (10.167.249.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 08:26:55 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 02:26:50 -0600
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
	<odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [RFC PATCH v10 4/4] drm/virtio: wire blob ioctl creation to userptr objects
Date: Fri, 6 Nov 2026 16:26:25 +0800
Message-ID: <20261106082625.812860-5-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106082625.812860-1-honghuan@amd.com>
References: <20261106082625.812860-1-honghuan@amd.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885D:EE_|DM4PR12MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8da829-1094-4b26-dfbe-08df3bdfb7ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|10067099003|11063799006|261102123227099003|261026121527099003|261021123027099003|261021121427099003|56012099006|261009223027099003|261009221727099003|261009221227099003|261009223327099003|261009220027099003;
X-Microsoft-Antispam-Message-Info:
	VCzAoSYcl+3nFN/pvTJ079voS1+sIbMqaRMkJrjzeoFoVd/KGt/gUl3EIOnUbZs7uWICNzoag3p/lItjlvdeUd2/VTgo+vGE1AqgaPGIe0D19KTj5M7zJPWsMQsdoXJFoOfNiXnSn70hpqnHOknK1PCiXZeupqGA2oDZGCHg6BdmEdVxRmzDt3YptGQ2nOuDbW0rlreOEscqM24xIrXUBYunhFzzYMzUxNjVAWxBW0ScHn9YuUeZ8NgodeZduceLRfJ39fsgdezIgNaqc9uXSLWMCEDQ1qChYiyk4XMt311/dP+Z4oPFIq+1mymz4FvOSTBgc0jnzcUNEwSjQnAB7Wws+jk4VALjBD74/RyWaQzHCWeu+Xc6h9lGxmfa5C4k7b7zB1ieWJy5jc9vCxiPzrYk2EGUJi1wXAXOqa7oYxNaCGYFW6ZzXmT8mm89SvZ1qnqFdlw/cwiaFBn9kiD6ZnMjUpIZeTuoofwa//Qpyvnn0HffhlRHLAaEKtfbj/3epgCDmgpkG73ljSvO/kepvqBruOW4ygwi4TW0baB/SwSBYiw9Zo32R/M4Owt65j61Y18aB3TvtpBK3qu21CaAsvWrJ2gEOQeUzg9vGLv+QH7V9bTyDNrCdVjz9o3Uc+B5CSpqH2Yf9gKZ43v9NO7vdMKdM+o391cTAp4Sn3RlDFY1CiVpOIMPVRdpIYqmuPv5BAxStBabFioI223kzGdelg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(261102123227099003)(261026121527099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(261009221727099003)(261009221227099003)(261009223327099003)(261009220027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kU94/cpjdrYQ1FRH5Ljdo8SiuljH2nvFZOUHUBiVfBMtyPUS6gWuhSprHROr13vOceg/vJhZFbdV/EyeF7eKgB1KrftPzz8vaKsREix9oNbzWk8HzS9gYgvBTQ/OGsPjY4dry/hhetZL1HzcWpOhZcy4wGnATfagWvn1H2UBDYdby6Ktk31Qv8Iak9Eq744zUe6ZvtzoHRusTmTKsh3wQnv8r5rcPB6qOAojurfeXSCk09lLrrfJJl9wfvIfmAPXHWkYIDmImcd7/jjLyx2/EzRqK/17gtY9OePoSTgfPRUn4OBZZseJSFj2SbfsCPvwh5OBvKQLv+IomRXTeTHM1EqmmThQ4d5VAXXI5bWx5iFeqCoTXGgOCQIOM/dFI+FtBZ4KdXR4pIo/ZCGyJNtBFH1nuJ2rdKMRBpABqleYvAOtRy2gtYnCZ0pWmxireV+B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:26:55.3736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8da829-1094-4b26-dfbe-08df3bdfb7ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF0001885D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6422

Integrate userptr into the blob resource creation ioctl.

- A non-zero userptr selects virtio_gpu_userptr_create()
- Reject userptr unless blob_mem is VIRTGPU_BLOB_MEM_GUEST
- Reject VIRTGPU_BLOB_FLAG_USE_READONLY unless the device
  advertised VIRTIO_GPU_F_BLOB_READONLY
- Advertise VIRTGPU_PARAM_USERPTR and VIRTGPU_PARAM_BLOB_READONLY
- Add VIRTIO_GPU_F_BLOB_READONLY to the driver's features[] array

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/virtio/virtgpu_debugfs.c |  1 +
 drivers/gpu/drm/virtio/virtgpu_drv.c     |  1 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   | 49 +++++++++++++++++++-----
 drivers/gpu/drm/virtio/virtgpu_kms.c     |  8 +++-
 4 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_debugfs.c b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
index 3a68a16b58..b8b9b40584 100644
--- a/drivers/gpu/drm/virtio/virtgpu_debugfs.c
+++ b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
@@ -55,6 +55,7 @@ static int virtio_gpu_features(struct seq_file *m, void *data)
 			    vgdev->has_resource_assign_uuid);
 
 	virtio_gpu_add_bool(m, "blob resources", vgdev->has_resource_blob);
+	virtio_gpu_add_bool(m, "blob readonly", vgdev->has_blob_readonly);
 	virtio_gpu_add_bool(m, "context init", vgdev->has_context_init);
 	virtio_gpu_add_int(m, "cap sets", vgdev->num_capsets);
 	virtio_gpu_add_int(m, "scanouts", vgdev->num_scanouts);
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 2aaa7cb080..f1edd20c37 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -182,6 +182,7 @@ static unsigned int features[] = {
 	VIRTIO_GPU_F_RESOURCE_BLOB,
 	VIRTIO_GPU_F_CONTEXT_INIT,
 	VIRTIO_GPU_F_BLOB_ALIGNMENT,
+	VIRTIO_GPU_F_BLOB_READONLY,
 };
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 3d8e4ccdb7..e57750588d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -36,7 +36,10 @@
 
 #define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
 				    VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
-				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
+				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE | \
+				    VIRTGPU_BLOB_FLAG_USE_READONLY)
+
+#define VIRTGPU_BLOB_HINT_MASK DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING
 
 /* Must be called with &virtio_gpu_fpriv.struct_mutex held. */
 static void virtio_gpu_create_context_locked(struct virtio_gpu_device *vgdev,
@@ -122,6 +125,12 @@ static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
 			return -ENOENT;
 		value = vgdev->blob_alignment;
 		break;
+	case VIRTGPU_PARAM_USERPTR:
+		value = 1;
+		break;
+	case VIRTGPU_PARAM_BLOB_READONLY:
+		value = vgdev->has_blob_readonly ? 1 : 0;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -453,11 +462,23 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	if (rc_blob->blob_flags & ~VIRTGPU_BLOB_FLAG_USE_MASK)
 		return -EINVAL;
 
+	if (rc_blob->blob_hints & ~VIRTGPU_BLOB_HINT_MASK)
+		return -EINVAL;
+
 	if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
 		if (!vgdev->has_resource_assign_uuid)
 			return -EINVAL;
 	}
 
+	if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_READONLY) {
+		if (!vgdev->has_blob_readonly)
+			return -EINVAL;
+	}
+
+	if (rc_blob->userptr &&
+	    rc_blob->blob_mem != VIRTGPU_BLOB_MEM_GUEST)
+		return -EINVAL;
+
 	switch (rc_blob->blob_mem) {
 	case VIRTGPU_BLOB_MEM_GUEST:
 		*guest_blob = true;
@@ -495,10 +516,15 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	params->blob = true;
 	params->blob_flags = rc_blob->blob_flags;
 	params->blob_hints = rc_blob->blob_hints;
+	params->userptr = rc_blob->userptr;
 
-	if (vgdev->has_blob_alignment &&
-	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
-		return -EINVAL;
+	if (vgdev->has_blob_alignment) {
+		if (!IS_ALIGNED(params->size, vgdev->blob_alignment))
+			return -EINVAL;
+
+		if (!IS_ALIGNED(params->userptr, vgdev->blob_alignment))
+			return -EINVAL;
+	}
 
 	return 0;
 }
@@ -518,9 +544,10 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
 	struct drm_virtgpu_resource_create_blob *rc_blob = data;
 
-	if (verify_blob(vgdev, vfpriv, &params, rc_blob,
-			&guest_blob, &host3d_blob))
-		return -EINVAL;
+	ret = verify_blob(vgdev, vfpriv, &params, rc_blob,
+			  &guest_blob, &host3d_blob);
+	if (ret)
+		return ret;
 
 	if (vgdev->has_virgl_3d)
 		virtio_gpu_create_context(dev, file);
@@ -538,7 +565,9 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
 				      vfpriv->ctx_id, NULL, NULL);
 	}
 
-	if (guest_blob)
+	if (guest_blob && params.userptr)
+		ret = virtio_gpu_userptr_create(vgdev, file, &params, &bo);
+	else if (guest_blob)
 		ret = virtio_gpu_object_create(vgdev, &params, &bo, NULL);
 	else if (!guest_blob && host3d_blob)
 		ret = virtio_gpu_vram_create(vgdev, &params, &bo);
@@ -557,14 +586,14 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
 	if (params.blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
 		ret = virtio_gpu_resource_assign_uuid(vgdev, bo);
 		if (ret) {
-			drm_gem_object_release(obj);
+			drm_gem_object_put(obj);
 			return ret;
 		}
 	}
 
 	ret = drm_gem_handle_create(file, obj, &handle);
 	if (ret) {
-		drm_gem_object_release(obj);
+		drm_gem_object_put(obj);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 1d4d3bf46a..06c2bded49 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -249,15 +249,19 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 		vgdev->blob_alignment = blob_alignment;
 	}
 
+	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_BLOB_READONLY))
+		vgdev->has_blob_readonly = true;
+
 	DRM_INFO("features: %cvirgl %cedid %cresource_blob %chost_visible",
 		 vgdev->has_virgl_3d    ? '+' : '-',
 		 vgdev->has_edid        ? '+' : '-',
 		 vgdev->has_resource_blob ? '+' : '-',
 		 vgdev->has_host_visible ? '+' : '-');
 
-	DRM_INFO("features: %ccontext_init %cblob_alignment\n",
+	DRM_INFO("features: %ccontext_init %cblob_alignment %cblob_readonly\n",
 		 vgdev->has_context_init ? '+' : '-',
-		 vgdev->has_blob_alignment ? '+' : '-');
+		 vgdev->has_blob_alignment ? '+' : '-',
+		 vgdev->has_blob_readonly ? '+' : '-');
 
 	ret = virtio_gpu_find_vqs(vgdev);
 	if (ret) {
-- 
2.34.1

