Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF2120FA9E
	for <virtualization@lists.linux.dev>; Tue,  5 Nov 2024 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838568; cv=none; b=D/Tz8DqPBnWG4JFN2XCa2Zl6005dE5mP6H+gY5dgM1zTM27U2iD7EObntyqm01ghBxC94wVHD9gkErw2/a51b4jskljxSQCIxEWIlj01l2F3ASobRaEHhre5BqdquNw5K4qtsqW4nLKeIiuxtCpGAY3EE6DYEDpGHuVnQFwjNX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838568; c=relaxed/simple;
	bh=d3dD1BAZxlbYeLGAcAe/6Ue5ouZ4MMP1Gn0DibkROqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTgF5wyPmocKjLQJUB5GkwN5Cyi6cPnUDmdGcH7AZrnlwfqmKu6l5sxYs42esz7ZXaWdHEReuh6g/sxJYNm/6e4snNloDtr4u99HO5HUbdEGTtgOi2GmSJaxCHu6QpC25zPttKi7wPkuMtFsBx1spJeGgtBiRDRhX3jRRp55r30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gxZLvmk0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gxZLvmk0"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c6f492d2dso64749455ad.0
        for <virtualization@lists.linux.dev>; Tue, 05 Nov 2024 12:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730838566; x=1731443366; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TG+HKfsXVndr/dbdsEdQzVp/Dckr4A4PHVsSxF6U0c=;
        b=gxZLvmk0jllOkwkbrgEjNlawz4RIJiAEtOCgCJmlS39h68YGztLlIirXvwWIKa6HUc
         Lr+ETgLHm4OQBfn6THkSM85wIchkJq3C0SZ1WyW17f0fa6HN2kp0rWcJd3Jupety/fPz
         EQSE+Ck3fhMmClWDYYgz49d4InVM/c8vkJJU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730838566; x=1731443366;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TG+HKfsXVndr/dbdsEdQzVp/Dckr4A4PHVsSxF6U0c=;
        b=ZR7RrGkrYgpu5UtZ/3I3OFxiLNzMtvtzWE8xOMKs4sBDtY8N9QGE3+sVmMbJverZT+
         S6o0UhgLWB/wAgsad0Nt7/QuXtOsTK2+HXgqEs/w/eFIgM7PuGQr0hXEjBeV7qO/kw74
         aYEeTCWZv5bl/8XxzEAaI2WAf8UMghtFBCDGpaFIbnFR+YOmzfFyrJg8mX2t36u63+a1
         Mz2eJqfPdO2nWmiL6Vil6mGRlhhGDn6Papl4uc39TZI9z6//QC+LmAgXtsZ49Mv69lil
         U1DJufb2DKF8QS2iVWTMfaDMGZ51C/xP/T11q1n6ukZ0ft4yzY2ph5UdXkTUZf6ZSiAw
         wpyg==
X-Forwarded-Encrypted: i=1; AJvYcCUf6m3vg97+GaAW3IrXqYbvDfXHwOn0LMMiA+Y2fZFJ72/VAJNMoisVumcO2G1ewpFjQldZ0N9cjFqemDEXYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9tOg6HqLyjhdEonEdCg2A6WkX9DgOSz+jqLa2559dDf384u6U
	Dew5n3S9JVUYS2vgcTDqie9bzbVcEbRw1/ujDFNXNNNxue/8Ni3kBoNIzAA84Yk=
X-Google-Smtp-Source: AGHT+IGpXvnQLdYM/eNUxgFErDh6D1tC1fH+hd2J2ncskN5f6MUlUmoouPD6XNorFgW/ypBKExow4g==
X-Received: by 2002:a17:90b:2781:b0:2e5:5e55:7f18 with SMTP id 98e67ed59e1d1-2e94c2e77f5mr25127221a91.24.1730838566657;
        Tue, 05 Nov 2024 12:29:26 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbfb05asm12412856a91.48.2024.11.05.12.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 12:29:26 -0800 (PST)
Date: Tue, 5 Nov 2024 12:29:23 -0800
From: Joe Damato <jdamato@fastly.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew@daynix.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/4] virtio_net: Sync rss config to device when
 virtnet_probe
Message-ID: <ZyqAI--BgVBo1Kt1@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew@daynix.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
References: <20241104085706.13872-1-lulie@linux.alibaba.com>
 <20241104085706.13872-4-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104085706.13872-4-lulie@linux.alibaba.com>

On Mon, Nov 04, 2024 at 04:57:05PM +0800, Philo Lu wrote:
> During virtnet_probe, default rss configuration is initialized, but was
> not committed to the device. This patch fix this by sending rss command
> after device ready in virtnet_probe. Otherwise, the actual rss
> configuration used by device can be different with that read by user
> from driver, which may confuse the user.
> 
> If the command committing fails, driver rss will be disabled.
> 
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index acc3e5dc112e..59d9fdf562e0 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6584,6 +6584,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  	virtio_device_ready(vdev);
>  
> +	if (vi->has_rss || vi->has_rss_hash_report) {
> +		if (!virtnet_commit_rss_command(vi)) {
> +			dev_warn(&vdev->dev, "RSS disabled because committing failed.\n");
> +			dev->hw_features &= ~NETIF_F_RXHASH;
> +			vi->has_rss_hash_report = false;
> +			vi->has_rss = false;
> +		}
> +	}
> +
>  	virtnet_set_queues(vi, vi->curr_queue_pairs);
>  
>  	/* a random MAC address has been assigned, notify the device.

Acked-by: Joe Damato <jdamato@fastly.com>
