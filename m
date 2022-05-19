Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1484C433FE
	for <virtualization@archiver.kernel.org>; Thu, 19 May 2022 08:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30D3984363;
	Thu, 19 May 2022 08:08:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P3Z_J45h8Zom; Thu, 19 May 2022 08:08:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B8DDF84368;
	Thu, 19 May 2022 08:08:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8282DC0032;
	Thu, 19 May 2022 08:08:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FF76C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 475654048D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:08:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kfjKevj8_m21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:08:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8DEA340165
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652947716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PaRT19em+T4GPwPQ/T0xXwQTdvktI3d/a43tTl0NNkw=;
 b=YglDRBKj6NtFtEJYgfjfIpd1ByEZctatedn6v9j81LNqt+xhBZV61SoFn79PG0s02KGQUu
 a/UgZ74/I1bUEYl+5IjHPdee1b7/n8vcOIg0ctb8k6uydrnF8a3j4nl7JLUs+qp16r4rQV
 lh8SI1THDehlZ7EwnriNP+yGI6IbaaE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-7nggYhh1N16UUisWuq7DSw-1; Thu, 19 May 2022 04:08:35 -0400
X-MC-Unique: 7nggYhh1N16UUisWuq7DSw-1
Received: by mail-lf1-f71.google.com with SMTP id
 p36-20020a05651213a400b004779d806c13so2307261lfa.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 01:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PaRT19em+T4GPwPQ/T0xXwQTdvktI3d/a43tTl0NNkw=;
 b=dd7ebQu2wpaQ+W6PU9cHMrx2XZwrReEq90KduxMkSijcLzo/6j8fwsHYoSUF5xrxYM
 3JJjU10CY5SdT+LWdUHi3behjtubV0k4kQAnQKT88LO0oeBN0Q5HzUkxlbOIc2KNH9w+
 z9mDyyhI+QK9n88YhlYAaKUcLzS239QY8Lf6jOI19xENB40s200JJzEHFPykO7xcA7G9
 a5Wamdma6B1D9pkybR2mkZ4hTfRFm/kReRKbBPEZCGDREdCAfg4sU0qpBoB1OnkVfu+t
 VZGzj9c7LKGyEYAmUdaV0SXDPUgs9wHrQF7XhUaGmw/YgifS4eSioXpWwyYZhwZSLKj6
 fNWg==
X-Gm-Message-State: AOAM533pFYHEj5mhRYs8RQyVDJEN1DA24BtFSVW2hTfTyCRy7In7/wIL
 W0Q3UAa2/VTI3B5H3eBslrWw5W/LsOpP7MH84zpSNlfMgf807CZS00ccBYaCWZxto7HDMRKzhBA
 VpgnAmIbAs6ZaKyYl+hcnhDQZ8TkrJfDHAwZHCGVOgGtuJEFFDM0aRub3Hw==
X-Received: by 2002:a2e:bd85:0:b0:250:9bf2:8e27 with SMTP id
 o5-20020a2ebd85000000b002509bf28e27mr1936014ljq.177.1652947713550; 
 Thu, 19 May 2022 01:08:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTVSo9SydbYuTdAcj6vvShrXEBo1eZDTyMXTBaYDqgH2C2D8RyXds5Ke02dPdHxXw8Kdl7wrNxJTIMixKQCm4=
X-Received: by 2002:a2e:bd85:0:b0:250:9bf2:8e27 with SMTP id
 o5-20020a2ebd85000000b002509bf28e27mr1936002ljq.177.1652947713385; Thu, 19
 May 2022 01:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220518035951.94220-1-jasowang@redhat.com>
 <20220518035951.94220-8-jasowang@redhat.com>
 <87r14rf983.fsf@redhat.com>
In-Reply-To: <87r14rf983.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 May 2022 16:08:22 +0800
Message-ID: <CACGkMEs7f63SDxed0qg4XVspJ9cSCTRrV8R-MUUVQCvjAXp+DA@mail.gmail.com>
Subject: Re: [PATCH V5 7/9] virtio: allow to unbreak virtqueue
To: Cornelia Huck <cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-s390@vger.kernel.org, Peter Oberparleiter <oberpar@linux.ibm.com>,
 Cindy Lu <lulu@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 mst <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
 Vineeth Vijayan <vneethv@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Wed, May 18, 2022 at 6:04 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Wed, May 18 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > This patch allows the new introduced __virtio_break_device() to
> > unbreak the virtqueue.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 21 +++++++++++++++++++++
> >  include/linux/virtio.h       |  1 +
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index cfb028ca238e..5b7df7c455f0 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2397,6 +2397,27 @@ void virtio_break_device(struct virtio_device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_break_device);
> >
> > +/*
> > + * This should allow the device to be used by the driver. You may
> > + * need to grab appropriate locks to flush. This should only be used
>
> Hm, to flush what?

How about "to flush the write to vq->broken"?

>
> > + * in some specific case e.g (probing and restoring). Driver should
> > + * not call this directly.
>
> Maybe "This function should only be called by the core, not directly by
> the driver."?

Ok.

Thanks

>
> > + */
> > +void __virtio_unbreak_device(struct virtio_device *dev)
> > +{
> > +     struct virtqueue *_vq;
> > +
> > +     spin_lock(&dev->vqs_list_lock);
> > +     list_for_each_entry(_vq, &dev->vqs, list) {
> > +             struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +             /* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> > +             WRITE_ONCE(vq->broken, false);
> > +     }
> > +     spin_unlock(&dev->vqs_list_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
> > +
> >  dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
> >  {
> >       struct vring_virtqueue *vq = to_vvq(_vq);
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
