Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7072EDD76
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933580; cv=fail; b=HRB3+QBW6Lq06rTgPciXLVULuUuLVSeG8sRFbINpDxowsmbuKHEyB3LPNkZv6WtLocSOIdmAyUp9KY8bHLiPLlvQ6QV6FZuhHz+UO+bRpbFXh57qXjswpzPCbKXMbRqkk/gMY2MVTDRHH4BQXb4EzAUzLhX/zfNpdG2wTS9/8jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933580; c=relaxed/simple;
	bh=DBhfl0uPswn+FOMYCzkwWURgSHPPtX9lLHwCL6LcO4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXGcL8ylJg+/ERj23WHZ2PfMuYSeslB1Vx9He71ro7iGEjP6kM73n/ugdXNylnP8+L3GucJgeTOad+JVXZwWPJ/vrxQFZuB5+viVu7QpoXQFGdQ8l+9jI1VdSoBuI9XmX9lOLEhlc1Gk8zgGS7NAelCzToZ/zSDUplPCnHAQ+LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZyNF6Sey; arc=fail smtp.client-ip=40.107.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZyNF6Sey"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7dvph7hgufFkV1QmMjebqp60oE1xb7IKdXWEOTKYzYnrH3IP4zYXn62Dq2o5FvvloAdVhVEd+RfS1ImyzHZJ+jd1rXWSA+iNZ9L/6hoHExODtcHsi25oMnjbF4xNOjvkOhd4ROy3BJ8AJKrEMQEY4WHWI5eZqkdqc/1GDj6yYmnS/5beSIontC383NMeyHONRwwUa/rIfLLGAGS+XOUQzAcfADAXq9FV4tTD16SYCW03ZvFnmGMgmpKhae8Pc7LGKwyPWPFwuexcHY7xMlY/D3pnFwCMoZpxdDzwR+m2hVTOHRlPg/zZITNjHrnJZp3XzKfZGAv2YchmSSxnRBNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAB4z7D0Douu6kwMFotEfPhw+YDECGlRnMWK8lH5738=;
 b=O9vMIlrwtiYiOS26CtJ8gLsR3scDHQK7ZkwvzoB0FzE851Mk8Uywo2WYvt2NPOlJ5NOKA0j6djC1Tsx/59qXaWYuV3pNKKozVrm0hJhv9PVKJzryO99gdnWKKH+T1PekW3wrJPhT4r2LSZEiUyj2oS2VPRqlgn1FVjsW+u2yDnPDjVMns5Yeo0If946m/zva1KXkX80CPqAle0u+x80Pqm+OSN00PLn/X9XmlGQlnYiVEXZyMMM4KmuGYP53i7hyasNsoEIowtZZM7XXjbLih1HCPeiFLoUsGPspWaLlGW9+N7EEQqn6QzGO4Go2uQ3cS6afgcBBbnAUjjpnNAI4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAB4z7D0Douu6kwMFotEfPhw+YDECGlRnMWK8lH5738=;
 b=ZyNF6Sey+SqUuwgF1dGKzKFCTyEzSitjhV3if15EvgXma7iw6NfS4x0rwJQIlvdXSsHjLj5G/1VOUTdUoX9LmpHfIRSGuC38oBrFb1iFwHexYvnMViDGF7CNeZmvWTJ/iUtnEWFvy2t5e+WvSxr3oUHubSblIg1vUX0BObP6gYg=
Received: from CY5PR15CA0053.namprd15.prod.outlook.com (2603:10b6:930:1b::30)
 by CH1PPFC596BECF8.namprd12.prod.outlook.com (2603:10b6:61f:fc00::621) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 07:46:11 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:1b:cafe::d8) by CY5PR15CA0053.outlook.office365.com
 (2603:10b6:930:1b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 07:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 07:46:10 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 23:46:06 -0800
From: Honglei Huang <honglei1.huang@amd.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
	<Ray.Huang@amd.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, <dri-devel@lists.freedesktop.org>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Honglei
 Huang" <Honglei1.Huang@amd.com>
Subject: [PATCH 1/6] virtio-gpu api: add HSAKMT context
Date: Wed, 12 Nov 2025 15:45:43 +0800
Message-ID: <20251112074548.3718563-2-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112074548.3718563-1-honglei1.huang@amd.com>
References: <20251112074548.3718563-1-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CH1PPFC596BECF8:EE_
X-MS-Office365-Filtering-Correlation-Id: 783fdfa9-be00-4be6-f652-08de21bf8c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LU3TON7kVlwRHQMSOS/npYMlaTwRCLQGqWxijohMYHKgKkNgfscG+Uxk2nmO?=
 =?us-ascii?Q?ON1qG4daNyuNsf7mNcIpXGM1UO5aYWIZgnJQYXJfdXKVTIm8Lz+JBdSFrOjN?=
 =?us-ascii?Q?qwVbjNRfXMi0iDj8am1g2aupczZ3sKghrlPA0nqkh/sOFM21Pbl9dT+ypGJq?=
 =?us-ascii?Q?oGOEI2X882IApyD4UZ1zkj3VPxAUeBndF2SRO6gdOhJnsqeAb8SyaU1Wc3k0?=
 =?us-ascii?Q?TlgiK5Lv8EArntjbM1ppWzwR5DOyJLkYnk9dPOufWQRZLmVwAgoS2GvDD6OA?=
 =?us-ascii?Q?X/TtqMx56bxWkiVQLGQqFyLk+c+xxwhX5w5lTNwQzn0CA1HLrqAlw65NX3Os?=
 =?us-ascii?Q?9V3P5IUCq0m7pHDzAAZY05cUxV3Q+uLMQSEwRieeM5c66wFnMZEgnNxHF3vx?=
 =?us-ascii?Q?ns0iAxXryqXwNss+8rVyiC2T3V/HONNfiVKBYJoubz23LEZWWaZHSbznmBh7?=
 =?us-ascii?Q?ZGxurzvnrAT1hgVlJnul5UYsyiJ7u+8ReB/1+vGE4u/BsRWV72t5Z6S0VKvF?=
 =?us-ascii?Q?+xIDzFVIP28PBU2iwQ4RftNj/nbh5dDJDHCocUKgyqaLu/nqPX6r92OlKsMx?=
 =?us-ascii?Q?k8byu7qBMmbXBh3d8DGHl6Yb0ov68MD067w/SNzHCgrTC2egyOQinR5xG8mE?=
 =?us-ascii?Q?gNhUL3aiZWSSwvmI1+vBYVxnUHhdmFRTvW4P5zV6U5hwo23WiYtG+m4bYKej?=
 =?us-ascii?Q?ryFSj3UI52e7CVclKXOGue51UTCamBymGyBioZiHSQZS74Uw/pJzEctELa3p?=
 =?us-ascii?Q?E84bs+jUHbdZ303ROSwarrfv31v51MV1deuLnUOMFPrhkVumongmkOrzwK+m?=
 =?us-ascii?Q?B2UwCo8g/xmDioqGrbbSmR/xID8e9zy91lwCFtqT4MZo65vvbQdNqZrF/NGu?=
 =?us-ascii?Q?rO/k9/zBacdYKf44aEoN0LPMpZx388TL8DSFYIwmUBrPXN4kW0s+Yeg97Z+l?=
 =?us-ascii?Q?JFhiG9BuUMQPg5QSRtl5b+qnXkpNrIRousTnvOu72A/iSDpcdB9/D9E13W0e?=
 =?us-ascii?Q?JDH/4qYxwzo+tvNqUwwO/MzhGg4Swxq/jSj0gjpzU8rvHUq/p9RpLGvw7QC4?=
 =?us-ascii?Q?Jw6pgfcTAtFsZCxMDJdT7NQFSttCiXr5/WM/upRBiYVVzM3PniNw3hHzFlIx?=
 =?us-ascii?Q?SHcBEqsbJ9bQMvGEuEp97Af0N1K5qwaZLNf+iLVe2VEsWuRDgQ6QpakJA25n?=
 =?us-ascii?Q?S6lZD9QUX97aLekVH13FHxGE8V7XpL3yZDZ7oF1o+BSvI6o/G3oLp8vIsWmS?=
 =?us-ascii?Q?pAMFuUcvQfNtSLwD4pbH70EVbvKU8wDCjXsprf0KMx38x+ttt6u/GxlB+Uzv?=
 =?us-ascii?Q?3bdy3K62aqxOBAeLdJk8ae7/8YOsOiM3FDo6Ab3C3eYW7gD6PdkizoQX9Urs?=
 =?us-ascii?Q?wprOSGHYuoZuQgDwzMyhHukktzylbETCeqxIjC+E1q/VsXU5Wl9AAlJARivh?=
 =?us-ascii?Q?lM5JsY2w2IFGyJfv9ptbfefKifV3TbvopbZRayJtOtDE1DEGvmij4QmU/fz8?=
 =?us-ascii?Q?i1wKS15B8hNVs092yJaAo6w+tyjUii1ADhks/NsC02unY2+VPyHV++FfOUdk?=
 =?us-ascii?Q?4y4zFMGn6X5tU53dsZM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 07:46:10.9420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 783fdfa9-be00-4be6-f652-08de21bf8c58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC596BECF8

From: Honglei Huang <Honglei1.Huang@amd.com>

Add a new context named HSAKMT for compute use case.

- The capset VIRTIO_GPU_CAPSET_HSAKMT used for context init,
in this series patches only HSAKMT context can use the userptr
feature. HSAKMT is a GPU compute library in HSA stack, like
the role libdrm in mesa stack.

Signed-off-by: Honglei Huang <Honglei1.Huang@amd.com>
---
 include/uapi/linux/virtio_gpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index be109777d10d..30f5e1a9f03d 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -313,6 +313,7 @@ struct virtio_gpu_cmd_submit {
 #define VIRTIO_GPU_CAPSET_VENUS 4
 #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
 #define VIRTIO_GPU_CAPSET_DRM 6
+#define VIRTIO_GPU_CAPSET_HSAKMT 8
 
 /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
 struct virtio_gpu_get_capset_info {
-- 
2.34.1

