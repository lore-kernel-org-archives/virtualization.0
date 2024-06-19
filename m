Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56F813D532
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811271; cv=none; b=QzBoKZM6C6DuLw8W0M3VLKTExrhe8QWkHf+p9TX6fySk9xe9WRWGuu/gsqg5QZb1fkG1Ht5u7XmMh1BcGnLbpYjYIx1zR+sHnKE0JYohXmePbg2mXki1TBesudyuX0jXrO7I3N112WXtBlhE3ODH8jKMIuM6e0Ru/FA1b/EaUo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811271; c=relaxed/simple;
	bh=SyZw5x3PrOSKjnuwYIruwizBz8S5XAWHURMQrf+hBZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stDhiRPFum/BLgUy+4AYqfNz+GRkAQMdKlEDwPimnGCaXtOzxJDAzhaDnE1VDVpDaSR6jbuWpQa6y1XV8RXYejT4cThb+qjfJDTrmMTuVZFL8EccotccXvMFIsO6VKF7fv7SL8EUEJxiP+8T2GaSEdBXaTusBo/j6kLk4xJAtWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kzi6K1O9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kzi6K1O9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718811268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Z6cd0gXeCDMqMe2Sn9JeYqUvzxkN6ZqxSbh48wbjqY=;
	b=Kzi6K1O9yXJb1m6XtlaMYhs/zM5WPpGhHbbpndbNeLT/lWBuEMB0P1RbJuaBEcLwRZDdHS
	Ax4RKE6fWSFSGxxUNKdHNsgKIlUhQAuy5vdImge7e/2DP6kwu6KkZiW/ppUX7yeVpDcrnP
	vYSVEdlj5ff51h7q+1NKpxg+RIcKBYY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-yo-njAS3OXSJwp3L-nTnWQ-1; Wed, 19 Jun 2024 11:34:27 -0400
X-MC-Unique: yo-njAS3OXSJwp3L-nTnWQ-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-df773f9471fso12244544276.3
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 08:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718811266; x=1719416066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Z6cd0gXeCDMqMe2Sn9JeYqUvzxkN6ZqxSbh48wbjqY=;
        b=RTLLiYMOiQnXkZgcoO+3CfwjJLTrxOoGtoqUQc33Sucr7/0sX0VoZ5bOlSdJs0QUGq
         lmIqTArtVMU9S361ehvvCkWD7pe9XjLkcxYTzRutwhCBYgks3awZKkpkByiJ0lbiJ7Nx
         cbrgl4zw2seuZ251TfwEC1EpFnj9d6ZcuJI65xnNLrit4r5mQk+j2KxAl3vZb/QiA6H0
         oB/6hCWsd6em7lQh23NPA2Xv0XZ63p0TrmezyuCTsAhsFIve+CETG2WrMqRL7lPH8IF6
         ZbSEnSX+8NaoGBUArynAchQiWPpYkiMdc9OYUITKKBo2sOfUhmMQC6HwxB6taRBLodk8
         F1tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPKskoH8H+iWfOILYJUO7QKrjwSEAUpbyq9H04TlJNSNqJrzm7eUnB7PjJYe8/b5hlA0912xkSvuxgesd6n/AlENx0NMLuVmkXRgz4p1M=
X-Gm-Message-State: AOJu0Yzhq9ztiIWzNvsjBKNvH3e5KQ0Ix8Sxv5bClAyiqKD2MM2LjU/v
	GJz5vXh0JpHwDoAG3c9sIUFqYAFVAB6kDxi4uEwXNLpfL84rEB8Bc9N+UP+U5bi5efWqIs0noZd
	bcq+twR4MMG4nDT2KkhvxyuFNXc7Q2tM7L4ina+3liwVhPZgGR7YIiAxYSYfFIIHzijyCZhSs76
	M+7X+hDUGYDAA5VY6J8B0WyIqOInxk/7Q+HL+gydk=
X-Received: by 2002:a25:6ac5:0:b0:dfe:148f:114f with SMTP id 3f1490d57ef6-e02be16c2acmr2786993276.27.1718811266508;
        Wed, 19 Jun 2024 08:34:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUWTR+p1MQws1i/MEYEjVgKq/tSc0AqXDfYlDvxq3BQdTNeJcL/NDUPxxwDuKICtSuQJkzJRGB/bJCvMMgtB0=
X-Received: by 2002:a25:6ac5:0:b0:dfe:148f:114f with SMTP id
 3f1490d57ef6-e02be16c2acmr2786967276.27.1718811266146; Wed, 19 Jun 2024
 08:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-13-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-13-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 17:33:50 +0200
Message-ID: <CAJaqyWc7B5BA31nMDotNQuWv19CAK2kcDKTZjTy_ODLHP2FMZw@mail.gmail.com>
Subject: Re: [PATCH vhost 13/23] vdpa/mlx5: Set mkey modified flags on all VQs
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
> Otherwise, when virtqueues are moved from INIT to READY the latest mkey
> will not be set appropriately.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 0201c6fe61e1..0abe01fd20e9 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2868,7 +2868,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>
>         mlx5_vdpa_update_mr(mvdev, new_mr, asid);
>
> -       for (int i =3D 0; i < ndev->cur_num_vqs; i++)
> +       for (int i =3D 0; i < mvdev->max_vqs; i++)
>                 ndev->vqs[i].modified_fields |=3D MLX5_VIRTQ_MODIFY_MASK_=
VIRTIO_Q_MKEY |
>                                                 MLX5_VIRTQ_MODIFY_MASK_DE=
SC_GROUP_MKEY;
>
>
> --
> 2.45.1
>

