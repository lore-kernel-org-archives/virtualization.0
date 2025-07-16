Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440D31EF091
	for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674364; cv=none; b=YV/1M/4ZNFJ7xgNGoyns4BVTgyPhKMu2i0bb85c9DwMrvgCnZp9/lDPMpCOUAeEZrbnsCuk2xD9EjQfCp1d6RlW3HlyOEUfNp6/ha5x5Q+e9XARW6pTa3iRNnYXsQScv1OOWlVIlrQQMGo3byd4PMCcatyRoyCnP4qMdzdiAx6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674364; c=relaxed/simple;
	bh=vHxPCtOGRmTWwUUNQPX/mlHvWm4lcQMqvFYAd3E7mz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Nc5NkxAdUC2yqf5VSicQQ/OebI14fQLQ03ZeaNG2qaXFEelu4TBAs7ub6YXpSrypIAlgNlPkMlA0fn/TbpR31V7+iejmXi4ugSzrcldi027P6IU3wp1+cn0evoydES2SskIX5VwccgW+q/YfFgRQ+TRE9tfCUqWL1wMWLpzRDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYgKGcO7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYgKGcO7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752674362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p3rw/fBA5XAemzUR/xM/HsYNQo7lSDwo1j9IVDjWp3c=;
	b=cYgKGcO7gwcpAXwsoszfY+KrL/FDNSAmUZstrsFXEv/Snuvk4GMNF/svzAtMyH3d6NU4l9
	5tiJjjWlyLnSlAd2ctYCqeLKwH+7QcKPKToFhU54xmkc7caSBBbKKxXp4gwM5q6lwDuOLM
	dpMYzXKFFyLpKZ/3Axf9S+pO5USMmto=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-x4Xt_j5WOl2PriLWVCcryw-1; Wed, 16 Jul 2025 09:59:20 -0400
X-MC-Unique: x4Xt_j5WOl2PriLWVCcryw-1
X-Mimecast-MFC-AGG-ID: x4Xt_j5WOl2PriLWVCcryw_1752674360
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-453817323afso41725045e9.1
        for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 06:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752674360; x=1753279160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3rw/fBA5XAemzUR/xM/HsYNQo7lSDwo1j9IVDjWp3c=;
        b=q/4y6NYh9Aln0u8t/QAglWcNAnT3j99Fw7hN8EyMVtXkUQuE2V+iShSf0mexS+RINR
         GtZVnFMq1NVp1mgzzMCeGUBiTE9m3sxpEBsjJT5xIqW3QmHW9ZxSQerunDxyfwZz6Stp
         ZhWxuWEtkbpg2iiM4+zu/4pJB7cYjBf7JptdUVP2AoUuFY7mNnmDjkNNCkT99QLtN+7b
         cbbo8f+NYOE1WOl8w8UHOftctnFc+vtKIlvGKe91+nZ6de6HR/WlECawmBys1cioLScJ
         3TUvo7DLOTjn/dGcQs8FXv36n0R+ea/B1fX4XL9ZME3l/9yqsnmZ5pGRnaLfMclJ/7VL
         Y1kQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7AYfGfY0PVS8+laFZjVADSmUSi94DhqOXLSA4oVpi4G3cyw6o92cMXB8ag+MKqCmtaZs8k5hMvNF2sHg+qw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw50DJB5AIKgJJv1oAU/O99hW1j9cpbB9NJj0QGbTxVSx/JDIxe
	r2qkoVKg+wLgRZkAf710ncUXevTmwX6ZxESgnBWjRYSqk0YxOYjRhLCtOVJnltedJJ7A/Z453pT
	fnXZJ2oRwTsRQ+GR1BaQxdXXANTk1cEaM0lFn4XVIGM3JICV/cUb+Ox9ksj9qMdSR6vgg
X-Gm-Gg: ASbGncuLKTlDK+BPJXSV5fzksRoBBCHJpVDXsP2pZs9LhBqhAFSp4vskPOfDJSKL/L1
	Rd6o0kt2HnTXuzSu4lNYlrv66PHUjBXKRz0F0wD2q3TyzkVERXXVmqeKv8igI5j47aMk63mfN/v
	pgY7cR//5X2xgbYOTiL3AlElNTXX9Kfw3Mkq7A4xf0ALb7SP1/bl3PmxnjhP2Mh30+ZK6UC8tPN
	gVs6UzhLO+/BTsfvAetj2RCbwkD6nA4UG2FEIU5tQkPsZVjBgz4Gh98iGlfOuBPAnSNTaxfZTCG
	5zk6w2DUschurb4rl4kQ6nro29tr+lLJ
X-Received: by 2002:a05:600c:5246:b0:456:207e:fd86 with SMTP id 5b1f17b1804b1-4562e03bdf0mr35701135e9.2.1752674359560;
        Wed, 16 Jul 2025 06:59:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtBlIepy23CW5zO4OFRebEc+q6FcwXdViDGIwmEkFbQb1HdNuzCXykuQ+4KUs+XckpmR18SA==
X-Received: by 2002:a05:600c:5246:b0:456:207e:fd86 with SMTP id 5b1f17b1804b1-4562e03bdf0mr35700725e9.2.1752674359063;
        Wed, 16 Jul 2025 06:59:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e832dfbsm22006015e9.29.2025.07.16.06.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:59:18 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:59:15 -0400
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] virtio-net: fix received length check in big
 packets
Message-ID: <20250716095850-mutt-send-email-mst@kernel.org>
References: <20250708144206.95091-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250708144206.95091-1-minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9HiXY2g8vd5eOeI-ir_sKkBOaWYJdVHjl7QxaREP8t8_1752674360
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 08, 2025 at 09:42:06PM +0700, Bui Quang Minh wrote:
> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> for big packets"), the allocated size for big packets is not
> MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
> number of allocated frags for big packets is stored in
> vi->big_packets_num_skbfrags. This commit fixes the received length
> check corresponding to that change. The current incorrect check can lead
> to NULL page pointer dereference in the below while loop when erroneous
> length is received.
> 
> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes in v2:
> - Remove incorrect give_pages call
> ---
>  drivers/net/virtio_net.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5d674eb9a0f2..3a7f435c95ae 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  {
>  	struct sk_buff *skb;
>  	struct virtio_net_common_hdr *hdr;
> -	unsigned int copy, hdr_len, hdr_padded_len;
> +	unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
>  	struct page *page_to_free = NULL;
>  	int tailroom, shinfo_size;
>  	char *p, *hdr_p, *buf;
> @@ -887,12 +887,15 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  	 * tries to receive more than is possible. This is usually
>  	 * the case of a broken device.
>  	 */
> -	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> +	BUG_ON(offset >= PAGE_SIZE);
> +	max_remaining_len = (unsigned int)PAGE_SIZE - offset;
> +	max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
> +	if (unlikely(len > max_remaining_len)) {
>  		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
>  		dev_kfree_skb(skb);
>  		return NULL;
>  	}
> -	BUG_ON(offset >= PAGE_SIZE);
> +
>  	while (len) {
>  		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
>  		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
> -- 
> 2.43.0

