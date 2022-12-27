Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD02EC4332F
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 03:47:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2777C40629;
	Tue, 27 Dec 2022 03:47:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2777C40629
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PNAaB0Eo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eD-YQplC9EST; Tue, 27 Dec 2022 03:47:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 41784402E0;
	Tue, 27 Dec 2022 03:47:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41784402E0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EE46C0032;
	Tue, 27 Dec 2022 03:47:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78F96C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 03:47:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4D20F8137B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 03:47:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D20F8137B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PNAaB0Eo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bw8p43RIVIzu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 03:47:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35F0D81357
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 35F0D81357
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 03:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672112869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o1hZLNXBMRorOqtx9oPycEFZQJRnhLcRbVQCtG3oSBs=;
 b=PNAaB0EotPjaGjlVSGLkUQCGh1bJbCWxaZFWfZFVKjSe+I93JaPipKis5LFlIv62I6N2In
 I/K+HQ5QPSeVlDVlBodrUqYK9VieAb+OLv+KwXXfPYe9z1eHYs/Ez3hCM5jzuWiMTu/z+J
 LMU7DMEa+SP9GaC7oVTqUc5oZ9hGfWQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-499-2bJfjMa2M72ENRQTAOLY2Q-1; Mon, 26 Dec 2022 22:47:46 -0500
X-MC-Unique: 2bJfjMa2M72ENRQTAOLY2Q-1
Received: by mail-oo1-f69.google.com with SMTP id
 g6-20020a4a6b06000000b0049d1e5cd0cfso5638511ooc.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 19:47:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o1hZLNXBMRorOqtx9oPycEFZQJRnhLcRbVQCtG3oSBs=;
 b=y4K2ritDIUUEotF+4BhsiJv1+6UHnHq84+pdzDbzi4Pk1wOID55XMZ3qat1H0inhy8
 vK7xPyvJWP38PvLo8vwwNQgS3dzHss/ICy0THOsZ376zg+Za0fQGw+cKjH9qh4vtBURu
 LFOVMXjitGwEracbI+sRf1hGE26Pfiu6X6YkdRq/UEgeq8z5KS+AuX86DvcVFtJGzFlf
 Nn7PRbJwB/KEP+3L7yFzZAQvwom2iUcTgIQ3KEPhOxXFGJdBUncTN0yzxsSBcXTI92+F
 Lyak0ePydNSmltYI/S0RMIECYZ80ZdRjeaAdZH+QYLqStgCGFVajN7nInfV7bHstTtoZ
 vo6w==
X-Gm-Message-State: AFqh2koiX5KYcD/fRsWSmnyokoNSZ2jG73tcggheORNFXB++Sly46HtW
 9p+5uXTErpvnzbMJv49PzByJpuCJn0SwfGbPd3Z66yh/i8qTwP7HmC87H8qmSRgEfd6XPFGkSAR
 1Asy42yj7x8wg/uZOfb6KPRAqOm+DE9oJr5zOVlsoLJNNau33jHXa0IvmmQ==
X-Received: by 2002:a05:6870:3d97:b0:144:b22a:38d3 with SMTP id
 lm23-20020a0568703d9700b00144b22a38d3mr1321681oab.280.1672112865645; 
 Mon, 26 Dec 2022 19:47:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuBQ4cEkt4jn/adSCLJl1vc6Exv4RmhhMEQtw3ZaT4aCCWDhZtot/2yJeEX77WcRCiDwyeeL1Gf55fW+jYaRlA=
X-Received: by 2002:a05:6870:3d97:b0:144:b22a:38d3 with SMTP id
 lm23-20020a0568703d9700b00144b22a38d3mr1321670oab.280.1672112865324; Mon, 26
 Dec 2022 19:47:45 -0800 (PST)
MIME-Version: 1.0
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-4-jasowang@redhat.com>
 <20221226183348-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221226183348-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Dec 2022 11:47:34 +0800
Message-ID: <CACGkMEsJYn=4mC-+QKnkHi+zjZsRL+m+mdyuLemPhsZDi_hcEw@mail.gmail.com>
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

On Tue, Dec 27, 2022 at 7:34 AM Michael S. Tsirkin <mst@redhat.com> wrote:
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
> There's no good timeout. Let's not even go there, if device goes
> bad it should set the need reset bit.

The problem is that we can't depend on the device. If it takes too
long for the device to respond to cvq, there's a high possibility that
the device is buggy or even malicious. We can have a higher timeout
here and it should be still better than waiting forever (the cvq
commands need to be serialized so it needs to hold a lock anyway
(RTNL) ).

Thanks

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
