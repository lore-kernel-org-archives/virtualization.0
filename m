Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72849C4332F
	for <virtualization@archiver.kernel.org>; Fri, 16 Dec 2022 05:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D7AA740289;
	Fri, 16 Dec 2022 05:35:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D7AA740289
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jrj9as+m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pojsPnpBC9qP; Fri, 16 Dec 2022 05:35:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3691C40327;
	Fri, 16 Dec 2022 05:35:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3691C40327
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BE01C0033;
	Fri, 16 Dec 2022 05:35:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87D58C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 05:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 68B0482036
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 05:35:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 68B0482036
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jrj9as+m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FFAdFBZKiQgE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 05:35:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5671782019
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5671782019
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 05:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671168948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=15kneUv6xIwsc7YmiaK1y3hzzsO9x/bfH79/junA/Zk=;
 b=Jrj9as+m3IfFXqIQJaYPUe884mspn+Z0RGHRcZVTXRW3bwZ8wttKP8+Ei3LjLwYCQZ2BMi
 CLvWtSUnjLSlHls4QQXNRIyDPfxffRJWJNJUJ9Gelft9kLbwc/xeZcmoaEnHVgNiwvlFeq
 xjKGlM5EQCLNGNaB3KHuDqxpae2ZPvY=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-153-qnIMpTLGM_a0K4H-issfjw-1; Fri, 16 Dec 2022 00:35:37 -0500
X-MC-Unique: qnIMpTLGM_a0K4H-issfjw-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-1441866fa6cso804417fac.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 21:35:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=15kneUv6xIwsc7YmiaK1y3hzzsO9x/bfH79/junA/Zk=;
 b=GoB8I/yOXpWqpNpjpib3BItDC5UIRq9nP14GLdJlB4/wwTpMpVXhGnVxClGWLTmdc3
 /BpbSS7YDO2IevwvhMag3LAaJoEWTuRj9otKDzwZ317bgqpYQOb8fvpb7W0kFwjqrUGV
 dmPPf55F/FBP9pAvemeAo2jUVuKKPo4oErLDXrwwX+Hu5URVg+0dSflrGTEXT/1t4hPj
 xQKxsqgahqX5bXYM9QwzdB452zhzLuE93FHSP6RnY1SBGCUlYdSI3NLTW8PdiIpQDRBM
 jF2i1SDK+hQQM8nD5NxSuOhegcXeV4sP44u9tAuI6zogU+eBKZTRCrlulZo4npuMb4zm
 x8oQ==
X-Gm-Message-State: ANoB5pmoPkecdWUrx/v0+OGFO6tQ0hTN/uiDd+y2SQAXEgaR0Q6aeLrH
 WL67lfQnFSjUxdL6HQId9PfTd5jfKZ4S/DOnMokDyNlplNxqff9iO2eQT0ecPLdL1W0TDBok0yp
 DrgmPtCzT0YSeQb/fl8oHaBCfWHUyV05rc+vapjaFH6PR6dUQIkR3tH75iQ==
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr333519oab.35.1671168936519; 
 Thu, 15 Dec 2022 21:35:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6vAcuuDYaqibZH4I1Z22WkAii2wf8+1cShP52aqKRcbNLv1gQJ2SoMjC6INmiqsmfRZ4BBxnMALM837rgIiWY=
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr333515oab.35.1671168936300; Thu, 15
 Dec 2022 21:35:36 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205090243.791-1-xieyongji@bytedance.com>
 <20221205090243.791-2-xieyongji@bytedance.com>
In-Reply-To: <20221205090243.791-2-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 Dec 2022 13:35:25 +0800
Message-ID: <CACGkMEsX1RjU_ncNTY-KbeUY8bxm7X62V_SNO=hMehZRuGQ+CQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] vduse: Add sysfs interface for irq callback
 affinity
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
> Add sysfs interface for each vduse virtqueue to
> show the affinity and effective affinity for irq
> callback.
>
> And we can also use this interface to change the
> effective affinity which must be a subset of the
> irq callback affinity mask for the virtqueue. This
> might be useful for performance tuning when the irq
> callback affinity mask contains more than one CPU.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 148 ++++++++++++++++++++++++++---
>  1 file changed, 137 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 6507a78abc9d..c65f84100e30 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -61,6 +61,7 @@ struct vduse_virtqueue {
>         int irq_effective_cpu;
>         struct cpumask irq_affinity;
>         spinlock_t irq_affinity_lock;
> +       struct kobject kobj;
>  };
>
>  struct vduse_dev;
> @@ -1419,6 +1420,120 @@ static const struct file_operations vduse_dev_fops = {
>         .llseek         = noop_llseek,
>  };
>
> +static ssize_t irq_cb_affinity_show(struct vduse_virtqueue *vq, char *buf)
> +{
> +       return sprintf(buf, "%*pb\n", cpumask_pr_args(&vq->irq_affinity));
> +}
> +
> +static ssize_t irq_cb_effective_affinity_show(struct vduse_virtqueue *vq,
> +                                             char *buf)
> +{
> +       struct cpumask all_mask = CPU_MASK_ALL;
> +       const struct cpumask *mask = &all_mask;
> +
> +       if (vq->irq_effective_cpu != -1)
> +               mask = get_cpu_mask(vq->irq_effective_cpu);

Shouldn't this be vq->irq_affinity?

> +
> +       return sprintf(buf, "%*pb\n", cpumask_pr_args(mask));
> +}
> +
> +static ssize_t irq_cb_effective_affinity_store(struct vduse_virtqueue *vq,
> +                                              const char *buf, size_t count)
> +{
> +       cpumask_var_t new_value;
> +       int ret;
> +
> +       if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
> +               return -ENOMEM;
> +
> +       ret = cpumask_parse(buf, new_value);
> +       if (ret)
> +               goto free_mask;
> +
> +       ret = -EINVAL;
> +       if (!cpumask_intersects(new_value, &vq->irq_affinity))
> +               goto free_mask;
> +
> +       spin_lock(&vq->irq_affinity_lock);
> +
> +       if (vq->irq_effective_cpu != -1)
> +               per_cpu(vduse_allocated_irq, vq->irq_effective_cpu) -= 1;
> +
> +       vq->irq_effective_cpu = cpumask_first(new_value);

Does this mean except for the first cpu, the rest of the mask is unused?

Thanks

> +       per_cpu(vduse_allocated_irq, vq->irq_effective_cpu) += 1;
> +
> +       spin_unlock(&vq->irq_affinity_lock);
> +       ret = count;
> +
> +free_mask:
> +       free_cpumask_var(new_value);
> +       return ret;
> +}
> +
> +struct vq_sysfs_entry {
> +       struct attribute attr;
> +       ssize_t (*show)(struct vduse_virtqueue *vq, char *buf);
> +       ssize_t (*store)(struct vduse_virtqueue *vq, const char *buf,
> +                        size_t count);
> +};
> +
> +static struct vq_sysfs_entry irq_cb_affinity_attr = __ATTR_RO(irq_cb_affinity);
> +static struct vq_sysfs_entry irq_cb_effective_affinity_attr =
> +                                       __ATTR_RW(irq_cb_effective_affinity);
> +
> +static struct attribute *vq_attrs[] = {
> +       &irq_cb_affinity_attr.attr,
> +       &irq_cb_effective_affinity_attr.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(vq);
> +
> +static ssize_t vq_attr_show(struct kobject *kobj, struct attribute *attr,
> +                           char *buf)
> +{
> +       struct vduse_virtqueue *vq = container_of(kobj,
> +                                       struct vduse_virtqueue, kobj);
> +       struct vq_sysfs_entry *entry = container_of(attr,
> +                                       struct vq_sysfs_entry, attr);
> +
> +       if (!entry->show)
> +               return -EIO;
> +
> +       return entry->show(vq, buf);
> +}
> +
> +static ssize_t vq_attr_store(struct kobject *kobj, struct attribute *attr,
> +                            const char *buf, size_t count)
> +{
> +       struct vduse_virtqueue *vq = container_of(kobj,
> +                                       struct vduse_virtqueue, kobj);
> +       struct vq_sysfs_entry *entry = container_of(attr,
> +                                       struct vq_sysfs_entry, attr);
> +
> +       if (!entry->store)
> +               return -EIO;
> +
> +       return entry->store(vq, buf, count);
> +}
> +
> +static const struct sysfs_ops vq_sysfs_ops = {
> +       .show = vq_attr_show,
> +       .store = vq_attr_store,
> +};
> +
> +static void vq_release(struct kobject *kobj)
> +{
> +       struct vduse_virtqueue *vq = container_of(kobj,
> +                                       struct vduse_virtqueue, kobj);
> +       kfree(vq);
> +}
> +
> +static struct kobj_type vq_type = {
> +       .release        = vq_release,
> +       .sysfs_ops      = &vq_sysfs_ops,
> +       .default_groups = vq_groups,
> +};
> +
>  static void vduse_dev_deinit_vqs(struct vduse_dev *dev)
>  {
>         int i;
> @@ -1427,13 +1542,13 @@ static void vduse_dev_deinit_vqs(struct vduse_dev *dev)
>                 return;
>
>         for (i = 0; i < dev->vq_num; i++)
> -               kfree(dev->vqs[i]);
> +               kobject_put(&dev->vqs[i]->kobj);
>         kfree(dev->vqs);
>  }
>
>  static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
>  {
> -       int i;
> +       int ret, i;
>
>         dev->vq_align = vq_align;
>         dev->vq_num = vq_num;
> @@ -1443,8 +1558,10 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
>
>         for (i = 0; i < vq_num; i++) {
>                 dev->vqs[i] = kzalloc(sizeof(*dev->vqs[i]), GFP_KERNEL);
> -               if (!dev->vqs[i])
> +               if (!dev->vqs[i]) {
> +                       ret = -ENOMEM;
>                         goto err;
> +               }
>
>                 dev->vqs[i]->index = i;
>                 dev->vqs[i]->irq_effective_cpu = -1;
> @@ -1454,15 +1571,23 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
>                 spin_lock_init(&dev->vqs[i]->irq_lock);
>                 spin_lock_init(&dev->vqs[i]->irq_affinity_lock);
>                 cpumask_setall(&dev->vqs[i]->irq_affinity);
> +
> +               kobject_init(&dev->vqs[i]->kobj, &vq_type);
> +               ret = kobject_add(&dev->vqs[i]->kobj,
> +                                 &dev->dev->kobj, "vq%d", i);
> +               if (ret) {
> +                       kfree(dev->vqs[i]);
> +                       goto err;
> +               }
>         }
>
>         return 0;
>  err:
>         while (i--)
> -               kfree(dev->vqs[i]);
> +               kobject_put(&dev->vqs[i]->kobj);
>         kfree(dev->vqs);
>         dev->vqs = NULL;
> -       return -ENOMEM;
> +       return ret;
>  }
>
>  static struct vduse_dev *vduse_dev_create(void)
> @@ -1637,10 +1762,6 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>         dev->config = config_buf;
>         dev->config_size = config->config_size;
>
> -       ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
> -       if (ret)
> -               goto err_vqs;
> -
>         ret = idr_alloc(&vduse_idr, dev, 1, VDUSE_DEV_MAX, GFP_KERNEL);
>         if (ret < 0)
>                 goto err_idr;
> @@ -1654,14 +1775,19 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>                 ret = PTR_ERR(dev->dev);
>                 goto err_dev;
>         }
> +
> +       ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
> +       if (ret)
> +               goto err_vqs;
> +
>         __module_get(THIS_MODULE);
>
>         return 0;
> +err_vqs:
> +       device_destroy(vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
>  err_dev:
>         idr_remove(&vduse_idr, dev->minor);
>  err_idr:
> -       vduse_dev_deinit_vqs(dev);
> -err_vqs:
>         vduse_domain_destroy(dev->domain);
>  err_domain:
>         kfree(dev->name);
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
