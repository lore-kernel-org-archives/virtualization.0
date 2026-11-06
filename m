Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977463;
	b=tszjEkegFUfcEFU+B7keBMmOkNKCa62ZosbZgr4ICvuDZze8QaKV9c3dMbYiguaSq5/C
	 eLPO78AzepvfsZs2ArXXReAD5nE8LB89xvIZsZ5pJhSeRM0jZs5pPHfCsVvZ3U1aJFP2u
	 C66sqC9kgQeCLXrLb+LzFlJ+K5fI6EsqaxnklvZI6Pg2JzoSQL3cYcsMf/GKIj3PJhPFl
	 P07nAessww5nJbCS+xV+Lo18KuiUHJ817oIF4OPoA9XR4RqPPdBc7jdyisna+WBOdmpCK
	 /OcMFIgEO0neVfS+PMOtRPV2GGJScA5fkAhBFHvD4xOP/zoug+7MOUp7xVHgL3DHfAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977463;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=VFHEfM7uSHxmbeEDYFc714iPr6SLeYV/p8Cpk1n20G0=;
	b=JSy9GYvYqEnJc89ZDk1gY8RjoRxE7/iiD6UJll7CtIgZG3uuDNsJgxBdp8DKOAB83bzs
	 i1pL97cxEdVC/tuQ5OPoFFMvNwh8/fpbwGCUmud1VqbeJmLSfVIC+dgwpZdPAYstsskWN
	 q41zSfRIPJ5o3qNjEjfNnt7A+LWsXpS0K3gXLurakWC49Fgf/OgTPjGqT9HDp1jU8IOTt
	 a3Uy4654Yloxu1rycbkD/A+GdTLzXbNY/FXXUY9ySbNVf1aWYwUr2Ndyt3C4uBXA/ztLD
	 f8NTZCANfo2rdJbq48V+advPnu2ZIv4u3uHj2tk4MUmOcglgkCT8Wyov9k1x3eqBWQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YWJI0aR8;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180B3606A329
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 15:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 180B3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YWJI0aR8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793977462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VFHEfM7uSHxmbeEDYFc714iPr6SLeYV/p8Cpk1n20G0=;
	b=YWJI0aR83JkRMYKC0xUEf5vevtX22MosZC0Oecjg+f3OnI1AzAu5y0AbeQ+nnnrl0dbVTy
	zZ4ilrR9UXX3PZMpj4qOjXR5a9A0numo2IMEuW0CPNvW8VecPl3lo+CsGzCfyrSNrE7V84
	Y4IO5afjsaMgUNEZKHibuxJSXkSqjpM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-A9fL8D2yOrynv_swuHImyw-1; Fri, 06 Nov 2026 10:04:20 -0500
X-MC-Unique: A9fL8D2yOrynv_swuHImyw-1
X-Mimecast-MFC-AGG-ID: A9fL8D2yOrynv_swuHImyw_1793977460
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a359c7f47bso7402805e9.2
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 07:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977460; x=1794582260;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VFHEfM7uSHxmbeEDYFc714iPr6SLeYV/p8Cpk1n20G0=;
        b=aAzucE3vwOpMS3VhN9Trh588ORT6j68E4VplChagEX5nvT3kEHJ4ANi8fd88LwxLaV
         e+kGe01Txxl2bXhT6ScO5ht7IVugRNG3Wrtk0PpWWAddbS26yDPog1XO9xdiSnWDSGKC
         EFho9Mg7au47x1sYNqwSo0xj+nQhwtCHjdjYSXjJRo7QvgcEJCHNj/3jeB7dcs5pbwy2
         IFoA9uwFxdRA/s62nykzCQL50ISAfzbb0BR1OdrPjulNpjjCj09LFqqKnQsGcBJ+F4mT
         4CiJp2Ou61xc68VztAIaVm5NXmY9ZjQUheJds8r2H6lHq0pYYGbBAiNgV1BoCasWo9Md
         bGog==
X-Forwarded-Encrypted: i=1; AKwUvBwBUTBWp++j6WiiP92pNduRCFNSCOfOkkyi+gselAZNhqG5jbjsvszo25qThqCDtz1KzE2oKBSFqonMfJbYow==@lists.linux.dev
X-Gm-Message-State: APuU4Z8m9TXxCokpIJfsY7Z6GuOaU2ToRG3VA8+6vjyx0ZAxGCKuTVbw
	GknkbIJyfkXmtsjJ0NVZDQTwdB3A945C7dDzcAzv5P56SnzGyAx+wg6F6zPxa8nPX7U5tqHDFUE
	Ube+N6t12jzgzT7KPC2lU5S00cVF+KYNW5wwM6IB4BzZB/xY2d4oSA/AJiHBKZ42f/fNl
X-Gm-Gg: AYBFou2etWXEAKnzbVoXZVr6dIyw3zwyRDYW10WNLrFi0ZBsr+3Ux+xJ5uoY81p/TtE
	cy5Gtuxk4f2RL2nPiGZ6V4EKO/1KnxxVg280ADlh/6gXZToL1XrQQ5wI62VQ6+FUUdUdJbIfBXU
	UKZepiNFJ3V3jJeofMWPBjYDs9RX2ffw3OzodZnPX18AwXZsfPFpsCN1MYKCyKzi12pf3/ZANmq
	po3WjaaqkLnQP1u4Gs8MyGMK3J29MPOhUTQzYWoZwP+u6szmXk8A1C1dkZRBWuajfL2b7+gNHcK
	DqXMhH9AJrlVL9OkhhtgPILYHVAhxtPLwMhdOQ+TEFj8lMX5W6aWmPbTscBSONMEUFp+rAQGuM+
	gBoHH9Nz6DLLKlXhuqblApRcxMG4izyLceABKJ9xCxs+CKzEf8okRZuJO1hIk5cOn0s808caGFx
	FZx0NSuAvP
X-Received: by 2002:a05:600c:37c9:b0:4a1:e0d5:293e with SMTP id 5b1f17b1804b1-4b6df8c9cbbmr42830125e9.21.1793977459557;
        Fri, 06 Nov 2026 07:04:19 -0800 (PST)
X-Received: by 2002:a05:600c:37c9:b0:4a1:e0d5:293e with SMTP id 5b1f17b1804b1-4b6df8c9cbbmr42829535e9.21.1793977459116;
        Fri, 06 Nov 2026 07:04:19 -0800 (PST)
Received: from leonardi-redhat ([176.206.36.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7626a2804sm29251095e9.4.2026.11.06.07.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:04:17 -0800 (PST)
Date: Fri, 6 Nov 2026 16:04:15 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>, 
	Xuewei Niu <niuxuewei.nxw@antgroup.com>, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] hv_sock: Report no unread data before a channel is
 available
Message-ID: <au3sW3i2qjKDLMzq@leonardi-redhat>
References: <20261106123920.162131-1-parri.andrea@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261106123920.162131-1-parri.andrea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gT9RktGOkliiEXl4yVoZHpSAP42FLQ5xBRwISwEkcR4_1793977460
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Nov 06, 2026 at 01:39:18PM +0100, Andrea Parri wrote:
>The Hyper-V transport is assigned before the asynchronous VMBus channel
>offer completes.  Its zero-initialized hvsock therefore has a NULL chan
>until hvs_open_connection() associates the channel with the socket.
>
>SIOCINQ can query the assigned transport while the socket is connecting,
>or after connect() fails once the transport has been assigned.  Unlike
>poll(), that path does not check stream_is_active() before calling the
>transport's stream_has_data callback.  hvs_stream_has_data() then passes
>the NULL channel to hvs_channel_readable_payload(), and any user in the
>guest can trigger an oops:
>
>  BUG: kernel NULL pointer dereference, address: 0000000000000178
>  RIP: 0010:hvs_stream_has_data+0x23/0x120
>  Call Trace:
>   <TASK>
>   ? vsock_ioctl+0x74/0xf0
>   sock_do_ioctl+0x42/0xf0
>   sock_ioctl+0x27d/0x310
>   do_vfs_ioctl+0x700/0x810
>   __x64_sys_ioctl+0x7d/0xf0
>
>Return zero unread bytes when no channel is available, before accessing
>the receive state or ring.  Leave the existing channel-backed receive
>handling unchanged.
>
>The oops was reproduced on an unmodified v7.4-rc1 kernel in a WSL2
>guest with a small user-space program, available on request.  With this
>patch, the program reports zero unread bytes and the kernel logs nothing.
>Other vsock_test cases were not run, as most of them need a host-side
>peer.
>
>AI assistance was used to identify the issue and develop the fix.
>
>Fixes: f7c722659275 ("vsock: Add support for SIOCINQ ioctl")
>Cc: stable@vger.kernel.org
>Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
>---

oops, thanks!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Luigi

