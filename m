Return-Path: <SRS0=bZ0l=OF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD460C433F5
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 08:06:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51CC1611AF
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 08:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 51CC1611AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12A9340287;
	Wed, 15 Sep 2021 08:06:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5igGaxjzKWu8; Wed, 15 Sep 2021 08:06:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8AD4F40250;
	Wed, 15 Sep 2021 08:06:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41CFBC000F;
	Wed, 15 Sep 2021 08:06:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09F80C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 08:06:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE19D4011C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 08:06:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iWMRpDXNlQ-W
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 08:06:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AAAA7400EE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 08:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631693163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XTJOPOBK2FWoIHtqCxOB4rq1YLQd/kSrktTEId4dfSw=;
 b=DLavQAQV2UdWt5tgpaEB29kNjgkXyrZ6rcOAUpPLUTswJojrgq0u4DlUW0PaGoNVZvknTL
 /vI0Jp1ZJ65bNy/6QrQBYuhLNGsi9KTmliWL/V6NfR0If+kTDniCdn7QS1KjXNMtuX/naK
 cJnZJ1+HhkjFV+36kfYuHA1ECHTxFfQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503--eWwa4jPO8uj_c_ccEWLEQ-1; Wed, 15 Sep 2021 04:06:01 -0400
X-MC-Unique: -eWwa4jPO8uj_c_ccEWLEQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 p11-20020a2ea40b000000b001d68cffb055so1123931ljn.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 01:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XTJOPOBK2FWoIHtqCxOB4rq1YLQd/kSrktTEId4dfSw=;
 b=i9lD8OEVlNBZRkIM9UVABDAORNUk43gqONcDOfHm/zijtXOBKeNV3RnYOjFc5LgMw5
 FmKPbEvZivCcHthxSH0OfQIci66BLlC8XGtJYvb55CSUo0leGeBSirMRz9dBzzPtcAdC
 +iZGBG7ykkuuhs5dTins4bHc/tXbmRCFGbw/oSy72m0X6++qh1AbmOLQmpJGlwS7k5IL
 7LjqYXbfstj5J9MTLgZzKeqb6thK0A4Rj4gMWGIEJS+8gCzdCC0WvCmKJPj7M+yO68Dv
 uBaBHOQPZgVh6FmKDidX/LNxIkbe/e+Ipd1PHdwDaq8k8PdTpx5W2ZCdTRPoVUXwa2dF
 7/0g==
X-Gm-Message-State: AOAM533HBK0kQM1kqicaGJCD0UO/WHoPBnZwqvas3AxLiycv+VciBBfC
 jhS+q50C4JJgj2XsLK3umi8YDpPcwYcM6xTKeultzNVl/2sad81o2w0xDcg9V7hkdPMLvFqr86e
 RBGZaQYEPENNQhOWoe/sDZGfuB+un2+u5TYD6/voNkzPcFKNx1J8VZmVEBg==
X-Received: by 2002:a05:6512:2254:: with SMTP id
 i20mr16264812lfu.348.1631693160336; 
 Wed, 15 Sep 2021 01:06:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqrnLiCAjGMSIhm0xEtGCYbTdjLcTMVGgBTxbfAsS5lxuiHGYePOaD1vkjPALPM1IjTYCM6wVKxVBewo2YRgU=
X-Received: by 2002:a05:6512:2254:: with SMTP id
 i20mr16264799lfu.348.1631693160094; 
 Wed, 15 Sep 2021 01:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
 <20210914085711-mutt-send-email-mst@kernel.org>
 <20210915032453.GA18793@L-PF27918B-1352.localdomain>
 <20210915032732-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210915032732-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Sep 2021 16:05:49 +0800
Message-ID: <CACGkMEumkCih51kENTiP9hpRbtKNkRJsR3MienZDtfBYVF73Zg@mail.gmail.com>
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

On Wed, Sep 15, 2021 at 3:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Sep 15, 2021 at 11:24:53AM +0800, Wu Zongyong wrote:
> > On Tue, Sep 14, 2021 at 08:58:28AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Sep 14, 2021 at 08:24:51PM +0800, Wu Zongyong wrote:
> > > > This new attribute advertises whether the vdpa device is legacy or not.
> > > > Users can pick right virtqueue size if the vdpa device is legacy which
> > > > doesn't support to change virtqueue size.
> > > >
> > > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > >
> > > So if we are bothering with legacy, I think there are
> > > several things to do when building the interface
> > > - support transitional devices, that is allow userspace
> > >   to tell device it's in legacy mode
> > > - support reporting/setting supporting endian-ness
> >
> > It's true if we try to implement a general drvier for legacy.
> > But this series is dedicated to implement a driver only for ENI. Is it
> > necessary to implement what you said here in this series?
>
> To a certain degree, yes.
>
> I am thinking about the UAPI here. The new attribute is part of that.
> E.g. userspace consuming this needs to be more or less hardware agnostic
> and not depend on specifics of ENI.
>
> Otherwise if userspace assumes legacy==eni then it will break with
> other hardware.
>
> One way to test how generic it all is would be adding legacy support in
> the simulator.

I don't get why we need to support legacy devices e.g it doesn't have
ACCESS_PLATFORM support. I think we should re-consider to mandate 1.0
devices.

https://lore.kernel.org/lkml/20210408082648.20145-1-jasowang@redhat.com/

And it will complicate all of the different layers.

Thanks

>
> > >
> > > > ---
> > > >  drivers/vdpa/vdpa.c          | 6 ++++++
> > > >  drivers/virtio/virtio_vdpa.c | 7 ++++++-
> > > >  include/uapi/linux/vdpa.h    | 1 +
> > > >  3 files changed, 13 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > index 1dc121a07a93..533d7f589eee 100644
> > > > --- a/drivers/vdpa/vdpa.c
> > > > +++ b/drivers/vdpa/vdpa.c
> > > > @@ -12,6 +12,7 @@
> > > >  #include <linux/slab.h>
> > > >  #include <linux/vdpa.h>
> > > >  #include <uapi/linux/vdpa.h>
> > > > +#include <uapi/linux/virtio_config.h>
> > > >  #include <net/genetlink.h>
> > > >  #include <linux/mod_devicetable.h>
> > > >
> > > > @@ -494,6 +495,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > >   u16 max_vq_size;
> > > >   u32 device_id;
> > > >   u32 vendor_id;
> > > > + u64 features;
> > > >   void *hdr;
> > > >   int err;
> > > >
> > > > @@ -508,6 +510,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > >   device_id = vdev->config->get_device_id(vdev);
> > > >   vendor_id = vdev->config->get_vendor_id(vdev);
> > > >   max_vq_size = vdev->config->get_vq_num_max(vdev);
> > > > + features = vdev->config->get_features(vdev);
> > > >
> > > >   err = -EMSGSIZE;
> > > >   if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
> > > > @@ -520,6 +523,9 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > >           goto msg_err;
> > > >   if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
> > > >           goto msg_err;
> > > > + if (features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> > > > +     nla_put_flag(msg, VDPA_ATTR_DEV_VERSION_1))
> > > > +         goto msg_err;
> > > >
> > > >   genlmsg_end(msg, hdr);
> > > >   return 0;
> > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > index 72eaef2caeb1..1cba957c4cdc 100644
> > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > @@ -7,6 +7,7 @@
> > > >   *
> > > >   */
> > > >
> > > > +#include "linux/virtio_config.h"
> > > >  #include <linux/init.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/device.h>
> > > > @@ -145,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > >   /* Assume split virtqueue, switch to packed if necessary */
> > > >   struct vdpa_vq_state state = {0};
> > > >   unsigned long flags;
> > > > + bool may_reduce_num = false;
> > > >   u32 align, num;
> > > >   int err;
> > > >
> > > > @@ -169,10 +171,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > >           goto error_new_virtqueue;
> > > >   }
> > > >
> > > > + if (ops->get_features(vdpa) & BIT_ULL(VIRTIO_F_VERSION_1))
> > > > +         may_reduce_num = true;
> > > > +
> > > >   /* Create the vring */
> > > >   align = ops->get_vq_align(vdpa);
> > > >   vq = vring_create_virtqueue(index, num, align, vdev,
> > > > -                             true, true, ctx,
> > > > +                             true, may_reduce_num, ctx,
> > > >                               virtio_vdpa_notify, callback, name);
> > > >   if (!vq) {
> > > >           err = -ENOMEM;
> > > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > > index 66a41e4ec163..ce0b74276a5b 100644
> > > > --- a/include/uapi/linux/vdpa.h
> > > > +++ b/include/uapi/linux/vdpa.h
> > > > @@ -32,6 +32,7 @@ enum vdpa_attr {
> > > >   VDPA_ATTR_DEV_VENDOR_ID,                /* u32 */
> > > >   VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
> > > >   VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> > > > + VDPA_ATTR_DEV_VERSION_1,                /* flag */
> > > >
> > > >   /* new attributes must be added above here */
> > > >   VDPA_ATTR_MAX,
> > > > --
> > > > 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
