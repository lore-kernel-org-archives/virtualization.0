Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9E1C4338F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 02:56:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FA4611C8
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 02:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 16FA4611C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D598660BA4;
	Tue, 24 Aug 2021 02:56:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AgmCVLIsys2T; Tue, 24 Aug 2021 02:56:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6D3A260B8B;
	Tue, 24 Aug 2021 02:56:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48DADC0010;
	Tue, 24 Aug 2021 02:56:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5642C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 02:56:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8EF4280FFF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 02:56:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F8q74DYAm-XG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 02:56:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB77580FD7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 02:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629773800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6T5JAPZVa1j86BfQYVY4oz5vWxgay/VARFozO23Y+KY=;
 b=GB4LVvpkXjTlXGxPCT4I13/j7jncBoM1NvGCAwbd2+/ZTFYjboumBfzJn/GieiyZmFplm7
 J6GYLLXi5ZvLyZO5A+gWh2Ffyeyrg7Sore5o8Grc+b4w9jQ3FhcTZNkLvozmkMIgRz58y5
 bqzBdHd9HiAUDAsAzsGpuNrpUklM0kw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-Jwa9KrgZM66SEdteScqu-A-1; Mon, 23 Aug 2021 22:56:39 -0400
X-MC-Unique: Jwa9KrgZM66SEdteScqu-A-1
Received: by mail-lf1-f70.google.com with SMTP id
 d21-20020a05651233d500b003cd423f70efso5626622lfg.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 19:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6T5JAPZVa1j86BfQYVY4oz5vWxgay/VARFozO23Y+KY=;
 b=cJEt3IhepjZFSY6hxooGLdo0BfFky7Pc0zVT/eBwuH87vIRxvKRXKrkcn8JWOPZt8w
 shfZFEfAMOG3pK2bei5a5pwl5YXsX54K5ezy5dK4NbKGIk0miXd20+YnT5Tua6mGSebD
 77cXwhiWTMRTPg7+zI0N2rHGC15bNUzjq8VmTmC4BfoOQooEm0lKt1vF5vCa6fBiwPZJ
 Qydf4s0mOyxGoyWTo74iW/1LKxJW4F+bqAt9zQDVsI9p1SpG7SGGkxGLfwaTl7oGneAk
 KlUStOOZxPqGSpImGXtUf8YDMqeO/wQnmQpu9EkDHaXgzwz4/StA4UpY6x+OgeUfHyq2
 A0Ow==
X-Gm-Message-State: AOAM531BHHWv1fSfl1/9kivf3BuQa39Erv9jLnqD3u8ak9W9SoJ4Iotn
 Knevx8GjRv4dLTkCqnSr+75iaYyekTUmRy4dm1NuNPtvxU99c14WqEpqOE85fBXtaek/BsCunfy
 9P+jpFLne9EliqbA88TY1017JKwCFK34x9YtipHyCBzyplYtyY6CG2pkr6g==
X-Received: by 2002:ac2:5e7a:: with SMTP id a26mr27408935lfr.312.1629773797708; 
 Mon, 23 Aug 2021 19:56:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygN5Mp6svg11K/9VEguoba3q4eEUcZcOAs1YmNXhHdqBM6qZVfDQCXZvrAlkEnufKmKVwkrzwSGyn7HWxTtX0=
X-Received: by 2002:ac2:5e7a:: with SMTP id a26mr27408919lfr.312.1629773797467; 
 Mon, 23 Aug 2021 19:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210823081437.14274-1-vincent.whitchurch@axis.com>
 <20210823171609-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210823171609-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Aug 2021 10:56:26 +0800
Message-ID: <CACGkMEvR6GVfgSCDvFWvHJ3UryN4GOMDQhWMSAAqVHsbfAfPiA@mail.gmail.com>
Subject: Re: [PATCH] vhost: add support for mandatory barriers
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm <kvm@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>, kernel@axis.com
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

On Tue, Aug 24, 2021 at 5:20 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Aug 23, 2021 at 10:14:37AM +0200, Vincent Whitchurch wrote:
> > vhost always uses SMP-conditional barriers, but these may not be
> > sufficient when vhost is used to communicate between heterogeneous
> > processors in an AMP configuration, especially since they're NOPs on
> > !SMP builds.
> >
> > To solve this, use the virtio_*() barrier functions and ask them for
> > non-weak barriers if requested by userspace.
> >
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
>
> I am inclined to say let's (ab)use VIRTIO_F_ORDER_PLATFORM for this.
> Jason what do you think?

Yes, it looks fine to me.

>
> Also is the use of DMA variants really the intended thing here? Could
> you point me at some examples please?

Yes, we need to know which setup we need.

Thanks

>
>
> > ---
> >  drivers/vhost/vhost.c      | 23 ++++++++++++++---------
> >  drivers/vhost/vhost.h      |  2 ++
> >  include/uapi/linux/vhost.h |  2 ++
> >  3 files changed, 18 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index b9e853e6094d..f7172e1bc395 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -500,6 +500,7 @@ void vhost_dev_init(struct vhost_dev *dev,
> >               vq->indirect = NULL;
> >               vq->heads = NULL;
> >               vq->dev = dev;
> > +             vq->weak_barriers = true;
> >               mutex_init(&vq->mutex);
> >               vhost_vq_reset(dev, vq);
> >               if (vq->handle_kick)
> > @@ -1801,6 +1802,10 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> >               if (ctx)
> >                       eventfd_ctx_put(ctx);
> >               break;
> > +     case VHOST_SET_STRONG_BARRIERS:
> > +             for (i = 0; i < d->nvqs; ++i)
> > +                     d->vqs[i]->weak_barriers = false;
> > +             break;
> >       default:
> >               r = -ENOIOCTLCMD;
> >               break;
> > @@ -1927,7 +1932,7 @@ int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
> >       int i, r;
> >
> >       /* Make sure data written is seen before log. */
> > -     smp_wmb();
> > +     virtio_wmb(vq->weak_barriers);
> >
> >       if (vq->iotlb) {
> >               for (i = 0; i < count; i++) {
> > @@ -1964,7 +1969,7 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
> >               return -EFAULT;
> >       if (unlikely(vq->log_used)) {
> >               /* Make sure the flag is seen before log. */
> > -             smp_wmb();
> > +             virtio_wmb(vq->weak_barriers);
> >               /* Log used flag write. */
> >               used = &vq->used->flags;
> >               log_used(vq, (used - (void __user *)vq->used),
> > @@ -1982,7 +1987,7 @@ static int vhost_update_avail_event(struct vhost_virtqueue *vq, u16 avail_event)
> >       if (unlikely(vq->log_used)) {
> >               void __user *used;
> >               /* Make sure the event is seen before log. */
> > -             smp_wmb();
> > +             virtio_wmb(vq->weak_barriers);
> >               /* Log avail event write */
> >               used = vhost_avail_event(vq);
> >               log_used(vq, (used - (void __user *)vq->used),
> > @@ -2228,7 +2233,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
> >               /* Only get avail ring entries after they have been
> >                * exposed by guest.
> >                */
> > -             smp_rmb();
> > +             virtio_rmb(vq->weak_barriers);
> >       }
> >
> >       /* Grab the next descriptor number they're advertising, and increment
> > @@ -2367,7 +2372,7 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
> >       }
> >       if (unlikely(vq->log_used)) {
> >               /* Make sure data is seen before log. */
> > -             smp_wmb();
> > +             virtio_wmb(vq->weak_barriers);
> >               /* Log used ring entry write. */
> >               log_used(vq, ((void __user *)used - (void __user *)vq->used),
> >                        count * sizeof *used);
> > @@ -2402,14 +2407,14 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
> >       r = __vhost_add_used_n(vq, heads, count);
> >
> >       /* Make sure buffer is written before we update index. */
> > -     smp_wmb();
> > +     virtio_wmb(vq->weak_barriers);
> >       if (vhost_put_used_idx(vq)) {
> >               vq_err(vq, "Failed to increment used idx");
> >               return -EFAULT;
> >       }
> >       if (unlikely(vq->log_used)) {
> >               /* Make sure used idx is seen before log. */
> > -             smp_wmb();
> > +             virtio_wmb(vq->weak_barriers);
> >               /* Log used index update. */
> >               log_used(vq, offsetof(struct vring_used, idx),
> >                        sizeof vq->used->idx);
> > @@ -2428,7 +2433,7 @@ static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
> >       /* Flush out used index updates. This is paired
> >        * with the barrier that the Guest executes when enabling
> >        * interrupts. */
> > -     smp_mb();
> > +     virtio_mb(vq->weak_barriers);
> >
> >       if (vhost_has_feature(vq, VIRTIO_F_NOTIFY_ON_EMPTY) &&
> >           unlikely(vq->avail_idx == vq->last_avail_idx))
> > @@ -2530,7 +2535,7 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
> >       }
> >       /* They could have slipped one in as we were doing that: make
> >        * sure it's written, then check again. */
> > -     smp_mb();
> > +     virtio_mb(vq->weak_barriers);
> >       r = vhost_get_avail_idx(vq, &avail_idx);
> >       if (r) {
> >               vq_err(vq, "Failed to check avail idx at %p: %d\n",
> > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > index 638bb640d6b4..5bd20d0db457 100644
> > --- a/drivers/vhost/vhost.h
> > +++ b/drivers/vhost/vhost.h
> > @@ -108,6 +108,8 @@ struct vhost_virtqueue {
> >       bool log_used;
> >       u64 log_addr;
> >
> > +     bool weak_barriers;
> > +
> >       struct iovec iov[UIO_MAXIOV];
> >       struct iovec iotlb_iov[64];
> >       struct iovec *indirect;
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index c998860d7bbc..4b8656307f51 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -97,6 +97,8 @@
> >  #define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
> >  #define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
> >
> > +#define VHOST_SET_STRONG_BARRIERS _IO(VHOST_VIRTIO, 0x27)
> > +
> >  /* VHOST_NET specific defines */
> >
> >  /* Attach virtio net ring to a raw socket, or tap device.
> > --
> > 2.28.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
