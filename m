Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D6223D0
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 03:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="beNu3hoc"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6538613F0
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 03:28:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6538613F0
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=beNu3hoc
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mc3llF0JjjlT
	for <virtualization@lists.linux-foundation.org>;
	Wed, 10 Jan 2024 03:28:02 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 25DB4613C0
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 03:28:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 25DB4613C0
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-28db7135547so180014a91.3
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Jan 2024 19:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704857281; x=1705462081; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmHQeP0vkxtfvKhUYEtyUhBg1iWakI0fi5SAJQmRJk4=;
        b=beNu3hoc/S9ZbEipp/hlyVLk/UPzKxC5ayGQYJN7gdwZl6e0YabtNCqgO5bxLPtQ8h
         nZgeZKUVxPd0Hl5zSYtvnmFva2z1QPpZPEVKWNPFmKOTsXXbgkpgrk3NEcZT05A1lLXO
         b+XlR0+HqTwtZCVPSxh8zPJ/ZXQk77l7amhTdGwClusFNdZPDF74Cmw92gQ5rloIOoPK
         QCONUxCNjX9PX+9PI8orrQn9aq9T1iz0W7rKecx71c0Lc2efCaYajx7uikuZfB6WMfE5
         PtgI0qKpS4S0LhpPdHTucxjfqLgsd6Csz86060EPFZ1Eut9NTrwMByI0noIpuYsN4OtP
         gCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704857281; x=1705462081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmHQeP0vkxtfvKhUYEtyUhBg1iWakI0fi5SAJQmRJk4=;
        b=tBfzkUlhvPiEz120B92GeG1032yYUs++K8xuFDSw4VqKLFImG1A5Glhm6KwI1D5yar
         og3D8t9e8X4rG/aHXBY/vfni0OQ+LVTCxALndUeM8EAsVDWVWolpXSrotDTM0e7+xblW
         9xaEmHVyVhPxMc08p3y/i9e/5btnL5bF4RrJNoyBj9Wivbm2cxXBWwBSxJ+5OTCb+WfT
         fwXHoSz3/s+IZvm1dNxsVP1zx82OtkwRwxvQuYRBmZbkb5L8mpDZFVakv1Ttb64qOpNZ
         17AzTWl0Q1sFGImISS6f0Zqw1MjwiJs4Se8H4m6L8w59vRKQNnU6fPGXILqh+iN95GTd
         kEow==
X-Gm-Message-State: AOJu0YxxSPC8akxWLnnhWET2Zs8JRJ4egGCSK+Ncd594UPYpHj6OI3dY
	0EGSaask2h+Sn3PPXNLgOJA2ps9i2MDIHgHSNkDOx7ohbhG2
X-Google-Smtp-Source: AGHT+IF27DiaczlYFILU/RHYpoznkULFIUjMXHiMAHYqtzlVUZr2n4os6ENUCEt3jfhAxw20K/LutHE5YEYDJgy4qfQ=
X-Received: by 2002:a17:90b:117:b0:28c:7ca2:ee49 with SMTP id
 p23-20020a17090b011700b0028c7ca2ee49mr167498pjz.54.1704857281474; Tue, 09 Jan
 2024 19:28:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240109111025.1320976-1-maxime.coquelin@redhat.com> <20240109111025.1320976-4-maxime.coquelin@redhat.com>
In-Reply-To: <20240109111025.1320976-4-maxime.coquelin@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 10 Jan 2024 11:27:50 +0800
Message-ID: <CACycT3sLjx1b9BjijP0ofM6OZkgRHk92VunGQcAweguBPzN1Dg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] vduse: enable Virtio-net device type
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization <virtualization@lists.linux-foundation.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, David Marchand <david.marchand@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 7:10=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch adds Virtio-net device type to the supported
> devices types.
>
> Initialization fails if the device does not support
> VIRTIO_F_VERSION_1 feature, in order to guarantee the
> configuration space is read-only. It also fails with
> -EPERM if the CAP_NET_ADMIN is missing.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 00f3f562ab5d..8924bbc55635 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -143,6 +143,7 @@ static struct workqueue_struct *vduse_irq_bound_wq;
>
>  static u32 allowed_device_id[] =3D {
>         VIRTIO_ID_BLOCK,
> +       VIRTIO_ID_NET,
>  };
>
>  static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
> @@ -1686,6 +1687,10 @@ static bool features_is_valid(struct vduse_dev_con=
fig *config)
>                         (config->features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)=
))
>                 return false;
>
> +       if ((config->device_id =3D=3D VIRTIO_ID_NET) &&
> +                       !(config->features & BIT_ULL(VIRTIO_F_VERSION_1))=
)
> +               return false;
> +
>         return true;
>  }
>
> @@ -1793,6 +1798,10 @@ static int vduse_create_dev(struct vduse_dev_confi=
g *config,
>         int ret;
>         struct vduse_dev *dev;
>
> +       ret =3D -EPERM;
> +       if ((config->device_id =3D=3D VIRTIO_ID_NET) && !capable(CAP_NET_=
ADMIN))
> +               goto err;
> +
>         ret =3D -EEXIST;
>         if (vduse_find_dev(config->name))
>                 goto err;
> @@ -2036,6 +2045,7 @@ static const struct vdpa_mgmtdev_ops vdpa_dev_mgmtd=
ev_ops =3D {
>
>  static struct virtio_device_id id_table[] =3D {
>         { VIRTIO_ID_BLOCK, VIRTIO_DEV_ANY_ID },
> +       { VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
>         { 0 },
>  };
>
> --
> 2.43.0
>
