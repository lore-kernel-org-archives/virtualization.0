Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FDB1DFDE
	for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 23:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768088794; cv=none; b=HyvQ8aQ0Xih9OUI0RTr1MKBqqeguCisqmMY3+IOv+rr1bpAWljahM4lPwFJVd+Y9cpJd+3vt1sm52zQA7IeUOw9uJ0Cvg2K/FpX6tETQJOBq82mlHeOk6z4kxjfkGrHY+CUTjTXkTSf0n6cAjI3a8hMLHzLKpXCLocokaBoK6QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768088794; c=relaxed/simple;
	bh=jz3bvB1PHTGPTSjDNldaMYUAl7EV4XOYsnYZI7MEa/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uaV3dN1ehyLwlPNUWe5ISKAALkvkACSHbVohs65kjOFKCN5mUcUnoHOvAbqYBPJMtA9QOrcEX/04UpLIV7kzZWB2E+5RJwnU+8E2gkEZirCgz9AVk1bsB3fmGLHA3HkHzko1qzXHIFIhUY5hrik370oH3oLfsfA6MDWa5j5GBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IA4nTvQq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IA4nTvQq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768088792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6elRUNWlenmQfN0BXFXD2AZTB0rmwpfsMViEoPTV8U=;
	b=IA4nTvQqhaB/6lCkODFAZFWUDvYGtpqf+W/kRKfOrtQ3/DSxwN7Jn5Qj1RB3kjVdOiCMjx
	+WoVmD7Kmi5lAfuHTm8CIonLMSE4cAyIf+cEayFD8N9m/VlBRR4G7uvR+psGe7ZW/U3ylt
	z74EIhSin+yAnGC9/UdWABkA/XDMLQQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-KXkEShEkNFyjsNrAZMXkng-1; Sat, 10 Jan 2026 18:46:29 -0500
X-MC-Unique: KXkEShEkNFyjsNrAZMXkng-1
X-Mimecast-MFC-AGG-ID: KXkEShEkNFyjsNrAZMXkng_1768088788
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477cf25ceccso49065705e9.0
        for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 15:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768088788; x=1768693588;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6elRUNWlenmQfN0BXFXD2AZTB0rmwpfsMViEoPTV8U=;
        b=nuS6WOuHNFk/807mcDaGqHgmsjKOqjVboUmg0tR0nNekzMlk+E3rbP36m43iohwuE7
         uPrVWGi8ypG+4OwVEQY+llZi43IODXOTkb+u8JHeCcfMBtgyki2bZz2W0eucTq0UH4nD
         tpH2q2EcQ+y3R8vIIQA/qgilhaM30w0cKkhIjJmjr17p28Ik9VC5sbkIIbirmG1dwXB+
         LjxBfjAriBqkVoU6RjQUWtkluzk0so+LRI7UWdBiAYI+scrmq+8PGS8maOxCbJdDPien
         H4B4GWe+GFKBxop4zuSdi7lP5NNeOxmIsH4ucRSHg0Ubkpz35EQ/gqLpynn5mrDN/lxS
         nXzw==
X-Forwarded-Encrypted: i=1; AJvYcCU+5zIPzLh1O4LXkYsVyBNqFS6FB7KSYkKqD5tzO2h0nsKoLKHTBhGMmRubfBynxrEVyHQnoRc0gKzaY75HcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvfEBRTEB3MEcm7bu/muGIxvnkC/9gXXWPWVUXf5pPFl+wlcwR
	5IUJbsBUsPMAn1/jZgYsyHUu1yyKKCnIWSPho1W2yhBxWmIN6ab1gTY5+hbme9NZN9WOEqo5EtV
	dUvpUvxKBR/F773QQF4xO2uZ2INzWkVzHfHdE1wrlzQCcP0s8uWeNRb9W8Y83H8Cslzyh
X-Gm-Gg: AY/fxX7jsIkCn16CPKkMqV6vpjbt0jAUZC+tbNZO6WgPcogDMg8GS+C/b7wy5MMLP7d
	dZ7ZXsv4HC8zL9S0M3k89LrwfBzkw8P5xniUV5GqY7eY2bjDe+YkkK9sBdFTWK2ps43xr6fjwVA
	bH+BkIyPUT1mk+GJ8Z8vyo1mqUvpsfo6ULyRX6z8Hfm7AoNB6a9imc3b90l5cjLA7+UIEEpDjJL
	uTsin356/RvZXdeg/RJbS4OUMj8Pzp55JQhWWYGrhlQvqcPKx0XIKpTo66Yoq7DgJulogJDgCJl
	nDDfoYmaJm6R5zonHGY7ne5ibLZyru8z+CJCVagyqhUWdEM7N5782awWDFkpRHqwbvn2NBpznFP
	WYRLpyaOViy0hTC5XgHBCAQFph/ZWAj8=
X-Received: by 2002:a05:600c:a106:b0:47d:73a4:45a7 with SMTP id 5b1f17b1804b1-47d84b3badfmr148899915e9.24.1768088787727;
        Sat, 10 Jan 2026 15:46:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2ab/QGx2TbXl9n4Rd/6gILYQe8AK5QFNV9Yjv10GRzRcB5XzNkX8wK50oU0rhKiS2cVIRmA==
X-Received: by 2002:a05:600c:a106:b0:47d:73a4:45a7 with SMTP id 5b1f17b1804b1-47d84b3badfmr148899705e9.24.1768088787269;
        Sat, 10 Jan 2026 15:46:27 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f668e03sm289862035e9.14.2026.01.10.15.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 15:46:26 -0800 (PST)
Date: Sat, 10 Jan 2026 18:46:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v11 04/12] vhost: move vdpa group bound check to
 vhost_vdpa
Message-ID: <20260110184515-mutt-send-email-mst@kernel.org>
References: <20260109152430.512923-1-eperezma@redhat.com>
 <20260109152430.512923-5-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260109152430.512923-5-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i1SylPnv8JSUk0tByo2i0oWCjcpZt_9AWT3z_4u7ABY_1768088788
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jan 09, 2026 at 04:24:22PM +0100, Eugenio Pérez wrote:
> Remove duplication by consolidating these here.  This reduces the
> posibility of a parent driver missing them.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c  | 6 ------
>  drivers/vhost/vdpa.c              | 2 +-
>  3 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index ddaa1366704b..44062e9d68f0 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3640,9 +3640,6 @@ static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,
>  	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>  	int err = 0;
>  
> -	if (group >= MLX5_VDPA_NUMVQ_GROUPS)
> -		return -EINVAL;
> -
>  	mvdev->mres.group2asid[group] = asid;
>  
>  	mutex_lock(&mvdev->mres.lock);
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index c1c6431950e1..df9c7ddc5d78 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -606,12 +606,6 @@ static int vdpasim_set_group_asid(struct vdpa_device *vdpa, unsigned int group,
>  	struct vhost_iotlb *iommu;
>  	int i;
>  
> -	if (group > vdpasim->dev_attr.ngroups)
> -		return -EINVAL;
> -

BTW is the original ">" here an off by one error? Should have been >= ?
if yes then this is a kind of bugfix and maybe needs a fixes tag.

> -	if (asid >= vdpasim->dev_attr.nas)
> -		return -EINVAL;
> -
>  	iommu = &vdpasim->iommu[asid];
>  
>  	mutex_lock(&vdpasim->mutex);
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 05a481e4c385..9d25b735b43d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -680,7 +680,7 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  	case VHOST_VDPA_SET_GROUP_ASID:
>  		if (copy_from_user(&s, argp, sizeof(s)))
>  			return -EFAULT;
> -		if (s.num >= vdpa->nas)
> +		if (idx >= vdpa->ngroups || s.num >= vdpa->nas)
>  			return -EINVAL;
>  		if (!ops->set_group_asid)
>  			return -EOPNOTSUPP;
> -- 
> 2.52.0

