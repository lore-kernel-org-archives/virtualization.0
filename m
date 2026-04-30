Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E251E8342
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554287; cv=none; b=pUv/2pu1qcXs6B9CXjB6UhiAKyEXPauAZqmbd0kY1sWPeXMRJ/YdAUCug3uBFgPSOUON0YCdPfGLSHi7Iaw/lgZKu6VS/USlI40cE1+5QgMD90x6HSlvEvEPOj/SEMTrXBLiXrxplnQK6UGNtFMOWoJ0/zC71TbfXSd5WxYkvM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554287; c=relaxed/simple;
	bh=Dk9brHbKfFNbGJGzioI4SNCia5lWoLEHi0LrGbaPeqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YyU4KjWOmFhURNRyhJvGj8CE725h2RUEehC5PRYN68ISGS6BcztBhPvpDscE//s+HD4Jm5w97LM/kI16QkLduOj62L0sD7cn6E/3o1MertNvFGrS6UAcVZzq/GiYB/2xKR6XzNwa1nNm9XJwb18PHO42wD3OArZTVb+pwljDKZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGlUyu4r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGlUyu4r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777554284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4iM1C5bPOK6CsY7bMqOIntIdxAE/svN63ooTIzddU6M=;
	b=ZGlUyu4rbOPVnW4Sr1iIvILnB3w43V+YJDxJ1yHvjiV/UlSXj1cD0OAZo3lmAdYseokGMb
	rlgba/lLn2FVt5AmAN24j/uL6hIIk59CO6XG6vRpTIfmaI5REgQK9ORhIsMbv2k7hhCf80
	qkshYq4W3135MLlOzZbdyc+5349FFSg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-M0jDyxOJO9q-IlfTpSThxg-1; Thu, 30 Apr 2026 09:04:43 -0400
X-MC-Unique: M0jDyxOJO9q-IlfTpSThxg-1
X-Mimecast-MFC-AGG-ID: M0jDyxOJO9q-IlfTpSThxg_1777554282
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48919890a95so6589625e9.2
        for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 06:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777554282; x=1778159082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iM1C5bPOK6CsY7bMqOIntIdxAE/svN63ooTIzddU6M=;
        b=JLXly2Wl7euqKhCqDq4k958Jnxk7UnW4pf0k0KN/s215mGn/AIixZVwE/AfeKu2L3e
         RGpZDHk1EqZww2qswDTYwORpiSPEBuyyltRUtX0IT+HvM/Wiqfs4vubPOYRF3edN3QAk
         CO73V0Cj5c167q8WJ/+pRn6Ac1DFjepAv8XAFhJqqA45eZi7dsvJZ5n8or497hB7mQ+5
         sBz6K5wxSX5hvRP84pVerMN1PB3DDwHP2b36h/PZCjihg1WomjderxYXb6VwRMgt9tdI
         OogHYno4oW2K0FuHcnZSYQ1b9owHMpzKXbN0lE7WZxuYB0nWJ+VrRcwbLsNYeajvzHVI
         5V/w==
X-Forwarded-Encrypted: i=1; AFNElJ8kZhtVCkurK5VW45qsnAV6oBvbXz3aUoIdeO8WSfxa51vohZHfq4VcSG+/MHIOIcQq0HsCaes//60DVPobvw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyjr9jA2Jbpsh749BpNJ+v9tn20pkLniii2tQyQ0jCAT9KiOcKL
	Tol4irD+lfACLILG4cSZJbCoZ9bZJBOo6SkuZKHXOI+rDOa4ZFX8hnShLqyrvRvdMjdYbO/YX62
	YtUR5OAJGcEklI8vOd4T68BFyteG/vl8D6IMnOiGgF5G8LT3FlO68fxqXeaqgrFtTkc4Q
X-Gm-Gg: AeBDieuWixZ4FKB4y1FuZRYnTxrSI1/brTXUeTm58ptP8PFZTe4lF599ZbF8bNGqUW9
	04EvQvSWsPLmeNSTpI3khh22AVavMuS4W7hWA5duEdK0fD4C1ceSPVdz2dFL2x/8SHwADQcu1DS
	mmMNUTOp2nYCostRAlN6m3rYRHBC4g7v72YCPIa9spGIMSDdzNHpc80I+3h14obLhdrymbktyjB
	in6/YSJn07T7pDbNkEMD66hiFLZoeOO0qEG/YU9go5/z7KlHNjwQDGZQHiCwb1mLBUbbgO92pY7
	4t9FsgqP6sYg8wdnjrVERKq4NSAuoDisY4v5pMTX8W5m9t8k2Rez7dHZ3rSMkjVsJAWFdBw3gtB
	mg/y79K7yrm7dlcWD7d8Y3d84HAwMsIeYNItS1A==
X-Received: by 2002:a05:600c:6992:b0:48a:56de:d62a with SMTP id 5b1f17b1804b1-48a83d7b059mr51482245e9.11.1777554281987;
        Thu, 30 Apr 2026 06:04:41 -0700 (PDT)
X-Received: by 2002:a05:600c:6992:b0:48a:56de:d62a with SMTP id 5b1f17b1804b1-48a83d7b059mr51481435e9.11.1777554281407;
        Thu, 30 Apr 2026 06:04:41 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301b7bsm71336415e9.11.2026.04.30.06.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 06:04:40 -0700 (PDT)
Date: Thu, 30 Apr 2026 15:04:37 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Yiqi Sun <sunyiqixm@gmail.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stefanha@redhat.com, 
	sgarzare@redhat.com, mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap
 copy
Message-ID: <afND89LDgovPpanE@leonardi-redhat>
References: <20260430071110.380509-1-sunyiqixm@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260430071110.380509-1-sunyiqixm@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ypXkOZV0s8GloNbx68s8VxFJQnnvthdpzcrJuIldUEE_1777554282
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

Thanks for the fix!

Tested using vsock_loopback sending zero-copy packets. Payload is always
zero before the fix.

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

