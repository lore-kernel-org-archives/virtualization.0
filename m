Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC2130AFC
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794557; cv=none; b=V6/aJfh9HU+PRJw13nWygLifFrpw0UwOsGCpZw1HtOOROukpZuIXZFgBemyB4pDFxPGOaCNBMwUVaVATXtDMSpZThLwGtFi0iG4Zjbh2ysiISVB8xAMHAMErRa8FQmNntfGi8nG9B2ifGO4XFRZNBwV0fwli8Uj00zrwEmxoess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794557; c=relaxed/simple;
	bh=kGxMAaJvLmfXkBIK3NGXhSRM0AwoYHtsGbNLEE0bnpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQJ/Y5hlehdObWbk0n/3lD77GdcVFUkR5lLKWYR7qec9aGsvGC4RYNe6TFEbOcp8ktBGz7OKGOu7YYkd/PM4OAMlbeAnLFwnOPa+xiCHBqPZCJ2oNWponV4tAe7vWjPeBedbSDJ5bCWyFumJuSnChHV993qLBcrbw6Ovs5CvaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kyq3RRzv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kyq3RRzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718794555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOO5ZSP3WLU9Q7oAH7CvSIrRzVR6QPgru4zl8xC0EsM=;
	b=Kyq3RRzvAQoiGk8i8GKOhLyFdurooJHfq+ALjKJSHAnTHSOccX/pWPVV3Mzw4hAfl4ylEL
	TbKnnerlslU1kLmW7WIkv8Iwda0WP2+vGjc5sV9mk5HIPcYX8ddAEHDqlzXPtuaZG4Od0/
	kNIr27EFQJvgT/ddhsdMMeeF50TCnvA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-gAGuqk-ZPemHyJ88hdCsCA-1; Wed, 19 Jun 2024 06:55:54 -0400
X-MC-Unique: gAGuqk-ZPemHyJ88hdCsCA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-631d53af5e1so112529517b3.2
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 03:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718794553; x=1719399353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOO5ZSP3WLU9Q7oAH7CvSIrRzVR6QPgru4zl8xC0EsM=;
        b=Y3FsSysnVL5rE9KjX9pM+WQj32UYAgijzkCtWibuIcqHDG5jZHX/gxXvIq+VtFAXtW
         Md0EEU0vkUQ7mkQzcXYgB217LM9ruyAu6KZe4PXhGcMZ5Q5Mp2f+3Jxh3Uog/LospriI
         6a85M5JTK9rgfO9+oqFWA3feav+5fylh5jFN5gatm+3VtHceiwdxhvfvn6j+xwzxwTeR
         fISGzXbtXUbA3uPbjY2NguFltk84h37RNyj5EFUT59r6q5HxLlR9c2F5i/7qKO97pn3t
         bzhH65tREsvrczX73JF+ema4f8mgrruF1MDH/cVxe+Gh5GLxS/fEdN8pUIC1vpsfb3XI
         BRzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd/IaWuYarOvA+df9d825SFV/GpmazVjde1G+MFdNipcm1SW7Xql4htFR0a0uQdLG3BbA0ugCctBGrvJkEXFjGvPYhpoQeDp164EJ9+Fo=
X-Gm-Message-State: AOJu0YyMKX9NRZPnheGc3FrTuu5nOHZif3GvTT04IVYKfpy6NSwHcBcU
	PB8FvrKDcC4QynxeVRWBU3WZljB0hx0Y0+EVmUe2jnCSkK8+qR62vAIxaOJwB3kH4MUPzfYFfng
	rIBDiw7rheJ/Nrgpgj3AK9ZYc8+cOk88ukOW92RQyPbrL0ancSgzZdQjTu02cdzKgsD5hxizcHW
	DhlJ+TzoUXPOyJuePY5sUpsQ5LYCTlaw2j0zqKrnM=
X-Received: by 2002:a81:9144:0:b0:627:a7d7:6d76 with SMTP id 00721157ae682-63a8f6196cfmr23423217b3.39.1718794553597;
        Wed, 19 Jun 2024 03:55:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvxPUUYPpg9QjOGGTil9Q0vxhLdibJM9rIX47lCpLHxV4IIFiJXXL5B/tBGDpyegeZIjHDn8kj0g1taUiWYss=
X-Received: by 2002:a81:9144:0:b0:627:a7d7:6d76 with SMTP id
 00721157ae682-63a8f6196cfmr23423047b3.39.1718794553297; Wed, 19 Jun 2024
 03:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-3-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-3-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 12:55:17 +0200
Message-ID: <CAJaqyWdWSbua3HJaAHP0vetugyy5-ryAD8d-z-Xi26VQXiRSiA@mail.gmail.com>
Subject: Re: [PATCH vhost 03/23] vdpa/mlx5: Drop redundant code
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

Patch message suggestion:
Originally, the second loop initialized the CVQ. But (acde3929492b
("vdpa/mlx5: Use consistent RQT size") initialized all the queues in
the first loop, so the second iteration in ...

>
> The second iteration in init_mvqs() is never called because the first
> one will iterate up to max_vqs.
>

Either way,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 1ad281cbc541..b4d9ef4f66c8 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3519,12 +3519,6 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
>                 mvq->fwqp.fw =3D true;
>                 mvq->fw_state =3D MLX5_VIRTIO_NET_Q_OBJECT_NONE;
>         }
> -       for (; i < ndev->mvdev.max_vqs; i++) {
> -               mvq =3D &ndev->vqs[i];
> -               memset(mvq, 0, offsetof(struct mlx5_vdpa_virtqueue, ri));
> -               mvq->index =3D i;
> -               mvq->ndev =3D ndev;
> -       }
>  }
>
>  struct mlx5_vdpa_mgmtdev {
>
> --
> 2.45.1
>

