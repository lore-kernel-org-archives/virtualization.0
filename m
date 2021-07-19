Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41931C07E9B
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 10:39:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95BA610C7
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 10:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95BA610C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4B6C60799;
	Mon, 19 Jul 2021 10:39:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6HOwqBP1ZGkq; Mon, 19 Jul 2021 10:39:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3714C6077E;
	Mon, 19 Jul 2021 10:39:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12268C0010;
	Mon, 19 Jul 2021 10:39:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 289BDC001F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:39:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BD4782444
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:39:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M7fIts9pQ6mV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:39:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2054.outbound.protection.outlook.com [40.107.95.54])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F84A8248F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:39:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oX1cgRCQpKBV4USleJilvfjs4WsYsOE4fEhGFfsZUIPOg82lNrOrfh3mq3tuwQlKovBFBAAJGvnipMaY8wBbnOrT2lTdnjsiBkwh8/BLGniei6s0/PZWQk6aH0Sr1yMlBxIfvYL8oboXrOB4uj/rQDlwYn6SCMUfvcsDLk4ozFNi3c6a73tWSq6uYcwLXtvpLNgwqZd0+Jpe68UDPKm2HA4GODDbOOoxPyy74K3whHE/G2bU4Cxr010e7Pjqn6hxsgwJ9+cqKy8/A9A5K9f6iQgt+Cyxao9t2rELHbAhh/+ITFZG7LJbgd7cPM7zGPYi4AiR6p6BSxpWEj3et3qXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqr0cMIdgdwmZmBUmAD7MYIwWJ6SotNbx+U0JPjAhB0=;
 b=NBGAn6OGZPXoV/mWDjaQAoOAWGHyyeesq9rxjzLE7AglJj37ljta3fgAemx2zAfJBQtfUHKijLBq41uGRL6qF6eN8pchm04wngu1Fi9fVUAajMmgLBBwfy/qub/QXiRb8HuM1C5f/oCFFWOEomshC7BgwXfV71L8S49rOl0P4YS5QgmUOjVjO++Ex7Do1vT1uixerMmQPA07T7zM65h/hwkKJWlIuibvEhs2k9ISnvhUkRr6KIbN345z+lyXX30k4rA1GtWDsU8DobHAegqBYs5iVRpzKaaVrBsiylAc1YECJttBeONpuovcZTyPXKL0gv0F8tYoYfiD3TU8RQvq/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqr0cMIdgdwmZmBUmAD7MYIwWJ6SotNbx+U0JPjAhB0=;
 b=qASswlV6tSR9IuvNWVkmqKYDpHiIOF3wod/rd3a6ISgU6nZdZNwQfFvW4ZWKOzEGOLaiFTyr5M8g1hdQFfemH1D06ovtBVmDQoVtbA5PBunB13o2Pg3KPXToG8G3WK37k0dNVsATZOHzXjiQTohY/TfBaaWqL6NTrfZ3y9TVxntiZno4Hu15SvX2vYtKBkfrtRlCTaAu2iAD09KR53roAKdAc5ginFo+5Jpz3BC6xxFjO2WzQ5rhR2XVLpMxx74fomzfDbwMeDfyK6k/Ta7/DfHGAavfSg7H8StyiZS+pZBd3l7WpZHsy6ar66Rfqg2oqC0QBaxzDQ66sOKl5J3WgQ==
Received: from DM6PR11CA0034.namprd11.prod.outlook.com (2603:10b6:5:190::47)
 by DM6PR12MB3402.namprd12.prod.outlook.com (2603:10b6:5:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Mon, 19 Jul
 2021 10:38:58 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::e7) by DM6PR11CA0034.outlook.office365.com
 (2603:10b6:5:190::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Mon, 19 Jul 2021 10:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 10:38:58 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 19 Jul 2021 10:38:57 +0000
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 4/4] virtio_pci: Support surprise removal of virtio pci
 device
Date: Mon, 19 Jul 2021 13:38:41 +0300
Message-ID: <20210719103841.1488049-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210719103841.1488049-1-parav@nvidia.com>
References: <20210719103841.1488049-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c891b81-7bf1-43be-5886-08d94aa16a41
X-MS-TrafficTypeDiagnostic: DM6PR12MB3402:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34021BD59504E521DBB974F0DCE19@DM6PR12MB3402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+KX2nMMNXvgOWLM1H+dOF1/DH1R+6rqId4z4oEHbIGlaK3XZqPtk4eL1uPsdfvA7ftIupGubfXNRlh7URNTgoZzhA/DwCE8+Yo1t3wblcwCThx7EWZ4tt6P5hqdY0mPnXtYqt/JJumVDC7DO4Z0qhJOQCXi1FfiHtpPwd+k5UUJaaccFbTqej73YpLaCuPrm68TIS3gu0C23hD3eL1opUS/r995j5fBqHtgNUb9Ta2uKXm1SIS0CHAoOwcT3GjJmVYoOuOgYGox3egnE159W/hy2pGgvhNyS41S392EfUCn4wGWdWCS8uzXf7cmcVUuHVoXmQ4jmH7GYclaSt3Y5N7Q0cIwP1hXuQoT5P52IfTBCSKlYVzcuJs6FoiKWbCdUVuF9rcE5qbq9HXR1Zqvd62Ighw9t9K7IuIicVTdSNrSDYoKbxCN7CDkoYKXGNlmYntZFIAQSRWPisagTnZSL+Ni8h6a0KNEl+txtgvVKzkb5+cme7UjagZrm8A2MmAdeP+1HXAstkW9Ma2952COnVH2j9lbWvtBtOOJoMwaZyy3E64vUy+FdLNrRmuAATW6D5LAm2ILA+56VBnZIOQF/gS/IjuqeK1fjS5KCH92ixGxIiKdKprooRPRP8T3bg28C/+DzEHbzjuS8FAB3c1R+qCOa8xBiqu6Cec7l5R5oGotElyWfPGEsXhq7jmCusB1gOsiFeUVoQvdjKKF1pzpzA==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966006)(36840700001)(16526019)(186003)(83380400001)(47076005)(356005)(2616005)(36860700001)(336012)(426003)(82740400003)(7636003)(36906005)(110136005)(1076003)(5660300002)(316002)(2906002)(6666004)(478600001)(26005)(4326008)(8936002)(107886003)(36756003)(8676002)(86362001)(70586007)(82310400003)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 10:38:58.1284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c891b81-7bf1-43be-5886-08d94aa16a41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3402
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
