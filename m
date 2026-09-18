Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536C13B9DA2
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 02:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697543; cv=fail; b=CJAjJF0N7159uITYQfeaHWCkxMbsWWDy4junpQgkfXn2uvmF67kToLHd0qrBk3s0wUYHTKUrBoJtWzXdQjj0kCbV/MoUwVzB8TxnoqwhNKBd67X6YD26J3ofAj5MNO1wCALyQLrv/MYkdNe1fdT3i49ZHH7pZaPURdcU6oVn8oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697543; c=relaxed/simple;
	bh=jluCXE+Y9rLXUz/X/Xd8ATvDlFCJwmFvNmrA41EyH8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJ+KupGp9NjZqoxqvP/uI1xvcIfa4bSgTSbImh0CuBDCJmRRRhd3Hf8PNcxIsywErAPfdIs6r4aE97r5XrRzkf3fDiNhfIMm/rQ7AYn00TPX35ANJYzXnJLW2+qWh2Nov5xibdc3DBz8AFqVxgtzVHLuGYvLYXYRv9KfRb/0jEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1I2Ptp4d; arc=fail smtp.client-ip=52.101.52.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1I2Ptp4d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aej3aA+yLd/YqWvIVxEh0ABRaf1BN0t7JpJjQjHQ8O/eVJWL2BBUPAxyeHcIIFvvuNsXG9L0tr+0yZoVW5JEQRzEBMQhOWL2j3BvIoREKqgYouzT5FVxl9/SZgEcVQWp5ZZUPw04iLzJd4ZnJoZVnEtIC5r9DjEmGcUAs/I/VdMyhiiGBZePaM7QvspfssH65RL5OVWjTVwxE2W/I2RdrBndUE/8JLtem7NHt3kYMBonYJn+DSOZF5wdQ3nLekweZ1Vy8iYGgN4epfoZVvSYHg9yG5F4OB7P/Tjvxpi9ELw/sUYs5/jHPttlKVzEasHAdYyREac7/lM1iZ9PiBe5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPZgi3EZoiK37BEgU8VWTDJ16nfVL1aGE1DlxaQkN8A=;
 b=UT695jXiX+omeYbB+DqqM5bV2Mwd1/1OzqgZqzl0kqlS+Llwth86ac89MvWOWVgeHNi3HAnqqx6wSpOvsliNmgqxKA/WSnTCCtZ7NVvtAVLIv/x0knqEaAufa6dv/Lqu1t+r8gm1Vg/Z/zU5mbwRU3615C3gV2UNyEzw6VFHMiNsFS14IAJYR/5dQDLcP42rMNAXT3GaLAreQ18ycz9w4N9iP1UEefb03ofPYIYO6bC9Cl+YcFVgcp9tidGkLwyYKru35J5cBbazBsXDr2ywa7YG673rWrtLUtPFa6qSw4NF7516P54ofu9gCXCrHSPoe8JbETw8tYplOJJLYJreXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPZgi3EZoiK37BEgU8VWTDJ16nfVL1aGE1DlxaQkN8A=;
 b=1I2Ptp4d6oM0KcSKi/VmtuCC81jhCw2VrsgIKW7og03kjED1Wr7i+r1t3xX+aMsDuKer+M0/uxVCEONleh7asWHCG8SlwbP6D/uXcP5E14PvZO79PuEKszlI8AIsYbjC/kPZ+3bTfuUdC640qB2y4Jx9V+EPq8Ok/tWvFaW+41E=
Received: from PH1PEPF00013314.namprd07.prod.outlook.com (2603:10b6:518:1::6)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 02:12:17 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2a01:111:f403:c902::13) by PH1PEPF00013314.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 18 Sep 2026 02:12:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Fri, 18 Sep 2026 02:12:16 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 21:12:13 -0500
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
	<odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [PATCH v7 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability
Date: Fri, 18 Sep 2026 10:11:51 +0800
Message-ID: <20260918021154.1432154-2-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: f4909c2d-9738-45df-cfaa-08df152a430d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UVC9HrT59iSTOJvcUrv8ATu6I/oIzlFb/eOHNR1rpgnzCiUtvD3ZxmiAgP0tbqGNDUMx71GU1zI4JRYZ4vSaJ1KX12+i76qudQbbCg1EBYea/CSA/tVUlWm7wyYHx3GYHq6AVt4GRVQPYWHzAIg0fa2/evo4VWuhK+J226Q4ytR+Xdo7UXZf7DWjVJbRFAAjV8yAdlCTiDDBqA47AjncytN1Pc6616xc6JquwY2LKYVNiiE7vOVpM9owSyY40vOD4Lx3sEIzD7BPWHzQuyYFNjgHUoc8k6dNoiKf73uBeHdYhbr9DbCEMRVRMsC2jKZuCdp9lRYryaI+K5Z4TdIfCKcXroJDdmOF+2tmOyMdyTJP0NzFzFy6BCPSUVU1t3YvHvoD3x7AKENPAzNirffV1krkS8ThQaDviZopSuU6MEeSi9FX9oLfmYqKfgGYLhaPwZ5xS4eRCFcOJRCP5wibKkk+C/MiYmzekcqtJaLrcL+zHbVDIENTYvea7nx6FHspgCU4VnR7SlnjLRhKWu5m+zw2FNTtS3DxE87OW70jdU5vyz3gh4pg1DDJIvfvm1tHGctkS39ZTstP5jPeTv4ijmXFkW9mBlImuVRVOZaQktDfDkCKYA46WRAW9VStbvwuPFF4svJpHydrtopR6E7F/qvPKeZELbX8ZKH7PcAshliB2jZXIL6p2TRfm405UMYfdYnp4fTruygqqJWxXxJIqg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rHB5SyVfSfFM+/259p1FX5BGEg47f4iK7u7S/6H3T/APVZ/hG8kRpXl+GPobIjaHYr+Tfsb/vroyfUeISe7/h+xaMNgBpDnLfq7hrag7gB8nBUQdJHaRmjIYzl/RHLRyhH/Frdy59OEEFyU0qeNy4pJl2CQDBqV8Hj9zi39SiDg1wGdl3SUWXeQBs6DQsCTz5qhReQFLu6DXlWGoWxjGp4wSqQuUCCYMg09Q7jSX9BxtTlasS9j5GPk+hsPVVe0o2vuiw+sdNo79d0M+KR+fEzTjJqIH/1g+1gs7k+qhzf2Y8DJDCQoReK2Czl7kDT5vuJzx9C7L8CobT1IgNfjo7NCSMTTM60wB+Oykmcv4sIk7pmwiNO+CoCgMTVt/9OUr+j+HoP36fS+4KjufIq+MZUcPPRh0efdbrBLd6rG1ooOqoprqBOXbYW8d5vfjtiku
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 02:12:16.6440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4909c2d-9738-45df-cfaa-08df152a430d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341

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

