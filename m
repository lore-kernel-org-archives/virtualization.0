Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52339C636C9
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:27:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9DF611C1
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9DF611C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6E3E608A9;
	Wed, 21 Jul 2021 14:27:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wb5a-dSdf5eY; Wed, 21 Jul 2021 14:27:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 41937606C6;
	Wed, 21 Jul 2021 14:27:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAFCDC0023;
	Wed, 21 Jul 2021 14:27:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1C30C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E8FCA82FF9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bo8j1QueQSHw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::605])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA8C28308D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uqz4TH7VbXr8DPviYmQVLILCtRZ8LaeCMBvjW8fThUhD84NrC9hdRRqgw8YD2gsYDOKSKAVUYSdfHTfMoEQD2ktMDyKpVx4ZiViTUshwqSX+82GGNZLJOq7v6uMRw3aKYySBMfigq5n5mEuN+7j+olJP8dHYLI1izLw2YrOCkvs3rkPMiGDN4ba2ZJ3VOaFDu9vjunuiNkHI/6t9TLZeQXfxi8LbBaXAmZ4GLvTqAJk40bBirx3dLQL5YuHINyLDejLszJflcSajDW2qfX9p4M8kjdOUzuQSW2M0Z1UewtM6UVK/ds3lQvl+TDRM6TrBdG4NmkXi3/G34jenGmb2qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqr0cMIdgdwmZmBUmAD7MYIwWJ6SotNbx+U0JPjAhB0=;
 b=Y56dlnUG2akORoYt/tI2cqMaiYdnQCR0QDte2dfGidgfcCjprn5sJ+sDDOVEY3IXvHlqVvRmua6n8qiPnkQeWJxtPw1q78jZV8WAnP6Hjufo0FaLXbqRxOk8ivAjrGbV4z6JwlbOYgKMHSVakWGcPZBxM92ok1Bef5zwcCC6eddCKESZWKarCMBgYMpDypBxQMMuut6zgyDTnAUhZcmGbS5Xgyw7MfbpVttC/0objff7moe6xbmj8qz/WLF7PC76n8nUrVBW0U8Biyi4oaOha4cDtvOL0wMJVZxXvkI5OtZmpMXSJvnr9Z9dBZJiuTlFmhHCgnbaS2GRf9HEcYHDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqr0cMIdgdwmZmBUmAD7MYIwWJ6SotNbx+U0JPjAhB0=;
 b=uqS+9BjQx0/IaYRklt6qqcvAMYR3WWm+R2WkvX584rxhAIeNhjq+ju2m8Pztgq1t+aEEkjq6I6+WkLGrrPwKt0K0/SqfE6mU1foSO5M9GkwtAMCRY9F8/Z+Cw2T3SsCND+ypRnWkw23/DSU8v3N4iipVDY54l/ePuyZpls0XdAmsg7cL3jSn4c2DZQ+yw8FzYXm85zON0Z+KffyhBDP1l/+6BJPSsTPBSvA22HGC0evJxs6wKr0LBDa1Ai3ZJp0NmVzKfQtb5/9P4L/oDgoBEzLg1YLxJQjeNnoFsCcyfm5vYghTSjiWtE2OuOSHOljSlweVaYjzVnrLa4jc33YGPQ==
Received: from MW4PR03CA0141.namprd03.prod.outlook.com (2603:10b6:303:8c::26)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.31; Wed, 21 Jul
 2021 14:27:21 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::fd) by MW4PR03CA0141.outlook.office365.com
 (2603:10b6:303:8c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Wed, 21 Jul 2021 14:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 14:27:21 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 21 Jul 2021 14:27:19 +0000
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH v3 4/4] virtio_pci: Support surprise removal of virtio pci
 device
Date: Wed, 21 Jul 2021 17:26:48 +0300
Message-ID: <20210721142648.1525924-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210721142648.1525924-1-parav@nvidia.com>
References: <20210721142648.1525924-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 816e12cd-ba37-4def-77d8-08d94c53a6fd
X-MS-TrafficTypeDiagnostic: BL1PR12MB5352:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5352EFED447D712AB25FD1E2DCE39@BL1PR12MB5352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ji0A3Tf4935+ZqTS+KxK/oImZudEMaQvJwe+h84AyNKHuVjcmcLq7RFzhjFJR0SrpIfeCR0aGTHyGseT6YUE5nFcXDr3+Z/jkhz9wM8y7P3B65aY1HlFUSOtkHQtCmAbY7L/1uPCDZstfJOqV8Q5P730Ax7LNvprNSxL9UiTZ4Eb9SNJ/xn82aHhVEwGAJy0maRE3bqcsinMDGx1R0TEPtsrTsFMC/RsEGl6/w2fKtqRCcTvx7nB7qyogaLVBiUhYnsE4bnfaJDh/I9O794cOgBYAVGrOyjWBmI/co3a8Rcx9jnL5+druDRHvgLg7Dy4Ng8D4Fh7o7XIwbs74N+5FQTI823tsGR+Mg95u8lmayOTxDj/0BtOCETga8j6xBTWgFRJYTp8ERkoim7YbnmQr6ZbZ5OvyYk4yD9VxFCvrAUWX2v565mvtqPvqw8RvN4LeqzdvVaMGllEqnFOXUiUbyKb8MBK/ee5HyHBEvK9/uBdWB+0sazl/fldS9fMbKQAGc5yjalqAoDLtlLs0Ai9X1czPdtxj8ZYuV8VMfvnnKWgQgwJMZtmYMS0AooOC/x+EMQRghh/8KkmrNIzDLatwQh4ecED5vORFEZ4HmAi9Gh/sdn/b15uDccI4hSxJgf3NZ0rCgXWuP9meFm7xPtc8aYv+GyZReIjLvhk2OSDgzo3BW03fuhgn9QhDwokl2gpkaw0HAyRFV78xVkUf++ytw==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(36840700001)(46966006)(70586007)(356005)(83380400001)(316002)(82740400003)(36756003)(478600001)(6666004)(110136005)(107886003)(47076005)(7636003)(4326008)(8676002)(70206006)(36906005)(36860700001)(16526019)(2616005)(86362001)(336012)(5660300002)(426003)(1076003)(8936002)(2906002)(186003)(82310400003)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 14:27:21.6202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 816e12cd-ba37-4def-77d8-08d94c53a6fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352
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
