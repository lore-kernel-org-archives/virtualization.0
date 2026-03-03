Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41C8386545
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522788; cv=none; b=N1JqYPQZRQ9SPZsSyJ4mBOHSCIjmAibgEPfxB6Df9YlEZi21bFPM33a86RaBsvEmSv65ivqwxoLo8iiHTLIqDPCIMXGVNZkvo+9O/jqO/qER832kP4Je988a/wCXYG9946wm6ktq2dS9FiFN63JHoorUkbr8oRMfMjDB59lYdlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522788; c=relaxed/simple;
	bh=LXZg+BMTFSI43oPHrz+vIE37k/OEOfT93qqC6VzPnAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZkw0Us9ntgxy7QRGM7Cqsyt5BkDMcyaN/BiObWG8PbCOxadeEJWIDWfYAPrRJGWN15mhTi/dIjaWQaAJLcsz3vh2XfpD5xYv/iBVZoP+jmT53Aq/NkxQF/RyvMyaDVzP2FtIURoLfxbRdK5u2dLVoGsyACWumzD5V+wktvT2PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1QqRikJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1QqRikJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772522785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+QF1drXGLX108YE9bBV1ZopWn+aDOOwRWRJOZr8QL8=;
	b=F1QqRikJxRrOmnLq+h1LacXGBtWiYEetCKFDrmdNp7WKr78g5SjrkW8O9S9Ln0q5DkzYRW
	LaCPmVuy8UCdYatEJ+ZzYtgUQyxyA0MhwAFB7AN5VZo2VgPEXpVdKBghX9i2hstxtvBxTa
	/yuCzv/+fez1v/xRxv4D7QRfF1nSbrA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-ui5vLKCnPo2pq4n9Lc29ww-1; Tue, 03 Mar 2026 02:26:24 -0500
X-MC-Unique: ui5vLKCnPo2pq4n9Lc29ww-1
X-Mimecast-MFC-AGG-ID: ui5vLKCnPo2pq4n9Lc29ww_1772522783
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3598c05c806so1876210a91.0
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 23:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772522783; x=1773127583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x+QF1drXGLX108YE9bBV1ZopWn+aDOOwRWRJOZr8QL8=;
        b=AdseheG7320HN+qvqO4n4WtkvHLvP5GGvN4rfzHY2LAJAY10K0ApTykLLwRbjwaiDf
         Dv3kFWThM+xKbdb6lCwBYM1bWnJneFYS8w8u+hahnA3ISHfvud+fJVf3ZDBipUuEbh5m
         HvcJWjS090VJbHdKB8vlIheLTfKSLJqTEkzWR+R9ztZt16GWcd/phOQeJ2tTtF8SauN1
         qs648TvGy5CJSSffRhElSyUp6Ff7PArpdrMde3+8xS6ngSHdvY6h35Iuw+3xmTtlVnvo
         IN42QLAlpxD7ZkNcVN7Vbu/euolASNeIoR8AOlXQdv6AEGfuf0lFSmRaEvIWNAJQM2PY
         fzmg==
X-Forwarded-Encrypted: i=1; AJvYcCXlDjz6qHruelUzvF+LmjBf9GIf3YBAwuCo48w+JZ7AY+FS7yvUNnmahBwDJEo1ReCfpMYAww8QxsHk3n9Cdg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUWAJ5AnzAUGCaADrggMUr42j5sGTJ9iL7wu8Sq+bH9EEkclJr
	q3UjvoEQgCBwrVD58WUXOpEVPS1pZT8C+m4SXbcsenlVo3VKkJiJY5JwpRY6sMnK0bfr+8U28aF
	N2GUehbi83KG3KuejB1twBiPaxcoNu1noPtrPM1TexntNzYAzKvkHdCMamfCGtAUMp53AvZh/a4
	SH3XRyBM2Qg7ZQ/w/V6fJL1RFonRaQIGSVm5SrioP5ulA=
X-Gm-Gg: ATEYQzwZwh4Or/VVJvpKcdBDgKObBlMI2Y0ijgyRaw/r8s2CpS/j93a2vGyxRhRXG3f
	NWWo4AFywKOgVoU76yjYIhp6ol8zDf+8cqLlQ45WT5puHK3wNhVxNfUDug/NTMX1O7qbOT7tr7S
	loX75C4MPaozTkgnEVVlkzQ9Q+0KibPbuoaMDf6nWWV3i4P3Xj49qeJhl+weGIfIivV0KwimGE4
	bjJIdqd
X-Received: by 2002:a17:90b:3951:b0:34c:a29d:992a with SMTP id 98e67ed59e1d1-35965cf6211mr13268843a91.34.1772522783150;
        Mon, 02 Mar 2026 23:26:23 -0800 (PST)
X-Received: by 2002:a17:90b:3951:b0:34c:a29d:992a with SMTP id
 98e67ed59e1d1-35965cf6211mr13268822a91.34.1772522782695; Mon, 02 Mar 2026
 23:26:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260211120158.2501592-1-eperezma@redhat.com>
In-Reply-To: <20260211120158.2501592-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Mar 2026 15:26:11 +0800
X-Gm-Features: AaiRm516eHyFHGPwWQHteb3plrqpLBYUUWWnB7ajYdNMtJR4ExbPUA4OISKgvVk
Message-ID: <CACGkMEtizCT+4WUXaROEvnWgKoFVqv9iRfLk-3HduRnsKfthqQ@mail.gmail.com>
Subject: Re: [PATCH] vduse: Add suspend
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Laurent Vivier <lvivier@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -ABahu7-WQjRgVRzXggHbDvCCfX_Pp95KKFb8SWVmx0_1772522783
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 8:02=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Implement suspend operation for vduse devices, so vhost-vdpa will offer
> that backend feature and userspace can effectively suspend the device.
>
> This is a must before get virtqueue indexes (base) for live migration,
> since the device could modify them after userland gets them.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> This series depends on
> https://lore.kernel.org/lkml/20260210082554.1582553-1-eperezma@redhat.com
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 86 +++++++++++++++++++++++++++++-
>  include/uapi/linux/vduse.h         |  4 ++
>  2 files changed, 88 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 59d9c4718d86..bdcc114e2710 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -54,7 +54,8 @@
>  #define IRQ_UNBOUND -1
>
>  /* Supported VDUSE features */
> -static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_QUEUE_READY);
> +static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_QUEUE_READY) |
> +                                      BIT_U64(VDUSE_F_SUSPEND);
>
>  /*
>   * VDUSE instance have not asked the vduse API version, so assume 0.
> @@ -85,6 +86,7 @@ struct vduse_virtqueue {
>         int irq_effective_cpu;
>         struct cpumask irq_affinity;
>         struct kobject kobj;
> +       struct vduse_dev *dev;
>  };
>
>  struct vduse_dev;
> @@ -134,6 +136,7 @@ struct vduse_dev {
>         int minor;
>         bool broken;
>         bool connected;
> +       bool suspended;
>         u64 api_version;
>         u64 device_features;
>         u64 driver_features;
> @@ -480,6 +483,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
>
>         down_write(&dev->rwsem);
>
> +       dev->suspended =3D false;
>         dev->status =3D 0;
>         dev->driver_features =3D 0;
>         dev->generation++;
> @@ -559,6 +563,10 @@ static void vduse_vdpa_kick_vq(struct vdpa_device *v=
dpa, u16 idx)
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
>         struct vduse_virtqueue *vq =3D dev->vqs[idx];
>
> +       guard(rwsem_read)(&vq->dev->rwsem);
> +       if (vq->dev->suspended)
> +               return;
> +
>         if (!eventfd_signal_allowed()) {
>                 schedule_work(&vq->kick);
>                 return;
> @@ -896,6 +904,27 @@ static int vduse_vdpa_set_map(struct vdpa_device *vd=
pa,
>         return 0;
>  }
>
> +static int vduse_vdpa_suspend(struct vdpa_device *vdpa)
> +{
> +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> +       struct vduse_dev_msg msg =3D { 0 };
> +       int ret;
> +
> +       msg.req.type =3D VDUSE_SUSPEND;
> +
> +       ret =3D vduse_dev_msg_sync(dev, &msg);
> +       if (ret =3D=3D 0) {
> +               scoped_guard(rwsem_write, &dev->rwsem)
> +                       dev->suspended =3D true;
> +
> +               cancel_work_sync(&dev->inject);
> +               for (u32 i =3D 0; i < dev->vq_num; i++)
> +                       cancel_work_sync(&dev->vqs[i]->inject);

Should we cancel those before msy sync?

> +       }
> +
> +       return ret;
> +}
> +
>  static void vduse_vdpa_free(struct vdpa_device *vdpa)
>  {
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> @@ -937,6 +966,41 @@ static const struct vdpa_config_ops vduse_vdpa_confi=
g_ops =3D {
>         .free                   =3D vduse_vdpa_free,
>  };
>
> +static const struct vdpa_config_ops vduse_vdpa_config_ops_with_suspend =
=3D {
> +       .set_vq_address         =3D vduse_vdpa_set_vq_address,
> +       .kick_vq                =3D vduse_vdpa_kick_vq,
> +       .set_vq_cb              =3D vduse_vdpa_set_vq_cb,
> +       .set_vq_num             =3D vduse_vdpa_set_vq_num,
> +       .get_vq_size            =3D vduse_vdpa_get_vq_size,
> +       .get_vq_group           =3D vduse_get_vq_group,
> +       .set_vq_ready           =3D vduse_vdpa_set_vq_ready,
> +       .get_vq_ready           =3D vduse_vdpa_get_vq_ready,
> +       .set_vq_state           =3D vduse_vdpa_set_vq_state,
> +       .get_vq_state           =3D vduse_vdpa_get_vq_state,
> +       .get_vq_align           =3D vduse_vdpa_get_vq_align,
> +       .get_device_features    =3D vduse_vdpa_get_device_features,
> +       .set_driver_features    =3D vduse_vdpa_set_driver_features,
> +       .get_driver_features    =3D vduse_vdpa_get_driver_features,
> +       .set_config_cb          =3D vduse_vdpa_set_config_cb,
> +       .get_vq_num_max         =3D vduse_vdpa_get_vq_num_max,
> +       .get_device_id          =3D vduse_vdpa_get_device_id,
> +       .get_vendor_id          =3D vduse_vdpa_get_vendor_id,
> +       .get_status             =3D vduse_vdpa_get_status,
> +       .set_status             =3D vduse_vdpa_set_status,
> +       .get_config_size        =3D vduse_vdpa_get_config_size,
> +       .get_config             =3D vduse_vdpa_get_config,
> +       .set_config             =3D vduse_vdpa_set_config,
> +       .get_generation         =3D vduse_vdpa_get_generation,
> +       .set_vq_affinity        =3D vduse_vdpa_set_vq_affinity,
> +       .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> +       .reset                  =3D vduse_vdpa_reset,
> +       .set_map                =3D vduse_vdpa_set_map,
> +       .set_group_asid         =3D vduse_set_group_asid,
> +       .get_vq_map             =3D vduse_get_vq_map,
> +       .suspend                =3D vduse_vdpa_suspend,

We can have a

if (suspend_is_supported)
        ...

to avoid having a new set of config ops?

> +       .free                   =3D vduse_vdpa_free,
> +};
> +
>  static void vduse_dev_sync_single_for_device(union virtio_map token,
>                                              dma_addr_t dma_addr, size_t =
size,
>                                              enum dma_data_direction dir)
> @@ -1148,6 +1212,10 @@ static void vduse_dev_irq_inject(struct work_struc=
t *work)
>  {
>         struct vduse_dev *dev =3D container_of(work, struct vduse_dev, in=
ject);
>
> +       guard(rwsem_read)(&dev->rwsem);
> +       if (dev->suspended)
> +               return;

Device can still modify memory, so I wonder how much this can help.

> +
>         spin_lock_bh(&dev->irq_lock);
>         if (dev->config_cb.callback)
>                 dev->config_cb.callback(dev->config_cb.private);
> @@ -1159,6 +1227,10 @@ static void vduse_vq_irq_inject(struct work_struct=
 *work)
>         struct vduse_virtqueue *vq =3D container_of(work,
>                                         struct vduse_virtqueue, inject);
>
> +       guard(rwsem_read)(&vq->dev->rwsem);
> +       if (vq->dev->suspended)
> +               return;
> +
>         spin_lock_bh(&vq->irq_lock);
>         if (vq->ready && vq->cb.callback)
>                 vq->cb.callback(vq->cb.private);
> @@ -1189,6 +1261,9 @@ static int vduse_dev_queue_irq_work(struct vduse_de=
v *dev,
>         int ret =3D -EINVAL;
>
>         down_read(&dev->rwsem);
> +       if (dev->suspended)
> +               return ret;
> +
>         if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
>                 goto unlock;
>
> @@ -1839,6 +1914,7 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev=
, u32 vq_align, u32 vq_num)
>                 }
>
>                 dev->vqs[i]->index =3D i;
> +               dev->vqs[i]->dev =3D dev;
>                 dev->vqs[i]->irq_effective_cpu =3D IRQ_UNBOUND;
>                 INIT_WORK(&dev->vqs[i]->inject, vduse_vq_irq_inject);
>                 INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
> @@ -2311,12 +2387,18 @@ static struct vduse_mgmt_dev *vduse_mgmt;
>  static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
>  {
>         struct vduse_vdpa *vdev;
> +       const struct vdpa_config_ops *ops;
>
>         if (dev->vdev)
>                 return -EEXIST;
>
> +       if (dev->vduse_features & BIT_U64(VDUSE_F_SUSPEND))
> +               ops =3D &vduse_vdpa_config_ops_with_suspend;
> +       else
> +               ops =3D &vduse_vdpa_config_ops;
> +
>         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> -                                &vduse_vdpa_config_ops, &vduse_map_ops,
> +                                ops, &vduse_map_ops,
>                                  dev->ngroups, dev->nas, name, true);
>         if (IS_ERR(vdev))
>                 return PTR_ERR(vdev);
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index d39734cef6d3..95b93bc6bac5 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -21,6 +21,9 @@
>  /* The VDUSE instance expects a request for vq ready */
>  #define VDUSE_F_QUEUE_READY    0
>
> +/* The VDUSE instance expects a request for suspend */
> +#define VDUSE_F_SUSPEND                1
> +
>  /*
>   * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION=
).
>   * This is used for future extension.
> @@ -338,6 +341,7 @@ enum vduse_req_type {
>         VDUSE_UPDATE_IOTLB,
>         VDUSE_SET_VQ_GROUP_ASID,
>         VDUSE_SET_VQ_READY,
> +       VDUSE_SUSPEND,
>  };
>
>  /**
> --
> 2.53.0
>

Thanks

