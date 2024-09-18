Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07FD1C579B
	for <virtualization@lists.linux.dev>; Wed, 18 Sep 2024 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671514; cv=none; b=azUjMbU+5tvN7KUTJ1HtQAbpSwQhfAn6qF4Lghf1v10ivoJAB7pVfUgx0fZwdCEvscy62KFY263Njb4Nj1v4n8BPOTUmjsgBHhcRrLXZNuZJAxXlZDq/bLHBb0z5mdgcsIJ393gWfQP4pTP1Z+c6egaoUF9nPfx9uuPNtWLLbCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671514; c=relaxed/simple;
	bh=QM+WRIrqOf/VG+tDwYImunOT5LIH7QRSSR3sO1/hKqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eiax3AYMIUi0oxx14qLitN/e84V9UQGet0QUgHDVMX1fJII5uR4y+QxI2u+dTppx7c98MRdKhZw9aSBuB1yeYLXqHFHzxlCjbzxp1omx9l9/KVZmCuF5hMOpsHOJ5ZjxT2arp5ZzkL6YlCqGZ+RF8J9vyLT1e+8R3ExxprwHiOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2ULJver; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2ULJver"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726671511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MAwqY9vnRPc9YnB7fd6OqxXe5O2u5mpoyMN36Na6yP8=;
	b=G2ULJver9frtc59JaKphGZAQq8y+BVsYSKbE38K3AeYiMPZRzkAGr6Vtx/RaMKxh1+NLJi
	Ti4juDOqBztkDeNoVC1d7JXiMtGUFWttOf6XvHSYlE/l85QeoUyD/ZhYR43T1XI8tKxRww
	isl6MVO9WxYzJhRp7GcjEtoZEDwqQM0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-QN4dbYYCPAmQHhO8FReV7g-1; Wed, 18 Sep 2024 10:58:30 -0400
X-MC-Unique: QN4dbYYCPAmQHhO8FReV7g-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c2483adeeaso1045426a12.1
        for <virtualization@lists.linux.dev>; Wed, 18 Sep 2024 07:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726671509; x=1727276309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAwqY9vnRPc9YnB7fd6OqxXe5O2u5mpoyMN36Na6yP8=;
        b=PdUO2RAdwC9/+cXF3Tx+YKzFSj6+Z1nEO1DJ57c8sGKDkhYyQrvMQH+HuvC4pC6RkY
         NBOO5VacsJ6A49thzBYKRlSNO20AaDbVhZWtn5j3tbaRJlvSoTlNJ58HAje15Jff17NX
         m6PGA4bZfaNVwmIH90EjDMSD320M16m7j0U55mRNPdfQWzXuXvSLnzuwYjnYPjdwzIQz
         zOIUzsNO970GrKld7AYLO5mxgG3VbdXXrNJxMlrQ4+AtABuBYqlH7euojS4waRgR9j0d
         /0t1Pbfn+Q2GzrLEXjm3obgh9uleVDn1xL2wlJMsA1oPz5+uV20FIV9gMyleX6DjQB6r
         YTvA==
X-Forwarded-Encrypted: i=1; AJvYcCX3GqSe2Y94xoLRMvraOpJqauUZhRTRMCNh775SwMfLIxkmVq1P/+emzmdSF2PP7+YcalrKWR2XE9OLXOcvPw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6CLlh/7OEfeI9Hb8BdcuwiI3c532hTjRNxwHIoT9INQLd2R+A
	LBks2w+fQVU/0+teoxM4fgBNVl8q1XAv5pda23R51TlmfWJsF0npYMLow6u9Nh9G/81slJDjQsP
	3qTki4grQJI+1jmnsQ7dKLzd9xV9jrXRm+Ss3nO6JUlWtDHWtTxbbVyaJgzftJirk
X-Received: by 2002:a05:6402:5c8:b0:5c2:5254:cdc4 with SMTP id 4fb4d7f45d1cf-5c4143874bdmr25722277a12.17.1726671509313;
        Wed, 18 Sep 2024 07:58:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzH5nuqNle+ILuHyENqVhBvmZFotgEz0rqz8hkG1mCshcHdFnBkW5waH+k3AXJut3JW5zwew==
X-Received: by 2002:a05:6402:5c8:b0:5c2:5254:cdc4 with SMTP id 4fb4d7f45d1cf-5c4143874bdmr25722237a12.17.1726671508527;
        Wed, 18 Sep 2024 07:58:28 -0700 (PDT)
Received: from redhat.com ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5e83asm5178794a12.40.2024.09.18.07.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 07:58:26 -0700 (PDT)
Date: Wed, 18 Sep 2024 10:58:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wenbo Li <liwenbo.martin@bytedance.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiahui Cen <cenjiahui@bytedance.com>,
	Ying Fang <fangying.tommy@bytedance.com>
Subject: Re: [PATCH v3] virtio_net: Fix mismatched buf address when unmapping
 for small packets
Message-ID: <20240918105803-mutt-send-email-mst@kernel.org>
References: <20240918132005.31174-1-liwenbo.martin@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240918132005.31174-1-liwenbo.martin@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 18, 2024 at 09:20:05PM +0800, Wenbo Li wrote:
> Currently, the virtio-net driver will perform a pre-dma-mapping for
> small or mergeable RX buffer. But for small packets, a mismatched address
> without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.
> 
> That will result in unsynchronized buffers when SWIOTLB is enabled, for
> example, when running as a TDX guest.
> 
> This patch unifies the address passed to the virtio core into the address of
> the virtnet header and fixes the mismatched buffer address.
> 
> Changes from v2: unify the buf that passed to the virtio core in small
> and merge mode.
> Changes from v1: Use ctx to get xdp_headroom.
> 
> Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
> Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
> Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
> Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>

OK but can you please adhere to the kernel coding style?



> ---
>  drivers/net/virtio_net.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6f4781ec2b36..9446666c84aa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1804,9 +1804,15 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  				     struct virtnet_rq_stats *stats)
>  {
>  	unsigned int xdp_headroom = (unsigned long)ctx;
> -	struct page *page = virt_to_head_page(buf);
> +	struct page *page;
>  	struct sk_buff *skb;
>  
> +	// We passed the address of virtnet header to virtio-core,
> +	// so truncate the padding.
> +	buf -= VIRTNET_RX_PAD + xdp_headroom;
> +
> +	page = virt_to_head_page(buf);
> +
>  	len -= vi->hdr_len;
>  	u64_stats_add(&stats->bytes, len);
>  
> @@ -2422,8 +2428,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>  	if (unlikely(!buf))
>  		return -ENOMEM;
>  
> -	virtnet_rq_init_one_sg(rq, buf + VIRTNET_RX_PAD + xdp_headroom,
> -			       vi->hdr_len + GOOD_PACKET_LEN);
> +	buf += VIRTNET_RX_PAD + xdp_headroom;
> +
> +	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
>  
>  	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>  	if (err < 0) {
> -- 
> 2.20.1

