Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5228B285CA3
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976350; cv=fail; b=FQiChgLyKCzuwH7tUiV+/INopMtJc36U0e/oigbuJ7mXHtZkuzRaNQCS0Aiu98uYcPYrFUO7aOj8wkBLNIeheW2HE5kt88UMCxEfr5agmIqaKmnOedOL0lIrYDZOs24zWgE6KRXxfX6TKIS5Js6Z0caZysJ1vBb2k+qr40/YmJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976350; c=relaxed/simple;
	bh=54690a4fxmNzyF4p8JRVhcWgM4CnhdbxYXWu4OaIRQs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fo/eGDXr906Tgz9v9N2zRWruCLdqPNTRNMzbrOUQmDSXzHVm88nzwCqn25XNFgKJi6sp3ZGxdMbQ2HrCFa+4aAHXHPjdZ9o43RoA6R6dX3SKQ9lxyDBr2HD52x6Icom1kc17+eILkdC4YQi91JnEMY5j61Nyzi8K2RF6C7LIPqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cni9hIT3; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cni9hIT3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ld+Os6PwgZ0ycG6Bhe4WsudUfJ3Bu95oFsEY43Z6FaAyNOgtj0onxSPy5NEX/RuAXmsAXQam7I3BYT9QwBt5lwwHsPzNJTcfgoEpg9Zm8Ax/zqD0XJwixBg4olZu+Pr/esCt4EUetb7as3bdVjWzrBoXvavT+yCoDLusuPw9Pc/tawq+dAwZqc3OVBv+DcFENtIN5VaLHi8FcmmMoRLxGk2esJSL0nWr4TXpjaDQn6B073Gt+tj/phaVxVgL1z3lnpcMx4vNzOEkbXz6SQbS28405IrMtXCi9T8EMoZ01rI/DjqUAlSwSa9NetBvH/tnndsS6BAOoe7MPHbFZbJqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqdKlwv//H/m7WayBPHqwv/DghaPnRKRQyEbcinEjic=;
 b=J1SYHfMfJf2LEKU03T4JrIg31gaS2dBoicuobGg0VARji/+gVDYoBNc/C2cmyLD91BQ0ZHm2mpGovJ4Dp5FeqS+oi8W2tURmL5341//tjIV5gpOGfABsfwO8PHTrlmsUeB8vhcK224sHYHhO++ZPWFM8dSg3ycuqVKiZ9zT2KFNoosmBRGuaGTaDZFKPkEtPBgoVEF2XtL0RYtjVytTXuJuO1s4nVI41xDvJuBQDaoE0/lRnSkl7tuWN/jhPLIsghiI41e22daPahaD+mkeYP7mStvQm6aZfWm9VKkdAwXThHewM0TkSSuMSIYUq8emZa/OvmeLzSr1sz8wWnmyntA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqdKlwv//H/m7WayBPHqwv/DghaPnRKRQyEbcinEjic=;
 b=cni9hIT3YewCFXk19v+RtsxtjoG/h0iZT+r6/B227hZu0dS2X/PUlFYDUyOEH+uPPQaRZxzgzdUh10Qy4QvJJe2d7RY3cKYN/aMKN0PgsF+Z3/20NHk3Q2Gr26ykLfviBHz0Ild0WwJQIyzNfjAce/FfR+/eQbbp2TvFgJPOHoOZpCX2Kfz/wCDp08xMl9glnksGrKC5MSPU1DQJ7xw7YjrvNKZzawsym4kXB+D7D4CHQ1fAxQO2jcWGnyn0rpr0rXq9v5HapGF8Ot1CsZ5uD0inLwdnUm75EX+E8FfwuvKkqqamdfysnoQdnV/EXxQAVwCYR9bz9cLvg6UrE18dCA==
Received: from MN0P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::25)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 12:05:44 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:52a:cafe::3b) by MN0P221CA0021.outlook.office365.com
 (2603:10b6:208:52a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.20 via Frontend Transport; Tue,
 8 Jul 2025 12:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 12:05:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 05:05:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Jul 2025 05:05:29 -0700
Received: from dtatulea-c3.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Jul 2025 05:05:26 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>
CC: Wenli Quan <wquan@redhat.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH vhost] vdpa/mlx5: Fix release of uninitialized resources on error path
Date: Tue, 8 Jul 2025 12:04:24 +0000
Message-ID: <20250708120424.2363354-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: fcce7813-9021-485a-9b90-08ddbe17c43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2oul0acgD9K3+xrmwTLsDUzjzEh68quXgR8MindI51bVbqxgLmlR4b07Vdd2?=
 =?us-ascii?Q?+w/QkDQQ+v8e1NBKv6BuAL+Fs3g/wHAopVMCpxxBCWdW0aWwXOOg6LiqcgEV?=
 =?us-ascii?Q?3YswjoluHLvg5psQCu6lmWz9fsx9pPBVII3UWE2qnBoavBSAb/zkmSoYbqWk?=
 =?us-ascii?Q?+tv5E/1jGM3P3Os3wh9/mXvWuquc8u+hn4GyxHApmVBNidX9qvNSeA4hSNn2?=
 =?us-ascii?Q?lCWbkuzhxAQD0qZ89+8Z5ICtsSsyGh0p2UPbsvwAIbYPtXhDu5Py56RwSnep?=
 =?us-ascii?Q?Z6ow7763435vHjkk9d9lQS+pwcdih0t/68h1TKdQAZmMOs1Xf4SQlRXQytd5?=
 =?us-ascii?Q?Lzpf2NIOnQJaojA6K/gLyvOHhEe4nMWIj7ITZ2terlLQOUcnYnMlakhJHWwS?=
 =?us-ascii?Q?rlFx351RjrxjTtubycDuJWfysaIewTyrBgELyWzH+7U8JBvNAmdvwhRfKWFd?=
 =?us-ascii?Q?Dwk7KRsz6hAgxAXtXwu3TGtPXjEeAo8vrzNcvQxhsYfmRC+b0OwnLFpl+RcM?=
 =?us-ascii?Q?2z+DNv9/k6jtG6WwJ5WN8WL8NjbIJAaxgqq1FS85xcZrrHzDTGgzdZweyTiD?=
 =?us-ascii?Q?1IueeXnYgt+p5W5f4Z7rkuoolDa9jCrhhZmw3FnBVNJn7CAAzAEodU6QJEpM?=
 =?us-ascii?Q?Rw4fC9Fp6wCtaois9/3bxFbbPs9mpiN2cC6X0qFhvdCUGwuFDXxqfziHTBet?=
 =?us-ascii?Q?IlM9oJQC1dIFb1bV8LLrR41fMIfjh6c5dKooLMeHEpJMosbV4MYNRsYA2H/V?=
 =?us-ascii?Q?Wd83JcnI9XT9zuFBs2DKdsh/zfUBHBvPocz0Ldl1h4XmMXmy1f66QDZiIENV?=
 =?us-ascii?Q?7xs4sR1ib1mhmlJG6GzUdhs3eljVVm/OZC6PkP5K53jdzWkmqfteDhJGWxVB?=
 =?us-ascii?Q?FNFUB5BBxruP4OgX4ra3pLLWVpo/GCh2V5Nf/BnADH7X4+doDCo5iXfkrT1l?=
 =?us-ascii?Q?MqPcOfIZ1VmY/vvDZbWyG+aHuMJ640A6q71AnHfFSz3WfDIakTN3aqy1Q1nt?=
 =?us-ascii?Q?WZsH1y9COjWQHGuhhXddM1JancMWFubuSDWqic511805eCTN9dDACcmOmvDW?=
 =?us-ascii?Q?cgmF/GjtJZySzPnMrDFdATzj5i7zvOm8yk2OKWBhDKnvifMgxdBRYsZC7aRS?=
 =?us-ascii?Q?EJDgNOQTMFlJyBBaL457AgIBECdE1MP7YB0FnG7HDqSRnEooXZixZoxUwlfQ?=
 =?us-ascii?Q?YGvegVXS1ccDirIK38aNfH48G8oWQ/gzBfGffxZK/JLrLCX/U1wQMcE/hV4D?=
 =?us-ascii?Q?8MR4FyMg2Nqc8EH8IW6y0R4njzrC6KaZPqRA6FkgmW6B6dFz2Pg5mmUzyxsU?=
 =?us-ascii?Q?t28e0Z2QKhgG0SLeMT5qMVIpNhe2YRWJIjjPjqIBg83w/Iv2JCZhfLj8xhp6?=
 =?us-ascii?Q?RP8sxkr1wEthfLkr7IsSVukejVLjXx3wQlwTLrDf+B3LXRJvQqUEqdcyncNL?=
 =?us-ascii?Q?2e8oniUKE7SSVfUBds6qbh6il5j//UTTuWO2ljUHw4cqt983zwPxd8gxK7tM?=
 =?us-ascii?Q?44Hu6tPCAJHKs1JOv803Jef7n7TkNWtn8grd?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 12:05:44.0548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcce7813-9021-485a-9b90-08ddbe17c43d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424

The commit in the fixes tag made sure that mlx5_vdpa_free()
is the single entrypoint for removing the vdpa device resources
added in mlx5_vdpa_dev_add(), even in the cleanup path of
mlx5_vdpa_dev_add().

This means that all functions from mlx5_vdpa_free() should be able to
handle uninitialized resources. This was not the case though:
mlx5_vdpa_destroy_mr_resources() and mlx5_cmd_cleanup_async_ctx()
were not able to do so. This caused the splat below when adding
a vdpa device without a MAC address.

This patch fixes these remaining issues:

- Makes mlx5_vdpa_destroy_mr_resources() return early if called on
  uninitialized resources.

- Moves mlx5_cmd_init_async_ctx() early on during device addition
  because it can't fail. This means that mlx5_cmd_cleanup_async_ctx()
  also can't fail. To mirror this, move the call site of
  mlx5_cmd_cleanup_async_ctx() in mlx5_vdpa_free().

An additional comment was added in mlx5_vdpa_free() to document
the expectations of functions called from this context.

Splat:

  mlx5_core 0000:b5:03.2: mlx5_vdpa_dev_add:3950:(pid 2306) warning: No mac address provisioned?
  ------------[ cut here ]------------
  WARNING: CPU: 13 PID: 2306 at kernel/workqueue.c:4207 __flush_work+0x9a/0xb0
  [...]
  Call Trace:
   <TASK>
   ? __try_to_del_timer_sync+0x61/0x90
   ? __timer_delete_sync+0x2b/0x40
   mlx5_vdpa_destroy_mr_resources+0x1c/0x40 [mlx5_vdpa]
   mlx5_vdpa_free+0x45/0x160 [mlx5_vdpa]
   vdpa_release_dev+0x1e/0x50 [vdpa]
   device_release+0x31/0x90
   kobject_cleanup+0x37/0x130
   mlx5_vdpa_dev_add+0x327/0x890 [mlx5_vdpa]
   vdpa_nl_cmd_dev_add_set_doit+0x2c1/0x4d0 [vdpa]
   genl_family_rcv_msg_doit+0xd8/0x130
   genl_family_rcv_msg+0x14b/0x220
   ? __pfx_vdpa_nl_cmd_dev_add_set_doit+0x10/0x10 [vdpa]
   genl_rcv_msg+0x47/0xa0
   ? __pfx_genl_rcv_msg+0x10/0x10
   netlink_rcv_skb+0x53/0x100
   genl_rcv+0x24/0x40
   netlink_unicast+0x27b/0x3b0
   netlink_sendmsg+0x1f7/0x430
   __sys_sendto+0x1fa/0x210
   ? ___pte_offset_map+0x17/0x160
   ? next_uptodate_folio+0x85/0x2b0
   ? percpu_counter_add_batch+0x51/0x90
   ? filemap_map_pages+0x515/0x660
   __x64_sys_sendto+0x20/0x30
   do_syscall_64+0x7b/0x2c0
   ? do_read_fault+0x108/0x220
   ? do_pte_missing+0x14a/0x3e0
   ? __handle_mm_fault+0x321/0x730
   ? count_memcg_events+0x13f/0x180
   ? handle_mm_fault+0x1fb/0x2d0
   ? do_user_addr_fault+0x20c/0x700
   ? syscall_exit_work+0x104/0x140
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7f0c25b0feca
  [...]
  ---[ end trace 0000000000000000 ]---

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Fixes: 83e445e64f48 ("vdpa/mlx5: Fix error path during device add")
Reported-by: Wenli Quan <wquan@redhat.com>
Closes: https://lore.kernel.org/virtualization/CADZSLS0r78HhZAStBaN1evCSoPqRJU95Lt8AqZNJ6+wwYQ6vPQ@mail.gmail.com/
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/core/mr.c       |  3 +++
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 61424342c096..c7a20278bc3c 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -908,6 +908,9 @@ void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
 {
 	struct mlx5_vdpa_mr_resources *mres = &mvdev->mres;
 
+	if (!mres->wq_gc)
+		return;
+
 	atomic_set(&mres->shutdown, 1);
 
 	flush_delayed_work(&mres->gc_dwork_ent);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index cccc49a08a1a..571d6502be59 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3432,15 +3432,17 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
 
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 
+	/* Functions called here should be able to work with
+	 * uninitialized resources.
+	 */
 	free_fixed_resources(ndev);
 	mlx5_vdpa_clean_mrs(mvdev);
 	mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
-	mlx5_cmd_cleanup_async_ctx(&mvdev->async_ctx);
-
 	if (!is_zero_ether_addr(ndev->config.mac)) {
 		pfmdev = pci_get_drvdata(pci_physfn(mvdev->mdev->pdev));
 		mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
 	}
+	mlx5_cmd_cleanup_async_ctx(&mvdev->async_ctx);
 	mlx5_vdpa_free_resources(&ndev->mvdev);
 	free_irqs(ndev);
 	kfree(ndev->event_cbs);
@@ -3888,6 +3890,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	mvdev->actual_features =
 			(device_features & BIT_ULL(VIRTIO_F_VERSION_1));
 
+	mlx5_cmd_init_async_ctx(mdev, &mvdev->async_ctx);
+
 	ndev->vqs = kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
 	ndev->event_cbs = kcalloc(max_vqs + 1, sizeof(*ndev->event_cbs), GFP_KERNEL);
 	if (!ndev->vqs || !ndev->event_cbs) {
@@ -3960,8 +3964,6 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		ndev->rqt_size = 1;
 	}
 
-	mlx5_cmd_init_async_ctx(mdev, &mvdev->async_ctx);
-
 	ndev->mvdev.mlx_features = device_features;
 	mvdev->vdev.dma_dev = &mdev->pdev->dev;
 	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
-- 
2.43.0

