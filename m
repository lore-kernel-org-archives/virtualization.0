Return-Path: <SRS0=0+SM=OG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61B0C433EF
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 01:11:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74CA060234
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 01:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 74CA060234
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DFDF6138A;
	Thu, 16 Sep 2021 01:11:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XMxme2EvKhIg; Thu, 16 Sep 2021 01:11:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8F944606DA;
	Thu, 16 Sep 2021 01:11:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 609F8C000F;
	Thu, 16 Sep 2021 01:11:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48E80C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 01:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33B4040532
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 01:11:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XtdJj2H6SdUV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 01:11:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B7D0F4045A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 01:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631754695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=74EoAWXmDLcPB3Fwyw9DAw7gIYO7nWQCSI4r7V+M3G4=;
 b=NZp8KsocB6RYr5OcoyVS3XWmo4iL+338YNGVf9DeLEqNvqatZk9hShqi65Y7iSlI6B3dPt
 IFFkCEexY78/Go9W8z4Re5KTmUioUeyYV7JNqyHcl+tbic0WhEabpcMqcvCKT2mv2bdGc7
 sk7ROKQ/Pb/wDIQn2ugKxceXuYw8+Us=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-kVtyKyxaPk6nyU5_Ou0WhA-1; Wed, 15 Sep 2021 21:11:32 -0400
X-MC-Unique: kVtyKyxaPk6nyU5_Ou0WhA-1
Received: by mail-lf1-f71.google.com with SMTP id
 v137-20020a19488f000000b003e39263a61bso2378291lfa.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 18:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=74EoAWXmDLcPB3Fwyw9DAw7gIYO7nWQCSI4r7V+M3G4=;
 b=cvuz2rPidtSi73T3V1U+EmYD9fACpj18At7t6kfOjlft9WwfR0Bfvpj1ID1zvQAJmD
 BCzE45qNiOemgPMxRTCK47sI493ApPrD67o9a4/F2P97f6kyC/FHoMub9z2lnZYJrSXq
 w/SZJGF4wUNXDmxy1q+Mk3o+YjGfaPZhcLwfBhBt01G2t3e9cg5hOqBoDJ8dvZREgJNI
 fZXxJcZkwN6DhJnx1P2gGeEbUeHLKacwyt6FjKDLAiOX5gJ8/AIIM7cL6MU5Ez33AUpr
 yIhzJPXASF6tGd8j9s9hSzqdUz0RqSxkOAmWcFgit3OvyUA0WAifEqP/fUOKi0jzcIhm
 EpBw==
X-Gm-Message-State: AOAM530GbQLi1D7210aD3IUc/SVbsFpgzpuRjxblU1bSNSdbNw9XT0jy
 hJWwUNFVrJ5pcrYNZ0tYzFQydGkOUzP6/+VnkT2Z9basEhagUsPAcrpF+tV/3evgtcWEPlLnx5P
 uqT9mvAyBrrcwcrVMfvtbtmRW83bNeY9km0NNSKS7On1NdWQ8JDdMf+Zmkw==
X-Received: by 2002:a05:6512:32ca:: with SMTP id
 f10mr2106909lfg.498.1631754690413; 
 Wed, 15 Sep 2021 18:11:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxP1/lkCjy0c5KBp7+YpaUFk/F4bQxl89FXrFCbmOGahKvr7nn8im10RqULlylwzHu2Ebfx6BUAmWntkN5RCR4=
X-Received: by 2002:a05:6512:32ca:: with SMTP id
 f10mr2106898lfg.498.1631754690171; 
 Wed, 15 Sep 2021 18:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
 <20210914085711-mutt-send-email-mst@kernel.org>
 <CACGkMEu3RUGpe74Vh-FAZD3MwOC3gqU0OEf8A1ULvq7GSMm6Jg@mail.gmail.com>
 <20210915033756-mutt-send-email-mst@kernel.org>
 <CACGkMEtN0Z=rgMhaWNO=6h-KXGdosBuOdqoWoND-=Tf+afyUYw@mail.gmail.com>
 <20210915070805-mutt-send-email-mst@kernel.org>
 <20210915121234.GA19232@L-PF27918B-1352.localdomain>
In-Reply-To: <20210915121234.GA19232@L-PF27918B-1352.localdomain>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Sep 2021 09:11:19 +0800
Message-ID: <CACGkMEuJ_OpprwUDBtK0_QgNNp=xaKFEVhEmrCStBhM67WiQvg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] vdpa: add new vdpa attribute
 VDPA_ATTR_DEV_F_VERSION_1
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: wei.yang1@linux.alibaba.com,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Wed, Sep 15, 2021 at 8:12 PM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> On Wed, Sep 15, 2021 at 07:08:51AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Sep 15, 2021 at 04:06:57PM +0800, Jason Wang wrote:
> > > On Wed, Sep 15, 2021 at 3:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Sep 15, 2021 at 11:18:06AM +0800, Jason Wang wrote:
> > > > > On Tue, Sep 14, 2021 at 8:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Sep 14, 2021 at 08:24:51PM +0800, Wu Zongyong wrote:
> > > > > > > This new attribute advertises whether the vdpa device is legacy or not.
> > > > > > > Users can pick right virtqueue size if the vdpa device is legacy which
> > > > > > > doesn't support to change virtqueue size.
> > > > > > >
> > > > > > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > > > >
> > > > > > So if we are bothering with legacy,
> > > > >
> > > > > I think we'd better not. I guess the following may work:
> > > > >
> > > > > 1) disable the driver on BE host
> > > > > 2) present VERSION_1 with ACCESS_PLATFORM in get_features()
> > > > > 3) extend the management to advertise max_queue_size and
> > > > > min_queue_size, for ENI they are the same so management layer knows it
> > > > > needs to set the queue_size correctly during launching qemu
> > > > >
> > > > > Thoughts?
> > > > >
> > > > > Thanks
> > > >
> > > > There are other subtle differences such as header size without
> > > > mergeable buffers for net.
> > >
> > > This can be solved by mandating the feature of a mergeable buffer?
> > >
> > > Thanks
> >
> > PXE and some dpdk versions are only some of the guests that
> > disable mergeable buffers feature.
> >
> So what about this:
>
> 1) disable the driver on BE host
>    AFAIK, there are no use cases for ENI to be used in a BE machine. So
>    just disable the driver on BE machine, it will make things simper.
> 2) present ACCESS_PLATFORM but not VERSION_1 in get_features()

This sounds like a violation of the virtio spec. ACCESS_PLATFORM
depends on VERSION_1.

> 3) extend the management to advertise min_queue_size
>    min_queue_size is the same as with max_queue_size for ENI.
>
>  Another choice for 3):
>    extend the management to advertise the flag F_VERSION_1 just like
>    this patch

This will bring a lot of trouble, notice that the legacy/transitional
device doesn't work in several layers (both vdpa kernel and qemu).

If we can afford mandating mergeable rx buffers in the driver, it's
the most simple way.

I guess you should have the plan for the next generation ENI which
should support VERSION_1 and RING_PACKED.

Thanks

> > > >
> > > >
> > > > > > I think there are
> > > > > > several things to do when building the interface
> > > > > > - support transitional devices, that is allow userspace
> > > > > >   to tell device it's in legacy mode
> > > > > > - support reporting/setting supporting endian-ness
> > > > > >
> > > > > > > ---
> > > > > > >  drivers/vdpa/vdpa.c          | 6 ++++++
> > > > > > >  drivers/virtio/virtio_vdpa.c | 7 ++++++-
> > > > > > >  include/uapi/linux/vdpa.h    | 1 +
> > > > > > >  3 files changed, 13 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > > > > index 1dc121a07a93..533d7f589eee 100644
> > > > > > > --- a/drivers/vdpa/vdpa.c
> > > > > > > +++ b/drivers/vdpa/vdpa.c
> > > > > > > @@ -12,6 +12,7 @@
> > > > > > >  #include <linux/slab.h>
> > > > > > >  #include <linux/vdpa.h>
> > > > > > >  #include <uapi/linux/vdpa.h>
> > > > > > > +#include <uapi/linux/virtio_config.h>
> > > > > > >  #include <net/genetlink.h>
> > > > > > >  #include <linux/mod_devicetable.h>
> > > > > > >
> > > > > > > @@ -494,6 +495,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > > > >       u16 max_vq_size;
> > > > > > >       u32 device_id;
> > > > > > >       u32 vendor_id;
> > > > > > > +     u64 features;
> > > > > > >       void *hdr;
> > > > > > >       int err;
> > > > > > >
> > > > > > > @@ -508,6 +510,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > > > >       device_id = vdev->config->get_device_id(vdev);
> > > > > > >       vendor_id = vdev->config->get_vendor_id(vdev);
> > > > > > >       max_vq_size = vdev->config->get_vq_num_max(vdev);
> > > > > > > +     features = vdev->config->get_features(vdev);
> > > > > > >
> > > > > > >       err = -EMSGSIZE;
> > > > > > >       if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
> > > > > > > @@ -520,6 +523,9 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > > > >               goto msg_err;
> > > > > > >       if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
> > > > > > >               goto msg_err;
> > > > > > > +     if (features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> > > > > > > +         nla_put_flag(msg, VDPA_ATTR_DEV_VERSION_1))
> > > > > > > +             goto msg_err;
> > > > > > >
> > > > > > >       genlmsg_end(msg, hdr);
> > > > > > >       return 0;
> > > > > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > > > > index 72eaef2caeb1..1cba957c4cdc 100644
> > > > > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > > > > @@ -7,6 +7,7 @@
> > > > > > >   *
> > > > > > >   */
> > > > > > >
> > > > > > > +#include "linux/virtio_config.h"
> > > > > > >  #include <linux/init.h>
> > > > > > >  #include <linux/module.h>
> > > > > > >  #include <linux/device.h>
> > > > > > > @@ -145,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > > > >       /* Assume split virtqueue, switch to packed if necessary */
> > > > > > >       struct vdpa_vq_state state = {0};
> > > > > > >       unsigned long flags;
> > > > > > > +     bool may_reduce_num = false;
> > > > > > >       u32 align, num;
> > > > > > >       int err;
> > > > > > >
> > > > > > > @@ -169,10 +171,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > > > >               goto error_new_virtqueue;
> > > > > > >       }
> > > > > > >
> > > > > > > +     if (ops->get_features(vdpa) & BIT_ULL(VIRTIO_F_VERSION_1))
> > > > > > > +             may_reduce_num = true;
> > > > > > > +
> > > > > > >       /* Create the vring */
> > > > > > >       align = ops->get_vq_align(vdpa);
> > > > > > >       vq = vring_create_virtqueue(index, num, align, vdev,
> > > > > > > -                                 true, true, ctx,
> > > > > > > +                                 true, may_reduce_num, ctx,
> > > > > > >                                   virtio_vdpa_notify, callback, name);
> > > > > > >       if (!vq) {
> > > > > > >               err = -ENOMEM;
> > > > > > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > > > > > index 66a41e4ec163..ce0b74276a5b 100644
> > > > > > > --- a/include/uapi/linux/vdpa.h
> > > > > > > +++ b/include/uapi/linux/vdpa.h
> > > > > > > @@ -32,6 +32,7 @@ enum vdpa_attr {
> > > > > > >       VDPA_ATTR_DEV_VENDOR_ID,                /* u32 */
> > > > > > >       VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
> > > > > > >       VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> > > > > > > +     VDPA_ATTR_DEV_VERSION_1,                /* flag */
> > > > > > >
> > > > > > >       /* new attributes must be added above here */
> > > > > > >       VDPA_ATTR_MAX,
> > > > > > > --
> > > > > > > 2.31.1
> > > > > >
> > > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
