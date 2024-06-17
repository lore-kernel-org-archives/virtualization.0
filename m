Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6E516EB4E
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630722; cv=none; b=Zvrk2yyelpRAYMsaitA6Nohs05HbJ8O7g8C+Okx9IiMkNtN1VNYkxdihdMoFDkdDfHNM/l19O2L6khMT8hNnI6+vz1rkVU6s0tNyfi0UWvY+BoqXvq2a4tIcH1WsGbOiDPHhg3z2ERMIMUTJSFDLYYStwjXZTyUNVwM4RbIGcpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630722; c=relaxed/simple;
	bh=e0Ai7S6YQSXLPsDKMzDQYJxDo/I6cDjDA6YZygp1mvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FBhKOMzzWCLnuCb2wote9nkOLrwbR3E0cEH+wVxnx3yE0iWa4XWNFwsWVQntS4MSGRYwcJ5GBN86jwCgfuju/SGa61CzrX8sRz8KOhHwMNlJ9PMm7fV+indQ7BlvYTkQf9KYDdw7RwGMJbMb0qfHsTvc9Ic3iaDEbk1hk/4f3KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4Eyh/yx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4Eyh/yx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718630720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/S3QsnopAU1g3EZ48Lr3+KF/tnwo0ee82bp6T2xhvDs=;
	b=f4Eyh/yxkOSvgg2VCTOf5mHg9IcTjZ0DfGhSSbHtczTltR9jH5NWnAZmFhUCeEngeyw2hW
	GswFMNFmvcxpbfOM1Yc9v1accDLvQ2S1btjiX2URnXxRFjIke5ncpnAxcff0q5iaPEHUwA
	v4rSOomFMODOOC02gampzXcwRMyC6Fk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-SXX4bNlRMnOx-2p3wKliIA-1; Mon, 17 Jun 2024 09:25:16 -0400
X-MC-Unique: SXX4bNlRMnOx-2p3wKliIA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36083bd1b12so2308033f8f.1
        for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 06:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718630715; x=1719235515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/S3QsnopAU1g3EZ48Lr3+KF/tnwo0ee82bp6T2xhvDs=;
        b=KwqeocTwZU5eYN0VqZj1PHdx4a9ItL5z1OQTc0jeHSPWpkmxHiHZOX+IGVB+0wBdme
         PYBXE5W5m48iuPflf50dhbRmztw1JjMhHiKsHDKtLaShcTwEmT05eV5rUujeR6HuK5ZX
         fnc3uTKmGMU5THnnplzja+Ze9BuzVw/inhcO+RPC7Cf1NZAaJ/Hh1XsmUQKvzwIPl/Tb
         0KeYoyLiYiPIrrroaPRhvb6Os8rBqA1RItoqgLoWsh2gW0G6ZtoqLXETAAOeBux1VUNE
         I9pEybfJp6outbQimwN0wcgFOE+3gq5uNCAHqdHgkCMZHLnB9A4KeB6lMkqqArQkKnDv
         ejFA==
X-Forwarded-Encrypted: i=1; AJvYcCVsNqSojtZW0t2h3t87LMl1vlRPSo4cfCPwLEWNxXFuY7uXaT+JLoE2x3yvWGgy04ElYPAXyczvyZI8j2QoLlRFJuSuART0UDFL3i2Bsc8=
X-Gm-Message-State: AOJu0YxcrdxZpFxTNbXkW6uBuF3SZNYdSorjnlmJlRf7vFqhfw5xaM3z
	D3NEXkFuAZwpBZii0WlgRrC9kYv2EwP9x3aImjDcAmpP4xX2X7XftyteYH7gaLtKepfyr+eNIIV
	5C5cClE7th2Lf2hQto/E+1jjMd9zMlP55cIcpvb1X30o9EAciWn//sToJ6nNECq2a
X-Received: by 2002:adf:e850:0:b0:35f:204c:889f with SMTP id ffacd0b85a97d-3607a7833b0mr8786830f8f.56.1718630715267;
        Mon, 17 Jun 2024 06:25:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5RKQQn0KRZhLjfi6KZQa3K/TTM2W1cxHcRKnOc2A/u+LNZscYxGxayZdx96GzT+RJtL3BLQ==
X-Received: by 2002:adf:e850:0:b0:35f:204c:889f with SMTP id ffacd0b85a97d-3607a7833b0mr8786801f8f.56.1718630714671;
        Mon, 17 Jun 2024 06:25:14 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7439:b500:58cc:2220:93ce:7c4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509353csm11912155f8f.22.2024.06.17.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:25:13 -0700 (PDT)
Date: Mon, 17 Jun 2024 09:25:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH] virtio_net: Eliminate OOO packets during switching
Message-ID: <20240617091919-mutt-send-email-mst@kernel.org>
References: <20240614220422.42733-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240614220422.42733-1-jain.abhinav177@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 14, 2024 at 10:04:22PM +0000, Abhinav Jain wrote:
> Disable the network device & turn off carrier before modifying the
> number of queue pairs.
> Process all the in-flight packets and then turn on carrier, followed
> by waking up all the queues on the network device.

Did you test that there's a workload with OOO and
this patch actually prevents that?

> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>


> ---
>  drivers/net/virtio_net.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 61a57d134544..d0a655a3b4c6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3447,7 +3447,6 @@ static void virtnet_get_drvinfo(struct net_device *dev,
>  
>  }
>  
> -/* TODO: Eliminate OOO packets during switching */
>  static int virtnet_set_channels(struct net_device *dev,
>  				struct ethtool_channels *channels)
>  {
> @@ -3471,6 +3470,15 @@ static int virtnet_set_channels(struct net_device *dev,
>  	if (vi->rq[0].xdp_prog)
>  		return -EINVAL;
>  
> +	/* Disable network device to prevent packet processing during
> +	 * the switch.
> +	 */
> +	netif_tx_disable(dev);
> +	netif_carrier_off(dev);

Won't turning off carrier cause a lot of damage such as
changing IP and so on?

> +
> +	/* Make certain that all in-flight packets are processed. */
> +	synchronize_net();
> +

The comment seems to say what the code does not do.


Also, doing this under rtnl is a heavy weight operation.



>  	cpus_read_lock();
>  	err = virtnet_set_queues(vi, queue_pairs);
>  	if (err) {
> @@ -3482,7 +3490,12 @@ static int virtnet_set_channels(struct net_device *dev,
>  
>  	netif_set_real_num_tx_queues(dev, queue_pairs);
>  	netif_set_real_num_rx_queues(dev, queue_pairs);
> - err:
> +
> +	/* Restart the network device */
> +	netif_carrier_on(dev);
> +	netif_tx_wake_all_queues(dev);
> +
> +err:
>  	return err;
>  }
>  



Given the result is, presumably, improved performance with less
packet loss due to OOO, I'd like to see some actual testing results,
hopefully also measuring the effect on CPU load.




> -- 
> 2.34.1

