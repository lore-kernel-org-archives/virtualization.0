Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBBEC433FE
	for <virtualization@archiver.kernel.org>; Mon, 14 Nov 2022 07:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 14AF2409E9;
	Mon, 14 Nov 2022 07:58:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 14AF2409E9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SgHnv/Xa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9pTK8IQeTs8g; Mon, 14 Nov 2022 07:58:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 86E22409D3;
	Mon, 14 Nov 2022 07:58:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 86E22409D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46DABC0032;
	Mon, 14 Nov 2022 07:58:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FBF7C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 07:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1B5980E4F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 07:58:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D1B5980E4F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SgHnv/Xa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id grbDt3UfTsfB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 07:58:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E13B80D20
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E13B80D20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 07:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668412718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u9Vri5YF5wLHPwCb7qBcbtV4UMW1YjBA+Dbl2x/KC1Y=;
 b=SgHnv/XaxcyXdP80i1oyPSP9Jo6nzF+ESaN0YTfdd9unfB7j15+mXzKd/smi7HqrtWd7R5
 3V7OS2Zw0oLeFIEa9oyu5YWQCnpP15IjxaxJbfsqwYDk1okH2L6wBjqPVNnY+19sx0vDC+
 xj9R76d14lCT1RKkKgphM0qRDrmaZYk=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-472-QeCZ2GouPZSp295Uu8DxTQ-1; Mon, 14 Nov 2022 02:58:37 -0500
X-MC-Unique: QeCZ2GouPZSp295Uu8DxTQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 x203-20020acae0d4000000b0035a623fce1aso2952267oig.10
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 23:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u9Vri5YF5wLHPwCb7qBcbtV4UMW1YjBA+Dbl2x/KC1Y=;
 b=hFhU+rmcwiPnkvHJR17uK/CKYMZiD4DCCDWCdo0ol4KLSRodZyqKWC6k+HemJ4UcU9
 fpQSGacsyOyHjEP2dW1PPxwtT3UDjIGXI60XpU++4YqOrZsMeWXIIQ4MVRdTV7BLtK5v
 YKltBECKZEdp8yTGr7D+Y4zI6GBg6+pyquurfjPITjxAfNrLjo5vlMgrG7Px/WmpFccV
 xH6jN7TlXHpCz6kMmQWWv0HEj2guhDH3x4yJjuEH9JSweKGCHWW2IarKLAswf6/20NCt
 T0wlvXLG5+HmXb/fjrpVyec8sE5TLQuKMCIPyhBNmTJaz75zHXpwiu6VlAvt0r8+ErFp
 mG6Q==
X-Gm-Message-State: ANoB5pkz3IReoBCber7dOGghLBVFvN/ZY38LGRzM2rr+ntJgax4hui/w
 7KZt91NzK6cd3csY0XJXv2Z5AKvakZPEGK8Sy1WLkO+HzNdt7XdJkUGOQL4LmHfxulcTi4McPO/
 iaZCS/5DkopR/ZusI1p5lDSzm3PtyeOukYJwN/ZBE7N7KydSJK077btqdAA==
X-Received: by 2002:a05:6808:22a1:b0:359:f5eb:82ec with SMTP id
 bo33-20020a05680822a100b00359f5eb82ecmr5096002oib.280.1668412716589; 
 Sun, 13 Nov 2022 23:58:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf58nG4usnDPs5fqaEsioczJcO6qu7BmHpVEbAsV/sQXO0qGZP2+Zv4Znqtin27Fc7G5id+6Zv3e97H9pv88hZg=
X-Received: by 2002:a05:6808:22a1:b0:359:f5eb:82ec with SMTP id
 bo33-20020a05680822a100b00359f5eb82ecmr5095994oib.280.1668412716368; Sun, 13
 Nov 2022 23:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20221114070233.248-1-xieyongji@bytedance.com>
 <20221114070233.248-4-xieyongji@bytedance.com>
In-Reply-To: <20221114070233.248-4-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Nov 2022 15:58:25 +0800
Message-ID: <CACGkMEsbScqRtZeJ51ySiYdR_DrHwVAEGg_n0TR2mA2nK9e7sQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] vduse: Add sysfs interface for irq affinity setup
To: Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
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

On Mon, Nov 14, 2022 at 3:16 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> Add sysfs interface for each vduse virtqueue to setup
> irq affinity. This would be useful for performance
> tuning, e.g., mitigate the virtqueue lock contention
> in virtio block driver.

Do we have any perforamnce numbers for this?

Btw, I wonder if irq is the best for the name since we actually don't
use IRQ at all. I guess using "callback" might be better?

Thanks

>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 113 ++++++++++++++++++++++++++---
>  1 file changed, 102 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 9303942c2e64..3a0922fa7eb2 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -57,6 +57,7 @@ struct vduse_virtqueue {
>         struct vdpa_callback cb;
>         struct work_struct inject;
>         struct work_struct kick;
> +       struct kobject kobj;
>         int irq_affinity;
>  };
>
> @@ -1347,6 +1348,88 @@ static const struct file_operations vduse_dev_fops = {
>         .llseek         = noop_llseek,
>  };
>
> +static ssize_t irq_affinity_show(struct vduse_virtqueue *vq, char *buf)
> +{
> +       return sprintf(buf, "%d\n", vq->irq_affinity);
> +}
> +
> +static ssize_t irq_affinity_store(struct vduse_virtqueue *vq,
> +                                    const char *buf, size_t count)
> +{
> +       int val;
> +
> +       if (kstrtoint(buf, 0, &val) < 0)
> +               return -EINVAL;
> +
> +       if (!(val == -1 || (val <= nr_cpu_ids && val >= 0 && cpu_online(val))))
> +               return -EINVAL;
> +
> +       vq->irq_affinity = val;
> +
> +       return count;
> +}
> +
> +struct vq_sysfs_entry {
> +       struct attribute attr;
> +       ssize_t (*show)(struct vduse_virtqueue *vq, char *buf);
> +       ssize_t (*store)(struct vduse_virtqueue *vq, const char *buf,
> +                        size_t count);
> +};
> +
> +static struct vq_sysfs_entry irq_affinity_attr = __ATTR_RW(irq_affinity);
> +
> +static struct attribute *vq_attrs[] = {
> +       &irq_affinity_attr.attr,
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
> @@ -1355,13 +1438,13 @@ static void vduse_dev_deinit_vqs(struct vduse_dev *dev)
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
> @@ -1371,8 +1454,10 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
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
>                 dev->vqs[i]->irq_affinity = -1;
> @@ -1380,15 +1465,20 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
>                 INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
>                 spin_lock_init(&dev->vqs[i]->kick_lock);
>                 spin_lock_init(&dev->vqs[i]->irq_lock);
> +               kobject_init(&dev->vqs[i]->kobj, &vq_type);
> +               ret = kobject_add(&dev->vqs[i]->kobj,
> +                                 &dev->dev->kobj, "vq%d", i);
> +               if (ret)
> +                       goto err;
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
> @@ -1563,10 +1653,6 @@ static int vduse_create_dev(struct vduse_dev_config *config,
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
> @@ -1580,14 +1666,19 @@ static int vduse_create_dev(struct vduse_dev_config *config,
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
