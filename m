Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD214BFE74
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640768; cv=fail; b=mk5rqvq24IPIC1f0V8tzC3khnIFdkppJK+0spBT+UFxJBiBVU4rp/hYs0i9brGvwoOu0b22S1ikRZbkplon2vzd7rJJ8GaDflJkepE+PLgA2wU+yzD9m1x510gWs/sGZcEmlGq7wXvuJJFfXk6cyvwuwjLeGh+Si4o9Ls3s0wYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640768; c=relaxed/simple;
	bh=92fvRtiYjtF+LXCaI4RctzyAbrHzI2ikD/6LPMqtbbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FclOfl0HBIo8E7hj4RQ85ndeGgkWv5E8AWZClcjAxs83PKv9q43NFG51ZolKqGfHi3pj7bPBflBp9KsbZXiYyzq0b+4VjHr/HU81/sK1v28G3CJZMugkcTRXGfIHdtywgCavt6bykYsOGdsKMtFeQ8mv1cKpsPqBlX3BUTK1bOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=InrMybxE; arc=fail smtp.client-ip=52.101.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="InrMybxE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkMYca7p52HOo8rrB/oU/QCO/5i1vEQMNObwpzHRUDvYmn5pm+Mdoe7YXLlMgbG0E/FTM0yE6XyDfMJZ3xxXLQXoOzjdHVdSLdoOStFQlGLdICU0yAbZwUXFg8BrUc4B1RQle5a3faJO6H+FcsPWfExbSBnC87dDjEijgJl+jNs++589fAgevfIE8C8320wB0Kuide+NKLK1Dt++3NmTmf32AOdC0Y2CIVMXSqoqr9LzGDPym2HBRm/da+p8cZC6rjWJfFYKBGifiDZS8A8Ut+7kjfSkWyQUSiuVzl6t/9RrhlBZrSQ+qGqW++2mALJZYH40/RpdTO/hXWyYaHH7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5puHwNPs39x6Kv8ohvhndSNHE+f6Fnl4I5ZE9SOHsrg=;
 b=aRe4BGqyNQHcLqs2jTPxxL4qUWijgsoaVdj59PBzNUyRAe9FnNIurG06V01RC90An7sjE61Dhh4mozLMmNNIncTMQmLCDlK+c9oF+TVOIkJs1l/lcjUndrTYdaT99k62aJ/+aJXzfZoKCFnRD/MZ17OJNfHxh3weYy/aGBFNyk7LzjJc32YBTSXuz6icrUGNCd7xc3oieRDLrx/t+GFSMj3meMxPYAhoNIJasFFfGSZSMV1kkSkplU9xDZlwOHGiTcgU336JAQR6oT8Ye9Aks5l2y4i785B/LjQoEr2ZJbEGh8cz0b7Y2IbGrUcNqAjw7H8cLd5hwTIFSKEAl6nM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5puHwNPs39x6Kv8ohvhndSNHE+f6Fnl4I5ZE9SOHsrg=;
 b=InrMybxEvD2AFQzqsFSMUy691qICstHAUQ2ZecQLUbji+8/ENQ2OIQy0n5pVIwBLcrnklTZBl4dRNXfYJdxJJlVrBQC7I2jC1cBbqHOC0fWciFzbSiOyX1e2oSFeCmlqlV+kPXX9v3H9Shj302J4gw4YckLiWBWnpQ+52ekUfhI=
Received: from CP5P284CA0231.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:22e::9)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Thu, 17 Sep
 2026 10:26:01 +0000
Received: from BN7PEPF000000AA.namprd05.prod.outlook.com
 (2603:10d6:103:22e:cafe::8d) by CP5P284CA0231.outlook.office365.com
 (2603:10d6:103:22e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 10:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000AA.mail.protection.outlook.com (10.167.245.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 10:26:00 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 05:25:57 -0500
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
	<odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/4] drm/virtgpu api: add blob userptr resource
Date: Thu, 17 Sep 2026 18:25:38 +0800
Message-ID: <20260917102540.1312102-3-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917102540.1312102-1-honghuan@amd.com>
References: <20260917102540.1312102-1-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000AA:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6472d2-132d-4b11-40b3-08df14a6119d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jy0L+pJBRmjdpX90B+8HCe5ormhdSRVvkCuhjjSBjrCgdDWyU1GiFyC+ZS0SVcu/9+LN/YUD+RVq9bH7yowjegtGMiQbbvR2nJRRDR5D0piNWUlnapXvE+DUxmR81T8LX7QBJ6xXe16SM9AV+o84q0Cge7PyIBtPjOLr/sDXDtgzpRAvzhdPJE5YUWOYVaXxgFk2JDx2gImnB3+EpXlzkYO+e1MDFFrknfWWe01zsnpAK5pVvrUIwLXmrk0qmV4YK4UeDGnCh8t2zYOY9ZLbHdhGiga1Knj2xjQGjnQdaJszhKxy2+R/jkaHDEUsE7pYZZ5LOWljtLFOICYKsEH289N74x+dlYQ3/untK1HX4VU6YR1RXjD4QQYHVI2toDoxULvh64ggsVB9xOtrUKJ1ni047TtCTDlOtX6gSPUzhpAsufSu6seGfnxxE0YyI5eU5kxHbBPtIXVW3vPSgRO5aI223rkXsFISnC14eHhBYmdjB06wh6ehN6zbz0rT6ISPOvxh84g0eWfeBmOzMBFB39DW1fIL9h0al33NpkWiq2OeHbMRqglNahXF/DO5tjkJyM+hGFNnnz1zsqy2z5pG9iY1E4H1CvUgAl4czBlogjXTN2Z/RNjAF0uOYcTYU09adzntOYPm45DZm1mPc4UQ5cuvPAjBKZoTWgSMtNSU54kFNYtkhBawtN2wWyh5N483cCpWJwopsxG4KILU6pwdTA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Sj/bv76LErY/gGUVI40CBL8dhvcO6J1K4s9eidWCVwXfe7PcD+hSzCJ0jNr4o3We9ebGd+D+snNqGR8wbvgaeVTwPiSV52fGUU922Jh/hba7+njG0D/Xia1jfTFI2HcdOA0MbWycGwyuJDy+/hvHpS7Ft3r2nAqJ+AOY42fJNFYa5F7CNi8zwY3w9U8Qk7Qi/rUw7qmpHNDNjLskCGeRfEIy+1AFuAZQ3agIWdTyNc53fvq6x1zV6EJ4Wi8CZaqxUfV8TVRwpacr1mtDQHvoTyKqUA2A+Luo0dbvxSAPVs4fpVH+Jd0NdAPOaqftSMYAFYRJBj+Da3ZYHB2G/WBFYF7onxLVkF6N/DllxA7nmccsKZXmzMODw9WgP6pO/Z431x6FkHlj+tvrIAwey04NfyZOOlz6AOTCCVIVXDd5YM87FtG+cxzetzz5MUOU4tBS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:26:00.2120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6472d2-132d-4b11-40b3-08df14a6119d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000AA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750

From: Honglei Huang <Honglei1.Huang@amd.com>

Add DRM ioctl flags and a userptr address field so userspace can
request a blob backed by an existing process mapping.

UAPI changes:
- Add guest-only VIRTGPU_BLOB_FLAG_USE_USERPTR and
  VIRTGPU_BLOB_FLAG_USERPTR_RDONLY flags
- Add a userptr field to drm_virtgpu_resource_create_blob

These flags select guest pin behavior in the ioctl. They are not
part of the virtio CREATE_BLOB wire ABI.

Signed-off-by: Honglei Huang <Honglei1.Huang@amd.com>
---
 include/uapi/drm/virtgpu_drm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 95587e12ae..6171b4e230 100644
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
@@ -205,6 +208,13 @@ struct drm_virtgpu_resource_create_blob {
 #define DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING        0x0001
 	__u32 blob_hints;
 	__u32 pad2;
+
+	/*
+	 * userptr: guest userspace memory address for VIRTGPU_BLOB_FLAG_USE_USERPTR.
+	 * Must be 0 if VIRTGPU_BLOB_FLAG_USE_USERPTR is not set.
+	 * The driver will pin the user pages and allow the host to access them.
+	 */
+	__u64 userptr;
 };
 
 #define VIRTGPU_CONTEXT_PARAM_CAPSET_ID       0x0001
-- 
2.34.1

