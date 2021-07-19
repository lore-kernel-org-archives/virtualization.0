Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F08C12002
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 07:52:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4FF061164
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 07:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FF061164
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 62E3B4024A;
	Mon, 19 Jul 2021 07:52:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mjSVeEUYjosy; Mon, 19 Jul 2021 07:52:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F0CB840104;
	Mon, 19 Jul 2021 07:52:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC89AC001A;
	Mon, 19 Jul 2021 07:52:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3225AC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E1BE8271A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uQlnBg7c85k0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2061.outbound.protection.outlook.com [40.107.212.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A8A5826BB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2ixzXlUt4rX7KtGzRToAuwqePWx69+6b5TJR5q1qiLtp78D9hhORuXu7H5fPpigkrU/e1Fsi6UppYiD0KgyGSp7qiTJiJXnQjBPqYHmgH/AhxiBF8iuIosMw4nArq0V3JK2HyxJlCDpwFWSIthkeikeQcv2nteUe2FuR8qBczfQoMCDQeNAb7En3mxEIaR2GqcVaK89RbCihS2f8+Dyv4FiPufFYllDo57KLU4lT1ddfRYh1QAGVlt4I3EBgc69H/EgeYvuDxqvRx4w8VAmKFWaxMXCS71YOqnj/6K4U3UFaH081pzJTBqDT3He9Ejldlz6VOgHx5UoALN1mK+fkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmedK5ZIoigP9XPw8sLalimW30Aizn7QPHd+R49rhD0=;
 b=OCEVRp6suswtAYb0UqmllR32v6HWCEJLmy8UrjoxNWWS8JtyK0Gx6Ujwtj1TBiF9CwXbsRrwFvLiogGOfORFKp8Sg3qRlH1DZ2SLo5RLjOHEVw4GijITu2Seg4DQkU7Ih7E93swLCkTTwO0foDX0kpjha/beZZ36yfY/P2OOkKmu+gkMcoC3xiUxDOT7Es8W1deu3AgwDIVPbs4kpZmNcBxR6YP/iPpKtTMUsMYir+zO7sjSJEPzwnr/+bHQyG81rWrMwZhsZ34fhWm9dYiq2Ki0ll2JlON5yZShcF7dIfQ2zVA5EjmSvtaHeA5E7EZ1WnYrLZ0SHyVW6jeyA5ARIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmedK5ZIoigP9XPw8sLalimW30Aizn7QPHd+R49rhD0=;
 b=SDm0NVTC9nSb74qS3b0+uJBe7mEoBaEjUktfe+BuMWGqSna5B2r7LguB2Dby+xXcVO74P3eDaNKF9V4/8IyjqBO7C6PTTNbRQM7OBus1xbPHFMCx2sXKlEUIqH1SyBoDo56ZsX6qNAFwFe/92LjnoC4i+D85XPJmTmp1lu4kjnJm/NdOKFn5p86063HQplGfHRgSp9MIyraJZEPE0NpTrDqGv894Erhldd8dOIe7yq8/unsPvs9TR3AYxGLFLZXV3wXcK3Gc3I/ukdOwCxDb+KeWEoM+g1s74vHr+fMJDNCOi1G1b6g0UXVDC7jBdcejVql/dlvpuFTpn0A/dNPdtg==
Received: from DM6PR13CA0023.namprd13.prod.outlook.com (2603:10b6:5:bc::36) by
 MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Mon, 19 Jul 2021 07:52:35 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::91) by DM6PR13CA0023.outlook.office365.com
 (2603:10b6:5:bc::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.11 via Frontend
 Transport; Mon, 19 Jul 2021 07:52:35 +0000
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
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 07:52:35 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 19 Jul 2021 07:52:34 +0000
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH v1 0/4] virtio short improvements
Date: Mon, 19 Jul 2021 10:52:14 +0300
Message-ID: <20210719075218.1485812-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3ffaf7a-43f4-4318-83b4-08d94a8a2c10
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:
X-Microsoft-Antispam-PRVS: <MW2PR12MB25554E56BE47CB58F6E23FE0DCE19@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zb0Yziz1F5KDdL+pr1md7fAhwaWriORh8/k0/FuilHEIxsvDSm1MSgAfuNDMGzzxT2LIJOXw0cvERlQ8DR63JBD5spEy272V6r8yWj1vPpvbSTzcClJ4XazB+pzzcA2xGI8iT7+66XjzlAemDC2S+7eMI23r3sVgOFqnXyJYGlEyOdIZI1aU8MvyopkVrMt1FqXJfo80slegqQoojCFT7xZ7VvZIR1YBVKMrcoSSbCEQvv6SkjNLKoQEFPeuwsB4N4lruq6h6WRnIQIpNkY60YZwvtUxyHYWVcZgPsLhU764NjtVb6V1SwZGYhH107/Y7xRNcV8w9E26sAcRr1VIm4JZY2FfAbSfFNIkP2+H+rsCZaUGPnmznvATW37Xyc2YjM3Vpf/jGSQ7TRNrqP2xWd4zid963chZTo5WtAUF9AQp7x4id2csGJR5MWq5xXjo5kdxMTiUsFOdVr0FcTRnB1zyRi/+XZZwqBNtmVDwww9oWkidO6NK8vSk5Izk0cjcRGj9dYApdd/5glhaS6MGfvjm2FMUJP7XdH9klUKZNG9UFn8zdqGzdcKohqUQaJkLK2tJyvMaY/Tc6mb1JCgi2y6ENbSfsBVBawlhCLbKN6uPSx2oST0ltl+yr5Y1AxHLJ96m1DOjSv9Xyb9gVauF/dlWAxujyjOjYjtz1S8zCHGlI/QQwJTFzoZRS8eztXFvznfgOUGeW3EF9thhYroefw==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(36840700001)(46966006)(83380400001)(82740400003)(316002)(110136005)(36756003)(47076005)(1076003)(336012)(356005)(8676002)(26005)(2616005)(86362001)(36906005)(36860700001)(107886003)(6666004)(7636003)(82310400003)(8936002)(70206006)(2906002)(4326008)(70586007)(426003)(186003)(5660300002)(478600001)(16526019);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 07:52:35.3288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ffaf7a-43f4-4318-83b4-08d94a8a2c10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
