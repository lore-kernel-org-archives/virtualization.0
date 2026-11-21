Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795285970;
	b=D4xHndgBbeBdcvv+qYzyAIbfw2YZLvUsU8FM7n/ysoXOtRpk3l1j4tLVf0pqImu4Dq6u
	 KNnYLchazZOLYwdAIdSL5z5v+53KhU/y4Iw9qFZh883DwkbCthugsFbHO+ufiFdgdSiFV
	 045B0I3L+TWtb66cNYaL9Bq642VE/Y8K6m+2+y67OO0aP0OhQVa7t5fuZAVvxU+4Ap7Lv
	 w+xxovuLm3wystYxQls86XsDRO7GlBR+nTlVdj7wL/tXq5Hz2ssdZCpvVqsVo6mNZAvd4
	 uv7QDINYXKtA7xW0I7sakD5pBk3ohYKaU1rHkylzkdUpys+BKwY/NxMdPOprNJMJMQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795285970;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=fzDF0mKpBuN/Th1s2Wo0lqYfX3U1baz/HyUNpPlSrLo=;
	b=w5AxJqHozSSramxXsRXBONabfP0Ggp7gY1W+ny8oNjWxkDQBQ3BBJ6EeWkAnoDojX47O
	 T4pkYckq5vhf0hyEFRaQYGA2ySj4cH2iqNWJQ4llWljO8i7SneYRfSbMhohoX9esCuIzw
	 oL4onZk5gkETKC85IwyvPZ95FLYtjM2alAph0DqwyECVTsp7ImMDq7DlCntRrXg3pwuxI
	 cd1mptc3VkubRxgdl35kCvCrvs+pdehyLstuxlF/zBGv6rxk+ux4XvpTREFg601OsPq8H
	 TD4ppOpmeqM4Ioa/x2b+whVrpFRru9f2Yi3I9DhIPRQuQ7ZQXaEagMFbTwlwMetS6Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=EFDz5rbI;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1EE606A32A
	for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 18:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A1EE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=EFDz5rbI
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xUpsz-00GOGa-3H; Sat, 21 Nov 2026 19:32:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=fzDF0mKpBuN/Th1s2Wo0lqYfX3U1baz/HyUNpPlSrLo=; b=EFDz5rbIH+g3Jvyr3pCaQMqHvE
	Kn/I9edyG1N0gh5sRV+4prgaDrHW/9+1lUDXxvyw/13jqjpFKvgxcqAMweZwnByS4RMV/o+YmAxQl
	6m1qvQ/BP9jBipOxsU6AOHP4NkXDcuP+WNbqTZTJQMn7uETD2PV0XIRY+TKI1H1tKQARJGofrDay3
	TUlOSDev30eao2yDOE5oq9wwsqAiUtu45EwgFDXBdvmbPOP2BDJEV+caWeLftroGEFQCrfhpLT7RS
	eyYTNmAOXOD8xIpjrD3IW99ugwP4DiGGx/rCO4XZSCw9Ugl/6CZZ6oloY5zkl3cZfplw4DgVAZdQH
	psjNF2ZA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xUpst-000056-As; Sat, 21 Nov 2026 19:32:23 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xUpsr-0001IN-15;
	Sat, 21 Nov 2026 19:32:21 +0100
Message-ID: <ed28d36a-682e-4db5-abf4-1339734e7c57@rbox.co>
Date: Sat, 21 Nov 2026 19:32:15 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net v2] vsock: only undo SS_CONNECTING when connect()
 fails
To: Bobby Eshleman <bobbyeshleman@meta.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, George Zhang <georgezhang@vmware.com>,
 Andy King <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
References: <20261117-vsock-connect-close-v2-1-db5388323770@meta.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <20261117-vsock-connect-close-v2-1-db5388323770@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/26 02:34, Bobby Eshleman wrote:
> vsock_connect() sleeps with the socket unlocked. Meanwhile the transport
> can complete the handshake, setting sock->state to SS_CONNECTED, and then
> reset the connection, e.g. in vhost_vsock_reset_orphans(),
> virtio_vsock_reset_sock() or vmci_transport_handle_detach(). When
> connect() gets the lock back, it finds sk_err set and moves the socket
> back to SS_UNCONNECTED. Userspace can then connect() the socket again,
> and a connect() to a CID on another transport makes
> vsock_assign_transport() release the transport the socket was connected
> on.
> 
> Only move the socket back to SS_UNCONNECTED if it is still
> SS_CONNECTING. A socket that got connected stays SS_CONNECTED, and
> another connect() fails with -EISCONN.
> 
> Likewise, only move sk_state to TCP_CLOSE if it is still TCP_SYN_SENT.
> Otherwise a second thread blocked in connect() on the same socket can
> time out after the first one failed and called listen(), and overwrite
> TCP_LISTEN.

Ohh, this took me a while.

> +/* Avoid breaking the socket when another thread has changed its state while
> + * we were asleep.
> + */
> +static void vsock_connect_close(struct socket *sock)
> +{
> +	struct sock *sk = sock->sk;
> +
> +	if (sk->sk_state == TCP_SYN_SENT)
> +		sk->sk_state = TCP_CLOSE;
> +	if (sock->state == SS_CONNECTING)
> +		sock->state = SS_UNCONNECTED;
> +}

I was wondering why not

	if (sk->sk_state == TCP_SYN_SENT) {
		sk->sk_state = TCP_CLOSE;
		sock->state = SS_UNCONNECTED;
	}

and I think the only reasons we can't say "SYN_SENT iff CONNECTING" is
because shutdown() can flip SYN_SENT/CONNECTING to SYN_SENT/DISCONNECTING.
On connect's failure, the blocking path kinda-ignores such shutdown() and
resets the socket to UNCONNECTED anyway, while the non-blocking (i.e.
vsock_connect_timeout()) also consults sk_shutdown != SHUTDOWN_MASK.

So how about being consistent:

static void vsock_connect_close(struct socket *sock)
{
	struct sock *sk = sock->sk;

	// we follow vsock_connect_timeout():
	// TCP_SYN_SENT implies SS_{DIS,}CONNECTING;
	// and we do check sk_shutdown
	//
	// or am I missing something?

	if (sk->sk_state == TCP_SYN_SENT &&
	    sk->sk_shutdown != SHUTDOWN_MASK) {
		sk->sk_state = TCP_CLOSE;
		sock->state = SS_UNCONNECTED;
	}
}

What do you think?

I guess this approach also addresses "[Severity: Low] What happens if
another thread calls shutdown() while a blocking connect() is asleep?". As
for "[Severity: Medium] Can a connect() waiter that times out late still
abort a newer connect attempt on the same socket?", isn't this the current
situation?

thanks,
Michal
