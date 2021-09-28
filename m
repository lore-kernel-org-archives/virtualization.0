Return-Path: <SRS0=Y9jr=OS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE17EC433F5
	for <virtualization@archiver.kernel.org>; Tue, 28 Sep 2021 03:14:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 421A161288
	for <virtualization@archiver.kernel.org>; Tue, 28 Sep 2021 03:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 421A161288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF0B8404C7;
	Tue, 28 Sep 2021 03:14:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c_UkIFW6WhqL; Tue, 28 Sep 2021 03:14:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7CE37401D0;
	Tue, 28 Sep 2021 03:14:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 506B3C0011;
	Tue, 28 Sep 2021 03:14:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33190C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 03:14:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1BB5D60AC2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 03:14:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VBzBJHI8PLAO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 03:14:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 608236058D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 03:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632798853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aB0e6ntWUoQnt7Hycc5PAuXLUL4QivaE57l+2c3IgQE=;
 b=RZR8+CyV1PDM7FOzHb0hN71tv1K4Nf6+dZyUi+euZ/l/gl7e/2o0wBRnp41G85nXg92fY8
 BrLUUkkknnxQdjimq4PQ8hvpCVEgG5KWQZxajnhtexiJYwjHOUM8+lzUyLa8e+7KQFb1WX
 ggfLSlwig5PXv+bM1D0l0GkySZuZiDY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-iwWTDF5LMAmj1joH630YNg-1; Mon, 27 Sep 2021 23:14:11 -0400
X-MC-Unique: iwWTDF5LMAmj1joH630YNg-1
Received: by mail-lf1-f71.google.com with SMTP id
 x4-20020a056512078400b003fc8e963f1dso14415163lfr.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 20:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aB0e6ntWUoQnt7Hycc5PAuXLUL4QivaE57l+2c3IgQE=;
 b=btN/n1zmrDLXD5GrkuvaAWFqWBcqmpZ+OLmFDctDZxYODqVgKs2ap7lHS63YpxFynP
 sUrMONXNUGmmfmJ7RfTpNVSROZrx63zor8E3nyS8TIJfVgbp4zj3LzytI2x4keT01qfk
 1Qn+iC468l+TyGKeJqb9qykpqaiv6EyvvRa2mvrNTkXBkqkffnoTomd1+WKxA+L7mb2x
 B0dKQM0TODBQrN/AYiH0m+rP7kQG8hw6q4MGun9/w6qLS489AQtBz4Sl3SFysWyFEmH1
 kPDtb0LF6GCK45bF2VBCxXuROb0SB1ysBiTwKnJzVlefcN93RkRgOWA7S/LqCzeC/6qR
 EB1Q==
X-Gm-Message-State: AOAM532H/0//W/mEsT5BxmTM4NrxZ1koF48oRZxsSp6ej5VqMltWQ7Tq
 N05PftbAc4ieJU9jS2qiT0PDt76VLGMIevzTDrlTeW3/83fXIUoF6k7oSTe7E94dLbClgcI0frY
 EIkvTKX3BZf37pIYKYoje6GtAtN0djAklYmihUxAFztY8cgLR5WRkbDMAPA==
X-Received: by 2002:ac2:4bc1:: with SMTP id o1mr3500903lfq.84.1632798850222;
 Mon, 27 Sep 2021 20:14:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSRPBRMNUAFeqVdiDvFYpAgzczt8Zhc6qll6+xCCC7UxDxbvSD5KpGe7dSvvWNdYeWlZr/xUZJair+IhgVJYg=
X-Received: by 2002:ac2:4bc1:: with SMTP id o1mr3500884lfq.84.1632798849997;
 Mon, 27 Sep 2021 20:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210927131250.88-1-xieyongji@bytedance.com>
In-Reply-To: <20210927131250.88-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Sep 2021 11:13:59 +0800
Message-ID: <CACGkMEuj-73DTTPaO1hUMktjqveni-zSFAPr16gdk0jvyMoV9Q@mail.gmail.com>
Subject: Re: [PATCH] vduse: Fix race condition between resetting and irq
 injecting
To: Xie Yongji <xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>
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

On Mon, Sep 27, 2021 at 9:18 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> The interrupt might be triggered after a reset since there is
> no synchronization between resetting and irq injecting. And it
> might break something if the interrupt is delayed until a new
> round of device initialization.
>
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index cefb301b2ee4..ea7d80ade559 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -80,6 +80,7 @@ struct vduse_dev {
>         struct vdpa_callback config_cb;
>         struct work_struct inject;
>         spinlock_t irq_lock;
> +       struct rw_semaphore rwsem;
>         int minor;
>         bool broken;
>         bool connected;
> @@ -410,6 +411,8 @@ static void vduse_dev_reset(struct vduse_dev *dev)
>         if (domain->bounce_map)
>                 vduse_domain_reset_bounce_map(domain);
>
> +       down_write(&dev->rwsem);
> +
>         dev->status = 0;
>         dev->driver_features = 0;
>         dev->generation++;
> @@ -443,6 +446,8 @@ static void vduse_dev_reset(struct vduse_dev *dev)
>                 flush_work(&vq->inject);
>                 flush_work(&vq->kick);
>         }
> +
> +       up_write(&dev->rwsem);
>  }
>
>  static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
> @@ -967,11 +972,12 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>         }
>         case VDUSE_DEV_INJECT_CONFIG_IRQ:
>                 ret = -EINVAL;
> -               if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> -                       break;
> -
> -               ret = 0;
> -               queue_work(vduse_irq_wq, &dev->inject);
> +               down_read(&dev->rwsem);
> +               if (dev->status & VIRTIO_CONFIG_S_DRIVER_OK) {
> +                       ret = 0;
> +                       queue_work(vduse_irq_wq, &dev->inject);
> +               }
> +               up_read(&dev->rwsem);
>                 break;
>         case VDUSE_VQ_SETUP: {
>                 struct vduse_vq_config config;
> @@ -1049,10 +1055,6 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>         case VDUSE_VQ_INJECT_IRQ: {
>                 u32 index;
>
> -               ret = -EINVAL;
> -               if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> -                       break;
> -
>                 ret = -EFAULT;
>                 if (get_user(index, (u32 __user *)argp))
>                         break;
> @@ -1061,9 +1063,13 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                 if (index >= dev->vq_num)
>                         break;
>
> -               ret = 0;
> -               index = array_index_nospec(index, dev->vq_num);
> -               queue_work(vduse_irq_wq, &dev->vqs[index].inject);
> +               down_read(&dev->rwsem);
> +               if (dev->status & VIRTIO_CONFIG_S_DRIVER_OK) {
> +                       ret = 0;
> +                       index = array_index_nospec(index, dev->vq_num);
> +                       queue_work(vduse_irq_wq, &dev->vqs[index].inject);
> +               }
> +               up_read(&dev->rwsem);

Nit: I think we can factor out the common logic to a helper.

Others look good.

Thanks

>                 break;
>         }
>         default:
> @@ -1144,6 +1150,7 @@ static struct vduse_dev *vduse_dev_create(void)
>         INIT_LIST_HEAD(&dev->send_list);
>         INIT_LIST_HEAD(&dev->recv_list);
>         spin_lock_init(&dev->irq_lock);
> +       init_rwsem(&dev->rwsem);
>
>         INIT_WORK(&dev->inject, vduse_dev_irq_inject);
>         init_waitqueue_head(&dev->waitq);
> --
> 2.11.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
