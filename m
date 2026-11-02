Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793582531;
	b=jvyV/hxyg8rEZbLDE7cJXmQ/tPmRoHtTHWXl829RiEkfmTme5vDLYF6HADZt8lLX7mSt
	 PwOWPx1Js/2LHdlXSvPeDqXXQ4jQGcbKWmIWahTAiDFA/Y8Wlf2x9lmh//QAC03tZBkp+
	 GuE+c2PWbHDTR2JZIeGg9jn8nD8Ebf8dQII2k8eAATVAQjDWwmrYlLZPXhm+Aymd5mbQM
	 TJd1DzQLi6cTwJ2C45Ap895fZIugraEWnh4HOTd46l8Yyt9U+WHEQLMmU9TgE+FyT8UbF
	 IRL9No2jWeCuD55zbQc65d7m2pwuG3r6GP8wPRvjhARsQ6oaNLzpgwgtcQhS/nUYGbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793582531;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=C5gqpTOgkDU//zQkGOQKjOKsqsvBDDMS+gbejxMeVdk=;
	b=r1jk7OLvcBx//RbsjTw+M51BupX6xk1APaIKGgw4oiraqYGsVxNEcKk9/VmV8YdF67m+
	 6muAyAFYhp07T/6hpsDAMzotn0UuY+i4Z8caFLZCHa5GclZTHgbyTPJiBm3o21tca7Lst
	 gnNHBkXKvLcLjW1jUYFDiLMEZMYKYyCybXm3g7Ks2jA/dD3m2ojyeUkMCFVuRFjeGcysY
	 7nfDzhxcAh5RXUKY+Qq2Ao+87aqn77FyBhE7Ean4ofmaA4rU7TpQZufJUVusWAM1SkjdN
	 g0BSvQW1nrqtZa0BTHYLs2QdNG4ldoPq1+fUt/oTXc+ft041LP4R1rxJCs9kPI1aztQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=I2EnYMrr;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF74606A324;
	Mon,  2 Nov 2026 01:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BF74606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=I2EnYMrr
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xNgkL-008BKP-AU; Mon, 02 Nov 2026 02:22:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=C5gqpTOgkDU//zQkGOQKjOKsqsvBDDMS+gbejxMeVdk=; b=I2EnYMrrFCOKTtqiYFvChN8tuO
	Cy6ULEkHqZw8Q+rhppEMB19ro7BO6VuN7dn5ELjJpjzLDnCsLnHAmJUg76QVbr15RlNupVPczMgOt
	WYkrmzXN0jXh8lEMvXbiTMmKmjoXOSWj46V1Cq2SE+xjtzOUeBeI2TCoF+OAImGTyva3Ujp36uUn2
	+OMa3CNuLMCPwwJtY0Kp5TaNEtIzTJgcWZ1rDSglQuY4CGsVryG5zGIVdAkk8GgEeZN9Yd8LC/G5i
	eU1Z+j1RLVNA9qCUpGXnxdd7hU17+050tLzAXhcYSJFagJ/wJ9TbMYxkYmr5DaiWwyI0KVcfok/4+
	uvU/cxWw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xNgk3-00069h-Pc; Mon, 02 Nov 2026 02:21:43 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xNgjp-00AfUJ-El;
	Mon, 02 Nov 2026 02:21:29 +0100
Message-ID: <5a411a67-f550-459d-be9b-5e8e51d3018c@rbox.co>
Date: Mon, 2 Nov 2026 02:21:27 +0100
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
Subject: Re: [PATCH net-next v4 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@kernel.org>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me,
 jlinbox@meta.com
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-4-047527cfccfc@meta.com>
 <atjZZP2ebhXKzMxL@sgarzare-redhat>
 <atld3+5LKmGxJ8+s@devvm29614.prn0.facebook.com>
 <atnjOZjKUBagRVWq@sgarzare-redhat>
 <d946003a-8bec-4e8b-89a3-05eeb96780cc@rbox.co>
 <auT+YIawHSMPHbJI@devvm29614.prn0.facebook.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <auT+YIawHSMPHbJI@devvm29614.prn0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/26 21:30, Bobby Eshleman wrote:
>>>> Yeah its all kind of a pain. The problem is that we need to hold
>>>> sock_lock to set sk_state and sk_err, but can't acquire it under the
>>>> table lock. Instead, we grab the socket ref sock_hold under the table
>>>> lock to guarantee it stays alive between releasing the table lock and
>>>> grabbing the socket lock.
>>>>
>>>> I was really tempted to not do this lock_sock dance though. The race
>>>> condition I'm avoiding here is that if this reset races with an RST
>>>> receive, then the socket could end up with TCP_CLOSING + sk_err
>>>> ECONNRESET... but I'm not sure this actually propagates up into a real
>>>> problem for any potential user.
>>
>> Right, vsock_connect() is fragile. Two things to be cautious about:
>> 1. Don't let it reset the already connected socket. Because that would
>> allow user to "re-connect()" and make mess in connected_table.
>> 2. Don't let it re-assign transport of an already connected socket. Because
>> that breaks the contract in few places.
>>
>> State 1 is not an issue: vsock_g2h_reset_unreachable() calls
>> __vsock_remove_connected().
>>
>> State 2 may be problematic: if vsock_g2h_reset_unreachable() sets TCP_CLOSE
>> when connect() is scheduled out, then after the wake-up sock may get reset
>> to SS_UNCONNECTED. Then user re-connect()s and hits the transport
>> re-assignment logic. I'm worried that, as we re-assign, someone may be
>> holding a reference to such "connected" (even if not in connected_table
>> anymore) vsock.
> 
> I see path you're looking at... after vsock_connect() gets scheduled
> back in we set TCP_CLOSE/SS_UNCONNECTED if sock_error returns non-zero.
> Could you elaborate on your last concern there about someone holding a
> reference? I'm not sure I fully understood.

Ah, sorry, let me explain. This case reminded me of the vsock's TCP_CLOSING
bug[1]: reporter mentioned vsk->trans getting freed when skb was still in
flight. I did not reproduce the exact scenario, but it did sound plausible
and I thought it applies here: virtio_transport_destruct() frees vsk->trans
the moment vsock_loopback_work() invokes virtio_transport_consume_skb_sent().

Now, to get there let's start with vsock_connect() setting SS_UNCONNECTED
(on a connected) socket after vsock_g2h_reset_unreachable(). Then user is
able to re-assign the transport, which involves
virtio_transport_destruct(). But since we're dealing with a connected
socket, (before the reset) some send() might have triggered
vsock_loopback_work(). Does this make sense to you?

Another thing is this feature of vsock_assign_transport(): in some
re-assign failure paths you may end up with vsk->transport = NULL. In the
past this caused issues with sockmap: see WARN_ON_ONCE in
vsock_bpf_recvmsg(). Problem here is that normally vsock gets removed from
sockmap on close(), but in our (reset+reassign) case close() is never invoked.

[1]: https://lore.kernel.org/netdev/anzT1fREOSyHT99k@v4bel/

>> So I don't know, maybe it's vsock_connect() that should be fixed/hardened
>> instead?
>>
>> Or at least disallow transport *re*-assignment? Does the "re-" part have a
>> use case?
>>
>> Hope it's not too off-topic.
>>
>>>> It also avoided some racing with the tx path, but now that send_pkt()
>>>> also checks reachability I think that path is safe.
>>>>
>>>> What do you think about doing the below hunk (TCP_CLOSE, ECONNRESET,
>>>> sk_error_report) with no lock_sock?
>>>
>>> Looking at the code, it seems that in all the places where we close all 
>>> connections (virtio_vsock_reset_sock, vhost_vsock_reset_orphans) we do 
>>> with no lock_sock but with vsock_table_lock.
>>>
>>> So, makes sense to me.
>>
>> virtio_vsock_reset_sock() and vhost_vsock_reset_orphans() are my pet
>> peeves: state switcheroo without taking lock_sock(). Which, again, races
>> vsock_connect().
> 
> True, I don't love that either, but I feel the impact is at least
> constrained by the fact that it only happens when the module or device
> is already going away.

Doesn't it happen on suspend as well? Is so, with a poorly timed connect()
things can go south on resume.
