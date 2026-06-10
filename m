Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68BC20C029
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 22:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130126; cv=none; b=BtfUvWi29MqmmPF4fhF1LXIvyR8nAVdB8lj4v3rDkNY4nTjoSxNTbMFB/WZ64JFWzR6pjp+iEbOjdwCjKqdD6FFmxoOcBUJn7IsjGKrKXr1BN5ftI0ttfNah00+W9Lsni7dQM0aJD3am9DQZhZCklRJAaNGLCbWtF49jmQJEQbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130126; c=relaxed/simple;
	bh=8u+7DTzELirNm6wHvKOIo1/nebvVCwekSoFgUO2K8oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=s0alWsuqmOLuV9hEzMhwOM3Jx5jR/rit1ue1BU+zU/l0dY7k1JP1oIx9acQhET4JK5n1EW8816OrXiTiAEsHdiyDveUM5SJVZn7BShznd9FeTbc4eqsrTNFmkzfHMYWQZE0iNens5ArTej+qcqesD8fyN2qL5Uj3BdHCRIFwld4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mbt9yaeA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mbt9yaeA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781130123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3XNDDsRWPntbc74MBmHORM39yXNnRzhKg57vrlJiACo=;
	b=Mbt9yaeAIJ5IrncD4yltkm1UO+CAavwNEy+ua6pU5ZRh0RstdGr2L8L/SvvZsM700a165r
	EYlbgIe+ouRKMPrDOgJwA3uZGugWpO6XFCyyPxY9UV0ZG9avqXB1j+5TyloxmDCAiHNfq1
	rZsdpD7HasWSkHCxxxRWr1O60a6tR8s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-MpemFqYnMyOb0bXZxNYeYA-1; Wed, 10 Jun 2026 18:21:55 -0400
X-MC-Unique: MpemFqYnMyOb0bXZxNYeYA-1
X-Mimecast-MFC-AGG-ID: MpemFqYnMyOb0bXZxNYeYA_1781130114
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso58136985e9.2
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 15:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781130114; x=1781734914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XNDDsRWPntbc74MBmHORM39yXNnRzhKg57vrlJiACo=;
        b=GApTvQyZR4ZSXviw7noOJV+pbTiXUYR3/jOWCkCiVHdtUv3dKAUrpp/cZFPzhBr/M9
         T1wwfjzKSp3caYGldEAzwbMDvpxqQdGFb2QiuYxcIyS3ohGp7DMt0xv90ZzUpL1twcr8
         tthUa5a0L5LHmaFxOhKI0ZrxnL6LOMWopYf3vtPmj0h/eoUembbIigLkWsf64J9hayJq
         Wj0qA1CT4qIG+h1NP8gKIBMnno1aEi6YKygXc/yN7A69uFIM5fgNnE+fD+WNbbdcppWo
         hUMv4vESeBaUzWbjlT5D73tzmbv8AI6Ak1lP3DrG2wtBl4fs4ud50mPzVPxzU9sQgn9h
         yEiw==
X-Forwarded-Encrypted: i=1; AFNElJ+OIk8OcdZleMdaeQPioQgNsAONUpQ598xeopzVVIemZdmKXv7Spnoa15zivhFNPGpiPnvlsH9ExbPJKEG8fQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFxyk5d/iRFLvMDRu346eiQtI3KjocgRtk9LlTYxM14TRSAEHP
	LoJ7yODD21XAuKk842wV4Fo0wQaoFudS/DGfN6LcaE4P+NjF3g5Dy+pMg/QkP09PJjREHzvtWZ0
	/DA3eWy0atcb/wLqw6yNnX9s6Mh9cx5UXO2fyqf1ldelQbXbgaYF5On04NQS7z66i/zzQ
X-Gm-Gg: Acq92OFonEUmBklVH3uKPCL5jfCr77zgzEcGBZJa5rukyApH7SmN0MuWJoze4Ah8DzY
	SEvFKhUH8M3ddx5Ri8VG83dNU48Pw3oPD722WsXfXnRM35C+KmcAdE8Sy4G/BFGeCR5jOnBwJ5r
	rbnvOfPL3xXrnVc7ntepKYJkRLcnJFWB46CrvGRyG8kE979d/SlRbfC4YMKmRigYYBjrjEDJeRW
	41j+8SwtB2iB7jDR7wXkPfqjM00DOrwupH1Io9LnDHdbw/j4wW90ZkCqoeqrcIPK9SZearOfqGb
	hcTZdT1cRQ5HsBUIxIcstb4Vbnc277SxaHxPA2bprIWMYhLSXci7ZeppGnGy+9ukgNg8AcVqmg9
	BioRaZzt99xc/hsUVDOx/jaLN4k7BMy6e2moTQ0JdO3NU5CmMUCzAqg==
X-Received: by 2002:a05:600c:6087:b0:48a:8b02:ae91 with SMTP id 5b1f17b1804b1-490c25b0231mr459511065e9.11.1781130114022;
        Wed, 10 Jun 2026 15:21:54 -0700 (PDT)
X-Received: by 2002:a05:600c:6087:b0:48a:8b02:ae91 with SMTP id 5b1f17b1804b1-490c25b0231mr459510675e9.11.1781130113557;
        Wed, 10 Jun 2026 15:21:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm74431249f8f.0.2026.06.10.15.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:21:53 -0700 (PDT)
Date: Wed, 10 Jun 2026 18:21:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	minhquangbui99@gmail.com, bestswngs@gmail.com
Subject: Re: [PATCH net] virtio-net: fix len check in receive_big()
Message-ID: <20260610181911-mutt-send-email-mst@kernel.org>
References: <20260610221606.1091465-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260610221606.1091465-1-xmei5@asu.edu>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 52uz5w6vdU6cuIdczsfJ8EUSmMohfJwfjtqw2pnHFXk_1781130114
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2026 at 03:16:06PM -0700, Xiang Mei wrote:
> receive_big() bounds the device-announced length by
> (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> add_recvbuf_big() sets sg[1] to start at offset
> sizeof(struct padded_vnet_hdr) into the first page, so the chain
> actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> check allows for the common hdr_len == 12 case.
> 
> A malicious virtio backend can announce a len in that gap.  page_to_skb()
> then walks one frag past the page chain, storing a NULL page->private
> into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> write past the static frag array and a NULL frag handed up the rx path.
> Bound len by the size add_recvbuf_big() actually advertised.
> 
> Fixes: 0c716703965f ("virtio-net: fix received length check in big packets")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Let's instead (or additionally?), bound the frags array index.

Seems more robust.

> ---
>  drivers/net/virtio_net.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..afe73eda1491 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_device *dev,
>  				   struct virtnet_rq_stats *stats)
>  {
>  	struct page *page = buf;
> +	unsigned long max_len;
>  	struct sk_buff *skb;
>  
>  	/* Make sure that len does not exceed the size allocated in
>  	 * add_recvbuf_big.
>  	 */
> -	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
> +	max_len = vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_hdr)) +
> +		  vi->big_packets_num_skbfrags * PAGE_SIZE;
> +	if (unlikely(len > max_len)) {
>  		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
> -			 dev->name, len,
> -			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> +			 dev->name, len, max_len);
>  		goto err;
>  	}
>  
> -- 
> 2.43.0

