Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518F72D59FC
	for <virtualization@lists.linux.dev>; Thu, 10 Jul 2025 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752141478; cv=none; b=CFyr6vNYIUzWUGZlxKzs/HzS83d1HnGbM4Ah0ztCIM3iDRUxfacTWB9hRf09yOz9ts9+LtxjUt7csWJ2Jto+a852yAx0+JkR6PztlZYj70WMejgx6j2siuiMsjCi0Vh34aOW19q+aG9aTuKZUEq0ehjR2oUB0DrxYlUyA09VpC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752141478; c=relaxed/simple;
	bh=7xwliJkVJ22YY86sSCdm9ttnnURaGoeDVbNMIvocjHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xn/HIdWnm1LEGAOs5HxJvkXTriWDpJwkEHBtTndLJW4wKBvtGlSSKNGLwr6Lxl42HVWkEC+mEw5c3ZH6le9FftI5dwd0NNQqnTFKXx4aSxSM1EHj8W0rUMKImUYjquHnBadI49TSoBrwfwzI+U6ZoqJmJao1QDyivcPyLExD/z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEf24AUD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEf24AUD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752141475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDPcEVJCGuQNOn/llIxQqC/tDyrkofeBP4MHIQfFqcE=;
	b=PEf24AUDtER3ujJx7VMT8lU77VgIGFoIErjogDRG4B9nDjJvzAW9RqS3YQANqTwKpOMHrZ
	oOE2KFf8KgRB1VJLVx1n/sxX0JSjYe8rQES8NbXG67Wgmd+YdFQBngAlhRNr8FwTecV9dE
	K54rKriZs7JDaBgo/3DtgEArvr6idHo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-2ZxlF5kmOEiJ47b5Wh9PDA-1; Thu, 10 Jul 2025 05:57:53 -0400
X-MC-Unique: 2ZxlF5kmOEiJ47b5Wh9PDA-1
X-Mimecast-MFC-AGG-ID: 2ZxlF5kmOEiJ47b5Wh9PDA_1752141473
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-454c2c08d36so5637595e9.2
        for <virtualization@lists.linux.dev>; Thu, 10 Jul 2025 02:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752141472; x=1752746272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDPcEVJCGuQNOn/llIxQqC/tDyrkofeBP4MHIQfFqcE=;
        b=rmp+IDDuYRVlj3rfqUTwj6zeBXXf1bMuSpgQHfX2t9ctqtAGH3rPavyrvLBo1tcC3x
         x9QLhwgLVukTb0/KPqjhIomP9NfNDVWvYyY2Kzhm+83Z7GXGSrxFVJ/91FOd/vg5l8LS
         IEPAeiMyv6Xv1LaJ2D7mGEPEHQvPl1hOSG1JLQ1FMRYlMadEy7TLe+FpwkWP4D9zSvj+
         kYZ9YOBLBbKzuTlxvlxCPVG+PuE62/j8iBlQrCiNGbywSFry5Gq9XzGYpR01q2emL6sF
         QPB4+RKadwHRmnpiR9NdnkTXvF81SpJzS9djv7cVUYX22WKp5yTNnhmz9W+lMSkoMtfx
         BtMA==
X-Forwarded-Encrypted: i=1; AJvYcCWbgRZioouytoXryivy5/rRVVD0JKGWoJ3Z5aG8HIw+BnT0kDc6NC2q2mT29mKo6vPFrs+qd+yvwh9K9Yi1GA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzR0p1yrmBkURnLiXgnh0qeDgABVcBNJmK2hPyVZeZdl10Tpb/w
	NS+c89EqBpqiKHc/mYmyTqMQtGB7eFXAuhc+IXzf9vCbVkDImfN3yweyFZCXqzfQDfSaxX2n4eZ
	tqQj9eGrSRDVcv+s6+trJ+KnqxWIn/U4tHvDTCghtacXX6TraU7u5VHVxy79wyMMxFmfH
X-Gm-Gg: ASbGncsR3l6QRqgzmaql0YEfDrxfPhVf9mQnM75t8FqkHb+AxJoFYQJC+eZqRrVzapM
	isZyra3dXuWjpN2G7yo6PFNOa3Q3KOjn3g3bn5fGTOstFhUmQBXrMtJ6WiN5iYEx2hQmw9T1svj
	JqvSiwUYD/VfJxx70lt0bf+XvKVVt98MRMYosFoMCzDR/WrxptsFd8mQumYBfQxtGtIVIv8iITO
	BCOAGtwEKs/Ie1CW9XPz+NtqscVmtE+A740mL/C2z4p8Bozi7hdQa4fcUXDiK4EfiOFPZI/Hjfa
	JN+8MyycXi7OA+o398QA9RjjaZutOo3jbrjY36oF3jQYTGkdUaoas6nT0nvEynhncCLTdQ==
X-Received: by 2002:a05:600c:4705:b0:453:59c2:e4f8 with SMTP id 5b1f17b1804b1-454dd1fbc3cmr18100415e9.1.1752141472571;
        Thu, 10 Jul 2025 02:57:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIJdl2it7UMshDGjV9veVJZFAmJkxwLppeIY5QkUEZVKY+WX/0RWzk+iU2OR29VnHls7guHw==
X-Received: by 2002:a05:600c:4705:b0:453:59c2:e4f8 with SMTP id 5b1f17b1804b1-454dd1fbc3cmr18100095e9.1.1752141472067;
        Thu, 10 Jul 2025 02:57:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1ecbsm1422399f8f.25.2025.07.10.02.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 02:57:51 -0700 (PDT)
Message-ID: <d808395d-2aad-47a3-a43a-cf2138d1d2b1@redhat.com>
Date: Thu, 10 Jul 2025 11:57:50 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] virtio-net: fix received length check in big
 packets
To: Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Gavin Li <gavinl@nvidia.com>,
 Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250708144206.95091-1-minhquangbui99@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250708144206.95091-1-minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ukVYdbRojWC_yjSIvqNk7yQCPrjn8pjCOTvcnlVpMXE_1752141473
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/25 4:42 PM, Bui Quang Minh wrote:
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

Minor nit (not intended to block this patch): since you are touching
this, you could consider replacing the BUG_ON() with a:

 if (WARN_ON_ONCE()) <goto error path>.

/P

