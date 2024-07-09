Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8EA2B9D4
	for <virtualization@lists.linux.dev>; Tue,  9 Jul 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529135; cv=none; b=rVGz9ukNWJf26SMR7wQXoZo4YQecF4mf+7aRWbbixwexnNxA7VFtWI/bpSAM4vyndet2iDSQUSD0dBKIECTKH9TtahhQf4W/hXGA8qzIBa9zAeL3VO+KWUErrNcd2jI9gxE1AAGwKO6VzbnTZ5XSixriS23b3mBUEw6A9hA55ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529135; c=relaxed/simple;
	bh=qkDSpZl31i+/hBrfQgJpmqiStGg52BC4bBURCAoFLMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DVWCIG5P21HywQJulEWjJWj6RFPbwPN0FTGMKBDBcAnY6Nwyb3mS6A1Gvv5YMK9csoB0vQghk+7ISTSh9sa7oHos0ebbgOCjAfc3VeSqo3EhSuVSo8MQZJj9Y5VYGYo5olxX2WfVUblybta6I6kPtoRoYlD2ZoNPYNCrLnSbdyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P17GN0fe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P17GN0fe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720529133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5CTLeRlDMVVXgOXwJHhEJME+SCXM+Wt3vrFV6ZQ+bKs=;
	b=P17GN0febiS/scTntBBZmfzPinEljLKF9+EZnQpvOQdBUEt+XNekDaZifhQyXnmAkHDKsB
	TxOjMyi5q7AwaGjshCMW9WLNNitZcSUGuC7CpUjHuLZsIPBsKTtmJXA6awH/glN3cOdbKw
	hlXfOQE22RHtfweGPCf101iO9YcSYPQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-hWTJYLWCNMmoBsqq9xKC9A-1; Tue, 09 Jul 2024 08:45:32 -0400
X-MC-Unique: hWTJYLWCNMmoBsqq9xKC9A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3679e7eeda6so3112982f8f.3
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 05:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720529129; x=1721133929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CTLeRlDMVVXgOXwJHhEJME+SCXM+Wt3vrFV6ZQ+bKs=;
        b=vRfJNGuwa2GwlIY88OPJKwvnVpOQytNXYvRA+9UpQQn9edugkdgQFAzK+SYC4mwGfP
         6h9tg3mT2CBbvESqDpHZMBTpUXDrKoKL1526e4D7AhCtcJ6ekfSmjST5dTod4CMZN/YN
         g6gc99RlzXKrjRs4uDNaCxjK7qjAACdiP94naUx7FLNsBmZbsqneA2M0HgvSRmjOiAQx
         xwxrVHQ8D8BHjDeXRFATjaOyoLimuLznubUhI9iF/Y9pI7aIS1B6tfVVB13UjJMT5AfX
         COP14BbxQ/8OUD+cKWHVrinZND9JgH2WnWRAj2xOOORhfwikb8WFlaVgn4KJnYe0ouBh
         flxA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ//jNgmYiayW5Z/W48wzKbmXfpu0QsimMCCGGSJoOENTZwhpDwTRWwMmvMRWd/L3fXNDK7Tt8/N9vOQ2xmJ475uItp4nzU3dgA1XaIUc=
X-Gm-Message-State: AOJu0Yz68ZdX7KBw5bygJ0SbinOm+UVp2dP4syslSHYdyGNw/ZfCiNfX
	42KEqoVWCHMLKICpWye7oc7TQuNgEwTXjc9kT941f09dv9hv6d02CSfStj+q2zOkAz0Icx6KvLv
	alXJOSx5F8tnwTS/jIVmjrsdjzt2SpFZkLr6koMnMo+S1MTYaUmYh3s8lC0a3PtoR
X-Received: by 2002:adf:f583:0:b0:367:9037:d075 with SMTP id ffacd0b85a97d-367cea9630amr1798614f8f.37.1720529128913;
        Tue, 09 Jul 2024 05:45:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI/62fYWAbov6M9yXYpN3yUDAfLjP7a0+LrXAwktHtFKQNHUlKIC+VwSXZ4cuHu7iJoLYIAA==
X-Received: by 2002:adf:f583:0:b0:367:9037:d075 with SMTP id ffacd0b85a97d-367cea9630amr1798594f8f.37.1720529128422;
        Tue, 09 Jul 2024 05:45:28 -0700 (PDT)
Received: from redhat.com ([2.52.29.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa0689sm2450765f8f.85.2024.07.09.05.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:45:27 -0700 (PDT)
Date: Tue, 9 Jul 2024 08:45:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li RongQing <lirongqing@baidu.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	hengqi@linux.alibaba.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Use u64_stats_fetch_begin() for stats fetch
Message-ID: <20240709084312-mutt-send-email-mst@kernel.org>
References: <20240619025529.5264-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240619025529.5264-1-lirongqing@baidu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2024 at 10:55:29AM +0800, Li RongQing wrote:
> This place is fetching the stats, so u64_stats_fetch_begin
> and u64_stats_fetch_retry should be used
> 
> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

So I dropped this from my tree, if you think it's
still necessary, pls resubmit to net-next.

Thanks!

> ---
>  drivers/net/virtio_net.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 61a57d1..b669e73 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2332,16 +2332,18 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>  static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receive_queue *rq)
>  {
>  	struct dim_sample cur_sample = {};
> +	unsigned int start;
>  
>  	if (!rq->packets_in_napi)
>  		return;
>  
> -	u64_stats_update_begin(&rq->stats.syncp);
> -	dim_update_sample(rq->calls,
> -			  u64_stats_read(&rq->stats.packets),
> -			  u64_stats_read(&rq->stats.bytes),
> -			  &cur_sample);
> -	u64_stats_update_end(&rq->stats.syncp);
> +	do {
> +		start = u64_stats_fetch_begin(&rq->stats.syncp);
> +		dim_update_sample(rq->calls,
> +				u64_stats_read(&rq->stats.packets),
> +				u64_stats_read(&rq->stats.bytes),
> +				&cur_sample);
> +	} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
>  
>  	net_dim(&rq->dim, cur_sample);
>  	rq->packets_in_napi = 0;
> -- 
> 2.9.4

