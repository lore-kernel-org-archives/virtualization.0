Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812473D9699
	for <virtualization@lists.linux.dev>; Thu, 21 May 2026 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383634; cv=none; b=Q26UoacLS4DkIwjcyly3HxdTj7lGqQqD1bHuhinZk0mv8ERADj4pH8ZSfeFQh2db1HTzCYoJZTggJ6pUCMMTO74zrsXQKMEbdfceAQDjKqG7yjX8xDF8UlYI/uGyJvrpENuTs/GtP7o0WJJFGD6tEkS+wkps+QNZKDsF6dh7W8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383634; c=relaxed/simple;
	bh=X9MG1kwNUf8O8KAK/Sm8SuGe/dZdaTwPaR1MzEF3AHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfm+5uXyxTs5kxwB67VZogrKqLk1W+7sTpP2zkbDFDtL23283x605ma0x6vaESpf1tsm1n8nlWGoxFqZGB1NfFT70g1XTIk31rKdcL9I1fCWaPGlm9sg+4f8bfnUojIxhR2Vrv4QIKcr0awYnrmuii7vUldN/igJKBTFW5Lo/V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGlPWo4V; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGlPWo4V"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so89652115e9.2
        for <virtualization@lists.linux.dev>; Thu, 21 May 2026 10:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779383631; x=1779988431; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIuChPU1JlP7AlPyeu7nnCYpBOhiwGUpJRXAIqjmuvM=;
        b=IGlPWo4VSmumFnoVdaO3JjZ/9LRvrqwk9Yypkzt6Oyx+wttcH7qLrbHNZEesZsjegN
         uVradv21Hg0Jd471JhcpBS1cPYkAyx7/GL9+oGhShX0mEU7Nrdc5zoHCLM5hj4werpM6
         k+cNc5C7Z/JXwU/MODWnDiE7WSlcxEnQ5MqaQfDcVHCkXsmD76nnYnCC6vtD5PWcxEej
         SNJXlPEY6fP+V90jgU78Z3sIAsjQVRBiiITvLTrasc0i2p8g/B0eoPBQZidTDjLYptyv
         kr4Wi0+hp2UqzU9pcoMJ6pT+8Fz1Evv8JD8sfHIE1BiUzGqcaEkb2EXg33Zo+c3FYXDv
         4RoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779383631; x=1779988431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zIuChPU1JlP7AlPyeu7nnCYpBOhiwGUpJRXAIqjmuvM=;
        b=jDf6PhroUajuemLce9Tzbb6W0zhiWE7RrsusrMPpLtfUArkGYU2YUAURwuD68k0kyj
         d5+y8vFZ3AKi1M1l05URwCkP3VVXZHtf+20EUzoYj37DqxRsDnHGP4afR4gdeZ9Y1oDN
         u8kTmkL3XWhVoBsUm8aqIxVj/a+ZCuofu5UZWLIDTZK2SP1qdWI+NYVpIbeK7SPv4uBf
         qpI/Da3Rnh2M7JRH7onjZvjK+yrVER6gEeqEGU/4ym+u88Lb7PFwD8wYO75Z6G+zRGZr
         fS7/0M9gjvu5yvAAkcvH/Q/vuhWzWmSzW6ww275lQ3qVcabck0Ih2K0aw7OfArByUl+V
         fDWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/jD+f0zNtGsQ5MgXSDRtIq7Vn4oj/p00xKo07WrN/wroG7F/DF1p69+SPF61ECvibPzYS7ly9W592SXs+g2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcmvPqON6jevkw3Ign6W7SMXiGmXr1NhbH6mHAoP2bxzOxe5eD
	VNPP7Sf+KMgPbmi8Y3Y8M5i72XJntGdgmD9OBzl/1l7kje4WhfE7xG+n
X-Gm-Gg: Acq92OHDi550mTuiOzmA5MtDwMAH7xyUbswVXRx0VZLfI+IXfM0Qd9TEeDqlav6macY
	NZk2mylx6HGdXAZl0lW3WGXAMLUwA5woL8ujt5606F3mQ6vDWG77libTiBMRgdg6Ydsc3dgxz5I
	sz0+q4vavspkHMdVZPwHuggN54N4nvFV9B/OWsmVVmHh6pwbHPm6frMGRMmmSb6sc7TgurkUIuo
	QC7vHU/yRb2yR0hHZFyDqvAMDf1bJhYctboIjx6pS0KxHzeaI/GzTv3N9o6pYxYofaozdJuJBTl
	yfBPMnlM7lim9acp/KJzEFN64pC/Q6xCXFSUHWBwpF4+dUIOQUIYNkPm/kz+iqPvS+40dxS6SD9
	YM9kiFXkNOIa41kXAZDx79OQxtpiVErIjoObmVS93xyR5QvHE3TnxDNT/sGrcVuef/igxxiQ22a
	NUAH9rS3xo3fOD7L3lvwYB72/A+4841SjvUKWTTgtqc8A4stPC2U1vf1AzJzaWFl49
X-Received: by 2002:a05:600c:828c:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-4903606b5b2mr58827015e9.19.1779383630691;
        Thu, 21 May 2026 10:13:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa7cf23bsm4086708f8f.5.2026.05.21.10.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 10:13:50 -0700 (PDT)
Date: Thu, 21 May 2026 18:13:48 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Simon
 Horman <horms@kernel.org>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Dumazet <edumazet@google.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <20260521181348.3d61858e@pumpkin>
In-Reply-To: <20260521124732.125771-1-sgarzare@redhat.com>
References: <20260521124732.125771-1-sgarzare@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 14:47:32 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
> to 32-bit values. The multiplication can overflow before being assigned to
> the u64 skb_overhead variable, making the skb overhead check ineffective.
> 
> Cast skb_queue_len() to u64 so the multiplication is always performed in
> 64-bit arithmetic.
> 
> This issue was reported by Sashiko while reviewing another patch.
> 
> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> Closes: https://sashiko.dev/#/patchset/20260518090656.134588-1-sgarzare%40redhat.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index df3b418e0392..71198bf23fc4 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -417,7 +417,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> -	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> +	u64 skb_overhead = ((u64)skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);

I was thinking this should use mul_u32_u32().
But that is all moot.
'skb_overhead' is a memory size in bytes, 'unsigned long' it more than big enough.
No need for 64bit maths on 32bit.

-- David

>  
>  	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
>  	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff

