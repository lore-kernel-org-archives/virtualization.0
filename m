Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B5218929
	for <virtualization@lists.linux.dev>; Thu,  7 Nov 2024 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016223; cv=none; b=LFHrgt95hJiBRgp69PUjvYePM5PJgmOeG4274GBBG2IPoPFh8AYHauaawgExX0c6wfTdMiPwO6flu2vjhKKeTD7Ww3mtwom7CCnEAe/bMt7UmkB95c1tiE87kMpr8dNiAcYMeJOa3RUMxH33O8ZJ9QuDS5UvhEssv5eqAzPJnG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016223; c=relaxed/simple;
	bh=pst33w5MBGaHwFI2CZYkiWO99oANTIkX7lPh4MyoqE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RupJhplLNfFHNre5xVpKYV2fu3I6n/apJu5uaHaOWaqXJbZfftDkG9RokklyTYhqfP1gEl2HOaMu39+GDCFpNH98k+UBckSJ/H7oaJim/iMQpC143mCTGzjzONiQ1AcGkVcJlRNqMIgqCC3fZ4EqMYGpRdmDar/jLqtYRWpKRNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jeu5yRzh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jeu5yRzh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731016221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l18LLKMDfqxNEVCeijQW2WIw0xKoPj/t5wcWlYhyNaQ=;
	b=Jeu5yRzhjtRZ8nl6woOGXjDM6X7Lq0TB0Ts5QSt3QTiphAO3hLbeLmMX/jYz8ZMUHrgalW
	2nFJkwOKMXbkEGqzjSfzaPgUSPWhhLP4piv0ORVyfx4lBtt5Lkz6o87X/7GWVQtpQWec1A
	Yn+y2McvG+ervJ/+53KD4CIR69Eoq3w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-KDBZpCnvP7283mDgwMVGfw-1; Thu, 07 Nov 2024 16:50:17 -0500
X-MC-Unique: KDBZpCnvP7283mDgwMVGfw-1
X-Mimecast-MFC-AGG-ID: KDBZpCnvP7283mDgwMVGfw
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c95ac2d13bso1021837a12.2
        for <virtualization@lists.linux.dev>; Thu, 07 Nov 2024 13:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731016217; x=1731621017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l18LLKMDfqxNEVCeijQW2WIw0xKoPj/t5wcWlYhyNaQ=;
        b=l4wHIdFsQajV0GpFVCFBGAw68aEfiF8Ii0bbkJY/2stCLWq85YRV3RqG0tpEnsGU3A
         9wvxbkH3v6vzAA2dTSzLtsKLDQNW+RRo1tHWu5gWQCIyuypRa7c2jI4lCj5IaVSmfjOH
         Lh312TphPiSsicTUrUJxTwUlu1YFrB03GVQUwnOsG9BGpDKSwacoldb0bJ+HR2SYWTUD
         gGh5DtMv6lrwK+BAAJsQgpoO2vqlGpxoDyKshHVIp14ZmTA0Hz7VU7jvFZcmtoWf8x/j
         Nwc/NMNLe3rlaFkt26zJnTIGOgYL0MXuGoMOsMc1uNBEKebqeh/IifrNpiwJomD8bymC
         4U/g==
X-Forwarded-Encrypted: i=1; AJvYcCUUTvI1T680jE/CM8bYgZSJ7a8PxsWv3SeO8P2vpZXltJMwywDsGNATIdaHjPAsLmpshhslFquiBOg6fr7DMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyXgODKjOXNM9HDJmkVvrsvxmZUktXdiuBxNUxH0DvOLu8Dutk
	g9uxZW6tdkeJVpU08m6i09UKA0a0NEZIm16zfJ2vTbdN7ArRZqnZxMwr4jDRpb/tzB9S4VEt9VO
	kxB98GpQ+kJIpzMzhekodDEggiFWqkbohirXjPzDbOu79QUvFZD2Apa6sV3pp7qcw
X-Received: by 2002:a05:6402:2744:b0:5cf:c5d:3821 with SMTP id 4fb4d7f45d1cf-5cf0c5d389fmr236594a12.32.1731016216601;
        Thu, 07 Nov 2024 13:50:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6nDc50TzAQL4eJHDTWajE9g/rEFVvsViceWaZynJTGUxmlB32dBLzNO6F7e97OIiqtIhyXg==
X-Received: by 2002:a05:6402:2744:b0:5cf:c5d:3821 with SMTP id 4fb4d7f45d1cf-5cf0c5d389fmr236573a12.32.1731016216212;
        Thu, 07 Nov 2024 13:50:16 -0800 (PST)
Received: from redhat.com ([2a02:14f:179:39a6:9751:f8aa:307a:2952])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf08ca5bdesm439054a12.11.2024.11.07.13.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 13:50:14 -0800 (PST)
Date: Thu, 7 Nov 2024 16:50:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: dtatulea@nvidia.com, jasowang@redhat.com, shannon.nelson@amd.com,
	sashal@kernel.org, alvaro.karsz@solid-run.com,
	christophe.jaillet@wanadoo.fr, steven.sistare@oracle.com,
	bilbao@vt.edu, xuanzhuo@linux.alibaba.com, johnah.palmer@oracle.com,
	eperezma@redhat.com, cratiu@nvidia.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Carlos Bilbao <cbilbao@digitalocean.com>
Subject: Re: [PATCH v3 1/2] vdpa/mlx5: Set speed and duplex of vDPA devices
 to UNKNOWN
Message-ID: <20241107164932-mutt-send-email-mst@kernel.org>
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
 <20240904151115.205622-2-carlos.bilbao.osdev@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240904151115.205622-2-carlos.bilbao.osdev@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kmfAQzh9Rw5D85Axdm8TWnKA2RP-ayw7PeLDmHILRsI_1731016217
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 04, 2024 at 10:11:14AM -0500, Carlos Bilbao wrote:
> From: Carlos Bilbao <cbilbao@digitalocean.com>
> 
> Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
> This is needed because mlx5_vdpa vDPA devices currently do not support the
> VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex.

I see no logic here. Without this feature bit, guests will not read
this field, why do we suddenly need to initialize it?

> Add
> needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.
> 
> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index b56aae3f7be3..41ca268d43ff 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -173,6 +173,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
>  	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
>  }
>  
> +static __virtio32 cpu_to_mlx5vdpa32(struct mlx5_vdpa_dev *mvdev, u32 val)
> +{
> +	return __cpu_to_virtio32(mlx5_vdpa_is_little_endian(mvdev), val);
> +}
> +
>  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
>  {
>  	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> @@ -3433,6 +3438,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	init_rwsem(&ndev->reslock);
>  	config = &ndev->config;
>  
> +	/*
> +	 * mlx5_vdpa vDPA devices currently don't support reporting or
> +	 * setting the speed or duplex.
> +	 */
> +	config->speed  = cpu_to_mlx5vdpa32(mvdev, SPEED_UNKNOWN);
> +	config->duplex = DUPLEX_UNKNOWN;
> +
>  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>  		err = config_func_mtu(mdev, add_config->net.mtu);
>  		if (err)
> -- 
> 2.34.1

