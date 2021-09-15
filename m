Return-Path: <SRS0=bZ0l=OF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7F3C433EF
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 11:10:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01ECA61279
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 11:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 01ECA61279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF798404C2;
	Wed, 15 Sep 2021 11:10:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8xL4wgbXdo0i; Wed, 15 Sep 2021 11:10:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9E2BC404CF;
	Wed, 15 Sep 2021 11:10:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7493EC000F;
	Wed, 15 Sep 2021 11:10:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6306C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 11:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D4AD66079A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 11:10:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7tsggkUE8VL5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 11:10:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B3FED60731
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 11:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631704216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JcHCmj3cvd+64VQr8BHNTf8c//397whjwhYgQBrI9QY=;
 b=VB708mDQc2+LFwDNDzS0aTUu2TTO2LHRiLoRDTlT9wavID8LvXMH9FTB7RoD1Qr4jQECg3
 uTftbw9nFd/sSaECGRH6GDbX6r3KqWSgC9B2C6gjY/Rfz1qgDJc26mjBfb5H+c1c5AjZU6
 TIpfVNo93f4lz5ZlHhEfM6vhdfTWIeg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-TJVONbs1NjyDXET8Am5fBg-1; Wed, 15 Sep 2021 07:10:15 -0400
X-MC-Unique: TJVONbs1NjyDXET8Am5fBg-1
Received: by mail-wm1-f69.google.com with SMTP id
 g13-20020a1c200d000000b00308ecd761e8so1296623wmg.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 04:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JcHCmj3cvd+64VQr8BHNTf8c//397whjwhYgQBrI9QY=;
 b=aIGXm5rJ380/rM7dK5vfdmUOtDVvHC8E//un3UIqEgAFK/5DhZDpccQ0T4JqZ9aQ4+
 AcYK9IDz+ysdBqBwc/BRd+qkxNJgYU1otwXzP8q8ChmPEax2Ja6KC/6pLEMBHD9alQ/d
 DcrLm1p8iXTJpWFnu9IViwO+AyWKLvgO34U4PXxTFhdgjPFq3wFEhwOSAU956eanV/Zd
 09ZIZhTjXMNy8cDbSYeYTrQMs9WaNI1UH32AW9NMjri357vU/zIzas25AvA+u5xE7Oko
 OB+Zz/Tp8QYY83Kdhdhqdn7Kwd4tXujYoub0TYkxLqLrXVBsQZ9BQf3AM36RJz54psnD
 kWvA==
X-Gm-Message-State: AOAM5302aVmYLbGfRH7Dj6tHiGdu05oS1ve3dppFOtOpHn0NuXikY75D
 V0RqMgUo3N0V3JHj86sI/0vzcv9hplVLdL8Zlma/5E1h53l0e8GncfpmmsA46oQw4NMC3ELg1yi
 z0hk/UBIdkxfMZcP4n9z4/gyY8IPK/TfUWTSBewT3jA==
X-Received: by 2002:a1c:28a:: with SMTP id 132mr3739545wmc.101.1631704214198; 
 Wed, 15 Sep 2021 04:10:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwH6OAXSIvprwNUVtsxUUkCUdgcjFVIvgZKPIZ8ABVHRyPWzmIUjNkQsThbAHIbk8cVOjsSLA==
X-Received: by 2002:a1c:28a:: with SMTP id 132mr3739514wmc.101.1631704213929; 
 Wed, 15 Sep 2021 04:10:13 -0700 (PDT)
Received: from redhat.com ([2.55.157.56])
 by smtp.gmail.com with ESMTPSA id n4sm13762379wra.37.2021.09.15.04.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Sep 2021 04:10:13 -0700 (PDT)
Date: Wed, 15 Sep 2021 07:10:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 4/5] vdpa: add new vdpa attribute
 VDPA_ATTR_DEV_F_VERSION_1
Message-ID: <20210915070909-mutt-send-email-mst@kernel.org>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
 <20210914085711-mutt-send-email-mst@kernel.org>
 <20210915032453.GA18793@L-PF27918B-1352.localdomain>
 <20210915032732-mutt-send-email-mst@kernel.org>
 <CACGkMEumkCih51kENTiP9hpRbtKNkRJsR3MienZDtfBYVF73Zg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEumkCih51kENTiP9hpRbtKNkRJsR3MienZDtfBYVF73Zg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: wei.yang1@linux.alibaba.com, Wu Zongyong <wuzongyong@linux.alibaba.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, Sep 15, 2021 at 04:05:49PM +0800, Jason Wang wrote:
> On Wed, Sep 15, 2021 at 3:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Sep 15, 2021 at 11:24:53AM +0800, Wu Zongyong wrote:
> > > On Tue, Sep 14, 2021 at 08:58:28AM -0400, Michael S. Tsirkin wrote:
> > > > On Tue, Sep 14, 2021 at 08:24:51PM +0800, Wu Zongyong wrote:
> > > > > This new attribute advertises whether the vdpa device is legacy or not.
> > > > > Users can pick right virtqueue size if the vdpa device is legacy which
> > > > > doesn't support to change virtqueue size.
> > > > >
> > > > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > >
> > > > So if we are bothering with legacy, I think there are
> > > > several things to do when building the interface
> > > > - support transitional devices, that is allow userspace
> > > >   to tell device it's in legacy mode
> > > > - support reporting/setting supporting endian-ness
> > >
> > > It's true if we try to implement a general drvier for legacy.
> > > But this series is dedicated to implement a driver only for ENI. Is it
> > > necessary to implement what you said here in this series?
> >
> > To a certain degree, yes.
> >
> > I am thinking about the UAPI here. The new attribute is part of that.
> > E.g. userspace consuming this needs to be more or less hardware agnostic
> > and not depend on specifics of ENI.
> >
> > Otherwise if userspace assumes legacy==eni then it will break with
> > other hardware.
> >
> > One way to test how generic it all is would be adding legacy support in
> > the simulator.
> 
> I don't get why we need to support legacy devices e.g it doesn't have
> ACCESS_PLATFORM support. I think we should re-consider to mandate 1.0
> devices.
> 
> https://lore.kernel.org/lkml/20210408082648.20145-1-jasowang@redhat.com/
> 
> And it will complicate all of the different layers.
> 
> Thanks


It's not that we have to, it's just that imho, if we do
it's easier to just do it all in the kernel rather than spreading
parts of code around.

> >
> > > >
> > > > > ---
> > > > >  drivers/vdpa/vdpa.c          | 6 ++++++
> > > > >  drivers/virtio/virtio_vdpa.c | 7 ++++++-
> > > > >  include/uapi/linux/vdpa.h    | 1 +
> > > > >  3 files changed, 13 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > > index 1dc121a07a93..533d7f589eee 100644
> > > > > --- a/drivers/vdpa/vdpa.c
> > > > > +++ b/drivers/vdpa/vdpa.c
> > > > > @@ -12,6 +12,7 @@
> > > > >  #include <linux/slab.h>
> > > > >  #include <linux/vdpa.h>
> > > > >  #include <uapi/linux/vdpa.h>
> > > > > +#include <uapi/linux/virtio_config.h>
> > > > >  #include <net/genetlink.h>
> > > > >  #include <linux/mod_devicetable.h>
> > > > >
> > > > > @@ -494,6 +495,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > >   u16 max_vq_size;
> > > > >   u32 device_id;
> > > > >   u32 vendor_id;
> > > > > + u64 features;
> > > > >   void *hdr;
> > > > >   int err;
> > > > >
> > > > > @@ -508,6 +510,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > >   device_id = vdev->config->get_device_id(vdev);
> > > > >   vendor_id = vdev->config->get_vendor_id(vdev);
> > > > >   max_vq_size = vdev->config->get_vq_num_max(vdev);
> > > > > + features = vdev->config->get_features(vdev);
> > > > >
> > > > >   err = -EMSGSIZE;
> > > > >   if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
> > > > > @@ -520,6 +523,9 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > >           goto msg_err;
> > > > >   if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
> > > > >           goto msg_err;
> > > > > + if (features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> > > > > +     nla_put_flag(msg, VDPA_ATTR_DEV_VERSION_1))
> > > > > +         goto msg_err;
> > > > >
> > > > >   genlmsg_end(msg, hdr);
> > > > >   return 0;
> > > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > > index 72eaef2caeb1..1cba957c4cdc 100644
> > > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > > @@ -7,6 +7,7 @@
> > > > >   *
> > > > >   */
> > > > >
> > > > > +#include "linux/virtio_config.h"
> > > > >  #include <linux/init.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/device.h>
> > > > > @@ -145,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > >   /* Assume split virtqueue, switch to packed if necessary */
> > > > >   struct vdpa_vq_state state = {0};
> > > > >   unsigned long flags;
> > > > > + bool may_reduce_num = false;
> > > > >   u32 align, num;
> > > > >   int err;
> > > > >
> > > > > @@ -169,10 +171,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > >           goto error_new_virtqueue;
> > > > >   }
> > > > >
> > > > > + if (ops->get_features(vdpa) & BIT_ULL(VIRTIO_F_VERSION_1))
> > > > > +         may_reduce_num = true;
> > > > > +
> > > > >   /* Create the vring */
> > > > >   align = ops->get_vq_align(vdpa);
> > > > >   vq = vring_create_virtqueue(index, num, align, vdev,
> > > > > -                             true, true, ctx,
> > > > > +                             true, may_reduce_num, ctx,
> > > > >                               virtio_vdpa_notify, callback, name);
> > > > >   if (!vq) {
> > > > >           err = -ENOMEM;
> > > > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > > > index 66a41e4ec163..ce0b74276a5b 100644
> > > > > --- a/include/uapi/linux/vdpa.h
> > > > > +++ b/include/uapi/linux/vdpa.h
> > > > > @@ -32,6 +32,7 @@ enum vdpa_attr {
> > > > >   VDPA_ATTR_DEV_VENDOR_ID,                /* u32 */
> > > > >   VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
> > > > >   VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> > > > > + VDPA_ATTR_DEV_VERSION_1,                /* flag */
> > > > >
> > > > >   /* new attributes must be added above here */
> > > > >   VDPA_ATTR_MAX,
> > > > > --
> > > > > 2.31.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
