Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E1F155752
	for <virtualization@lists.linux.dev>; Wed, 15 May 2024 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785671; cv=none; b=PjtcTCPkXQ4XVySzYqgnTa7ZgTqlUqc9sYfB+FgosfZ/nIU17mLPWUMySVGpsaESRHVJUPg/hYuYm/HxNttb9huntpKuosBXkAzBhuEHqRhwA12+dwBvV91KlSgbcI+e8ItSbNinH3JgA1Y8edvKqG5W3J9I6ZWRGK7uL1TENek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785671; c=relaxed/simple;
	bh=4kwqZOsHkHkC7vF55q95cqcIf9m/KCYHiCaiDGJADbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=i+3rLyWKJM4+cPxyv3f/fWHfU4SCxwWDZZDdn/DAp1RKtUYiw4PJFH/KMbSLU52hNKl6SYyX/hu32EWR4oegkZwUYtPkDa8MniVt7paem5k+NJ2Ar4TgpTMpAe9Ebbm8niK2EnFFlNN+lpetD9DEXbasdcDHoe6NtPV8jRDKJtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=adAl7wVU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adAl7wVU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715785668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Y5LmjyinNpOK5AewP0EhrT5FIK8gwKzGrfp3dWcri4=;
	b=adAl7wVU1sPZKVaJ7G70pUNsO70jM4tF5Aot5OzQTOQpTi0wFFfUbuUHl/g/vjeCDMS9I1
	cLsGSksVcJI+OyWoxf5vXCzCkcjlnUQ+WXtByRzDJ+6AG44C7lwRXzMcwyiVRvCoRRg/Ay
	8eClWQHil1VklFrFLYec4AvYVNnu3co=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-y8h6By54OS6-EOqRXV-QaQ-1; Wed, 15 May 2024 11:07:44 -0400
X-MC-Unique: y8h6By54OS6-EOqRXV-QaQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41ff1a36e7bso41080275e9.1
        for <virtualization@lists.linux.dev>; Wed, 15 May 2024 08:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715785663; x=1716390463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Y5LmjyinNpOK5AewP0EhrT5FIK8gwKzGrfp3dWcri4=;
        b=atHswc4odlqf4eJw9Av4VbUIWbo09UBp9SKfPLb5AAnEs7vcVkrrt//IYUoFx6dqmY
         87Mr1znU+mWb3y42E/1Rfg2GzICfX2VcPJsAECDgN/+RjHQ0vcbYMZjRfWshBXPwPxk7
         UorohCcqq4ZliF9ihsu9fI2JWCN52apr+ErfyNLGSmfD/5aCS4TFo6MkKCn7w7oFCVqS
         eJufT9qZX86bxkN1g4fcD3NBSa5V6WpwEpKAvpAx1aqZQe2uoqLfIZNqUEoP4udxce3Z
         E59IjmbkArO0+eYDDYfs5x3MOj2snPyPhm4vSVK99yNW1am6edriUOm7QKDUEC/1WOZ0
         mbXw==
X-Forwarded-Encrypted: i=1; AJvYcCXGCooTeVNVzE8LNtl7+HK1EFcRDq2TFc9BBjhGAXz0LKagE55L74sLzvTq5ob+KS7YL0d2xtbdCfaQrHF4ruz390pvd7GQp1oiOeBjBzE=
X-Gm-Message-State: AOJu0Yxp3kmkzWbG6W1NJIxD3o4ghbFX1B4HVuhdTL3fivo9eGA8aSOB
	8EkKre57O3Bz7Gec/M7wTWXHw4IKXC6Ycs1wWzsvmibo7hXQD7Kcqwu1yCKmxga9TeQoDSa6Sr+
	fi0Gsi/W9PdnJzdaIqwWHIvkMakJyZqlwxkl9FJaLAVDoKfHIZXnSrywNKVBOLEvR
X-Received: by 2002:a05:600c:4683:b0:41b:f6b6:46cf with SMTP id 5b1f17b1804b1-41feaa38ab0mr142390745e9.11.1715785663276;
        Wed, 15 May 2024 08:07:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0UKh1tOV/wBnFRQ5wDIRuqGtj+ZtTNaCx+aXjZOOMmuWMYgdOY/ov/oV5PZgaLTL+EaSOuA==
X-Received: by 2002:a05:600c:4683:b0:41b:f6b6:46cf with SMTP id 5b1f17b1804b1-41feaa38ab0mr142390415e9.11.1715785662677;
        Wed, 15 May 2024 08:07:42 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:c01e:6df5:7e14:ad03:85bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b897e39sm16726473f8f.48.2024.05.15.08.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:07:42 -0700 (PDT)
Date: Wed, 15 May 2024 11:07:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jiri@nvidia.com, Eric Dumazet <edumaset@google.com>
Subject: Re: [PATCH] virtio_net: Fix missed rtnl_unlock
Message-ID: <20240515110729-mutt-send-email-mst@kernel.org>
References: <20240515143120.563700-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240515143120.563700-1-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 15, 2024 at 09:31:20AM -0500, Daniel Jurgens wrote:
> The rtnl_lock would stay locked if allocating promisc_allmulti failed.
> 
> Reported-by: Eric Dumazet <edumaset@google.com>
> Link: https://lore.kernel.org/netdev/CANn89iLazVaUCvhPm6RPJJ0owra_oFnx7Fhc8d60gV-65ad3WQ@mail.gmail.com/
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>


Fixes: tag?

> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 19a9b50646c7..e2b7488f375e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2902,14 +2902,14 @@ static void virtnet_rx_mode_work(struct work_struct *work)
>  	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
>  		return;
>  
> -	rtnl_lock();
> -
>  	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_ATOMIC);
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

