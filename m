Return-Path: <SRS0=0+SM=OG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7667FC433F5
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 08:59:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B67611C4
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 08:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 24B67611C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D91D5403FE;
	Thu, 16 Sep 2021 08:59:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xddRVtTUxmIp; Thu, 16 Sep 2021 08:59:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7239D40252;
	Thu, 16 Sep 2021 08:59:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56DDCC000F;
	Thu, 16 Sep 2021 08:59:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7030CC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 08:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F59460636
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 08:59:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eNTWh6sz294T
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 08:59:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1EED6605D1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 08:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631782763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t2Z/Tfws0/ZPIkBTJwi6vBLPKuMktwH7w8C6L94eoVM=;
 b=G37tWJXZgJiTawDu+EWUQkxqQIqtNGr2OS2sboJ68TjLxP1BJ2HCchOBNR1RUpPpyE36Ra
 QFaEI7NxT9wzJIsXKdl/5Bfc+qjMBk/6JTZ0L6D9jxbVSYzK3SmwaWeAhouOhYyNzYymio
 sr8our5csTOncndMxOOJ0q5V+Q6PMbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-GlU6ZhEVPs-lOiN55UKk5A-1; Thu, 16 Sep 2021 04:59:19 -0400
X-MC-Unique: GlU6ZhEVPs-lOiN55UKk5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24861100CCC1;
 Thu, 16 Sep 2021 08:59:18 +0000 (UTC)
Received: from localhost (unknown [10.39.192.155])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B554960FDD;
 Thu, 16 Sep 2021 08:59:17 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Pierre Morel
 <pmorel@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>,
 linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] virtio/s390: fix vritio-ccw device teardown
In-Reply-To: <20210915215742.1793314-1-pasic@linux.ibm.com>
Organization: Red Hat GmbH
References: <20210915215742.1793314-1-pasic@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date: Thu, 16 Sep 2021 10:59:15 +0200
Message-ID: <87pmt8hp5o.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: bfu@redhat.com, Vineeth Vijayan <vneethv@linux.ibm.com>
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

On Wed, Sep 15 2021, Halil Pasic <pasic@linux.ibm.com> wrote:

> Since commit 48720ba56891 ("virtio/s390: use DMA memory for ccw I/O and
> classic notifiers") we were supposed to make sure that
> virtio_ccw_release_dev() completes before the ccw device, and the
> attached dma pool are torn down, but unfortunately we did not.
> Before that commit it used to be OK to delay cleaning up the memory
> allocated by virtio-ccw indefinitely (which isn't really intuitive for
> guys used to destruction happens in reverse construction order).
>
> To accomplish this let us take a reference on the ccw device before we
> allocate the dma_area and give it up after dma_area was freed.
>
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Fixes: 48720ba56891 ("virtio/s390: use DMA memory for ccw I/O and
> classic notifiers")
> Reported-by: bfu@redhat.com
> ---
>
> I'm not certain this is the only hot-unplug and teardonw related problem
> with virtio-ccw.
>
> Some things that are not perfectly clear to me:
> * What would happen if we observed an hot-unplug while we are doing
>   wait_event() in ccw_io_helper()? Do we get stuck? I don't thin we
>   are guaranteed to receive an irq for a subchannel that is gone.

Hm. I think we may need to do a wake_up during remove handling.

> * cdev->online seems to be manipulated under cdev->ccwlock, but
>   in virtio_ccw_remove() we look at it to decide should we clean up
>   or not. What is the idea there? I guess we want to avoid doing
>   if nothing is there or twice. But I don't understand how stuff
>   interlocks.

We only created the virtio device when we onlined the ccw device. Do you
have a better idea how to check for that? (And yes, I'm not sure the
locking is correct.)

> * Can virtio_ccw_remove() get called while !cdev->online and 
>   virtio_ccw_online() is running on a different cpu? If yes, what would
>   happen then?

All of the remove/online/... etc. callbacks are invoked via the ccw bus
code. We have to trust that it gets it correct :) (Or have the common
I/O layer maintainers double-check it.)

>  
> The main addresse of these questions is Conny ;).
>
> An alternative to this approach would be to inc and dec the refcount
> in ccw_device_dma_zalloc() and ccw_device_dma_free() respectively.

Yeah, I also thought about that. This would give us more get/put
operations, but might be the safer option.

>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index d35e7a3f7067..99141df3259b 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -1006,10 +1006,12 @@ static void virtio_ccw_release_dev(struct device *_d)
>  {
>  	struct virtio_device *dev = dev_to_virtio(_d);
>  	struct virtio_ccw_device *vcdev = to_vc_device(dev);
> +	struct ccw_device *cdev = READ_ONCE(vcdev->cdev);
>  
>  	ccw_device_dma_free(vcdev->cdev, vcdev->dma_area,
>  			    sizeof(*vcdev->dma_area));
>  	kfree(vcdev);
> +	put_device(&cdev->dev);
>  }
>  
>  static int irb_is_error(struct irb *irb)
> @@ -1262,6 +1264,7 @@ static int virtio_ccw_online(struct ccw_device *cdev)
>  	struct virtio_ccw_device *vcdev;
>  	unsigned long flags;
>  
> +	get_device(&cdev->dev);
>  	vcdev = kzalloc(sizeof(*vcdev), GFP_KERNEL);
>  	if (!vcdev) {
>  		dev_warn(&cdev->dev, "Could not get memory for virtio\n");
> @@ -1315,6 +1318,7 @@ static int virtio_ccw_online(struct ccw_device *cdev)
>  				    sizeof(*vcdev->dma_area));
>  	}
>  	kfree(vcdev);
> +	put_device(&cdev->dev);
>  	return ret;
>  }
>  
>
> base-commit: 3ca706c189db861b2ca2019a0901b94050ca49d8
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
