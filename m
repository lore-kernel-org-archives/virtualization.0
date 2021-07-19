Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A4CC636C9
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 10:39:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E023B6112D
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 10:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E023B6112D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A64AB40284;
	Mon, 19 Jul 2021 10:39:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DcujLPcqWxdU; Mon, 19 Jul 2021 10:39:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C2AF94012D;
	Mon, 19 Jul 2021 10:39:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38551C0021;
	Mon, 19 Jul 2021 10:39:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D45DC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E4204606F9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:38:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vb1MFpBkSeLH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:38:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::622])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 473E96058B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmvtHG31VHYeTAM139m6g+ndBZlmiNkJJ5ELsockhvZu/6lWSrp4F/upeMXGPV8QuQ+vLdi/00A+Gzxo5n+1h+MuDFh8n/ICRMqW17JykNEyCRbQ1+HYDI3A9s8RF5BFH081ytOcAC/prz0emw+OrhIoCHS9Zv/FF4duJZd3q4MH0fLMQPkPgwC4ivREeDlnJG5TvD3v85dU2ZF5z7XqQ9PZUIiNSDieM0aJtoUwRzmG1uXmaoJsscD1iFbL7O66wiaqa9XtMQYlZOX0GKP6F3ecfiwmOhXlUNC9ZfpXDIpCZp0vazrKk2htR10M0zWoJR3zjDG24HT8zdCLC/Qg8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhfCxf1fDXNaPOHqi6NJp6scQqfHmBOo4OWMncU+V3Q=;
 b=czvunwXt5uatxuHHFG64NUNpdk/awiCXdRR/Z11iGVac0ZeRj3oacgZPxxVY7yNqH1Je9X8sLWcQ34zW3lhJSDUA5ZtKi+cl6SiwAiaTqWNwk/wA99Yn6IAlZN49AKbAJ38DQn/z0iVPHvhx2XkpP3YhCzFOTVzpv9xSTauf84vGJhEmBxPCf/ZbKSRjJzsj5z5VIZuBiW8Vyj04qfVrTx1NJXxkM679g9iCAp6dBSJ+bqXf2FacCaRlyYfob8+sE2mdNqH524Ba5sFaeyOCdkz1EPXUl3m0NtBkl8Ab99x3o1eXI2YRIZx5Zo2ynqgsNWNFCIVcer5to47zOSRTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhfCxf1fDXNaPOHqi6NJp6scQqfHmBOo4OWMncU+V3Q=;
 b=LSstwQ2prJxmFjmWi/lqKNhNItfoy2oFEau+/Im7i/OwQONMVxgftG4nfdR70Wo9bK+wUNUQxTd7z8hFfhHfpsiV0AUnJeltwXM9bvadFK9R6KeexF5YUglxqjE0AIeH59zyR032ZvyJal6EJoSPteaSGEfBadZthdsyGPPdInxAkIlVCgGncbL93tlQx7meBKoSC83XSBtJqEzu55dHQHoyKOOj+qWFz/MD598zeGJKoOA/guiH0PXgc2wL99fU7MZ6mZ42Psw8kCRTZiVrOc9dcxYaN1zWHWYfYzLH4rHCYVYKwhciyPSbXGjbDDkvRoGjaEjJSLdUkSMMwpxZ2g==
Received: from DM6PR11CA0006.namprd11.prod.outlook.com (2603:10b6:5:190::19)
 by MWHPR12MB1629.namprd12.prod.outlook.com (2603:10b6:301:3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Mon, 19 Jul
 2021 10:38:56 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::4d) by DM6PR11CA0006.outlook.office365.com
 (2603:10b6:5:190::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Mon, 19 Jul 2021 10:38:56 +0000
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
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 10:38:55 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 19 Jul 2021 10:38:55 +0000
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 0/4] virtio short improvements
Date: Mon, 19 Jul 2021 13:38:37 +0300
Message-ID: <20210719103841.1488049-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bb79fd2-a955-4174-b111-08d94aa168fa
X-MS-TrafficTypeDiagnostic: MWHPR12MB1629:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1629B8139606C005B6808838DCE19@MWHPR12MB1629.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dxL/zVm3EK1lJupazkUdl3Ro8Y+q42g29EB4ZL/Rr6mYgEi18BJvT8Vl+aRpLQCQH2/av7jKXxzjFTQHFx7QP1IcSpIbOS0NMdUEEP4nx996EiK4QVVClZGK8qgG81FOh6pNOUUpUlZCYPqxqNZcW380szHu9Eo/Z4EpB9kHfgG+Gtwx5FMkkfyJQSdyjlA/6rhCsfj8orJY435v5ljFCH2zqWAvpPSBOAWCcxkyGoV/OyRB3GEYFOBUCWI+Y/hkswavCC/vDjIMF5arc0TyQen2z601gdVS8maT1k3F8w/hGZzEyC5sbwhBvYy4mPFW9ovDnHyzy9Zzciaw08WW9dYvJlMHY6IiGmL68GFzJVi+OPdT0NyOK/yybwy1GT9vkM06Sgo2gBWZa3sSQ6JEDf57cT9vkri5HHwC5k5bzKMUuYslnx3ITo9rXjXhjb+dKEWMN9/TdcWblYpUypkgOb9gfmQ4w0VbFce56ClLXfnkyne84WokxjOSMcDKDWCXhW+U2lG6Nyaf/Qdjq/pAw1oRyZQYM6EIMWcX1790FL/ZwQ8J6BDtKBSjx6ZQIa5lR1j/hqQ7/ZfdP4dNeWE1WC1fF9wpn92fU6hmPpwR3pvCierT0Pe7YQy5xBcqrDmbhbg8DIAOhLYl9WDoGHrdRgyRpw6Qi0jwiMCumwlGCo4ZU+kZy6NxfbyygB3EP8exg1Ja4Sb2CcIFSX3gpVUlaw==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(36840700001)(46966006)(1076003)(8676002)(5660300002)(110136005)(356005)(8936002)(82310400003)(316002)(36906005)(7636003)(4326008)(70206006)(6666004)(36756003)(36860700001)(336012)(426003)(478600001)(83380400001)(186003)(82740400003)(16526019)(86362001)(2906002)(47076005)(2616005)(70586007)(26005)(107886003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 10:38:55.9976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb79fd2-a955-4174-b111-08d94aa168fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1629
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

Hi,

This series contains small improvements for virtio pci driver.
The main idea support surprise removal of virtio pci device.

Patches 1 to 3 prepare the code to handle surprise removal by marking
the device as broken in patch-4.

Patch summary:
patch-1: ensures that compiler optimization doesn't occur on vq->broken
         flag
patch-2: maintains the mirror sequence on VQ delete and VQ create
patch-3: protects vqs list for simultaneous access from reader and a writer
patch-4: handles surprise removal of virtio pci device which avoids
         call trace and system lockup

---
changelog:
v1->v2:
 - updated commit log for WRITE_ONCE usage
 - improved vqs protection patch-3 for using natural structure alignment
v0->v1:
 - fixed below comments from Michael
 - fixed typo in patch4 in comment
 - using WRITE_ONCE instead of smp_store_release()
 - using spinlock instead of rwlock
 - improved comment in patch
 - removed fixes tag in patch-1

Parav Pandit (4):
  virtio: Improve vq->broken access to avoid any compiler optimization
  virtio: Keep vring_del_virtqueue() mirror of VQ create
  virtio: Protect vqs list access
  virtio_pci: Support surprise removal of virtio pci device

 drivers/virtio/virtio.c            |  1 +
 drivers/virtio/virtio_pci_common.c |  7 +++++++
 drivers/virtio/virtio_ring.c       | 17 ++++++++++++++---
 include/linux/virtio.h             |  1 +
 4 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
