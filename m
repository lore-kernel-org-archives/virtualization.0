Return-Path: <SRS0=rr22=L7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BC5C07E95
	for <virtualization@archiver.kernel.org>; Wed,  7 Jul 2021 09:43:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84FA361C82
	for <virtualization@archiver.kernel.org>; Wed,  7 Jul 2021 09:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FA361C82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50F3682FBE;
	Wed,  7 Jul 2021 09:43:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d0gk0Am4qxgk; Wed,  7 Jul 2021 09:43:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1B0F98308A;
	Wed,  7 Jul 2021 09:43:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7218C0010;
	Wed,  7 Jul 2021 09:43:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 512CAC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 09:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4DC598308A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 09:43:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9lCycr3BmlDo
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 09:43:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 86B77830C5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 09:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625651007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oaIwLpusiYwyhpLzYUMthLrmVzW4gUqXL4P+58at9uw=;
 b=cx28zaBmJiW1swGhxGABUzc5vaclP7FmTnM3yDCrGErS1wG98lPdyQqcJNPgdmxkM0cMML
 m9l/YuLlv0R+AiFLLAyoBRa+QgQmc/qRRNgwIF0/QcFAWK4FkCNOIZAvuNgGNeuGogCZsQ
 Hz73ULewN0NqthElfmn0wGjVgtU5Jzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-NfrNQFSeMuibJaNzREP50w-1; Wed, 07 Jul 2021 05:43:24 -0400
X-MC-Unique: NfrNQFSeMuibJaNzREP50w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1516B804143;
 Wed,  7 Jul 2021 09:43:21 +0000 (UTC)
Received: from T590 (ovpn-12-27.pek2.redhat.com [10.72.12.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 977AC60BD9;
 Wed,  7 Jul 2021 09:43:02 +0000 (UTC)
Date: Wed, 7 Jul 2021 17:42:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 5/6] virtio: add one field into virtio_device for
 recording if device uses managed irq
Message-ID: <YOV3HgWG6F3geECm@T590>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
 <20210702150555.2401722-6-ming.lei@redhat.com>
 <20210706054203.GC17027@lst.de>
 <87bl7eqyr2.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bl7eqyr2.ffs@nanos.tec.linutronix.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <damien.lemoal@wdc.com>,
 John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Wen Xiong <wenxiong@us.ibm.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
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

On Wed, Jul 07, 2021 at 11:06:25AM +0200, Thomas Gleixner wrote:
> On Tue, Jul 06 2021 at 07:42, Christoph Hellwig wrote:
> > On Fri, Jul 02, 2021 at 11:05:54PM +0800, Ming Lei wrote:
> >> blk-mq needs to know if the device uses managed irq, so add one field
> >> to virtio_device for recording if device uses managed irq.
> >> 
> >> If the driver use managed irq, this flag has to be set so it can be
> >> passed to blk-mq.
> >
> > I don't think all this boilerplate code make a whole lot of sense.
> > I think we need to record this information deep down in the irq code by
> > setting a flag in struct device only if pci_alloc_irq_vectors_affinity
> > atually managed to allocate multiple vectors and the PCI_IRQ_AFFINITY
> > flag was set.  Then blk-mq can look at that flag, and also check that
> > more than one queue is in used and work based on that.
> 
> Ack.

The problem is that how blk-mq looks at that flag, since the device
representing the controller which allocates irq vectors isn't visible
to blk-mq.

Usually blk-mq(block layer) provides queue limits abstract for drivers
to tell any physical property(dma segment, max sectors, ...) to block
layer, that is why this patch takes this very similar usage to check if
HBA uses managed irq or not.


Thanks, 
Ming

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
