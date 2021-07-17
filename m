Return-Path: <SRS0=6YK7=MJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE94FC636CA
	for <virtualization@archiver.kernel.org>; Sat, 17 Jul 2021 07:43:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E96611F1
	for <virtualization@archiver.kernel.org>; Sat, 17 Jul 2021 07:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E96611F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5226D424D2;
	Sat, 17 Jul 2021 07:43:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S698u4A6RDqh; Sat, 17 Jul 2021 07:43:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7C3FD424B6;
	Sat, 17 Jul 2021 07:43:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0398EC0023;
	Sat, 17 Jul 2021 07:43:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6D83C0026
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7EC3E422A9
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F0XRJK7GYYX8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4AA71424AE
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ei855svWi9P0RoJDstqCPBh3JNCJpae36kFlmiCmTsbkyCk7RrAb5oDmge2W9yQDk4gm6gjRi3VngniuYaFTCTpCzWsp8IREAkcy+4nvd6bNc6rl2OYDBv65mt/fd+k1kwD9O6PyLHjinNWq73vW7AG5dgFNFO8nJ0OXNT7TJhzYr0Glj0Bbmw0/UjboPgwvZrkBRk/eescn+UQs/aIQYcDbBnanbGNtZYEBxiSCRP4Q1RG8Jo45k05Ci5GmOixQFwSBFj7W1GEYnu1NjmiJEVxpIYJ3c9Wpahm/in6T3PXhoZ8fLZnuRmv1BR1HdTqPT8CEsa8jmrqrO1ijXKUeIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S73FoJnUHx/BWXD+vB5vzgEBm4TU79Vjq/T12w2Q65s=;
 b=VKoZX5be7TLVhUN8xjCOI+bMJtzDDPHBrkG6yvGy5SIDtW9GBbgTFebFDZBZxaAOt0D+KByK9xDl7avS7w9l9n+u9XdDmNSHtNIEuD/iVClSHcGy0e46ePAF51Bx9AqIJq5ymw4DbPJRFYvu4fh4OkcdA7NLS8/0RRyqb1qV62QclwDhW4XFGGbGTbRZNCRqBknIxjj12oui5JimanwS5BqImpt9aR2lckg1Ufd8coKrPvXA/WAHiHiX0qOaIuFEaiyGnxCLd8s7XFiEvPB+ifDaSkGZ8IobxP9DqSgosaMzIQ3bwsmVfIhdQPSsEYySXEI6L0BFJtRIipyt9AharQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S73FoJnUHx/BWXD+vB5vzgEBm4TU79Vjq/T12w2Q65s=;
 b=P3H6hxOoXPOaKdmQaSJer7jIH8iWfiRUidrcaOMbme4aQdcoO/4NWeGUoNkHz+OGY0eawiADuc+Nt0H20zQupZiwtGRyLqaWXvNV9QW/r6x6r/KTY2usbECNiDyFr2uCji222Zf4dewLZup+4mtPlMcELGyZOU7+aj8Sddp9jZKSLUl03vYKsXqIoY8BHp16XSm6Eu0XLw/edbJ5ZzbGIuNAnUHbsHFuxIdnvbv95RPSvVwifbjBw5srGyrn6AtMdjjZFRsSPMeSm1TaFVpEhCD+3RVFpl9klTKXPUL6swDILE0Tj49UNpXx03yyNQK3Pr7yrAFSzow9N4pwzdK/hg==
Received: from MWHPR22CA0068.namprd22.prod.outlook.com (2603:10b6:300:12a::30)
 by BN8PR12MB4770.namprd12.prod.outlook.com (2603:10b6:408:a1::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Sat, 17 Jul
 2021 07:43:15 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::45) by MWHPR22CA0068.outlook.office365.com
 (2603:10b6:300:12a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Sat, 17 Jul 2021 07:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Sat, 17 Jul 2021 07:43:15 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sat, 17 Jul 2021 07:43:14 +0000
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH 4/4] virtio_pci: Support surprise removal of virtio pci device
Date: Sat, 17 Jul 2021 10:42:58 +0300
Message-ID: <20210717074258.1463313-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210717074258.1463313-1-parav@nvidia.com>
References: <20210717074258.1463313-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5562e62-e3d1-49c3-9743-08d948f68975
X-MS-TrafficTypeDiagnostic: BN8PR12MB4770:
X-Microsoft-Antispam-PRVS: <BN8PR12MB47706B4EE30AAC6A94310B97DC109@BN8PR12MB4770.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aP8ZO5QkGbi68z0DLx3exn2gFEKFdYXFJCFiKbAiepJOt11k/6cKvGIwxcM+WOvqx6VUZoSi/17kFXTVD8zaUROhRr/Fwn/8w0TABLU7KEBOrcbzWZVueL3cjcjdTgtvl+3fBJ/Lo9ktm7Kc1xN+rQXF1Pe17OQt/TTrBDGyv7oqVzP32n6FN0w/HpSbiNoSrPQHAjlfJ0r/W6nSFTRmX6iewvtDemW1qar0Zu5JmWt5GR1O3JLE4QZvaE9APfrreR6rUbWMJ0yE/JLwPxsYN+FBponYnLo6YUqSmVX8RsONrXBXVyQpwQyG4nqeELco7+gRKmCqXMkTR2J5rsSN6F98Sytwwj06rzWKHGpl5rrgPcjK8DX06wZN/rlZgCXkcF9HphVJ8jSiyy/WkJ+I28PbYASxOvIiEAV3AVMW7nS8SAsaA0u4ia73f0mjHr0hKeu+j3xt+osp2hniiBZx4IdhGs8f2Wp6Cgk7rkQYq5qreri4ZKn2EMur6YWZZrIrGI/W1ogvGhaSJnXCZDJXd1jiv1hGXK7igNduxT3WCWke2eYArbMDeJcnZ1XOm4+f1ElxAlxn9KduiGoHwejZtiqPGv6j9dMVj9lHGoBWAaQbDGQZ1xM59bPu/l9ajqZFhLJFUPJqS7RNlpUito3MTleBWuCrW2NQWlesHxhpkulbrMEV/wAClm9V4DS9R6FS/ZRwrW6qWgYxf9+wlQ7iRG6sDpGoNJDhaRNDMVAuSSs=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(39850400004)(376002)(136003)(396003)(346002)(36840700001)(46966006)(7636003)(2616005)(70206006)(26005)(5660300002)(1076003)(6666004)(83380400001)(36756003)(34020700004)(82310400003)(70586007)(426003)(2906002)(107886003)(8676002)(82740400003)(47076005)(186003)(36906005)(478600001)(336012)(4326008)(110136005)(316002)(16526019)(86362001)(8936002)(36860700001)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2021 07:43:15.3496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5562e62-e3d1-49c3-9743-08d948f68975
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4770
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

When a virtio pci device undergo surprise removal (aka async removaln in
PCIe spec), mark the device is broken so that any upper layer drivers can
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
