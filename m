Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E3E272E42
	for <virtualization@lists.linux.dev>; Tue,  6 May 2025 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746525245; cv=none; b=HwLRwO+Y13vcFhZBN6MuF2I77GxWZnKeVYxi4JjulbADF+tABSjl/AJRiyId6MlH0aMg0FYgzyWo+PrAfO2pKQg8Iji81YEc0rsXBcSH9pYtwQpfhu1JbbgsWn4iVcE0fGA2PBrypIa1yWgB09xisWKRwZ1S8fovSz3FMs/oslM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746525245; c=relaxed/simple;
	bh=WZ64pm8mCn6WauOvEK5LHUkaP/YAEqtWPN8ZVB3/f58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CfeZH11PpR+hgKwOffeiBkC+k8xc/ahAonAwkSAquB+nUv+36NQkquZTr0yI7OSOYVBLwVYvCuLAzAzXqAbO0wrQEBGlAhK20431llvnfEOMEhoaELBXHFh6DurfB9yi34cZsJzSS2crWkplr7GsD7Gg/hXtpDq+L2dg/OP9Fz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mwiq0lH0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mwiq0lH0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746525242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E6B1xjoScf7bsPJTh7xEGagDYN0nDoGDFYe9DHlpFOg=;
	b=Mwiq0lH0P4jffVY+V/d3llJPsV8wIedPkaMJTpKOGI2DHmTpHGW/2xMFJKJ7Zm9AMThwSA
	TEaZEwEsYVes1jkx1BPSbMxfJIlZbJdHEGKqPBSuBO3lErmX+UtpzKlXhaOTmIps7fk08/
	aW8kENlmHIQVjjL/Qtrn8lBJNYIECdU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-tFGS-G7BOiGSUD9-nQC5Yg-1; Tue, 06 May 2025 05:54:01 -0400
X-MC-Unique: tFGS-G7BOiGSUD9-nQC5Yg-1
X-Mimecast-MFC-AGG-ID: tFGS-G7BOiGSUD9-nQC5Yg_1746525240
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5f62fb80999so5417383a12.3
        for <virtualization@lists.linux.dev>; Tue, 06 May 2025 02:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746525240; x=1747130040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6B1xjoScf7bsPJTh7xEGagDYN0nDoGDFYe9DHlpFOg=;
        b=SlNBkm4yH4xMhtloksW6UsFrWjSGrWSTx9D2TvpX+aPmqOjm/gUummeq5EZOZrz/le
         s6ogbyikXCTKSsFaLHPssoZGwxzW+6ENkfxnFPu7/3Njg9NrYeJa6NCbp1/Rci+bANWt
         CTJHqm+8SY4DVUfs29ff5njbFBUDA1Y00K7YLaKVpgHfmW9EwW62ELTQYmRRiTJj5Gvu
         GNM/EvJcuq7iqT6JEB6PAnR3L5wMGtdlIjGIDXCMh3pEFxM/rAzPTynE0SQm+gwzXO+t
         4KGllf8ckzyY9psJFdYrLyO0oWpBFSKWtDm5uDSVU5UMIckP2xdftsklB14ltIXz+uqj
         sGww==
X-Forwarded-Encrypted: i=1; AJvYcCV7TpFulAB9C+33zIaufAjUsPG5U2CSPClHagUHAflSpBnnAIaGbBxnj89EXFoLeW4g0m+gNuZBIx6Xeiociw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwL35PXgH/QELe+Dkb+qCmkRLp+5n9S0bMt6T/A0CzuDl0TuDwn
	8Qf2uMkcQyx6uGb0sj4XfrfENPb3GBwIKt5bf+IxpCbzQLfxgtPQkz6M+8eKbX6XPYVIVBm+zFA
	GyyfaK2l6s0A3H81hjyiRrkuMY/d/bhZamzwMarriQjPEfqBt6RElKVMpG28DSAWO
X-Gm-Gg: ASbGncuOU8FgiGG1TwVzWHmu3UfUH7LLmP9Kd7HTFWsDxb0QQfoRbSpfUDDH+ll1h/+
	34CyWbi2RDhdL4CiRBFZj+x1vkAOs25Uos4JCo4gR7MhST8WNeqyUn8h11iCAP5AXWGauwOFCYb
	p6xjbELCGHBFzzsUIGz70W2bygpz8eUzI/RNYTuTaMOt+eeCi7EtZid+KV4KE5L0YH5+s2m46G8
	jj20hUiVkaZg+cfk7LpAquujB+eqcMr2zXrMTUFDwsrfR9apflpkCrQg3ygl8ovdQP37C3DVrMT
	xp5CtAq97GRuvToz3w==
X-Received: by 2002:a17:907:8d87:b0:aca:de15:f2ad with SMTP id a640c23a62f3a-ad1d46ddad0mr219299566b.60.1746525239838;
        Tue, 06 May 2025 02:53:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/1oV0zciKaW3O1wacg9c1zps+3AHOJS/RUO5rgbV5p2b2yw5R1zfs8RHPWnIxlOh3Hh5OJQ==
X-Received: by 2002:a17:907:8d87:b0:aca:de15:f2ad with SMTP id a640c23a62f3a-ad1d46ddad0mr219295266b.60.1746525239247;
        Tue, 06 May 2025 02:53:59 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.219.197])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77b8fe52sm7425752a12.55.2025.05.06.02.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 02:53:58 -0700 (PDT)
Date: Tue, 6 May 2025 11:53:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/3] vsock: Move lingering logic to af_vsock
 core
Message-ID: <hcme242wm3h33zvbo6g6xinhbsjkeaawhsjjutxrhkjoh6xhin@gm5yvzv4ao7k>
References: <20250501-vsock-linger-v4-0-beabbd8a0847@rbox.co>
 <20250501-vsock-linger-v4-2-beabbd8a0847@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250501-vsock-linger-v4-2-beabbd8a0847@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5USeb8p81oQ8ToE7MdKgQ37K4fONN3cZl65oWxddNOA_1746525240
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, May 01, 2025 at 10:05:23AM +0200, Michal Luczaj wrote:
>Lingering should be transport-independent in the long run. In preparation
>for supporting other transports, as well the linger on shutdown(), move
>code to core.
>
>Generalize by querying vsock_transport::unsent_bytes(), guard against the
>callback being unimplemented. Do not pass sk_lingertime explicitly. Pull
>SOCK_LINGER check into vsock_linger().
>
>Flatten the function. Remove the nested block by inverting the condition:
>return early on !timeout.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> include/net/af_vsock.h                  |  1 +
> net/vmw_vsock/af_vsock.c                | 30 ++++++++++++++++++++++++++++++
> net/vmw_vsock/virtio_transport_common.c | 23 ++---------------------
> 3 files changed, 33 insertions(+), 21 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 9e85424c834353d016a527070dd62e15ff3bfce1..d56e6e135158939087d060dfcf65d3fdaea53bf3 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -221,6 +221,7 @@ void vsock_for_each_connected_socket(struct vsock_transport *transport,
> 				     void (*fn)(struct sock *sk));
> int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock 
> *psk);
> bool vsock_find_cid(unsigned int cid);
>+void vsock_linger(struct sock *sk);
>
> /**** TAP ****/
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index fc6afbc8d6806a4d98c66abc3af4bd139c583b08..a31ad6b141cd38d1806df4b5d417924bb8607e32 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1013,6 +1013,36 @@ static int vsock_getname(struct socket *sock,
> 	return err;
> }
>
>+void vsock_linger(struct sock *sk)
>+{
>+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>+	ssize_t (*unsent)(struct vsock_sock *vsk);
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+	long timeout;
>+
>+	if (!sock_flag(sk, SOCK_LINGER))
>+		return;
>+
>+	timeout = sk->sk_lingertime;
>+	if (!timeout)
>+		return;
>+
>+	/* unsent_bytes() may be unimplemented. */

This comment IMO should be enriched, as it is now it doesn't add much to 
the code. I'm thinking on something like this:
     Transports must implement `unsent_bytes` if they want to support
     SOCK_LINGER through `vsock_linger()` since we use it to check when
     the socket can be closed.

The rest LGTM!

Thanks,
Stefano

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
>index 
>045ac53f69735e1979162aea8c9ab5961407640c..aa308f285bf1bcf4c689407033de854c6f85a639 
>100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1192,25 +1192,6 @@ static void virtio_transport_remove_sock(struct vsock_sock *vsk)
> 	vsock_remove_sock(vsk);
> }
>
>-static void virtio_transport_wait_close(struct sock *sk, long timeout)
>-{
>-	if (timeout) {
>-		DEFINE_WAIT_FUNC(wait, woken_wake_function);
>-		struct vsock_sock *vsk = vsock_sk(sk);
>-
>-		add_wait_queue(sk_sleep(sk), &wait);
>-
>-		do {
>-			if (sk_wait_event(sk, &timeout,
>-					  virtio_transport_unsent_bytes(vsk) == 0,
>-					  &wait))
>-				break;
>-		} while (!signal_pending(current) && timeout);
>-
>-		remove_wait_queue(sk_sleep(sk), &wait);
>-	}
>-}
>-
> static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> 					       bool cancel_timeout)
> {
>@@ -1280,8 +1261,8 @@ static bool virtio_transport_close(struct vsock_sock *vsk)
> 	if ((sk->sk_shutdown & SHUTDOWN_MASK) != SHUTDOWN_MASK)
> 		(void)virtio_transport_shutdown(vsk, SHUTDOWN_MASK);
>
>-	if (sock_flag(sk, SOCK_LINGER) && !(current->flags & PF_EXITING))
>-		virtio_transport_wait_close(sk, sk->sk_lingertime);
>+	if (!(current->flags & PF_EXITING))
>+		vsock_linger(sk);
>
> 	if (sock_flag(sk, SOCK_DONE)) {
> 		return true;
>
>-- 
>2.49.0
>

