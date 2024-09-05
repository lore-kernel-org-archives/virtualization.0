Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B43C12FF71
	for <virtualization@lists.linux.dev>; Thu,  5 Sep 2024 02:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725503172; cv=none; b=ss/IhwyiCc2dvSlXWKRVRJ/Catt+hosdQEZt4riiMCiDvZXtSyFmF6nZVQ0tPeg8tKJHuU+Yov9Zx1pwnEjM3R8eH1sWRlErwG13A/5E/1fS5GOfjtbEJZUa3OX4fmRAFDzxahIh1VaeSGwE07/XipB0XS9xgD0WCA83O7LyItM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725503172; c=relaxed/simple;
	bh=6HsTloLJdBFoEXKfZ8aGSqm//A/eqdNI9yed2rDL5is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3Yfc/5u07cmoD2KRYcAVtwvrEUF6PBogRvUOq+R3fw5NHn/gg8QmrgG8ttwOH0KIWR3dwJKD8UT0JwxROT6ihiHA9hUr1tVGt9bfBVo7cZO7lDHOe+llawFFYCUYnCkPArHUVllXNLax/lC5qUrXq3PkY/CdQLBXiKE2RQ6M8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1X+C80K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1X+C80K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725503169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkGEpSYn9X1jTRdg8LwSxGH+JtLTyupWKLCpL49TUjY=;
	b=Y1X+C80K8BF93lYwrTFsrey76WzvKNHO6fh9xdalBnRd+Lb0U8mdcHHPu34D9WHOQe6AlH
	tXcuRCtMs8LpFaqrzQ6aGNx1QNRvt8OUDFkqOyTgUuQxCk9wnr6Wv6bFjcRBYFwHRmu+EE
	QNtmCnbOGOFlmb+dm4hwOePPTywT7n4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-wQdXoqcFNH-U4WT_jBsQ3A-1; Wed, 04 Sep 2024 22:26:08 -0400
X-MC-Unique: wQdXoqcFNH-U4WT_jBsQ3A-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7141ab07fddso279319b3a.0
        for <virtualization@lists.linux.dev>; Wed, 04 Sep 2024 19:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725503167; x=1726107967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkGEpSYn9X1jTRdg8LwSxGH+JtLTyupWKLCpL49TUjY=;
        b=F6pwMgqk8TfOTYZ1mmjyhN41DvXRBWtp0ZlL4wv3KvCatnPuyi7cnpq+/MRwTBwYJW
         yR6wN1OkmXXf6YcVfvOX5AHSp2tsy3AQ/7h5I6ELLL6HYKfdk++3HLfkexmA/SiKoMtV
         iGHA3vzFa2mhfGUU3KqdXCrtd/DkTgtkFj+GGJL18yEoVWuBaSmY6nNxZvnaOzFU+lqi
         ihGgEQtRg7yTzqfghEaSG7zrTVD+e10bdlzOT0TlLyvOKa0LEMiM/bCaTY1F/cqukl9N
         EI9i7QQoQ0hlG8KbjgNpebfZwgxFG26Jq2xlEbvSr0qkDYEDa35O7NXajJmCJP1JW/Yk
         2iJg==
X-Forwarded-Encrypted: i=1; AJvYcCV+YtPwkJpMOEwf5i9mLVDKgwYyzuUZNDHHxc/FlGdEExxX5piHZovSe4kxFgZ0RAWs1oZQWywFEgtqlqiJSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5P9rEQyIYBIkTcQFytu3DrBpRM5BTM+z9q1ScIUg6bpdCUa9V
	7XBkMbjlkhKHNIV0RkzsNWJE7JZKo1SEgPfo2S5Q3dEwcWLny8f+tiI6PPCxPNircp1oKAJcHi8
	psjZif21UaohmeD/rkg5Kn3keuBz4vfvsHM19ODZ2VvL0gRRoY9k2x2mTtwsJIDeQkZ0anldjY0
	pna6VEpbuL7RxLZWVGo3d3VxSZXcHr7tdaJQbiz/Q=
X-Received: by 2002:a05:6a20:2d26:b0:1c8:a5ba:d2ba with SMTP id adf61e73a8af0-1cce100d806mr24332837637.22.1725503167077;
        Wed, 04 Sep 2024 19:26:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH36RHIImIJkuTpQJV2BJ97x7hbS5vQ6ed+PTcKjhwO+EtAGg9dPYzIjddm2wctNJ1xh9Z8wO1XV2X3Dgp26pk=
X-Received: by 2002:a05:6a20:2d26:b0:1c8:a5ba:d2ba with SMTP id
 adf61e73a8af0-1cce100d806mr24332809637.22.1725503166353; Wed, 04 Sep 2024
 19:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com> <20240904151115.205622-3-carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20240904151115.205622-3-carlos.bilbao.osdev@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Sep 2024 10:25:55 +0800
Message-ID: <CACGkMEvoyi1Bhs9q5ZmO-xvcYeU+ZVJ6EcM_sUtJW-F_349Hqw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec compliance
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, shannon.nelson@amd.com, 
	sashal@kernel.org, alvaro.karsz@solid-run.com, christophe.jaillet@wanadoo.fr, 
	steven.sistare@oracle.com, bilbao@vt.edu, xuanzhuo@linux.alibaba.com, 
	johnah.palmer@oracle.com, eperezma@redhat.com, cratiu@nvidia.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Carlos Bilbao <cbilbao@digitalocean.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 11:18=E2=80=AFPM Carlos Bilbao
<carlos.bilbao.osdev@gmail.com> wrote:
>
> From: Carlos Bilbao <cbilbao@digitalocean.com>
>
> Remove invalid ioctl VHOST_VDPA_SET_CONFIG and all its implementations wi=
th
> vdpa_config_ops->set_config(). This is needed per virtio spec requirement=
s:
> virtio-spec v1.3 Sec 5.1.4 states that "All of the device configuration
> fields are read-only for the driver.".

Just to make sure we are on the same page.

That part is specific to the virtio-net device. Other types of device
may have a field that could be written. For example the writeback
field of the virtio-blk device when WCE is enabled.

Even for the networking device, it doesn't mean we can't have a
writable field in the future.

So I tend to leave the code as-is.

Thanks

> This excludes legacy Alibaba's ENI
> so make it use vda_config_ops->set_config_legacy() to avoid future
> confusion.
>
> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> ---
>  drivers/vdpa/alibaba/eni_vdpa.c    |  2 +-
>  drivers/vdpa/ifcvf/ifcvf_main.c    | 10 ----------
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  |  7 -------
>  drivers/vdpa/pds/vdpa_dev.c        | 16 ----------------
>  drivers/vdpa/solidrun/snet_main.c  | 18 ------------------
>  drivers/vdpa/vdpa.c                | 16 ----------------
>  drivers/vdpa/vdpa_sim/vdpa_sim.c   | 16 ----------------
>  drivers/vdpa/vdpa_sim/vdpa_sim.h   |  1 -
>  drivers/vdpa/vdpa_user/vduse_dev.c |  7 -------
>  drivers/vdpa/virtio_pci/vp_vdpa.c  | 14 --------------
>  drivers/vhost/vdpa.c               | 26 --------------------------
>  drivers/virtio/virtio_vdpa.c       |  9 ---------
>  include/linux/vdpa.h               |  7 ++++---
>  include/uapi/linux/vhost.h         |  8 ++++----
>  14 files changed, 9 insertions(+), 148 deletions(-)
>
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_v=
dpa.c
> index cce3d1837104..64b0c0be89ae 100644
> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -429,7 +429,7 @@ static const struct vdpa_config_ops eni_vdpa_ops =3D =
{
>         .get_vq_align   =3D eni_vdpa_get_vq_align,
>         .get_config_size =3D eni_vdpa_get_config_size,
>         .get_config     =3D eni_vdpa_get_config,
> -       .set_config     =3D eni_vdpa_set_config,
> +       .set_config_legacy =3D eni_vdpa_set_config,
>         .set_config_cb  =3D eni_vdpa_set_config_cb,
>         .get_vq_irq     =3D eni_vdpa_get_vq_irq,
>  };
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_m=
ain.c
> index e98fa8100f3c..7cbac787ad5f 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -568,15 +568,6 @@ static void ifcvf_vdpa_get_config(struct vdpa_device=
 *vdpa_dev,
>         ifcvf_read_dev_config(vf, offset, buf, len);
>  }
>
> -static void ifcvf_vdpa_set_config(struct vdpa_device *vdpa_dev,
> -                                 unsigned int offset, const void *buf,
> -                                 unsigned int len)
> -{
> -       struct ifcvf_hw *vf =3D vdpa_to_vf(vdpa_dev);
> -
> -       ifcvf_write_dev_config(vf, offset, buf, len);
> -}
> -
>  static void ifcvf_vdpa_set_config_cb(struct vdpa_device *vdpa_dev,
>                                      struct vdpa_callback *cb)
>  {
> @@ -640,7 +631,6 @@ static const struct vdpa_config_ops ifc_vdpa_ops =3D =
{
>         .get_vq_group   =3D ifcvf_vdpa_get_vq_group,
>         .get_config_size        =3D ifcvf_vdpa_get_config_size,
>         .get_config     =3D ifcvf_vdpa_get_config,
> -       .set_config     =3D ifcvf_vdpa_set_config,
>         .set_config_cb  =3D ifcvf_vdpa_set_config_cb,
>         .get_vq_notification =3D ifcvf_get_vq_notification,
>  };
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 41ca268d43ff..35ed46c65b4d 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2918,12 +2918,6 @@ static void mlx5_vdpa_get_config(struct vdpa_devic=
e *vdev, unsigned int offset,
>                 memcpy(buf, (u8 *)&ndev->config + offset, len);
>  }
>
> -static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int =
offset, const void *buf,
> -                                unsigned int len)
> -{
> -       /* not supported */
> -}
> -
>  static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> @@ -3218,7 +3212,6 @@ static const struct vdpa_config_ops mlx5_vdpa_ops =
=3D {
>         .reset =3D mlx5_vdpa_reset,
>         .get_config_size =3D mlx5_vdpa_get_config_size,
>         .get_config =3D mlx5_vdpa_get_config,
> -       .set_config =3D mlx5_vdpa_set_config,
>         .get_generation =3D mlx5_vdpa_get_generation,
>         .set_map =3D mlx5_vdpa_set_map,
>         .set_group_asid =3D mlx5_set_group_asid,
> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
> index 25c0fe5ec3d5..553dcd2aa065 100644
> --- a/drivers/vdpa/pds/vdpa_dev.c
> +++ b/drivers/vdpa/pds/vdpa_dev.c
> @@ -553,21 +553,6 @@ static void pds_vdpa_get_config(struct vdpa_device *=
vdpa_dev,
>         memcpy_fromio(buf, device + offset, len);
>  }
>
> -static void pds_vdpa_set_config(struct vdpa_device *vdpa_dev,
> -                               unsigned int offset, const void *buf,
> -                               unsigned int len)
> -{
> -       struct pds_vdpa_device *pdsv =3D vdpa_to_pdsv(vdpa_dev);
> -       void __iomem *device;
> -
> -       if (offset + len > sizeof(struct virtio_net_config)) {
> -               WARN(true, "%s: bad read, offset %d len %d\n", __func__, =
offset, len);
> -               return;
> -       }
> -
> -       device =3D pdsv->vdpa_aux->vd_mdev.device;
> -       memcpy_toio(device + offset, buf, len);
> -}
>
>  static const struct vdpa_config_ops pds_vdpa_ops =3D {
>         .set_vq_address         =3D pds_vdpa_set_vq_address,
> @@ -595,7 +580,6 @@ static const struct vdpa_config_ops pds_vdpa_ops =3D =
{
>         .reset                  =3D pds_vdpa_reset,
>         .get_config_size        =3D pds_vdpa_get_config_size,
>         .get_config             =3D pds_vdpa_get_config,
> -       .set_config             =3D pds_vdpa_set_config,
>  };
>  static struct virtio_device_id pds_vdpa_id_table[] =3D {
>         {VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID},
> diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/sn=
et_main.c
> index 99428a04068d..141740269b6c 100644
> --- a/drivers/vdpa/solidrun/snet_main.c
> +++ b/drivers/vdpa/solidrun/snet_main.c
> @@ -478,23 +478,6 @@ static void snet_get_config(struct vdpa_device *vdev=
, unsigned int offset,
>                 *buf_ptr++ =3D ioread8(cfg_ptr + i);
>  }
>
> -static void snet_set_config(struct vdpa_device *vdev, unsigned int offse=
t,
> -                           const void *buf, unsigned int len)
> -{
> -       struct snet *snet =3D vdpa_to_snet(vdev);
> -       void __iomem *cfg_ptr =3D snet->cfg->virtio_cfg + offset;
> -       const u8 *buf_ptr =3D buf;
> -       u32 i;
> -
> -       /* check for offset error */
> -       if (offset + len > snet->cfg->cfg_size)
> -               return;
> -
> -       /* Write into PCI BAR */
> -       for (i =3D 0; i < len; i++)
> -               iowrite8(*buf_ptr++, cfg_ptr + i);
> -}
> -
>  static int snet_suspend(struct vdpa_device *vdev)
>  {
>         struct snet *snet =3D vdpa_to_snet(vdev);
> @@ -548,7 +531,6 @@ static const struct vdpa_config_ops snet_config_ops =
=3D {
>         .get_status             =3D snet_get_status,
>         .set_status             =3D snet_set_status,
>         .get_config             =3D snet_get_config,
> -       .set_config             =3D snet_set_config,
>         .suspend                =3D snet_suspend,
>         .resume                 =3D snet_resume,
>  };
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index a7612e0783b3..a9eac31f3757 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -401,22 +401,6 @@ void vdpa_get_config(struct vdpa_device *vdev, unsig=
ned int offset,
>  }
>  EXPORT_SYMBOL_GPL(vdpa_get_config);
>
> -/**
> - * vdpa_set_config - Set one or more device configuration fields.
> - * @vdev: vdpa device to operate on
> - * @offset: starting byte offset of the field
> - * @buf: buffer pointer to read from
> - * @length: length of the configuration fields in bytes
> - */
> -void vdpa_set_config(struct vdpa_device *vdev, unsigned int offset,
> -                    const void *buf, unsigned int length)
> -{
> -       down_write(&vdev->cf_lock);
> -       vdev->config->set_config(vdev, offset, buf, length);
> -       up_write(&vdev->cf_lock);
> -}
> -EXPORT_SYMBOL_GPL(vdpa_set_config);
> -
>  static bool mgmtdev_handle_match(const struct vdpa_mgmt_dev *mdev,
>                                  const char *busname, const char *devname=
)
>  {
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index 421ab01ef06b..c2e14bcc01f6 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -546,20 +546,6 @@ static void vdpasim_get_config(struct vdpa_device *v=
dpa, unsigned int offset,
>         memcpy(buf, vdpasim->config + offset, len);
>  }
>
> -static void vdpasim_set_config(struct vdpa_device *vdpa, unsigned int of=
fset,
> -                            const void *buf, unsigned int len)
> -{
> -       struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> -
> -       if (offset + len > vdpasim->dev_attr.config_size)
> -               return;
> -
> -       memcpy(vdpasim->config + offset, buf, len);
> -
> -       if (vdpasim->dev_attr.set_config)
> -               vdpasim->dev_attr.set_config(vdpasim, vdpasim->config);
> -}
> -
>  static u32 vdpasim_get_generation(struct vdpa_device *vdpa)
>  {
>         struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> @@ -754,7 +740,6 @@ static const struct vdpa_config_ops vdpasim_config_op=
s =3D {
>         .resume                 =3D vdpasim_resume,
>         .get_config_size        =3D vdpasim_get_config_size,
>         .get_config             =3D vdpasim_get_config,
> -       .set_config             =3D vdpasim_set_config,
>         .get_generation         =3D vdpasim_get_generation,
>         .get_iova_range         =3D vdpasim_get_iova_range,
>         .set_group_asid         =3D vdpasim_set_group_asid,
> @@ -792,7 +777,6 @@ static const struct vdpa_config_ops vdpasim_batch_con=
fig_ops =3D {
>         .resume                 =3D vdpasim_resume,
>         .get_config_size        =3D vdpasim_get_config_size,
>         .get_config             =3D vdpasim_get_config,
> -       .set_config             =3D vdpasim_set_config,
>         .get_generation         =3D vdpasim_get_generation,
>         .get_iova_range         =3D vdpasim_get_iova_range,
>         .set_group_asid         =3D vdpasim_set_group_asid,
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdp=
a_sim.h
> index bb137e479763..b48bf954a3bb 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -46,7 +46,6 @@ struct vdpasim_dev_attr {
>
>         void (*work_fn)(struct vdpasim *vdpasim);
>         void (*get_config)(struct vdpasim *vdpasim, void *config);
> -       void (*set_config)(struct vdpasim *vdpasim, const void *config);
>         int (*get_stats)(struct vdpasim *vdpasim, u16 idx,
>                          struct sk_buff *msg,
>                          struct netlink_ext_ack *extack);
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index df7869537ef1..4fe69cb5b156 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -698,12 +698,6 @@ static void vduse_vdpa_get_config(struct vdpa_device=
 *vdpa, unsigned int offset,
>         memcpy(buf, dev->config + offset, len);
>  }
>
> -static void vduse_vdpa_set_config(struct vdpa_device *vdpa, unsigned int=
 offset,
> -                       const void *buf, unsigned int len)
> -{
> -       /* Now we only support read-only configuration space */
> -}
> -
>  static int vduse_vdpa_reset(struct vdpa_device *vdpa)
>  {
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> @@ -790,7 +784,6 @@ static const struct vdpa_config_ops vduse_vdpa_config=
_ops =3D {
>         .set_status             =3D vduse_vdpa_set_status,
>         .get_config_size        =3D vduse_vdpa_get_config_size,
>         .get_config             =3D vduse_vdpa_get_config,
> -       .set_config             =3D vduse_vdpa_set_config,
>         .get_generation         =3D vduse_vdpa_get_generation,
>         .set_vq_affinity        =3D vduse_vdpa_set_vq_affinity,
>         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/=
vp_vdpa.c
> index 281287fae89f..5e8ff91475e3 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -400,19 +400,6 @@ static void vp_vdpa_get_config(struct vdpa_device *v=
dpa,
>         } while (old !=3D new);
>  }
>
> -static void vp_vdpa_set_config(struct vdpa_device *vdpa,
> -                              unsigned int offset, const void *buf,
> -                              unsigned int len)
> -{
> -       struct vp_vdpa *vp_vdpa =3D vdpa_to_vp(vdpa);
> -       struct virtio_pci_modern_device *mdev =3D vp_vdpa_to_mdev(vp_vdpa=
);
> -       const u8 *p =3D buf;
> -       int i;
> -
> -       for (i =3D 0; i < len; i++)
> -               vp_iowrite8(*p++, mdev->device + offset + i);
> -}
> -
>  static void vp_vdpa_set_config_cb(struct vdpa_device *vdpa,
>                                   struct vdpa_callback *cb)
>  {
> @@ -457,7 +444,6 @@ static const struct vdpa_config_ops vp_vdpa_ops =3D {
>         .get_vq_align   =3D vp_vdpa_get_vq_align,
>         .get_config_size =3D vp_vdpa_get_config_size,
>         .get_config     =3D vp_vdpa_get_config,
> -       .set_config     =3D vp_vdpa_set_config,
>         .set_config_cb  =3D vp_vdpa_set_config_cb,
>         .get_vq_irq     =3D vp_vdpa_get_vq_irq,
>  };
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index fb590e346e43..c6fcd54f59be 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -350,29 +350,6 @@ static long vhost_vdpa_get_config(struct vhost_vdpa =
*v,
>         return 0;
>  }
>
> -static long vhost_vdpa_set_config(struct vhost_vdpa *v,
> -                                 struct vhost_vdpa_config __user *c)
> -{
> -       struct vdpa_device *vdpa =3D v->vdpa;
> -       struct vhost_vdpa_config config;
> -       unsigned long size =3D offsetof(struct vhost_vdpa_config, buf);
> -       u8 *buf;
> -
> -       if (copy_from_user(&config, c, size))
> -               return -EFAULT;
> -       if (vhost_vdpa_config_validate(v, &config))
> -               return -EINVAL;
> -
> -       buf =3D vmemdup_user(c->buf, config.len);
> -       if (IS_ERR(buf))
> -               return PTR_ERR(buf);
> -
> -       vdpa_set_config(vdpa, config.off, buf, config.len);
> -
> -       kvfree(buf);
> -       return 0;
> -}
> -
>  static bool vhost_vdpa_can_suspend(const struct vhost_vdpa *v)
>  {
>         struct vdpa_device *vdpa =3D v->vdpa;
> @@ -719,9 +696,6 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fi=
lep,
>         case VHOST_VDPA_GET_CONFIG:
>                 r =3D vhost_vdpa_get_config(v, argp);
>                 break;
> -       case VHOST_VDPA_SET_CONFIG:
> -               r =3D vhost_vdpa_set_config(v, argp);
> -               break;
>         case VHOST_GET_FEATURES:
>                 r =3D vhost_vdpa_get_features(v, argp);
>                 break;
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 06ce6d8c2e00..481ded50c916 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -62,14 +62,6 @@ static void virtio_vdpa_get(struct virtio_device *vdev=
, unsigned int offset,
>         vdpa_get_config(vdpa, offset, buf, len);
>  }
>
> -static void virtio_vdpa_set(struct virtio_device *vdev, unsigned int off=
set,
> -                           const void *buf, unsigned int len)
> -{
> -       struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);
> -
> -       vdpa_set_config(vdpa, offset, buf, len);
> -}
> -
>  static u32 virtio_vdpa_generation(struct virtio_device *vdev)
>  {
>         struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);
> @@ -462,7 +454,6 @@ virtio_vdpa_get_vq_affinity(struct virtio_device *vde=
v, int index)
>
>  static const struct virtio_config_ops virtio_vdpa_config_ops =3D {
>         .get            =3D virtio_vdpa_get,
> -       .set            =3D virtio_vdpa_set,
>         .generation     =3D virtio_vdpa_generation,
>         .get_status     =3D virtio_vdpa_get_status,
>         .set_status     =3D virtio_vdpa_set_status,
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 0e652026b776..9346fa9e3d97 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -259,7 +259,8 @@ struct vdpa_map_file {
>   *                             @buf: buffer used to read to
>   *                             @len: the length to read from
>   *                             configuration space
> - * @set_config:                        Write to device specific configur=
ation space
> + * @set_config_legacy:         Write to device specific configuration sp=
ace
> + *                             Legacy functionality for virtio-spec < v1=
.3
>   *                             @vdev: vdpa device
>   *                             @offset: offset from the beginning of
>   *                             configuration space
> @@ -378,8 +379,8 @@ struct vdpa_config_ops {
>         size_t (*get_config_size)(struct vdpa_device *vdev);
>         void (*get_config)(struct vdpa_device *vdev, unsigned int offset,
>                            void *buf, unsigned int len);
> -       void (*set_config)(struct vdpa_device *vdev, unsigned int offset,
> -                          const void *buf, unsigned int len);
> +       void (*set_config_legacy)(struct vdpa_device *vdev,
> +                       unsigned int offset, const void *buf, unsigned in=
t len);
>         u32 (*get_generation)(struct vdpa_device *vdev);
>         struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev=
);
>         int (*set_vq_affinity)(struct vdpa_device *vdev, u16 idx,
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index f5c48b61ab62..b7977f9ae596 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -157,13 +157,13 @@
>   */
>  #define VHOST_VDPA_GET_STATUS          _IOR(VHOST_VIRTIO, 0x71, __u8)
>  #define VHOST_VDPA_SET_STATUS          _IOW(VHOST_VIRTIO, 0x72, __u8)
> -/* Get and set the device config. The device config follows the same
> - * definition of the device config defined in virtio-spec.
> +/* Get the device config. The device config follows the same
> + * definition of the device config defined in virtio-spec. According to
> + * virtio-spec v1.3, all device configuration fields are read-only for t=
he
> + * driver, and thus we do not have VHOST_VDPA_SET_CONFIG.
>   */
>  #define VHOST_VDPA_GET_CONFIG          _IOR(VHOST_VIRTIO, 0x73, \
>                                              struct vhost_vdpa_config)
> -#define VHOST_VDPA_SET_CONFIG          _IOW(VHOST_VIRTIO, 0x74, \
> -                                            struct vhost_vdpa_config)
>  /* Enable/disable the ring. */
>  #define VHOST_VDPA_SET_VRING_ENABLE    _IOW(VHOST_VIRTIO, 0x75, \
>                                              struct vhost_vring_state)
> --
> 2.34.1
>

