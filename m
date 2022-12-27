Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7902C10F1B
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 07:19:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 93BB4400D1;
	Tue, 27 Dec 2022 07:19:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 93BB4400D1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FOIP3JLo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t-00OJ5-nqkW; Tue, 27 Dec 2022 07:19:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 05F53403A7;
	Tue, 27 Dec 2022 07:19:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 05F53403A7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1F6BC0035;
	Tue, 27 Dec 2022 07:19:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67557C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:19:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B0F981261
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:19:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B0F981261
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FOIP3JLo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cmwk7svOB5Wg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:19:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4477C81240
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4477C81240
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672125588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pls6iOSWC2kFyaUSWKPdUzM+kGf/u8clfUMg06KjZTI=;
 b=FOIP3JLo8UIpCJzQ5aCK2T0F8WS3VM4SSYA25mYCQLlZzURtjafsO8YwC0I918ZZ2szP0o
 /sFV0K6PV+XY1f7kDrwQ8mI5gbR9eK9xSvOz9QVmCIHQOPMoOTbYfjqAKLgeIKo3FXypLu
 JDDKejt2QJho2iYcosbLr5tjmPMm2wQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-520-SSS7DioNPBWWOFp2PjBxHA-1; Tue, 27 Dec 2022 02:19:46 -0500
X-MC-Unique: SSS7DioNPBWWOFp2PjBxHA-1
Received: by mail-wr1-f70.google.com with SMTP id
 d6-20020adfa346000000b0024211c0f988so1654032wrb.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pls6iOSWC2kFyaUSWKPdUzM+kGf/u8clfUMg06KjZTI=;
 b=47pWNQnCC24JIT20bOpr2xmdYBrs7n1ZKRB+RPqMGHqm6EKPXLHEudnAu/3ejecN46
 zucXJhEWfcpLP2a8DVmHBX1c6R7RnP+tftthFwSBk4gjsabOI+KXmjePFCvj3SPUellk
 lP0GCq5/1ZtN+hDpHHiR2uzKlH8Jvu37pmLRP4xeprQCAycFGeKA/Qvb3S8a0irDFk5v
 J2wYVf+3EATrO9RrURxaH509UWXT0d9vHWuiGv7JSPUTMbU4XePSKRsrEi/YCN0/PlP2
 K37LDMGEGCOfVIgZ5Lu7gvT8Roc9FlJKXJs9Nfl9c/m4EjKX7Nc9WwxdKR+f3R3ncIbY
 LgvA==
X-Gm-Message-State: AFqh2krnvlsT9K4+suMlKR/8YN/LqmeNf8kREA5GxI1tYCGUcHZ8iaZc
 QE9EOWSWm3nJi6ilichygTMdvdSA/+NiU5P4PYaSPhvS3zQumHZLcParE4pebtIGuthK8z4ZAFw
 6EkoopE1HvV75nTdzLRACJffKyzH2cfx2KaZDyV5GXQ==
X-Received: by 2002:a05:600c:1503:b0:3d0:8722:a145 with SMTP id
 b3-20020a05600c150300b003d08722a145mr14221009wmg.40.1672125585676; 
 Mon, 26 Dec 2022 23:19:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs4Rwxf/qElXmIkV+f5TlWcPongqSwfRMKdgNis+qiC5BcIaaL4H6iGFlspXDoj13H5xyeZFQ==
X-Received: by 2002:a05:600c:1503:b0:3d0:8722:a145 with SMTP id
 b3-20020a05600c150300b003d08722a145mr14220994wmg.40.1672125585449; 
 Mon, 26 Dec 2022 23:19:45 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 r9-20020a05600c35c900b003d6b71c0c92sm28458756wmq.45.2022.12.26.23.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Dec 2022 23:19:44 -0800 (PST)
Date: Tue, 27 Dec 2022 02:19:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
Message-ID: <20221227020901-mutt-send-email-mst@kernel.org>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-4-jasowang@redhat.com>
 <20221226183348-mutt-send-email-mst@kernel.org>
 <CACGkMEsJYn=4mC-+QKnkHi+zjZsRL+m+mdyuLemPhsZDi_hcEw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsJYn=4mC-+QKnkHi+zjZsRL+m+mdyuLemPhsZDi_hcEw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Tue, Dec 27, 2022 at 11:47:34AM +0800, Jason Wang wrote:
> On Tue, Dec 27, 2022 at 7:34 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Dec 26, 2022 at 03:49:07PM +0800, Jason Wang wrote:
> > > This patch introduces a per virtqueue waitqueue to allow driver to
> > > sleep and wait for more used. Two new helpers are introduced to allow
> > > driver to sleep and wake up.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > Changes since V1:
> > > - check virtqueue_is_broken() as well
> > > - use more_used() instead of virtqueue_get_buf() to allow caller to
> > >   get buffers afterwards
> > > ---
> > >  drivers/virtio/virtio_ring.c | 29 +++++++++++++++++++++++++++++
> > >  include/linux/virtio.h       |  3 +++
> > >  2 files changed, 32 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 5cfb2fa8abee..9c83eb945493 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -13,6 +13,7 @@
> > >  #include <linux/dma-mapping.h>
> > >  #include <linux/kmsan.h>
> > >  #include <linux/spinlock.h>
> > > +#include <linux/wait.h>
> > >  #include <xen/xen.h>
> > >
> > >  #ifdef DEBUG
> > > @@ -60,6 +61,7 @@
> > >                       "%s:"fmt, (_vq)->vq.name, ##args);      \
> > >               /* Pairs with READ_ONCE() in virtqueue_is_broken(). */ \
> > >               WRITE_ONCE((_vq)->broken, true);                       \
> > > +             wake_up_interruptible(&(_vq)->wq);                     \
> > >       } while (0)
> > >  #define START_USE(vq)
> > >  #define END_USE(vq)
> > > @@ -203,6 +205,9 @@ struct vring_virtqueue {
> > >       /* DMA, allocation, and size information */
> > >       bool we_own_ring;
> > >
> > > +     /* Wait for buffer to be used */
> > > +     wait_queue_head_t wq;
> > > +
> > >  #ifdef DEBUG
> > >       /* They're supposed to lock for us. */
> > >       unsigned int in_use;
> > > @@ -2024,6 +2029,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > >       if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> > >               vq->weak_barriers = false;
> > >
> > > +     init_waitqueue_head(&vq->wq);
> > > +
> > >       err = vring_alloc_state_extra_packed(&vring_packed);
> > >       if (err)
> > >               goto err_state_extra;
> > > @@ -2517,6 +2524,8 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
> > >       if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> > >               vq->weak_barriers = false;
> > >
> > > +     init_waitqueue_head(&vq->wq);
> > > +
> > >       err = vring_alloc_state_extra_split(vring_split);
> > >       if (err) {
> > >               kfree(vq);
> > > @@ -2654,6 +2663,8 @@ static void vring_free(struct virtqueue *_vq)
> > >  {
> > >       struct vring_virtqueue *vq = to_vvq(_vq);
> > >
> > > +     wake_up_interruptible(&vq->wq);
> > > +
> > >       if (vq->we_own_ring) {
> > >               if (vq->packed_ring) {
> > >                       vring_free_queue(vq->vq.vdev,
> > > @@ -2863,4 +2874,22 @@ const struct vring *virtqueue_get_vring(struct virtqueue *vq)
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_get_vring);
> > >
> > > +int virtqueue_wait_for_used(struct virtqueue *_vq)
> > > +{
> > > +     struct vring_virtqueue *vq = to_vvq(_vq);
> > > +
> > > +     /* TODO: Tweak the timeout. */
> > > +     return wait_event_interruptible_timeout(vq->wq,
> > > +            virtqueue_is_broken(_vq) || more_used(vq), HZ);
> >
> > There's no good timeout. Let's not even go there, if device goes
> > bad it should set the need reset bit.
> 
> The problem is that we can't depend on the device. If it takes too
> long for the device to respond to cvq, there's a high possibility that
> the device is buggy or even malicious. We can have a higher timeout
> here and it should be still better than waiting forever (the cvq
> commands need to be serialized so it needs to hold a lock anyway
> (RTNL) ).
> 
> Thanks

With a TODO item like this I'd expect this to be an RFC.
Here's why:

Making driver more robust from device failures is a laudable goal but it's really
hard to be 100% foolproof here. E.g. device can just block pci reads and
it would be very hard to recover.  So I'm going to only merge patches
like this if they at least theoretically have very little chance
of breaking existing users.

And note that in most setups, CVQ is only used at startup and then left mostly alone.

Finally, note that lots of guests need virtio to do anything useful at all.
So just failing commands is not enough to recover - you need to try
harder maybe by attempting to reset device. Could be a question of
policy - might need to make this guest configurable.



> >
> >
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtqueue_wait_for_used);
> > > +
> > > +void virtqueue_wake_up(struct virtqueue *_vq)
> > > +{
> > > +     struct vring_virtqueue *vq = to_vvq(_vq);
> > > +
> > > +     wake_up_interruptible(&vq->wq);
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtqueue_wake_up);
> > > +
> > >  MODULE_LICENSE("GPL");
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index dcab9c7e8784..2eb62c774895 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -72,6 +72,9 @@ void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
> > >  void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
> > >                           void **ctx);
> > >
> > > +int virtqueue_wait_for_used(struct virtqueue *vq);
> > > +void virtqueue_wake_up(struct virtqueue *vq);
> > > +
> > >  void virtqueue_disable_cb(struct virtqueue *vq);
> > >
> > >  bool virtqueue_enable_cb(struct virtqueue *vq);
> > > --
> > > 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
