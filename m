Return-Path: <SRS0=bZ0l=OF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAACC433EF
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 03:18:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F095B61209
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 03:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F095B61209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 285FD60AFC;
	Wed, 15 Sep 2021 03:18:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wX5wgyZXvxsz; Wed, 15 Sep 2021 03:18:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C2033606E0;
	Wed, 15 Sep 2021 03:18:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 824B0C0011;
	Wed, 15 Sep 2021 03:18:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B94AC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 03:18:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 63C5B40500
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 03:18:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xv6_zHTKFvMv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 03:18:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4F87F404FC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 03:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631675900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G9OTi+I6mElAnVtqWJXABEPv/vr+kKCZOit8WTNNJF8=;
 b=V79Q6x4WGO4LpM9kZliPm7V6JVYl8rancZm7CdAzqfWWhepRQqXlSGXh837dDhnpjtTwt3
 SXhIiJhxg86cMoc3IiWHBH7TGldUrzTdbCMyHEimiEK5eByBw7Z57DDL/KKLQheVCHkUhr
 0v5ItkWJ+TLTOB6f9gVaMtQSRGjqSbU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-pRgZ8fOFOsWEGsAKdoJNuw-1; Tue, 14 Sep 2021 23:18:19 -0400
X-MC-Unique: pRgZ8fOFOsWEGsAKdoJNuw-1
Received: by mail-lf1-f72.google.com with SMTP id
 q5-20020ac25fc5000000b003d9227d9edcso520700lfg.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 20:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G9OTi+I6mElAnVtqWJXABEPv/vr+kKCZOit8WTNNJF8=;
 b=AabqmJFUcnJ091o6YqqNk8sXb6NcrD9qXSsaSrfSEIBUUcsF2K6Vcl66TLxy/CrYYm
 bVrWFgI/RxjN6ZhyAQI8ZgkycoZ2ABEEDMxsVLcP2qGZuiIGXNXCNOFhzAmQkDfkR0Fn
 cna3fWF6zIyY3TyRR7JzNmIYUm494P/xx+T+GVG6Enh0JsnKz/w2qItmZfOubvHHSl6i
 oPQMReDtPFJ/IZI8KzG3w+PhlcP1rh7hW9Eylt/XWNOR2kmpMWxUrMqtmz/kIQd2W+jZ
 1gC5bWxvJCwqc2wUcKYDQUyq0IXs6mflTz51sS5WmXTK1Yfo/QuuFqqoVVo+FG+PFRpH
 gF+g==
X-Gm-Message-State: AOAM533PKPI3upLvFZvvYs6Sw+wwwTOGQRoJvau5EDeOFzMHLSfJXmPX
 4QZ5P/1ITBgAspofbnuulWceeqbxU5U5xpqbnohRoB21VkAEiZ6rYUqHuMojKnnPIb3SCPGL9HK
 xs8wvkZ+OT1YZnK8ttozijHFjeev8ZfeAj2VovkKcq58oqLQvVBX+CjzEUg==
X-Received: by 2002:a05:6512:110b:: with SMTP id
 l11mr15482562lfg.199.1631675897629; 
 Tue, 14 Sep 2021 20:18:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxViT8vFiqnR4GYSzaBHxKHxPutxAUmMnRBJ8kFY85O+uo5Tk3lj53Fwai7Z6rjx0PWRSkkVW15fi6Tsfj9y44=
X-Received: by 2002:a05:6512:110b:: with SMTP id
 l11mr15482553lfg.199.1631675897429; 
 Tue, 14 Sep 2021 20:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
 <20210914085711-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210914085711-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Sep 2021 11:18:06 +0800
Message-ID: <CACGkMEu3RUGpe74Vh-FAZD3MwOC3gqU0OEf8A1ULvq7GSMm6Jg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] vdpa: add new vdpa attribute
 VDPA_ATTR_DEV_F_VERSION_1
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Tue, Sep 14, 2021 at 8:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Sep 14, 2021 at 08:24:51PM +0800, Wu Zongyong wrote:
> > This new attribute advertises whether the vdpa device is legacy or not.
> > Users can pick right virtqueue size if the vdpa device is legacy which
> > doesn't support to change virtqueue size.
> >
> > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
>
> So if we are bothering with legacy,

I think we'd better not. I guess the following may work:

1) disable the driver on BE host
2) present VERSION_1 with ACCESS_PLATFORM in get_features()
3) extend the management to advertise max_queue_size and
min_queue_size, for ENI they are the same so management layer knows it
needs to set the queue_size correctly during launching qemu

Thoughts?

Thanks

> I think there are
> several things to do when building the interface
> - support transitional devices, that is allow userspace
>   to tell device it's in legacy mode
> - support reporting/setting supporting endian-ness
>
> > ---
> >  drivers/vdpa/vdpa.c          | 6 ++++++
> >  drivers/virtio/virtio_vdpa.c | 7 ++++++-
> >  include/uapi/linux/vdpa.h    | 1 +
> >  3 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index 1dc121a07a93..533d7f589eee 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/vdpa.h>
> >  #include <uapi/linux/vdpa.h>
> > +#include <uapi/linux/virtio_config.h>
> >  #include <net/genetlink.h>
> >  #include <linux/mod_devicetable.h>
> >
> > @@ -494,6 +495,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> >       u16 max_vq_size;
> >       u32 device_id;
> >       u32 vendor_id;
> > +     u64 features;
> >       void *hdr;
> >       int err;
> >
> > @@ -508,6 +510,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> >       device_id = vdev->config->get_device_id(vdev);
> >       vendor_id = vdev->config->get_vendor_id(vdev);
> >       max_vq_size = vdev->config->get_vq_num_max(vdev);
> > +     features = vdev->config->get_features(vdev);
> >
> >       err = -EMSGSIZE;
> >       if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
> > @@ -520,6 +523,9 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> >               goto msg_err;
> >       if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
> >               goto msg_err;
> > +     if (features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> > +         nla_put_flag(msg, VDPA_ATTR_DEV_VERSION_1))
> > +             goto msg_err;
> >
> >       genlmsg_end(msg, hdr);
> >       return 0;
> > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > index 72eaef2caeb1..1cba957c4cdc 100644
> > --- a/drivers/virtio/virtio_vdpa.c
> > +++ b/drivers/virtio/virtio_vdpa.c
> > @@ -7,6 +7,7 @@
> >   *
> >   */
> >
> > +#include "linux/virtio_config.h"
> >  #include <linux/init.h>
> >  #include <linux/module.h>
> >  #include <linux/device.h>
> > @@ -145,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> >       /* Assume split virtqueue, switch to packed if necessary */
> >       struct vdpa_vq_state state = {0};
> >       unsigned long flags;
> > +     bool may_reduce_num = false;
> >       u32 align, num;
> >       int err;
> >
> > @@ -169,10 +171,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> >               goto error_new_virtqueue;
> >       }
> >
> > +     if (ops->get_features(vdpa) & BIT_ULL(VIRTIO_F_VERSION_1))
> > +             may_reduce_num = true;
> > +
> >       /* Create the vring */
> >       align = ops->get_vq_align(vdpa);
> >       vq = vring_create_virtqueue(index, num, align, vdev,
> > -                                 true, true, ctx,
> > +                                 true, may_reduce_num, ctx,
> >                                   virtio_vdpa_notify, callback, name);
> >       if (!vq) {
> >               err = -ENOMEM;
> > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > index 66a41e4ec163..ce0b74276a5b 100644
> > --- a/include/uapi/linux/vdpa.h
> > +++ b/include/uapi/linux/vdpa.h
> > @@ -32,6 +32,7 @@ enum vdpa_attr {
> >       VDPA_ATTR_DEV_VENDOR_ID,                /* u32 */
> >       VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
> >       VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> > +     VDPA_ATTR_DEV_VERSION_1,                /* flag */
> >
> >       /* new attributes must be added above here */
> >       VDPA_ATTR_MAX,
> > --
> > 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
