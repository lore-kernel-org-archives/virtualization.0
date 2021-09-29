Return-Path: <SRS0=D/KU=OT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF924C433F5
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 08:41:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BA161407
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 08:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 61BA161407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 26205403AF;
	Wed, 29 Sep 2021 08:41:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uH5VQnwy-tsI; Wed, 29 Sep 2021 08:41:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 38CD140431;
	Wed, 29 Sep 2021 08:41:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E81F0C000F;
	Wed, 29 Sep 2021 08:41:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF6C8C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 08:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D0449401EA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 08:41:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aAbs9baBtySu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 08:41:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CC398400B5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 08:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632904862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BWnNMXLVSn3vdKQFS+RK+5bioF+NKyoX4ChEqIq7uU0=;
 b=VSIB0kFyKnUDoNBZUadNVy5em+I3/oYuwB07Uy2l5MaLwPHW4CUWEWh9oKaCAVFq6d+y9h
 wPjLms47cdwWYRZ8VqXY6/Qes7F18bCiuos2GHKgrFdp2IZ/6LaF3AWIvcWH0kCAsqQ8Rz
 G4JQTiIU/8dxrbrDKivNV+sWyFLot2M=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-EfEsYBZlNT2cHaS9SwL1tg-1; Wed, 29 Sep 2021 04:41:01 -0400
X-MC-Unique: EfEsYBZlNT2cHaS9SwL1tg-1
Received: by mail-yb1-f198.google.com with SMTP id
 w4-20020a056902100400b005b6b29d9a27so2586647ybt.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 01:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BWnNMXLVSn3vdKQFS+RK+5bioF+NKyoX4ChEqIq7uU0=;
 b=QqAz291LH/hJwFY78gKYYBiyCZEKUz/lRJuiAXJ+3J7Zrhs5S1ZltLSXEGJe2UFEEx
 obuOWD0hRCY8Xm5u87b7ImeV8l6O0B1mUEaRxSox2t8iFvt87VXtE3rO5AEg1k0vX1GA
 Pu+d2b6n1sTO41lyIN2uUcnSnufYrJQs5hXP64/XXNKgu5SkHUNSVZ9AWFEBaG65r1Sa
 75i50pFzIII08SxasQ6nFVvl9AXhXAyVwkNK4kyvt5aqxyh6QkfX1ThC6D7NEHFfHETs
 vvYQgAJnsd49GhgNkJYhkX+m0GYhzkHPbWxVBvvEjLcitLzI/xs4w/FisoNiXwWw7eh9
 4vxw==
X-Gm-Message-State: AOAM5329Xb7gKMVEJ0psvMVOv+y5sBDrgc5AqEaGUn0jnKB+6x+Exbuc
 5MMpeXe0q8vv3SdtbQMGKYjkLrEHkiBOb+LK507SQZdK/vDonGjp4N/BAEV6ThMCoxfZmmS0pmT
 TEO+tyWHMZIZNC/1W1xrCzoLi99EgsBKMcStX9Hy4V3eER1Fg/BuJaoiz6A==
X-Received: by 2002:a25:4745:: with SMTP id u66mr11941429yba.421.1632904860951; 
 Wed, 29 Sep 2021 01:41:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcyrSgChCJFJEyNIZA5VAiIyibH+mqxzUutWDBZdNvkWnaqPffsJpdf1TlV3c3mA39I9b/Wx48Xl/6htUK5Ow=
X-Received: by 2002:a25:4745:: with SMTP id u66mr11941418yba.421.1632904860699; 
 Wed, 29 Sep 2021 01:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210929083050.88-1-xieyongji@bytedance.com>
In-Reply-To: <20210929083050.88-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 29 Sep 2021 16:40:49 +0800
Message-ID: <CACGkMEtYny-5pH8o0BjMjpDU3ZOVq5rLQV11AqpxDEpsYpGPKQ@mail.gmail.com>
Subject: Re: [PATCH v2] vduse: Fix race condition between resetting and irq
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

On Wed, Sep 29, 2021 at 4:32 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> The interrupt might be triggered after a reset since there is
> no synchronization between resetting and irq injecting. And it
> might break something if the interrupt is delayed until a new
> round of device initialization.
>
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index cefb301b2ee4..841667a896dd 100644
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

Rethink about this, do we need to sync set_status() as well?

Thanks

>  }
>
>  static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
> @@ -885,6 +890,23 @@ static void vduse_vq_irq_inject(struct work_struct *work)
>         spin_unlock_irq(&vq->irq_lock);
>  }
>
> +static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> +                                   struct work_struct *irq_work)
> +{
> +       int ret = -EINVAL;
> +
> +       down_read(&dev->rwsem);
> +       if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +               goto unlock;
> +
> +       ret = 0;
> +       queue_work(vduse_irq_wq, irq_work);
> +unlock:
> +       up_read(&dev->rwsem);
> +
> +       return ret;
> +}
> +
>  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                             unsigned long arg)
>  {
> @@ -966,12 +988,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                 break;
>         }
>         case VDUSE_DEV_INJECT_CONFIG_IRQ:
> -               ret = -EINVAL;
> -               if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> -                       break;
> -
> -               ret = 0;
> -               queue_work(vduse_irq_wq, &dev->inject);
> +               ret = vduse_dev_queue_irq_work(dev, &dev->inject);
>                 break;
>         case VDUSE_VQ_SETUP: {
>                 struct vduse_vq_config config;
> @@ -1049,10 +1066,6 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
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
> @@ -1061,9 +1074,8 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                 if (index >= dev->vq_num)
>                         break;
>
> -               ret = 0;
>                 index = array_index_nospec(index, dev->vq_num);
> -               queue_work(vduse_irq_wq, &dev->vqs[index].inject);
> +               ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index].inject);
>                 break;
>         }
>         default:
> @@ -1144,6 +1156,7 @@ static struct vduse_dev *vduse_dev_create(void)
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
