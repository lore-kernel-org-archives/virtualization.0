Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244F01DF277
	for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005624; cv=none; b=TMC0NS8/3PYxdnQ+090eJg3nyRSSfp2jNzUsPyH4Vs22ZCRGpMWcZ7igmo8YKWQrZYNAFI40JulBut4+NxlvDGEwmltu78Hm+sdFACMoIGNJIalSO22xPDSEqdfj1YOe4YEgLMnGRNtrISHFDOENfMUEphR+63vakHRchlvH4Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005624; c=relaxed/simple;
	bh=mA9BKBCKpYb6lTEd9olYOonbkelRooJ8eRvHK8TBPc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YBFxSeUJqzpwty/rIJ+6lA/qUUMHo30kVOK5KlX8nRSZbW++Lr8vm72ClztwGHxntON7fJg4/23dmak8bHZHPJfEEez9gcjZnKek82JKUXCbhaaMTz34c0mS1ni4RGOZdC7GAQFz+qUKrMG8TUnSen9SQ7TLsxKwSe4EhpDUK/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYqcyKrf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYqcyKrf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746005621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3bYVNnNO1IClTpNKVqUBTHWwZJ5vtzLvL3vS8eJfpg4=;
	b=LYqcyKrf8lNprV3UaKaZB+y4sysFexRevl8aoDnw3ZQmgkKu+kvzeSNLwHBgoeUFggJg06
	Yg30VqPezVI++WA1zsyEyeIsAlchtNf1r4XGGHyUuMqopKrsf68xAOe58VrH89kRGfChQ9
	WWtCF0Ha/f5SbOKgXo53xZ3STajxLAM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-wqYQqludNoCwLjQnU7UEsw-1; Wed, 30 Apr 2025 05:33:40 -0400
X-MC-Unique: wqYQqludNoCwLjQnU7UEsw-1
X-Mimecast-MFC-AGG-ID: wqYQqludNoCwLjQnU7UEsw_1746005619
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ace942ab877so382051666b.1
        for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 02:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746005619; x=1746610419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bYVNnNO1IClTpNKVqUBTHWwZJ5vtzLvL3vS8eJfpg4=;
        b=whfn6yE9siDfSTlpoBbE9VEWpXDe4elUmcusZKQDxRx5mxwOdw2Ay/CBFjZQt1fWcO
         JAn4Hh2RIOtI8bwHcz29vLqkmoqps54vYNJXp25EBHOXxzhNYMAxQvvJnhOFo1NMYQ1G
         jD5v3pUtSfwqrQ97Ani+7HybD9XDoi4KlUOUmM8p7ym4qa/OqqeigGu4BoZcJfw5mk/z
         FH0vcP9JU6PeQf9EsKKMLCltenqiFAoJovtd+miZh0iWg1ucEraUfzG9Jsn3SvVmrbyq
         /CfNgIQX9/FswM29nF13dnJwxt/NDQ0EmKSEUey4BIksusOAbbUjL3Vwle0z6XYVb1SF
         rbJg==
X-Forwarded-Encrypted: i=1; AJvYcCVkQpjs+2quPQDvef4RYnZXdVeWtqFp3bTQA18JFkayErikRgTTuIlwFOpgIuPHFSuLA1NPBAkjJ5Gi95VAAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzM+M5eCnb1KKtN75FU+Tqa8A5SzZK+ie4Odj/a1rrAI9QWoQ/x
	NrNGcztqFTiML7eW+ifuWpEGhzsHb2m9GD/ZhPTl9ayYz/qwUWPukCxR1VKZmN3meqbRDuvEhwY
	fnB0oUP4eXB7Lr5ltNzJK/AfeZj+dx7tg6wVQjGLuEPR6WCSZwhOD5rU0cPSMw/Tn
X-Gm-Gg: ASbGncsXYDlmNHWma1r5CPc9MXZOlcyBOoDph4ADTB7ydU4UC2SH8Xs/rHubTpS9H3J
	sllifO/qiB4ePQriCVDPT1rpbYHQOax2FWNH4+WpLwF1/Ct1wYDpdBeD0xlqSLRXS5Ow75V8BTu
	OTyCfC5ymvf6LU/RKn+ilDRnvmbB6ucO372wydB+ihIwCaJ4CYytYQ/QuiR4O+43UhUu+hnhulx
	dZ837su6G+t22+SOBn2Iv3W2ZcpYeovCu1WinogsHeRFfJJYPpa5hyjRbASPeyRYZElYQfCOm8x
	KIzK6hSOf/ZKE9CyoQ==
X-Received: by 2002:a17:907:9604:b0:acb:711d:36c8 with SMTP id a640c23a62f3a-acee25d7ff3mr153151666b.38.1746005618799;
        Wed, 30 Apr 2025 02:33:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi6C65Ki6Gb3ZNOp51SaR56emN5GoIfZVHQB22tLfmRROrIqgYNk0gnSTXY99ElK+/CuKjUA==
X-Received: by 2002:a17:907:9604:b0:acb:711d:36c8 with SMTP id a640c23a62f3a-acee25d7ff3mr153147866b.38.1746005618183;
        Wed, 30 Apr 2025 02:33:38 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.220.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecf9a47sm906727866b.104.2025.04.30.02.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:33:37 -0700 (PDT)
Date: Wed, 30 Apr 2025 11:33:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/4] vsock: Move lingering logic to af_vsock
 core
Message-ID: <kz3s5mu7bc5kqb22g6voacrinda3wszwhlda7nnwhm5bciweuc@dpsyq2yfrs7f>
References: <20250430-vsock-linger-v3-0-ddbe73b53457@rbox.co>
 <20250430-vsock-linger-v3-3-ddbe73b53457@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250430-vsock-linger-v3-3-ddbe73b53457@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cwlCfVPOn2zJHh7N2-3MN45SeYfHS8yYI0ets-5dwuo_1746005619
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Apr 30, 2025 at 11:10:29AM +0200, Michal Luczaj wrote:
>Lingering should be transport-independent in the long run. In preparation
>for supporting other transports, as well the linger on shutdown(), move
>code to core.
>
>Guard against an unimplemented vsock_transport::unsent_bytes() callback.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> include/net/af_vsock.h                  |  1 +
> net/vmw_vsock/af_vsock.c                | 25 +++++++++++++++++++++++++
> net/vmw_vsock/virtio_transport_common.c | 23 +----------------------
> 3 files changed, 27 insertions(+), 22 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 9e85424c834353d016a527070dd62e15ff3bfce1..bd8b88d70423051dd05fc445fe37971af631ba03 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -221,6 +221,7 @@ void vsock_for_each_connected_socket(struct vsock_transport *transport,
> 				     void (*fn)(struct sock *sk));
> int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
> bool vsock_find_cid(unsigned int cid);
>+void vsock_linger(struct sock *sk, long timeout);
>
> /**** TAP ****/
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index fc6afbc8d6806a4d98c66abc3af4bd139c583b08..946b37de679a0e68b84cd982a3af2a959c60ee57 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1013,6 +1013,31 @@ static int vsock_getname(struct socket *sock,
> 	return err;
> }
>
>+void vsock_linger(struct sock *sk, long timeout)
>+{
>+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>+	ssize_t (*unsent)(struct vsock_sock *vsk);
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+
>+	if (!timeout)
>+		return;
>+
>+	/* unsent_bytes() may be unimplemented. */
>+	unsent = vsk->transport->unsent_bytes;
>+	if (!unsent)
>+		return;
>+
>+	add_wait_queue(sk_sleep(sk), &wait);
>+
>+	do {
>+		if (sk_wait_event(sk, &timeout, unsent(vsk) == 0, &wait))
>+			break;
>+	} while (!signal_pending(current) && timeout);
>+
>+	remove_wait_queue(sk_sleep(sk), &wait);
>+}
>+EXPORT_SYMBOL_GPL(vsock_linger);
>+
> static int vsock_shutdown(struct socket *sock, int mode)
> {
> 	int err;
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 4425802c5d718f65aaea425ea35886ad64e2fe6e..9230b8358ef2ac1f6e72a5961bae39f9093c8884 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1192,27 +1192,6 @@ static void virtio_transport_remove_sock(struct vsock_sock *vsk)
> 	vsock_remove_sock(vsk);
> }
>
>-static void virtio_transport_wait_close(struct sock *sk, long timeout)
>-{
>-	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>-	ssize_t (*unsent)(struct vsock_sock *vsk);
>-	struct vsock_sock *vsk = vsock_sk(sk);
>-
>-	if (!timeout)
>-		return;
>-
>-	unsent = vsk->transport->unsent_bytes;
>-
>-	add_wait_queue(sk_sleep(sk), &wait);
>-
>-	do {
>-		if (sk_wait_event(sk, &timeout, unsent(vsk) == 0, &wait))
>-			break;
>-	} while (!signal_pending(current) && timeout);
>-
>-	remove_wait_queue(sk_sleep(sk), &wait);
>-}
>-
> static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> 					       bool cancel_timeout)
> {
>@@ -1283,7 +1262,7 @@ static bool virtio_transport_close(struct vsock_sock *vsk)
> 		(void)virtio_transport_shutdown(vsk, SHUTDOWN_MASK);
>
> 	if (sock_flag(sk, SOCK_LINGER) && !(current->flags & PF_EXITING))
>-		virtio_transport_wait_close(sk, sk->sk_lingertime);
>+		vsock_linger(sk, sk->sk_lingertime);

What about removing the `sk->sk_lingertime` parameter here?
vsock_linger() can get it from sk.

BTW, the change LGTM, would be great to call vsock_linger() directly in 
__vsock_release(), but we can do it later.

Thanks,
Stefano

>
> 	if (sock_flag(sk, SOCK_DONE)) {
> 		return true;
>
>-- 
>2.49.0
>
>

