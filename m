Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBBF44C50E
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243793; cv=fail; b=UOyYgvbEafUG7TPJMbBZdFMtCN7Q6tr66cO4MQCb1GVh0W4ipilzFjlbBNFdAHtD6k1OswJqRgrA1pfO64Go3cBXHoamDcC5tesZLQduBJy+j6uOWApjyM8SHSTWob1j1czOO9QI8+Z8hVQVdR6WGPNilDxbP/ZgD8c54RmprWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243793; c=relaxed/simple;
	bh=tdQ1HL8bX3+iZ56OT20Fp7mPGXbJTjf5yrIC/2uUJtw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5OIs52dp2g6VzyAMyPxFrz9CPXnCuSYQPDGLAyUC3p/SJ4bBWzupK3mokBgZKU/MSjKQrBFCKJTvVQ6IbQK64cmjdJvPwzDWjiXhxzsENMCRrtZZqndPYeIvVpili8NTteMnbs3dYvaeJyDoNdJV52Qu0og/e51u/SbxIzCFIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1tCOsLbL; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1tCOsLbL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJOLyEDXmifxg3dv6PyNEMlP/Z7d9PAkIZAGljZ+DPVHPreFBlvlj4MLMmwjj3lvzmpx4URlhxrc0dCtVgRzZqMHmVrrhtNCcr5KqMIUj0ncUNRPd9ZWSGvxF6f1Ko4YlsPHi0BvV2M6tTVGGPD8QO5R1YIKCnAus5dArNnHGH+N373lBuVtpw/lN9FXJv82QQU6J0gVzLJRg4bbmEgGLxgslUhQnA4r1xVGJIvX9MrLX7jWdlyeXa8HZdNqwZmIAMwXUvfkl1a3rjnCEC8VBeSGlgPcftSFOvlzN/vBmDyjT0RqcU5DUKcnIg+20xFKGpkA6junTmLfiSdWd9NTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDPnASpYJelJWNYK7ontFRtDPpi+l0vK475gROAW84A=;
 b=kodoJnXqUFYlK8p1j/2lnECH05LOHUd525R1hueqh0OryxGyxs52P3G5xRcvljMn/9ATYp5XvEMS9Q1LLSNNV73TPMfk5uxPdWEwHO7y4LUdRs+OL2ak3RPR5p/fcb+E4L79DCVDju0mKZsv1yYM59pev/GQ9NFgmuRqxCBsZse5gtCnAgi1ZDXs3NzGI7ZcwBgeVKej1AFkm9KHZYIPJsa6gOM7u1nRcxc2KPqf2e7IZmNo0e3Z2wIoBTR5xgcy74afYztqXodpffLr/c1mhLQRA++lfESr02ci/6znV41x9X3m6OONZP7s6ST/K0GjX+ZUNncwTDbzf3aeCOUHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDPnASpYJelJWNYK7ontFRtDPpi+l0vK475gROAW84A=;
 b=1tCOsLbLrWaGktGtDcBT6xGKIlrQ3O5hPcBIeSMiK+hTBCJnFcgorpgbpBsbGKptiDb6VuHAlS1XPI9oWnow1HihcK1o4YKZa/Gv7ZE5hb6yEA2rPKdIPu5EjPQ1ZxFyM5SjHSLAcVFH7PqifHjIB+vXWEIZcM4EgoYwgh8Xd7M=
Received: from CH0PR03CA0353.namprd03.prod.outlook.com (2603:10b6:610:11a::15)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Thu, 24 Sep
 2026 09:56:17 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::64) by CH0PR03CA0353.outlook.office365.com
 (2603:10b6:610:11a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 09:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 09:56:17 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 04:56:14 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dmitry.osipenko@collabora.com>, <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	<airlied@redhat.com>, <kraxel@redhat.com>
CC: <gurchetansingh@chromium.org>, <olvaffe@gmail.com>, <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [RFC PATCH v9 2/4] drm/virtgpu api: add blob userptr resource
Date: Thu, 24 Sep 2026 17:55:54 +0800
Message-ID: <20260924095556.1326164-3-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: f9c38be3-e6b2-4c8a-34d2-08df1a2213f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	tlllrdusFaSdMToMgnSC6+p8WDiPN9MK2V182X/LN/F2dz3d2dTyvPDB7sz1GvM/fmoO8UOpCqm6T/eA928TJzimqy7/9bRA/wYwQDg7VQr/kXVohL2X45xtatCm8r8GYvefZlHYYAvVfsV9/Q9JFmyfhHcR1Wi8tgL964jW5euRs4Ig3YftftQyYfHEYo312PPmha3cvza8YAXXI0JLAlCM/nmnrMtvFzvt12rJXHNAuxFthgv5OV5JMos9oUyXE4sjlzQN4jLbuW5m+1xsX6wG9eKajE5rbdBwwBl7+0o9CYDtjd3LLN/EDG6KaFbwK7vcMAr50RYXeb/ASgUGXRIrZEV54dzK8G0Ql5xmYhLsE2/OSn+04KZGRl3+9z/2n2+g8qyFvZImTsoQYAbj6BPQEutKKhi/5/ZYkQuDO1M13TXQ+PEDMOULBp37L+kqryZD0xZtjIAWTR2qbCinyCCPPNLMwyGURFqLl1GAtlMxfDvNtE2P75cBIFD+LZvz7fdK63k42sX8yjmD2SfDCCE/J/NlfRfCoROrjOIeKpJ6bPpHZneJtgfA9SIZpkuL57DjFN1hnBgQOoBxHK5DI9+DCt5uyudHNcdZRxhIX0su9qbLkCQEYEi20OJcifz/q/X8dIasX7LCDDP71vuIrD3Iu22+cB4lVxPPB5oPga14x/l3Ll8Zm+UmH+iiaKysVby55DyCNDZtMlWvExxVTw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fKzCbyd0aTMlDOcbe7UeKtjtokTCbDqx9bXR1zUqe7gcBdEXv1lOgQox8jiWyhr/h+eJdC1Q95MnUYk6UZAAmPWU/P37LGlxMmtzQ2e/n2afLCk8/l2U5vwjg5ii8/jzXd5ckvi545mPzcmAycYqQ4ax4LBODjd+ZL2k4JjD8dQgDl2jv1y8tfLSzoEL/0faPMV5a3IzxaWBGe8iIAcZumrlwAF/1o9mZkczAyiHqwWBPElH+ZV1NWyG5dRo9gV2aOYNM0L+KUmnfWtCNwUbTXs5r0GMR9GrH1WnyBCx8s583GA+sIPCOkceXbb2MwEesqN+H6a3s7wPxl7ECRolADzS7xsBLapjiZVntSlR4bkMPHgPv4ON0tBfEcqzQlsYJxt/2W9dxS00t58gmjxQfnHXFqNPdKq2GOJFaLAvao97nLEDjY2zi/Q9eXAcBW4T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 09:56:17.4799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c38be3-e6b2-4c8a-34d2-08df1a2213f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078

Add a userptr address field so userspace can request a blob backed
by an existing process mapping. A non-zero userptr selects that
path; probe VIRTGPU_PARAM_USERPTR before using the field.

GPU-readonly backing is requested with the virtio CREATE_BLOB wire
flag VIRTIO_GPU_BLOB_FLAG_USE_READONLY (also
VIRTGPU_BLOB_FLAG_USE_READONLY). The device MUST NOT write such a
resource. The guest pins without FOLL_WRITE only when the device
advertised VIRTIO_GPU_F_BLOB_READONLY (VIRTGPU_PARAM_BLOB_READONLY).

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/uapi/drm/virtgpu_drm.h  | 10 ++++++++++
 include/uapi/linux/virtio_gpu.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 9b886e9772..c890c754d8 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -99,6 +99,8 @@ struct drm_virtgpu_execbuffer {
 #define VIRTGPU_PARAM_SUPPORTED_CAPSET_IDs 7 /* Bitmask of supported capability set ids */
 #define VIRTGPU_PARAM_EXPLICIT_DEBUG_NAME 8 /* Ability to set debug name from userspace */
 #define VIRTGPU_PARAM_BLOB_ALIGNMENT 9 /* Device alignment requirements for blobs */
+#define VIRTGPU_PARAM_USERPTR 10 /* CREATE_BLOB userptr field is supported */
+#define VIRTGPU_PARAM_BLOB_READONLY 11 /* VIRTGPU_BLOB_FLAG_USE_READONLY is honored */
 
 struct drm_virtgpu_getparam {
 	__u64 param;
@@ -187,6 +189,7 @@ struct drm_virtgpu_resource_create_blob {
 #define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+#define VIRTGPU_BLOB_FLAG_USE_READONLY     0x0008
 	/* zero is invalid blob_mem */
 	__u32 blob_mem;
 	__u32 blob_flags;
@@ -206,6 +209,13 @@ struct drm_virtgpu_resource_create_blob {
 #define DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING        0x0001
 	__u32 blob_hints;
 	__u32 pad2;
+
+	/*
+	 * Non-zero selects the userptr path and is valid only with
+	 * VIRTGPU_BLOB_MEM_GUEST. Must be 0 otherwise. Probe
+	 * VIRTGPU_PARAM_USERPTR before using this field.
+	 */
+	__u64 userptr;
 };
 
 #define VIRTGPU_CONTEXT_PARAM_CAPSET_ID       0x0001
diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index e22049835e..af95374758 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -72,6 +72,10 @@
  * must be aligned to that value.
  */
 #define VIRTIO_GPU_F_BLOB_ALIGNMENT      5
+/*
+ * VIRTIO_GPU_BLOB_FLAG_USE_READONLY
+ */
+#define VIRTIO_GPU_F_BLOB_READONLY       6
 
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
@@ -415,6 +419,7 @@ struct virtio_gpu_resource_create_blob {
 #define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+#define VIRTIO_GPU_BLOB_FLAG_USE_READONLY     0x0008
 	/* zero is invalid blob mem */
 	__le32 blob_mem;
 	__le32 blob_flags;
-- 
2.34.1

