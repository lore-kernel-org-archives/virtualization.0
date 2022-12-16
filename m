Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9A3C4332F
	for <virtualization@archiver.kernel.org>; Fri, 16 Dec 2022 05:30:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F758409B4;
	Fri, 16 Dec 2022 05:30:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F758409B4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PsCw/RwC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LcAOlkbGBmgZ; Fri, 16 Dec 2022 05:30:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 45FAC4091E;
	Fri, 16 Dec 2022 05:30:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 45FAC4091E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2133FC0033;
	Fri, 16 Dec 2022 05:30:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0604C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 05:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B233A8205F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 05:30:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B233A8205F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PsCw/RwC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lYPkbq332ztf
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 05:30:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B50F58204C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B50F58204C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 05:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671168626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3+XU3NOi5/AH6byjyKh3uKPQGZdUxmKJMRxGY2jtMG4=;
 b=PsCw/RwCsCp7tYJDaVEUPEKE3+tejVgSyv6JvL7+UnVLtGrcDFGIoD+x3BAahZdAvlx6iA
 bWR6eLkJ+H8uCRmRPa2YybDA2MVr2iHXlLO9BFrbxnu1WKS0zPdwWYCOzI+aubmM5wL7Ns
 0zyBw39dix7Y33JZz0JOMX7ciJ0hTIg=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-294-oO8k0By3MAO2vum9SvYplg-1; Fri, 16 Dec 2022 00:30:24 -0500
X-MC-Unique: oO8k0By3MAO2vum9SvYplg-1
Received: by mail-oo1-f70.google.com with SMTP id
 y19-20020a4a9c13000000b0049dd7ad41c4so741281ooj.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 21:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3+XU3NOi5/AH6byjyKh3uKPQGZdUxmKJMRxGY2jtMG4=;
 b=PtQaUxHtwy+VRJPArSzwgM+Al0dWeXKgJe8eWHGQpLIXg8sd3NQqmuxNTSDHYxtUfN
 ZSBsNJXd5bI7jpt6UJpKI1ETWw+RDxoGlCl6/4YIaxdYz6G/jYGfGb2tkBih/ByyqQlp
 +HHhlDFo6JWDgLD50UqWOE0EXgBfORF0TrBPqmfJSmT6qsBnw9VOAsbkiG01gcGjDrGz
 JMMUPEOSLM5Lt7jw0irDwb4CB91YMcj4NUG86pP9s3EtZQHGDVLZ3kjgYHek3+KmarBh
 pnv54pimdUIZhLgxb73ONpzO1hzxFh98rE0WjcMZ0czPMPjEzqw0NKCvu80rp1zLb8cA
 Tmfg==
X-Gm-Message-State: ANoB5pl02X9cXepuZP8sSgbErG56HIiYeVdLDDFjVFF6DdSXZ1ezVXkh
 sSzS5SzNhfxfTqnWkDnlW5vdkCJyCvPV1h67EvAPnJUSLUwdOREt7e5MuY4d64CdwILpgY9UiYd
 xBjHifSWJR18lXbsMSaaXpFq9vJRYzI/C03DiRDra93ojejrOwKkTzIKR3Q==
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id
 cm5-20020a056830650500b0066cfb5b4904mr49184169otb.237.1671168624163; 
 Thu, 15 Dec 2022 21:30:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6BrOptlv6D9XDmrSx9Gl/+QASruxbWSD27Gp2XJqBb4LkjXk5a8WbVpb7gaZS4dCUJ7gxwKJDDAhCpCBzolGs=
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id
 cm5-20020a056830650500b0066cfb5b4904mr49184168otb.237.1671168623904; Thu, 15
 Dec 2022 21:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205085846.741-1-xieyongji@bytedance.com>
In-Reply-To: <20221205085846.741-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 Dec 2022 13:30:12 +0800
Message-ID: <CACGkMEuhYO3neFmxwiBp8C0QTaa+Mb13kken+RZ9QuruMct6tA@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] vduse: Support automatic irq callback affinity
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

On Mon, Dec 5, 2022 at 4:59 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> This brings current interrupt affinity spreading mechanism
> to vduse device. We will make use of irq_create_affinity_masks()
> to create an irq callback affinity mask for each virtqueue of
> vduse device. Then we will choose the CPU which has the lowest
> number of interrupt allocated in the affinity mask to run the
> irq callback.

This seems a balance mechanism but it might not be the semantic of the
affinity or any reason we need to do this? I guess we should use at
least round-robin in this case.

>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 50 ++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index d126f3e32a20..90c2896039d9 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -23,6 +23,7 @@
>  #include <linux/nospec.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched/mm.h>
> +#include <linux/interrupt.h>
>  #include <uapi/linux/vduse.h>
>  #include <uapi/linux/vdpa.h>
>  #include <uapi/linux/virtio_config.h>
> @@ -58,6 +59,8 @@ struct vduse_virtqueue {
>         struct work_struct inject;
>         struct work_struct kick;
>         int irq_effective_cpu;
> +       struct cpumask irq_affinity;
> +       spinlock_t irq_affinity_lock;

Ok, I'd suggest to squash this into patch 5 to make it more easier to
be reviewed.

>  };
>
>  struct vduse_dev;
> @@ -123,6 +126,7 @@ struct vduse_control {
>
>  static DEFINE_MUTEX(vduse_lock);
>  static DEFINE_IDR(vduse_idr);
> +static DEFINE_PER_CPU(unsigned long, vduse_allocated_irq);
>
>  static dev_t vduse_major;
>  static struct class *vduse_class;
> @@ -710,6 +714,49 @@ static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
>         return dev->generation;
>  }
>
> +static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
> +{
> +       unsigned int cpu, best_cpu;
> +       unsigned long allocated, allocated_min = UINT_MAX;
> +
> +       spin_lock(&vq->irq_affinity_lock);
> +
> +       best_cpu = vq->irq_effective_cpu;
> +       if (best_cpu != -1)
> +               per_cpu(vduse_allocated_irq, best_cpu) -= 1;
> +
> +       for_each_cpu(cpu, &vq->irq_affinity) {
> +               allocated = per_cpu(vduse_allocated_irq, cpu);
> +               if (!cpu_online(cpu) || allocated >= allocated_min)
> +                       continue;
> +
> +               best_cpu = cpu;
> +               allocated_min = allocated;
> +       }
> +       vq->irq_effective_cpu = best_cpu;
> +       per_cpu(vduse_allocated_irq, best_cpu) += 1;
> +
> +       spin_unlock(&vq->irq_affinity_lock);
> +}
> +
> +static void vduse_vdpa_set_irq_affinity(struct vdpa_device *vdpa,
> +                                       struct irq_affinity *desc)
> +{
> +       struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +       struct irq_affinity_desc *affd = NULL;
> +       int i;
> +
> +       affd = irq_create_affinity_masks(dev->vq_num, desc);
> +       if (!affd)

Let's add a comment on the vdpa config ops to say set_irq_affinity()
is best effort.

Thanks

> +               return;
> +
> +       for (i = 0; i < dev->vq_num; i++) {
> +               cpumask_copy(&dev->vqs[i]->irq_affinity, &affd[i].mask);
> +               vduse_vq_update_effective_cpu(dev->vqs[i]);
> +       }
> +       kfree(affd);
> +}
> +
>  static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
>                                 unsigned int asid,
>                                 struct vhost_iotlb *iotlb)
> @@ -760,6 +807,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
>         .get_config             = vduse_vdpa_get_config,
>         .set_config             = vduse_vdpa_set_config,
>         .get_generation         = vduse_vdpa_get_generation,
> +       .set_irq_affinity       = vduse_vdpa_set_irq_affinity,
>         .reset                  = vduse_vdpa_reset,
>         .set_map                = vduse_vdpa_set_map,
>         .free                   = vduse_vdpa_free,
> @@ -1380,6 +1428,8 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
>                 INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
>                 spin_lock_init(&dev->vqs[i]->kick_lock);
>                 spin_lock_init(&dev->vqs[i]->irq_lock);
> +               spin_lock_init(&dev->vqs[i]->irq_affinity_lock);
> +               cpumask_setall(&dev->vqs[i]->irq_affinity);
>         }
>
>         return 0;
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
