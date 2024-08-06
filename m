Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8088F3EA76
	for <virtualization@lists.linux.dev>; Tue,  6 Aug 2024 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722947109; cv=none; b=sUd70TkEjdMIoPihu5LU0ybgeIXB957fWYZmiFzpgU7Eh7ET20KDv1HUau1mgaRcGX4AwBX1ByYteesdgJ0HUxFXKhRs0NUK2ZDFRvtqMExky5yB07Kjmg8TW7rp+bXWGOECEIuEvoRD8c7eu+lUFsEByPOUz159HFNun+K2ukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722947109; c=relaxed/simple;
	bh=Zu5nxB10vxcRfClXXeGH1h4cUWEuoT+5MdHAObYksrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jgMOSw0WG8DDPYUFtiCw42QmGJ1Yl3imP/1cgspH4zHIKt5MgcEGCMHftvswjn6xlhBO0gVd4h9o35esOF+uJ78KUQtKjL+yXkthP/aXYPEt+nr4/q+CQEhERf8n66vZ6AiAOa66Ma3UZ5f92B4qVdgPhY9jBdfpwLf0B6yDP/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1Jx+n+W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1Jx+n+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722947106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PactkZyJX0Ag5OakZPEWVf1Vde5VXyxtGsMlaDiA2ks=;
	b=D1Jx+n+WLgy/rmeHRaN1b9yxx7t881oFAd5qiTFcCVd7ayTFQ/PEeycYgEr9p7ews+JNnj
	50dk3+df1/ZBXYvKg4jjz6vmO+1WV79S77ALG8JA0SSf+XhZVfGGUNXSyHORRog/6rMqKl
	xDdD28T6U0SaqKuGudSy+wcgPVxKEto=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-M6FJd6b5MK-WS6-1g-y4Eg-1; Tue, 06 Aug 2024 08:25:05 -0400
X-MC-Unique: M6FJd6b5MK-WS6-1g-y4Eg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-427ffa0c9c7so6854435e9.1
        for <virtualization@lists.linux.dev>; Tue, 06 Aug 2024 05:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722947104; x=1723551904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PactkZyJX0Ag5OakZPEWVf1Vde5VXyxtGsMlaDiA2ks=;
        b=X6c0yc14hcvq3zo/n/TXI4O7ZNadeTSirhve6iNZUXn9kxFflZ0bvNTHxiU1+bfWP8
         hhZfGefSQ9gpt2O4G23yMWGpwn5WEC04YC88ajZ8+nq7SnXuLn2f7H78efs0kMw8zgpm
         VdUbn3mk62M5omPYBONa33qlHHhNFXKYU3IYez8jFneucfRFfU9qqrx6epi4a7qmPD5X
         FAvAoYn5zUmNtdKoll23cCnADHjvQ7iZLlHvTPTouUa9vcD03QZWEJrYfcYg1GFj5iBh
         VF7MaKamwc912PkfianuCeHt0Mz1XgcbNFmi4pOM4Hl4KFBiW7dZmI+1p9soAb4vAQ1l
         dlDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDC1v2Hf1+4S900qFOdlKQC4RPQl0H/1mhCuXdls6w5C5CXOc91xbItZyuWbrqHHjbrW6gySdXPvoU7alhVjOhuRUGmaCYdrt/+d8POuk=
X-Gm-Message-State: AOJu0YwleGqEEvMKCwe347U453RdSDnrxuDTCW9UMSTawtU2tAirQn74
	CC/1AEjfF3hFOi1Kg5XTOo1xjaI8BRq96KHaWC6fElC5sZOgfZncBpP3tDn9ibKp3PlvzXwtdTs
	L6RRJhJJrQF+ruJNbNu2G4o5JwvUMxpt6QcvL4ep2MQY2/nfBPSoeqeWNWFNGcbSy
X-Received: by 2002:a05:600c:3b16:b0:426:6822:5aa8 with SMTP id 5b1f17b1804b1-428e6b2a6ffmr145329825e9.18.1722947103951;
        Tue, 06 Aug 2024 05:25:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzVU9aAZD5lCQaBSPg04gI2QuPw/TNVwvVCA7OZglja6VMFhHphFFZfNM7ojHYJSFxf3gR6Q==
X-Received: by 2002:a05:600c:3b16:b0:426:6822:5aa8 with SMTP id 5b1f17b1804b1-428e6b2a6ffmr145329395e9.18.1722947103082;
        Tue, 06 Aug 2024 05:25:03 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:c9eb:d9d4:606a:87dc:59c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89aa4bsm241485275e9.7.2024.08.06.05.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:25:02 -0700 (PDT)
Date: Tue, 6 Aug 2024 08:24:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	inux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V6 4/4] virtio-net: synchronize probe with
 ndo_set_features
Message-ID: <20240806082436-mutt-send-email-mst@kernel.org>
References: <20240806022224.71779-1-jasowang@redhat.com>
 <20240806022224.71779-5-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240806022224.71779-5-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2024 at 10:22:24AM +0800, Jason Wang wrote:
> We calculate guest offloads during probe without the protection of
> rtnl_lock. This lead to race between probe and ndo_set_features. Fix
> this by moving the calculation under the rtnl_lock.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Fixes tag pls?

> ---
>  drivers/net/virtio_net.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index fc5196ca8d51..1d86aa07c871 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6596,6 +6596,11 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		netif_carrier_on(dev);
>  	}
>  
> +	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
> +		if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> +			set_bit(guest_offloads[i], &vi->guest_offloads);
> +	vi->guest_offloads_capable = vi->guest_offloads;
> +
>  	rtnl_unlock();
>  
>  	err = virtnet_cpu_notif_add(vi);
> @@ -6604,11 +6609,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		goto free_unregister_netdev;
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
> -		if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> -			set_bit(guest_offloads[i], &vi->guest_offloads);
> -	vi->guest_offloads_capable = vi->guest_offloads;
> -
>  	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
>  		 dev->name, max_queue_pairs);
>  
> -- 
> 2.31.1

