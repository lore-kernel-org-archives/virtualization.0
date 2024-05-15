Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C748415B0E3
	for <virtualization@lists.linux.dev>; Wed, 15 May 2024 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715811445; cv=none; b=s4oL53g2E1UJuIieocz4u8UkGVPNmdzJDqUaL/TXZbtffOgpSnC2VYyvsz+EqE2nG5d2lJpeJix3bUP8WXgmioo93l1r4n8SvhT/msc1MXAVWO9ixVngG2ypiFA4D9vokiPDTw686el6FwQ+SlZQ+2tdBl9kOuldtmdpU1vLDOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715811445; c=relaxed/simple;
	bh=5Lb04IOxAFHZl0H1mV+xBky+LXkYjevp1pkg8SVXj0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ohXFOTp9Eq5gJ0hXLJor5nosMRbyxCW+C+pfDIKDm5WyTTVnQQPxf1tg9kNWXzlsCU5NQ1QinadN8D6beRmqJ0T/zzSq0aBOY6sCg13nWExRU8GSGE5wQ7k8+adjvKOlEQNEP2q8BQ9Fiog6262LZDKqATBy4iPDw5gC1nGcTIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmmB9soO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmmB9soO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715811442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EZN0wVmWs2EnG1RV9I+3ErWKTp5IW4jpo10Yojdq8Hs=;
	b=KmmB9soO/Z56jun/aXSGvmVANSmB8rQfp4nDkpOUiD1/mF/xhybM2uN5/IbUofO3kxEPZX
	snKKBG5cduWqNwuWZeLTbHqy41vRlIfu7Jxn5vRy6XWJiGLRy0pgo2o3U/CuE+IcoAVKOs
	c/xJKZH9mxBXyROmuO6mpPLX1Gt73e4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-MIDpFTCLMHm2_-qStJl09w-1; Wed, 15 May 2024 18:17:21 -0400
X-MC-Unique: MIDpFTCLMHm2_-qStJl09w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4200e6a9901so27328675e9.3
        for <virtualization@lists.linux.dev>; Wed, 15 May 2024 15:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715811440; x=1716416240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZN0wVmWs2EnG1RV9I+3ErWKTp5IW4jpo10Yojdq8Hs=;
        b=hyOTT2S3ai8NmA0fni33a/2EMFg1O6pzHhy84TXcTfQbMpp/YXg49ynaz8gZ4jsKUE
         1Hmf0guQ7cx6aB0G65p9feZb49UYv6SB6i3GBM9G8hHX2gIlQgQ03mhjDgVsd3pA/TJ0
         op8W4BRwNne+PN6MMGnhh4nGO+ITQTN3NzRP6q+u1IH/wcEeJVMtIoTnqjlWFB431++B
         H9R4Z9AqCSUhFsvmsOUfwmrTuAHU7bXT7ZEB+mxblhNh35BluzUD87JOqiKASuc37uYa
         OMymDWiVDmyokoOzyqa1wyHok4tPzfrEPsSAsQYh4ImY6ZC25QMJ48FLDj3dTah0iHRE
         5f0A==
X-Forwarded-Encrypted: i=1; AJvYcCUjWIWnYnD+xA0fALwDhgw9WErK/VO4QWFTQzV73vQPQfS9KSqjMXPdupkgnhfpiOUu6KWmi1M+zvaET4PRvlnZI+rnZDhoY3ovmAEnOyk=
X-Gm-Message-State: AOJu0YwziucUZIzlSE4SMJK8xgJE4WIl0NIlWjF/ugmviJbnwW/xwiyo
	SRVRXgVS3Y5WbHcCofUidj/RWY5b3v/qRHnB2fbsCrqLSDNud4vFBdwOe52oa6aVPhZo1UJrI5r
	g5yk1o6spAP1Lq9mP20MPdeSi/825IPyx3hyxKkHRJ54eo7b16tl8ZzONIp82BEoN
X-Received: by 2002:a05:600c:4705:b0:418:f5a9:b91c with SMTP id 5b1f17b1804b1-41fead65a1bmr116997825e9.33.1715811440029;
        Wed, 15 May 2024 15:17:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5P3/Oya1xRhWyAyXMJIMSfGyBGzEjtt1Hz1ue8IRQmpEkMwr+1aF7P3KXgLTzDOVE/m+eeA==
X-Received: by 2002:a05:600c:4705:b0:418:f5a9:b91c with SMTP id 5b1f17b1804b1-41fead65a1bmr116997725e9.33.1715811439493;
        Wed, 15 May 2024 15:17:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:443:357d:1f98:7ef8:1117:f7bb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fa9dbab53sm260530495e9.13.2024.05.15.15.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 15:17:19 -0700 (PDT)
Date: Wed, 15 May 2024 18:17:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jiri@nvidia.com, Eric Dumazet <edumaset@google.com>
Subject: Re: [PATCH v3] virtio_net: Fix missed rtnl_unlock
Message-ID: <20240515181647-mutt-send-email-mst@kernel.org>
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

net tree I presume.

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

