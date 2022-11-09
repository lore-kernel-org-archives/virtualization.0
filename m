Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA846C4332F
	for <virtualization@archiver.kernel.org>; Wed,  9 Nov 2022 09:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59DD1606E6;
	Wed,  9 Nov 2022 09:44:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 59DD1606E6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=hymZ8ZM3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Vro6MY9e7ID; Wed,  9 Nov 2022 09:44:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BF786605EA;
	Wed,  9 Nov 2022 09:44:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF786605EA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9410EC0032;
	Wed,  9 Nov 2022 09:44:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E61BDC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 09:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF4A240B05
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 09:44:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CF4A240B05
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=hymZ8ZM3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wtmY8m8u3mKN
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 09:44:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BFF354019D
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BFF354019D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 09:44:45 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id l127so18223269oia.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Nov 2022 01:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yd7m0UKXqi53ClJL65yU8qjDOwcft3F2iuOqP1KsINc=;
 b=hymZ8ZM3A8U1kgf39F85p1YVXuAglTXNsj/KUSoy7TW7bmc9iEz3e0mPdQjsQ2QOcx
 kCBMwRLJjh0PPIoo8a7zeBMs0UmJxuOEuW4L8QAq4H8t7PibzuBM4MOvCwM/DY2OOKd0
 KGM/+t/O+UvTtdrmH2Iq633uVVv+Wm/3TZHD2DpycDqRmU7jrxnzMXly3CdPjJDzRLPF
 JXdTNhqryqUSeLSWaaXEWTlT0598Bq8UpEZMDRwdVsobYxKXO5P8hfu0iMxM4VpiKIhV
 apRV4ieWPCXtoP/CQKCGxu3GCDywUaNJ970sOn6M875CmAQJT8iMKOEUgFx50XTa4HSC
 4fQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yd7m0UKXqi53ClJL65yU8qjDOwcft3F2iuOqP1KsINc=;
 b=I35zeN6GrF5Ukiz2OxRgqsBt/inc9nz0knuKN/JPoES/EqYNMpOnq5gxqfFI7bz7IW
 7bX3L6ltTG7V+s5vc25W2jqEj8BsrR80/Qb6uBS22nkeFdQ2CiZX7vRCoLTnQGFNzpea
 rjVVAqra3GE73tMO68Bfaiu0oZqJRq2ylwmPv1QA26f9sG6+Om4ZgzjQ4eDcsw+xC+Bz
 34ugO0G/xL2y2hSaWSSWjGb+MOyLzzOtq9U5l9fPqxoS9m27It1BDYHZTIwenKOEtIhE
 vtIAsFYE8ONnOAThS4o0qfqaGaZmUvkNu2/h0Ggot+mr1NYxNgQa/ueqZH7GjTjJSto6
 Zk+A==
X-Gm-Message-State: ACrzQf067oN7LQJgr84kJTV8yctR9j/RjibBs7unREfBgHe5QlKBvIs0
 MNshRv1l7dx6WakGRfNI72ThUPRztWApGVK7P+Lxow==
X-Google-Smtp-Source: AMsMyM4wZF5+sgmn9/18LUpSBDu6adEoWpRpXlvjP9yVpy9vQ4Bie62xiFY4NvYUJ21vmybMqmqf/D+dw0MUpN06B7M=
X-Received: by 2002:a05:6808:1391:b0:35a:6109:c91b with SMTP id
 c17-20020a056808139100b0035a6109c91bmr14553044oiw.273.1667987084672; Wed, 09
 Nov 2022 01:44:44 -0800 (PST)
MIME-Version: 1.0
References: <20221108100925.823841-1-alvaro.karsz@solid-run.com>
 <318f4b6e-bcd5-a269-b385-f0e521c2ee9a@redhat.com>
In-Reply-To: <318f4b6e-bcd5-a269-b385-f0e521c2ee9a@redhat.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 9 Nov 2022 11:44:09 +0200
Message-ID: <CAJs=3_BTL3Rdrnbykgzy5arA5xOoUGz6Y_g6yUNpZg7hfouVSw@mail.gmail.com>
Subject: Re: [PATCH] virtio: vdpa: new SolidNET DPU driver.
To: Jason Wang <jasowang@redhat.com>
Cc: Jean Delvare <jdelvare@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>, virtualization@lists.linux-foundation.org
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

Hi Jason,

> If I was not wrong, this value seems doesn't change. If yes, I wonder we
> can move the kick_offset logic to snet_alloc_dev()?


There is not a real reason to have this logic in snet_set_vq_address,
so it could be moved to snet_build_vqs (which is called within
snet_alloc_dev).

> -EOPNOTSUPP?


Returning an error from the set_vq_state callback leads to probe failure.
This code is taken from drivers/virtio/virtio_vdpa.c,
virtio_vdpa_setup_vq function:

>  struct vdpa_vq_state state = {0};
>
> ......
>
> err = ops->set_vq_state(vdpa, index, &state);
> if (err)
>         goto err_vq;


I could check struct vdpa_vq_state, and return 0 if struct
vdpa_vq_state value is 0, -EOPNOTSUPP otherwise.
What do you think?

> I fail to understand how can this work. E.g after reset there should be
> no interaction from the device like DMA, otherwise there could have
> security implications.


You're right, I'll add a proper reset callback.

> Since read is ordered with write, a more easy way is to perform a ioread
> here.
> Interesting, which barrier is this paired?


Usually reads are slow, but we don't care about speed when sending
messages (since we only send a "destroy" message so far, meaning that
the pci remove callback was called), so the memory barrier can be
replaced with a read operation.

>
> Do we need to do endian conversion here (cpu_to_le64())?


Yes, I'll add it.

>
> Need to take endianess into account.


I'm not sure about that.
The endianness appears to be handled by the caller.
Function from include/linux/virtio_config.h

> static inline void virtio_cwrite16(struct virtio_device *vdev,
>   unsigned int offset, u16 val)
> {
>     __virtio16 v;
>
>
>     might_sleep();
>     v = cpu_to_virtio16(vdev, val);
>     vdev->config->set(vdev, offset, &v, sizeof(v));
> }


> static inline void virtio_cwrite32(struct virtio_device *vdev,
>   unsigned int offset, u32 val)
> {
>     __virtio32 v;
>
>
>     might_sleep();
>     v = cpu_to_virtio32(vdev, val);
>     vdev->config->set(vdev, offset, &v, sizeof(v));
> }
>


> static inline void virtio_cwrite64(struct virtio_device *vdev,
>   unsigned int offset, u64 val)
> {
>     __virtio64 v;
>
>
>     might_sleep();
>     v = cpu_to_virtio64(vdev, val);
>     vdev->config->set(vdev, offset, &v, sizeof(v));
> }


I'm not sure how the endianness can be handled by the vDPA driver.
This function may be called for a 8bit, 16bit, 32bit or 64bit variables.
It theoretically may be called to change multiple variables at once.
It may be called to change part of a variable.


>  If I was not wrong, the device depends on the platform IOMMU to work. So
> unless device have a more strict iova range than what platform IOMMU can
> provide, we can simply not advertise this and use the one that is
> provided by the IOMMU:
>
>
> static void vhost_vdpa_set_iova_range(struct vhost_vdpa *v)
> {
>          struct vdpa_iova_range *range = &v->range;
>          struct vdpa_device *vdpa = v->vdpa;
>          const struct vdpa_config_ops *ops = vdpa->config;
>
>
>          if (ops->get_iova_range) {
>                  *range = ops->get_iova_range(vdpa);
>          } else if (v->domain && v->domain->geometry.force_aperture) {
>                  range->first = v->domain->geometry.aperture_start;
>                  range->last = v->domain->geometry.aperture_end;
>          } else {
>                  range->first = 0;
>                  range->last = ULLONG_MAX;
>          }
> }


I'll delete the snet_get_iova_range function.

> Any chance to use device managed region helper here? It seems to
> simplify the codes (e.g the cleanup stuffs).


Ok, I'll do it.

> Is this better to say "config is not ready"? Btw, I wonder if it makes
> more sense to wait until the confg is ready with a timeout?


Good idea, I'll implement the wait & timeout.

> I wonder if it's worth to bother consider we're using devres to manage irqs.


You're right, this isn't required, I'll remove it.

>
> It looks to me all the devices created here use the same dma_dev (the
> PCI device), I wonder how the DMA is isolated among the vDPA devices
> created here.


All vDPA devices indeed use the same DMA device, there is no isolation
between the devices.
I'm not sure why there should be isolation in this case.

> Btw, the vDPA has been switched to use vDPA tool to create devices, it
> is suggested to implement the mgmt devices as what other parents did.
> Then the snet_alloc_dev() could be used for dev_add().


We want to leave control to the DPU at the moment, the number/type of
devices is determined by the DPU's config, and can't be controlled
from userspace.

> There looks like a race, the vDPA device could be registered to the bus
> and used by userspace by bus master/drvdata is set.


You're right, the vdpa registration should be done after the
master/drvdata is set.

> I think devres should take care of this since we're using
> pcim_enable_device()?


You're right, this isn't required, I'll remove it.

> According to the code, this seems to be the driver features and


These are the negotiated features
We're not keeping record of the driver features, when
set_driver_features is called, we just logic AND the driver features
with the supported features received from the DPU.
I'll rename it to be 'negotiated_features", this seems more accurate.

> static int snet_set_drv_features(struct vdpa_device *vdev, u64 features)
> {
>     struct snet *snet = vdpa_to_snet(vdev);
>
>
>     snet->used_features = snet->cfg->features & features;
>     return 0;
> }



> This seems to be unused.


You're right, I'll remove it.


Thank you for your comments.
I'll send a new version once I finish working on the comments.

Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
