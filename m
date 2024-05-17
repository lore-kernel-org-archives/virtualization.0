Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0E66A005
	for <virtualization@lists.linux.dev>; Fri, 17 May 2024 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972729; cv=fail; b=Uh29JQTgj6dCfnbPF87HQQKC90vO4AgXNeW4CVWL/t+fyDSieVkqkAmDbI2sArtMh4EMT+gVwMvjFlL2LM+4jUth5SUkKO+qTRgjMGRT/IqOR80onAe/Iwzp9g7Xrqf2hqBOsv6eTFWgVZA2YfNmb8l3/4fzi/efzVsvjYJlU+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972729; c=relaxed/simple;
	bh=8K9OzoQ8QirLRIEyKa36HCfgJlklHzu4X+dim0/2qNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsX86mIdl9FEGkOAkm2FF+UcTWObnaJednFokhLWWNsd1mTDg5k+qhLsV1LtcRc51gr3pNTwWNEKxHiA08ffKetM3SFjZfM+qn5w08LvDcRI1zlSXNYSVqFIzu3+qecG4aTbAH97QWJjM1OiQXC+olonlsuc9BH8bdyhvB1k+Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RCAphEn9; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RCAphEn9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcNdJQUJytGhvhu6tOu+6MYBbijiaBCzE3aYAyE918jVzANLgf480tHblmJiRo+3kNeRPO2UJeS+0mHkP8paAo2j0N8lsJMzXxJLo/J3hl8MEpVmqc1wMUD+t2g5xOkl1h/ZbfUv9HaZnZeLaToyAnL+XgqCOAhUH40NYg2LAjwkk8I04P0yI+0nYMRFAx7xNeqGaSyASpaH1hl8tK8xY07gG1QFH1RZmHVNxD1SGbxx07gqmAv0Kh2hC1PstnjmYxhAxIRdYKmJlzIMpirxl4sJUuEXs0SPHM3VlSoxhMf5JD/4dk62s9YuNr3AU4JVmBrj6Zlbiyprb7DjWAPDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ei4l5KFiQE/5BYvbjn3dfVq7ywFkeENkFU5iPcmuLdU=;
 b=Pg0bC4Qh83eAQspvt53V2ok6HnytmYUR74pZQdpQiJo4UfB113duGbQADfThX4Ij6pDrVzQHc2zjForIAsKnbw7dYJGXe91VrUXFwWqh9amPbO1Wo7HEufQlxJg5IaMGF4E7DSav7GPG8CE6seUX3rmASt/WWbHuCa5zzyZBKzY+BdPA5T2JQgXkfQ7WDHMQ2HRGwrk4Xz5XDHHGiH8mdyt1NjjXtaXHDpBth5NOJTXLilyuJ2ZzNOba7qGfbsu5xfB7MqyPadphM7xWNhJIWdhss5O9kbDB63ESOIYeN0KwjVsSQK4U6mIO2LiCqHY8aJQEAoxx4m9vyHnS3BB0iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ei4l5KFiQE/5BYvbjn3dfVq7ywFkeENkFU5iPcmuLdU=;
 b=RCAphEn9rwuMvNSqnxH7KMwc/m0v0cD+2W+6xg6Lw46dLTHO1Pib+OsEi8sE1vskXs/SBY8Vn6672HzzUdwS+H8sz6BuLahpsojbvRi5gdNQkbxwlHuf+jOj0kJgr1qT8HiSFsjGwM5PP/dXkPHKsX90WTibemL1FIoW7TYzVTcZOoZkLhyv66Yzfe/RC+67xsaBrViHlrIat27xRKW6VoftLAjIUB6K/AH/vXAFlPZnffqUP2daPPKtgtbs6/W2CB6q86skDAqCokODMu8azmGuukCdsXHrJGLXMitqH81240NKiqgq46fO7XtteAdTlZPyp+ysmDscN4UaRmg0mA==
Received: from BLAPR05CA0047.namprd05.prod.outlook.com (2603:10b6:208:335::28)
 by IA1PR12MB6331.namprd12.prod.outlook.com (2603:10b6:208:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 17 May
 2024 19:05:23 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::fd) by BLAPR05CA0047.outlook.office365.com
 (2603:10b6:208:335::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.13 via Frontend
 Transport; Fri, 17 May 2024 19:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Fri, 17 May 2024 19:05:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 May
 2024 12:05:10 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 17 May 2024 12:05:10 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 17 May 2024 12:05:06 -0700
From: Peter-Jan Gootzen <pgootzen@nvidia.com>
To: <virtualization@lists.linux.dev>, <vgoyal@redhat.com>,
	<stefanha@redhat.com>, <miklos@szeredi.hu>
CC: <mst@redhat.com>, <dgilbert@redhat.com>, <yorayz@nvidia.com>,
	<mgurtovoy@nvidia.com>, Peter-Jan Gootzen <pgootzen@nvidia.com>
Subject: [PATCH 1/2] virtio-fs: let -ENOMEM bubble up or burst gently
Date: Fri, 17 May 2024 21:04:34 +0200
Message-ID: <20240517190435.152096-2-pgootzen@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517190435.152096-1-pgootzen@nvidia.com>
References: <20240517190435.152096-1-pgootzen@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|IA1PR12MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d864e8-d77f-414f-8712-08dc76a44e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZxsLU7/1gFTA3p5K5qTfKGJAS8eNuuqq36Hlfjqk7FjEl7Agvh9D3AhANyk5?=
 =?us-ascii?Q?Lt72XmeKOQro5BkAFVXk8YYVQ3OoGXsWJaioyiXePkRzr24Ho0JJk6yg+3M9?=
 =?us-ascii?Q?3LldwS6vX5jp7Kmlm/8mBrlT5brLRLATASI5PuSnj0W/CgVgkA807YV0gMlY?=
 =?us-ascii?Q?3LtvaiNll3uDmHHAlQDe74hcgQt4bwhOj6yFoBfoijpFb7MjldH4I2fVEvsh?=
 =?us-ascii?Q?MHqfzhsXfLcwKpl1JSu3+0w7GyVujLbTp4o6sfJjSNVaktncXJWhPYvdJBLP?=
 =?us-ascii?Q?+BgG6QHJkPeTT6DWrIlRg7hjvd4Gi6+2yqXFUOHCrHrbKbAz2sgflfq/NYV7?=
 =?us-ascii?Q?2xaWXXWp8GDVXYoXyt53Vp8pLKvQSTtQeHpLSgsHg95VdYll61ia9w1y61xo?=
 =?us-ascii?Q?gpLNhlP5JYSmU3E6PTZ8k3axSQZoqhHoxjEnIfmyViT7ZUfUwv8f6Lm0I+oG?=
 =?us-ascii?Q?dFLvm6cJYf2Zmk5Pr+gNuErFYRUBtbm1NTu72ZrKX/rBdLo0G5qZpYCvVtH1?=
 =?us-ascii?Q?4gACIlZwgtwHw/JOGVry6NCuZ3sTa71HL0czX/WwDSoyMd9A71Xqmq4alFrc?=
 =?us-ascii?Q?X9dbyVKLMHeJyhVcSUKuW5Y3uYh1geauFS3UY+sTTdvpnQzhJB8V8j1Lw66O?=
 =?us-ascii?Q?c3WQaOuzoo0b+2cytmytAGRRAi205qplDeH05+jEiE5RF6MTLOqO1chHjUgg?=
 =?us-ascii?Q?Kh9M15QnS+wuNq3VCPggPfkc7bzdC0ZS2SlauonYXSE+bc3qHGp0mXi5tp7Y?=
 =?us-ascii?Q?VgCFyG86Nhj7MhfeCfA5/kvwbNurAY0dGVIAJwVZagDmd9RsCUxCfQ69WzRd?=
 =?us-ascii?Q?Z9f42wuht3cfQz4o7+K6RaIOUBmo1jExaMC3yqGnBp3Jyv/lE6cI7GIMBpHy?=
 =?us-ascii?Q?rYGvbPv2kNWrNiLOs1RyFNeWx46/wO/AHr8ScD5rH0ZfUWDNeUHFoIfPwJwN?=
 =?us-ascii?Q?Eiqo/7Afhig7hFRzpIyvTy9YWDBcpb7VEShNKmpjkr7Y0fiKLUX/xWZW5fjL?=
 =?us-ascii?Q?DOqJlKVa79TEnKkC7r+1ae6Pht22RcESoDtopANihPTlAfLIFPtGw0GlvlMV?=
 =?us-ascii?Q?tqP5ifyBgqEi2Jjv3Ql0DNy0/RcBNk7CZByIhh30z2hzTdJX0xqlyaGvuuoq?=
 =?us-ascii?Q?ja3F1YTp2rDGGgH2BOsNarFfeSlHPo6qqDvDeyN8awQHvPWoXVjLw3NlVJYq?=
 =?us-ascii?Q?FaXeRAImPI2/qIs0NHf5z2JgCh2aWh0wePT223TswE9a/1+/QufWb85qVRWZ?=
 =?us-ascii?Q?b7lhroD2N2FBrK/ZCSdTFJetNrYOYuzh4k3M/pvyi14rlZBgRsFd6fgo54jg?=
 =?us-ascii?Q?bt++OQSsyVgnkQum5jZc/GCHsZhd0CbJ4QQSIfGjOmKGCNiUTI//NdKye+3C?=
 =?us-ascii?Q?CkMIiMWDMtK/rfmPwpAhjsjFwmcZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 19:05:23.5427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d864e8-d77f-414f-8712-08dc76a44e21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6331

Currently, when the enqueueing of a request or forget operation fails
with -ENOMEM, the enqueueing is retried after a timeout. This patch
removes this behavior and treats -ENOMEM in these scenarios like any
other error. By bubbling up the error to user space in the case of a
request, and by dropping the operation in case of a forget. This
behavior matches that of the FUSE layer above, and also simplifies the
error handling. The latter will come in handy for upcoming patches that
optimize the retrying of operations in case of -ENOSPC.

Signed-off-by: Peter-Jan Gootzen <pgootzen@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Yoray Zack <yorayz@nvidia.com>
---
 fs/fuse/virtio_fs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 8ffa4f063a37..55126df202d6 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -447,7 +447,7 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 
 		ret = virtio_fs_enqueue_req(fsvq, req, true);
 		if (ret < 0) {
-			if (ret == -ENOMEM || ret == -ENOSPC) {
+			if (ret == -ENOSPC) {
 				spin_lock(&fsvq->lock);
 				list_add_tail(&req->list, &fsvq->queued_reqs);
 				schedule_delayed_work(&fsvq->dispatch_work,
@@ -494,7 +494,7 @@ static int send_forget_request(struct virtio_fs_vq *fsvq,
 
 	ret = virtqueue_add_outbuf(vq, &sg, 1, forget, GFP_ATOMIC);
 	if (ret < 0) {
-		if (ret == -ENOMEM || ret == -ENOSPC) {
+		if (ret == -ENOSPC) {
 			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Will try later\n",
 				 ret);
 			list_add_tail(&forget->list, &fsvq->queued_reqs);
@@ -1368,7 +1368,7 @@ __releases(fiq->lock)
 	fsvq = &fs->vqs[queue_id];
 	ret = virtio_fs_enqueue_req(fsvq, req, false);
 	if (ret < 0) {
-		if (ret == -ENOMEM || ret == -ENOSPC) {
+		if (ret == -ENOSPC) {
 			/*
 			 * Virtqueue full. Retry submission from worker
 			 * context as we might be holding fc->bg_lock.
-- 
2.34.1

