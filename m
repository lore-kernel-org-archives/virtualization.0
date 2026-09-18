Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012060.outbound.protection.outlook.com [40.107.200.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D3E430794
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725612; cv=fail; b=Ay5JBbnpLQn2vSjNX9534gfUqJhMHZ60zFZjBBVG0E2DmijTEWNLEpJzOovGYp0FPpshT2nueWdYjAa9rRYv5Bg8oH4YnTJgtoXrGhWhiMi2wNothvEfns0sw+EUgADsN7M3sHhN9FMOBH9HvyTuI8uPo3sMCthu5sWuPfZfWqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725612; c=relaxed/simple;
	bh=m2dJVrN4C+yWnA+bwb3IS+s8iwlfIVF2vRmATIpvxa4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPQ++zBE3pGxlrTMB4NYtptfGinHs3i50Xr9/IHbcnx+wTfLVsyZe7vtsf5vkuY5JlYgp2pNvU+KIIolLjfd+WR/+Ce7OwFVYTU1LBTLBYcGmKAHZ1MKiHvmtrO8aUYZMfXP1ac7O05aN4m1X3RlJjebYcuzOb3Q6hA1aDTuMtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VhOi6Gta; arc=fail smtp.client-ip=40.107.200.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VhOi6Gta"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqlT56Fhy/XJWVSFNz1MCvHY4ESL/XKuRdXplhEHoIJt7lE4GqzyMG3vH7rx1fUoK9kHFPZP2nKnPYjy3ZW+ck9RFCaUuHw/P5biQKG0dc79Rpe0JcmM6GhKwgWvSSst1bnO5PY6ud9Br2Qw4fBr9GssUMe2UgttKz/PW5SyXGjsoi6oSpJWqrI6F79OuqqjjeChWKrGaOFs0bowp6TuOPo4WgEJQScHntR2tNSJ+weDTGd+aYgK+z7vOcJ5CecnET6j/CYcM7SsBjp9sX9sqDpQmvmYNSFHnTI3AXgb+kYy2Eesgb5q3GkQ1q5AbnuDXk8CRzORMoiPHzDISE1qbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEd3Ws1ZJrISbTEwZ1itvhZz4BbQlDtfOlJ4JlqZyxE=;
 b=RJuSOmrYVhx4x3h0I60vPoxtxLRS2CsuPA3tUiIdEBPGwXUposSz4fbAClYRPu1u5OuwOlZhXHDtgBbHE/rjVS4wXR9TYx4aDSnxvawV4sgbfq+X8yRX3RoZt3fAOpnvEuRX6s4K5HARlF0L4EKb+dmWa1HuVM7OBHPtGm/NmsBy3LXTJnXD/OJB3J1PXMExkqlk9mFqIktyd3Df4+n4/4kwmLVBAG1XgyxUHp4wDWOIDOCDmXr7+4mTTk+QrqtPKT531M6RZs15679zIj3bB5GgbvvkQi90F7mKwp6BjtKZeZv65M3VdDnkJG3jiZRP9i5lQYMCs/PkzbYPSFlX6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEd3Ws1ZJrISbTEwZ1itvhZz4BbQlDtfOlJ4JlqZyxE=;
 b=VhOi6GtaJGHh237jy7ve17Tb5Jhxiu3szxSZPSIE/SgzUbuZYKOltE8aauribZ/DPgKOBeyscjLuSXUWfnPrQGIqfTI5wHowOHQStdhfqhCQGnb3Ppar8HQ5L8/uM8kRkWU7+8EJekWKlzJwmpIEZh9Smm6NFW6bnGJD89hACno=
Received: from SJ0PR05CA0089.namprd05.prod.outlook.com (2603:10b6:a03:332::34)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 10:00:00 +0000
Received: from SJ1PEPF000037A1.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::43) by SJ0PR05CA0089.outlook.office365.com
 (2603:10b6:a03:332::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7 via Frontend Transport; Fri, 18
 Sep 2026 10:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A1.mail.protection.outlook.com (10.167.244.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 10:00:00 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 04:59:56 -0500
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
	<odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 2/4] drm/virtgpu api: add blob userptr resource
Date: Fri, 18 Sep 2026 17:59:38 +0800
Message-ID: <20260918095940.2253018-3-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A1:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 57aa3307-fe97-4b21-9994-08df156b9a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	syRnVjhO2bPglVv6B9s+mlo98ybqJXWQOUCeRrVBwLDtGzAVubhA/Tiyk9ptP5lV0WB2b2cNOETiCp155knbpEEB9mMoeuoy877GAqozsfFW9UV1oDGyGVM1cG6vMdcBGg2exKyQ0MhaaDvDfc+kh5AcIhVviuEjrR8T9lszuYBflP8DBgXmB5NIvD1RdLML0kjf6sNukmUGxooywkNpZ3bT8nIeTwyL4muHepUhg/SCRqf8lKAgo1tJNDog77qsGDkmAaPb7BFEpEnN/ZcZcflLA1w0KAfII0350IixL7g8CvZuFhLrIyS2ynnXEOhpWyc8d+Ko/raYJ4HO+WxzGW+tmjo2NHfoSiokOISLn6YRV+/TNAc6ss9U5RlQ0/V5n4Az+YS0GQHC9F7XtenIDI7+1GQAFZKDTrgPLltBSqHIYo5NI3FHLCIkXAxhWY3sI19HveaxLsjPKedd18Z76/vfgy+5ZXUrVtrz/1BDpDHac8dBB8VEjyFIgG5LEUI9BtVTDxBT0YZAebC3QOeQUHehKyaw+RwC15fF6uqB23AH6Dq1NXqDPwR708kVuItFlyFeznLfXwqNVblP5coValQWoyMxGoSAYC6KC7XK5dGHNgHo84A7cGgBN/TSDh2ff4nH24HZvjDw1vfkYtHIf8YwV4yTwrFIJjwwsbQOm9a1NRRv5JziQjCSm7cHiEZeSvKPvhSO1MunsZg7kbpYMQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kjLKxDq9jXgDJd06a9RgRLionevae9HN4nymZn2ZheXWChbuhiTZqZDBp0Rc7XPd2dqZ/yPh4vJRvgV2pPKrLyscM7M0hS/ljfMWY69WoN+Vp0JFkjXiMNtUAqawRnObdm4YdA/qA/HOhPiOTC12C+HqF2NDGE836VKz1iOAHpSyaSynxuNjEaqqRWQVl9cxgRov/5+QVEfhKRr2h4HqcTNQXp3OinNgdwCKevJr/pHqjauiHQo1SH68mq1Q/55LMRSf6QRcG8GsmCvnBXYEW0Cwk2I6tQaOYhBCPI+yRMM1phEmCx23kHS6+DRmk9TcGHFXOsMB1fqodVVZTzqr0DKuMyL1ao/vayf3E9k6os3c8RbSpTBokeD6P1J8oD25Nf2f94MRN+qs9f3IXLDNGdtg4my5ORaTnFyJRtrOPXob1ojFm9MOaJ6zZYfKIxyg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 10:00:00.2444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57aa3307-fe97-4b21-9994-08df156b9a43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282

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
 include/uapi/drm/virtgpu_drm.h  | 13 +++++++++++++
 include/uapi/linux/virtio_gpu.h |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 95587e12ae..80f73b3276 100644
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
@@ -186,6 +188,10 @@ struct drm_virtgpu_resource_create_blob {
 #define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+/* Wire flag: device MUST NOT write. Guest pins without FOLL_WRITE.
+ * Rejected unless VIRTGPU_PARAM_BLOB_READONLY is 1.
+ */
+#define VIRTGPU_BLOB_FLAG_USE_READONLY     0x0008
 	/* zero is invalid blob_mem */
 	__u32 blob_mem;
 	__u32 blob_flags;
@@ -205,6 +211,13 @@ struct drm_virtgpu_resource_create_blob {
 #define DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING        0x0001
 	__u32 blob_hints;
 	__u32 pad2;
+
+	/*
+	 * Guest VA to pin as blob backing. Non-zero selects the userptr
+	 * path and is valid only with VIRTGPU_BLOB_MEM_GUEST. Must be 0
+	 * otherwise. Probe VIRTGPU_PARAM_USERPTR before using this field.
+	 */
+	__u64 userptr;
 };
 
 #define VIRTGPU_CONTEXT_PARAM_CAPSET_ID       0x0001
diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 3d4dfadc9d..33f5332e59 100644
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
@@ -415,6 +419,8 @@ struct virtio_gpu_resource_create_blob {
 #define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+/* Device MUST NOT write. Driver may pin read-only guest pages. */
+#define VIRTIO_GPU_BLOB_FLAG_USE_READONLY     0x0008
 	/* zero is invalid blob mem */
 	__le32 blob_mem;
 	__le32 blob_flags;
-- 
2.34.1

