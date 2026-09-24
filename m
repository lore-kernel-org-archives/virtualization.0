Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263645D915
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243817; cv=fail; b=FQHnHq34yXHw7/GPCWmlmcNzkkDhm2bndTX5cgDG4Q5bkMjziVX1PE7O2Xj1F9ErT60TOE7cVrMbVMqvqyWPwTImq/UzB3hEcebjziUsZm5uN5P3owKXSePDok8n/yMHAjTT5KiKiWGgNkWGUOvRMMW3SAl0nUxfJDH5eXUY/SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243817; c=relaxed/simple;
	bh=CzxGF+4M5PF+o9iOOHzARuxAv5VnaHE3YqFjzO4GOq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlCJfpACDPTubnYj8jAQ58gLNZQT3/Pkwz43Qnb1cyl53SkDZy44HnFCEOP9UUS/oRbEwwA39ehhLau4BxFa3mo/B7/1TjMOLafPvIm1g/Bgauwax66E0byvnvdG0K0ATaeO7/AevoIU43Z5h763uKBJq3VmYuincn6dKBwIRYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oUOvP/JG; arc=fail smtp.client-ip=52.101.52.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oUOvP/JG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gH5Uv5oK6Howp8Bo94/vc6Sx/jDPFMGWctk2dk/X5AEe6j83EPDu6V17aHff3k5QpogXZhBv4PSbesAv8a0oQaQK31IwA6XBfDsmW9AD66qP5qOL8WLgXVkcn6z5oe9evw9SO7C1/njCQ88IaeX5vpVAFz1WAJ5LGjBZgc03Kx7lkDPt1+OCOBjP0Sjid7DoB0/FgzQoH+QLL9bokjMZ/qDHc3HAzMcVyVjQ6vfMpwhDxGNOh5v7k6KNB2s/0TDjFfujm4q4vnSmq7y5IVBnt1MVMI/1CwI/iG++bAe+oWs8kQCoOGCA+Z4K2CyP18iTggjXn93Ekjib6EjbUqh3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hqaldN7+P3zq2opasHkEJZag4SvXgRaREPcyfFNwqQ=;
 b=sggbipVumEvf0QgP3hoJ1HpuurgtXhMonPP7V4XRqC9Z/L3EjTF5JxgNasDlVf7q8vdGvRBZpSpp/Zg41mi+PbtBtQ9+8l7v9iJUqkroJAkhtcWqnljfwABwVTKLUNDDPDYhh5pn1M9GelL9xRMGQ5rLWvB51Sqmh5rQFby1lXLwuDBDtoSQSROrBDhDCPB/+Q3x19lrHtJJWwwjISYi7c9VIuwY2gBlXc2LsxKE6r19Ta0olnHPDM5DmRFyJAE5gyfyLmjG6RhSHoBQOCkAqCmg/+VYR/jBiQvFmWTuJvhprffFAOFsEysK5IvHDN6Yt9U8DLV67gt4jZgabp9zHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hqaldN7+P3zq2opasHkEJZag4SvXgRaREPcyfFNwqQ=;
 b=oUOvP/JG4YwkVQn3EU/Q2aRiBpZTVhvudgxVwdJJSpU5qR3CPJ8DDHIfgRJQtb1OqWXS19UftmhI5tYM+gJZ6yqc3nrAZVHJWghxrvMsfsfbzDAVR4YsdI2FmD6h4AQ/vfLmpBUxQsxdc6fT0ly3t0PCaEP5WaD2b4HLDPN+bCs=
Received: from SJ0PR05CA0123.namprd05.prod.outlook.com (2603:10b6:a03:33d::8)
 by DSSPR12MB999235.namprd12.prod.outlook.com (2603:10b6:8:377::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 09:56:35 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::92) by SJ0PR05CA0123.outlook.office365.com
 (2603:10b6:a03:33d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Thu, 24
 Sep 2026 09:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 09:56:34 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 04:56:20 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dmitry.osipenko@collabora.com>, <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	<airlied@redhat.com>, <kraxel@redhat.com>
CC: <gurchetansingh@chromium.org>, <olvaffe@gmail.com>, <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [RFC PATCH v9 4/4] drm/virtio: wire blob ioctl creation to userptr objects
Date: Thu, 24 Sep 2026 17:55:56 +0800
Message-ID: <20260924095556.1326164-5-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924095556.1326164-1-honghuan@amd.com>
References: <20260924095556.1326164-1-honghuan@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|DSSPR12MB999235:EE_
X-MS-Office365-Filtering-Correlation-Id: 4961096c-3d31-4dfb-357f-08df1a221e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	u3vq4KEct+jxcvY9JiCBMsyEbaHG2Fr4HxF5mtnG/mmooYlJcb82SGTY8F5aRlGnp5vMqY32n7roOHfoV0DYbprrFR0nrIKzGTPjl7OG8hNxR0k4qawFWM5vAVF2BSskY3ffCEY6cZ3bm63pKS4AB1vptEyU4Sj4uWpXEiUl3cHkJSmz6+/N3UCXndgnnQJoVYGmC1byIM2P48jf5UHroY8x/wkC2PPoVO0PRmUJ26JEus3TH0HPQ9YS0RfzT1dRujWSKVY3VBnpXFeeFdDVU/G1C70hwlA30+SaPcFULTJWuLteJYEUHyrIDSHCEjIhc1bid1ANByOlq7oM2oueBBfA8qCgvyMpqmN28U3hV1nKhioHuz8ni7Xl4sgbKgpyFNTeuvEKrLPR7I0lxPwkSUcL2ljnFwom/zKaMODHx1i1G5PZGuwE1BpwYLmFax/6E7a9lniGuTKlKc7QrNmeIPup/UP9HFRcazl7d/04zdGHcEYrWHV30NqenlGDr+9so32nDZgUaBS1KNOXn+g9pnJHUxwrqJWWCayEUhUHXa1KNKxMU8gKBImAAXJEKwNPjn5ipc2KyfXx5LeS+NU0xVbbhWibxqX4bXQKgHq39Lmsf+9aaHnjBDKBQBpQmiF+FIpPASfk/wYRYKX5EDIouhUohkKjz2diRmKwwLLnl3o8/BoXQ/KcpZuRnRzxefnjvjcVFBW2NR0imymaDlTDRA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/fEgoKgr0GePnZcPPRq9wHPsLFzuoom/GV+JFHDEFBS6t9hP81J+t2jTXzKvNaxmszqIDPR4y3K/HWvRtlnekiJgaQw6EonD6ZkNACnU39fsmIudpslkfLJFK1xFdkBsrVT6PZzVxFE+pgHJXiIqHg6B/87a63trQ1pYlkz7PUGIV9+NnfLAyDK3MBFzLv6PWyVQFBjsBC8uANY7C3GrKv5UXIIwvyrdF0PAQHngJ5B2tSahOah/Shtzcp0Ii0s6agoKqmvevz6aTooUJjTGYyQ+H6JD6TFWhBczBMI40EVVvz7nTXEqt9N0YX+qhkeekCe7ZQjRQKvbJ+sah2ITlkBfq9Bok9pISLd/lkPmZ5EoRoeiyBctwMKxnG7umFwpJ2HS4NszpmoNsiD7nYOQ6woGXFyZpyY+V5kxU0s29NGAQyhec1IN4NsZA/KXGP/d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 09:56:34.6422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4961096c-3d31-4dfb-357f-08df1a221e2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999235

Integrate userptr into the blob resource creation ioctl.

- A non-zero userptr selects virtio_gpu_userptr_create()
- Reject userptr unless blob_mem is VIRTGPU_BLOB_MEM_GUEST
- Reject VIRTGPU_BLOB_FLAG_USE_READONLY unless the device
  advertised VIRTIO_GPU_F_BLOB_READONLY
- Advertise VIRTGPU_PARAM_USERPTR and VIRTGPU_PARAM_BLOB_READONLY
- Add VIRTIO_GPU_F_BLOB_READONLY to the driver's features[] array

virtio_has_feature() routes device-specific feature bits through
virtio_check_driver_offered_feature(), which calls BUG() when the
driver queries a bit it never declared in features[]. The
VIRTIO_GPU_F_BLOB_READONLY probe added to virtio_gpu_init() hit
exactly that: every probe crashed regardless of host support because
the bit was missing from features[]. Registering it there fixes the
crash.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/virtio/virtgpu_debugfs.c |  1 +
 drivers/gpu/drm/virtio/virtgpu_drv.c     |  1 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   | 35 ++++++++++++++++++++----
 drivers/gpu/drm/virtio/virtgpu_kms.c     |  8 ++++--
 4 files changed, 38 insertions(+), 7 deletions(-)

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

