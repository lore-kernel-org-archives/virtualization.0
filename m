Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D16F438FE6
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725622; cv=fail; b=MFfgqFiDTKyBcjatZtAcjvxIZ6gro7NY8aV2pMm1wElgph98eWw23L1gmd8NZEC+AJnF67YLiCV75nfEoAY3pEp69oNOvQ/He/OhR4dIQwkHX5KPASbfnK/uvI8snHp1sIFf5p5FQ7MLM/E2kKxkeRkY4XfFywWK31Ywy6p2E6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725622; c=relaxed/simple;
	bh=mFVCiM5xeBJCksOk+LA8iN+Z+yh+iQtif75mc3oYgLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnuyS5iPF/r44X4EhUSzYv8ex15aSxQ6Lcc48vnuPXzSKSCRMskWOwRa4SptPkmrFlx50XfNHJW8vhqOnMHj+WBs2Vlbb84Bo0fduv8QIZMbU5PbpKXd7jw1ZCgC8H0hgwR0zcQyjOH8ht45w8QFoKZ1fk/DrEX1xUQtJBqW1Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uHWPfefR; arc=fail smtp.client-ip=52.101.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uHWPfefR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwqaxfiNsEBsT3J7cDesVnH8LBW1MeaXC7SpPBOUipweRjCdwaDQjtxUelL+Z+M20qKs0BHQQrOCRBbAn+3ri40eIXoSIWh3LwRJ20XMgaI/TjuEQh4oSuJKmnZ5xLaO7LgMHxwz6j7A8kMU800u+muLEGAXhBLBplOK/CGzX8LAOumQTB7MEUsW1nuRrEhUpd9Ld4jF36IGg/VIdPVPdkW2pzDUW3ZeKfKHo977GXqWWauEy9mf+S1KWLGDonzrGIYsJviEQqzidBUUqB/YhMv4vy0e0DoYqz9fp1pJPU7TxoZUz78lxNQkqxM6H9Yl5xkAIW2AIfBlcYrplQt9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xh7t9lCZvEKIt8fCKxkY0noneQl/NapxT7EK65Iw9pM=;
 b=RjRSe7UOQhCr5RBReuxcHnoc5jQzFIoGeqLIMOnU9+UJ5tgtxvn3pkXsqQ6cxArFWO8/XJ9SzfNvxBC/lyHYn/e0LyuQZxNFUGAMKCYsA4TEd2MuXLYx3xOsg2sN9Da+okV35ZHWTua+ZAtoc5UFJvRxiq2LvfYvGMSCjIvKcIrb9U+OqZ/b7ogfQiFWtuqaW6LWRLcak2FOz8hCyA5oNUvqrLZN277uBxRcyO68U7YyMFUeifmYeMclAgaZ+0rxVFLRgEYOi7lyPM3NbG2fjoeO1+F269b7lXgEULE5qb8Uayy3uuRTgWOP4lNytN3in85eluAZGvH8Q50VEoKCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xh7t9lCZvEKIt8fCKxkY0noneQl/NapxT7EK65Iw9pM=;
 b=uHWPfefR0RVB0h6moNfwb8I3ab++pHb1f5XKK5F0FZ8WjeNsU2CcLh9r5Gd6wFgEKzi3iwdo7FehhP2OkGVx/MVsehRgI7JqzxqZGl1aOr9snz7e5zIsvJpV0Q3EhHRbAlsMSwdgJhKRNdUbqzIH138S5fKastuCr2apB7GYw6c=
Received: from SJ0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:a03:331::31)
 by BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 10:00:10 +0000
Received: from SJ1PEPF000037A7.namprd04.prod.outlook.com
 (2603:10b6:a03:331:cafe::64) by SJ0PR03CA0086.outlook.office365.com
 (2603:10b6:a03:331::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Fri,
 18 Sep 2026 10:00:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A7.mail.protection.outlook.com (10.167.244.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 10:00:09 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 05:00:02 -0500
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
	<odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 4/4] drm/virtio: wire blob ioctl creation to userptr objects
Date: Fri, 18 Sep 2026 17:59:40 +0800
Message-ID: <20260918095940.2253018-5-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918095940.2253018-1-honghuan@amd.com>
References: <20260918095940.2253018-1-honghuan@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A7:EE_|BL1PR12MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 0238a22f-1201-4cf7-b0f0-08df156b9fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UIVRXaLKGOd25cFP7JThWNq/rfgJAwdSf2UGIMULSDdi2OymYmW7uepeUGRDWFL+sTypxQbxZOsbVQCy/N6xY32I1SKngU/8zdCE1WIvum23sgkViHrFjEwHq7dmOeD9XFmMavnvJhKTFml20Y2lOYVSVAmqLmTD4XbNnjgEOWAybn6q0+ydGnd+rDWxm8nh95QBSYfJG2DeO4Hc1Nr6aer4NLHDxCpTMH7aCd8EZfLyKXTAfMGRFm85lKrmrO4NaIB/00MbasacN+ia0Sr99g+tBXY1ud+qJkemCGb/Ua+1uRKqiITiuYTcoINxM9Pa7ls9wP8T2Y7LMdutG/RUk2kZQVHpJd+gA8MFIYGNX1fdjEU6tJZOD8xWsFTKK8B2ITZ7gio42yPLI8Vm1Hxd7/qPmoFBnBy0aQ6NsT+TJG7eN+e5BSqEoQOuDtRlkPFsUWp2kKhlTC3pl3BB9JNlRog0sPAmPTftkZNNn0ZITXsI5y1fi0NmP2hgyp5FIUu//Xg+MoQgqZn266k8lJleHaaOVTPWZe2X5c3sE7SNHCo2N3Mxww9pIHT74N5/S4OaxXIt7jI1XE0FG9vi5/01/lO96/uB2TI7mD1E2u5daOhCqWpyyCs1RTjQhCXyyyH+J5iPXkHo4T4teTJ1FQXYoU7ZmEqPdaTzRKYP+BNuV1AMggDUmx/0KaqioxnXo0dVyVazIraKddinpt399+DNOA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+OOnFywmHuJcuC6N7kAPZNmbLTtduEqgijDC+O4rrTJRCM/1TH7MhnNtTzB2SIcI/NbHGPcLQ7s7lHtpzQS3F4PP79kFCGi/5Sy1dmgkNmESOn+gaZ9eW+qGbsmjnYlhdtayyyFSKNRz6m7l60pwXbEOcNdxD9xjFofuvHecGb+kMohyQyq17683Rc9Itd7Ks9588ujdQhTxWJA+QuyQs8LLvcfXqMlu7GY/808bkS9fHxKTGfgcGXFTf0TuJMgDU4tfAcWwzDglqtEbnwr9OY6iBJ9/1hKtv9rVRW1M3HTv5Ba15V4a4Mpx0PI0aDtbK9eGeJJXrPg3rrxtwJPAmv35Q3GgfsmzB6bXYGigfUuVC13NXyCLDaFWk34gY1ZPokIVz7rtIxuaUa5l/1jfAlGEBMfyKxh/CUYnNZ3gh+JNFyMePAUI7OiOb8FjHKih
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 10:00:09.5713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0238a22f-1201-4cf7-b0f0-08df156b9fe7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5873

Integrate userptr into the blob resource creation ioctl.

- A non-zero userptr selects virtio_gpu_userptr_create()
- Reject userptr unless blob_mem is VIRTGPU_BLOB_MEM_GUEST
- Reject VIRTGPU_BLOB_FLAG_USE_READONLY unless the device
  advertised VIRTIO_GPU_F_BLOB_READONLY
- Advertise VIRTGPU_PARAM_USERPTR and VIRTGPU_PARAM_BLOB_READONLY

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/virtio/virtgpu_debugfs.c |  1 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   | 35 ++++++++++++++++++++----
 drivers/gpu/drm/virtio/virtgpu_kms.c     |  8 ++++--
 3 files changed, 37 insertions(+), 7 deletions(-)

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
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 3d8e4ccdb7..3dc058e50e 100644
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
@@ -495,6 +516,7 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	params->blob = true;
 	params->blob_flags = rc_blob->blob_flags;
 	params->blob_hints = rc_blob->blob_hints;
+	params->userptr = rc_blob->userptr;
 
 	if (vgdev->has_blob_alignment &&
 	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
@@ -518,9 +540,10 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
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
@@ -538,7 +561,9 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
 				      vfpriv->ctx_id, NULL, NULL);
 	}
 
-	if (guest_blob)
+	if (guest_blob && params.userptr)
+		ret = virtio_gpu_userptr_create(vgdev, file, &params, &bo);
+	else if (guest_blob)
 		ret = virtio_gpu_object_create(vgdev, &params, &bo, NULL);
 	else if (!guest_blob && host3d_blob)
 		ret = virtio_gpu_vram_create(vgdev, &params, &bo);
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

