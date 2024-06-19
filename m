Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BAB13211E
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795118; cv=none; b=pTOMVXxGU/cMg54aNoYHLL20rMBgoJak+5XOY1ciiGs2ERPWlhUF3ZkBE6wqR2PznnJmNaZkWIwQg0RhqD6wuTYcQ44CVYdwY08Vm2DmHsBrJ4tpxyle9hwcFSMz+XGF4w+IJ0rmXw4t/jEJ6TEH2R/aiX7xFn6RiBmciUtjURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795118; c=relaxed/simple;
	bh=0dRR5aTDWvDECUZeTACFItq3dlsdteCaVW0/xAz+trc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgq48YfBjlx8WwaqAUXxKtsisf7RuxZjIh3MV0AxsO5xgZkRR+Snksz5uZsNkew4sP3hBq4kQvJNUeqBsGKkCPic+XKwyJ3OWauG81TkS8JujZeKmgjx8VlemEooeLm6VbSVKc+JTvPS38yDPEgxg1e3aDJ0XxCSf/oxbzcUulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKrh+ty+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKrh+ty+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718795116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDjyaWl/Y5cyCdQUhzIAoRmk8UfpGo+tEe8x0hJrdZo=;
	b=hKrh+ty+oSMMJ5ulQT05eHdOPh7TsQDgQVLIXBkTgCzcg6wy/bLS/DYXiL50AtdnKS8+HZ
	ajKvs/bX0vfLneIvD2cQEDxklQiStMgbjmnvBmNw/Qt1kkk4Gx3XOmCTM9g87VYcTxRyj0
	DfLhOnCdKpMj6/nX3H7GuiExowGpCoQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-ohIiYs8EMsGqu8CHACPcxg-1; Wed, 19 Jun 2024 07:05:14 -0400
X-MC-Unique: ohIiYs8EMsGqu8CHACPcxg-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6313189f622so128185967b3.2
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 04:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718795114; x=1719399914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDjyaWl/Y5cyCdQUhzIAoRmk8UfpGo+tEe8x0hJrdZo=;
        b=AhoxIdX9kwk5vBIZmFDfPooAO2Eyx+jOWZ91Q8W3tG6OWmNsosC/k9aju/rEiZ66Hs
         HOsd5AnBMZGnrA8qT5IZd062iaoPFCFuk3PwghkuMezlD09ZcMNlH7h3Jd3Ny0YQKGQ8
         Vq2qGYxNSoxloVU/PfJkH7pD3V+McvRcf8Mlx6tCfo6XWsUiZrd6azNftUFyzeXQM7qL
         qX70zAvuEWyi6KznDTywaiWSbRO/1FYDNc51S10FMGmyTMQ/7iayLpGLPBCtDMBo8DOC
         /QNbC8oWzH483rUKkxD5JKWYbOtaQ8R9vrOmSAXY8GgZck4dAaSAnx9RrNsjGQfohgLg
         ZaDg==
X-Forwarded-Encrypted: i=1; AJvYcCWmkkSaCcTbFpSMQ+LZKGIiRw9ro7Cq9/P+k1QOsYGvAL7HDpz4mDcmBf6mEhEO6o+Q3D0LhQMmcOQ4maYelSB6VJDaAdH9lO0mqMc8H+Q=
X-Gm-Message-State: AOJu0YxDIPBWNbGl0PrWOonCFPRFsGWxmyJ3ayP7u0RxAWLQAaiU+YhY
	1wAn4TKCufS8V+pqJBkh8ecpq1VenRyXsiA3l6lYnKq7L3zeuZjAqzkNED2QAnML71H9JxApCbD
	1KvRmQmE/xmkBvwZ5vQBjrbupOMI5YRhvrySdUrcq5moy7HYc8l/wJUOlmfVXLIUFmdzYr94ywF
	qIklr60sQTPNyY0kH+ivwLuJpvPrr9AKu65j2EGe4=
X-Received: by 2002:a81:c602:0:b0:631:2ebf:b8dc with SMTP id 00721157ae682-63a8dc0792amr23261707b3.4.1718795114362;
        Wed, 19 Jun 2024 04:05:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ6Lahkzgb076y8mwVE/rW64T5ZHzTRWqaXRb1RvSZblvaEByNxDwfUmyzdSIeGCQH2jJ+ANLd7BBvZ34oULM=
X-Received: by 2002:a81:c602:0:b0:631:2ebf:b8dc with SMTP id
 00721157ae682-63a8dc0792amr23261497b3.4.1718795114089; Wed, 19 Jun 2024
 04:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-5-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-5-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 13:04:38 +0200
Message-ID: <CAJaqyWfXe9+KTzucF6YsBXOzCkJL0_w-n7PUih_j43hMAgMX4A@mail.gmail.com>
Subject: Re: [PATCH vhost 05/23] vdpa/mlx5: Iterate over active VQs during suspend/resume
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

On Mon, Jun 17, 2024 at 5:08=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> No need to iterate over max number of VQs.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 96782b34e2b2..51630b1935f4 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1504,7 +1504,7 @@ static void suspend_vqs(struct mlx5_vdpa_net *ndev)
>  {
>         int i;
>
> -       for (i =3D 0; i < ndev->mvdev.max_vqs; i++)
> +       for (i =3D 0; i < ndev->cur_num_vqs; i++)
>                 suspend_vq(ndev, &ndev->vqs[i]);
>  }
>
> @@ -1522,7 +1522,7 @@ static void resume_vq(struct mlx5_vdpa_net *ndev, s=
truct mlx5_vdpa_virtqueue *mv
>
>  static void resume_vqs(struct mlx5_vdpa_net *ndev)
>  {
> -       for (int i =3D 0; i < ndev->mvdev.max_vqs; i++)
> +       for (int i =3D 0; i < ndev->cur_num_vqs; i++)
>                 resume_vq(ndev, &ndev->vqs[i]);
>  }
>
>
> --
> 2.45.1
>

