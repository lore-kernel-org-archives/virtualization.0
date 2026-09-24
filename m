Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77DF381AE3
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259790; cv=fail; b=VSgAPWFsirNVxY+u9Q0M8VZVO+klt904GiYI1LIxOipZ31Sh5GErB4ABedYxiVg3OfTFY/MbkhKDzi5azjNakvHrqfXcddG11vWX5rlzGDCnaIS8gHByTCqvnoolKQq2g+1o3MMliUzkgIcFi6oceZGLa0oe0hi0udViTYw+K9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259790; c=relaxed/simple;
	bh=R0fb69MbrKuMpX+lPTUDfVE9cGNQY1m4AlUv787rsvA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tfDJllpsYGhw4KaBF/e1m9/rD3qyfUoJ+un8736usqVM651w56ba6WhpVDgkIgcsncDpJQAp1xDlz23I4gqbFqIXmJBl/yTAxtZroXRpOJZOE9fokxaREBnhi4+t3zstXnAttymAH3fPhyqJerxuH8jt+WJB5+wLwvRYQaT9ZIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DNTAcsDm; arc=fail smtp.client-ip=52.101.85.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DNTAcsDm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIy4BZM+ngyU1k8LAqYs1Kqf/M0TgSmsK4yf0w2rUTVJwVHrhvl/ZAwf9nRenPuyBbnVlxyCYqhYI6Jm/XAAON2bEs0MmUe8JhzlbNNBYrBJpqIYNJcOuec0+Gdb1Sc/3iN3imYd5RnQFJBBUdTr97ApYCHF9fC2GE3sHd9r4ZsaUhThsSHnFh5NGE5KjE4FZzNFJlYxGGpv+2WEYUl6pkvKIHLIAv+uNNMXGhNOu7mGWcVuLd+bwBhGLghL3De+rfrkhemHGOOersnplJ4yUDtNBY9cM1I6dXlyTadJFMhpvYcX+2dH481c5ADVQvQrqZxphaQraqYLn3BaXePJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHigaZcoTQAlZdsLbau/IFWFIFgOiK6sNVWHc2zvf1c=;
 b=JEZXrkwmxOG630EJYA9IayTKDXGf4XIJuxycuNHaxVZlvtPGLQPdPqzj/LBhLIe9XrhJDoYqhOIQSZHji57tgfgVSxrW2vAPOSXbsi3ow851DdAvKdaUAP7PREoI7f26zyUNvwJaVVRasQxVkT+2oBkPBNJXE0pS2k1TmECtQRNy7Y41CnXL1SZ9PewfJXUk51MjyBuCKuwR0tP54PiFKbVMsrQsNv+n3nlgiPp1SDJvy0WhvC5jcMDh9P5mmslh0lC+s2oqs8zFiSXztYL4nSNAlNYgH/9ziCwVa9GIoN4AM24hj2ZQGNTz7B4HegbgQyHqqk+op7Y2O8OGkdJQCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHigaZcoTQAlZdsLbau/IFWFIFgOiK6sNVWHc2zvf1c=;
 b=DNTAcsDmL9wrets6NgannombxLM55omvzQRAX9HkFzz67e9ZX4ife3C2bZU22M/ZxN8Pgy98K35FP6++Pkcd9bLNxh34pfeNSvhrt93CdM6YMa+5H2sih7xOl9uxtlCqEibMIb80nImPOVoqo2kxjcSvcJs3fkbpQta2aMtK+WI=
Received: from SJ0PR13CA0218.namprd13.prod.outlook.com (2603:10b6:a03:2c1::13)
 by SA3PR12MB8801.namprd12.prod.outlook.com (2603:10b6:806:312::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Thu, 24 Sep
 2026 14:22:56 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::34) by SJ0PR13CA0218.outlook.office365.com
 (2603:10b6:a03:2c1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Thu,
 24 Sep 2026 14:22:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 14:22:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 09:22:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 09:22:54 -0500
Received: from localhost.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 09:22:51 -0500
From: Baorui.Liu <baorliu@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <virtualization@lists.linux.dev>, <airlied@redhat.com>,
	<kraxel@redhat.com>, <dmitry.osipenko@collabora.com>,
	<gurchetansingh@chromium.org>, <olvaffe@gmail.com>, <lili.gong@amd.com>,
	"Baorui . Liu" <baorliu@amd.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/virtio: add overlay plane format support
Date: Thu, 24 Sep 2026 22:22:42 +0800
Message-ID: <20260924142242.676-1-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|SA3PR12MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: c42fda3a-ff31-4f8f-48de-08df1a47539f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|36860700016|82310400026|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	7quCEq5+C5ThnuqK5yTl9LbDVLbb51hgMWRadYbIUvxtUF31ri2ycwHQXM46ZyzpOOXiJsYaNWFHeSo6SD5q0C0Hsfcb/wGPMYTWVm6i5H5ZjsL9yEBKFAjpt7YyQ9xkPpWR9875UYsFTEDm9ZGW9EBn3/UhM6sfl8cIXJPyBxcbwcX9VduuCZRZGJMc6sILcxUlP6w7WTRroWYpf1fP3qMgNeD8XzamC+Y1gOaDS+OXxwWO3tvP3D5NFr7w7vYmz1riXlrWQPR0pQfSJQiZkjZ/vHezWeLYyLNhUhSPVueO1mGdMxPGcZMEc6TFDHjOQMGo9uF3qgDSxsppPVH0uBuL75erjp5j2Zzhj9z7e6ff7g+zOm1oGU0ffdPoZ02udbvmIdlyCp/OtR49IeSsR08ORxFPEmRu6fB+LT+fLgz+yZFUY9j86S0Y3GHl6KNBVWJIIITm4yhxduIGxmks/xW5AD2RmiK1OctEDAUuBuCOmP3LwSv//F5jcatOzzRLCeO77XF7Du+kYkEHHrYS6LogoueIPe730sDG5FBsU/SbtqtcnsieFnZDYb+9UwePuR4WhjE0knu+gvdAsSVWPwRPezxPIg7FWR19I9u2XfHyNSE4+iCBKZyx5V2cVPaQxHFZziEJfh/4o/oM4ENIrhLb/Vi9xsYrFcaivYRcj7E72kiKcoM9wS6N1NaL95krMACyEOtOSQruBhDpM1SZVQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1lxHslYmO0SaoNAoXTl/sf6ssahtJ9MSt4KC8SZ1L97//iROynaQGUV3IwTkbLFCiLAxKM0noD3a8Ba6RT3XuFWDRDFCmTNHCFtm5GqdwMQBg+uhd8UD5RUekaVPP3lRqhWaZuQu15htCOtNyfsE6f/3PvchbzF0JZO0Z7ol33S91p/h1QHWdn2EuocXXwb8vufn+0o1hzhClERcAr7tp5OoUTANgiIhtTnEPdihTmFLruHFc4haX2g3lR0sDxyCymQtGR1dDpItSXXzuj1QeeZdSanECNFYTjbo9GmlKUvmivyicmKzAxqJInBcInNEuJbkcxAdLzzOQf0x+ydxMkJ1jOpLOX+BikKWVEFxvM7cZr435rhBKsXUG590es2NG+3VNaDPmPpnIvAHP1oa6NODqPRX/SYDKv+un6fYSw59nkbsjVnRQ2KEJe6fu8wF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 14:22:55.6567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c42fda3a-ff31-4f8f-48de-08df1a47539f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8801

From: Sophia Gong <lili.gong@amd.com>

Advertise additional pixel formats for virtio-gpu overlay planes so a
userspace compositor can use KMS overlay composition instead of
falling back to GPU composition.

Handle DRM_PLANE_TYPE_OVERLAY in virtio_gpu_plane_init() with a
dedicated format list, and reuse the primary plane update path for
overlay scanout.

Signed-off-by: Sophia Gong <lili.gong@amd.com>
Signed-off-by: Baorui.Liu <baorliu@amd.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 29e4b458ae57..23ca880692f1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -41,6 +41,21 @@ static const uint32_t virtio_gpu_cursor_formats[] = {
 	DRM_FORMAT_HOST_ARGB8888,
 };
 
+static const uint32_t virtio_gpu_overlay_formats[] = {
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_RGBX8888,
+	DRM_FORMAT_RGBA8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_XRGB2101010,
+	DRM_FORMAT_BGRX1010102,
+	DRM_FORMAT_NV12,
+	DRM_FORMAT_P010,
+};
+
 uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
 {
 	uint32_t format;
@@ -572,6 +587,13 @@ static const struct drm_plane_helper_funcs virtio_gpu_cursor_helper_funcs = {
 	.atomic_update		= virtio_gpu_cursor_plane_update,
 };
 
+static const struct drm_plane_helper_funcs virtio_gpu_overlay_helper_funcs = {
+	.prepare_fb		= virtio_gpu_plane_prepare_fb,
+	.cleanup_fb		= virtio_gpu_plane_cleanup_fb,
+	.atomic_check		= virtio_gpu_plane_atomic_check,
+	.atomic_update		= virtio_gpu_primary_plane_update,
+};
+
 struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
 					enum drm_plane_type type,
 					int index)
@@ -586,6 +608,10 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
 		formats = virtio_gpu_cursor_formats;
 		nformats = ARRAY_SIZE(virtio_gpu_cursor_formats);
 		funcs = &virtio_gpu_cursor_helper_funcs;
+	} else if (type == DRM_PLANE_TYPE_OVERLAY) {
+		formats = virtio_gpu_overlay_formats;
+		nformats = ARRAY_SIZE(virtio_gpu_overlay_formats);
+		funcs = &virtio_gpu_overlay_helper_funcs;
 	} else {
 		formats = virtio_gpu_formats;
 		nformats = ARRAY_SIZE(virtio_gpu_formats);
-- 
2.25.1

