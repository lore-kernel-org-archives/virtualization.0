Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B881BFE00
	for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774922; cv=fail; b=Jic7lpCMtK+fZL+9xaqVKWzqF6aGI5TalKdpFtqd3ZggDE2HanH+WREvfLeBumg1lA2A4xHKnKqfQ+Ie5XtzJvd/NVmSNBQ3/GS46eB9MaHIYJPKKbOLZowPTiove5TBdIco9OtRhu5xTbuW9Ttqzn03gOW3lEijYvIkVLZRQBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774922; c=relaxed/simple;
	bh=NhUsh9x4GxLtyut5O/mnRAqlerzP+PB0kQA2fcmy2/w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hRi7wBkA7YUKn+Qxh8zxIm7ptMMnGdvnXJ5TzNT73ZK1bbVg0+tdXVULUyjgePgcJRYHw0j+37JD1kGypd1OULJFT7kmygyuQk+yHql1OJVE7N5SXBj9WPGj3gTNzYhIR9UhzQT1vYABLih47darENKFfhWLSJqXzeh+BjsqeS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NuqcLkTf; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NuqcLkTf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMmp0ufKOpbogtzyNUUJL0c83UvPcW00/qkZ/y4TRqabhmAWR1d7/Dljv1uIBM7phY/uBxHU9d19M04H+HkGPWWP5tyP0WUi4UumULBFPq4i8j22kCEAmSZ5gWgxu++k9NEd8c98zVUvE8uUlumIPf7MZg5TZrtIocyyatyh8G8Dm6CdBI8V/uuclMpn8aLTHxmJsDdNuXe/RaVtL3aLsVF4GTo1STUeImuIV5udI50UvgY1GAxX8+EcmDZ5huY+GyDn1Ask4Guhw52fosSykOuQmfYDzrz+S/fpI7IBMy0RW1zwhR+49OTzPmcaW1dpgnGmzQMAgANx7V0klhzKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEBBVZk35VacjsuAKxGEdgZG58amKNMEJkzVFyo0N6A=;
 b=ND5gfAGhFzXhu0eD2bJYW0WiaRFH8+6ytShbViVw3l3aWF+g/mEA0cswJzqBmrcQSsU232KxPXUUiFFNS+GiolQzBoWy//ORM9W1ttK6qR5ZDfvR2+3cH35onlFRDHzBqWwbZc6KbKc0dk4vRG0P+j8T+KjdBy947sMTppTMt6xr4hnUX70/FNeIeAkXWvB2IO1X3h97/L81Q+qvC8mI965Aq/PQxmlxKIfQ9+T5wTEnMkWfYLW9VDgePRkhirrdWUUsS0XJi3/FgKn1yd5NrDHh3cQ+KaYFW8ZeKZelEkeVac6Z5if2FJaIdXbj1ldBOkQwGPpRofQAuEZiToBxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEBBVZk35VacjsuAKxGEdgZG58amKNMEJkzVFyo0N6A=;
 b=NuqcLkTfThOHfxQfltAPSphJ4czNsSrR+LDe4RVIr5ES4ulRxUnR1zZYVdAJJm8cNsmlvUSV6+Z9v7I/trLMSbaH7wLfji/VA0C6J+wbhQwcYCDBPIqtKnthcV2Lbe/tJfioxAmH6e2MJ6+YPjEdiyYeS522abY0R4nD9LzNMf2d+ld+wWThzY6THxVIULCdQi/rL7mP3YhEdROSXlpYl+vltX59J6FSSs7rBrBa5o5+BgNwiNC8JgIwIyl5cLYVvSRurzk8bez0xIm6zkW5C72NLrkyjl4qEUgWbhCc3cNxaPFlc5OsXNroV23Kd2CVFUcJdHHbDulORt0vkpxhKQ==
Received: from CH2PR15CA0026.namprd15.prod.outlook.com (2603:10b6:610:51::36)
 by SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 16:08:36 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::e0) by CH2PR15CA0026.outlook.office365.com
 (2603:10b6:610:51::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 16:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Tue, 27 Aug 2024 16:08:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 09:08:21 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 09:08:20 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Tue, 27 Aug 2024 09:08:18 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
CC: Cosmin Ratiu <cratiu@nvidia.com>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] vdpa/mlx5: Fix invalid mr resource destroy
Date: Tue, 27 Aug 2024 19:08:08 +0300
Message-ID: <20240827160808.2448017-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.45.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: f96b4eaa-4de9-4a1d-ee74-08dcc6b2817a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WOuuinHoKa8iftyxigqx468mHyApEcFM2G0dVLFOFZwhE2u/E67vUfzp/6aI?=
 =?us-ascii?Q?jdrGOArlNJg/DY4XcSBs7NpY52ZFJC/kmSrS8F6G3MBcpeoaHmsjjlLmRysp?=
 =?us-ascii?Q?7gSMCZzMvtJ6bIxh4Jwd85pX0d0JNeR1YwXU7r64eQ+ebS72Z8K+yhaZNaSG?=
 =?us-ascii?Q?Pm03n/xqCNusYvmfN53v9UiGj8b22nybHQ2O9Z1mg6IsxCbIcmm6By0cW4vW?=
 =?us-ascii?Q?9rKezwCtu8HE6r1UOvPyM7r1NRIsqfv3+s5BvwIUHWOi6KcSrcovZJYGw/sF?=
 =?us-ascii?Q?N78XNnAHdXmxc7iLJjSnz9nfIFGWBQw3czM+xcG5rDzVyzLK+NaD8MhFflCQ?=
 =?us-ascii?Q?UAPbd4GwRVMiElSIFQm+4CZ1ZKFriisTIwL6bncD7Fo61/uW0jp2GYCmWNBg?=
 =?us-ascii?Q?EBjAZLPlPt34Ydv/dv6EGcccXKJJxlTqU1en/Q/AasM1HgP8Zui0nw0cJpy0?=
 =?us-ascii?Q?WHyew8NY0uPnZnm4ApZTKRvSdVdzKCrZgQywCcP8okICNqSEij1OR42ItupT?=
 =?us-ascii?Q?MuIqnFfACqMkkZsTDhi0uqHlfsAQnsrdLTh2CoeTae145q2UXf6yeKRkUEon?=
 =?us-ascii?Q?X88HX/q133q7d+jFFyZ1XXV0ehPJQSerjgoX2FLbgXEWB1MyPR/aJFjNutyj?=
 =?us-ascii?Q?I26oj3yclfRb/1XCD3rz2fjycFc70xBIdtj//UX0aLt+zgSTJ/CjaDoVVUic?=
 =?us-ascii?Q?BZ+HbW/fNlg6wnTIARo30pnYP/aQZ7LL400o9TRIEAPkqVjA0fk8mMjhUFKQ?=
 =?us-ascii?Q?bfnCHNaqNark8FAFKGxQYDoZ+qrzwrpkNxXDFmACLNA4p62HnOHz8R60iagI?=
 =?us-ascii?Q?ZcJ8apNVbporwaU8dXoux+rUaQ1sRvKY6sOSi/JqzZK2igDhJQY/E/MnqSv1?=
 =?us-ascii?Q?KdlMlo3UCgTG47p1vKNHRwp/GjnL4MqobboN/EfSL5SDP+7/nOxkaYTLef3b?=
 =?us-ascii?Q?WVobSl9jKWofimaqVLnReXbhHbXoV3ahA5teEeZBkzVWuUOsSv8CyDWF/AI5?=
 =?us-ascii?Q?NzPpi+BKEQDds+AC+CiS5fGJxDUkDJSFmlSjcIqo2wEvmraObzoVDMVnfy2q?=
 =?us-ascii?Q?D2pWRQclFnVkjDbIKwG3GHzKXhVG1Y5JN06WLPM/7+Z4W2IlDMYyfeFYTMEh?=
 =?us-ascii?Q?0I5GNsjutfTjjuRdGLL+ldlJWMr2/ABmAoeFEqv+XqILdq8zW76KDh2hJLoc?=
 =?us-ascii?Q?NiFihpoVMgwFyYIFjwkXrVBOS+SeO4/SO8DiSA0URr0abKH/5bmRpkjH4dZc?=
 =?us-ascii?Q?LFKRZCcCZbviRoIXl9Py2kafSXEuQEDnwMw8BoQMiS2D+1UflusQSHDF5gn/?=
 =?us-ascii?Q?yYQG0JEOIFPC0qhA3rvSWz4vexkOKeWbvGWgOZT3J6aiwW9nHkt2Zvex7vKQ?=
 =?us-ascii?Q?yfvX9FIFsqe1W1VjUjZMW+K8d8sa429fWE64EvFFtRb8P63NoBkKRvHjOK/i?=
 =?us-ascii?Q?9mCLf/2A3VQwvQyFsNYaWuPnO8CKNYIS?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:08:35.7000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f96b4eaa-4de9-4a1d-ee74-08dcc6b2817a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147

Certain error paths from mlx5_vdpa_dev_add() can end up releasing mr
resources which never got initialized in the first place.

This patch adds the missing check in mlx5_vdpa_destroy_mr_resources()
to block releasing non-initialized mr resources.

Reference trace:

  mlx5_core 0000:08:00.2: mlx5_vdpa_dev_add:3274:(pid 2700) warning: No mac address provisioned?
  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 140216067 P4D 0
  Oops: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 8 PID: 2700 Comm: vdpa Kdump: loaded Not tainted 5.14.0-496.el9.x86_64 #1
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
  RIP: 0010:vhost_iotlb_del_range+0xf/0xe0 [vhost_iotlb]
  Code: [...]
  RSP: 0018:ff1c823ac23077f0 EFLAGS: 00010246
  RAX: ffffffffc1a21a60 RBX: ffffffff899567a0 RCX: 0000000000000000
  RDX: ffffffffffffffff RSI: 0000000000000000 RDI: 0000000000000000
  RBP: ff1bda1f7c21e800 R08: 0000000000000000 R09: ff1c823ac2307670
  R10: ff1c823ac2307668 R11: ffffffff8a9e7b68 R12: 0000000000000000
  R13: 0000000000000000 R14: ff1bda1f43e341a0 R15: 00000000ffffffea
  FS:  00007f56eba7c740(0000) GS:ff1bda269f800000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 0000000104d90001 CR4: 0000000000771ef0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  PKRU: 55555554
  Call Trace:

   ? show_trace_log_lvl+0x1c4/0x2df
   ? show_trace_log_lvl+0x1c4/0x2df
   ? mlx5_vdpa_free+0x3d/0x150 [mlx5_vdpa]
   ? __die_body.cold+0x8/0xd
   ? page_fault_oops+0x134/0x170
   ? __irq_work_queue_local+0x2b/0xc0
   ? irq_work_queue+0x2c/0x50
   ? exc_page_fault+0x62/0x150
   ? asm_exc_page_fault+0x22/0x30
   ? __pfx_mlx5_vdpa_free+0x10/0x10 [mlx5_vdpa]
   ? vhost_iotlb_del_range+0xf/0xe0 [vhost_iotlb]
   mlx5_vdpa_free+0x3d/0x150 [mlx5_vdpa]
   vdpa_release_dev+0x1e/0x50 [vdpa]
   device_release+0x31/0x90
   kobject_cleanup+0x37/0x130
   mlx5_vdpa_dev_add+0x2d2/0x7a0 [mlx5_vdpa]
   vdpa_nl_cmd_dev_add_set_doit+0x277/0x4c0 [vdpa]
   genl_family_rcv_msg_doit+0xd9/0x130
   genl_family_rcv_msg+0x14d/0x220
   ? __pfx_vdpa_nl_cmd_dev_add_set_doit+0x10/0x10 [vdpa]
   ? _copy_to_user+0x1a/0x30
   ? move_addr_to_user+0x4b/0xe0
   genl_rcv_msg+0x47/0xa0
   ? __import_iovec+0x46/0x150
   ? __pfx_genl_rcv_msg+0x10/0x10
   netlink_rcv_skb+0x54/0x100
   genl_rcv+0x24/0x40
   netlink_unicast+0x245/0x370
   netlink_sendmsg+0x206/0x440
   __sys_sendto+0x1dc/0x1f0
   ? do_read_fault+0x10c/0x1d0
   ? do_pte_missing+0x10d/0x190
   __x64_sys_sendto+0x20/0x30
   do_syscall_64+0x5c/0xf0
   ? __count_memcg_events+0x4f/0xb0
   ? mm_account_fault+0x6c/0x100
   ? handle_mm_fault+0x116/0x270
   ? do_user_addr_fault+0x1d6/0x6a0
   ? do_syscall_64+0x6b/0xf0
   ? clear_bhb_loop+0x25/0x80
   ? clear_bhb_loop+0x25/0x80
   ? clear_bhb_loop+0x25/0x80
   ? clear_bhb_loop+0x25/0x80
   ? clear_bhb_loop+0x25/0x80
   entry_SYSCALL_64_after_hwframe+0x78/0x80

Fixes: 512c0cdd80c1 ("vdpa/mlx5: Decouple cvq iotlb handling from hw mapping code")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/core/mr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 4758914ccf86..bf56f3d69625 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -581,6 +581,9 @@ static void mlx5_vdpa_show_mr_leaks(struct mlx5_vdpa_dev *mvdev)
 
 void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
 {
+	if (!mvdev->res.valid)
+		return;
+
 	for (int i = 0; i < MLX5_VDPA_NUM_AS; i++)
 		mlx5_vdpa_update_mr(mvdev, NULL, i);
 
-- 
2.45.1

