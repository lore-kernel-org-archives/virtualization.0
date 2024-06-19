Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED9E15099B
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718813104; cv=none; b=UuS4jcLGRgAkofat6FMFTJb3vKWMDM0ZEik9YlwQDmRNlKpoFIouOJIdca7shKNyqrPfcmsg3KQ0HOdby0Kkxf4E8WvTZf6tQHtiQitnWR44Xx09PUb79GjSnawBccSGaYtD5CNv6o+IBEXCXi9cumfN4L3/wpGC1lH+/nhiVMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718813104; c=relaxed/simple;
	bh=Zk8KBM+kAiD+53BnHbeYt1t9uy6ihq6v5ohcl+/8Gdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrvK9yIoCFMv9jOoPu7gEm7UB1NsfNFp6hg6zrNfGQThs/ypOaB5yQ+OQzy4ll5YNyXUbr7eNNi61GpatsBQudVEquzILeWWlrXFIZAaK0IB+ms//3XoDvitRPrtC2dealLL5v15xtGg+/DsfDUpiQ0MjO85FpMFS/a5J86p7uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jq1Qxr6x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jq1Qxr6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718813100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6qMRpfuI0FN17k1qQZ97/BIgCWj0BU7d5gGDLL6iE0E=;
	b=Jq1Qxr6x890ioy8Q+bCJQ541OP1UllCeZItOZe0st1AV4TYbYJQ1XwwXu0tiiWWriywlNx
	J0nk0/J9NdUkO9qy2mpuJ5Yx0WKDkxeTfMapC9wgHntmWRZBe6VjJP8G+cpkKklXHTd/ZG
	JUauBi5rtaYAteBl0RbFO714b5h1VY0=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-dnIh1OIaNhyqqNDGBkeWYA-1; Wed, 19 Jun 2024 12:04:59 -0400
X-MC-Unique: dnIh1OIaNhyqqNDGBkeWYA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-62d032a07a9so138086797b3.2
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 09:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718813098; x=1719417898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qMRpfuI0FN17k1qQZ97/BIgCWj0BU7d5gGDLL6iE0E=;
        b=WpW+DscsuAaiFLeMyAWLLnNl4rMxX3TR6X4FQEhx4WDHHS+uih/fgJPPZAVrX3w4bO
         A1qEUSIFrSKb1WtPDotlKyat/WnqupYImdEEsxic37//cWskEfFO3GQcgGnln9vOCWNP
         TGE7VewMEBV6zVz+VYsnBSmKXmPtUOigS8NMiFV6VwZ66yjCrXJBHv+fILISkNR2Ay0X
         mJJW679emuqYTxve3w1pIbQXHP4KRv8AQALM1cveLMNH/G0lNqJWKn4JUwMxYtvRlJOT
         GjDFDXZK9DGC+CT9+STmF4+5hzaNVrA9nqFJpxeIjfFiG2XmQOTjhyB4GdlpGhGb0S4A
         9ugA==
X-Forwarded-Encrypted: i=1; AJvYcCXjPpbyoh3PYCyDM7sc6o4fHNP4nL8JyUHZ/7GUKU7R0yrFneXu7Kj9w7gFydyfbCl5LkZiJMMOSXy7adUIld4hyPGodSvMZsO6CM6xt3I=
X-Gm-Message-State: AOJu0Yz/OEy8ifocPwSUVXYhEJq+hJiB3+vQ291/oDMcAFiNejrAOwTI
	vi1YQIcuVYVJM95pK05zbc5EaJ00773uruwMSF69xPg8BmycjjnyLg0lTGoP49DvbZH1mxMA00i
	Fq4MMMtN+g++YFpJc/ectOQK3m9HEXeYz7FiMD+JPlGVZxm9SofeVWYZrGX/5VlyYHV/m5URkre
	IjA7Ku/fx2/zFKC+CwW4dO4Weh2CzXqgep0jKhPVM=
X-Received: by 2002:a0d:c3c3:0:b0:618:2381:2404 with SMTP id 00721157ae682-63a8ffca0cdmr31982837b3.44.1718813098377;
        Wed, 19 Jun 2024 09:04:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOi0Bbuup1rjSY4QNqBeZr45d0/SLJoglpZcqMwzRQ4d442scS4ePsVvRRAEIzgBBpB2IayrTUCHF5plE2VAk=
X-Received: by 2002:a0d:c3c3:0:b0:618:2381:2404 with SMTP id
 00721157ae682-63a8ffca0cdmr31982517b3.44.1718813098007; Wed, 19 Jun 2024
 09:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-21-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-21-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 18:04:21 +0200
Message-ID: <CAJaqyWc75+ccqXUPa4GfwZsbCp+4Q49Vw6Vnsu+n1BXDdLi5Dw@mail.gmail.com>
Subject: Re: [PATCH vhost 21/23] vdpa/mlx5: Re-create HW VQs under certain conditions
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:09=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> There are a few conditions under which the hardware VQs need a full
> teardown and setup:
>
> - VQ size changed to something else than default value. Hardware VQ size
>   modification is not supported.
>
> - User turns off certain device features: mergeable buffers, checksum
>   virtio 1.0 compliance. In these cases, the TIR and RQT need to be
>   re-created.
>
> Add a needs_teardown configuration variable and set it when detecting
> the above scenarios. On next DRIVER_OK, the resources will be torn down
> first.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +++++++++++++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.h |  1 +
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index b2836fd3d1dd..d80d6b47da61 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2390,6 +2390,7 @@ static void mlx5_vdpa_set_vq_num(struct vdpa_device=
 *vdev, u16 idx, u32 num)
>          }
>
>         mvq =3D &ndev->vqs[idx];
> +       ndev->needs_teardown =3D num !=3D mvq->num_ent;
>         mvq->num_ent =3D num;
>  }
>
> @@ -2800,6 +2801,7 @@ static int mlx5_vdpa_set_driver_features(struct vdp=
a_device *vdev, u64 features)
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
>         u64 old_features =3D mvdev->actual_features;
> +       u64 diff_features;
>         int err;
>
>         print_features(mvdev, features, true);
> @@ -2822,6 +2824,14 @@ static int mlx5_vdpa_set_driver_features(struct vd=
pa_device *vdev, u64 features)
>                 }
>         }
>
> +       /* When below features diverge from initial device features, VQs =
need a full teardown. */
> +#define NEEDS_TEARDOWN_MASK (BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) | \
> +                            BIT_ULL(VIRTIO_NET_F_CSUM) | \
> +                            BIT_ULL(VIRTIO_F_VERSION_1))
> +
> +       diff_features =3D mvdev->mlx_features ^ mvdev->actual_features;
> +       ndev->needs_teardown =3D !!(diff_features & NEEDS_TEARDOWN_MASK);
> +
>         update_cvq_info(mvdev);
>         return err;
>  }
> @@ -3038,6 +3048,7 @@ static void teardown_vq_resources(struct mlx5_vdpa_=
net *ndev)
>         destroy_rqt(ndev);
>         teardown_virtqueues(ndev);
>         ndev->setup =3D false;
> +       ndev->needs_teardown =3D false;
>  }
>
>  static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
> @@ -3078,6 +3089,10 @@ static void mlx5_vdpa_set_status(struct vdpa_devic=
e *vdev, u8 status)
>                                 goto err_setup;
>                         }
>                         register_link_notifier(ndev);
> +
> +                       if (ndev->needs_teardown)
> +                               teardown_vq_resources(ndev);
> +
>                         if (ndev->setup) {
>                                 err =3D resume_vqs(ndev);
>                                 if (err) {
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/ml=
x5_vnet.h
> index 2ada29767cc5..da7318f82d2a 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> @@ -56,6 +56,7 @@ struct mlx5_vdpa_net {
>         struct dentry *rx_dent;
>         struct dentry *rx_table_dent;
>         bool setup;
> +       bool needs_teardown;
>         u32 cur_num_vqs;
>         u32 rqt_size;
>         u16 default_queue_size;
>
> --
> 2.45.1
>

