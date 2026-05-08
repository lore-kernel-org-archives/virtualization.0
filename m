Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A3C3E9589
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258847; cv=none; b=WCvX4d/RiqzNu95LzP07k0IJzJpHjnpDP8wKMkPyFMYCu8VH0AH12JH2dWcFjk1ju520AMBSpRGK00RYJ+brABHMnnEVblaBbT2TyQ9spvSbOgSs9VDpfx6FhvN1R7/vmL8yhHyPfKBe4j29A98uTIwc41KnETnAApQMbDj9P/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258847; c=relaxed/simple;
	bh=+GlTIpRQZ5vV/lIQfJdZ/NWxJDB5jBGX6KC+RdsOsLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kufVHN3W7xJEGkjkUZ56MznJDUq/0y0P91U3vBsRg53wD00Moe9qrrs0UAg14tMfiP9EgpK1/skVXJSy3DtSkbDwcIOf/cwn0Z39J1UzBh8d3d1zWArCu+zfqDXAQ2PXc2/obdcVJIciUATlbh9HuacF2mFQZn60YSRw8kyGeaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OR4brhwQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OR4brhwQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778258845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MA8iF/H4+Ea4mWZn+FttEJhotoY2jxN8mx6SClzyAQk=;
	b=OR4brhwQ3xzVejNYqK3q9qV3JXzFXsHFSb2qURJ2iJ6SpgWVSGfVw7DKg9TyXGa3+v9AJL
	9ekN+Rdp82JN/SBLfJ3FVs81RKZ1o6Oe17x/nLNplTHtCWJFA0Eb5TZBbL7kSlK7W0b+yq
	v1EOoiZGIs6D6FrO5nJAJKzez3PQtgw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-ue2Rgnx9PS2XD4Ch2b_ORg-1; Fri, 08 May 2026 12:47:23 -0400
X-MC-Unique: ue2Rgnx9PS2XD4Ch2b_ORg-1
X-Mimecast-MFC-AGG-ID: ue2Rgnx9PS2XD4Ch2b_ORg_1778258842
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48d127eb013so13199575e9.1
        for <virtualization@lists.linux.dev>; Fri, 08 May 2026 09:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778258842; x=1778863642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA8iF/H4+Ea4mWZn+FttEJhotoY2jxN8mx6SClzyAQk=;
        b=Zgpau4kcXcm4JMQnoH0QsomS1spb4459o0CJ6HA1KTgqoJ+HDCNgcWUUCR3jhutdhG
         ztkXawJfFovqQjhg+Iz0TPqyxyVG7iDK8jSiwBEIIhnbsZV4wxXfIVyWI4G1n3LCKAGc
         3uzdUYF5bXxfqHp2EEM1z+IjQDv8Kc310fyxi6B9ncyNcsHPBstlwZFgy4HXV1eZodk3
         t484e94s3tRvXZH8ogSy9hL+vMK7VhQwSNuukf5X4ONcr3bUq4CuRWYR0OqCx0NABISq
         r0zLREO/O3CQDVdl5pdF2Tum5ronVxO5rcQPfiHNMuokDC61cbyyNwLZtdcGveiRlcsF
         IqXg==
X-Forwarded-Encrypted: i=1; AFNElJ9MX6CwSxaKJ06R7744k1Zep1E1glync6+LtGLDOvkViOKjIFtasIgMIEZQDhC8j276zJ3oGP6mobOfSu223g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSu3h1KyBRNCUfNVTuNbRUONzhgeop6xgle5hUroK32zP88yzG
	TXZXE6NI4kaTg0QESVoGPmoSVdQALu/8en7j5exO9RS3iRsbTzTSkDRtJQp0R5k+7u/9X6wjypg
	B1Gifeef5GTTbMo24+zvN0p/Wedbq+l0otzlCreZ9FaDhog8fUywAG6O4+xK0kiCtJouo
X-Gm-Gg: AeBDievzMTYjgr1f8DtvCmZlrXdTue2VIYPhZvxa4exh0NlrlXZxa70h4de2gmNmwzg
	VaS7PwjYm0AoAvuNprDUJwZZKBXx1DvvnT/lJkOaXwtRnAM8Ezi11Lua6f0ky8SeScUlri6Gr/f
	SA+kLJKT+Wscl0pwb2g6gikI5lFr5JNKMXPTm5Kt4jezEe5v+SgJvnpw8o7Zo12/9Vd66mPSaSS
	XhED6uHo+BxaFMRIbSOwVUKZjKJeXV3TCdLOpiZUBmcH7WWnUVfJHLBFvD5NFogMHFB9w0lLt0F
	24sVQd57WfSi+LowCuxv1Dd1+SV5olGlt2aru1PYmXo/6bdXRxniiDtXoVoqmeyH3cGbYHPnx7G
	UzVdLwIRq0GtvJ6euM30JJFuanuOXQS2aHpDs0Hei8bTXYG13axxrG4cEyk9e9+NGSjM/IHyEPQ
	==
X-Received: by 2002:a05:600c:45c5:b0:48e:526e:1040 with SMTP id 5b1f17b1804b1-48e676b45eamr54988545e9.23.1778258842215;
        Fri, 08 May 2026 09:47:22 -0700 (PDT)
X-Received: by 2002:a05:600c:45c5:b0:48e:526e:1040 with SMTP id 5b1f17b1804b1-48e676b45eamr54987955e9.23.1778258841600;
        Fri, 08 May 2026 09:47:21 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dd2c59esm6805945e9.1.2026.05.08.09.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:47:20 -0700 (PDT)
Date: Fri, 8 May 2026 18:47:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Yiqi Sun <sunyiqixm@gmail.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stefanha@redhat.com, 
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap
 copy
Message-ID: <af4TLgAsn8zS7cGs@sgarzare-redhat>
References: <20260430071110.380509-1-sunyiqixm@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260430071110.380509-1-sunyiqixm@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h2AwaOx6y86qsP6A2iAVwX4cdhORAOug9ffPUjcjRG8_1778258842
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Apr 30, 2026 at 03:11:10PM +0800, Yiqi Sun wrote:
>vsockmon mirrors packets through virtio_transport_build_skb(), which
>builds a new skb and copies the payload into it. For non-linear skbs,
>this goes through virtio_transport_copy_nonlinear_skb().
>
>Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
>As a result, skb_copy_datagram_iter() sees zero writable bytes
>in the destination iterator and copies no payload data.
>
>This becomes an info leak because virtio_transport_build_skb() has
>already reserved payload_len bytes in the new skb with skb_put(). The
>skb is then returned to the tap path with that payload area still
>uninitialized, so userspace reading from a vsockmon device can observe
>heap contents and potentially kernel address.
>
>Fix it by initializing iov_iter.count to the number of bytes to copy.
>
>Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
>Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Hi Yiqi Sun, thanks for this patch, but as I mentioned in the sub-thread 
I found another issue and also another way to fix this, please can you 
test the series I just sent: https://lore.kernel.org/netdev/20260508164411.261440-1-sgarzare@redhat.com/

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 416d533f493d..6b26ee57ccab 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
> 	iov_iter.nr_segs = 1;
>
> 	to_copy = min_t(size_t, len, skb->len);
>-
>+	iov_iter.count = to_copy;
> 	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
> 			       &iov_iter, to_copy);
> }
>-- 
>2.34.1
>

