Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB39C2AEE7
	for <virtualization@lists.linux.dev>; Thu,  5 Sep 2024 02:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725503199; cv=none; b=iwG0KiAlwrOVNTOyGSprkZcEAqZ0YnhzRAmRvPU8LZ6i0hzDnwqXYLgUIH2r+vETk8BVcomnmKKeVHqWR+9rwZw3AAdd+w2h+poAQVYYUcGDkdq8A1tPUhFSqiJ2D9U34Swlemt2YM6Vntk7beiIbFQE0m5Fig5LLyoIYtnBo2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725503199; c=relaxed/simple;
	bh=0fSXcX9f2cuGkwjtwMSB0e3XbaJEAH6jrJj+iH7u9GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RySNdEv+T4Mhb6QV1j4xyVU5ETIPQ/slqTMI6B040ICJIyPN0I9qnv2wQ4Y+AhzzvLAiwhPa0wfQJ1XF4IGqjxwDLdO7NbzuBEeJyRKiViKkNALx1+G7SxF79ZPufXh0caOYOhsf8v5RwkYYr1zr7mb0kqzEq2/Ifxv492yJ2Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b9PIkari; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9PIkari"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725503196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0AcrrDwG+gt5HtN9utGk0xrv2KVXxivTuUcudC8C5KA=;
	b=b9PIkariwn1YazMcrlbu6Y3kPpLw0IkI/OqWpcJD9XsEzv83wGVgXQQV02CtwXXFNnKBkW
	SPoYZIGme5TnO7rm4IzKdCjZtMx1+jYgIfMy2Fqb9SbOKWHxA+nOToJFBQnXyWIfHPxBr0
	4cafQsi9Fg/SqGv03KoqK0oVyYjysBI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-y3XqJZ_-M4aoH804-I7qOA-1; Wed, 04 Sep 2024 22:26:35 -0400
X-MC-Unique: y3XqJZ_-M4aoH804-I7qOA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d882c11ce4so258107a91.2
        for <virtualization@lists.linux.dev>; Wed, 04 Sep 2024 19:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725503194; x=1726107994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AcrrDwG+gt5HtN9utGk0xrv2KVXxivTuUcudC8C5KA=;
        b=tsposG9MjHjBvNHbh4j2gtOznKU6eUrR6Al++gAn5jxpGFaVEnJnGA0vr1V4Ab0IXP
         S/T6904mYFrU+VtyROJUhht+MXgKpGOPvLG6MYE4707dxvGMru8Scm5f7mq+wlShtcXM
         qQe6J4fn/heWar12J+9sGRqOoyrVwQqqpflWnHIdci6L7noaLpSoLOwIURhHA/Tq91Qd
         JcI4plpvnv+uWAOU9uMIXTaVyfrv7Z36Z+kNMkXldEubptw36tJNfNrBOQNw+8WC+OjK
         d5OvQDbCT/IdHJ769yQl5cNcmg7gLfhPAPhTZ6Dk+ATClCYujCQES09gSKR3JG2h4K5g
         Il7A==
X-Forwarded-Encrypted: i=1; AJvYcCUZM2d76PPJArr5WzRPlvkxQTzqHB6e83UUH6eJAPWQ+tRAv46Z4o90cg3y7vh8AQ534Iqdsdl8i5oZdmw1bQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyfw806fC/EK6Nq/traSPE6xh5z6vU1ZVA8xVZcV2x5jPqsML68
	SNC+eJ/o9m/YPOBsrSzwwdqWDeJINJ78aGQg7ZwTjsmA6gyllK5z0HIsf79dXnSCll77B6X5EOP
	MMwnjI5YrwjkSqotWccrsguIGzQgOFH1Ngd7yaqk9AUW+y/A8Lu0OVU1qyiT/ALj2eM0DaUFaQw
	JqUOXkKgegnhYF6wEv/Huz+JxZ6/JSjOxWOguxCuU=
X-Received: by 2002:a17:90b:3006:b0:2d3:ba42:775c with SMTP id 98e67ed59e1d1-2d8904c6ea8mr14915075a91.1.1725503194562;
        Wed, 04 Sep 2024 19:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWuQKLDoZMrRIdao7KmQN4ts3CZKQHTuY+s+a//aNWe36FRXtO0yYzwLAFD4CEo6un3aPXRTMoy8n5g9CHlN4=
X-Received: by 2002:a17:90b:3006:b0:2d3:ba42:775c with SMTP id
 98e67ed59e1d1-2d8904c6ea8mr14915055a91.1.1725503194136; Wed, 04 Sep 2024
 19:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com> <20240904151115.205622-2-carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20240904151115.205622-2-carlos.bilbao.osdev@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Sep 2024 10:26:22 +0800
Message-ID: <CACGkMEvj0yWoGP6LvdNL5rkE59DsdpGwwaZNGVVHYO+zgjTudg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] vdpa/mlx5: Set speed and duplex of vDPA devices to UNKNOWN
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
> Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
> This is needed because mlx5_vdpa vDPA devices currently do not support th=
e
> VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex. Add
> needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.
>
> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index b56aae3f7be3..41ca268d43ff 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -173,6 +173,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa=
_dev *mvdev, u16 val)
>         return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
>  }
>
> +static __virtio32 cpu_to_mlx5vdpa32(struct mlx5_vdpa_dev *mvdev, u32 val=
)
> +{
> +       return __cpu_to_virtio32(mlx5_vdpa_is_little_endian(mvdev), val);
> +}
> +
>  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
>  {
>         if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> @@ -3433,6 +3438,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev =
*v_mdev, const char *name,
>         init_rwsem(&ndev->reslock);
>         config =3D &ndev->config;
>
> +       /*
> +        * mlx5_vdpa vDPA devices currently don't support reporting or
> +        * setting the speed or duplex.
> +        */
> +       config->speed  =3D cpu_to_mlx5vdpa32(mvdev, SPEED_UNKNOWN);
> +       config->duplex =3D DUPLEX_UNKNOWN;
> +
>         if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>                 err =3D config_func_mtu(mdev, add_config->net.mtu);
>                 if (err)
> --
> 2.34.1
>

