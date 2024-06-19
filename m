Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4145153BFC
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815201; cv=none; b=oVJS6s3KCoBpBNR3Nv6hPMTirPL+bVGJO0PKBsGq1nmJmgfwkMtM/Br0cG3tsadJ68IZPpup5P9L5GoKWUIW3Me92gfzgF4JGRmLQuLKlttSU728puZIE96gyMymMS0LJmtuI0QIAYRPUafstpxPe3i2LrgezzhXk7w8KTvoUI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815201; c=relaxed/simple;
	bh=TLxDuDULv7mvnSpOlUw3zxuVhjTlDVDDw8EewhZA5MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McFryQqKKnxXMleQbxKBy+b81I49zUYTQuvMu0VGeFIwV/ns5SERRhpTEXIQvQ5p6Oq+qWi47kMh7gm5wTGzCfG4qy8bR+Bb1D4ivKsVno519sBmkydtx+s5GOgePAQJpgngbkbAOy885qMsji8MuOMffmoRMQVyZpfme5xxR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FM/6aQCr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FM/6aQCr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718815199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P60Z+qqKP/gxhy1fal8KOowFEF1s+YzH3edKw1gHlyU=;
	b=FM/6aQCrgoL8qshur8rleJ3Qhz5i3MmMhcg1Rv7t2D4p8wear3fyrMXeAjOW9KjwdrnWew
	Iz9LCpkgCFJdNdaBsyx7sh265A9WFZEJ0bjuMBUb8+nzzRn1wYcEXvWkV8a+9yjOn80gU6
	6WakzzfrrFDAW+mNrYosX99OuAN/xrw=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-YcK1hDR7O-m13gDYnkysKQ-1; Wed, 19 Jun 2024 12:39:57 -0400
X-MC-Unique: YcK1hDR7O-m13gDYnkysKQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-62f8a1b2969so137922887b3.3
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 09:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718815197; x=1719419997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P60Z+qqKP/gxhy1fal8KOowFEF1s+YzH3edKw1gHlyU=;
        b=NgZzP5NRPU/M/RKFpdkDED7tg1rNzFvW8hnenjmpEJ4Gib8VElieoUr4po2v8gmRgV
         XT7N1L6mg11yqP4JURo0Gv1vWMzexj2/xLlU8FgVq9Sz7wVLZcuWTluPSJPDU+rDYEP4
         BLUHl9RxyZIqIagDALs++51HutNZfgDBYSCPKone3c5x8hkGq64V3I+xzvLs8JtZNtCg
         dKAhJqcsjTBx30UbORJ9Yi2wKVmZfbiHryRHgBlAu4acrRxMtwm/otngR3krlAsrFmjS
         hlfGDn6qqlJhxFRi2MaREoNyx3nO/nvhk64CxgDavyu343PcjgBVBptO7ynBMjP8V45f
         1ekw==
X-Forwarded-Encrypted: i=1; AJvYcCXkOMRlSl2Ums5Hyt+Hgp00KgUZBJQ3nmRpgftCR7U8leF6LrQkjVP4dwiDq2FgW5n80ijgXejKTZcXeyY7D8CTLX327m9980nIef2ChnU=
X-Gm-Message-State: AOJu0YyHAqtocNOXQZ9gCLth5unDhOdiLdlQ/VGuWzDK6X1kdDueEN18
	3TZfWiMaYjYFA7Mtaadb0C+zwqtdzJ+Kbqa3DPo3iVgjKsRt+CE3qvx6u4ZaIu0ITtgNKYigKwY
	rhZVfIPs/vBanQpWHgX6HTmfuhShAU9EJm0tT8ph5NPWEIJDWOT3g3S72PPXZWfZ3hrGrI5d8M7
	XJp1R8nO4q3l3ZePXEN1AoInUYmvxBwOQYc5YGEWc=
X-Received: by 2002:a05:690c:94d:b0:61a:b038:6d34 with SMTP id 00721157ae682-63a8e4bb5a1mr33219797b3.24.1718815197190;
        Wed, 19 Jun 2024 09:39:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOXaEuiFH0ecGWxfyNYKYA47piELvowHtDpjSC86sl6JvY/gqFtoIQ2677PkimEVq0gbLNOWpWdslhce2oYP0=
X-Received: by 2002:a05:690c:94d:b0:61a:b038:6d34 with SMTP id
 00721157ae682-63a8e4bb5a1mr33219687b3.24.1718815196917; Wed, 19 Jun 2024
 09:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-23-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-23-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 18:39:20 +0200
Message-ID: <CAJaqyWc+bmWVU8Lu40bhxEatJ5y1f3n=AD2_UborSRa+Bf495g@mail.gmail.com>
Subject: Re: [PATCH vhost 23/23] vdpa/mlx5: Don't enable non-active VQs in .set_vq_ready()
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
> VQ indices in the range [cur_num_qps, max_vqs) represent queues that
> have not yet been activated. .set_vq_ready should not activate these
> VQs.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 1a5ee0d2b47f..a969a7f105a6 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1575,6 +1575,9 @@ static int resume_vq(struct mlx5_vdpa_net *ndev, st=
ruct mlx5_vdpa_virtqueue *mvq
>         if (!mvq->initialized)
>                 return 0;
>
> +       if (mvq->index >=3D ndev->cur_num_vqs)
> +               return 0;
> +
>         switch (mvq->fw_state) {
>         case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
>                 /* Due to a FW quirk we need to modify the VQ fields firs=
t then change state.
>
> --
> 2.45.1
>

