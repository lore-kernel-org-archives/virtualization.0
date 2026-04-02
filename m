Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EDF3E51C5
	for <virtualization@lists.linux.dev>; Thu,  2 Apr 2026 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135313; cv=none; b=FfYyFnShacXVUkr1VlWsmChE4iqIFWyyB3vVS/XjmfUu+U1pj//2nlCj2HvDpwKnjPn+Nlp7cgQ6vBm1WGVeoHAFj9yA2ARivWH5e8cTQbQXTiN2rizinSLJHA4qy6SCoRxScM6CJCA5FmwhV2xouOusW23kbZh+/EjA9JXrPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135313; c=relaxed/simple;
	bh=wm02E3T0a1peGSnmnmR4/hZwBTf9XgjeCN8sySv09FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jtS6EnxR2bOhmTeYd1AdLAy5ASmPjVPJUxPTtXbEJeK7YnPYfdeoXY4A5tQky+pXnpG7PF8XxpPaR1u6tDIytI8qNYlBDyopZUH/WH8IMV7GdYQdMKz37QLA9bq0Q+LXeQ9w6u8/x6llDI2INYC7qFIaDk67QLElSNIWo6YNDM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xr2GyAt9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xr2GyAt9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775135308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/AYnKJRH8mdswMQLrHJ90PhRLOmS9dKac7jjdIwogo=;
	b=Xr2GyAt9Jbc6RMafb1malf2z11tv03vn0ECDjXNafC1Y7hAPhs68S1tKbXe3FY06SzgQMd
	FNu1nslpexwwjyr2/AyfQeLquuaDrZj1OSe8I8k5RADAnRJQl4bzqZ9Xed/M96CbRFncZn
	pFlpZxMqIYV9+9/2lD1qef6zp00iPUo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-H_TTmFrjOpypLuQls3ahLQ-1; Thu, 02 Apr 2026 09:08:25 -0400
X-MC-Unique: H_TTmFrjOpypLuQls3ahLQ-1
X-Mimecast-MFC-AGG-ID: H_TTmFrjOpypLuQls3ahLQ_1775135305
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so18951025e9.0
        for <virtualization@lists.linux.dev>; Thu, 02 Apr 2026 06:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775135304; x=1775740104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/AYnKJRH8mdswMQLrHJ90PhRLOmS9dKac7jjdIwogo=;
        b=hE5PYMwawqb0U3BaxMX7Sus2NAOrNz0S+BuVzyUlV3mxDpPXj4v1d+vSY9RLfOtTLv
         3JYDWwYLhfkzJpmhreXe/Xl4yhnsqcujai3oxaWkkeWR+Z5Sg2YdSJVXXe6mp9fAH8m0
         Iw6WDgdewGOHgTyA1YCUvKz+yEAEdj/QnDIsRavP0WPuQ7Yvgm+Ykj/C9oGhp5pklXwP
         n8jTDayFtmvG8+QejTKh9yMt7z5tPaNuf734AYiAXJAq43lpuHtVpAuCT8Ehlp+qxH87
         +JnlzZkdCXEC5SYOe47QhssCxCkT2N6c8RNt2BrU7w6p4xNEEAv2EZmZHVRIguyffe2Z
         CKBg==
X-Forwarded-Encrypted: i=1; AJvYcCWcMN8arf890zeXjP9k0/0ECwKKuT7g/xWoB7N0/S1GP53DyKAjs4Zde1g4uXKQUwL02/0OQhbgahftEogMNw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7668D3HIMNQucmbc/1v28fzXNEodCCFBGTMjtHqWMRBhyUSFn
	eYJnCzKe4wWWGjW0/6H4izSGAj1eyrRRVR0HfYFm/IiPcUQPSkYveCaozqkNWSyaGb/Rk368cKf
	uezm7Exw4nRkCClXq/mQbTb57vSb+GyboKIUvis2jD66XuSpiPPf7Xoqsmjah1MmUvkdQ
X-Gm-Gg: ATEYQzxG5lhitfoDIueWY6Z0b0nHt+z/Qwj9HdTdo1p9nwZy30XN0IuUw+SfEpUaiE1
	IoRpmwuX3FrETmhwyl6PNy+CK1+h+S1HTWJ6UKxcihIwd6PQqfksIz0BnENlJ1fkCtoLds53Tia
	slJ0bkxikTArnS1aUCPjXqbyG1dZYypCTKTVnjPXARKX9eMz5/T9Ed3+rE5NAe8eY+sxN5qlNPn
	VXJxcQc9zAShKZSwNsbz5RbFPSD9tgi1jfJL6QewBAcm3ib1B/y8jEkTQlVJYmMcA/094nlzvn1
	YOzQTOs7BJfQorIAU2urARzUL3OIHeF/3Uo7VSSkBWoyS9LuPEM860Pb4GZjTddAr9x0kNFrbb4
	f2pLRW90cjzafP/NTnJZiOOA3CBAQeZZbWNtB4z06Nc/DE36gXU/MYHgCfVsWr8J6MDWokx4OQn
	RX
X-Received: by 2002:a05:600c:3496:b0:486:fbc4:8fe2 with SMTP id 5b1f17b1804b1-4888e0e47damr36924965e9.15.1775135304497;
        Thu, 02 Apr 2026 06:08:24 -0700 (PDT)
X-Received: by 2002:a05:600c:3496:b0:486:fbc4:8fe2 with SMTP id 5b1f17b1804b1-4888e0e47damr36924105e9.15.1775135303929;
        Thu, 02 Apr 2026 06:08:23 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e967badsm251669415e9.14.2026.04.02.06.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 06:08:23 -0700 (PDT)
Date: Thu, 2 Apr 2026 15:08:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] vsock/virtio: fix MSG_PEEK ignoring skb offset
 when calculating bytes to copy
Message-ID: <ac5pVRhTSc0Xr2xy@sgarzare-redhat>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
 <20260402-fix_peek-v1-1-ad274fcef77b@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260402-fix_peek-v1-1-ad274fcef77b@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v3FDBjcBW8jmq-UzF1aMh5P1mlgkWfMTat70y6iKBj8_1775135305
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Apr 02, 2026 at 10:18:01AM +0200, Luigi Leonardi wrote:
>`virtio_transport_stream_do_peek()` does not account for the skb offset
>when computing the number of bytes to copy.
>
>This means that, after a partial recv() that advances the offset, a peek
>requesting more bytes than are available in the sk_buff causes
>`skb_copy_datagram_iter()` to go past the valid payload, resulting in a -EFAULT.

nit:

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#14: `skb_copy_datagram_iter()` to go past the valid payload, resulting 
in a -EFAULT.

>
>The dequeue path already handles this correctly.
>Apply the same logic to the peek path.
>
>Fixes: 0df7cd3c13e4 ("vsock/virtio/vhost: read data from non-linear skb")
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 8a9fb23c6e853dfea0a24d3787f7d6eb351dd6c6..4b65bfe5d875111f115e0fc4c6727adb66f34830 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -547,9 +547,8 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
> 	skb_queue_walk(&vvs->rx_queue, skb) {
> 		size_t bytes;
>
>-		bytes = len - total;
>-		if (bytes > skb->len)
>-			bytes = skb->len;
>+		bytes = min_t(size_t, len - total,
>+			      skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset);

I think we should add some helper like virtio_transport_skb_remain() or 
virtio_transport_skb_bytes() and use it here but also in places where we 
check offset < len or offset == len. But maybe better to do that in 
another patch/series for net-next.

This fix LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

