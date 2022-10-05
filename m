Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC75CC433FE
	for <virtualization@archiver.kernel.org>; Wed,  5 Oct 2022 03:23:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4548E408E9;
	Wed,  5 Oct 2022 03:23:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4548E408E9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iW3jsrpo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WAo15F7W3PgK; Wed,  5 Oct 2022 03:23:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 78480400AC;
	Wed,  5 Oct 2022 03:23:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 78480400AC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58635C0033;
	Wed,  5 Oct 2022 03:23:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E313CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:23:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 741F560AEB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:23:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 741F560AEB
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=iW3jsrpo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hEduuCWnRI6T
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:23:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A1AE60AB7
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A1AE60AB7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAnP4nz11d924n5Ea6rkfbTTWZkOcBMR/h7ZkQJ1oHltLxDJaeH/Iez5BS7J79qQ2VcFFwKYgIGmCiYXjOb76HvhXSy2EaAQdXrVxivVboL/NYUst26hybzA8F8XTgXAFdbEcsSJMarnV5z3mvpNv6/2qB++DsmW8q+cjiY5mYdZRhiZtGSYFd3lR+A2iFGBWA/Ij8OWKnFTulTcMU+8KAKsLHdCYRDn4ExerGOo0Cz+trXQUARNz81ypcs8fpGxbeso3FeGPHnm9ypVjlCvgTaHFSZVumbmAN2zpDwlny92lM3GEdkISUQHh9Y61BlOgXREHFsrbzCGQ5y2BJTFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrgGetB/TLOjMS3vQknhv/SINTgMiPk7KqpkdclIcUs=;
 b=Xdz1XM9XgHs5tzhGy60K1VMGf7QyJWaVPAJhDsbnmp5W/XTYb8Bi8f8nb1UQ9e1IMXiPYTTYFi+RlZ3dI4B1Y65Z0QQl37FH3c1C70lf2zoeoThJTzvL5pDhglUPoxYHgg6oC5ZPXVTzZ7fI8eRAMYUPXqTcCbnYF3bAL97S2ILwtM1l2jXOjFCoIw/7vNwUKgtUw5eRwCmMqR8F6tJ6kWA6QAr1QEgGdFMtX9EEuzAUXyUW/5oQ5M9j8wHfEwj0ontzAsr9fQnTHG8LgEDXWpyAJq2jM6WEwKhEfCq2J7ZwlH6dHyJLv/NzzbtfG8MmACbtqAtD5iuTsSetceIsug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrgGetB/TLOjMS3vQknhv/SINTgMiPk7KqpkdclIcUs=;
 b=iW3jsrpo9QXt4SmTdh80KE4thGPDh8fejFIagobwIQSERcoWvLGWdLcnqwJhThlAROWm8mvRxQA47EVCi2eq5eIqa5WE0yHiZwRofiP/64oBAIcTBy9/FMHs0x/UhCYe76qnqD/RIxdsnzqz50SrhQQ5XHpX7WIjLrthz2kNv59+A3mkKtYd3h3MQR4rPdtfo4TK1QbuPLEW/MLJ9voFSb02DML6kB8S+aqt7c7YeYtZ6sH/cLX22f9gL/69KTjRMugSIK3H29HTjUPGFQd45Kix5z6Vce1d/4Amspy1WZOvPhvdO4CpC2PD1IOhhn2ZmJ7Dkg4nMNlIVcZcz5zeig==
Received: from BN8PR04CA0001.namprd04.prod.outlook.com (2603:10b6:408:70::14)
 by DM6PR12MB4863.namprd12.prod.outlook.com (2603:10b6:5:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:23:16 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::c8) by BN8PR04CA0001.outlook.office365.com
 (2603:10b6:408:70::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Wed, 5 Oct 2022 03:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:23:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:23:08 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:23:05 -0700
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
 <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: [RFC PATCH 00/21] block: add and use init tagset helper
Date: Tue, 4 Oct 2022 20:22:36 -0700
Message-ID: <20221005032257.80681-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT062:EE_|DM6PR12MB4863:EE_
X-MS-Office365-Filtering-Correlation-Id: fce348ec-947a-4641-efb6-08daa680f183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9FlJpRPPWo/UczTdTCd5SyHamL/pqbpEL/Ib+DcXgEmnGmZ9HEQsxCsQSSaqCQcTZjccDkXjj6u6yhsKWFHSidDTY7fUyBz2KqAnbklpfj1swJc7PjxXCgzNELZVysLo4szooec2ZY8lzfdkSE6HtdY+DtVcTMVjT8/jV+DKt5E6leNDKjVvSwh8EQ+Et7lmmqiT5dBceOsWFEahHF9xDSoPAe8cAus+8SNEDsQM/6NnzlmMJLTqU3TNS2er/HUj3CSYob4ij3EhgCsbqwKE9P/opr4klhGiEvSjB3DqbxFBhoQWFGh3JkLy/bkJIE9ynCNZz144NHMITmR5CHCTeusxffP0uhFo7kUdiQBTkgxqKecyfPQnuhlX/bH6m9Szl15GpW7txUmH/1j62W3KaE9uc5ouAyMtQlwD5YGw+snHXJjYVq7VluiZGSPIx5lNKrFTs9brAjh+oHAqB/n511BLraQb8GC6Uxu2tRGuunDb47VIS8P+D/hbiblfD/8mXucfE4lBfj0SIMlLUoPlKp0fkZ4FwsXtU2X1Gkn+mFFL+PnaG2Bvhazs80UG8ITqBnJHvmm8BR0hiA5I9yOwQqNN/La6BsPmng/IjQ0jXZDQtHd5tXAwu7XpWpAsOHNrnNQejJI1nT3M/dr+3H7VZ902lZCeV4RpYrjbSktdNLt+0q4Qgde1mX3VLGrvRqUzqyMBNIPAnRd4/ehBsgzMWgL1bZOGZzvOa9nJKokVBQEo8fw8n1c1PismK7nqoMDbHtoaNR1b+Woq9GxppbdQ+Uk3j/bTNKU/oQZ46LetuLMSQ2+S8Aek1LfTGwDQtcXmq39TIGsaevKwgzMGZjrTtWGxjjuYVEglp3ZjLIPlBV0=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(7696005)(41300700001)(36756003)(6666004)(82740400003)(5660300002)(7366002)(7406005)(7416002)(8936002)(26005)(8676002)(316002)(70206006)(70586007)(4326008)(336012)(40480700001)(83380400001)(47076005)(426003)(82310400005)(16526019)(186003)(1076003)(921005)(356005)(7636003)(40460700003)(2906002)(2616005)(36860700001)(478600001)(110136005)(54906003)(21314003)(2101003)(83996005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:23:16.2764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce348ec-947a-4641-efb6-08daa680f183
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4863
Cc: vincent.fu@samsung.com, vincent.whitchurch@axis.com, stefanha@redhat.com,
 mst@redhat.com, hoeppner@linux.ibm.com,
 virtualization@lists.linux-foundation.org, bhelgaas@google.com,
 haris.iqbal@ionos.com, miquel.raynal@bootlin.com, agordeev@linux.ibm.com,
 jinpu.wang@ionos.com, hch@lst.de, alyssa@rosenzweig.io, vigneshr@ti.com,
 sagi@grimberg.me, richard@nod.at, damien.lemoal@opensource.wdc.com,
 vaibhavgupta40@gmail.com, joel@jms.id.au, shinichiro.kawasaki@wdc.com,
 idryomov@gmail.com, jejb@linux.ibm.com, asahi@lists.linux.dev, ohad@wizery.com,
 gor@linux.ibm.com, sven@svenpeter.dev, hca@linux.ibm.com,
 john.garry@huawei.com, josef@toxicpanda.com, efremov@linux.com,
 ming.lei@redhat.com, christophe.jaillet@wanadoo.fr, sth@linux.ibm.com,
 baolin.wang@linux.alibaba.com, kbusch@kernel.org, ceph-devel@vger.kernel.org,
 nbd@other.debian.org, bvanassche@acm.org, axboe@kernel.dk,
 martin.petersen@oracle.com, wsa+renesas@sang-engineering.com,
 johannes.thumshirn@wdc.com, andersson@kernel.org, marcan@marcan.st,
 dongsheng.yang@easystack.cn, christoph.boehmwalder@linbit.com,
 mcgrof@kernel.org, svens@linux.ibm.com, pbonzini@redhat.com
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
From: Chaitanya Kulkarni via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Chaitanya Kulkarni <kch@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi,

Add and use the helper to initialize the common fields of the tag_set
such as blk_mq_ops, number of h/w queues, queue depth, command size,
numa_node, timeout, BLK_MQ_F_XXX flags, driver data. This initialization
is spread all over the block drivers. This avoids repetation of
inialization code of the tag set in current block drivers and any future
ones.

P.S. I'm aware of the EXPORT_SYMBOL_GPL() checkpatch warn just to make
get some feedback to so I can remove the RFC tag.

-ck

Chaitanya Kulkarni (21):
  block: add and use init tagset helper
  loop: use lib tagset init helper
  nbd: use lib tagset init helper
  rnbd: use lib tagset init helper
  bsg-lib: use lib tagset init helper
  rnbd-clt: use lib tagset init helper
  virtio-blk: use lib tagset init helper
  scsi: use lib tagset init helper
  block: use lib tagset init helper
  amiflop: use lib tagset init helper
  floppy: use lib tagset init helper
  mtip32xx: use lib tagset init helper
  z3ram: use lib tagset init helper
  scm_blk: use lib tagset init helper
  ubi: use lib tagset init helper
  mmc: core: use lib tagset init helper
  dasd: use lib tagset init helper
  nvme-core: use lib tagset init helper for I/O q
  nvme-core: use lib tagset init helper for adminq
  nvme-apple: use lib tagset init helper
  nvme-pci: use lib tagset init helper

 block/blk-mq.c                    | 27 ++++++++++++++++++++++-----
 block/bsg-lib.c                   |  9 +++------
 drivers/block/amiflop.c           |  8 +++-----
 drivers/block/floppy.c            |  7 ++-----
 drivers/block/loop.c              | 12 ++++--------
 drivers/block/mtip32xx/mtip32xx.c | 13 ++++---------
 drivers/block/nbd.c               | 11 +++--------
 drivers/block/null_blk/main.c     | 10 +++-------
 drivers/block/rbd.c               | 11 +++++------
 drivers/block/rnbd/rnbd-clt.c     | 25 +++++++++++--------------
 drivers/block/virtio_blk.c        | 14 +++++---------
 drivers/block/z2ram.c             |  7 ++-----
 drivers/mmc/core/queue.c          |  9 +++------
 drivers/mtd/ubi/block.c           | 11 +++--------
 drivers/nvme/host/apple.c         | 25 ++++++++-----------------
 drivers/nvme/host/core.c          | 21 +++++----------------
 drivers/nvme/host/pci.c           | 25 +++++++------------------
 drivers/s390/block/dasd_genhd.c   |  9 +++------
 drivers/s390/block/scm_blk.c      | 10 +++-------
 drivers/scsi/scsi_lib.c           | 13 +++++--------
 include/linux/blk-mq.h            |  5 +++++
 21 files changed, 109 insertions(+), 173 deletions(-)

-- 
2.29.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
