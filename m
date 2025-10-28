Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C15E307ADA
	for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662512; cv=none; b=OaKM3HlL9ZUkjygZYIhOq0yeqluoUzBiIKQBngBBSdeYKSAEGqG//O6yMY/R443mrqXvUMmF1an9HVrP8ICQ41XwKeBwtqjdHyCrjRIYUfwbHXlRqyfo3Cbt8HqTGJ5UpfWQtPTeSyxDkpF73n6O42SNCHPJG8JQ4vYhPBn2lM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662512; c=relaxed/simple;
	bh=zZFrWoA22wiG0tWmfXQmHOPpME9nO7zblFQfy5vvLz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IYPAK1KZvlmSR4RKxvmrD3SAjKhobBRK5fyyoZwIMxdH3CfDPNaRq0dvaSpSzHTF83r6dJWnhTZ64ahptgfOjeVVpGlBUeSRHig/Ek7fBAhLExt0JmTILUQrackn06W1dwTZc9fx7NFQbsr0XG16sN0EO3pqO7FtsI3kuCkxJLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KuoAOkcZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuoAOkcZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761662510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7eWGU4/sCZhBc+k/OXAlSXf1w6wQiO+JEvcP2rSPOPA=;
	b=KuoAOkcZVDdT3pMbcleWKpgCqUQutjkGOyBeQHpuQgR6mgUxqvkVbubGKVKMf44bg88SUY
	7yaEBYHdezb5luE3dStv1uTD5YKCYnaKmn8wTNHaqsBpKXZS7XBsExyPGc41k4G1YT9xEO
	TcOgxKsPYNAdknwQpYBYT87SMKvRC58=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-OmgyxK9YPxSND4HNvfICEw-1; Tue, 28 Oct 2025 10:41:48 -0400
X-MC-Unique: OmgyxK9YPxSND4HNvfICEw-1
X-Mimecast-MFC-AGG-ID: OmgyxK9YPxSND4HNvfICEw_1761662507
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-63c585eb47bso9013077a12.1
        for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 07:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761662507; x=1762267307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eWGU4/sCZhBc+k/OXAlSXf1w6wQiO+JEvcP2rSPOPA=;
        b=uD7BLNy8taQmnzECzRhKpskAMEJ0JjNu7amH6Oi9mdbSUr2WyXMH9q52SZys3EHwL/
         y4vhdgAZl7BeqQBd/10Nu5PyFKLdp5R1X5R4JGANSYKq6c63kayTZ7hydb3NUgE59P7T
         6GmRroRq3Fmk8YFZDY624kwwFRfITRqExyqEoyS8JkINSZwsgD92QqDvdEpRtmHDaT/i
         uFtigJbAh5nhkg69AC+9gcRW9CLiira3CTSdnaDMY02Fv6Jvcr3OXSSqcieG2COXtmau
         XI8lMURk7gNmhMvOx479BUP5HxKPXbA5Zp1b47LoZQ+BHCZyae7z0CU98rj40d9Izani
         UdJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO9QF2M8YhGfYIO1Tb2x5wyFdF623YDu/DUqG5/gZsMAfQjA0f/urOCbtaVbGfcpYX6SxcfGs24w3V19n8pQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoeKM/SzT7okKXA6vW47H7LuwVSPR8njdFS33rFLFQxO4t6HLF
	+hah1h8wOKODkueGq27VOIK4//5QAGmHJ13uFSWeuefoQNs+Rvr2fxh4Trj6/70nZLsgPH7v2G+
	O58211rh70l9tgcgKxTTx3CUgFRDc+46ZJa1c9x6iJDNVLkwFYjR1UvV1ivOjvtPW8ZYa
X-Gm-Gg: ASbGnctGP1lmMHdTKjNOddc62eubsqX4I8gjN9E41hA4IrOU08Jjp0I7dXFyOr9iIyn
	WqN/7Ar/wL1AbecncZda0R0cWQwvVq/0KTxysdX/6sNtu+P716cgPL9TSWuBEuUiZENcfKFP6rE
	DBL/y9RxfiaNG/dWNvhsZSsuCrzEw5gCc30VkuP3wytDrr41zsvwvg/6q4/lnwoSgwi5SFSpTa2
	82PTni7HX41DZ9IfaKmmW4t9Wx5z89RGxmHrx/Irsfi1T85fmFj8isy/CBOEQtqAd4e788rUg4u
	oAVvredKwCQP1fVi89P/DYO8m3Y6LiObgdtO6s94Q9uEA1zM+S5kAmeytOXICQ2J
X-Received: by 2002:a05:6402:144a:b0:62e:ebb4:e6e0 with SMTP id 4fb4d7f45d1cf-63f4bca70a6mr2966891a12.1.1761662506588;
        Tue, 28 Oct 2025 07:41:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOr/YGySpncsjMyKMI6CUK3yhy881BlqAgFf5Tw9hIOxtgltg9Pn+Albol7GlK//8Ah0jD8A==
X-Received: by 2002:a05:6402:144a:b0:62e:ebb4:e6e0 with SMTP id 4fb4d7f45d1cf-63f4bca70a6mr2966848a12.1.1761662506036;
        Tue, 28 Oct 2025 07:41:46 -0700 (PDT)
Received: from redhat.com ([31.187.78.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd0e23sm9044225a12.35.2025.10.28.07.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:41:45 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:41:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v6] virtio-net: fix received length check in big
 packets
Message-ID: <20251028104041-mutt-send-email-mst@kernel.org>
References: <20251028143116.4532-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251028143116.4532-1-minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RjoHgm08fvANTiVHPtnkHM_A3Wr3lcOm0bM45vi_TH4_1761662507
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 28, 2025 at 09:31:16PM +0700, Bui Quang Minh wrote:
> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> for big packets"), when guest gso is off, the allocated size for big
> packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
> negotiated MTU. The number of allocated frags for big packets is stored
> in vi->big_packets_num_skbfrags.
> 
> Because the host announced buffer length can be malicious (e.g. the host
> vhost_net driver's get_rx_bufs is modified to announce incorrect
> length), we need a check in virtio_net receive path. Currently, the
> check is not adapted to the new change which can lead to NULL page
> pointer dereference in the below while loop when receiving length that
> is larger than the allocated one.
> 
> This commit fixes the received length check corresponding to the new
> change.
> 
> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
> Changes in v6:
> - Fix the length check
> - Link to v5: https://lore.kernel.org/netdev/20251024150649.22906-1-minhquangbui99@gmail.com/
> Changes in v5:
> - Move the length check to receive_big
> - Link to v4: https://lore.kernel.org/netdev/20251022160623.51191-1-minhquangbui99@gmail.com/
> Changes in v4:
> - Remove unrelated changes, add more comments
> - Link to v3: https://lore.kernel.org/netdev/20251021154534.53045-1-minhquangbui99@gmail.com/
> Changes in v3:
> - Convert BUG_ON to WARN_ON_ONCE
> - Link to v2: https://lore.kernel.org/netdev/20250708144206.95091-1-minhquangbui99@gmail.com/
> Changes in v2:
> - Remove incorrect give_pages call
> - Link to v1: https://lore.kernel.org/netdev/20250706141150.25344-1-minhquangbui99@gmail.com/
> ---
>  drivers/net/virtio_net.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a757cbcab87f..461ad1019c37 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -910,17 +910,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  		goto ok;
>  	}
>  
> -	/*
> -	 * Verify that we can indeed put this data into a skb.
> -	 * This is here to handle cases when the device erroneously
> -	 * tries to receive more than is possible. This is usually
> -	 * the case of a broken device.
> -	 */
> -	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> -		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
> -		dev_kfree_skb(skb);
> -		return NULL;
> -	}
>  	BUG_ON(offset >= PAGE_SIZE);
>  	while (len) {
>  		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
> @@ -2107,9 +2096,19 @@ static struct sk_buff *receive_big(struct net_device *dev,
>  				   struct virtnet_rq_stats *stats)
>  {
>  	struct page *page = buf;
> -	struct sk_buff *skb =
> -		page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
> +	struct sk_buff *skb;
> +
> +	/* Make sure that len does not exceed the allocated size in
> +	 * add_recvbuf_big.

you mean "the size allocated in add_recvbuf_big"

> +	 */
> +	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
> +		pr_debug("%s: rx error: len %u exceeds allocate size %lu\n",


allocated?

> +			 dev->name, len,
> +			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> +		goto err;
> +	}
>  
> +	skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
>  	u64_stats_add(&stats->bytes, len - vi->hdr_len);
>  	if (unlikely(!skb))
>  		goto err;
> -- 
> 2.43.0

