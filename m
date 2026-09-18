Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F23370ACE
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725611; cv=fail; b=VTE8SSwpu78+/XPWfrfwKUMgG2wBKHnUqL6pdDYT1UTRN7/viNqcG+vws7wEUgh/ta9znttsobU5Ib5/YBOJx/tZwm8PwCGvorou5B2c5g4TrH2mQOWZW+3x+8Gno/NQn0UhVMjQA7f57r+E6DQ2CpyFp75lKEvq/+UG7UQ8Q2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725611; c=relaxed/simple;
	bh=jluCXE+Y9rLXUz/X/Xd8ATvDlFCJwmFvNmrA41EyH8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZGlnjCJTGrDfSPu72f+RjiEnDEubkPJQaluMUGIbO5wdDxwKBevHwoTSq0xwAJJ30+RJe5UzgfZIAtz2yDNgzYr7T1g08xmoc8i2/o1pzhaatBg06AHwcXc9L8JXyuVHeYGd5IIHwMu6RHP0cuMItT2HRzCmnfvCdUJJOqaxFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ogj2cZIP; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ogj2cZIP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIJWRTcx2TadZeJgkxkcdjeTEgMWQBx+6pvKluC+/3edA4CaMVE8aAqSbWnDp9GCMX4BBk4pEgnqwl8z3X5HWW0mNS6KDGBhfRtgAtvdIPjUyy0MYYWLjnyJT25pgAh2y2HU9ZXipmGfLaOHHYs0zbnt5xZb3e6KhR8Svri/ozHlwrYkSoo+M8CcaJm585NbnkaHHfWbD6olkOLgenyT+bpc/Kc/DnT3FSLwSngxW1ZOBQGM3uUPBHAWwXCa0bzcFMDo2zpWToMd/2pam4b+bFGClU7TID4RG3q0idPGDeMRf2Lo3vHgSBpM8slbVSRy2et7L9OGehDaLH6JEPmOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPZgi3EZoiK37BEgU8VWTDJ16nfVL1aGE1DlxaQkN8A=;
 b=d7B8IIIxL/RjuvlA1eLxhPHnfS7haMqDFXnAkoW1rkxImAbgb46S0ZNrXPiK61kfh+g6RaHUbF1/O6fcYvSJreMjLJPv/Tk2IxxfJ1Q4L/tjBq9/BO89Wmc2z0shfzjZ/b7p+5mNIrG5/oLi+L+18PGGJWtQStS0KRP5g1aMFP4C52XLWvfX+GPvXuNXHss2FJbeQnDkl1PsKDgyhM81MGI9mupEHwQIhLZeowSQH6trTVI8OxYFsrSf30CFm5zfFj14R8fGN0iTfTz5wqtMV2RrF4sGRr/ji03f9CI108p6CdW4fcGOxY8ReI9dqkqneV8oDvd0nXD2R0TT3Xv3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPZgi3EZoiK37BEgU8VWTDJ16nfVL1aGE1DlxaQkN8A=;
 b=ogj2cZIP2dINMu14NNA+QLV8tDF3VVg6inkUQyLpqLUS6YbrqjrtvlWFbB15DC6o74iRAEPHOCXoCmAjJLmfuIF1wU3/mFTXvjsuA6z2q7ffmCg/Jy4wdZ2r455EZr0gUUBgejsFC3ve5YNTChnNoAHU7dI97J5I1LSqE59J/08=
Received: from SJ0PR03CA0389.namprd03.prod.outlook.com (2603:10b6:a03:3a1::34)
 by CH3PR12MB7499.namprd12.prod.outlook.com (2603:10b6:610:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 09:59:58 +0000
Received: from SJ1PEPF000037A5.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::84) by SJ0PR03CA0389.outlook.office365.com
 (2603:10b6:a03:3a1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 09:59:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A5.mail.protection.outlook.com (10.167.244.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 09:59:57 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 04:59:53 -0500
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
	<odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability
Date: Fri, 18 Sep 2026 17:59:37 +0800
Message-ID: <20260918095940.2253018-2-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A5:EE_|CH3PR12MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ccb0267-ee2c-4a2b-f664-08df156b9887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yp3AFuC0su0ZDvkJjRUKErvCJ1eCd4j8tIRkouR+7BNlTYqJ2R7oB6jK9PuIhk/CjMn4bytQADqleE54dpyk+pnHX4tEt1CjM2vACl0Gb1pMiWHAIkBtwcSz+DG/CREm2fimf8yRAw53VTqqHUjz3D17slQ36Q1HkeurAkcjOGaWwb0OfrOWP1a4ywJdrTT9N+niPH1riYYf5V3SZ0BMsKgcxmuOds1oeoGTCxi6jfi5pxB9YWErknG+TbVtNMduz8iAAVxsx6mRT6RHomlfgSiuq2an/jWTm6uhWyhaJy7n6F9ELwzv2ia8gMhJzYVjTWQpkWDjXQzE3X+OUg9uT5X18zYB6YhzSpoFF1laq3bXhT+llOK+VlJwPHxX3BsoU5NrgvHCci7CzowBApkIIQ+CB0XuD7BVeJrpNL+RASP0dnoTWU6oz+BwW2sfejTHglwvQPdwknCpjc0HLUKMvgRXtlKShyYUQKix8twWR/LEaxJ3RNDy7wsHm1vu+Jn77pi2KF19FJZ0RNmw8pY2/GV7tU+Eb8++QxHXGAPNhLSpEr1ADicGhOgPkUReXWyXLB8WcP6lP0wTx5pGolgjhYrc6lomT5yhn74uLvKsb4VLiv1DW1Xf+s9H/TOLm8V5Q8ZxfQS5V7GJ25oCHr9DouzsWXAESyXn6gfEwD2dExXCATE7GZZroTeN+vIAM2VnwWH6gNm5jSh6mX5FMuXGaQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	h0pTJcNsJYCCUMFtuMSiWfPKfXPvmUm8ypxmBmWGkUAh96L4t9Zv7BR4bwQvbHb1UgABH7FyLXznVL3L2rlCyC6tLvFFepkOzYCP2eFMt8IafLKRnUOAMAiaw6lHQcu5xsH/Nh8D7e0U3l8h3S2L3ZVhHXOQg4tuOI4ek77EnVm/mq13rHCkrMrdSZrFuhVd1hvOT+GapJG8NqL75H1JUHVHMR3s9EVHQ5vKxXATfpLu0O0UmzCHLu0aFpOnYJC24f8Kf3jZjzE5X+Cu471wrjxWx4NiCuLZFk0aFsUgOiilvdsIaPtuHi2YLbwuiwp7nrRYo/aiNlRnySyx7y+BJB13N5kZmYgvsGUBFYxtZSgXHmg1eQPmQeZp2EEG6F93I0iEgtgRKXPNf7dYcQUOVnebFtO0GN5r2eUQwL7jExKBT+3IYe49kSe6BsS6M4Yx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 09:59:57.3345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccb0267-ee2c-4a2b-f664-08df156b9887
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7499

Add a new GPU capability set VIRTIO_GPU_CAPSET_ROCM to support
ROCm compute workloads in virtualized environments.

ROCm (Radeon Open Compute) is AMD's open-source software platform
for GPU compute and HPC workloads.

ID 7 is already used by VIRCL in the virgl/virtio-gpu stack, so
ROCm uses ID 8. A matching virtio-gpu specification change is in
progress to register this assignment.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/uapi/linux/virtio_gpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 4f530d9005..3d4dfadc9d 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -321,6 +321,7 @@ struct virtio_gpu_cmd_submit {
 #define VIRTIO_GPU_CAPSET_VENUS 4
 #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
 #define VIRTIO_GPU_CAPSET_DRM 6
+#define VIRTIO_GPU_CAPSET_ROCM 8
 
 /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
 struct virtio_gpu_get_capset_info {
-- 
2.34.1

