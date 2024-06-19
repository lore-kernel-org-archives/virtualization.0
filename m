Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D10D59147
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809758; cv=none; b=sGi7yrDpzFHmBttprEzcUpy8LyMqz/zp62QK/FL2J1SjEBYwPRsP6WkSE9sr4ZdsoG2fuzqYCs5m//aN4MUTiPAz+cxAB/b9Kl4EqJTvxU+6y+b6n+3R+Na90jZzXECss/syqSyrfIIjIPWw+C9lNxbE9Z83P8PO1JqiUUfopXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809758; c=relaxed/simple;
	bh=512ZCaEEz4eWfZutUiztkEEEXYz1p7svVNn8c4qwTrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DyRUGVLDBmtWPb5Iq5XRZsufm6MeShTI0LgQp9i++orcOcEuazLcVdnFpjt5RtKhQ31oTwVZ5IDepNvsayICg+sT/xsTFyaUA+uAo34urQhBJHsrQLc+lCNQrvCXquTSoCDK8c1IMr/NtcOJJL+gIP0mG5vEZm63u8qyxBY91ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LR490eQg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LR490eQg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718809755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BMIw7ds/nWlexouYyFojHRj11oBl9QxmnevyQlA8My8=;
	b=LR490eQgFKt2bJNIKoZjg/YYEoCXqBW5kUV880bpnvgnxq4nUVE/UAO45TQncuqtJM1tzR
	RcbmMqa0sxo9GRFyuGoJWKWnCHja0+X7rNrfeXuK26OI+Z6NMXu+P5xKBQidcXAeTLw3Xg
	dpWXL8R7sV707hbuiELjnUOKW0FLSH0=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-osf5El5UNSiib_-_43VzZg-1; Wed, 19 Jun 2024 11:09:14 -0400
X-MC-Unique: osf5El5UNSiib_-_43VzZg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-631d53af5e1so116658297b3.2
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 08:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718809752; x=1719414552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMIw7ds/nWlexouYyFojHRj11oBl9QxmnevyQlA8My8=;
        b=byYN0wSdV8Fx0C61CcCXcCkVNtyTAj6/eKoW3Vx1Uej/wJ69Gv8D8Xq2r2CS+aVh8/
         tY1Rv0+qw2EEOt3o7jr/HB0t2UoInVxJKMJzP/HitFmnSyQgtdimeOhUQPneIQVh2DI2
         bCMOkwwkopOiywfz7ojfZR1yITS7PUdTyyXF0SaJ9QKuYclgOdIPXqkEgegiN9WbFY0z
         5ElYpNp/39seRRzI9IxkYtJqRYp5dF8jBFNOb1ScV2GvVIrVw/C4B0sWER3Z3TW2Z90G
         q4BzUIuPhMTOFfymMVLIRt/A4TXeRwKKc+tQGkCjiHrJexDjFK2zKk3XQA0VXInNNFET
         Sqrg==
X-Forwarded-Encrypted: i=1; AJvYcCVfSiIsrwYVZb3tZAEtJTQ4a/KwEkH5hyyeEjGFQacVxWT9NvRYwjkU/X2VPJ9JYUFd9415UvPx2oEAMuoUDYpJEMgfIhbUK16kWW4BKFM=
X-Gm-Message-State: AOJu0Ywdppb3ARSWERomYCx57QW8RMvON8had/K05x2/MMARb14TLRk/
	DFUNAI+z0yqxr6Rj81ZgBbD+5Qov1+MbhOsMP1d4upCdypmDDeNfe7aAWM9XEmUVGsug+Dn5xOA
	pFYb2ZUT7fRxsrXLgEaq420VzsXG413S9G9Y65cdU30/tWVt0gSNjZWVairHaEM39hRqX/WJBL7
	vhrfhwd2UAEcOQWo56GYHGKstRpbf2FQnJTre9RfM=
X-Received: by 2002:a25:8004:0:b0:dff:3058:e30f with SMTP id 3f1490d57ef6-e02be13ba98mr3072458276.21.1718809752487;
        Wed, 19 Jun 2024 08:09:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3OygO+UAqhsmU2eYtM9cFyW9UsJ4Ba910yO3Z4ITLZ68HjjdISuMgaXJBXkGYQ6BkgCtmeVGylZ1w88hx65c=
X-Received: by 2002:a25:8004:0:b0:dff:3058:e30f with SMTP id
 3f1490d57ef6-e02be13ba98mr3072423276.21.1718809752187; Wed, 19 Jun 2024
 08:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-11-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-11-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 17:08:36 +0200
Message-ID: <CAJaqyWedSQdAiFoQuqdzwdZ4KNNPD7wyX4=QTMMG4aYt7US7PQ@mail.gmail.com>
Subject: Re: [PATCH vhost 11/23] vdpa/mlx5: Set an initial size on the VQ
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
> The virtqueue size is a pre-requisite for setting up any virtqueue
> resources. For the upcoming optimization of creating virtqueues at
> device add, the virtqueue size has to be configured.
>
> Store the default queue size in struct mlx5_vdpa_net to make it easy in
> the future to pre-configure this default value via vdpa tool.
>
> The queue size check in setup_vq() will always be false. So remove it.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++---
>  drivers/vdpa/mlx5/net/mlx5_vnet.h | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 245b5dac98d3..1181e0ac3671 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -58,6 +58,8 @@ MODULE_LICENSE("Dual BSD/GPL");
>   */
>  #define MLX5V_DEFAULT_VQ_COUNT 2
>
> +#define MLX5V_DEFAULT_VQ_SIZE 256
> +
>  struct mlx5_vdpa_cq_buf {
>         struct mlx5_frag_buf_ctrl fbc;
>         struct mlx5_frag_buf frag_buf;
> @@ -1445,9 +1447,6 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, str=
uct mlx5_vdpa_virtqueue *mvq)
>         u16 idx =3D mvq->index;
>         int err;
>
> -       if (!mvq->num_ent)
> -               return 0;
> -
>         if (mvq->initialized)
>                 return 0;
>
> @@ -3523,6 +3522,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
>                 mvq->ndev =3D ndev;
>                 mvq->fwqp.fw =3D true;
>                 mvq->fw_state =3D MLX5_VIRTIO_NET_Q_OBJECT_NONE;
> +               mvq->num_ent =3D ndev->default_queue_size;
>         }
>  }
>
> @@ -3660,6 +3660,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>                 goto err_alloc;
>         }
>         ndev->cur_num_vqs =3D MLX5V_DEFAULT_VQ_COUNT;
> +       ndev->default_queue_size =3D MLX5V_DEFAULT_VQ_SIZE;
>
>         init_mvqs(ndev);
>         allocate_irqs(ndev);
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/ml=
x5_vnet.h
> index 90b556a57971..2ada29767cc5 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> @@ -58,6 +58,7 @@ struct mlx5_vdpa_net {
>         bool setup;
>         u32 cur_num_vqs;
>         u32 rqt_size;
> +       u16 default_queue_size;

It seems to me this is only assigned here and not used in the rest of
the series, why allocate a member here instead of using macro
directly?

>         bool nb_registered;
>         struct notifier_block nb;
>         struct vdpa_callback config_cb;
>
> --
> 2.45.1
>

