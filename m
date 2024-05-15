Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0346C15B540
	for <virtualization@lists.linux.dev>; Wed, 15 May 2024 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715809382; cv=none; b=NpJT93snyeKReV5SDAHDeztQC/CkCnlU+YlmVqdl4AmiFEMZ108qNvMkvc646QYRWKktPTItetilJp2xBt9aXejLQXNtTzzJyxq9h1P53QpF8cf4+uVgCNgNPyn9LNSyEi4MLD69J09WO44Y1RYf0fTPRJqtIya94bcKcW/4gFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715809382; c=relaxed/simple;
	bh=PtK14fY1rMzkVkKJc7euI+0gYz8tpqvd3VtkvA0K1vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=g5/YOvkjZ9ujdmA7MDtrqQIPXrhHZOqt2RIXEkzcWHxib6zSmZtl4Rc86R9tfnY5OtTBTd4FvExNpWK3T8y37yQ00wYip8DGajLNyBDsvARNigFVuB1mUnAHvAVuuuCgY2xAF66U6PV6hD2gIHHkw1QZUwF7IihfsvGhbIQLAmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K0K6W5G4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0K6W5G4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715809379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfsV4L3uCM0qt/IKuOVeCHgH84Q1PpVaktQ22pA6gPE=;
	b=K0K6W5G4BpQvVEZsY9IVi9psHBUZGSThoj6So7mICZ5Sf22hnEWZLAocrRGUtHMU+j4/NM
	aJYxGtnIerFHhhcYdMCvCQZPGc69sE4KgNRoKpGA30uBLJ4l5hP09O4xRV2a7kuCatF18k
	WTbEmhNMQAWAEQbHm1oBsfYO86kF2pY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-AeQo-VbFN5ygqtOjn3TtxQ-1; Wed, 15 May 2024 17:42:58 -0400
X-MC-Unique: AeQo-VbFN5ygqtOjn3TtxQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-351d77e63fdso77853f8f.3
        for <virtualization@lists.linux.dev>; Wed, 15 May 2024 14:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715809377; x=1716414177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfsV4L3uCM0qt/IKuOVeCHgH84Q1PpVaktQ22pA6gPE=;
        b=A4JC9WPP6mB+00KFoF0Qnhe9nvPgLNuMjfDlrj7+rTTJS3ONN5LsPx172qUnNXrmVQ
         M/S4CA7GTzuC3Cq1N5Ng5qV5o7ioDQptTNA34fxE0oedm8Noj3Hsci74D+gyHpjsEGO5
         Q3vyG831ZaxPkhhXTXuoEN0ipkY4XicDHAMum2cyKxVzL1xrcPyaJVs9e4ix3vJQNDea
         F7joehDwAX4FV91v8sHHBNjM/Xo/NWk+qn1AXfaLMjaljy5C2BvOajDshVKH0kcPRZMz
         nF+CBPotXYGtN838Ng85cz3rT6M3EPyZIh0NxL0RYmuAKXlqZux08j3oKpMwJLINxLRN
         2GSg==
X-Forwarded-Encrypted: i=1; AJvYcCUeJlMmcVrsUXzCieBjBpzK31hUlC8MAcJGp4blXr0zvHp0nDgJpDo/3HKeOYumiMmLyjs4l6nrsZR6/Rk+P131WVTEdhMKEq/so8hcsDI=
X-Gm-Message-State: AOJu0Yy6eOL79nIOzxpoyY4pCZswnuuHnkfEOpzdI3dSc/EXOGJAvQt+
	J6BpU5jd3c8Rphoa7CWKV9+WvC971+gjYBJ5CkkxUia7FlyWTMCw51sGs+jtXo6aXUbn67rqEqd
	C5ZcC23pkUGqSqac7hyrRVXW+T/2j4qEcC1/ETAeDKzq2D9tYpK97qqphu4JAiulE
X-Received: by 2002:adf:e492:0:b0:34d:8d55:739a with SMTP id ffacd0b85a97d-3504a96ab52mr15997872f8f.57.1715809376763;
        Wed, 15 May 2024 14:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5vExwjG+ezOplBIzZSZDAIp3ZaPruBka2DhO/g/D3QX0xD25ZA2BfM/H4xr1SPHjrXyhbZQ==
X-Received: by 2002:adf:e492:0:b0:34d:8d55:739a with SMTP id ffacd0b85a97d-3504a96ab52mr15997855f8f.57.1715809376098;
        Wed, 15 May 2024 14:42:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:443:357d:1f98:7ef8:1117:f7bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896ab0sm17499202f8f.41.2024.05.15.14.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 14:42:55 -0700 (PDT)
Date: Wed, 15 May 2024 17:42:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jiri@nvidia.com, Eric Dumazet <edumaset@google.com>
Subject: Re: [PATCH v3] virtio_net: Fix missed rtnl_unlock
Message-ID: <20240515174242-mutt-send-email-mst@kernel.org>
References: <20240515163125.569743-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240515163125.569743-1-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 15, 2024 at 11:31:25AM -0500, Daniel Jurgens wrote:
> The rtnl_lock would stay locked if allocating promisc_allmulti failed.
> Also changed the allocation to GFP_KERNEL.
> 
> Fixes: ff7c7d9f5261 ("virtio_net: Remove command data from control_buf")
> Reported-by: Eric Dumazet <edumaset@google.com>
> Link: https://lore.kernel.org/netdev/CANn89iLazVaUCvhPm6RPJJ0owra_oFnx7Fhc8d60gV-65ad3WQ@mail.gmail.com/
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v3:
> 	- Changed to promisc_allmulti alloc to GPF_KERNEL
> v2:
> 	- Added fixes tag.
> ---
>  drivers/net/virtio_net.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 19a9b50646c7..4e1a0fc0d555 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2902,14 +2902,14 @@ static void virtnet_rx_mode_work(struct work_struct *work)
>  	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
>  		return;
>  
> -	rtnl_lock();
> -
> -	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_ATOMIC);
> +	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_KERNEL);
>  	if (!promisc_allmulti) {
>  		dev_warn(&dev->dev, "Failed to set RX mode, no memory.\n");
>  		return;
>  	}
>  
> +	rtnl_lock();
> +
>  	*promisc_allmulti = !!(dev->flags & IFF_PROMISC);
>  	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
>  
> -- 
> 2.45.0

