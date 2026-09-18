Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011057.outbound.protection.outlook.com [40.93.194.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AEC3A382D
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697546; cv=fail; b=CwQ+FJM2Z4CqufEs2gCl/XQNqL82Nh6oy23jAgdspAXO3BKghdRewL3ThAYN5gRnksGMh9BJEkWIBRz+FrHeSVjU6jCfKVFOkhaVID6r6Eh9hb7jX/D6rktZ3YO0/l7sP65xTM21TTiyh37bjfx1Me2BEYq3BLFDQp2EtH4KkGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697546; c=relaxed/simple;
	bh=z916DXQ9wXtwcF7TuLeQvFxojxHrGjiSBlCRtSW/Dpo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWISzjTPPCttAShdjl/K7ZJtP7SEafhszLayIqcYgxWIGbMfWtyHr92VHKCNO/54Y9Jckpa8Hly7Y3o70pv/DbTrYQvgjbKpaqALXdiVpvq/YRmZs1T+HnFSy8dUVeP2tmbyEaFaYG+nyW0MMAN4yiLbQYwUZ5+eHhwElLWXOoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jFNjylSj; arc=fail smtp.client-ip=40.93.194.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jFNjylSj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyB9dNfhwzOSCgrp+UY8Y8eiJQMg6SIRxS5I7Nm9ldlVKe5bJsGNQK6weY4n9EqYu/sNx0rL3LKVgWjgdBBRgwO7YI2AVX2jKbz0rmNcfauRbRRII3NRhrHPt9VBXf/4MuaGHScYCtsrQvszFHsPojZbO8DsO0qa9am0Jfkh/3uJmXXAvIkl9bte3veWmIzmiFVvgJzhJu5UhgwjtwUppStoyjIjcHQbJ+ZuN1CPYYB0vqB5ejwVDLZ0thkwMOUF/rHt7OMncxnovYoA2Ez3gHTNQFO/735eB9WB6hWPGpXswN/6RXEwbbw1IUgrRB9yyilc4mKd6Y4HVVv62btyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDxL3z6p5SsREHtPP551hmUkLs/GzCim7aKlqTkTeR8=;
 b=KrAuoFzja/vObo31ba92480S4btQkRPeHVeSC+To7JuJkKB8MI0F1lJZHywsCBsYqbRgyfBW+AMmKNHKw6w93e72oLGVfNWCqTxcz4J7Jd7lVjeGvLAy8WJAw0JLFcmeC0YxEhpuM6PeA1KDz9R0AUnB/VAPpSzkUnup3jBQnxfwvv+J8iVoXdpylEUO2DPz1aW78aNMAtUl9/B7RL7/ClyFSy+USIPOccAflayYXoTo9wzIHhchBAO18zBataAnaiD02OaGpFto+e0vyZFdWOmCwE9jSdZMrVUz7TKWRaBZNiCmVlwEZmo8Vqj3pZjgFa6IgFbuSNL4NfW5KoPK9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDxL3z6p5SsREHtPP551hmUkLs/GzCim7aKlqTkTeR8=;
 b=jFNjylSjYLpHvt4a6zf5EE3mVI2enXaeJoZVYys35Rq4ur/dawR2zgvh88Gz/0Y11hnu42O9+MuAreIlgj+NrZ3LMUTWHTcfYjhTIePEB5HFlwUrzYb0ISeq2Mq+uD0JAxEBf2Hv89g+uZm6690pehPQoM38DgQTmnLX+2AeUv8=
Received: from PH7P221CA0043.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::31)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 02:12:19 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:510:33c:cafe::35) by PH7P221CA0043.outlook.office365.com
 (2603:10b6:510:33c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 02:12:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Fri, 18 Sep 2026 02:12:19 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 21:12:16 -0500
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
	<odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [PATCH v7 2/4] drm/virtgpu api: add blob userptr resource
Date: Fri, 18 Sep 2026 10:11:52 +0800
Message-ID: <20260918021154.1432154-3-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c49da6-a03b-4bae-374b-08df152a44b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	lrLTKVGdqJOzkvku4Kf53XXen0OyU/SNsz4W9mkQBuzDjz5Z2pqk8Y8vRQjtEHotxg82ufFjYAmrhoMszgktxU/0ArywrULAY41PqDvd9quH+uscO7MnutRuaxFb58kfmbdmvq8XzZ2NT92Bztip8mdYDEP7iNwZNumo+nO6Y0HHCCBJozKjBaLnrqCADmACME2+fe6hiWRwFf6dwMmC0DMOMEzjWVfIDuwxC8uhW2CFYHvt8VWXv0DXidf9BtwIzbdhjZQE/+YA6iSXJdCYncOzViKDwrXO54p4+/eaH0ofHBfJ4m++sjoOd+IYt/GYnhuoozgItgQ+qqAzinMwVPvq7o1cfWelHaEV9BAz9AUVRHkYbXEG+rcZvElS4w7gGWYYW39sSUEvJfQQFNGxVlYRXNgkGEDpaXsf6CR0GZFUgjk9p3u0sV3dx90Ua0AKJWDxRgBNAtIy1B0ZIzioGrDc/crgLFnbU+8hgnC+J5v/tdsy1hD0kQNUtur30vrO4EatrU720Qu4CYsZb+gsrF/3BjdFTtX8K7KmTvbs7wZhCYBDpwVObj3Ws9dqt5D2D6ITBl0uDe1FKLwxnjNIK9ULi1PY2rLF9buKJ7xgrbmBB5Ciepz4Snt/mBB7qsty6lAoKeVMvRzY+oGPWI2m//QWqieZXZ7QdiwcShDNKqyP7N6ELCOw0ZV1HAEenHt0aW/jGgkZ+qCYkaLE/ZYhlQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mSpJIHeif5SYF0rwpI03QvAoA+fCmghC/I5vmkxo4MZRuBGiby+x0n8BYq2Y3UEhOrrk+e3qVSzORyFGmIQ1HHSqnMXUP3tjXhfXR9LeUuBEJERZVLBtyO/Q6BaQQw2b+cgZgQC1iWrtGLe1aS5sig9Rb1A+/ib0ayT550CdtscJi+MytZELmVTufSdioWZySP/t/OJft/aS2XkTbFnzBcvdZlz6lkkutGBpyO8dr1RDQxzJN53DM8y3Noebeyd3HcrjgU3Mhls8KF85SVg+F5B1X3OkKWhpipqI1RHVczJ0CEITethiGWwy7Ism4I+LoNMsCsdjVSATBiqcEG2LO72c1ynZ+qXiIYiaIZ1Vbp8ACibf8oGzSdTNoW1PW/JyuRLZAcuRyrCKxfLglFpdDCMfkn1F8YHud280aKJiFC0VBI/wwsT8WZF1v54Phxq/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 02:12:19.4105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c49da6-a03b-4bae-374b-08df152a44b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798

Add DRM ioctl flags and a userptr address field so userspace can
request a blob backed by an existing process mapping.

UAPI changes:
- Add guest-only VIRTGPU_BLOB_FLAG_USE_USERPTR and
  VIRTGPU_BLOB_FLAG_USERPTR_RDONLY flags
- Add a userptr field to drm_virtgpu_resource_create_blob

These flags select guest pin behavior in the ioctl. They are not
part of the virtio CREATE_BLOB wire ABI, so mask them out in
virtio_gpu_cmd_resource_create_blob().

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 6 +++++-
 include/uapi/drm/virtgpu_drm.h      | 9 +++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index c02c03c10d..6830673309 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -1494,7 +1494,11 @@ virtio_gpu_cmd_resource_create_blob(struct virtio_gpu_device *vgdev,
 	cmd_p->hdr.ctx_id = cpu_to_le32(params->ctx_id);
 	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
 	cmd_p->blob_mem = cpu_to_le32(params->blob_mem);
-	cmd_p->blob_flags = cpu_to_le32(params->blob_flags);
+	/* Guest-only flags stay off the wire. */
+	cmd_p->blob_flags = cpu_to_le32(params->blob_flags &
+			(VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE |
+			 VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE |
+			 VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE));
 	cmd_p->blob_id = cpu_to_le64(params->blob_id);
 	cmd_p->size = cpu_to_le64(params->size);
 	cmd_p->nr_entries = cpu_to_le32(nents);
diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 95587e12ae..62c4b8f19b 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -186,6 +186,9 @@ struct drm_virtgpu_resource_create_blob {
 #define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+/* Guest-only flags */
+#define VIRTGPU_BLOB_FLAG_USE_USERPTR      0x0008
+#define VIRTGPU_BLOB_FLAG_USERPTR_RDONLY   0x0010
 	/* zero is invalid blob_mem */
 	__u32 blob_mem;
 	__u32 blob_flags;
@@ -205,6 +208,12 @@ struct drm_virtgpu_resource_create_blob {
 #define DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING        0x0001
 	__u32 blob_hints;
 	__u32 pad2;
+
+	/*
+	 * userptr: guest userspace memory address for VIRTGPU_BLOB_FLAG_USE_USERPTR.
+	 * Must be 0 if VIRTGPU_BLOB_FLAG_USE_USERPTR is not set.
+	 */
+	__u64 userptr;
 };
 
 #define VIRTGPU_CONTEXT_PARAM_CAPSET_ID       0x0001
-- 
2.34.1

