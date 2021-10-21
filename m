Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CACC433F5
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 08:25:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA9A61056
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 08:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4DA9A61056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1004540297;
	Thu, 21 Oct 2021 08:25:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B_I4yotdKXGI; Thu, 21 Oct 2021 08:25:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1661A401D5;
	Thu, 21 Oct 2021 08:25:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4B7AC0033;
	Thu, 21 Oct 2021 08:25:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 880C5C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 08:25:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B0B182656
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 08:25:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DI7P5Rbjl1Hf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 08:25:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 179018258A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 08:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634804712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=200t0cLXhAHJtgA6a0MnRPD5hB8kv1y+rEoU56S9KLk=;
 b=c326wWNBfUIiGWeCDp5I04n0MIffonPuOmOe6PTGOrp4VUwLr5vw1gx5vIPvLinF7Y65p1
 i6yEqa5rQdagH03+P2P+pahFlj0rZwILztypetvosE6G1SGZSBNndEWKGj0wFbLTpRxGdf
 C7jwfzugq2b7zWeRH3Jj0YHwqAEnDUs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-Qq3wmAcJNOqhSGIbcy9bWg-1; Thu, 21 Oct 2021 04:25:11 -0400
X-MC-Unique: Qq3wmAcJNOqhSGIbcy9bWg-1
Received: by mail-lj1-f200.google.com with SMTP id
 s5-20020a2e98c5000000b002112895b3f6so2534236ljj.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 01:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=200t0cLXhAHJtgA6a0MnRPD5hB8kv1y+rEoU56S9KLk=;
 b=0xGFkLUHoDqaodlSKXP6bT+ytpMbiwnNLgC+Zl5ccpGQe+brCViiaQo1gAfd33RiAo
 t7r9FjQsFiIPYJff34e0vbDkeGRlMP8nE+SYBdjXxOv2wiaOD9MQ93Er10h6ZhG44+fa
 5ni/Cx7RBvKF4Rxdth1w1su6G+8p7aD2gUt2xwszll3Q6rCklBLpKhj2ygRQR1TYqmC7
 sI01KMo2InaVm1fVDJo/LA9JBKHp3NGYfebFu4PnCPMzKCXIi1H3bkJqbkZXQIrzAV+u
 Nr7DQNXTL7VoJvSMB3ZLC1Px9f1G1M4qagzqHgNjeEKXuqyrx+D+LKM2u1ui15utG+S0
 RxTw==
X-Gm-Message-State: AOAM5318sahvKBTh0/sezQwFnhZP1q6NDP5hJ8lq9Iqts0ta0qO920xE
 +T9UzQRkL4eer1KMpNf8M9aD3jFm8GKL6wWaxnuz5ADgbURcSb6GFcDqgQrWjmTqkPvOJ+qn9ds
 VHZjRydOrafEWceBxoAg4icxhj6iy70UkUmgNlJPugGxuYt1nJQCCbQqe1Q==
X-Received: by 2002:ac2:494d:: with SMTP id o13mr4321974lfi.580.1634804709628; 
 Thu, 21 Oct 2021 01:25:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7FS30C0xsB5Db8/OJ4IHoUI/XDzgtK7edmnZqjXEyteHFiLU5SypbFJSjgLbZ5j5A5vqpWQaBCyN79LIdn/8=
X-Received: by 2002:ac2:494d:: with SMTP id o13mr4321954lfi.580.1634804709352; 
 Thu, 21 Oct 2021 01:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211021032926.89-1-xieyongji@bytedance.com>
In-Reply-To: <20211021032926.89-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Oct 2021 16:24:58 +0800
Message-ID: <CACGkMEsyunF86psKckrcOppZS4iDDLzi6Vd9eiQe2=4nPiyHSg@mail.gmail.com>
Subject: Re: [PATCH] vduse: Don't call interrupt callback without DRIVER_OK
 bit set
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

On Thu, Oct 21, 2021 at 11:29 AM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> Commit 1018722ef0b7 ("vduse: Fix race condition between resetting and
> irq injecting") tries to fix a race condition like:
>
> CPU0                                      CPU1
> ----                                      ----
> vduse_dev_ioctl()
>   check DRIVER_OK
>                                           vduse_dev_reset()
>                                             flush_work(&vq->inject)
>   queue_work(vduse_irq_wq, &vq->inject)
>                                           virtio_vdpa_probe()
>                                             virtio_vdpa_find_vqs()
> vduse_vq_irq_inject()
>   vq->cb.callback(vq->cb.private);
>                                               set DRIVER_OK
>
> The irq callback will be triggered before DRIVER_OK is set in this case.
>
> To fix it, commit 1018722ef0b7 introduces a rwsem to add synchronization
> between resetting and irq injecting. But it missed the synchronization
> with set_status() and increased overhead on irq injection a bit. This
> patch tries a simpler way to fix it. We just check DRIVER_OK again in
> vduse_vq_irq_inject() and make sure each time setting status is done
> under the irq lock.

Acked-by: Jason Wang <jasowang@redhat.com>

I wonder if we can use RCU to synchronize them in the future.

Thanks

>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 48 ++++++++++++++++++++++++--------------
>  1 file changed, 30 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 841667a896dd..bf3c71ee597f 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -39,6 +39,8 @@
>  #define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
>  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
>
> +struct vduse_dev;
> +
>  struct vduse_virtqueue {
>         u16 index;
>         u16 num_max;
> @@ -55,10 +57,9 @@ struct vduse_virtqueue {
>         struct vdpa_callback cb;
>         struct work_struct inject;
>         struct work_struct kick;
> +       struct vduse_dev *dev;
>  };
>
> -struct vduse_dev;
> -
>  struct vduse_vdpa {
>         struct vdpa_device vdpa;
>         struct vduse_dev *dev;
> @@ -80,7 +81,6 @@ struct vduse_dev {
>         struct vdpa_callback config_cb;
>         struct work_struct inject;
>         spinlock_t irq_lock;
> -       struct rw_semaphore rwsem;
>         int minor;
>         bool broken;
>         bool connected;
> @@ -402,6 +402,22 @@ static __poll_t vduse_dev_poll(struct file *file, poll_table *wait)
>         return mask;
>  }
>
> +static inline void vduse_dev_lock_vqs(struct vduse_dev *dev)
> +{
> +       int i;
> +
> +       for (i = 0; i < dev->vq_num; i++)
> +               spin_lock(&dev->vqs[i].irq_lock);
> +}
> +
> +static inline void vduse_dev_unlock_vqs(struct vduse_dev *dev)
> +{
> +       int i;
> +
> +       for (i = 0; i < dev->vq_num; i++)
> +               spin_unlock(&dev->vqs[i].irq_lock);
> +}
> +
>  static void vduse_dev_reset(struct vduse_dev *dev)
>  {
>         int i;
> @@ -411,8 +427,6 @@ static void vduse_dev_reset(struct vduse_dev *dev)
>         if (domain->bounce_map)
>                 vduse_domain_reset_bounce_map(domain);
>
> -       down_write(&dev->rwsem);
> -
>         dev->status = 0;
>         dev->driver_features = 0;
>         dev->generation++;
> @@ -446,8 +460,6 @@ static void vduse_dev_reset(struct vduse_dev *dev)
>                 flush_work(&vq->inject);
>                 flush_work(&vq->kick);
>         }
> -
> -       up_write(&dev->rwsem);
>  }
>
>  static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
> @@ -640,7 +652,11 @@ static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
>         if (vduse_dev_set_status(dev, status))
>                 return;
>
> +       spin_lock(&dev->irq_lock);
> +       vduse_dev_lock_vqs(dev);
>         dev->status = status;
> +       vduse_dev_unlock_vqs(dev);
> +       spin_unlock(&dev->irq_lock);
>  }
>
>  static size_t vduse_vdpa_get_config_size(struct vdpa_device *vdpa)
> @@ -874,7 +890,8 @@ static void vduse_dev_irq_inject(struct work_struct *work)
>         struct vduse_dev *dev = container_of(work, struct vduse_dev, inject);
>
>         spin_lock_irq(&dev->irq_lock);
> -       if (dev->config_cb.callback)
> +       if (dev->status & VIRTIO_CONFIG_S_DRIVER_OK &&
> +           dev->config_cb.callback)
>                 dev->config_cb.callback(dev->config_cb.private);
>         spin_unlock_irq(&dev->irq_lock);
>  }
> @@ -883,9 +900,10 @@ static void vduse_vq_irq_inject(struct work_struct *work)
>  {
>         struct vduse_virtqueue *vq = container_of(work,
>                                         struct vduse_virtqueue, inject);
> +       struct vduse_dev *dev = vq->dev;
>
>         spin_lock_irq(&vq->irq_lock);
> -       if (vq->ready && vq->cb.callback)
> +       if (dev->status & VIRTIO_CONFIG_S_DRIVER_OK && vq->cb.callback)
>                 vq->cb.callback(vq->cb.private);
>         spin_unlock_irq(&vq->irq_lock);
>  }
> @@ -893,18 +911,12 @@ static void vduse_vq_irq_inject(struct work_struct *work)
>  static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
>                                     struct work_struct *irq_work)
>  {
> -       int ret = -EINVAL;
> -
> -       down_read(&dev->rwsem);
>         if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> -               goto unlock;
> +               return -EINVAL;
>
> -       ret = 0;
>         queue_work(vduse_irq_wq, irq_work);
> -unlock:
> -       up_read(&dev->rwsem);
>
> -       return ret;
> +       return 0;
>  }
>
>  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> @@ -1156,7 +1168,6 @@ static struct vduse_dev *vduse_dev_create(void)
>         INIT_LIST_HEAD(&dev->send_list);
>         INIT_LIST_HEAD(&dev->recv_list);
>         spin_lock_init(&dev->irq_lock);
> -       init_rwsem(&dev->rwsem);
>
>         INIT_WORK(&dev->inject, vduse_dev_irq_inject);
>         init_waitqueue_head(&dev->waitq);
> @@ -1322,6 +1333,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>
>         for (i = 0; i < dev->vq_num; i++) {
>                 dev->vqs[i].index = i;
> +               dev->vqs[i].dev = dev;
>                 INIT_WORK(&dev->vqs[i].inject, vduse_vq_irq_inject);
>                 INIT_WORK(&dev->vqs[i].kick, vduse_vq_kick_work);
>                 spin_lock_init(&dev->vqs[i].kick_lock);
> --
> 2.11.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
