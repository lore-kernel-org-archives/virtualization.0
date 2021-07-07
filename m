Return-Path: <SRS0=rr22=L7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91136C07E9B
	for <virtualization@archiver.kernel.org>; Wed,  7 Jul 2021 09:06:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5105461108
	for <virtualization@archiver.kernel.org>; Wed,  7 Jul 2021 09:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5105461108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 110D583183;
	Wed,  7 Jul 2021 09:06:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hrypr5YVj9gk; Wed,  7 Jul 2021 09:06:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C071E83147;
	Wed,  7 Jul 2021 09:06:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91C19C001A;
	Wed,  7 Jul 2021 09:06:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E6E6C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 09:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3CEE740179
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 09:06:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="VMZu/KtO";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="jvHB3jPe"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FSLQGUuvNWz7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 09:06:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D3A540140
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 09:06:29 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1625648785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ymz7q4weAiGoomeb9VhZNmEV+QoSjk8iMWjGMjXQqs4=;
 b=VMZu/KtOPRzfwx1MNlTbIoFmS5VJXe1QwNKhK6JQ8oKx6HDa0tnjgagoo2HLgY8sLIjsTv
 7x6d9vQqxgojiPyBlT2nq1Xll0E5OfQAuPe0xPUtspDoK7QBhlrnDcAl/qSbPsHLLuCyqY
 t2qCdFprLfhbxAY17nDLOlErl/A4+s0dUqiAPh1xBvLiaBwGfWlWgmDxHOS4tG38t+XxmE
 aUgZ/7OuG+5jLjMw79cqHXf7AGjg5G7ZOnpohDS5v6ugDWJMirddVrX/KJeiQgKTZ03d/y
 7QE+PQO4nsgGqN7Xs2ZiMG1vnLr2JZKPGxHYdRMI7XiRiZdHjQVBVWC236Ck1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1625648785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ymz7q4weAiGoomeb9VhZNmEV+QoSjk8iMWjGMjXQqs4=;
 b=jvHB3jPeKm2B9+jan+DVSNG6rd7e7Nizu04y+uwarQ60LEcGaCBWkvS3veWGCmuPAs7RfB
 IjJRyPwHAqFbRXCA==
To: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V2 5/6] virtio: add one field into virtio_device for
 recording if device uses managed irq
In-Reply-To: <20210706054203.GC17027@lst.de>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
 <20210702150555.2401722-6-ming.lei@redhat.com>
 <20210706054203.GC17027@lst.de>
Date: Wed, 07 Jul 2021 11:06:25 +0200
Message-ID: <87bl7eqyr2.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
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

On Tue, Jul 06 2021 at 07:42, Christoph Hellwig wrote:
> On Fri, Jul 02, 2021 at 11:05:54PM +0800, Ming Lei wrote:
>> blk-mq needs to know if the device uses managed irq, so add one field
>> to virtio_device for recording if device uses managed irq.
>> 
>> If the driver use managed irq, this flag has to be set so it can be
>> passed to blk-mq.
>
> I don't think all this boilerplate code make a whole lot of sense.
> I think we need to record this information deep down in the irq code by
> setting a flag in struct device only if pci_alloc_irq_vectors_affinity
> atually managed to allocate multiple vectors and the PCI_IRQ_AFFINITY
> flag was set.  Then blk-mq can look at that flag, and also check that
> more than one queue is in used and work based on that.

Ack.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
