Return-Path: <SRS0=bZ0l=OF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454F8C433EF
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 07:38:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D756060E9B
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 07:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D756060E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92B5D60665;
	Wed, 15 Sep 2021 07:38:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u15diQQ1qKKR; Wed, 15 Sep 2021 07:38:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2BDC160017;
	Wed, 15 Sep 2021 07:38:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BA19C000F;
	Wed, 15 Sep 2021 07:38:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BCADC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 07:38:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 385DE40176
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 07:38:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BVYcL6rPTM2s
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 07:38:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1FDE54015D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 07:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631691526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xxuTIZ1YWa1NOpjkj6dZNsRUC+/dmST7iBylAM+AKQQ=;
 b=PESAaZAdVzQdd1TihnySoykGVzwUbiBBPdYnq5ljw8re97c8U9HmiD2489MWIVuzkqejry
 VLd/+p56kO/94K5Q3EErhAdB8q8JZSFTpfd776rtB+q/uda6WsVT3RnnLYaxYhJbgO7zNh
 PjxJPgO7Bi+dsHgNl5I3HqD52SeY6LI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-527d2NHvN0-kVY2_z6tb9g-1; Wed, 15 Sep 2021 03:38:36 -0400
X-MC-Unique: 527d2NHvN0-kVY2_z6tb9g-1
Received: by mail-ej1-f72.google.com with SMTP id
 ak17-20020a170906889100b005c5d1e5e707so1023648ejc.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 00:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xxuTIZ1YWa1NOpjkj6dZNsRUC+/dmST7iBylAM+AKQQ=;
 b=QGTBzv+FCkKzFuZlSs1UVwcCzxsaNmM7WRXATXkiwr0WJSz/rNqB2Qj9mfBc2X2P2/
 F03eLrmXKWrF1W/yMLEeZLBPI4O+mZPm39mghFZTWRPfYsYC+YgQ8eHlwdLHpSEjjbfi
 JOisbTHJY/HnA3qJL9FzviCHMFTTgytGT8+KRQI360PafI1xXu3CSelt+2o7jn2uXwtS
 yFC4IaEVnoox/jGD9htSaLzkFuBwkGhpgRdLca1Xaz7vGcgezBFByJJpT8KQmEg7wwPY
 v92hM+xmcY2IroGlMK0QopBv6RXmAc4Xzq/X0v4wuqIm5OxTQN6P9f6wfPWB4Ox7nIwm
 Bk0g==
X-Gm-Message-State: AOAM531KqsZC6ip8p+0GWucNcSqBhDwN9NeA58J2EdpDI9lydJEH4clx
 4RYIe7xDZy5yTBo2TIvopL6edC9zrB6Yn26vgZYrTICd1S77X7AuEXzJm/oqRhYY48ACeN6C2qe
 jvvUtSRZKFdSyMcxEdB0zPYuYeHBvf07kDISIlUjO3Q==
X-Received: by 2002:a17:906:7208:: with SMTP id
 m8mr23518953ejk.82.1631691515101; 
 Wed, 15 Sep 2021 00:38:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjJG5HmRxot3O+sRXKAYzInQI3onfnVJshUEWm0IVFrmhJ/2Pm3nYzdj3Jd9vbXIIUP6W/VQ==
X-Received: by 2002:a17:906:7208:: with SMTP id
 m8mr23518933ejk.82.1631691514844; 
 Wed, 15 Sep 2021 00:38:34 -0700 (PDT)
Received: from redhat.com ([2.55.157.56])
 by smtp.gmail.com with ESMTPSA id n3sm6657200eds.79.2021.09.15.00.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Sep 2021 00:38:34 -0700 (PDT)
Date: Wed, 15 Sep 2021 03:38:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 4/5] vdpa: add new vdpa attribute
 VDPA_ATTR_DEV_F_VERSION_1
Message-ID: <20210915033756-mutt-send-email-mst@kernel.org>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
 <20210914085711-mutt-send-email-mst@kernel.org>
 <CACGkMEu3RUGpe74Vh-FAZD3MwOC3gqU0OEf8A1ULvq7GSMm6Jg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEu3RUGpe74Vh-FAZD3MwOC3gqU0OEf8A1ULvq7GSMm6Jg@mail.gmail.com>
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

On Wed, Sep 15, 2021 at 11:18:06AM +0800, Jason Wang wrote:
> On Tue, Sep 14, 2021 at 8:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Sep 14, 2021 at 08:24:51PM +0800, Wu Zongyong wrote:
> > > This new attribute advertises whether the vdpa device is legacy or not.
> > > Users can pick right virtqueue size if the vdpa device is legacy which
> > > doesn't support to change virtqueue size.
> > >
> > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> >
> > So if we are bothering with legacy,
> 
> I think we'd better not. I guess the following may work:
> 
> 1) disable the driver on BE host
> 2) present VERSION_1 with ACCESS_PLATFORM in get_features()
> 3) extend the management to advertise max_queue_size and
> min_queue_size, for ENI they are the same so management layer knows it
> needs to set the queue_size correctly during launching qemu
> 
> Thoughts?
> 
> Thanks

There are other subtle differences such as header size without
mergeable buffers for net.


> > I think there are
> > several things to do when building the interface
> > - support transitional devices, that is allow userspace
> >   to tell device it's in legacy mode
> > - support reporting/setting supporting endian-ness
> >
> > > ---
> > >  drivers/vdpa/vdpa.c          | 6 ++++++
> > >  drivers/virtio/virtio_vdpa.c | 7 ++++++-
> > >  include/uapi/linux/vdpa.h    | 1 +
> > >  3 files changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > index 1dc121a07a93..533d7f589eee 100644
> > > --- a/drivers/vdpa/vdpa.c
> > > +++ b/drivers/vdpa/vdpa.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/vdpa.h>
> > >  #include <uapi/linux/vdpa.h>
> > > +#include <uapi/linux/virtio_config.h>
> > >  #include <net/genetlink.h>
> > >  #include <linux/mod_devicetable.h>
> > >
> > > @@ -494,6 +495,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > >       u16 max_vq_size;
> > >       u32 device_id;
> > >       u32 vendor_id;
> > > +     u64 features;
> > >       void *hdr;
> > >       int err;
> > >
> > > @@ -508,6 +510,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > >       device_id = vdev->config->get_device_id(vdev);
> > >       vendor_id = vdev->config->get_vendor_id(vdev);
> > >       max_vq_size = vdev->config->get_vq_num_max(vdev);
> > > +     features = vdev->config->get_features(vdev);
> > >
> > >       err = -EMSGSIZE;
> > >       if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
> > > @@ -520,6 +523,9 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > >               goto msg_err;
> > >       if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
> > >               goto msg_err;
> > > +     if (features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> > > +         nla_put_flag(msg, VDPA_ATTR_DEV_VERSION_1))
> > > +             goto msg_err;
> > >
> > >       genlmsg_end(msg, hdr);
> > >       return 0;
> > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > index 72eaef2caeb1..1cba957c4cdc 100644
> > > --- a/drivers/virtio/virtio_vdpa.c
> > > +++ b/drivers/virtio/virtio_vdpa.c
> > > @@ -7,6 +7,7 @@
> > >   *
> > >   */
> > >
> > > +#include "linux/virtio_config.h"
> > >  #include <linux/init.h>
> > >  #include <linux/module.h>
> > >  #include <linux/device.h>
> > > @@ -145,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > >       /* Assume split virtqueue, switch to packed if necessary */
> > >       struct vdpa_vq_state state = {0};
> > >       unsigned long flags;
> > > +     bool may_reduce_num = false;
> > >       u32 align, num;
> > >       int err;
> > >
> > > @@ -169,10 +171,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > >               goto error_new_virtqueue;
> > >       }
> > >
> > > +     if (ops->get_features(vdpa) & BIT_ULL(VIRTIO_F_VERSION_1))
> > > +             may_reduce_num = true;
> > > +
> > >       /* Create the vring */
> > >       align = ops->get_vq_align(vdpa);
> > >       vq = vring_create_virtqueue(index, num, align, vdev,
> > > -                                 true, true, ctx,
> > > +                                 true, may_reduce_num, ctx,
> > >                                   virtio_vdpa_notify, callback, name);
> > >       if (!vq) {
> > >               err = -ENOMEM;
> > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > index 66a41e4ec163..ce0b74276a5b 100644
> > > --- a/include/uapi/linux/vdpa.h
> > > +++ b/include/uapi/linux/vdpa.h
> > > @@ -32,6 +32,7 @@ enum vdpa_attr {
> > >       VDPA_ATTR_DEV_VENDOR_ID,                /* u32 */
> > >       VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
> > >       VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> > > +     VDPA_ATTR_DEV_VERSION_1,                /* flag */
> > >
> > >       /* new attributes must be added above here */
> > >       VDPA_ATTR_MAX,
> > > --
> > > 2.31.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
