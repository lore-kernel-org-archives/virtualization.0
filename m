Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E755D35F8D2
	for <virtualization@lists.linux.dev>; Thu, 21 May 2026 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352051; cv=none; b=CexE1kxCKyx+7OJyWjKj9F/Viop62gKY1Jrp+C5+O678zMJiLT0SVUC0R9tsLyL2ADt8B0JzMv1X2pSOSFYnca18oJ7Lj8KUgOx7FxUvc/SOibpttuSfEU9Di0buYZnZ0BiekZLewF5/OwSCnd72Kpe4ZLexsgTypvYzaiDD228=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352051; c=relaxed/simple;
	bh=Mea46XcA70zxzmyZqyD+qyEd3ZA9s42FFfqINPOE7cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIX8eArpu1VB6LOmx6tXm6WpsR8h91lhn4u4QU/ucD0+A1F12DGgP/w1JOefxMqr3lNSI8vNhAKStXPauOIdYynjlDt5Ggbo+cSMdpiDC6YjxLkHCPcX/BOQjWMaTsazS+6SAQ4wvM4fR0CwGq34FhCQqy1zaQxOlMfQ/RUyFs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8VZUagU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8VZUagU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779352048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rB3LIF/atoVQxpAbXGNRQNLpos0KUx8F+xO8WV7sZgM=;
	b=U8VZUagUhR3xhguPgv+jzwkwgNboMvr8k1lCViWaoXh+BTOH8D0WDglE6S2miRz9tUVcif
	F6PeZY8XWmBJLoRXo9n2i2IOPLhCfEUB3LtpUZ8KK8w3giZ3PnSS9ratQrMj1GzCGDxsHa
	nJJH/ILS5maOj11iX90whB9hcEv3s/M=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623--d9wSp1pNwmJhuoua-wR6A-1; Thu, 21 May 2026 04:27:26 -0400
X-MC-Unique: -d9wSp1pNwmJhuoua-wR6A-1
X-Mimecast-MFC-AGG-ID: -d9wSp1pNwmJhuoua-wR6A_1779352046
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-651bd2131f0so2082262d50.3
        for <virtualization@lists.linux.dev>; Thu, 21 May 2026 01:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352046; x=1779956846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rB3LIF/atoVQxpAbXGNRQNLpos0KUx8F+xO8WV7sZgM=;
        b=UI3AhvW9Z8EOHrb5N25TRtSlYtXSNGpky6lV0AyUFjXu6sVXfglQmpZKRvSEkhTK7o
         jRjZ4Zv1VVm2REdens3UzYeoBMVioC4OB15eKLvqmnOCjDnLuMVfIaH1we0TMKeoAPBF
         K7gJB/roTa5TJqyMi0B1vqPYrxilZZcBWwpctzbYsMuL6NR2KDgFHA15FUvkgUevN5hZ
         hvNN7hxm2Z/hR/shfa1rqRdO1uiBhYFyzVBTJmevtS4eTtAGeNlUPEZ842B3G5NfKIZO
         V0QQLypM4Hsvp8Z06V4uISBu2pZ1znDcrnAEteKTMM4Oehm5H4mrUVwxsIyvRofDCg15
         tkeg==
X-Gm-Message-State: AOJu0YzKxp6gDnn6bVrSwarDZc9mX26FI3IWt8+4aDBLR9APzN6CiMjQ
	0u3GXCvs4JbxIn+Mylgjj99Lxjo0CSMEI/Ox30aclpdRwb2FbaZoMsn1br0NpLXy3Xnh5PW8Bvw
	Rk7dcrqWTqUURENEYUKiNnzHd7m163Or9AfGaeWkGObIF7xV2b6MUAurDixZtIMWPhsLQ9KGWBT
	8hm6VczwfikmEkdr6QvOH/N5dOvpgT2+8iE6k6Ty5qWIo=
X-Gm-Gg: Acq92OERTTc1YBFE6Avsvwou41bLStFfllzCfGK+iYYxHje8RnLgrox49BvvTjsdiKQ
	if9Y1GpWh7ImyDasOQgAQrziYOgPQvVPqnFbqF3Efnpg+8xPhp/7K/l7QaCHjaoRPlpKCKUSjOl
	clXz+A+4RAr3oVNeL5EgX294jhrxeuESzQyXhdp/43N8FSC32wYUAfOK6vclxANdbKAwyKJ9PU3
	8nJNJSc3MJoCg==
X-Received: by 2002:a05:690e:400a:b0:65e:3df3:1c71 with SMTP id 956f58d0204a3-65eae3402d0mr1402727d50.43.1779352046102;
        Thu, 21 May 2026 01:27:26 -0700 (PDT)
X-Received: by 2002:a05:690e:400a:b0:65e:3df3:1c71 with SMTP id
 956f58d0204a3-65eae3402d0mr1402702d50.43.1779352045681; Thu, 21 May 2026
 01:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260511094504.1619893-2-dtatulea@nvidia.com>
In-Reply-To: <20260511094504.1619893-2-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 21 May 2026 10:26:48 +0200
X-Gm-Features: AVHnY4KzvfnK96jq_WEM08qHvg7RJR8HuiYmXJ5atCT1OCaQOTYbbzhAXG5NZTQ
Message-ID: <CAJaqyWc6gA=TU-YMYdttH3_MjBo+644kgmah1XZnvxP58Gxzag@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: Expose ASID group change after DRIVER_OK via
 backend feature
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V3wYBUdYTdPJU4Lti-TDpNIX6RE_ueunGycUe0YtUJ8_1779352046
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 11:46=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> The commit in the fixes tag blocked VHOST_VDPA_SET_GROUP_ASID operations
> once DRIVER_OK is set. That is too strict for devices which can safely
> handle this during live migration flows.
>
> Bring back this behavior under a new vhost backend feature flag. The
> feature is supported by mlx5 and vdpa_sim devices.
>
> Fixes: 3543b04a4ea3 ("vhost: forbid change vq groups ASID if DRIVER_OK is=
 set")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c |  3 ++-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c  |  3 ++-
>  drivers/vhost/vdpa.c              | 13 +++++++++++--
>  include/uapi/linux/vhost_types.h  |  4 ++++
>  4 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index ad0d5fbbbca8..f89177957c76 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2906,7 +2906,8 @@ static void unregister_link_notifier(struct mlx5_vd=
pa_net *ndev)
>
>  static u64 mlx5_vdpa_get_backend_features(const struct vdpa_device *vdpa=
)
>  {
> -       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
> +       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
> +              BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK);
>  }
>
>  static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 f=
eatures)
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index 8cb1cc2ea139..253c7fb35ea0 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -428,7 +428,8 @@ static u64 vdpasim_get_device_features(struct vdpa_de=
vice *vdpa)
>
>  static u64 vdpasim_get_backend_features(const struct vdpa_device *vdpa)
>  {
> -       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
> +       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
> +              BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK);
>  }
>
>  static int vdpasim_set_driver_features(struct vdpa_device *vdpa, u64 fea=
tures)
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 692564b1bcbb..67b3f49fa709 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -682,7 +682,8 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa =
*v, unsigned int cmd,
>                         return -EFAULT;
>                 if (idx >=3D vdpa->ngroups || s.num >=3D vdpa->nas)
>                         return -EINVAL;
> -               if (ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK)
> +               if ((ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK) &=
&
> +                   !vhost_backend_has_feature(vq, VHOST_BACKEND_F_GROUP_=
ASID_AFTER_DRIVER_OK))
>                         return -EBUSY;
>                 if (!ops->set_group_asid)
>                         return -EOPNOTSUPP;
> @@ -791,7 +792,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fi=
lep,
>                                  BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST) |
>                                  BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
>                                  BIT_ULL(VHOST_BACKEND_F_RESUME) |
> -                                BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRI=
VER_OK)))
> +                                BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRI=
VER_OK) |
> +                                BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER=
_DRIVER_OK)))
>                         return -EOPNOTSUPP;
>                 if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
>                      !vhost_vdpa_can_suspend(v))
> @@ -805,6 +807,13 @@ static long vhost_vdpa_unlocked_ioctl(struct file *f=
ilep,
>                 if ((features & BIT_ULL(VHOST_BACKEND_F_DESC_ASID)) &&
>                      !vhost_vdpa_has_desc_group(v))
>                         return -EOPNOTSUPP;

Ouch to me here. By reading the errno manual:

Nit: By reading errno(3):
ENOTSUP - Operation not supported (POSIX.1-2001).
EOPNOTSUPP - Operation not supported on socket (POSIX.1-2001).

I picked the wrong constant even if they share the same errno value
(by the same page of the manual). MST, is it worth changing it?

> +               if (features & BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_D=
RIVER_OK)) {
> +                       if (!(features & BIT_ULL(VHOST_BACKEND_F_IOTLB_AS=
ID)))
> +                               return -EINVAL;
> +                       if (!(vhost_vdpa_get_backend_features(v) &
> +                               BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_=
DRIVER_OK)))
> +                               return -EOPNOTSUPP;
> +               }
>                 if ((features & BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST)) &=
&
>                      !vhost_vdpa_has_persistent_map(v))
>                         return -EOPNOTSUPP;
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_=
types.h
> index 1c39cc5f5a31..ec1ff8a2e260 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -197,5 +197,9 @@ struct vhost_vdpa_iova_range {
>  #define VHOST_BACKEND_F_DESC_ASID    0x7
>  /* IOTLB don't flush memory mapping across device reset */
>  #define VHOST_BACKEND_F_IOTLB_PERSIST  0x8
> +/* Device supports changing the group ASID after DRIVER_OK.
> + * Requires VHOST_BACKEND_F_IOTLB_ASID.
> + */
> +#define VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK  0x9
>
>  #endif
> --
> 2.54.0
>

