Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E9D4D8CC
	for <virtualization@lists.linux.dev>; Fri,  2 Aug 2024 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722604485; cv=none; b=QldfNEfj/kOG5VxzEartLxTgPiXvjpPgwXDBKws9r2Lp9VHRwuLYSjC/Xec5BzOtNbk7l+I4x32n6wGRFRNL2OqCnqN216uaQ11ti8t9vi0kzlTXwhm8yjtJegwuZ8Auyob2ugOhZ7BuI4GrQWh7esc7IziGcULCLu0DXdLVDTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722604485; c=relaxed/simple;
	bh=mlVHMMZEWCwegHzSZJoPrbG16hagpjxEFmlG/bPjAc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nlKh5GuzuNtW/BzSPHhOUdbXtbmebeAB96R4Cbm7BiqzJcd4zxDUgrXZmb1pb2irsNC8MhFTdxtMRkyPI9w1FJre7si8Wqir3Wy41uXC5XBuRoQVLWTC9xKC71MSoVHtcRRM2BtqLsOCzwT1yfopVW0VBqGLCezXcUG5ESOHCCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vqc87/ps; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vqc87/ps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722604482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5G+bWvjkV854PGv5nQauKmV3J78os2SxWsQ3vifFpzE=;
	b=Vqc87/ps4K+/6g3OlrtyJ38wctRreGnEisPZKgTeVERxLMrx7VEnM/qfTbFOYFToKDNmzx
	FeojJ7XgVGm7MXCYXdNAJkPH22mmXGwGXI5JrZykLpoIILBEUQT3MaW42CFeBHhbiFqB6Z
	Qx4NjMVW4yDjrnFXnQGSznI31jwrRL8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-PLp86FtwNlqf7IAJ0o6rng-1; Fri, 02 Aug 2024 09:14:41 -0400
X-MC-Unique: PLp86FtwNlqf7IAJ0o6rng-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-428ea5b1479so5547695e9.0
        for <virtualization@lists.linux.dev>; Fri, 02 Aug 2024 06:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722604480; x=1723209280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5G+bWvjkV854PGv5nQauKmV3J78os2SxWsQ3vifFpzE=;
        b=RLbJTOuiGOmLdBTgsRftvp+W/yxYxIaPnrOI9F7J258B9omonD/eWdO6gMDvv1kmgv
         cCPWczspHpfDoxxN8D3LCXjj/UhYh/XYw74uFVCyNvq2PjBNw7/aVXqvbgHb1dvFNfCT
         TCB5UZMEoYKffg4j+HGbl1u1M5bAdRLgATNmbqqv/dakK1lEqQGfbveiuim7paYZ+9XG
         zNQhuoEJ0Rg4aQkncHFM+ptQvXaFVc94wZTxpfvBuWFI6znWzYqBNj1F5m8M36IJNT1Z
         RXO7od5/4S87H8Zz0m+ikxQYx3PoJJ9LZcPprYWmPldu5WSzy0mT/5yYALb2+KveQTTF
         0NjA==
X-Forwarded-Encrypted: i=1; AJvYcCUlHZz3QBjEnCmLTFzQ0g9MXp0pR2DDs9YfMExhChAaLFi5ammKKxv7uZOd7AdotyBumKId/omDm/MLn6QH2Uu5lOHg4Ls5uk4ErAbzZUU=
X-Gm-Message-State: AOJu0Yx75FNssohr4EvgE+S/IaZlKgg8KtFcXIkex9LtCD1rZYtavgss
	SRJm3C98mE7pH5Pp8U+mLrXgXojxKWhES8EnIObiBGux2kSRYBWl2oa3Ygxv9E8mNAEMii7ugqB
	T1mm4ogmlShkCCoEBh4Hwf5AuXYkT0WMSyxsEvWX8rt5y0qjFKGc8Vhl0vCUoWQHN
X-Received: by 2002:a05:600c:3b27:b0:426:593c:935d with SMTP id 5b1f17b1804b1-428e6af7aeemr19557175e9.5.1722604479663;
        Fri, 02 Aug 2024 06:14:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuRmjRgLKWU2y9r5mwZaqHkfa4aoDytkkFpO3vmjIpfmO1Id6emUqbDV3bWzmGUtUR32/LqA==
X-Received: by 2002:a05:600c:3b27:b0:426:593c:935d with SMTP id 5b1f17b1804b1-428e6af7aeemr19556785e9.5.1722604478820;
        Fri, 02 Aug 2024 06:14:38 -0700 (PDT)
Received: from redhat.com ([2.55.39.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb97fbasm95238665e9.41.2024.08.02.06.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 06:14:37 -0700 (PDT)
Date: Fri, 2 Aug 2024 09:14:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH vhost 0/7] vdpa/mlx5: Parallelize device suspend/resume
Message-ID: <20240802091307-mutt-send-email-mst@kernel.org>
References: <20240802072039.267446-1-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240802072039.267446-1-dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 02, 2024 at 10:20:17AM +0300, Dragos Tatulea wrote:
> This series parallelizes the mlx5_vdpa device suspend and resume
> operations through the firmware async API. The purpose is to reduce live
> migration downtime.
> 
> The series starts with changing the VQ suspend and resume commands
> to the async API. After that, the switch is made to issue multiple
> commands of the same type in parallel.
> 
> Finally, a bonus improvement is thrown in: keep the notifierd enabled
> during suspend but make it a NOP. Upon resume make sure that the link
> state is forwarded. This shaves around 30ms per device constant time.
> 
> For 1 vDPA device x 32 VQs (16 VQPs), on a large VM (256 GB RAM, 32 CPUs
> x 2 threads per core), the improvements are:
> 
> +-------------------+--------+--------+-----------+
> | operation         | Before | After  | Reduction |
> |-------------------+--------+--------+-----------|
> | mlx5_vdpa_suspend | 37 ms  | 2.5 ms |     14x   |
> | mlx5_vdpa_resume  | 16 ms  | 5 ms   |      3x   |
> +-------------------+--------+--------+-----------+
> 
> Note for the maintainers:
> The first patch contains changes for mlx5_core. This must be applied
> into the mlx5-vhost tree [0] first. Once this patch is applied on
> mlx5-vhost, the change has to be pulled from mlx5-vdpa into the vhost
> tree and only then the remaining patches can be applied.

Or maintainer just acks it and I apply directly.

Let me know when all this can happen.

> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-vhost
> 
> Dragos Tatulea (7):
>   net/mlx5: Support throttled commands from async API
>   vdpa/mlx5: Introduce error logging function
>   vdpa/mlx5: Use async API for vq query command
>   vdpa/mlx5: Use async API for vq modify commands
>   vdpa/mlx5: Parallelize device suspend
>   vdpa/mlx5: Parallelize device resume
>   vdpa/mlx5: Keep notifiers during suspend but ignore
> 
>  drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  21 +-
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h            |   7 +
>  drivers/vdpa/mlx5/net/mlx5_vnet.c             | 435 +++++++++++++-----
>  3 files changed, 333 insertions(+), 130 deletions(-)
> 
> -- 
> 2.45.2

