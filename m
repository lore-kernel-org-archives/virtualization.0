Return-Path: <SRS0=rr22=L7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16807C07E95
	for <virtualization@archiver.kernel.org>; Wed,  7 Jul 2021 14:05:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8534561C92
	for <virtualization@archiver.kernel.org>; Wed,  7 Jul 2021 14:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8534561C92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4AD184036D;
	Wed,  7 Jul 2021 14:05:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SSCgLFcJadI1; Wed,  7 Jul 2021 14:05:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A74B2404EB;
	Wed,  7 Jul 2021 14:05:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76CCEC001A;
	Wed,  7 Jul 2021 14:05:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77DE8C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 14:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 57B1640235
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 14:05:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XxO80xMsbbx6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 14:05:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54BCA4017C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 14:05:37 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id B225068C7B; Wed,  7 Jul 2021 16:05:29 +0200 (CEST)
Date: Wed, 7 Jul 2021 16:05:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V2 5/6] virtio: add one field into virtio_device for
 recording if device uses managed irq
Message-ID: <20210707140529.GA24637@lst.de>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
 <20210702150555.2401722-6-ming.lei@redhat.com>
 <20210706054203.GC17027@lst.de> <87bl7eqyr2.ffs@nanos.tec.linutronix.de>
 <YOV3HgWG6F3geECm@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YOV3HgWG6F3geECm@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <damien.lemoal@wdc.com>,
 John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Wen Xiong <wenxiong@us.ibm.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
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

On Wed, Jul 07, 2021 at 05:42:54PM +0800, Ming Lei wrote:
> The problem is that how blk-mq looks at that flag, since the device
> representing the controller which allocates irq vectors isn't visible
> to blk-mq.

In blk_mq_pci_map_queues and similar helpers.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
