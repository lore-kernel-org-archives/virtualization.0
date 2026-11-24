Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531164;
	b=jq5NPArmMtAhtMsFX594Z/2T8MplzZjsXO2F+THGN4wtPpQtJzmsc7AXiqOHFHpeXgTO
	 DLsLvYfduhkL1oG/v3A5tLpPrm+Fc/9+A8ANIRMhuWy/ngQTwZGOkh9B1O87SByatkMFo
	 fmETcyz8pgcTRHMd6ML49jLV9OlnOZMuePxyQ481UtYzWCMccO/djsC5FOZdUckEg7G4f
	 gqeQNHowCoCvEoexqnn9jkRuHx0EKOlMYV7Y73+EQ7MtaEHhYfQvhFjlioYpWy3iuATJU
	 SnLLN1wGqgMiwY2s6YBZjV5kvYesR8IVhsRgyTwlsmMtEFWiLVfcOJpZu+y4O6+WPRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531164;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding;
	bh=2stGQ4/HiGTctVyhMRCTqhZkagSo1oOLNXehp2IlUCY=;
	b=VbUXoVfyVNhZ2ol3qHm0Qx/yIN4yEqa7P96e4L/ogEalYjeZjcyytKJ7VqEdmBsi0LR4
	 i0cFNzRgOxHSh5EPkXf1xu8uAZdtOrgZk+iUzogP+F9nZakZo7yZSgls5yrPjropXnIGM
	 h++ZQM4reXQuHKJBB2PZ4vrdQUog8Mopu2GhfAdieCXyXgVrf5BJl//p3DSwCVBe2ARtx
	 Vj4vAcb3sw8nZILzPNRs1c/17GlsPpe7VMe8NVneuMiuGmhEEpXMyTdgZfP/EyGAUbwYc
	 RVRdfIIq3a5WpFGHOiNrBKtByCD70aqYM9KguI5e7aJZUdfRFHXfA8wGhBTuxAaeN5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T8UuG8ZY;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE65606A326
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 14:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EE65606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T8UuG8ZY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795531162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2stGQ4/HiGTctVyhMRCTqhZkagSo1oOLNXehp2IlUCY=;
	b=T8UuG8ZYCnnEw/hILltYbvL+Ws/MrVmKMp8C9lrgcXLNVCcyBvt7SNpl2rDqZHyyY7UO1z
	CL3rthACmy2uwv9jhY5JaEezqCeZOFf/sesVGDYVfuTzKhXEbYBIEVqQ0xbOZgSiv0EM4s
	mGn3RCvcZDPgrRzLvrI0Xn914/OOVw0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-E26KDNAwPoC5lYKCHodXkg-1; Tue, 24 Nov 2026 14:39:20 +0000
X-MC-Unique: E26KDNAwPoC5lYKCHodXkg-1
X-Mimecast-MFC-AGG-ID: E26KDNAwPoC5lYKCHodXkg_1795531159
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4a589b28bddso2576692f8f.0
        for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 06:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795531159; x=1796135959;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2stGQ4/HiGTctVyhMRCTqhZkagSo1oOLNXehp2IlUCY=;
        b=Na2/xxnfmV7rypqHTujngpNdqx654J1ectzgWUEkfwQ30mnA24IBPb2aHAGsouhLdl
         ksHLOxTjyKOJdhoQYmqR/u2o1zxh0j77IB2YGVeU5DpdEhE01OgiTtwv/1sU7jfQd8JZ
         CJzV0shdFy2LgsO4ChIWjNs60zkJ+5ZPA/VXoPjtOhVbKhWh4MZfupmAUN1Xs2VhkklZ
         /G25bymEMFYN3pSJjA5MJEivDnOBlP5hBbuIUWsWY7ttcKzQrthNMWKkMhbE8vfUtKML
         ueppB5pAxnHBAELwEB4g6q4bHREIznIXGxSO9fAJejpEqQA4TsJdyXToGZGrk9UvtnaU
         Q1VQ==
X-Forwarded-Encrypted: i=1; AL+hErGrgNtY7JW3rZtQxtfsVgLoQl/KAxZZZ/d5yY9XSAv94ABzBdv7CC73pnQXclFw+vopoeZfbemf7ix4mxt/NA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/vmsUfy5DKsK0UA/mDoG2uiWdMmHRhSNGSFQxpeH7qckCbXZkN
	qAzSP+qTQ63DD9vUq4pDZQKpTbpf3M/prWjurc/wljB+KcpMMkg+Tl3tPVl2X7iDPHsa9/i6s1L
	iOyrmoZMzByOu+JZv/ez4EP7WTuE11XU/UOxoK6icxKfm90Cuj3Zyf6TlBVaUpqUiQS6x
X-Gm-Gg: AZFdTZfz6ImVEJbSRrKbTBc6GgGtP27kKlGPKSXdE6HHaKhuCR119hZbhb9CxebSZGQ
	gip/afCPp0nS9XtCzgtQIu5z8Yl9PP+S1q5uFKtsLuyAcVLp/p2G4Uwatvr3tYiC4hsOZp56Fu3
	L+4aeMnkBODTf8ESjm0X7V2k6J5h6sUq0pAJ43PBiEC6+PrpETEi7Vb45yiDUZUO2V+yMvTh/Wa
	WitekKsqOh031SrXjtjphmdvfL0VV4sEB5Q3pZFA5A1LmhcP2CrrnU7gUf7uxPSS+DXGKw60hzL
	pHow9QqcnV3oCL1ubd2kmXzqhWzDGQ3dfbCkOxNW5DQgSdAVvaRicAPoKq5hEefhk1Jzb0XKeWZ
	17RPorY3VYX9+q2gYkGgtHe3ny0DGKYajAhk9qpStd37xWvaD/jyB9e+fcB2mGkGlL3agU7vdku
	SCM69OGVnMzDFFAm6vJ8xoM7VVuPseMM3Q6hgSPtt/tZ2t
X-Received: by 2002:a05:6000:4705:b0:48d:f851:ee5f with SMTP id ffacd0b85a97d-4abb225e5f9mr30398857f8f.24.1795531159359;
        Tue, 24 Nov 2026 06:39:19 -0800 (PST)
X-Received: by 2002:a05:6000:4705:b0:48d:f851:ee5f with SMTP id ffacd0b85a97d-4abb225e5f9mr30398797f8f.24.1795531158872;
        Tue, 24 Nov 2026 06:39:18 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c340df4sm32920486f8f.55.2026.11.24.06.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 06:39:18 -0800 (PST)
Message-ID: <ebb9c249-85bf-4737-841f-ab6ddcaab5a9@redhat.com>
Date: Tue, 24 Nov 2026 15:39:17 +0100
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
Subject: Re: [PATCH net v2] vsock: only undo SS_CONNECTING when connect()
 fails
To: Bobby Eshleman <bobbyeshleman@meta.com>, Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 George Zhang <georgezhang@vmware.com>, Andy King <acking@vmware.com>,
 Dmitry Torokhov <dtor@vmware.com>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kyle Zeng <kylebot@openai.com>
References: <20261117-vsock-connect-close-v2-1-db5388323770@meta.com>
 <ed28d36a-682e-4db5-abf4-1339734e7c57@rbox.co>
 <awTJ8EOl52W0ph1K@devvm29614.prn0.facebook.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <awTJ8EOl52W0ph1K@devvm29614.prn0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lcFBR3j0Dh6uZ0BGv7ZYbvUVQCoUsOKR6g4YpcgflFk_1795531159
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
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
> 
> It seems to work for vsock_connect_timeout() because that function only
> needs to test if the attempt to connect is still pending (if yes, then
> close everything up), but vsock_connect_close() needs to know more
> precisely if the socket still holds the state that this current connect
> attempt changed... so it separately checks "Did we set TCP_SYN_SENT? if
> so, set to TCP_CLOSE.  Did we set SS_CONNECTING?  If so, set to
> SS_UNCONNECTED."
> 
> I think it might even make more sense to consolidate in the other
> direction and make vsock_connect_timeout() a caller of the new
> vsock_connect_close(), since it appears there is a similar edge case
> there...
> 
> connect(), O_NONBLOCK
>    transport->connect()  /* OP_REQUEST */
>    mod_delayed_work(connect_work)
> 
> shutdown(SHUT_RDWR)
>    sock->state = SS_DISCONNECTING
>    sk_shutdown = SHUTDOWN_MASK
> 
> vsock_connect_timeout()
>    skips the socket because of SHUTDOWN_MASK
>    /* still TCP_SYN_SENT / SS_DISCONNECTING */
> 
> late OP_RESPONSE, virtio_transport_recv_connecting()
>    sk_state = TCP_ESTABLISHED
>    sock->state = SS_CONNECTED
>    vsock_insert_connected()
> 
> So the attempt never times out, and a late OP_RESPONSE connects a
> socket the user already shut down, overwriting SS_DISCONNECTING with
> SS_CONNECTED. I think that's a separate bug for a separate patch,
> though.
> 
> Or am I off track / missing something?
I have slightly different question: is the 'multiple threads
connecting/disconnecting the same socket concurrently' a
relevant scenario? Otherwise if final state is self-consistent
(i.e. _NOT_ TCP_SYN_SENT + SS_DISCONNECTING) I think there is
nothing to fix here.

/P


