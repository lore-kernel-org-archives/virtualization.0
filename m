Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793953617;
	b=a5HOPDIX3LJKgRtSlzyz47GSDZ/CjGTGOaj2I7znAH60kPuVBdNEjf5YOK4Oq+R8izNa
	 Ep7ywP6m3SUnXMkU15dfBHRojAdiq31zJtqKdzOSlALZIC9Q/IfvOpjSGE9qAfyhIEZyW
	 w60zi5cSK+sGAA35Z+BqkhCZTw85u7M7cx7+VGcRdVP2U2owXr2l9RTpDL5XFbMN1Y8Q2
	 4QIejnrecrsh/d00Akgu128Q3IuECa+uNCr1Q57FP8ZrW6gj7u/88UoSrMFjYUNkbJUUD
	 9T3jn5bME69wG7tNXXxZPkee1i6pojEumT4NAWOOq7rR+H/KCtV9L0u3cmV+XRe79Kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953617;
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
	bh=YDPnASpYJelJWNYK7ontFRtDPpi+l0vK475gROAW84A=;
	b=3Ny6nIu4rI1KqTcqzGRQO2NE+E6tUHZw3wT+to2ExadIr0nz1a+Msrw5wBoxSnuo/EQS
	 VBXI/il75iKDa5xkF0dwEs9IDxjK8BDcQut9mtZBAG6dozowvvabxGR87oKpGeMnlchiE
	 d6Qqvp/zDTMAcOySM9Ph9KAE5n98l/+7tQx2A2cvaoeeksiCx7x3mKXUFjFoukd/ysIlH
	 gVuPvwngkEGWHVRVBnBzo9BxpvEg6gW759H/nHVTgFBtDxt4XcrxDOgzUqYr1r3oTdn/u
	 /me2TTd+jkIoUF2hmj/Bquw2e37v9A8sbQzWsc0rsBFWe6RmWE0ieThSp1srjApYa/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eLNpPW51;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.61
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011061.outbound.protection.outlook.com [40.93.194.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33893606D808
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33893606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eLNpPW51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUmkPfSS5/fS/5RfjeDf37Glk6vCIEWVD+gauIVO+O+EUMrjsEFaDJIHh+F/QCK3KnK481Q4vgnJGdeDbCx/R1PEt/fv18iUHaxogpDYfCvnowcCJsY6VlhJWS4V2LTnyUY2HgTsrDEcoYVS214qpYOXtFP69zX23mpPfcbsROSecMpIVZTxhSG9+zhiHl8hKrYfaNGp/+znm2yTUxfRfagShhOotiKW3n7QdRk4X4zAARyDz/ehsoDtW1oSfXO6QpuxQ9JIdXk+V1oe2B78XNQM1BT1t4oXcLlKBP9KmlkZdMzBObzA4U3cUimSDeNIVEiMiP/HtjyrB9oix45T0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDPnASpYJelJWNYK7ontFRtDPpi+l0vK475gROAW84A=;
 b=IxIpSKCoGi233wVd2AYT6ROMmbe/iPq0IR0DkVSwJz5/uKlcRTkoV8wYwJLCWvO/P1vfJOiIwmtAZ6DIaBq7eH/jleN86EDAeGVnZnOeFtWa6SkQxvtHDmJDIJgSOvzgqdAjqtaFb5WxpGjpJJAGDnfF2cse/+KJEla3IedNVBsrMTpgZ5Xsk6OknzSHWFncJe3+qBv9JVLk4VYB3LWyQQYnMqDozs2OG0c+SeEjZ8QjBMfrS4Pbrs4WIsctqxYxTtQ4WlteZAI8wN0ocAFTUjdA2+1BXXlndEpAAE88ELXarDIC8NSmyWVD2s935Io6tm2pQibYP98+cJcdXgua9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDPnASpYJelJWNYK7ontFRtDPpi+l0vK475gROAW84A=;
 b=eLNpPW51RAdsl0c+MsM4VxkM/4oT8nCRXhroqNUqLvZKCl0WUyQeuVtIGLrxNKigqZl+YG7uEeH5uDlU8DJAEwg+Akz6AHS5thKI1lUHjCi1Y4AufOQsnshgFzY6EcLm9fdogeY1Bt6PX1H+1pjiyXP44rtph5n5e/oQjFxerDo=
Received: from MW4PR04CA0314.namprd04.prod.outlook.com (2603:10b6:303:82::19)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 08:26:53 +0000
Received: from CO1PEPF0001885D.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::40) by MW4PR04CA0314.outlook.office365.com
 (2603:10b6:303:82::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 08:26:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001885D.mail.protection.outlook.com (10.167.249.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 08:26:52 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 02:26:44 -0600
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
	<odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [RFC PATCH v10 2/4] drm/virtio: add userptr blob resource to the UAPI
Date: Fri, 6 Nov 2026 16:26:23 +0800
Message-ID: <20261106082625.812860-3-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885D:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df2be3a-f186-4e34-05af-08df3bdfb5fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|18002099003|22082099003|261102123227099003|11063799006|261026121527099003|261022105027099003|261026140227099003|261021121427099003|261009223027099003|56012099006|261028144727099003|261009221227099003;
X-Microsoft-Antispam-Message-Info:
	o4mkOM3G25Uck+iyCEooQPs1gOZ3eyK6UFOSHhEXZij0IxdVV+4fmNjaNfixZ8eeRWSEDbVeTyJ62fjN2be2UKHUzPTBwI/gI9Qql+kU3bRIe81UUcCbPN/tsG3CQK3e7HnjPKcXAjwf2TU3obTubOD2GR9p4uRf867VHEpdKYYGx2mdzYUAEBW+PNY1oNlPpiS8QI9B8gscxxmmviG1j/drhTFhwsMJaf1tKyNVBL171k0ulFM/7GXN3hOAOIa8Byb7D3IJQrVh2FmEuKD4wfuDnVx4aG9o9b32yZA72qGih+/OtmvmXItZGeifLIXn1AUXo7dMvu7e0R86slIgXUjCHIXzhjh/RxOj4DZQM50uQOsJugyo9b92kKcVxBxYdApWEEHMuwvDgLVo+DP+NAu/p+QxD2R4gtVjdBl5uJHZ2QY8/vIa/YXjOrhmip+z1lgdEieVpI05/TaEXHYcucpGwysf4hTb3H4aMzi5Wl6zL1tVJcIg9iSX7uNqX/VZWjkwE0LgdHdgex0TIKUetAPNFq5FlrhUyJcKf/zJUuUVBMaykq/LrSKhUtmopxVsT9A5XR+YEu7EQgowG7WjUWt5qT+x2PjvzKrU1Sw0AMRo8BWFa7B4QUVZ3CMizUzLsRPR48RNs4iii5c73P+axgD3aF7alC9h3Q6CZgxbi9stK385tcqANku9s0T7C/o3cbQfOIpiDwsZWikdw82mSw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(261102123227099003)(11063799006)(261026121527099003)(261022105027099003)(261026140227099003)(261021121427099003)(261009223027099003)(56012099006)(261028144727099003)(261009221227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	taOh4ucfnjSN+YVQ9KLNWaqrQnz0Mv70E/gc4zoFKQNzjvRgkLj++Pt3CuZWpRLcR1TykSOn/FqRK88ejR1VMllR9aPUeFFo8OsJLYL855IDmdiuIxEn6oBTuPlX6BtIoCzepuqLtQZ/nJmC7dtmhhgeeWw4wAyE8u2ZuF7ORzqo3+nm2Umtcc5LXrD1L+KbVTsOhNJlJc64MqnwhmL7hfB0NNfi5TK2JCzOYI9ac62Wg4Ps6Od6dDXJQQPPsfmjIgbRDwNlXsj2V3QZDghNeqG6qxr71UQMHJ9ObyrMTLn5s4hqFWOji+H69/rGxjrl3fhFmv9QA1Ay8LVymvj1UZqgd0xWPKXGzB0gYdCansbEzjcIU803vDGqMvFj2ioIlLbpjB0wPF/Ug9oOsk4z82/cH4YhNCSmdkldM4p3PCP91qQkexKVr/+QEZ4aFyRu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:26:52.5345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df2be3a-f186-4e34-05af-08df3bdfb5fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF0001885D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449

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

