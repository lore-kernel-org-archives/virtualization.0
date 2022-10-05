Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA86C4332F
	for <virtualization@archiver.kernel.org>; Wed,  5 Oct 2022 03:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C378B60BC9;
	Wed,  5 Oct 2022 03:24:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C378B60BC9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DUIZ4uXu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tYEhkZ9Z5Oqd; Wed,  5 Oct 2022 03:24:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3A544606A9;
	Wed,  5 Oct 2022 03:24:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A544606A9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15C6CC0033;
	Wed,  5 Oct 2022 03:24:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5945AC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:24:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2480181A5F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:24:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2480181A5F
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=DUIZ4uXu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GBbCjrUNh81u
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:24:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A024819D6
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A024819D6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 03:24:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ln0yyQZ4DGxlKBMYd0ytx81h53YlJGr6S0YK0mmSq+NkcL7vezTOT7RlMRm+oVr/w6f04MMOLvwvfEqINKsaTG5Nw3ngbiGEMC9ajD5/p90UB8bR0uQw7D+tE+DAX4mvN7aTUSSXPpllT7kAG76FlqxUFDFJk4yDrrwIpHoEGnCHhw+ZYD4OW423GI1G/W5M/VK16e56XvJ5oYdY9gm38onih9JrhUsUnmWqCTpyP+qgBjGSsevNrvJaq+bEGGHHofjEhkD2mk2kkpqVtpuRsaIk/gyMFrrrCXM2Lc8F9iLdinAA62RjsX6RZBfBYfm+7onC2yDLaPkuCpJc7iaa3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRDyQbDPyaFQSaQtZrBwesGqQGhPZsg6OeGHhsgmvr4=;
 b=EpKA8bC9AwDhAQf5pGbMQnjYtTVIczOb1X3JC5eR6h6erkptsvfjU/ZmElm7n2W/ybEwvY3jlpM8vo2SOX3zqtCTZIJRqLfxBi0U7y8xEXRXp9U39vj9wYnQkLNKflmL4y7+Dx9gayuUYK3A6RKBDm+ThhZbd/4+8Te4yCkOBWXlaVN3OmsmXY7z6e1y2r9MmOy2wZ0mpD4fNtMCqP9yHAdhHioC0EI8TM2i2MvSEq0PxjY7jkJ7hDzXtwqdiT2WpKF7DkRBI0YANoRC/kZM0Uy7GSJTDBuGmH8Qr0Bl0RS5of0OIU+hoyMg6To6lO0eaT1LtguL5pmNJefVXSfTig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRDyQbDPyaFQSaQtZrBwesGqQGhPZsg6OeGHhsgmvr4=;
 b=DUIZ4uXuNI88TXfzdBn7dOUYlIAIDGQJYPbViR1Lo10svL7ldEe9vP9ZXiYC5BZ7u/OFy7sMo712QgvXX3KnoXXKOWNheaRJp3oB1zZmB0YXLKPYI/GQaYE7yk36m7+Mled6MM4E6nS6DCjQvUgDK/Ox2ZLGpkMEnpTg2KSXgFpulj6pb+S2XLkVkXy1i+Q27/3sPhTjuOpnu1nsn6V7UqYRgShzRr75a6CaomsOKltU7KH98/JpmHPaYHvnz/PmbugAO21OMa338l6JjTZI/cueQteqsdd0ScHosuzFGsJOzgRXMh4TDIbfr9LhUnAteA51zRup/NmozlanlgA9jg==
Received: from BN0PR04CA0191.namprd04.prod.outlook.com (2603:10b6:408:e9::16)
 by DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:24:46 +0000
Received: from BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::49) by BN0PR04CA0191.outlook.office365.com
 (2603:10b6:408:e9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Wed, 5 Oct 2022 03:24:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT093.mail.protection.outlook.com (10.13.177.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:24:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:24:44 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:24:42 -0700
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
 <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: [RFC PATCH 07/21] virtio-blk: use lib tagset init helper
Date: Tue, 4 Oct 2022 20:22:43 -0700
Message-ID: <20221005032257.80681-8-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT093:EE_|DM4PR12MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: 733cfe8b-e794-46b0-6971-08daa68126fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTYESK4koO5+K4tHXWXuqxjcJLaPsJuNcwWiMufO91ITQJ1jgS1YrxY2KCJzOxppOxte8aHZxD7sYJMO1bjrBDYDMRjji/gTACpWSL4pKTf7yNmFlMmKESC9XKBRJvqQZHutJK4kwk4ceb/Wx491EpJR89S/BfUEjjT/RN8/oP2jNhFTZvo5cBDHm9v/uv1vlmg+ZWOQ4PxRkzMvrtGqItLuL7YXaXmmaOQ+hkEVFJ+AUQ8tyDi922b6UssJEPDgG1FycYc2f2jtxAYfVPC8yVsbzWYPU8A/GtD+cos6TdIE+RvbvlueFWg//fWB3h1d7/3l4AIszeg25xUFXhsAgVNTmzXcJSYic0ces8nfSIc/pjPE2Qj+189IrYcLTa+QnjvzabtL3WOmGY9Q0vyMvGpbICn6o5jtsX0RWmicaBnDPXQl13k59LiYBmU6xgaS8Dn8J2ua8H+O3u/5mfy95vMOkcItcjmnZ9/RuptRFmhHD+Tx2dkvhS0Waa5hK0LWxMA0YK3Dxu44NAhZ8huSKr+5++SPqGfmYjfPas47Nvhf1D9ikKFk3TLtlUlbnqAzQ7rRPD1+U2xpSmkXoVJyNSRGM1WphJzVC1lVf96kYUeWUX6cqmbtM4pQLHijYYntljLOSXRwhNEQCGowrsx8s47K5zxij8JI3XX6fDCXqMG8d8MYbPqCOquhe4MV+9b2GXa0DyrxDUpRX7vsMFrtA3rNHOLssk9H13wuLKtwyb44NaVOxSb96kyp2+EX91NwyXwEnFXVpsMRg2kCqRK41WWkXFe08cztahBIIA7NPY+H3APQIxlo64L8JsivF9E8pq1YqFjYyeDLm3v/6qdmpvSKHde+B4+Ne5H1AaB0uLM=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(26005)(16526019)(7366002)(1076003)(7416002)(186003)(2906002)(7406005)(41300700001)(2616005)(8936002)(36756003)(7696005)(8676002)(5660300002)(70206006)(70586007)(921005)(356005)(82310400005)(336012)(82740400003)(7636003)(40460700003)(40480700001)(47076005)(426003)(83380400001)(36860700001)(478600001)(4326008)(110136005)(54906003)(316002)(21314003)(83996005)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:24:45.9721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 733cfe8b-e794-46b0-6971-08daa68126fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5182
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

Use the block layer helper to initialize the common fields of tag_set
such as blk_mq_ops, number of h/w queues, queue depth, command size,
numa_node, timeout, BLK_MQ_F_XXX flags, driver data. This initialization
is spread all over the block drivers. This avoids the code repetation of
the inialization code of the tag set in current block drivers and any
future ones.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/virtio_blk.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 23c5a1239520..975b4a8213af 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -885,6 +885,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 	struct virtio_blk *vblk;
 	struct request_queue *q;
 	int err, index;
+	unsigned int cmd_size = sizeof(struct virtblk_req) +
+		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
 
 	u32 v, blk_size, max_size, sg_elems, opt_io_size;
 	u16 min_io_size;
@@ -942,15 +944,9 @@ static int virtblk_probe(struct virtio_device *vdev)
 	}
 
 	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
-	vblk->tag_set.ops = &virtio_mq_ops;
-	vblk->tag_set.queue_depth = queue_depth;
-	vblk->tag_set.numa_node = NUMA_NO_NODE;
-	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	vblk->tag_set.cmd_size =
-		sizeof(struct virtblk_req) +
-		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
-	vblk->tag_set.driver_data = vblk;
-	vblk->tag_set.nr_hw_queues = vblk->num_vqs;
+	blk_mq_init_tag_set(&vblk->tag_set, &virtio_mq_ops, vblk->num_vqs,
+			queue_depth, cmd_size, NUMA_NO_NODE, 0,
+			BLK_MQ_F_SHOULD_MERGE, vblk);
 	vblk->tag_set.nr_maps = 1;
 	if (vblk->io_queues[HCTX_TYPE_POLL])
 		vblk->tag_set.nr_maps = 3;
-- 
2.29.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
