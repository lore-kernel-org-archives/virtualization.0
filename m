Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2ABAC4167B
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 04:30:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3BDA9404EB;
	Tue, 27 Dec 2022 04:30:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BDA9404EB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iKd31PGg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9cpQtnQjG44Y; Tue, 27 Dec 2022 04:30:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9B34F403A7;
	Tue, 27 Dec 2022 04:30:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B34F403A7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 712C3C0035;
	Tue, 27 Dec 2022 04:30:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 016DFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 04:30:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C9825403A7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 04:30:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C9825403A7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bnulj6orQq_v
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 04:30:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E4537400D1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E4537400D1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 04:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672115449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+2iCB9qMVFrW7e1o/kg4F9WbtMs++mnsoQg+1UfY0k4=;
 b=iKd31PGgzPjlaUHAUaBGDr603kesGBjDzv08eQ1CQr54pjWT8ahhJtFCiX53V1MrBvddtv
 BvBzWZjxoU32t5Uo5dGD6hfRSCB78nan99XYvobxbwIUWx47hDFPUKCtIKTB6FMsOG2Gna
 dO/oUcCyfsaVQI8MY+9dQYS6FJQu/gI=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-108-dO0j2IokOqCNxe-OAJj52Q-1; Mon, 26 Dec 2022 23:30:47 -0500
X-MC-Unique: dO0j2IokOqCNxe-OAJj52Q-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-14261bd9123so5951794fac.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 20:30:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+2iCB9qMVFrW7e1o/kg4F9WbtMs++mnsoQg+1UfY0k4=;
 b=quNXvc7R8SjBcfhpYpOMweUHmuCDeCxX7x8tXkx22O402++5Av9Alocofd8j3W+xnq
 bCp0uGCHA6N9SGW7tPadWyg5AisM03d5V9Oy+vQaWzvfZzL8CQkYyWpxqpPr5saPMNYB
 aLZAaLjuoywH/F+b8pGXuyEuBQhc1yPUW6Di2yEqj5e78rtvtT9kRd2m9r95gttvr116
 dybvIYod4ZHF5tRNDUzPW1YhcKpazCh6lfb7Bo5+UnusKbdPSX8EPF8/bsPYeSpCxXAW
 32KgKGhV9hVwK5MefueVJJjFz2nFvtt66pW1tqwdtygbX8WCnx93MQAR/ATIybw7Px/3
 sE8g==
X-Gm-Message-State: AFqh2kohy24rBtAAnfhYbqa5NoKI13ZLeE6cK7Wt7eN/l/ke9yMT3Tm7
 sP3phy4ZpcXZBE/TttSczr7221fQKfIPmtpNcDgTP6S5uU8CIw1COkuqsSJtzSzq3ofKO9BzipF
 xLtl8+fKmjyZUA+ybGjC7WpAzNm9euy6u0mck0mj5IH8vutDDiQ7TgGyQtA==
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr999615oah.35.1672115447092; 
 Mon, 26 Dec 2022 20:30:47 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs6oyHGzxeVvGAakHIuhFN0Kfxv4s1lEI9mUDPHftWOOnd9r/T3VgLp57F9/Jm6z1+bYwUFL5i5S/6j3zykNvc=
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr999605oah.35.1672115446770; Mon, 26 Dec
 2022 20:30:46 -0800 (PST)
MIME-Version: 1.0
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-4-jasowang@redhat.com>
 <20221226183705-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221226183705-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Dec 2022 12:30:35 +0800
Message-ID: <CACGkMEuNZLJRnWw+XNxJ-to1y8L2GrTrJkk0y0Gwb5H2YhDczQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

On Tue, Dec 27, 2022 at 7:38 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Dec 26, 2022 at 03:49:07PM +0800, Jason Wang wrote:
> > This patch introduces a per virtqueue waitqueue to allow driver to
> > sleep and wait for more used. Two new helpers are introduced to allow
> > driver to sleep and wake up.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes since V1:
> > - check virtqueue_is_broken() as well
> > - use more_used() instead of virtqueue_get_buf() to allow caller to
> >   get buffers afterwards
> > ---
> >  drivers/virtio/virtio_ring.c | 29 +++++++++++++++++++++++++++++
> >  include/linux/virtio.h       |  3 +++
> >  2 files changed, 32 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 5cfb2fa8abee..9c83eb945493 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/dma-mapping.h>
> >  #include <linux/kmsan.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/wait.h>
> >  #include <xen/xen.h>
> >
> >  #ifdef DEBUG
> > @@ -60,6 +61,7 @@
> >                       "%s:"fmt, (_vq)->vq.name, ##args);      \
> >               /* Pairs with READ_ONCE() in virtqueue_is_broken(). */ \
> >               WRITE_ONCE((_vq)->broken, true);                       \
> > +             wake_up_interruptible(&(_vq)->wq);                     \
> >       } while (0)
> >  #define START_USE(vq)
> >  #define END_USE(vq)
> > @@ -203,6 +205,9 @@ struct vring_virtqueue {
> >       /* DMA, allocation, and size information */
> >       bool we_own_ring;
> >
> > +     /* Wait for buffer to be used */
> > +     wait_queue_head_t wq;
> > +
> >  #ifdef DEBUG
> >       /* They're supposed to lock for us. */
> >       unsigned int in_use;
> > @@ -2024,6 +2029,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >       if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> >               vq->weak_barriers = false;
> >
> > +     init_waitqueue_head(&vq->wq);
> > +
> >       err = vring_alloc_state_extra_packed(&vring_packed);
> >       if (err)
> >               goto err_state_extra;
> > @@ -2517,6 +2524,8 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >       if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> >               vq->weak_barriers = false;
> >
> > +     init_waitqueue_head(&vq->wq);
> > +
> >       err = vring_alloc_state_extra_split(vring_split);
> >       if (err) {
> >               kfree(vq);
> > @@ -2654,6 +2663,8 @@ static void vring_free(struct virtqueue *_vq)
> >  {
> >       struct vring_virtqueue *vq = to_vvq(_vq);
> >
> > +     wake_up_interruptible(&vq->wq);
> > +
> >       if (vq->we_own_ring) {
> >               if (vq->packed_ring) {
> >                       vring_free_queue(vq->vq.vdev,
> > @@ -2863,4 +2874,22 @@ const struct vring *virtqueue_get_vring(struct virtqueue *vq)
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_get_vring);
> >
> > +int virtqueue_wait_for_used(struct virtqueue *_vq)
> > +{
> > +     struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +     /* TODO: Tweak the timeout. */
> > +     return wait_event_interruptible_timeout(vq->wq,
> > +            virtqueue_is_broken(_vq) || more_used(vq), HZ);
>
> BTW undocumented that you also make it interruptible.
> So if we get an interrupt then this will fail.

Yes, this is sub-optimal.


> But device is still going and will later use the buffers.
>
> Same for timeout really.

Avoiding infinite wait/poll is one of the goals, another is to sleep.
If we think the timeout is hard, we can start from the wait.

Thanks

>
>
>
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_wait_for_used);
> > +
> > +void virtqueue_wake_up(struct virtqueue *_vq)
> > +{
> > +     struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +     wake_up_interruptible(&vq->wq);
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_wake_up);
> > +
> >  MODULE_LICENSE("GPL");
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index dcab9c7e8784..2eb62c774895 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -72,6 +72,9 @@ void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
> >  void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
> >                           void **ctx);
> >
> > +int virtqueue_wait_for_used(struct virtqueue *vq);
> > +void virtqueue_wake_up(struct virtqueue *vq);
> > +
> >  void virtqueue_disable_cb(struct virtqueue *vq);
> >
> >  bool virtqueue_enable_cb(struct virtqueue *vq);
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
