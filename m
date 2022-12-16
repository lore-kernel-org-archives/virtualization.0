Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93899C4332F
	for <virtualization@archiver.kernel.org>; Fri, 16 Dec 2022 05:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 181F4404A1;
	Fri, 16 Dec 2022 05:43:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 181F4404A1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XGIbqKrS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7W8sizIz1xAa; Fri, 16 Dec 2022 05:43:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 57A724044D;
	Fri, 16 Dec 2022 05:43:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 57A724044D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 358A7C0033;
	Fri, 16 Dec 2022 05:43:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFE25C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 05:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 85AC041B3D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 05:43:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 85AC041B3D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XGIbqKrS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T5VcCrDgxNa7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 05:43:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 871B24190B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 871B24190B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 05:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671169393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lR7WnqvDc+rTDFoKYRWuh6MMYqCYo5ZyrUKVWQtJrjg=;
 b=XGIbqKrS7Z/VZG7W+k/Swl9AVnVx4QkyAFIH2y0cfOqOwXQOCq7a/Bg/42klLOmjfyZ5PZ
 isFFhxMmoRldT4WMT20ZjvJvjNmq2qHH1oLxDNtxiDLgBdWElgNhvIgUPZbQN18gRcOJWy
 /PQSTkC5/V41aydmeXQP88MkU8Olbi8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-586-6vRbPsfiMsySSR4II0O5VA-1; Fri, 16 Dec 2022 00:43:12 -0500
X-MC-Unique: 6vRbPsfiMsySSR4II0O5VA-1
Received: by mail-ot1-f70.google.com with SMTP id
 m12-20020a9d6acc000000b006707706d25dso786901otq.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 21:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lR7WnqvDc+rTDFoKYRWuh6MMYqCYo5ZyrUKVWQtJrjg=;
 b=qaxWjJH//eiqbMcsJn4t6chICR7pW/ju6YyjaatK0i3LGGYDiQ99DfXnGKqiEyblhS
 0sqFEooSzl/d0YTYVpcIT2SvLy7f3M7lxSmayHISC6w8daACs4ywGgud1xv5JrPCmJUI
 MsjgaS7nMDtjiG6rHHGKDRRxIRMFB+Re5glUn7FQxDAXAKrzSlPS6uk2KExbki2lG8FL
 NDv2Lz0CGaX4bmiMB9lBlclcXCr+wQ3ZjWgvJRcNHIO6/IEFn5dK47ZYlLNue5/tDQ3V
 AIHh4tftjEx2xrk1m6JQly5md2lCXJFvCBDEXUmbziP37m8QeOL7lYAYI1e3towaIkJo
 AZBA==
X-Gm-Message-State: ANoB5pkpI1//Si/yfxLajH23GBPlNe6zU5RAXeLAFR5mpMotxYeMDfUB
 awSJd5APBmBeZK6yfYpdH9Cl/FZjol0sVmRtcY0Ux35KCZYlcz40wyYfcaK0PVb4eCrN8AB4NUq
 nMhYxlQROFP9ivU54e57f0Af7Vx2hFBvb4/reABAfrPIrAKX7MOoiaNDfSw==
X-Received: by 2002:a4a:94a9:0:b0:480:8f4a:7062 with SMTP id
 k38-20020a4a94a9000000b004808f4a7062mr31914716ooi.57.1671169391294; 
 Thu, 15 Dec 2022 21:43:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6ZMswovlmpw7FdDe9VO/33eW2UDQTUjORPwH4EGDIAX/TuiwI9YZfjjWcizpDDlCiCCEf+P97Fy2zif8OL2So=
X-Received: by 2002:a4a:94a9:0:b0:480:8f4a:7062 with SMTP id
 k38-20020a4a94a9000000b004808f4a7062mr31914710ooi.57.1671169391057; Thu, 15
 Dec 2022 21:43:11 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205090243.791-1-xieyongji@bytedance.com>
 <20221205090243.791-3-xieyongji@bytedance.com>
In-Reply-To: <20221205090243.791-3-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 Dec 2022 13:43:00 +0800
Message-ID: <CACGkMEuAxEEvShwN8Q_k-FKZODesORn4zJG7UFHD-KS8sQXYjg@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] vduse: Add enable_irq_wq sysfs interface for
 virtqueues
To: Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, hch@lst.de, mst@redhat.com
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

On Mon, Dec 5, 2022 at 5:03 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> Add enable_irq_wq sysfs interface to control whether
> use workqueue to inject irq or not. The vhost-vdpa case
> can benefit from it.

Do we have a benchmark result for this?

Or I wonder if we can extend set_vq_cb() by associating an eventfd
then VDUSE can signal that eventfd directly?

Thanks

>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 50 +++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index c65f84100e30..ed06c7afd484 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -62,6 +62,7 @@ struct vduse_virtqueue {
>         struct cpumask irq_affinity;
>         spinlock_t irq_affinity_lock;
>         struct kobject kobj;
> +       bool enable_irq_wq;
>  };
>
>  struct vduse_dev;
> @@ -1013,6 +1014,26 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
>         return ret;
>  }
>
> +static int vduse_dev_inject_vq_irq(struct vduse_dev *dev,
> +                                  struct vduse_virtqueue *vq)
> +{
> +       int ret = -EINVAL;
> +
> +       down_read(&dev->rwsem);
> +       if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +               goto unlock;
> +
> +       ret = 0;
> +       spin_lock_irq(&vq->irq_lock);
> +       if (vq->ready && vq->cb.callback)
> +               vq->cb.callback(vq->cb.private);
> +       spin_unlock_irq(&vq->irq_lock);
> +unlock:
> +       up_read(&dev->rwsem);
> +
> +       return ret;
> +}
> +
>  static int vduse_dev_dereg_umem(struct vduse_dev *dev,
>                                 u64 iova, u64 size)
>  {
> @@ -1278,8 +1299,12 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                         break;
>
>                 index = array_index_nospec(index, dev->vq_num);
> -               ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index]->inject,
> +               if (dev->vqs[index]->enable_irq_wq)
> +                       ret = vduse_dev_queue_irq_work(dev,
> +                                       &dev->vqs[index]->inject,
>                                         dev->vqs[index]->irq_effective_cpu);
> +               else
> +                       ret = vduse_dev_inject_vq_irq(dev, dev->vqs[index]);
>                 break;
>         }
>         case VDUSE_IOTLB_REG_UMEM: {
> @@ -1420,6 +1445,26 @@ static const struct file_operations vduse_dev_fops = {
>         .llseek         = noop_llseek,
>  };
>
> +static ssize_t enable_irq_wq_show(struct vduse_virtqueue *vq, char *buf)
> +{
> +       return sprintf(buf, "%d\n", vq->enable_irq_wq);
> +}
> +
> +static ssize_t enable_irq_wq_store(struct vduse_virtqueue *vq,
> +                                  const char *buf, size_t count)
> +{
> +       bool enabled;
> +       int ret;
> +
> +       ret = kstrtobool(buf, &enabled);
> +       if (ret)
> +               return ret;
> +
> +       vq->enable_irq_wq = enabled;
> +
> +       return count;
> +}
> +
>  static ssize_t irq_cb_affinity_show(struct vduse_virtqueue *vq, char *buf)
>  {
>         return sprintf(buf, "%*pb\n", cpumask_pr_args(&vq->irq_affinity));
> @@ -1480,10 +1525,12 @@ struct vq_sysfs_entry {
>  static struct vq_sysfs_entry irq_cb_affinity_attr = __ATTR_RO(irq_cb_affinity);
>  static struct vq_sysfs_entry irq_cb_effective_affinity_attr =
>                                         __ATTR_RW(irq_cb_effective_affinity);
> +static struct vq_sysfs_entry enable_irq_wq_attr = __ATTR_RW(enable_irq_wq);
>
>  static struct attribute *vq_attrs[] = {
>         &irq_cb_affinity_attr.attr,
>         &irq_cb_effective_affinity_attr.attr,
> +       &enable_irq_wq_attr.attr,
>         NULL,
>  };
>  ATTRIBUTE_GROUPS(vq);
> @@ -1565,6 +1612,7 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
>
>                 dev->vqs[i]->index = i;
>                 dev->vqs[i]->irq_effective_cpu = -1;
> +               dev->vqs[i]->enable_irq_wq = true;
>                 INIT_WORK(&dev->vqs[i]->inject, vduse_vq_irq_inject);
>                 INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
>                 spin_lock_init(&dev->vqs[i]->kick_lock);
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
