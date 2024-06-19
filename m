Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5D633CC2
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794995; cv=none; b=GIxL2i9djSuaBBmTcVFJqqpE1NbPJFw8xYTzd5RqdlGtx3f3E6jNELmRjYZuan2h1Bc2MB6rm+hGzDREfNrVVT8BYvw/jg1l0h3CI9tmnOj9GmmRtAo67Y1CbVeMiuKGAH/xvHF6xQGDHL81VVd+acEqIz3oEz0TWr1If4gNZEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794995; c=relaxed/simple;
	bh=1bdmFYChepEqjby6FGx8U06BldFaO0w3AEyYFVmPYEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJ0abGKwVEqzAtXG3fbXTnl8Ak5T2u91fNuoZPTRU+b4v0G43EJ4cakT/Wbbs3elfjrZFroySJo7SC1I9a7vgS3auHXQe3eCh6uz5fy5LoddBL4A1sBL54jTOCNUWmPYneueBftO5xxqLFUVgTy3EHOEQPshLe/NpdtIUYWp2nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Apo5wXh+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Apo5wXh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718794992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/M7MnGXwS8uLXvNZgVDSoX5YtxoFcpHgW7L/ahwWrY=;
	b=Apo5wXh+Oe2sl1Wib+T4CkHMmqXJJu040SM4WTDJM3ic30atp9VRtyb2PIW5aNbSu5uxzd
	rfX4N+j6rLfANP1LcdjdTmV5Wbr+qOSLnCLGBiaJrNLb+8lGVi5ieK+1uWupekun14ETt9
	gEaY+pCjpEh9nzKC7g8dSvod3/wZsXw=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-XU7fEBeJNl6o7dYF4tbiAg-1; Wed, 19 Jun 2024 07:03:11 -0400
X-MC-Unique: XU7fEBeJNl6o7dYF4tbiAg-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e02b7adfb95so2887869276.2
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 04:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718794991; x=1719399791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/M7MnGXwS8uLXvNZgVDSoX5YtxoFcpHgW7L/ahwWrY=;
        b=XnU+f9CqWVH45oeUkUozB9nTeB9R2AWofx38PZa+W7ypMu1Fb6Yelr92ZHYTBTmq+C
         IUCV7osB67eSaHD27N87ZI9uZUl34Oyer9AfF3BkHWrBYXGG4bw/SPcwIUE9zT+1zUsT
         ODyqLMItfAVrcfe1bdGk8pn7nQ9jOsoLt8MS8l0PG4tl3rWgtaP/CERNCvPwB6O1pBnI
         2+zPRjlnmybPo0ctGpvQ++82Rlm5sUgZ/MiDl+N2t7tMWAEKA200LtxIAxd9keZ6HacY
         1kf9gPI934sDt0yjPdx0aot//t0CJpG0dy1WBXGEg1XZq/8Nkn91dFGrEKKPpenhA6fG
         Y37A==
X-Forwarded-Encrypted: i=1; AJvYcCVIlqod7y5uAThawQfYQUKkwQCribbLts9Yf6SGvbHuim06P+bz2nhDKk832aOlA66RQg4+srAumP7qjVO3KYAgqkGhmSr32ep4d4SyG5E=
X-Gm-Message-State: AOJu0YzHKFqCKfuosi0wOuLUzDOP4NM3fKMMF8+e/qcLyfan1nH3wzhI
	t1Vd8yk85lruszCXMX0lkhygnsI7zpfKJtuZDLfLBGc5lsYU2hQ5bI8qrZdlOSg/25txN2bKtYy
	kfdYIt93ewWttsyrv8Dl4KyZExbKplw77NcIPXYSJPHbEer5mKVqCxw55e9q3ASAelazy5g5Nkj
	P1VpZPxYUDi68P9e64oqN3Gb2kxD4Z1m8m4QP5cgE=
X-Received: by 2002:a25:24b:0:b0:e02:c29d:7dc6 with SMTP id 3f1490d57ef6-e02c29d8011mr1449191276.43.1718794991116;
        Wed, 19 Jun 2024 04:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMuYoMspdK9W3dvJFbwMXu6A1vxVHrL7pJhY3Nas3Emxi4QlBjq10Z0XGEVO+7m9QoYNiiYNpMnoT3yoCdFRY=
X-Received: by 2002:a25:24b:0:b0:e02:c29d:7dc6 with SMTP id
 3f1490d57ef6-e02c29d8011mr1449158276.43.1718794990800; Wed, 19 Jun 2024
 04:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-6-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-6-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 13:02:34 +0200
Message-ID: <CAJaqyWdHgpbmjtEP-tGgCiMGwrvkicjxXV8NLRZyDpRk97nkJA@mail.gmail.com>
Subject: Re: [PATCH vhost 06/23] vdpa/mlx5: Remove duplicate suspend code
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
> Use the dedicated suspend_vqs() function instead.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 51630b1935f4..eca6f68c2eda 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3355,17 +3355,12 @@ static int mlx5_vdpa_suspend(struct vdpa_device *=
vdev)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> -       struct mlx5_vdpa_virtqueue *mvq;
> -       int i;
>
>         mlx5_vdpa_info(mvdev, "suspending device\n");
>
>         down_write(&ndev->reslock);
>         unregister_link_notifier(ndev);
> -       for (i =3D 0; i < ndev->cur_num_vqs; i++) {
> -               mvq =3D &ndev->vqs[i];
> -               suspend_vq(ndev, mvq);
> -       }
> +       suspend_vqs(ndev);
>         mlx5_vdpa_cvq_suspend(mvdev);
>         mvdev->suspended =3D true;
>         up_write(&ndev->reslock);
>
> --
> 2.45.1
>

