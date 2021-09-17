Return-Path: <SRS0=2Qdu=OH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4F2C433F5
	for <virtualization@archiver.kernel.org>; Fri, 17 Sep 2021 07:52:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F1C611C0
	for <virtualization@archiver.kernel.org>; Fri, 17 Sep 2021 07:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63F1C611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16E2783FA4;
	Fri, 17 Sep 2021 07:52:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L6YQRRpGeyvN; Fri, 17 Sep 2021 07:52:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 45DAD83F97;
	Fri, 17 Sep 2021 07:52:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A5F3C0021;
	Fri, 17 Sep 2021 07:52:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38693C000F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 07:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 19AC560835
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 07:52:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iWmJSuCaopdW
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 07:52:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D92916081E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 07:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631865126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ig9xHMFTEexFHtf5heeUZKbb6+d2Kocqp2z8ZEGYRPA=;
 b=SoTJtvTTHhYqGY2/DExsTcXYDp6YsXkGPGFg/4/nuheSezRbOoIBpcxu81w51WcjAGCSw7
 XsVHLvTNTd9lYY7elUicd89WJMr7YvTD3s/DVuS3pCkSl8kAD3LuEedDZsDkweB4Qwzsyw
 aachqcRC70PeumxpEih72pULSTsSGxY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-qwDBp_4nPk6Vj2v6i6s_ug-1; Fri, 17 Sep 2021 03:52:05 -0400
X-MC-Unique: qwDBp_4nPk6Vj2v6i6s_ug-1
Received: by mail-lf1-f71.google.com with SMTP id
 q5-20020ac25fc5000000b003d9227d9edcso6057828lfg.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 00:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ig9xHMFTEexFHtf5heeUZKbb6+d2Kocqp2z8ZEGYRPA=;
 b=03LXw6pZB+0TaGeEYmTxJ10Cd8XtPd+c7OrLTUt6k+KlOU0QrDHJj06DNGZTAzHrHo
 sU29SbrKO1RxIT3wyIVUclJG6tQx80xhuYzqNmbOrVtX7n7ytGS6TOXNKv4fd9EUGoZM
 VSX9cB/hc68M146CZIHkPiZtpV9UafEztEuq9tiVA2w+EN6aoLs3+G5mIGo0qOfPZUd8
 Osj1WmGhGtmwlPbj9qPxiMbzEYBA0mGUn8GV3OrlELY0D6oh1igY8CewSNzCLBHXQU8m
 kgRcX5FLUi6tbLcZuLX/L7OJVCSd9xBkXuiMV9wLXxvx9YKfa2VZoUXg0Aq2bESl5BjA
 TuSQ==
X-Gm-Message-State: AOAM530sT4tc36MyYjMDUOH80iJu9dvG4ioEejIO1OmxvPUoEZVAVTIb
 AasuR7vHP+P4HdDGfmkdi4KVDGNyH/a/3hGjn0qSvKE/Q5AGlOt4IUyq1WDjuq2sZjEML3XOeOQ
 sy6VHrAjbKLQD2Lj8ugx/71kjZjmiHwhBPIly6lemoQWbW0TtkEb4WThrqQ==
X-Received: by 2002:a2e:89c9:: with SMTP id c9mr8663666ljk.107.1631865123907; 
 Fri, 17 Sep 2021 00:52:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz25iogywOItEhZPEzJVaruboTkzhpqM8HfA6JZd6Gqcr0qBeyOdmGZHHpaqFEqEX3Uik/0IbFcZCFDXSPvLhU=
X-Received: by 2002:a2e:89c9:: with SMTP id c9mr8663649ljk.107.1631865123578; 
 Fri, 17 Sep 2021 00:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
 <20210914085711-mutt-send-email-mst@kernel.org>
 <CACGkMEu3RUGpe74Vh-FAZD3MwOC3gqU0OEf8A1ULvq7GSMm6Jg@mail.gmail.com>
 <20210915033756-mutt-send-email-mst@kernel.org>
 <CACGkMEtN0Z=rgMhaWNO=6h-KXGdosBuOdqoWoND-=Tf+afyUYw@mail.gmail.com>
 <20210915070805-mutt-send-email-mst@kernel.org>
 <CACGkMEvqZqwRxjnBLpX+=MYbho0q8Hs7OZbsx4ATzhfwOkB73w@mail.gmail.com>
 <20210917023451.GA19669@L-PF27918B-1352.localdomain>
In-Reply-To: <20210917023451.GA19669@L-PF27918B-1352.localdomain>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Sep 2021 15:51:52 +0800
Message-ID: <CACGkMEvzqYSNo4JGpqC5O-fkjOEPXNU0huRyufAOU5HxAXeoKg@mail.gmail.com>
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

On Fri, Sep 17, 2021 at 10:35 AM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> On Thu, Sep 16, 2021 at 09:05:58AM +0800, Jason Wang wrote:
> > On Wed, Sep 15, 2021 at 7:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Sep 15, 2021 at 04:06:57PM +0800, Jason Wang wrote:
> > > > On Wed, Sep 15, 2021 at 3:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Wed, Sep 15, 2021 at 11:18:06AM +0800, Jason Wang wrote:
> > > > > > On Tue, Sep 14, 2021 at 8:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Sep 14, 2021 at 08:24:51PM +0800, Wu Zongyong wrote:
> > > > > > > > This new attribute advertises whether the vdpa device is legacy or not.
> > > > > > > > Users can pick right virtqueue size if the vdpa device is legacy which
> > > > > > > > doesn't support to change virtqueue size.
> > > > > > > >
> > > > > > > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > > > > >
> > > > > > > So if we are bothering with legacy,
> > > > > >
> > > > > > I think we'd better not. I guess the following may work:
> > > > > >
> > > > > > 1) disable the driver on BE host
> > > > > > 2) present VERSION_1 with ACCESS_PLATFORM in get_features()
> > > > > > 3) extend the management to advertise max_queue_size and
> > > > > > min_queue_size, for ENI they are the same so management layer knows it
> > > > > > needs to set the queue_size correctly during launching qemu
> > > > > >
> > > > > > Thoughts?
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > There are other subtle differences such as header size without
> > > > > mergeable buffers for net.
> > > >
> > > > This can be solved by mandating the feature of a mergeable buffer?
> > > >
> > > > Thanks
> > >
> > > PXE and some dpdk versions are only some of the guests that
> > > disable mergeable buffers feature.
> >
> > True, but consider
> >
> > 1) the legacy stuffs requires changes in several software layers
> > 2) it is how virtio 1.0 works e.g device can fail the feature negotiation
> > 3) it is not supported since day 0
> > 4) management API can be extended to advertise the mandated features
>
> So let me confirm what I should do in next revision:
> 1) disable the driver on BE host like that:
>
>    #ifdef __LITTE_ENDIAN
>    int eni_vdpa_probe()
>    {
>        ...
>    }
>    #else
>    int eni_vdpa_probe()
>    {
>        return -ENODEV;
>    }
>    #endif

This might work but I wonder if we can disable it via Kconfig.

>
> 2) report F_VERSION_1 and F_ACCESS_PLATFORM in get_features()
> 3) introduce a new cb get_vq_num_min in vdpa_config_ops
>
> Does I miss something?

And we need this as well.

Fail the feature negotiation if mrg rxbuf is not negotiated. Otherwise
we can meet the 1.0 requirement of header length. Or the hardware can
still preset the mergeable header if the mrg rx buffer is not
negotiated?

Thanks

>
> > It looks affordable.
> >
> > Thanks
> >
> > >
> > > > >
> > > > >
> > > > > > > I think there are
> > > > > > > several things to do when building the interface
> > > > > > > - support transitional devices, that is allow userspace
> > > > > > >   to tell device it's in legacy mode
> > > > > > > - support reporting/setting supporting endian-ness
> > > > > > >
> > > > > > > > ---
> > > > > > > >  drivers/vdpa/vdpa.c          | 6 ++++++
> > > > > > > >  drivers/virtio/virtio_vdpa.c | 7 ++++++-
> > > > > > > >  include/uapi/linux/vdpa.h    | 1 +
> > > > > > > >  3 files changed, 13 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > > > > > index 1dc121a07a93..533d7f589eee 100644
> > > > > > > > --- a/drivers/vdpa/vdpa.c
> > > > > > > > +++ b/drivers/vdpa/vdpa.c
> > > > > > > > @@ -12,6 +12,7 @@
> > > > > > > >  #include <linux/slab.h>
> > > > > > > >  #include <linux/vdpa.h>
> > > > > > > >  #include <uapi/linux/vdpa.h>
> > > > > > > > +#include <uapi/linux/virtio_config.h>
> > > > > > > >  #include <net/genetlink.h>
> > > > > > > >  #include <linux/mod_devicetable.h>
> > > > > > > >
> > > > > > > > @@ -494,6 +495,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > > > > >       u16 max_vq_size;
> > > > > > > >       u32 device_id;
> > > > > > > >       u32 vendor_id;
> > > > > > > > +     u64 features;
> > > > > > > >       void *hdr;
> > > > > > > >       int err;
> > > > > > > >
> > > > > > > > @@ -508,6 +510,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > > > > >       device_id = vdev->config->get_device_id(vdev);
> > > > > > > >       vendor_id = vdev->config->get_vendor_id(vdev);
> > > > > > > >       max_vq_size = vdev->config->get_vq_num_max(vdev);
> > > > > > > > +     features = vdev->config->get_features(vdev);
> > > > > > > >
> > > > > > > >       err = -EMSGSIZE;
> > > > > > > >       if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
> > > > > > > > @@ -520,6 +523,9 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > > > > > >               goto msg_err;
> > > > > > > >       if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
> > > > > > > >               goto msg_err;
> > > > > > > > +     if (features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> > > > > > > > +         nla_put_flag(msg, VDPA_ATTR_DEV_VERSION_1))
> > > > > > > > +             goto msg_err;
> > > > > > > >
> > > > > > > >       genlmsg_end(msg, hdr);
> > > > > > > >       return 0;
> > > > > > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > > > > > index 72eaef2caeb1..1cba957c4cdc 100644
> > > > > > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > > > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > > > > > @@ -7,6 +7,7 @@
> > > > > > > >   *
> > > > > > > >   */
> > > > > > > >
> > > > > > > > +#include "linux/virtio_config.h"
> > > > > > > >  #include <linux/init.h>
> > > > > > > >  #include <linux/module.h>
> > > > > > > >  #include <linux/device.h>
> > > > > > > > @@ -145,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > > > > >       /* Assume split virtqueue, switch to packed if necessary */
> > > > > > > >       struct vdpa_vq_state state = {0};
> > > > > > > >       unsigned long flags;
> > > > > > > > +     bool may_reduce_num = false;
> > > > > > > >       u32 align, num;
> > > > > > > >       int err;
> > > > > > > >
> > > > > > > > @@ -169,10 +171,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > > > > >               goto error_new_virtqueue;
> > > > > > > >       }
> > > > > > > >
> > > > > > > > +     if (ops->get_features(vdpa) & BIT_ULL(VIRTIO_F_VERSION_1))
> > > > > > > > +             may_reduce_num = true;
> > > > > > > > +
> > > > > > > >       /* Create the vring */
> > > > > > > >       align = ops->get_vq_align(vdpa);
> > > > > > > >       vq = vring_create_virtqueue(index, num, align, vdev,
> > > > > > > > -                                 true, true, ctx,
> > > > > > > > +                                 true, may_reduce_num, ctx,
> > > > > > > >                                   virtio_vdpa_notify, callback, name);
> > > > > > > >       if (!vq) {
> > > > > > > >               err = -ENOMEM;
> > > > > > > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > > > > > > index 66a41e4ec163..ce0b74276a5b 100644
> > > > > > > > --- a/include/uapi/linux/vdpa.h
> > > > > > > > +++ b/include/uapi/linux/vdpa.h
> > > > > > > > @@ -32,6 +32,7 @@ enum vdpa_attr {
> > > > > > > >       VDPA_ATTR_DEV_VENDOR_ID,                /* u32 */
> > > > > > > >       VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
> > > > > > > >       VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> > > > > > > > +     VDPA_ATTR_DEV_VERSION_1,                /* flag */
> > > > > > > >
> > > > > > > >       /* new attributes must be added above here */
> > > > > > > >       VDPA_ATTR_MAX,
> > > > > > > > --
> > > > > > > > 2.31.1
> > > > > > >
> > > > >
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
