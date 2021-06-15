Return-Path: <SRS0=k2cl=LJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB8CC48BE5
	for <virtualization@archiver.kernel.org>; Tue, 15 Jun 2021 15:58:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8D460FE9
	for <virtualization@archiver.kernel.org>; Tue, 15 Jun 2021 15:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8D460FE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F0BB83B6B;
	Tue, 15 Jun 2021 15:58:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HG52cti8NS0x; Tue, 15 Jun 2021 15:58:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C7DBE83440;
	Tue, 15 Jun 2021 15:58:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EEFEC000E;
	Tue, 15 Jun 2021 15:58:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7580C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 15:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1806360873
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 15:58:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wF3vC3m3utSv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 15:58:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6FE16606F7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 15:58:23 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 757AD67373; Tue, 15 Jun 2021 17:58:17 +0200 (CEST)
Date: Tue, 15 Jun 2021 17:58:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 09/30] mtd_blkdevs: use blk_mq_alloc_disk
Message-ID: <20210615155817.GA31047@lst.de>
References: <20210602065345.355274-1-hch@lst.de>
 <20210602065345.355274-10-hch@lst.de>
 <CGME20210615154746eucas1p1321b6f1cf38d21899632e132cf025e61@eucas1p1.samsung.com>
 <13b21a07-b7c7-37db-fdc9-77bf174b6f8f@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <13b21a07-b7c7-37db-fdc9-77bf174b6f8f@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Justin Sanders <justin@coraid.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Mike Snitzer <snitzer@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Jack Wang <jinpu.wang@ionos.com>,
 Christoph Hellwig <hch@lst.de>, Tim Waugh <tim@cyberelk.net>,
 linux-s390@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>,
 Richard Weinberger <richard@nod.at>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, xen-devel@lists.xenproject.org,
 Ilya Dryomov <idryomov@gmail.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alex Dubov <oakad@yahoo.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Heiko Carstens <hca@linux.ibm.com>, Josef Bacik <josef@toxicpanda.com>,
 Denis Efremov <efremov@linux.com>, nbd@other.debian.org,
 linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Geoff Levand <geoff@infradead.org>,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org,
 Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Jun 15, 2021 at 05:47:44PM +0200, Marek Szyprowski wrote:
> Hi,
> 
> On 02.06.2021 08:53, Christoph Hellwig wrote:
> > Use the blk_mq_alloc_disk API to simplify the gendisk and request_queue
> > allocation.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> This patch landed in linux-next as commit 6966bb921def ("mtd_blkdevs: 
> use blk_mq_alloc_disk"). It causes the following regression on my QEMU 
> arm64 setup:

Please try the patch below:

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 5dc4c966ea73..6ce4bc57f919 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -382,6 +382,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	}
 
 	new->disk = gd;
+	new->rq = new->disk->queue;
 	gd->private_data = new;
 	gd->major = tr->major;
 	gd->first_minor = (new->devnum) << tr->part_bits;
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
