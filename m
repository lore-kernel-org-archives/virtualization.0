Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA81937BE6A
	for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654985; cv=none; b=gPhZcSX6ZDASCKEzsR8EO6vxn4NmFpQ916aqePAbTV5AVu4IthCX3eEXVXuw3AQ7vlWvnaRAPXjCT0iBmhKMyMiBjagNLUwT0Jp5GX3myTOBAwJ76Bxj9IzANhDpjRU70uYKmQX2V6FhSWq7nXzgmcmlZScLQugq7oBMalkf+CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654985; c=relaxed/simple;
	bh=QTOs2akWd78BcczwkDDLLxY3jOM4b2hdWX+lrEFzrTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Nz8qLrCsUfBxdZqvDgvpA6wf2nNrf0hcCpchfBJv56HqzyCRN3tRlwe9aawpIi8VfyKWAXm1M1KPL9hulqi3h7+O32eV6B5lAQHy9IrlQ7/rOhf041FWBwgWmH/B3ZbZCLjTus9iCZuF0v3ydc3a+WkgRtBO+Fa2iZ/SZQNbxOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWflSFEb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWflSFEb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773654983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QAVRmEgA2BSDX5bYHZyyKUZsGjR3EOuD2wkxuTEaH2I=;
	b=XWflSFEbzN2kHhXV42SumVoISRScfjfOY6HirALIvbb4X2GjRsdXQQBt2QuO00b8RDgSwY
	fbH/CjNyIV0GvAaZEzk63QL348Ed1x8v23Ha1KoYfJjt7B/wNs5z2wj+lhWWqoR0W3AyDV
	mBKIFZ3MB4JNuW0UP74IeFquJU3mWLg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-h656KNlAMQGUSB6Y_Jgj3A-1; Mon, 16 Mar 2026 05:56:22 -0400
X-MC-Unique: h656KNlAMQGUSB6Y_Jgj3A-1
X-Mimecast-MFC-AGG-ID: h656KNlAMQGUSB6Y_Jgj3A_1773654981
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-483786a09b1so43614365e9.3
        for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 02:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773654981; x=1774259781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAVRmEgA2BSDX5bYHZyyKUZsGjR3EOuD2wkxuTEaH2I=;
        b=oA35dM9LlzMkp5L0nO2ZmP9YSDLAYNScHbEgBc5GmghWyAktlfOTLpDheUspZeIOC9
         MATThOuKM2W5vwkh4wtD2i0GFXnTsTD1Vvo7iczm8WMNDgMpbjkWQ0lFhMmYpJWk/YtI
         Sr9/UtanaOPWp1UkIWc65lh/c+7sNVvZKdomaDNv5VmGIws3KkQEJboP7hEBAt3XKUlW
         MiZg9NBH9qtcHDI022SpPCsewK4HvwFgN1f6O/HqJHWChSt5DiYl5bLGHNm/OieRQcBR
         kS1SHNAA6nl0S4db12k1jbnLqXnuyarBwutRA+a1XqJoUXiLMp7/hLvS8DdOGWdmzA+T
         pGsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB8sUnzfU3AS/1xjMUMoU0RB3uB0f1Pa/u7vqdC88pop9Aq3iYR/9q2C7g785fdnUwjBTxeRbDbRl0+I1RVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YytThkWrq0oFhWKn7mS/44gOCmK/EW87Csi5E5ybI73Q30FthEn
	yZgp+7ovy5uGP4NY6yodmE13EZB/7ZSXgKf31G64Fwq0NPnuQ9f0ahsZg2cd0+sSTwK5C/j2nbo
	oBSvl4DgBHxG2OkqRnqHXbyyFbgpzzhfMujWoJRwHwcpDWOSjDMHQixw4IckhRQdgX3AQ
X-Gm-Gg: ATEYQzxUDz6DW9VNqJyevhmBhAJAZYUqLwJPUbw+1nkBuk4QtUPlaCoo0V64uYe3osl
	TwXpY+iKhdaTk9ZIbTLYel5qR6KDqmm74DZZB//aobJsWxCedqhg5obX7/YWtqtmUphUhQd8HsB
	M8HpHDTobdL7Du4XzbwFLxwZITTPYbos6dfN7eh7dK02v1WLryHWY/1DvI1uFm2/paEBNTi8OeQ
	WAxNEnr/s5aYVt5Ot8ujikqtUZH4LgBVtxmuWI1L6YPmJ7kzzNahsJfrg/aCSv/XIP2mBQw8chl
	O1XCD/hWy5EC7twvJPSVafzKcx+VK50TohAvJkIHT2Trpisd0pbScDFsNbf9NNuRpq0XKHimUea
	YuLlQ1f9XlqjLfvcPNTRev706QqosrNrzBWbUuM5fW96p9w==
X-Received: by 2002:a05:600c:4586:b0:485:363b:fafe with SMTP id 5b1f17b1804b1-485566c6a15mr212112815e9.1.1773654981226;
        Mon, 16 Mar 2026 02:56:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4586:b0:485:363b:fafe with SMTP id 5b1f17b1804b1-485566c6a15mr212112255e9.1.1773654980698;
        Mon, 16 Mar 2026 02:56:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f708sm889800085e9.11.2026.03.16.02.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:56:20 -0700 (PDT)
Date: Mon, 16 Mar 2026 05:56:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for
 buffer allocation
Message-ID: <20260316054232-mutt-send-email-mst@kernel.org>
References: <20260310183107.2822016-1-vishs@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260310183107.2822016-1-vishs@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gYtOeblTXGglZnDiFGVm8jBYEGmiiw4M89lS8JajQKg_1773654981
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2026 at 11:31:04AM -0700, Vishwanath Seshagiri wrote:
> @@ -5857,7 +5863,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
>  	/* In big_packets mode, xdp cannot work, so there is no need to
>  	 * initialize xsk of rq.
>  	 */
> -	if (vi->big_packets && !vi->mergeable_rx_bufs)
> +	if (!vi->rq[qid].page_pool)
>  		return -ENOENT;
>  
>  	if (qid >= vi->curr_queue_pairs)



It seems that a qid that exceeds curr_queue_pairs would previously get
-EINVAL and now gets -ENOENT. Maybe reorder the checks:

        if (qid >= vi->curr_queue_pairs)
                return -EINVAL;

        /* In big_packets mode, xdp cannot work, so there is no need to
         * initialize xsk of rq.
         */ 
       if (!vi->rq[qid].page_pool)
               return -ENOENT;


Alternatively I think we can completely drop this chunk: we already seem
to init page_pull at all times except for big packets mode, so the
current code is fine I think.


-- 
MST

