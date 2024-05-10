Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2CC165FB0
	for <virtualization@lists.linux.dev>; Fri, 10 May 2024 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335653; cv=none; b=kI7N33TUP2k4jcrVD/jovuoryGEPUQnBT9bVFac369IrO1w+AEIF2x6ZIy8F37/aKLy5SjmcU6LEd9LVSAMAYYpgvTgnuPFG2VRKzMTcRWIPr+IMhYnEZB1sBuKf9W43q7SPa3zl9Xx7uQGZXV4i0yyDky7Og73fY3I0wWJGcs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335653; c=relaxed/simple;
	bh=UzzrEAXXC7GjB0UzWHaGTus02kqoHPT2GIyFF+3NxgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bnHlFfwaWM6zBjotvETvKurUAlVMAG+yBNmCdUzCOcEPM02NdrzXdHuMb0qQxl6rDLCx/laucvNCoJ7W6JdL0x91hIvYLXsan+CzzdrfTceSKyIKqvA1Vm1PIe8xrvxDfiW+dLpvcoaaA/4wMkWbUi8ijx2wdxNvU9chAUVhDrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c46VoFzV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c46VoFzV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715335651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PU1jXrUxZHpWqbXLAeWI4bSbPEiHk/0IQA0hXmx3ydw=;
	b=c46VoFzV3dcGT6PtuhmcJW8DyEFutagHlKjtt3tCmotpPwdvcNBue6OytmjiCMKoLcBX21
	JWXv5vGC/9qhZbrmLdUHltaHM/Vh697bPZ/I79F529uXx3QKN8HQ/IBHpE30SwtsXk/f8o
	cxqN0zya0VbANallAt0EHzuMtdLNFok=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-39FTVX3-PJ64pF68-0buEg-1; Fri, 10 May 2024 06:07:29 -0400
X-MC-Unique: 39FTVX3-PJ64pF68-0buEg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2e5225e937aso6472521fa.1
        for <virtualization@lists.linux.dev>; Fri, 10 May 2024 03:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715335648; x=1715940448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PU1jXrUxZHpWqbXLAeWI4bSbPEiHk/0IQA0hXmx3ydw=;
        b=K8V5M2nGiEexFgYFwdIEn+PnN4R0ZPIsFYlFwbCVuyZMKewkPhiL7oOcgO0xgJolYQ
         Z/yGnhF5I7usMg94xLwCukjLD3wLt6t1osY7z9jSZTHkAySSq7gG2S7cVTifPoSa6KjT
         bSzSnjXlHDF9/XPRCeUtKsDON9cBaY1PFO0QNVvkLlHPur+kFeb7lzyQAbAjLblV2g71
         EfyYJ3s596NWLIHFfbOPqAaNfQGpEn2uTI5jiHhvZYA/4LaUVc5+r66dXgTvpC4ZfnSR
         6pM0jwyGHPwRlFdd5oTEv/i2+VmKUSjldIJ2Z0DAVMRDg1bSM9mO+A+S6wU6Huch20mn
         lxfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8DQNLP7ASgrP10SjTN0M2yqzTayE7jp15MOaH6ijk4n7TI1X1iRtBm5T3tabc55JK2gxvOVZCkNUaAkykp81C0ALjccTYXd5qVpOHTEc=
X-Gm-Message-State: AOJu0Yxy8L4avXPle5RDD5LPLJmIeUaoK7OZxk6jOlTEV/G68ZzGnlpl
	D5iBbeqb4Xx1kivLIdCWwE0l2Fcn68oRc8RAs6LKgP5hxi+nss73CUQF4xSkEJzfBFykqtdcWIc
	S92ZjL2bbf/qzCWuTnK7yKaUzK2oYoJtPfkGMldTWVlF86Rr6mdKd4GAsBBuBUEHf
X-Received: by 2002:a2e:9584:0:b0:2e4:9606:6b88 with SMTP id 38308e7fff4ca-2e51fc36498mr13732001fa.3.1715335648259;
        Fri, 10 May 2024 03:07:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXKNWD+EFdcSFAS5T5UD1yMpgsUDi4mA7kwfVGY9LXB94v/2AnWVsvufoI3+85K8YrZW3SFw==
X-Received: by 2002:a2e:9584:0:b0:2e4:9606:6b88 with SMTP id 38308e7fff4ca-2e51fc36498mr13731841fa.3.1715335647614;
        Fri, 10 May 2024 03:07:27 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7408:4800:68b:bbd9:73c8:fb50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccfe1277sm56451675e9.42.2024.05.10.03.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 03:07:27 -0700 (PDT)
Date: Fri, 10 May 2024 06:07:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jiri@nvidia.com, axboe@kernel.dk
Subject: Re: [PATCH] virtio_net: Fix memory leak in virtnet_rx_mod_work
Message-ID: <20240510060716-mutt-send-email-mst@kernel.org>
References: <20240509183634.143273-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240509183634.143273-1-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 09, 2024 at 01:36:34PM -0500, Daniel Jurgens wrote:
> The pointer delcaration was missing the __free(kfree).
> 
> Fixes: ff7c7d9f5261 ("virtio_net: Remove command data from control_buf")
> Reported-by: Jens Axboe <axboe@kernel.dk>
> Closes: https://lore.kernel.org/netdev/0674ca1b-020f-4f93-94d0-104964566e3f@kernel.dk/
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index df6121c38a1b..42da535913ed 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2884,7 +2884,6 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  
>  static int virtnet_close(struct net_device *dev)
>  {
> -	u8 *promisc_allmulti  __free(kfree) = NULL;
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i;
>  
> @@ -2905,11 +2904,11 @@ static void virtnet_rx_mode_work(struct work_struct *work)
>  {
>  	struct virtnet_info *vi =
>  		container_of(work, struct virtnet_info, rx_mode_work);
> +	u8 *promisc_allmulti  __free(kfree) = NULL;
>  	struct net_device *dev = vi->dev;
>  	struct scatterlist sg[2];
>  	struct virtio_net_ctrl_mac *mac_data;
>  	struct netdev_hw_addr *ha;
> -	u8 *promisc_allmulti;
>  	int uc_count;
>  	int mc_count;
>  	void *buf;
> -- 
> 2.45.0

