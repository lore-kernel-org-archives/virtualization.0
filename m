Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F917462
	for <virtualization@lists.linux.dev>; Fri,  8 Nov 2024 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731066719; cv=none; b=eYRyBz6fYinEKY7gE0rigtIgu3QbOeWEZWDPm3wuFgfS61KppCytaHkpnZluI6zAGdj7CaNbRRoVuJ3QNxy/AZd9B8DuPRRgfuqKZBGA9Ex1FKz/Y4NnV7A0Klk9Mz7xkh4bo79Zq90hrKDGRP2mChQ2X5SHHV6gcp6CQNneRfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731066719; c=relaxed/simple;
	bh=IdemLiGe2lleN2NhPFCYNBCFN+rRsyiDuFSx/WM/0Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SQ+OwFoUjp4Y4Hh2RGdVpB3j3LaTMly1AbNVv2+Xi8XQBigEa7STC8hKX7bXs092/ZiMXp8oUPZ9Hmx4iYQHyC64Gd5HkTVi4PeRNpoIUXvdp+WaoLXVDgR/UrAZWkdUtCFkHJd9dgwq/sTixSIcSv4LTm8DlaKFla9NRlonSIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5KCi5rn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5KCi5rn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731066716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RVMdf0uo3gDNaUoTkIjmu00DNjqcMxBxoCSu1o0JEIg=;
	b=K5KCi5rnoIZ16Bjzzwm++yeVVYaTuj7mHd+f0733EiYiag7FCwlXsVJfvHBwh/jDEjqE77
	h1UeTjhqEoLTQ/6NSqmmCsOfy8RNa/15RnKJJSquV0jhJ7Bn1myTBbTqyyLKdVncIPqd/h
	nPRTDm41koo7tAOarCmu5AlfLHN7GX4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-9FoNqrcjMWySF3LTIyNEiA-1; Fri, 08 Nov 2024 06:51:53 -0500
X-MC-Unique: 9FoNqrcjMWySF3LTIyNEiA-1
X-Mimecast-MFC-AGG-ID: 9FoNqrcjMWySF3LTIyNEiA
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c93572b437so1603369a12.3
        for <virtualization@lists.linux.dev>; Fri, 08 Nov 2024 03:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731066712; x=1731671512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVMdf0uo3gDNaUoTkIjmu00DNjqcMxBxoCSu1o0JEIg=;
        b=EPFC0EdSguwTKr7fAtjpmvXupdDYVY4ccUPyITx4zDxVug8NOHZmO750n5IgvIpTsj
         QTFfCgFP9U9dF2QmwxHclqFm3D5F9bRt+Effu0V9F6/Qr706pDeoGdkmHdEuuJmxJoRe
         4iNEIVj7Wax3+JysHKEOrwcQ9mUeIjvTSJ9URRKrRYku7k+fciNqSZzui+h+z1AzhZYL
         37Q4foz82phlwiKf44wcEvRTwBFERvn1J+lfChEFldPCEvp4h0T+8oWOAmeIBl4nq2FZ
         Lcd2Edz9++bcG7t27nP8xZw+1Qw5qYJnIMFfzZE79frBQ6DDn258B3Z449LkST9M5aBA
         LnHw==
X-Forwarded-Encrypted: i=1; AJvYcCUYr/ubP6r098MLTKla4BMlSyeFZArXV5WKGjRSn+CfenbvSWrXbIwqQRJBKanGiYz1U0XLvPnoEs507HPPSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZFlHTG81d1m89MbeUvBj6T0af77veRQxyc8OpEiClCIXVoiQP
	QRRmPSKMjoA8OdAiAatRdyafTANdETXfg8mvNCDnAFJzketd+/eaCDMXvTwbrMBm2kfmCZiG44f
	l4y6hJAvK3njETZ+2RHIN9IEHFkEMERqqKD6y4RExds7LjnW+x99taoqB1jFwhCSO
X-Received: by 2002:a17:907:8693:b0:a9a:26a1:1963 with SMTP id a640c23a62f3a-a9eefebd0dcmr232324766b.7.1731066711853;
        Fri, 08 Nov 2024 03:51:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFD0qTCLuzzpiQx4UleeDpBK4lEUwR0v0HeuCVIE9uNsxnMpSj0z1K6MCEU5lE8j24eebBDzQ==
X-Received: by 2002:a17:907:8693:b0:a9a:26a1:1963 with SMTP id a640c23a62f3a-a9eefebd0dcmr232321966b.7.1731066711377;
        Fri, 08 Nov 2024 03:51:51 -0800 (PST)
Received: from redhat.com ([2a02:14f:179:39a6:9751:f8aa:307a:2952])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4a995sm225542166b.61.2024.11.08.03.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 03:51:50 -0800 (PST)
Date: Fri, 8 Nov 2024 06:51:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, jasowang@redhat.com,
	shannon.nelson@amd.com, sashal@kernel.org,
	alvaro.karsz@solid-run.com, christophe.jaillet@wanadoo.fr,
	steven.sistare@oracle.com, bilbao@vt.edu,
	xuanzhuo@linux.alibaba.com, johnah.palmer@oracle.com,
	eperezma@redhat.com, cratiu@nvidia.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Carlos Bilbao <cbilbao@digitalocean.com>
Subject: Re: [PATCH v3 1/2] vdpa/mlx5: Set speed and duplex of vDPA devices
 to UNKNOWN
Message-ID: <20241108065046-mutt-send-email-mst@kernel.org>
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
 <20240904151115.205622-2-carlos.bilbao.osdev@gmail.com>
 <20241107164932-mutt-send-email-mst@kernel.org>
 <f1d671ff-0429-4cb5-a6e8-309a8567924c@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f1d671ff-0429-4cb5-a6e8-309a8567924c@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hMo8Lzkxirm_igVqr456HfY9qzDVTc4QZyIW_yVsSD0_1731066712
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2024 at 10:31:58AM +0100, Dragos Tatulea wrote:
> 
> 
> On 07.11.24 22:50, Michael S. Tsirkin wrote:
> > On Wed, Sep 04, 2024 at 10:11:14AM -0500, Carlos Bilbao wrote:
> >> From: Carlos Bilbao <cbilbao@digitalocean.com>
> >>
> >> Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
> >> This is needed because mlx5_vdpa vDPA devices currently do not support the
> >> VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex.
> > 
> > I see no logic here. Without this feature bit, guests will not read
> > this field, why do we suddenly need to initialize it?
> > 
> IIRC, Carlos was reading data via ioctl VHOST_VDPA_GET_CONFIG which calls
> .get_config() directly, always exposing the speed and duplex config fields [0].
> Carlos, was this the case?
> 
> [0] https://lore.kernel.org/lkml/afcbf041-7613-48e6-8088-9d52edd907ff@nvidia.com/T/
> 
> Thanks,
> Dragos

Basically, driver should ignore these if feature is not set.


> >> Add
> >> needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.
> >>
> >> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> >> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> >> ---
> >>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> index b56aae3f7be3..41ca268d43ff 100644
> >> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> @@ -173,6 +173,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
> >>  	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
> >>  }
> >>  
> >> +static __virtio32 cpu_to_mlx5vdpa32(struct mlx5_vdpa_dev *mvdev, u32 val)
> >> +{
> >> +	return __cpu_to_virtio32(mlx5_vdpa_is_little_endian(mvdev), val);
> >> +}
> >> +
> >>  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
> >>  {
> >>  	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> >> @@ -3433,6 +3438,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >>  	init_rwsem(&ndev->reslock);
> >>  	config = &ndev->config;
> >>  
> >> +	/*
> >> +	 * mlx5_vdpa vDPA devices currently don't support reporting or
> >> +	 * setting the speed or duplex.
> >> +	 */
> >> +	config->speed  = cpu_to_mlx5vdpa32(mvdev, SPEED_UNKNOWN);
> >> +	config->duplex = DUPLEX_UNKNOWN;
> >> +
> >>  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
> >>  		err = config_func_mtu(mdev, add_config->net.mtu);
> >>  		if (err)
> >> -- 
> >> 2.34.1
> > 

