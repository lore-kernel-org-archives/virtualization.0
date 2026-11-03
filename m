Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721494;
	b=wZ46EY9lgZ40KKycy6bdidvRgLENzwHtNospIS5R+hJpZwcDtGy1i16izDfx1a7IOGTO
	 g/bggTCuAcvD3kNerXrXB17DDjkgOfyQZrOAoI/6fZdCKJzibe8FWkhkm5BfdRN7VV+fT
	 dTOIet+19EsjMNtpgxv/tL0RMBMNtx7y8Gn37fjt7lB90pPDyQgePGM8a0CSVbNPmOmGg
	 HhvxP3Rhi+dUjaEFB7r8kK55xF/qohH+BTXXOkIm6KRZrj3Oq2AAjsb8L82qgaC4MBqd8
	 ey/6eJhrrKTRselJ/yRvAa0aB+Eg1g8vki7MxkhTIryBCSNtSBE74t3tRu3CZyw/o4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721494;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=eHLjN2pJ45O4GWNQW34u+4wkoWtEbyhvJN6ANTzGZ9Y=;
	b=cmScya09rOOLUm+fQH76o4D5Ku5CeeG8JjcN/puHYE6B47MgK3vhKD4c22MpyyIuLCW/
	 HH0ktlZMzdt48jjfIYTRfzDOLnnSC53C9KDvFizL3Ebe0rsGlcF430Q0W2g0A06BHmDzk
	 Y7Gm5eV8f6BO9Nkbx1K8HddfMxvAupQrxgZmjvUz85We3d+hU4/Sdu/8GW1CbAQd8mZSb
	 46rUgl4qz7xeuKknQgcRyCNzwaO/8hnezvvpinyl3nyN5UXSWx/jDw5CUppz4+Efn21+Y
	 qpg3HnGO32AVng+eJr2GWTZxuZe9b9Ea8q+0Imm2aB9b3xdAkbGNFNz2IUwEFYl4gjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=ySks7D3x;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10837606A334;
	Tue,  3 Nov 2026 15:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10837606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=ySks7D3x
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xOGtc-00CzEE-MG; Tue, 03 Nov 2026 16:58:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=eHLjN2pJ45O4GWNQW34u+4wkoWtEbyhvJN6ANTzGZ9Y=; b=ySks7D3xZqN9aJFyVj67piYgIB
	oOYQOoN1W7ezpr9blYnx/5bLQR0BMxnCddzIgp16Yn0HmCcORUng2LdjBRb4Zc4dZZS0gRooF34m0
	6ipDLUkIHT0dNcZaUmwWIvs29QnXbYomvbn+ylljE44D+6Px3YjDTLFy0j5U6h95QLtI9hNm3IPH8
	wxJRc/Qn1S1MoW+QOeVug0bDkV57wPHNfr/UFoetZMdvhsfpxh7avNYJ5VxlgoUfZv/qFWwzK0UR8
	5jYtBivCJTRNINptO1BvLFkRQ47OpDht6t6WcZjA0UX/9/Uy5x6uW8VuIXrBsQopTbKsgU0AGlDxZ
	I+i+7yoA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xOGt5-0001bx-2d; Tue, 03 Nov 2026 16:57:27 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xOGt2-00EocX-14;
	Tue, 03 Nov 2026 16:57:24 +0100
Message-ID: <0fa25128-1300-40f2-8d21-d09e21bcc96e@rbox.co>
Date: Tue, 3 Nov 2026 16:57:22 +0100
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
 <5a411a67-f550-459d-be9b-5e8e51d3018c@rbox.co>
 <aujn5/nm9f9YX6bM@devvm29614.prn0.facebook.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <aujn5/nm9f9YX6bM@devvm29614.prn0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/26 20:43, Bobby Eshleman wrote:
> On Mon, Nov 02, 2026 at 02:21:27AM +0100, Michal Luczaj wrote:
>> On 10/30/26 21:30, Bobby Eshleman wrote:
>>>>>> Yeah its all kind of a pain. The problem is that we need to hold
>>>>>> sock_lock to set sk_state and sk_err, but can't acquire it under the
>>>>>> table lock. Instead, we grab the socket ref sock_hold under the table
>>>>>> lock to guarantee it stays alive between releasing the table lock and
>>>>>> grabbing the socket lock.
>>>>>>
>>>>>> I was really tempted to not do this lock_sock dance though. The race
>>>>>> condition I'm avoiding here is that if this reset races with an RST
>>>>>> receive, then the socket could end up with TCP_CLOSING + sk_err
>>>>>> ECONNRESET... but I'm not sure this actually propagates up into a real
>>>>>> problem for any potential user.
>>>>
>>>> Right, vsock_connect() is fragile. Two things to be cautious about:
>>>> 1. Don't let it reset the already connected socket. Because that would
>>>> allow user to "re-connect()" and make mess in connected_table.
>>>> 2. Don't let it re-assign transport of an already connected socket. Because
>>>> that breaks the contract in few places.
>>>>
>>>> State 1 is not an issue: vsock_g2h_reset_unreachable() calls
>>>> __vsock_remove_connected().
>>>>
>>>> State 2 may be problematic: if vsock_g2h_reset_unreachable() sets TCP_CLOSE
>>>> when connect() is scheduled out, then after the wake-up sock may get reset
>>>> to SS_UNCONNECTED. Then user re-connect()s and hits the transport
>>>> re-assignment logic. I'm worried that, as we re-assign, someone may be
>>>> holding a reference to such "connected" (even if not in connected_table
>>>> anymore) vsock.
>>>
>>> I see path you're looking at... after vsock_connect() gets scheduled
>>> back in we set TCP_CLOSE/SS_UNCONNECTED if sock_error returns non-zero.
>>> Could you elaborate on your last concern there about someone holding a
>>> reference? I'm not sure I fully understood.
>>
>> Ah, sorry, let me explain. This case reminded me of the vsock's TCP_CLOSING
>> bug[1]: reporter mentioned vsk->trans getting freed when skb was still in
>> flight. I did not reproduce the exact scenario, but it did sound plausible
>> and I thought it applies here: virtio_transport_destruct() frees vsk->trans
>> the moment vsock_loopback_work() invokes virtio_transport_consume_skb_sent().
>>
>> Now, to get there let's start with vsock_connect() setting SS_UNCONNECTED
>> (on a connected) socket after vsock_g2h_reset_unreachable(). Then user is
>> able to re-assign the transport, which involves
>> virtio_transport_destruct(). But since we're dealing with a connected
>> socket, (before the reset) some send() might have triggered
>> vsock_loopback_work(). Does this make sense to you?
> 
> Ah you're right. I think that your approach of making vsock_connect()
> more robust is probably the right way to go...
> 
> I think this is the new race...
> 
> 1) vsock_connect(cid=VMADDR_CID_HOST)
>    -> enqueue pkt
>    -> sleep
> 
> 2) rx worker receives OP_RESPONSE
>    ->  sets TCP_ESTABLISHED/SS_CONNECTED
> 
>    (vsock_connect() still asleep)
> 
> 2) sendmsg()
>    -> sees SS_CONNECTED
>    -> enqueues skb
> 
> 3) netns reset sets TCP_CLOSE and sk_err=ECONNRESET
> 
> 4) vsock_connect()
>    -> scheduled back in
>    -> sees sk_err != 0
>    -> sets SS_UNCONNECTED
> 
> 5) vsock_connect(CID=VMADDR_CID_LOCAL) call #2
>    -> sees SS_UNCONNECTED
>    -> frees old vsk->trans
> 
> 6) sendmsg's skb tx completes
>    -> tx worker dereferences vsk->trans for the UAF

Yes, that's exactly what I've meant.

> If connect() checks for SS_CONNECTING before setting SS_UNCONNECTED,
> then in step 4 sock->state stays as SS_CONNECTING and the second
> connect() call will hit -EISCONN instead of freeing vsk->trans.
> 
> Seems to work for a racing vsock_shutdown() too, where sock->state would
> become SS_DISCONNECTING, and the second connect() would hit -EINVAL
> instead of freeing the vsk->trans.
> 
> I guess the rule would be that vsock_connect() sets SS_CONNECTING before
> sleeping and only changes it to SS_UNCONNECTED after waking if and only
> if it is still SS_CONNECTING.
> 
> WDYT?

I think it's a great idea. Does seem to solve quite a lot.

thanks,
Michal

