Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793953616;
	b=z619dxtEb3Fn+/AmlwlBTD9IKe1etCdQGpc6FZaR0EutVR+vTPgrd2bQR/OpAlbjvmvD
	 pZOn169BTugfApusQdFYSnkD1UKdVbfqgGQHR8wb5enF8zpxMSR7Bu+PD9lPSSKULIiXT
	 ZbQRb1znMgZ8rk3rEO+31pE4FKixSI7gB8JzcdUFbHz3niHMlODJd2ex7LX1zS2kfsYSj
	 wk8aSZ9lGECMdJ7LtePWkLNrARSSB/YcVd6D9JN5gnr2i3WAZXzHLpfX/azYrcRGVara3
	 6XqeL3wH3pid4t9q1Mmb1KAsHiiYkxbzIoiF3B6Q7QSeuEe1MLJirxEcAiQhhx6unMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953616;
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
	bh=1xEFLP+Nvprb4NYFnlQfnz7vty0C3ZZijL6g6xhB7kE=;
	b=TETxXwMVR5Gk9cqZHlPMxs3JGOmT6OqmRrXxLm+J1j0UJdEFGggY6skCvfF43dKBSTAq
	 9PJhQCHW/riG4Ym8qcoFKaggMnhe/R55olAZ1h9EaYnNgobcaq+syxsuUuxZy394YDWZu
	 qhtm8Nc1puqBe2xdCZ3zZaAXkZGEZwidnigBhkfX0z4LfX99X8naesvYF7EuCQ6ZMc0Rh
	 Y7xDS2Z2Y1TizIF4iTJtr7tzlezLM4/g7XScMx5v1x4UIrTv1zVWtEBCVpYsp6u+Mh9uc
	 1wi8sl5Ay289xctEGA23GKFza4kd9+8eumoH9Tcf8lRtX3L6abmNhspXZAVn6wwifOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SZ3ufG3V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.6
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010006.outbound.protection.outlook.com [40.93.198.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA13606A33A
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CA13606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SZ3ufG3V
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WATPF0jylaad22lx1cObgum/5PTLZDvra9w5chNtoPL5cbuyG5LF8vKY3JHtxgMIURMVJZvCvOmdLMRK97HHoUhCUz8W9Bfm99N2yUjW4Y1ilnLwdRNpLfm7iPF14pPjQ1Hk0Diq6q24s9tdG8ozv/+enlTVi9GW3u5LzkfmlTvClkhXZEzJZtmpMAM5wrDcGtiOHDBVmeUjYT9b4Ll1YSPt/HWELsH4nMAkQwRhDbURpLBDvSmXYcUR1MR+7tHJ2BKrOruczr8hoSOV63zQBvZ/mnCNJUF4a5zMzvsxE/fn4ifW5Z6RNClTlqgt08cI2P/OGkQjCfTDV3J68ytgig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xEFLP+Nvprb4NYFnlQfnz7vty0C3ZZijL6g6xhB7kE=;
 b=FZE/pUSj7rfVONAjQSxoQJ7CKoJaM5aLsWoQkGTYTaSUchHdSJHWlkwaeiiSsqsASN3/GhDlCVNGG803XL+JMYreQFOVJM3FCcDQfeS8/cZ3RRIXi+ILqDPNefbRaytIir3FDwjdvuJ1IFAiXGwCptKgt6e0omtjdOrh42U+wGJNaYypqJqUZQnSxbttoYcJjnekoUdGpst2jTeKosmWRGHO2NxaHaJls4KNyRAAy3/AlH91viQY93fjV2ykjdC0gcCAMUc4W21mE9QTIoGjrJxEbfboWTB0PvvlXAc6zM4CBmF9deyVGMlPiDgcTwEUTf4hHKvPaDbPHKFzwnsA5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xEFLP+Nvprb4NYFnlQfnz7vty0C3ZZijL6g6xhB7kE=;
 b=SZ3ufG3Vj7zpeZ88/dg3cRexpV25NhaTqE2aYK+x+ztyOKnkjCGKBJ/2OrDyJ90PVCu1PvfxR2z0EKeHLiN0l7yAQQN395aQwmLBc9I7KspfPblYMj00J3ISKL1vXog1ameCMN/P5uAPkr6G10A9OdddH62/lq19G056JmHJCmc=
Received: from MW4PR04CA0305.namprd04.prod.outlook.com (2603:10b6:303:82::10)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 08:26:52 +0000
Received: from CO1PEPF0001885D.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::4c) by MW4PR04CA0305.outlook.office365.com
 (2603:10b6:303:82::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 08:26:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001885D.mail.protection.outlook.com (10.167.249.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 08:26:51 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 02:26:41 -0600
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
	<odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [RFC PATCH v10 1/4] drm/virtio: add VIRTIO_GPU_CAPSET_ROCM capability
Date: Fri, 6 Nov 2026 16:26:22 +0800
Message-ID: <20261106082625.812860-2-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885D:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c338b7-efd7-4b24-a031-08df3bdfb56d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|261022105027099003|261021121427099003|261009223027099003|56012099006|261026121527099003|261028144727099003|261026140227099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	3s7CsOy+Kq4rNcEDyAUtZmlGReZG0NQ+Y4oYvR99zTL0XBEGmZX/Z5JTG+gQa+7sMY9P2nqb9sAkvkKxc4x7E7AR1fyuaQVtP7AYFeVszH2RQRuUf+mCaaL1pxGhqzaVCn5GMRxNM0I2FaNPHVsBpw1w55jzxOneHhi0j8jFPLTqoVHvHrtlgRrz3pMe9jNeyR4CEphEf1bY4+8999Y3Egb4jRbe3BhQcRKVS8oZktkYQp0Ii7ZlMLMtF41nukRp4VjrOoSGckkC2xLWPVpV4UFSqt2Xfk/yN+/7tKnQWvc+z1z+el4KqXp6zmhURPVD/slRMnyjWWf0oosUbrCmEcoqeT8uhSiFOu/HIHFevI/t2HHTkX090qJbGCjqw1Hb1CeZsRvok+2G4rQxk4nP6RSz/2bclda/pkUv+qrTOsdBqjraofq7J3Qrx0KOQECmZqVfTYf0ytjbsiVG/fLYlCZn4UE4WMWRF3i5M4q0R0BdMVtwVpYwpU45dfcEIrsdCvZSi7dNGVVXA7tJ/J9GtSjkXyFj0uddskmtsxGduiTq0d1AD7Ax4Bs5LYJiYCqvuerVmW4SiOqDMqKfnuKlUXKPMEhbmlV81vBMNnyA2ctP0NI8wtBCZRrptXBa9+cdWVDriwgaHw9Al32w/4b5XGRKb+lLmYryzW0jsjTQHWE1ySOU5+Z2/X0j1ZV2eXqqAMekq10ly5Prwl7WGMfFxA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(261022105027099003)(261021121427099003)(261009223027099003)(56012099006)(261026121527099003)(261028144727099003)(261026140227099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	az1UGPtLLYN7cWssVCV6HYiM5UcKfahvckl27SmxgrHTseS5mVipoDWCksIYSHd8c3WrKt92m4mYjUlhDHXNQgxFOMs6hPL3xv8udrH+a7ApnUjX+HTKXRCb6xVCb6xjIUxQpEYS9dL88MRrEm0lYR+1o/hwL/NSSgx2i6slY5X/EtSeu+4HxrUx5ODQ8GUhkRITX+/k50O7Ceh82O14HDXq56x/DzucfrAeLo2HTQIIQbBtgrClSG24Wl5Nw3MMmdEj5+0PrciFZ7TS2G3ADb+n0MUZ2VuW46PRMi4PJMbHecuosZH7YyZgfSo34CLNLk9E58Czi8LrOhCZmUo1XYLimZERsd2sSMRoPXUDLuyuuj+usC7HCnHfZfruTo6FKZwbHGkkykBleEVn0zo5AvEtzI5oDl1UxnUTdyKbYZbDXEh6McHB9KoH32U9dgVW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:26:51.6146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c338b7-efd7-4b24-a031-08df3bdfb56d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF0001885D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864

Add a new GPU capability set VIRTIO_GPU_CAPSET_ROCM to support ROCm
compute workloads in virtualized environments.

ROCm (Radeon Open Compute) is AMD's open-source software platform for
GPU compute and HPC workloads.

ID 7 is already used by the OpenCL capset (VIRCL), and gfxstream's
rutabaga_gfx has already claimed IDs 7-9 ahead of any spec or kernel
header update, so ROCm uses ID 10 to avoid a further collision. A
matching virtio-gpu specification change is in progress to register this
assignment.

Also add the matching VIRTGPU_DRM_CAPSET_ROCM alias in virtgpu_drm.h for
consistency with the other capability sets exposed through
DRM_IOCTL_VIRTGPU_GET_CAPS.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/uapi/drm/virtgpu_drm.h  | 1 +
 include/uapi/linux/virtio_gpu.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 95587e12ae..9b886e9772 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -170,6 +170,7 @@ struct drm_virtgpu_3d_wait {
 #define VIRTGPU_DRM_CAPSET_VENUS 4
 #define VIRTGPU_DRM_CAPSET_CROSS_DOMAIN 5
 #define VIRTGPU_DRM_CAPSET_DRM 6
+#define VIRTGPU_DRM_CAPSET_ROCM 10
 struct drm_virtgpu_get_caps {
 	__u32 cap_set_id;
 	__u32 cap_set_ver;
diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 4f530d9005..e22049835e 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -321,6 +321,7 @@ struct virtio_gpu_cmd_submit {
 #define VIRTIO_GPU_CAPSET_VENUS 4
 #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
 #define VIRTIO_GPU_CAPSET_DRM 6
+#define VIRTIO_GPU_CAPSET_ROCM 10
 
 /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
 struct virtio_gpu_get_capset_info {
-- 
2.34.1

