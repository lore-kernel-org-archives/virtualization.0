Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712824;
	b=KFQKLN+tjtWN7RTgKame1YqrmDKAVLZIDoi4/bDYcn4BZhx+naGcX9sYJtfqVa3YPfmE
	 3z0mWjia8NNFRFbCJHuQ6Ej/IZh019Pt144Uw81a5vOwF1AbSOboXy+A92xFetry2fq8J
	 hkjMs2Gn8lz59xdUZ7nelIfTkDZGdS5NhrdWpnEicCsWU+ZYEhos9qo4vS6PWYDTtI17L
	 ujTom2tTJd6O0OB8Py+AoPVW1PlaGw+LYEDmq9Rf4x/r/zAp40kAz7UZHuUgmsGfveznY
	 pkdpeoV0ykc14LCvEXGDhhIv2ATxMcXHKyGSPX17z4zZeWIm888bLzNUq9i/7YD1Ttg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712824;
	h=DMARC-Filter:DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=0yjxrZbpz1L+siRYyu7F1RBOFIChPAKyEA33AawY46g=;
	b=1bGXz24MEph2VfAd5liIKcRUE3w2DuoYifddsVP1jIsDTcCeZxr1IwXKQzdN/NnaDHLV
	 LzvkyM1/I5lmTgoIQR+dWY1Xu/XqF/chgOJO1xP5n9KZLAqT5VUm/PRnaY9XpXW1E4UIB
	 AgJ9B/d3IAMuxgFbqvgO6AUFcHCqXA9/BDeA64O9zmxuViTR1eZ5MhKDGABXLlXxFXFUN
	 fCMWZUQ/W+wbWSGXK94pBUNc8Wh4SKhWjxF7WkBzfTx0cm3X08nC6ScqtZdCQmIePSCS4
	 JbkHgnysq9m4zhCl09IC53jggqitKdS7kQ2fTfi28u72OU2l74l+Y4KyWGk99squv4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T2PpxdWp;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A784606A687
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 17:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A784606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T2PpxdWp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795712823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0yjxrZbpz1L+siRYyu7F1RBOFIChPAKyEA33AawY46g=;
	b=T2PpxdWpFJXNGqRPq5/ChOL/qARiztnKpvfnDI6eYY2iZDcM9w+VwEG9I2g0tTha13q7/y
	T2WzMgpc3SZ8mcRlm1haY+gisICsSkQXeW1M9tCM5NgVa9nPQ/XmqaRU7egT6YV5vTCwFg
	PGgOW2oCraJBH4S0DnV65UFtZEnuoI4=
X-MC-Rep: binary re single
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-n3V-ZZWcPqS74wS29Mz6OA-1; Thu, 26 Nov 2026 17:06:59 +0000
X-MC-Unique: n3V-ZZWcPqS74wS29Mz6OA-1
X-Mimecast-MFC-AGG-ID: n3V-ZZWcPqS74wS29Mz6OA_1795712818
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4bb8da397aaso47194055e9.0
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 09:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795712818; x=1796317618;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0yjxrZbpz1L+siRYyu7F1RBOFIChPAKyEA33AawY46g=;
        b=Ir0mDD3VZWB6j0XoPXaUELb2J1GN1WopBDruK+IG3J0vAqI58R2o8ymcSy/3ACCXNM
         2mFhfwRUuX/oXBb0GKxB6huTslQXyeZYHzkDkdiuB7qhsNJgrxY54q+HG9ooSOT3Vv+j
         a4SWz6v8r4huShz0HSU0cUH6nzGyAdwrb0Cb9F8oYRF5L+QnMUk7kHrodw8xWBsPj8mG
         u2JV1qYXwwSFukku4qkA3sxFo/b8Jhgm2UoCLaGm8i5v6HB8a11CGaAHvuengTOZeIrm
         LqEQ+I2yi8I/t765ZJXpsVArP1HB1RLMf/9tJlsWOFnllCnUp4hPLnVzZ0a7k/5Yk/uw
         mT4g==
X-Forwarded-Encrypted: i=1; AL+hErE7IzMh/SASF/LP3cJl6jhySYX2fNMgcuSVYBUARBnqdAp8Td7L72yTySOWbNs5zZ4qOWJyKy9z5beYL2LI4Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z88e7H8fXHif4e6BQNYyrrkvjC2MXAhwMWQt9TbjcGCQL3ntqKD
	Om5EktimoJTxHNyruS8P2cgiYirLqh5vc4ZWPT0si85tbHSeZFt8YaB5YKbSJsqQCS4K94EEL0f
	snv9XOCLgwTqIayr8Git6FpSSNMPT6DzzyKY5Swbfihw4MIAQME8uMlhm6YPeyZwGiSb4
X-Gm-Gg: AZFdTZdVzu5UlLvq4Y0T2k2L/Sl7i8Z/yNzY0reo8OwdIWylXZITU4mRG5jCu89q2V7
	/XdLtq4NRLV4XEz2VK68q3lE8UD512qqvmEBZM7RB8Bs1up2uZHfU4MXj0qW7qHuo1M9v/sJf8C
	fNUxhInGdJWk/UzYaMDb91Xd1EC5qmdZoP2E8K9+m++00AIlU++8QkIHE4z1EExG6MHouQEUhmw
	6ZjHxpbOiuCmsWKHZOa65pKjTOIS35KRWc9aPoJbDs6/+DGrLZkZeYhFVFwouofg8rjxqgsS4do
	f9xp70Bsknij9ryh3BA8faYxE6Jt9Sf7DYY1utdW2/ap8oAfir+MlShLldpC3oK2CQFgSD86h/q
	pH9eRtTK6I/ncpe39fkSzwp1oz2IwlqCyk8/W3ezpP/w4Hig1hkJCsQ==
X-Received: by 2002:a05:600c:1d09:b0:4bb:66fd:ad68 with SMTP id 5b1f17b1804b1-4bb888160cdmr463369805e9.14.1795712818071;
        Thu, 26 Nov 2026 09:06:58 -0800 (PST)
X-Received: by 2002:a05:600c:1d09:b0:4bb:66fd:ad68 with SMTP id 5b1f17b1804b1-4bb888160cdmr463368905e9.14.1795712817454;
        Thu, 26 Nov 2026 09:06:57 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906c089dsm362731005e9.1.2026.11.26.09.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 09:06:55 -0800 (PST)
Date: Thu, 26 Nov 2026 18:06:47 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	Sashiko AI bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH RFC v4 0/8] vsock: add datagram support to virtio and
 vhost
Message-ID: <awhAaTuR375RpyAE@sgarzare-redhat>
References: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f1ZneyDm5o92tx9YgPDPONbrCyHhCZ5WY7P-NOUXFMQ_1795712818
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 24, 2026 at 01:20:18PM +0100, Sergio Lopez wrote:
>This RFC adds SOCK_DGRAM support to virtio-vsock and vhost-vsock through
>the existing AF_VSOCK API. It is intended for guest and host services
>that exchange independent requests, responses, or events and need message
>boundaries and sender addresses without a stream connection or application
>framing.

Thanks for restarting this work, I have finally found the time to took a 
quick look, sorry for the delay.

Reading the cover letter, it is not clear to me the changes we are doing 
to the core and VMCI that was already supporting DGRAM. I'd like to 
understand better how the backward compatibility is handled and how VMCI 
behavior is preserved. Also reading commits, most of them just contains 
a description of what the code is doing, but they lack the reasons 
behind the changes (i.e. the why).

Overall it seems the right direction, but I have some open questions 
(some of them discussed with Bobby, Stefan, and I at KVM Forum some 
weeks ago):
- Can the virtio flow control be affected by a flood of dgrams ?
   See https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x1-5720001
   and virtio_vsock_pkt_info.reply / virtio_vsock_skb_reply(skb) 
   handling.
- Did you test virtio transports when VMCI transport is also loaded?
   That one is automatically loaded (for historical reasons) first time 
   AF_VSOCK socket is created, if af_vsock.ko is not loaded. So could be 
   a common scenario.
- Any limitation of the current implementation that we will need to 
   fix/implement in next steps?
- Any performance number?


About patches, I started to review, but I hit a wall with patch 6. It's 
too big and really hard to review/maintain. Please split it (e.g. the 
refactoring for vsock_assign_transport can be moved out, etc.). Also 
there are too many if() with conditions duplicated and few comments on 
those conditions, for example:

+	if (sk->sk_type == SOCK_DGRAM && !transport_dgram_fallback &&
+	    new_transport == transport_g2h && transport_h2g &&
+	    transport_h2g != new_transport &&
+	    try_module_get(transport_h2g->module))
+		fallback_transport = transport_h2g;
+	/* Loopback can own datagram state when directional transports cannot. */
+	if (sk->sk_type == SOCK_DGRAM && !transport_dgram_fallback &&
+	    new_transport != transport_local && transport_local &&
+	    transport_local != fallback_transport &&
+	    try_module_get(transport_local->module))
+		local_fallback = transport_local;

This seems a regular pattern, please make sure duplicate code/conditions 
are factored out.

Patch 7 should be vsock/virtio, no? Also should be moved before we 
enable F_DGRAM?

Also check better the bisectability, I'm confused why the changes in the 
core happen after we expose F_DGRAM to device/driver.

I'll send some reviews I did before stopping with patch 6, I'll take a 
deeper look patch by patch in the next release.


Here other issues spotted by an LLM reviewing (line numbers refer to the 
full series applied), please check if they are valid:

- [PATCH 3/8] net/vmw_vsock/virtio_transport_common.c:357-360
   (virtio_transport_send_pkt_info())
   When sk_wmem_alloc reaches sk_sndbuf, the datagram path returns -EAGAIN
   even for blocking sockets: nothing waits and SO_SNDTIMEO is ignored.
   UDP and AF_UNIX datagram sockets block in sock_alloc_send_skb(). The
   selftests always send with MSG_DONTWAIT, so they don't cover this.

- [PATCH 6/8] net/vmw_vsock/af_vsock.c:588 (vsock_use_local_transport())
   Stream/seqpacket routing changes: when the registered G2H transport is
   virtio without a device (get_local_cid() == VMADDR_CID_ANY),
   connect(VMADDR_CID_HOST) now goes to loopback instead of virtio
   (-ENODEV). This hits a guest before probe or after hot-unplug, where a
   local listener can then stand in for a host service. The commit message
   says the host alias "remains", but before this series it never applied
   while a G2H transport was registered. Using dgram_transport_match as an
   "is virtio" test in stream routing also looks like the wrong layer.

- [PATCH 6/8] net/vmw_vsock/af_vsock.c:1674 (vsock_dgram_resolve_cid())
   VMCI registers as the datagram fallback when its module loads, even if
   it has no guest/host context. In that state get_local_cid() returns
   VMCI_INVALID_ID, which is VMADDR_CID_ANY. A wildcard-bound or auto-bound
   socket then matches the first branch, svm_cid stays VMADDR_CID_ANY, and
   every wildcard sendto()/connect() fails with -EADDRNOTAVAIL, even with
   vsock_loopback loaded. Because of MODULE_ALIAS_NETPROTO(PF_VSOCK)
   (vmci_transport.c:2170) this module is often loaded on non-VMware
   machines. In that case VMCI also owns every datagram socket and creates
   a VMCI handle on each bind. (Sashiko reported the same issue on v4.)

- [PATCH 6/8] net/vmw_vsock/af_vsock.c:833 (vsock_dgram_get_transport()),
   called for every send (af_vsock.c:1740) and for every packet received on
   a connected socket (virtio_transport_common.c:1840, from
   virtio_transport_dgram_source_allow())
   Each datagram takes the global vsock_register_mutex, does a module
   get/put and may do several vhost_vsock_get() lookups, which serializes
   all datagram traffic in the system. On RX this happens in the RX worker
   while it holds rx_lock/vq->mutex and lock_sock(). (Also reported by
   Sashiko on v4.)

Thanks,
Stefano
