Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E24D3BBFAD
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 02:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697553; cv=fail; b=XS4aQ+rAkrj5qrpkOypvUgqxB81NMTC0ur2a+C6itYYh5hxRyIxgjMeARcjyNmhtqAU8SghAMmuQS8cbiNNDYPx4tnxxMG+HgEtdNioXjH1PaMcCEcrpXAZznl2GK2lAyGsG5Gys62VVUoN4UNd/ovrH9Squ0veQXmi5k5BFmTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697553; c=relaxed/simple;
	bh=j4eyziNsmm6F18gPfighsCUKQWzsOnPQuVa60y/l7ew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbM7yZUbFws/Dbu2kwuguR85GH5EzLwee9IrD706S7SorO5NVhrgrh2uPTl9BSdAg6uvE8W5Q72jmIrr+oeMrAmIPMhyZRhs0lpoWhEWCpQPAgRkLPBdeuwtrUkai+vA0glhmccJRSej/bhuyDCxLAVr4lGri0JFpb5/0nPDdDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PmDKg+D+; arc=fail smtp.client-ip=52.101.52.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PmDKg+D+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7bBAo/r8dYmpfBqblHN2Hk2ay7waMAHb5sB2GQoIOQH6PnpVqoyOTMBb9Hkf2bHp/Ens5bozTod9rOMkI4Zo6xxm54qXLBUbocJUrnPJRwNDf5VyNoDzflE8t/gc2ShW8toUZ3grra2Z7Ib2o5K6/BRfyfdl0Dkzcow8wn0RRs/tqGzpCSDxJBnVImrWSWoy0db//kpmkimp/W+bYlSZvJMFVv6dfmo2VnVUIGiChVZUKm/5bzbaTAYoyLvkXcaf/B/7oKGpPh6JlzHGsekQmwgZSpfGW19mkOgE2MmN4o3WcVsnrBkelJ/3ivNDOIqtR3AL0ZC1Fo+plpj/VOeHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rs2b6xSqLVuki8U0Nc22L1uOi9rbluxiCeg8FyCiT/k=;
 b=UTaRsShwI4tBWXTuJHVush/5aHCRQqAlQJ3YpQr985OzC5CvPhRSFyjrHk/AwFazxYInVGQb3uqGa2HU4glOVlJIHTc5ft2PVXtfksr7luEKrvUzFpgGhii2M9TMyEMTAPlUTrE99MWnofpdR3cQ3npa7meDQZWKooe4O1NB4qG/2O/VCg3QaFqHKcItpDbzwViN308vjv8X08nQMah+ZEgBG2wkTq/up9Ws1SjaHonR7oG/9UBMDwEFiIkjSNCd2y1TPRmIfi5Hm1TKF/uy3QiL1GwmnYIiaG42ufbIVov5o3R8ncaHfOBaCPItKXSy4IsG7S3OIY8ZO+uqrImfRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rs2b6xSqLVuki8U0Nc22L1uOi9rbluxiCeg8FyCiT/k=;
 b=PmDKg+D+mQYZAjshAyszcyxWjxHT2FI7fjn9f4N3jOX/4NAOwxZaz5KP1KGpRwkW9vxOZ4wpop2VMK0xHHc5mg4+gplxDGCQxQ5b8XjAhqNLX2IPjcRlzmX1e/mJURQW/Ggyx2tfLiu6cVO/MquSGfeSCnJJuV0nXqCDP3EX39A=
Received: from PH7P221CA0034.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::11)
 by LV3PR12MB9332.namprd12.prod.outlook.com (2603:10b6:408:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 02:12:25 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:510:33c:cafe::2a) by PH7P221CA0034.outlook.office365.com
 (2603:10b6:510:33c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 02:12:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Fri, 18 Sep 2026 02:12:25 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 21:12:22 -0500
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
	<odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [PATCH v7 4/4] drm/virtio: wire blob ioctl creation to userptr objects
Date: Fri, 18 Sep 2026 10:11:54 +0800
Message-ID: <20260918021154.1432154-5-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918021154.1432154-1-honghuan@amd.com>
References: <20260918021154.1432154-1-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|LV3PR12MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 37690f1d-70b8-430c-80b9-08df152a4850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	S/54ZdQs5GuUGUVajZVh42548Ky6tZ8PsjkUHEInUqHZGkH49NTKivJhdagwjORypqFocaE2X/BQuyU3EOkjvbLMPWttQYmHxdEKYPjATWvQIyAeJ8Mhnp0dnXbnKjwjWTaBWXNI7xej/9O8fETZ2CVGcGizWMb5F/X9zuK8AcK6P56DpD3c3iEy0NMM9/WMnRDt8qy0lT/7GQ2sPR7rjriK9TDj5mPOL7jEIvVs1q08Uozk8yjgiGKNablDxnPPx6O+p60YqwyaK/a2cmp/pb9Xs57f5Wb5X2nVdkdLurYEN319Y0e0R7tN7sGGpl5EfZExDmGZPhE7pb3m9e+tmZwLYN0AN5oCsKwaqAdlNRkHXV4WArNoDNEhggz7O16fgrCNMuOTdNDZtsEfefrsNadvHkvfVg0P2YuNztQAHUtaihaTQvAgAyfhnORB77adwC66ZR1sEMk9g/Lc5fzbezYPHtCwRV9qTN3FqomMvhkr5+u/8Wx73Ew0nIGmGzJ+GLhFebCCvrMXSfnXR/Hx11t8CTOCed8iYjzJHGQSGDjjB6Vvqbhm99KsO/Yxvsp4ovG5hsVqedClvP5XpvV96k29SKydcgXNtRQYFzMW6ZI/CsycB3thK0ryMZflrpEYvY4IwRJEhGR3n/L/SGOQ0vG73DXt2GAHbDJyK18wuRkJU5MYAEmJr6vT9VE9GETLHzcZpHgpT4Oxw7Bh6Iy1UA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Da0QcXmJmULsYom66Yd/X7rJQsyPETG8mFspsw8uto1YYpv6WkvpNooo8XexARHYQw3towZKOtaT4vLcR/4t7dRa1VDPJ7EiDo/xWzRjf9VNO0tqDPiWWOuxMwAVG2Y2Gw1uR1KFPHC5p8sHkuOoiQjNP4GkhYOPvJq+OmrRnaNo1+i8bFXcHdcBF7KFffT0WiKyCrBa3+1DJQXNSCvucdoSKdW0RPIbM804VqmUU8zfdZ6fM1Cv49WkJlcatkQWnIZIlD4YuWb81r1ww7G+cAO8VzyFLitwxc7hnNK9TP018WypEVjJiTvS1k5hcJY0TEelDcC4p+MW1lBK41sXmKGtl5W7Ud0P49RbXfiewBTaMGiubtpr6zAnUzUqbA385Sl3Y+lac5dXVZtY5gdF0cmix2y8BkqZ9XxCtkXFHxs84TjSC2VFQ/Gdhm/bbRlN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 02:12:25.4685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37690f1d-70b8-430c-80b9-08df152a4850
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9332

Integrate userptr into the blob resource creation ioctl.

- Include VIRTGPU_BLOB_FLAG_USE_USERPTR and
  VIRTGPU_BLOB_FLAG_USERPTR_RDONLY in VIRTGPU_BLOB_FLAG_USE_MASK
- Require userptr if and only if USE_USERPTR is set
- Reject USERPTR unless blob_mem is VIRTGPU_BLOB_MEM_GUEST
- Pass the userspace address into the internal create params
- Call virtio_gpu_userptr_create() for userptr blob requests

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 3d8e4ccdb7..6d38483f5f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -36,7 +36,9 @@
 
 #define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
 				    VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
-				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
+				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE | \
+				    VIRTGPU_BLOB_FLAG_USE_USERPTR | \
+				    VIRTGPU_BLOB_FLAG_USERPTR_RDONLY)
 
 /* Must be called with &virtio_gpu_fpriv.struct_mutex held. */
 static void virtio_gpu_create_context_locked(struct virtio_gpu_device *vgdev,
@@ -458,6 +460,17 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 			return -EINVAL;
 	}
 
+	if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_USERPTR) {
+		if (!rc_blob->userptr)
+			return -EINVAL;
+	} else {
+		if (rc_blob->userptr)
+			return -EINVAL;
+
+		if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USERPTR_RDONLY)
+			return -EINVAL;
+	}
+
 	switch (rc_blob->blob_mem) {
 	case VIRTGPU_BLOB_MEM_GUEST:
 		*guest_blob = true;
@@ -472,6 +485,11 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 		return -EINVAL;
 	}
 
+	/* Userptr is only defined for pure guest backing. */
+	if ((rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_USERPTR) &&
+	    rc_blob->blob_mem != VIRTGPU_BLOB_MEM_GUEST)
+		return -EINVAL;
+
 	if (*host3d_blob) {
 		if (!vgdev->has_virgl_3d)
 			return -EINVAL;
@@ -495,6 +513,7 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	params->blob = true;
 	params->blob_flags = rc_blob->blob_flags;
 	params->blob_hints = rc_blob->blob_hints;
+	params->userptr = rc_blob->userptr;
 
 	if (vgdev->has_blob_alignment &&
 	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
@@ -538,8 +557,10 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
 				      vfpriv->ctx_id, NULL, NULL);
 	}
 
-	if (guest_blob)
+	if (guest_blob && !params.userptr)
 		ret = virtio_gpu_object_create(vgdev, &params, &bo, NULL);
+	else if (guest_blob && params.userptr)
+		ret = virtio_gpu_userptr_create(vgdev, file, &params, &bo);
 	else if (!guest_blob && host3d_blob)
 		ret = virtio_gpu_vram_create(vgdev, &params, &bo);
 	else
-- 
2.34.1

