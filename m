Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630F9C636D6
	for <virtualization@archiver.kernel.org>; Tue, 21 Feb 2023 01:52:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D81581326;
	Tue, 21 Feb 2023 01:52:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D81581326
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LVDvfbVa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GwLYBq8iEulG; Tue, 21 Feb 2023 01:52:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 98BC581345;
	Tue, 21 Feb 2023 01:52:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98BC581345
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F6FCC0033;
	Tue, 21 Feb 2023 01:52:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 518E2C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 01:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AEEB7016D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 01:52:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2AEEB7016D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LVDvfbVa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8ylb9jgOhFPO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 01:52:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 602747002A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 602747002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 01:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676944320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7FZmDnCF/GxqpYxKaOIZUBnqq5magBE44Cwmnq/VtAo=;
 b=LVDvfbVav7e4+2eXsJsnyB02Bb4xWtradK+Gpz9+9fGL7N3kfXGAZw8egZgCR/LOm49jvc
 b4bm/evkyotUDj1XtRUnKFYwMrtq2zk1eYLZEPu4l48bJCJ1n+1P6bfEjzFxrb2OBlAIMe
 1pi9jPCvZFL4Rs6m9M9ErAAEeZc9ejs=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-kWk2QZjhMdSv_CP8Q1QXBQ-1; Mon, 20 Feb 2023 20:51:58 -0500
X-MC-Unique: kWk2QZjhMdSv_CP8Q1QXBQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 e137-20020a4a558f000000b0051a14b3d779so578895oob.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 17:51:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7FZmDnCF/GxqpYxKaOIZUBnqq5magBE44Cwmnq/VtAo=;
 b=YwoGjVjRlGXZCO/itlv8nG97sLesnHTW02VLch/xtKGcLGT6OsGTThO5l2p7+uldY0
 ATiXhqsiSEETO26E8ZHv0vnEq4Y6OGxBMHJ2aR3M//ajSl5EW12LCW5ZT2l6w2ivqCo8
 aPwTzNO3+C7vncZ0GnG4+5BaTlu0hJ2q4suLcdfRf1yEos93ZtJQipbcfV22FmQ/4AZs
 wol8fuAfG0cbXjsfhuVjfCP4/AtSL0avbavtCxSbH4iXT+pH2/mh8gL/Rnema+ixgg11
 x78YMjDj+A+/gY+KmJ3+cMyBE3kXotFdfHjenOb56U8lkkOD853WqrAb595A6NWlSEIn
 ipKQ==
X-Gm-Message-State: AO0yUKXk+0mrt9nXF818N86n7eiSu67Uz41Kz/tRcLOH4oB9GCJKtAtK
 l+37x9k8agMEmMVHFAZ2kh71JqCEisufv/xy642iIpL+68PS2u38u70+Yg48Np7ujc00c/iSEht
 RDu+rq3yP42YoSfUFrL+8O685UuknaouyAcNiHKIbyyXHtWxvjtSEoPb87A==
X-Received: by 2002:a05:6808:1812:b0:37a:3ebc:d282 with SMTP id
 bh18-20020a056808181200b0037a3ebcd282mr1150987oib.217.1676944318018; 
 Mon, 20 Feb 2023 17:51:58 -0800 (PST)
X-Google-Smtp-Source: AK7set/GjYip3wHIPhRfPyN98PmUvbkKFs1cSCRV4f2WKu5jPh4x07TnE2GU1e/I0nASxZtWt5MQO3ugvRlz5K+jU44=
X-Received: by 2002:a05:6808:1812:b0:37a:3ebc:d282 with SMTP id
 bh18-20020a056808181200b0037a3ebcd282mr1150983oib.217.1676944317762; Mon, 20
 Feb 2023 17:51:57 -0800 (PST)
MIME-Version: 1.0
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
 <20230214072704.126660-11-xuanzhuo@linux.alibaba.com>
 <CACGkMEtYxLp93m25hFA=xn_kVCh6eHD92CZq=SWGgNDE3c41Jw@mail.gmail.com>
 <1676876639.3591576-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1676876639.3591576-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Feb 2023 09:51:46 +0800
Message-ID: <CACGkMEvZat9wj3Wjr0GMgoXcM5CTcrfTmtWhyWcKrJKsgTXvEw@mail.gmail.com>
Subject: Re: [PATCH vhost 10/10] virtio_ring: introduce virtqueue_reset()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

On Mon, Feb 20, 2023 at 3:04 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Mon, 20 Feb 2023 13:38:30 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Tue, Feb 14, 2023 at 3:27 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > Introduce virtqueue_reset() to release all buffer inside vq.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 50 ++++++++++++++++++++++++++++++++++++
> > >  include/linux/virtio.h       |  2 ++
> > >  2 files changed, 52 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 2ba60a14f557..2750a365439a 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -2930,6 +2930,56 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_resize);
> > >
> > > +/**
> > > + * virtqueue_reset - detach and recycle all unused buffers
> > > + * @_vq: the struct virtqueue we're talking about.
> > > + * @recycle: callback to recycle unused buffers
> > > + *
> > > + * Caller must ensure we don't call this with other virtqueue operations
> > > + * at the same time (except where noted).
> > > + *
> > > + * Returns zero or a negative error.
> > > + * 0: success.
> > > + * -EBUSY: Failed to sync with device, vq may not work properly
> > > + * -ENOENT: Transport or device not supported
> > > + * -EPERM: Operation not permitted
> > > + */
> > > +int virtqueue_reset(struct virtqueue *_vq,
> > > +                   void (*recycle)(struct virtqueue *vq, void *buf))
> > > +{
> > > +       struct vring_virtqueue *vq = to_vvq(_vq);
> > > +       struct virtio_device *vdev = vq->vq.vdev;
> > > +       void *buf;
> > > +       int err;
> > > +
> > > +       if (!vq->we_own_ring)
> > > +               return -EPERM;
> > > +
> > > +       if (!vdev->config->disable_vq_and_reset)
> > > +               return -ENOENT;
> > > +
> > > +       if (!vdev->config->enable_vq_after_reset)
> > > +               return -ENOENT;
> > > +
> > > +       err = vdev->config->disable_vq_and_reset(_vq);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       while ((buf = virtqueue_detach_unused_buf(_vq)) != NULL)
> > > +               recycle(_vq, buf);
> > > +
> > > +       if (vq->packed_ring)
> > > +               virtqueue_reinit_packed(vq);
> > > +       else
> > > +               virtqueue_reinit_split(vq);
> > > +
> > > +       if (vdev->config->enable_vq_after_reset(_vq))
> > > +               return -EBUSY;
> > > +
> > > +       return 0;
> > > +}
> >
> > I don't get why not factor the similar logic from virtqueue_resize()?
>
>
> I can do this, if you prefer this.
>
> THanks.

Please do that, reset is a step of resize if I understand correctly.

Thanks

>
>
>
> >
> > Thanks
> >
> >
> > > +EXPORT_SYMBOL_GPL(virtqueue_reset);
> > > +
> > >  /* Only available for split ring */
> > >  struct virtqueue *vring_new_virtqueue(unsigned int index,
> > >                                       unsigned int num,
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index d0e707d744a0..cf4c157e4e75 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -106,6 +106,8 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
> > >
> > >  int virtqueue_resize(struct virtqueue *vq, u32 num,
> > >                      void (*recycle)(struct virtqueue *vq, void *buf));
> > > +int virtqueue_reset(struct virtqueue *vq,
> > > +                   void (*recycle)(struct virtqueue *vq, void *buf));
> > >
> > >  /**
> > >   * struct virtio_device - representation of a device using virtio
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
