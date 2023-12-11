Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA7D4BAA2
	for <virtualization@lists.linux.dev>; Mon, 11 Dec 2023 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPW1sWhi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702309639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IZlJdJgXVbL3FV2sl0lv/ikQI4rT8wZ5WPDilRcK534=;
	b=XPW1sWhiFLaQ6yVI9Fx+MDv9FzNPy2CRgfE/rwNegy+gNvSnoMM7XF7UiwcCrvAG2UjOqj
	XDgrIcZ3VUtYVt6IxFqDwHJVAGdjnISxETQAFRwUOKveiOpsy200P4Iwq9cxo15llvVLYz
	0w8AV8g9QRNgLj7FF9WuHPsioHmYCOo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-gvkwK0ubPC-AQp_KgWYu_Q-1; Mon, 11 Dec 2023 10:47:18 -0500
X-MC-Unique: gvkwK0ubPC-AQp_KgWYu_Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40c3307ccf4so24717085e9.0
        for <virtualization@lists.linux.dev>; Mon, 11 Dec 2023 07:47:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702309637; x=1702914437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZlJdJgXVbL3FV2sl0lv/ikQI4rT8wZ5WPDilRcK534=;
        b=a8guVHUbowfmJnOOMSPPIq0k3diITTTT7uo5OS01ZC2BGCJe5vh6CZlUyeHxCtI97Z
         RY2+icYg82Sht3tq/dEO2EJmfcZ+9BzkifPBqlPiB7rp84xcHLLX+albh0/nnliDipCy
         uVvQje1Vbg/4EI0x/WRqre468fmQ6VyaKohfgAKfJ8TPCsFIgEJzP1cq+TZhu7sxr4Q5
         rWjZu4xxj3iudqoB6WOMsc2ZMH0C+c4VECCUsJxLugW5/XfTKt6U64W2JvjrDU9tCe4Y
         Z+ar5RWRk62jCCrhYjYDJU9TRHZaJjCNQly1bf+0gfmZosRQsdhAhu20lv+slOxFZMfi
         XwhA==
X-Gm-Message-State: AOJu0Yyl173XaCHAmoDylHQ37lkowEvSWQyV0ASbI8nnvRVu/15J1vUW
	NtytaAiCzxbGHz0RGD8wQU+1kFZYvhOBSG8AK+kyg4phYT2IONiQlQOC5c3X6leISti9H8DyKcy
	6s0MOvUXPwzQWDH4t2x7b6wyAKJU=
X-Received: by 2002:a05:600c:1f08:b0:40c:3e98:5309 with SMTP id bd8-20020a05600c1f0800b0040c3e985309mr2116102wmb.98.1702309637340;
        Mon, 11 Dec 2023 07:47:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpH0te5s/Q1Xr8W7VeRGbO99gtL3UMDIEk2Fm7MvD8T4ecMB/fJcg5Sa0456ul8XolChfdVA==
X-Received: by 2002:a05:600c:1f08:b0:40c:3e98:5309 with SMTP id bd8-20020a05600c1f0800b0040c3e985309mr2116092wmb.98.1702309636881;
        Mon, 11 Dec 2023 07:47:16 -0800 (PST)
Received: from sgarzare-redhat ([78.209.43.40])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00405c7591b09sm13401013wmo.35.2023.12.11.07.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:47:16 -0800 (PST)
Date: Mon, 11 Dec 2023 16:45:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: Fix unsigned integer wrap around in
 virtio_transport_has_space()
Message-ID: <t6mnn7lyusvwt4knlxkgaajphhs6es5xr6hr7iixtwrfcljw67@foceocwkayk2>
References: <20231211142505.4076725-1-kniv@yandex-team.ru>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231211142505.4076725-1-kniv@yandex-team.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Dec 11, 2023 at 05:25:05PM +0300, Nikolay Kuratov wrote:
>We need to do signed arithmetic if we expect condition
>`if (bytes < 0)` to be possible
>
>Found by Linux Verification Center (linuxtesting.org) with SVACE
>

We should add:

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")

>Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index c8e162c9d1df..6df246b53260 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -843,7 +843,7 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
> 	struct virtio_vsock_sock *vvs = vsk->trans;
> 	s64 bytes;
>
>-	bytes = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>+	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);

If we respect the credit, this should not happen. It can happen, though,
that the receiver changes its buffer size while we're communicating,
and if it reduces it, this could happen. So yes, we need to fix it!

Thanks!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 	if (bytes < 0)
> 		bytes = 0;
>
>-- 
>2.34.1
>

