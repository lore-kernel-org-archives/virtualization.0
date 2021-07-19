Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66682C636CB
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 07:52:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03978611AE
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 07:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03978611AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B22AD403E2;
	Mon, 19 Jul 2021 07:52:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TlZsp-ydfMar; Mon, 19 Jul 2021 07:52:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E4D2A403E8;
	Mon, 19 Jul 2021 07:52:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1A45C001A;
	Mon, 19 Jul 2021 07:52:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72D7EC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6ABA382A83
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7T9G_rNMMxba
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::620])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B1C9F82A56
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYVi1P49jwegJSrQvc9ZiNxV05AY6caN8dbRj0BpVRHADRF5iNLK8Czsn6zcmPsxYW9J4I78qKVsjg72tJWIxDIZmLWeN0Rg+drKvSC/CDsOhXcucSnrhCEVcHgfd3wWT1jMT+36JKiw2PdmwDaxblz2ivcuzk/DL1c/IkcxxRBf27hzTeKeCJxZfFz5eak39mAD0FOtLgRmEsDTGRc62p7o5ChJNc5Xs9TOzPztFAVhk/YHXYQOnJ0De8Bio5z7I4SxO14cNFSIIixyPGYN+u27AH0hxhDSCrQRloPk8VVZ16RC4m3OUeaVbDzyEn77P4yN5Qc+AIieuZT9yG6fmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqr0cMIdgdwmZmBUmAD7MYIwWJ6SotNbx+U0JPjAhB0=;
 b=RMrkcO7n2LCwhFuGCYv7ylo0+00zS2y0PcmMHl8hYu98PNJeiqrKyW06UG0cL4zEeIT+klN9fXrP3tLwMOltMTqMsk2QLLDBlHjva2ElzQlvun6owEBpyxR3hPLVSBDnaikQRXAUqV1zkAEAbM5K7Lhq50Jx5iQEO68OSo2tXpAdfy/fvUYCf07/N4VYXen6+u82eOAsiRMsUbeOmdoGxo+BbrdciNEx5/dYZs1RMEtN2oIs5dbVG6RxmwrWiLqJwfOB/y7TcinFADzd9INPipxVNmKi9Wm+RPnSCQ2GeqhViz5eXDqiRPXyEgmZ5iCXeE3qlldedrtXOF5qNfpxSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqr0cMIdgdwmZmBUmAD7MYIwWJ6SotNbx+U0JPjAhB0=;
 b=b+wtDfdSnSL5BJ9ziPC1QWQ6WhBRhigKVRsARvak4Or983gBxUIcq/YpX3fbEHdJ0zXCHZBwpooKtnoUKFmI9rsVLVYsSKt3t0yxUtQvx3EpwQjkM2onMiqJE6OgCz5y7rl0JKr8LNdXSbnaqk4ddwV/oY167IQ6nXzb7V46sKxiHiN0fQMWaymen7nZE39C1MgbkRD2fnlcRBoVYnnlFRhqX08LQfmFnc91UzYHGhEQaTRbSsrPs5NSMKZzBfXI2P1J1e+OlICL7VBQVzy/jg5rQgWhd23wISpRDjedzs6BrpLZ5mbox4uwzCm/X8KA9OqM+JtdyzPQiv+MB/V2ZQ==
Received: from DM6PR13CA0010.namprd13.prod.outlook.com (2603:10b6:5:bc::23) by
 BN8PR12MB2964.namprd12.prod.outlook.com (2603:10b6:408:43::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Mon, 19 Jul 2021 07:52:40 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::ec) by DM6PR13CA0010.outlook.office365.com
 (2603:10b6:5:bc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.15 via Frontend
 Transport; Mon, 19 Jul 2021 07:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 07:52:40 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 19 Jul 2021 07:52:36 +0000
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH v1 4/4] virtio_pci: Support surprise removal of virtio pci
 device
Date: Mon, 19 Jul 2021 10:52:18 +0300
Message-ID: <20210719075218.1485812-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210719075218.1485812-1-parav@nvidia.com>
References: <20210719075218.1485812-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8785d3ef-6973-42e6-fa23-08d94a8a2ef5
X-MS-TrafficTypeDiagnostic: BN8PR12MB2964:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2964AA633191345947AF6A48DCE19@BN8PR12MB2964.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULKs/7N14XDgL9w7FMi0EMgVWue3dkWtBX6VaqguYFm11Zh8oGRl6yYvVYlHINIx4Rr20HNHk75xRDOnmnRiQOoxz0/lIDhg9rVqJUgBW4fnxE/FQVkRgqC9lOL9HPlza09HDrArUqUbmTYJom/BkqIDpk9ICvKj+TT9mLqw39ZgUWE1XEeEt3OUQsfVtActhVK7Ex4cgoBGQgh1Sbpairl6SfiLtrWEiNXcWs/fbWzPG8X5wXOPzr07xbFrMFhA/wpOwLRMzjvyjJIi3raopgZZxMeFTT1SjZLo6RToD7LNYOKlsTgnn7F6h45T9TfIo8WrtCLPExrBkXTCDqFRquQjf0nT+MU64PHAKm1IB4eIgWLYQqDxUF6AGTIN/u1I5RmzlcqifDT4i8K7h86jevqytUoTcuj72B7mEWvITKHFwwSh5jwrMf11RQ60rZEDoFauq/BVzpQJsF6o8RFHTgUfmrnI9oViz+PMK/2vyF/7ZnPgYbVpfd0+bqA2FIY1XddxrlbzdW8JiNgjxuPcShYVuPi60S4c2KKPLn2sipqOQGTwiDPGVugWAHIX18mJUlZ0zxn0kSd1eta+CPjrb15xleDzeR+519ao6EhDX0kHZIGCiUdtUPgnBnoj6aU4SPRDDiv0GjAFfKgLZSOLL/nS3al06HxcE/dIsIdkYSwip/rsl9n3w8ghA0MbW/co4iIPelNkc6hPZfVzNN5e7Q==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966006)(36840700001)(36860700001)(86362001)(1076003)(2906002)(478600001)(336012)(16526019)(70206006)(107886003)(6666004)(186003)(26005)(426003)(70586007)(47076005)(7636003)(36906005)(82740400003)(4326008)(8676002)(83380400001)(82310400003)(316002)(36756003)(8936002)(356005)(110136005)(2616005)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 07:52:40.2201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8785d3ef-6973-42e6-fa23-08d94a8a2ef5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2964
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

When a virtio pci device undergo surprise removal (aka async removal in
PCIe spec), mark the device as broken so that any upper layer drivers can
abort any outstanding operation.

When a virtio net pci device undergo surprise removal which is used by a
NetworkManager, a below call trace was observed.

kernel:watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [kworker/1:1:27059]
watchdog: BUG: soft lockup - CPU#1 stuck for 52s! [kworker/1:1:27059]
CPU: 1 PID: 27059 Comm: kworker/1:1 Tainted: G S      W I  L    5.13.0-hotplug+ #8
Hardware name: Dell Inc. PowerEdge R640/0H28RR, BIOS 2.9.4 11/06/2020
Workqueue: events linkwatch_event
RIP: 0010:virtnet_send_command+0xfc/0x150 [virtio_net]
Call Trace:
 virtnet_set_rx_mode+0xcf/0x2a7 [virtio_net]
 ? __hw_addr_create_ex+0x85/0xc0
 __dev_mc_add+0x72/0x80
 igmp6_group_added+0xa7/0xd0
 ipv6_mc_up+0x3c/0x60
 ipv6_find_idev+0x36/0x80
 addrconf_add_dev+0x1e/0xa0
 addrconf_dev_config+0x71/0x130
 addrconf_notify+0x1f5/0xb40
 ? rtnl_is_locked+0x11/0x20
 ? __switch_to_asm+0x42/0x70
 ? finish_task_switch+0xaf/0x2c0
 ? raw_notifier_call_chain+0x3e/0x50
 raw_notifier_call_chain+0x3e/0x50
 netdev_state_change+0x67/0x90
 linkwatch_do_dev+0x3c/0x50
 __linkwatch_run_queue+0xd2/0x220
 linkwatch_event+0x21/0x30
 process_one_work+0x1c8/0x370
 worker_thread+0x30/0x380
 ? process_one_work+0x370/0x370
 kthread+0x118/0x140
 ? set_kthread_struct+0x40/0x40
 ret_from_fork+0x1f/0x30

Hence, add the ability to abort the command on surprise removal
which prevents infinite loop and system lockup.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v0->v1:
 - fixed typo in comment
---
 drivers/virtio/virtio_pci_common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 222d630c41fc..b35bb2d57f62 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -576,6 +576,13 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
 	struct device *dev = get_device(&vp_dev->vdev.dev);
 
+	/*
+	 * Device is marked broken on surprise removal so that virtio upper
+	 * layers can abort any ongoing operation.
+	 */
+	if (!pci_device_is_present(pci_dev))
+		virtio_break_device(&vp_dev->vdev);
+
 	pci_disable_sriov(pci_dev);
 
 	unregister_virtio_device(&vp_dev->vdev);
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
