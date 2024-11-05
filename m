Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22041EBFF1
	for <virtualization@lists.linux.dev>; Tue,  5 Nov 2024 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838515; cv=none; b=q+/wCgO9IoVHyGod4q2VNIQDOSedb37CuG6r44BTZlokFJmNJ7TlwOhJM3SyTPofuHKlMFOTnx9+lc+7C3jV/Y61yHDWvCZHndb7+wkfZ9MWli+96DKklvfVDlNF67j0yk32Jfq275zX7zfFUgFauyTdtAtRt8b3X1lHHdSF+OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838515; c=relaxed/simple;
	bh=r4wQnQB7TOhhaDz2m1Pn1z5j3SZx+o7iBbQS2F+6OQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bW7y1HH9vT+BqdgU9qTFdlheYNBJUaS12VkqKfWiQBm63hSaEzusHxK5Yom1iRUu5nhn/PWei0LkeRD2vzGH/Co2BwJBTbAlEjnVR5ex/Qb2Xvlpz/5PLPpVh93L79txLtSyRxrefafuxfmqRFRybsgQMijFufrUVU1yUwYpnL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CJlsrC7Y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CJlsrC7Y"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21116b187c4so42032835ad.3
        for <virtualization@lists.linux.dev>; Tue, 05 Nov 2024 12:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730838513; x=1731443313; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQeQW2N8zpTgfzsfBRysnSUZd8G5nyNGiYxO+3VjSwE=;
        b=CJlsrC7YsJK/5V973go8HB5bq8545GIvwG66EHDDZWkKQITZTEGRJ7TU4VOQH1/H3D
         uEwBNy4EGR6UsW79KhQtGkB111tj0Djjshvi5g7jJjwBOtPK8XoKDKNGLKmewi87v5QE
         g0g8tTxOKgRYWGkqFoBffIJkIsGOUd98ri1/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730838513; x=1731443313;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQeQW2N8zpTgfzsfBRysnSUZd8G5nyNGiYxO+3VjSwE=;
        b=u5liTfeHICaYxSCTbnFvgC/tHTxsNZWstVNeJr+QxVo3guTj8+AHjpWwVnu56kWmrY
         j0pjUGPVqX73wCSLiebL1jYNFAea9rXu+87Lv3H9W/ZVWV64vUfCTJelQkepws93QoBW
         rgAE4rJ1VWAiCxGEI6ICBQfk1+Bf/uaBj/iENJKrwpy+CKp4KnRmVrRw+tYFvaszgAFO
         PCdgARx0QBJ2jsuQ57qsjGtWrGQd1YHBKq0Mtwxg8sS0/0qrvEjQzUvoVwxSZRf8ab1O
         MV/CNUaYE12Q6Iixms5nsrb8QFFtrapMifiY0JtaTCsmdfJJ5wglxHcKzRlkoqgZLFKe
         Z+vA==
X-Forwarded-Encrypted: i=1; AJvYcCU6qvsrVvr2IpExSp3WCtua7UXU7UqV/PoDaCX8/sBJDm9r9YqGraZnqC2PaFxfEJmf2WAfs9+bfHFoJVrZkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNJbwc+4JZ3DrJldxkCs5WYYZpExRTOOn3CbBk6I3C7LtUb8JL
	2K1SN4WdRBToF78M8M0VH51Q67PjPoNbkmf9PY3NZQ/OjwXcJrepVmJCRuRy2Sg=
X-Google-Smtp-Source: AGHT+IENnWKhXsUeHfoWFHGstrsTSODyhq9Rx+TVaQWEQ9Ryh4qCgsEm60cTkPZKg6zj/kWO5fN5wg==
X-Received: by 2002:a17:902:ea02:b0:20c:a122:e6c4 with SMTP id d9443c01a7336-2111af3f634mr222617155ad.14.1730838513019;
        Tue, 05 Nov 2024 12:28:33 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2110570865fsm82537165ad.107.2024.11.05.12.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 12:28:32 -0800 (PST)
Date: Tue, 5 Nov 2024 12:28:29 -0800
From: Joe Damato <jdamato@fastly.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew@daynix.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/4] virtio_net: Add hash_key_length check
Message-ID: <Zyp_7ea-1F9VPEBL@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew@daynix.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
References: <20241104085706.13872-1-lulie@linux.alibaba.com>
 <20241104085706.13872-3-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104085706.13872-3-lulie@linux.alibaba.com>

On Mon, Nov 04, 2024 at 04:57:04PM +0800, Philo Lu wrote:
> Add hash_key_length check in virtnet_probe() to avoid possible out of
> bound errors when setting/reading the hash key.
> 
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 75c1ff4efd13..acc3e5dc112e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6451,6 +6451,12 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report) {
>  		vi->rss_key_size =
>  			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> +		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> +			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds the limit %u.\n",
> +				vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> +			err = -EINVAL;
> +			goto free;
> +		}

I agree that an out of bounds error could occur and a check here
is needed.

I have no idea if returning -EINVAL from probe is the correct
solution (vs say using min()) as I am just a casual observer of
virtio_net and not a maintainer.

Acked-by: Joe Damato <jdamato@fastly.com>
