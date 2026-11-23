Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450640;
	b=rTg9HmsThi9al8dte5UfKsUyp5Hpjk0i8/ko3VHpkMLITH8afmzO/ocsNlzZurcCCwJT
	 qZIoWpY2Rz3yTroTvmfycHTon6Fb34HUptV/eNWfkyZLF2kGCONpd27Ij3PFg4YaB6n1a
	 tvQifpw3NMQtaB57qKzD5549rb3uYSwWyHxUradm1e7ld72T9SYFFUOEaplQW6+4uLTse
	 kWkB4QOcFWGlEPxGefdcYuoCKC6Wz3/EkDKS0UUaEUyZdAMPAbz/tiGpgLHRydyncoKfp
	 tg+LbqZSFE9xs7dGf0r3i79sEbVVub3Qe7ZmEZwJqMBvJYdlR/Kxo7aY3ma7oi2PkAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450640;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=+GHb/SYd6gXinJYqxw1GDlcMLdqBI2V3zFyLkxFbZ0k=;
	b=pRLebvWtiODN364TQ+0bNwkPovmz/gmxjKcrNHQgGk4cQwzvmHk6GTYH7RRJ8YY72U/b
	 hqQ9OE0bzpHN4tuhJ9QJOO8VIWL5kN2m27BH+1F4l33XEk+pJSRZo7iX+bBGtiCAM+8dT
	 N4VwumDlu8zLEW4vzmWVmwsm3x3zRUAh4QF0tzBU+ivL5sj+f1yLxaobCwGvoGnrRW35I
	 qxsNR+Lj9PQhx9apuQwPpeBjA/m9O4gjNPi87LTOhN8EFWSqgduu/hASxQ3A/FBHQH+i6
	 qc3k4IMmvYDSDXvwGE0ll48vScPD5fdmyJRjKrKP6pZ7c7UbFwJiS2hNnVGNNA1RW7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d0y4f7iL;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ABB606A330
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 16:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33ABB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d0y4f7iL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795450639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+GHb/SYd6gXinJYqxw1GDlcMLdqBI2V3zFyLkxFbZ0k=;
	b=d0y4f7iLfivHQWBFjZe0Gb0OBVayfWhwiCEqqJPb++ZTF43w9Evr2zOYx/xaqsOAMzMnWO
	XUq3Pj8B/mM93fSY62IjCEmz/wM6AFBX7ho+YTAqAj1P9+aiPlCOgEwb3QN2JdW8KPYe/E
	5pdEqWMJK7WCfhOPW31VK2v1cVqB7Rw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-1cEM7v4xNqqQ6NCjihfOeA-1; Mon, 23 Nov 2026 16:17:16 +0000
X-MC-Unique: 1cEM7v4xNqqQ6NCjihfOeA-1
X-Mimecast-MFC-AGG-ID: 1cEM7v4xNqqQ6NCjihfOeA_1795450635
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a16dc2323cso6024415e9.3
        for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 08:17:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795450635; x=1796055435;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+GHb/SYd6gXinJYqxw1GDlcMLdqBI2V3zFyLkxFbZ0k=;
        b=JpvSqpmrNITfib89c9RbQ+MO3hIE1UYn8gg9XbGFRDZziENSWMWw5K3zmUe5ooZViS
         yVmCeyb08pos30AjLnMX3UiAHDGgczxPQFkA7E4WUJR7jdD+QcLG/GND/lCRQU4dALOv
         MR+7OHWgnySZpB3mRqjISc/QpWI0X4k8SCnuq/btAHFf90D/DiZpzF8a4vDaPKTY3l4/
         /1RWdE6/aSPn6YC7ftjapUu4QTw08yc80ibK9Zt42EoI5G8VXbl9EeHqUP2QSw+1Gh+z
         gFGfvuIv62GsPjJd3VIJz3EwFFknJYSYdYzqi3AFABcWyTXuHT9ya3hd7DaCerUBX72s
         Vl1g==
X-Forwarded-Encrypted: i=1; AL+hErHkvERXyLl6AuuE6UHir3cjJFTpMEw41MxJ1c0VDnkCHWK18EOFBnc4G2KOfWd+UTV1zs5eDII2CgQo9yg0Ig==@lists.linux.dev
X-Gm-Message-State: APuU4Z/KcySAVdmhUBMHdSeOxWs1ywnZ60SNbVsFS5SbPs/76hSrpK2A
	STrJSd+zG15OEepvzaTDkHGsVmUsLk/llezuM4KoCrk8QUA1VmFc5B1T6I1fGjomqLIOlwl3yJd
	XU0ZXqgWLOvPm5gc2f6lCvPriFE4FVeEiHnmtEDieSWVJ6gZmDtHaOYTVuTHnhvT29CJrrF0zGU
	Ur
X-Gm-Gg: AZFdTZdI8u9fNlyUZ0w7yuzc9eAx246i2cBnLKmUdlFLmg5KFMKaYj7zKsUT4eqaZF3
	JR3ZaDFjFzo22YMVZHKUpoaTfeKW7Mf2kvzpGTLEV4O2t4z8oGS9tf61EhgE6XUy00zwL76zYjZ
	5PUBi5eqoOhsKgig12zbZlf7TimqR7BEPMJ1iPLb0SMPBtqCfsuSTLFMjGltjWNag3U21K3Vh1k
	zimkjiBAWPCON7Vp7ApyfgQwJQodluRK4xvRieA1CCGLDujKVMagnNVKNu0Qy63sUzBEt94uCVD
	sqXrcCeSN9AfQ8ZK5JI1s2gpnDoGo1vTeKjR4z48QxqVNNA3SoZGpV2Oh4/q9Fakh09/HEYZ51c
	ca0lcYPomz7ob4fGhmb8Hf5NMVA3yI76ya/w4MdRjszxcUXNhc9DBSA==
X-Received: by 2002:a05:600c:674d:b0:4a0:1fb9:2f51 with SMTP id 5b1f17b1804b1-4bb88808263mr270420315e9.14.1795450634799;
        Mon, 23 Nov 2026 08:17:14 -0800 (PST)
X-Received: by 2002:a05:600c:674d:b0:4a0:1fb9:2f51 with SMTP id 5b1f17b1804b1-4bb88808263mr270419595e9.14.1795450634202;
        Mon, 23 Nov 2026 08:17:14 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9067846esm209571105e9.4.2026.11.23.08.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:17:13 -0800 (PST)
Date: Mon, 23 Nov 2026 17:17:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v6 1/2] vsock/bpf: fix zero-length, MSG_OOB and
 MSG_ERRQUEUE reads
Message-ID: <awRlwL1epH1j61Z7@sgarzare-redhat>
References: <20261114-kbh3-1-022-fix-v2-v6-0-96b6029bbffa@eldare.de>
 <20261114-kbh3-1-022-fix-v2-v6-1-96b6029bbffa@eldare.de>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261114-kbh3-1-022-fix-v2-v6-1-96b6029bbffa@eldare.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lOhvjF7bzS6rqYWDikuxChy7dNKlJ_Xp9-3_Ic21k4Q_1795450635
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, Nov 14, 2026 at 12:59:14PM +0100, Jerome Mohm via B4 Relay wrote:
>From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>On a vsock socket in a sockmap, vsock_bpf_recvmsg() sends zero-length,
>MSG_OOB and MSG_ERRQUEUE reads down the sockmap path whenever the psock
>queue has data or nothing is queued at all. That path copies from the
>psock queue and waits for data, and it handles none of these reads:
>
> - a zero-length read with data in the psock queue spins with the
>   socket lock held, and the delivery worker blocks on that lock;
> - MSG_ERRQUEUE consumes stream bytes from the psock queue, and the
>   zero-length MSG_ERRQUEUE read that MSG_ZEROCOPY users make to collect
>   completions gets -EAGAIN or blocks instead of reading the error
>   queue;
> - MSG_OOB consumes ordinary stream bytes or waits for data, where a
>   connected native socket returns -EOPNOTSUPP.
>
>Hand these reads to __vsock_recvmsg(), the path of a socket outside a
>sockmap, which does not wait for any of them. They now take one path,
>so the order of the checks no longer matters.
>
>The MSG_ERRQUEUE case was found with the help of Anthropic's Claude,
>its stream-byte and MSG_ZEROCOPY parts by Stefano, and the zero-length
>and MSG_OOB cases by the netdev Sashiko reviews. Each was reproduced in
>a VM with a vsock-loopback socket in a sockmap, without kernel changes
>or error injection. With this patch alone they behave as on a native
>socket. The vsock vmtest.sh single-VM tests and the BPF sockmap
>selftests pass with the series; I did not run them on this patch alone.

nit: IMO talking about series/patch is confusing while reading when the 
patches will be applied.

>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>Cc: stable@vger.kernel.org
>Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>---
> net/vmw_vsock/vsock_bpf.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index 9049d2648646..c9b399f37720 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -80,6 +80,9 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 	struct vsock_sock *vsk;
> 	int copied;
>

nit: a brief comment here with the reason would be nice

>+	if (unlikely(!len || (flags & (MSG_OOB | MSG_ERRQUEUE))))
>+		return __vsock_recvmsg(sk, msg, len, flags);
>+
> 	psock = sk_psock_get(sk);
> 	if (unlikely(!psock))
> 		return __vsock_recvmsg(sk, msg, len, flags);
>
>-- 
>2.56.0
>
>

Code LGTM, if you have to respin, maybe you can improve a bit more.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


