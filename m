Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD212620FC
	for <virtualization@lists.linux.dev>; Sun,  9 Nov 2025 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762724090; cv=none; b=caWFGTrf2Uj3oxuTXuAApc7muabUsJUWl4Y+rWbt6HNRRIh4G3B6lCrsondnQt/6STN7rOHuDeKej8zqWj8QGn29CHo7EFva2O4TNrcpE5MDOQKUR7yIy8fQVoI9m8VH7IrwcnNir8ODoIHkbK3onzPz5prZDKk5CqtYitPH0v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762724090; c=relaxed/simple;
	bh=/k/tM7aN+VJfQPu1HR8zVVK7SFTOdEvY3M4sRoeTLCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=evy4AihNLMxE93/ey3i/tVu4zMzRCIplVHLaEboHshFE9LKnkgSG7CCJ04A6G8ERVZFHbVnTgU8pIryNrYfdkYwIdchzGfLVppV+69KEeIzrrGiPZdsVgWUgdJGIAPPt6q+uKMXs8LL8rbwoksqpLGr23bY/2iy5okXmso37H8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zq7bqjWO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zq7bqjWO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762724085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yuRvVMzBCOjz0UYXFyj845DdF5Y6IRoz7uN2lJXI1Vk=;
	b=Zq7bqjWONZ56qhNS8gV76XL13xRLpkPUWUhf2ndV2l83xMy89UfXOyz7DrCG/RHSkGEJbn
	n85TYkF16nY1lHorDgyhdkp3fDpOs+DTiQ6FN4g5orlw2mFyEUQYlyur1GA5oDHlPMMZ6q
	RFAgYA/SxBbXA0XGgQELKPuRJX0HjIY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-2zYH69_dNQmcqUZxlHBFhw-1; Sun, 09 Nov 2025 16:34:43 -0500
X-MC-Unique: 2zYH69_dNQmcqUZxlHBFhw-1
X-Mimecast-MFC-AGG-ID: 2zYH69_dNQmcqUZxlHBFhw_1762724081
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477563a0c75so14029535e9.1
        for <virtualization@lists.linux.dev>; Sun, 09 Nov 2025 13:34:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762724081; x=1763328881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuRvVMzBCOjz0UYXFyj845DdF5Y6IRoz7uN2lJXI1Vk=;
        b=dk3Dq158tAxsQFf7QZPZ6jkSFnN0LOmEYRnjuJCalCch2wfQDFfGEy20924fEnm49+
         GQA5+r9YlHTX6gEyerwrM6iBO96iEt6rfVv1lxB3knh0u/6AaaGIpHf31kMGBm3ObBEy
         tMPb091ztyCc3aAr6mpvXrTuEPHCgJapYn43Ryqya+QAhm+FJht47Geg152noKp0e5Bh
         Fk2HGRXht6KZ21U14N6UAiGpMMDflZDHFDSRnIpVjCckCFZOE25qLksT0IYGnbaGC/ki
         hERdESuM6pfjuh8d+GsJzGgIDQptOJl/BTPGgt//92p2Ln/mccfXCbtISJDaHYgAnXX9
         QyQw==
X-Forwarded-Encrypted: i=1; AJvYcCX+hVbiSAIgNcY1CkwSCRz0NLvYyYZKblsc5NJ9tyaSAd9lOMsACjkMffGsF38aSzZmO8SD7Bvbt+F8TBm5qg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSImQk8pjeWcl8VOvmRaFobbfYgUd9bLBJJ5RQR0zsUn/0yWuA
	fKszQWZBp/PR7OrQQ1+FsdWAprPFH3XNnZpvYguVp1MfuCfDk4I2XFk2puxVnmwI346rKk3QcaM
	bjvJrP5k+8VqQuQHBMwrg5pt9hKvAWFqoYUv/Kq4fPLKXztQY3oCskSF09PyQ2vji4yjt
X-Gm-Gg: ASbGncvG67wKOIStCIcwTDep9y+Y+uk8/s3hilx479JThtGsbljzsJeXx+HK9e4T+84
	vUjfGbF4ahuZKElyWkNpHZEc7gO0sln3hoWjrt7CeEIS6m9t//xGa8CCUr2EMhvgEQs7Q+WdgCs
	NACD6BJ/JQyESwOso9emHpAQ8FjuEdr+VRrf+iJJhFl8cOXiz0a0/MeTIv2jDJrCWqnXjrJ7qvs
	dz2IiOIgo35cVp8PysskNZ5nMet6jfC1YtX4aZyqbOzV3WlD2Bm0PS+iQYv86ZxaDrTP8PQgJwF
	F7+SGqlI61c94OiXk/OjMmSHjliwp5jaNRy/c6So2Tnn9zodf3CQSasSmehaXeBWnnI=
X-Received: by 2002:a05:600c:4ed2:b0:477:7d94:5d0e with SMTP id 5b1f17b1804b1-4777d945f1dmr1196725e9.27.1762724081112;
        Sun, 09 Nov 2025 13:34:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGW9iA+CzK/FjpBM/e7D6gQ+zW6aVjSPr8rNlm1S3UdLgIp9ALg50OwxbW/747hMDqIG1CnxA==
X-Received: by 2002:a05:600c:4ed2:b0:477:7d94:5d0e with SMTP id 5b1f17b1804b1-4777d945f1dmr1196595e9.27.1762724080621;
        Sun, 09 Nov 2025 13:34:40 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b322d533dsm7761055f8f.0.2025.11.09.13.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 13:34:40 -0800 (PST)
Date: Sun, 9 Nov 2025 16:34:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v4 1/4] virtio-net: fix incorrect flags recording in
 big mode
Message-ID: <20251109163431-mutt-send-email-mst@kernel.org>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
 <20251029030913.20423-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251029030913.20423-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rqAfVT1pxjRgAHtZwad1W0nH49vBWaZzqjUQfGsniLI_1762724081
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 29, 2025 at 11:09:10AM +0800, Xuan Zhuo wrote:
> The purpose of commit 703eec1b2422 ("virtio_net: fixing XDP for fully
> checksummed packets handling") is to record the flags in advance, as
> their value may be overwritten in the XDP case. However, the flags
> recorded under big mode are incorrect, because in big mode, the passed
> buf does not point to the rx buffer, but rather to the page of the
> submitted buffer. This commit fixes this issue.
> 
> For the small mode, the commit c11a49d58ad2 ("virtio_net: Fix mismatched
> buf address when unmapping for small packets") fixed it.
> 
> Fixes: 703eec1b2422 ("virtio_net: fixing XDP for fully checksummed packets handling")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e8a179aaa49..59f116b609f6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2625,22 +2625,28 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  		return;
>  	}
>  
> -	/* 1. Save the flags early, as the XDP program might overwrite them.
> +	/* About the flags below:
> +	 * 1. Save the flags early, as the XDP program might overwrite them.
>  	 * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
>  	 * stay valid after XDP processing.
>  	 * 2. XDP doesn't work with partially checksummed packets (refer to
>  	 * virtnet_xdp_set()), so packets marked as
>  	 * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
>  	 */
> -	flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>  
> -	if (vi->mergeable_rx_bufs)
> +	if (vi->mergeable_rx_bufs) {
> +		flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>  		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
>  					stats);
> -	else if (vi->big_packets)
> +	} else if (vi->big_packets) {
> +		void *p = page_address((struct page *)buf);
> +
> +		flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
>  		skb = receive_big(dev, vi, rq, buf, len, stats);
> -	else
> +	} else {
> +		flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>  		skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
> +	}
>  
>  	if (unlikely(!skb))
>  		return;
> -- 
> 2.32.0.3.g01195cf9f

