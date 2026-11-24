Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537106;
	b=ptKWE9FenTUv45cT7D9iLZFGlOw1L4fukrK7Svw9bcQ0RB/ZYbcl2fo2kazAyWNQA7Mh
	 lPHeVqSlbKFQwt28YaBgPkEZ17BcLN6YgxoCDPayi/abAIYcWUlkz7Tjng8juPVBKbd0d
	 LR8OH6FvR7oLWHSw7WkL6tZ+f7LEh55aCFbj95+awQQ9HYXg9fMzwiCUATyJlkVQc5Iki
	 adtbUGJ2PS6y0qa3pEPIj/jXvOEERZ4wpchgwgkq8NCT5ogfZHeOYRhPo87ZnlEfCdfx0
	 fLxTdFwJr35+rnTDz5PJLC2NgABgweFUqNpO1lkicXqDuIuW51z4KBJdpMVXHWCJqVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537106;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=OS+g8r/vEgbbXgK47jEcIac9E+hDiBGHrAOXRbTPV0U=;
	b=NilzkpCd4KbTguHuaB+OosIK+vzhe7rfd3FKgimMR3jhGai38E69s2BZ9fwSlO8Z3fxu
	 K2LKZDHnX3vQjBvZQwSbixk9eFDlgZVQxDr9eoV2lw/IB4qpNhUQddKQv7WBDZ34kfLtt
	 HmG4E+geMx6gL407cqcSmNkdTEZlKB3dElCPksWUfRMGr/AAPXZAEXq8UZN64jytOip3o
	 Be+K5k54Vnjvt+LO4uYGKVRB0sPAl5PO+DahFxesua9xjgzXpJdBe7M8tPqs7xIJLIrSG
	 aAX/QCoh/Wgz84U1vdZTG3+rKS0qVy7kACuksT3MK3j/DjOzQZ7FW7fO+NIHp/FzzhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=EYBjD2Kp;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F2C606A331;
	Tue, 24 Nov 2026 16:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62F2C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=EYBjD2Kp
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xVtDj-007i6q-Oj; Tue, 24 Nov 2026 17:18:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=OS+g8r/vEgbbXgK47jEcIac9E+hDiBGHrAOXRbTPV0U=; b=EYBjD2KpncwOkqCBy/Xwbbew40
	T5T9y/FvwFAM/8tQGhwyZbmpWQ4tKU/Alb+XzOvucJjfXCxSH4wHWA2WvM3rhdR0ZejkSD96rIuQg
	LCdHMDAixnlWjI/8kE5u2qC0wpAPEKfrwHAzwX1TAd02I+yG0Ud/RQ/bT0wn9hp2/PnbSy2kQVELT
	xG2EitK9Qv824kJ41t96dtri3io4/EU9A92H0hziRFcOG8a8rUBOvz4rXYS3K/86cUPGNvIf7MSSD
	yKGpbUvEP+A27VFPm4fq5aeRPftdyiqJsHYReeVB4a/Fx1NUWuZ/Jz9Xu3dPv4upGxzjgiuA+wfIi
	9H6qGmvg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xVtDe-0001Sk-3T; Tue, 24 Nov 2026 17:18:10 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xVtDR-009PeQ-BJ;
	Tue, 24 Nov 2026 17:17:57 +0100
Message-ID: <ca274ecf-3525-4bf0-a525-0460b5ea2d28@rbox.co>
Date: Tue, 24 Nov 2026 17:17:56 +0100
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
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, George Zhang <georgezhang@vmware.com>,
 Andy King <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
References: <20261117-vsock-connect-close-v2-1-db5388323770@meta.com>
 <ed28d36a-682e-4db5-abf4-1339734e7c57@rbox.co>
 <awTJ8EOl52W0ph1K@devvm29614.prn0.facebook.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <awTJ8EOl52W0ph1K@devvm29614.prn0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 00:19, Bobby Eshleman wrote:
> On Sat, Nov 21, 2026 at 07:32:15PM +0100, Michal Luczaj wrote:
>> On 11/18/26 02:34, Bobby Eshleman wrote:
>>> vsock_connect() sleeps with the socket unlocked. Meanwhile the transport
>>> can complete the handshake, setting sock->state to SS_CONNECTED, and then
>>> reset the connection, e.g. in vhost_vsock_reset_orphans(),
>>> virtio_vsock_reset_sock() or vmci_transport_handle_detach(). When
>>> connect() gets the lock back, it finds sk_err set and moves the socket
>>> back to SS_UNCONNECTED. Userspace can then connect() the socket again,
>>> and a connect() to a CID on another transport makes
>>> vsock_assign_transport() release the transport the socket was connected
>>> on.
>>>
>>> Only move the socket back to SS_UNCONNECTED if it is still
>>> SS_CONNECTING. A socket that got connected stays SS_CONNECTED, and
>>> another connect() fails with -EISCONN.
>>>
>>> Likewise, only move sk_state to TCP_CLOSE if it is still TCP_SYN_SENT.
>>> Otherwise a second thread blocked in connect() on the same socket can
>>> time out after the first one failed and called listen(), and overwrite
>>> TCP_LISTEN.
>>
>> Ohh, this took me a while.
>>
>>> +/* Avoid breaking the socket when another thread has changed its state while
>>> + * we were asleep.
>>> + */
>>> +static void vsock_connect_close(struct socket *sock)
>>> +{
>>> +	struct sock *sk = sock->sk;
>>> +
>>> +	if (sk->sk_state == TCP_SYN_SENT)
>>> +		sk->sk_state = TCP_CLOSE;
>>> +	if (sock->state == SS_CONNECTING)
>>> +		sock->state = SS_UNCONNECTED;
>>> +}
>>
>> I was wondering why not
>>
>> 	if (sk->sk_state == TCP_SYN_SENT) {
>> 		sk->sk_state = TCP_CLOSE;
>> 		sock->state = SS_UNCONNECTED;
>> 	}
>>
>> and I think the only reasons we can't say "SYN_SENT iff CONNECTING" is
>> because shutdown() can flip SYN_SENT/CONNECTING to SYN_SENT/DISCONNECTING.
>> On connect's failure, the blocking path kinda-ignores such shutdown() and
>> resets the socket to UNCONNECTED anyway, while the non-blocking (i.e.
>> vsock_connect_timeout()) also consults sk_shutdown != SHUTDOWN_MASK.
>>
>> So how about being consistent:
>>
>> static void vsock_connect_close(struct socket *sock)
>> {
>> 	struct sock *sk = sock->sk;
>>
>> 	// we follow vsock_connect_timeout():
>> 	// TCP_SYN_SENT implies SS_{DIS,}CONNECTING;
>> 	// and we do check sk_shutdown
>> 	//
>> 	// or am I missing something?
>>
>> 	if (sk->sk_state == TCP_SYN_SENT &&
>> 	    sk->sk_shutdown != SHUTDOWN_MASK) {
>> 		sk->sk_state = TCP_CLOSE;
>> 		sock->state = SS_UNCONNECTED;
>> 	}
>> }
>>
>> What do you think?
> 
> I think we could say TCP_SYN_SENT implies SS_{DIS,}CONNECTING, but
> probably not the reverse... without a peer on the other end our connect
> request gets an RST reply, switching to TCP_CLOSE but leaving untouched
> SS_CONNECTING. Using only TCP_SYN_SENT then skips resetting
> SS_CONNECTING to SS_UNCONNECTED, and future connect() retries hit
> -EALREADY forever.

Ugh, true. And your double-if approach has it covered.

> It seems to work for vsock_connect_timeout() because that function only
> needs to test if the attempt to connect is still pending (if yes, then
> close everything up), but vsock_connect_close() needs to know more
> precisely if the socket still holds the state that this current connect
> attempt changed... so it separately checks "Did we set TCP_SYN_SENT? if
> so, set to TCP_CLOSE.  Did we set SS_CONNECTING?  If so, set to
> SS_UNCONNECTED."

Right, got it.

> I think it might even make more sense to consolidate in the other
> direction and make vsock_connect_timeout() a caller of the new
> vsock_connect_close(), since it appears there is a similar edge case
> there...
> 
> connect(), O_NONBLOCK
>   transport->connect()  /* OP_REQUEST */
>   mod_delayed_work(connect_work)
> 
> shutdown(SHUT_RDWR)
>   sock->state = SS_DISCONNECTING
>   sk_shutdown = SHUTDOWN_MASK
> 
> vsock_connect_timeout()
>   skips the socket because of SHUTDOWN_MASK
>   /* still TCP_SYN_SENT / SS_DISCONNECTING */
> 
> late OP_RESPONSE, virtio_transport_recv_connecting()
>   sk_state = TCP_ESTABLISHED
>   sock->state = SS_CONNECTED
>   vsock_insert_connected()
> 
> So the attempt never times out, and a late OP_RESPONSE connects a
> socket the user already shut down, overwriting SS_DISCONNECTING with
> SS_CONNECTED. I think that's a separate bug for a separate patch,
> though.

Great, I'm all in favour of consolidation. So in the scenario above,
invoking vsock_connect_close() on vsock_connect_timeout() (with sk_shutdown
check dropped) would result in CLOSE/DISCONNECTING, and no more late
virtio_transport_recv_connecting(), right?

>> I guess this approach also addresses "[Severity: Low] What happens if
>> another thread calls shutdown() while a blocking connect() is asleep?". As
>> for "[Severity: Medium] Can a connect() waiter that times out late still
>> abort a newer connect attempt on the same socket?", isn't this the current
>> situation?
>>
> Yeah, Sashiko is worried that a racing shutdown() breaks reusing the
> socket, but AFAIK vsock doesn't support reuse after shutdown anyway.
> Before this patch a second connect() could succeed, but the shutdown
> flags are never cleared, so sendmsg() still returns -EPIPE and recvmsg()
> returns 0. With this patch the socket stays SS_DISCONNECTING, so
> connect() fails with -EINVAL instead.

One more detail: currently a sock that went through a failed connect() can
still become a listener. A transport-bearing listener, which I don't think
is good. So, except for the connect+shutdown case, this does not change
with your patch, right?

> And agreed about the medium issue, the late connect() waiter race is no
> different than before this patch.

Paolo, is this the "multiple threads connecting/disconnecting the same
socket concurrently" you were referring to? Yeah, I think there's an
agreement it's not an issue.

thanks,
Michal
