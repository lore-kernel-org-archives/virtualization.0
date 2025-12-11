Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB34E288C2D
	for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765461427; cv=none; b=NrWiWYYJKL5rFijN5mgSph0zyGCXgfjYvPf78PwviiQN1K7qJsSmRR3fqdH0vByNaQpKNFwKeQlyZuwcSvESpXgCL+0fGFzi2593zAHm35IQDzAOoj1bJRM1sP68Xn37dcpHRnI4lztjkpJVs66QnDAEAwaF8+EE6wmo4umrEyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765461427; c=relaxed/simple;
	bh=+MVABDurZoU3qR9+rsjOF4huwV5cza451zquYpBwYAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qyXK0rI4zzt/OSyMdlCJthkP7VXT8OGOd1yoMXY1C4zue0Q6cfxDC5GJzBj9OyBaq3dTCYcnuecH4wi1Rr+4WAiHCMlDIgpUaolhmLG4w5pfDfOLrIk+LaRPtkFKInjXXCXy+OMGZMEb0pC8bV4qP69RCNUHTJYKWl/PqoMJI8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FdF/EiGH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdF/EiGH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765461423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsvyJctSZ+XWD9ctkjkuUDFq51ROW0DhwfkxivMg8ec=;
	b=FdF/EiGHrXp5YhPS1iZ3e/0mK9t8iJg1SRhO6xClj5rWIVYGQItBn4/aXBqE9jym8ltGKL
	EO/2OiMOncUl2iXMRPguZS3Ryp5LQgZdcR94aHksxnn+V0e1+MkeFmqMS0YqU4bESXZHxK
	f8VOMSQia0UNrg9b9FV5BFDerHsaXSA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-6-bScT_AMM-VTtFAUSfGow-1; Thu, 11 Dec 2025 08:57:02 -0500
X-MC-Unique: 6-bScT_AMM-VTtFAUSfGow-1
X-Mimecast-MFC-AGG-ID: 6-bScT_AMM-VTtFAUSfGow_1765461421
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b3ed2c3e3so105570f8f.1
        for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 05:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765461421; x=1766066221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsvyJctSZ+XWD9ctkjkuUDFq51ROW0DhwfkxivMg8ec=;
        b=k497aPzVjmIPSi8BlBcYCG+nyNrJ17g+JbFLP8R6Eg15e/+/PsSyabED3kaXYBBQsm
         vU3pD7cdKxhOlVqmMNnlrHNIP3dK4MAPlRLOlI1a7BHYq05zvJvDBU3qjsrZGmuJ/+DK
         X2pJXd0vQEeetbDzoICRPV3ta3ShX3DrcLxXp8i2PeeFk0ujH3UbRfPuquPsYKl3Etaj
         4VkbAo36oFNouvlhNeVeiNrpZIHXrZyN5KhY5Wh3GnzabDXy57kqA0hmCyIcfahgJTJG
         3E7ephurwq6+lOBvEdS6rSCQSoWb4FglxsIfqzwxtbgqJgkYEBB0kW4cYi3PI93kahXf
         cKFw==
X-Forwarded-Encrypted: i=1; AJvYcCUe8fg1yNB+8yO3lLlWI/44e1i5hP4CBKn+fC2fptA3Lgg4ZFCQaC/1EyRdXhxLdj0Tso9MJqqaDBq+JQVsCA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw26ywvjZ21+ijwAgynrCatYqBCnJXS34q6grZmmfLmGmb/PUyR
	UBUfVd/Dfuho3j76Jmm0kRQp6pyOrvn+iPqXgTLkXWFVi7wwWRsnmBb6nlTBqX4Q7lILOP+clTx
	43XSKppiYnAto+87mWJK56nnwTlMpt9o1x13pC7u1YIXsDYjNhLliZfwUlxgwh3aXNKwt
X-Gm-Gg: AY/fxX6/32StGY9xnhQeQAak3wWq8I5WSHg2/xumhd+UyKIXuywveswTjPtGcFM1c3b
	y2TWIaZYz/cA1Pe46OYsNHgniqxTmIKPiQVgRVxdV+yH4tOcZ1j5JK6sCHOO3lRd6F8mwCEmBK7
	EguhumGyNiOKcNpf4TCtt7aJnCWvu9uVjDuKtkrDHtNc6oDPmqbgD4JkVlroWi/fo3Eb0R1ay/4
	b2dntMYi7cpoYavIhvNUsaKjCVp24uXII1sNbzcrvNk1af+Ga3TUKpN+JQ3NfFLWevP0h6m8lx0
	TQPaSEhqnn0qAq17LZM+4knyI7iK79MgL3OTc7GrZ4drvsRnuOvFfATNEAL7hAkHROBEzJ8sbA/
	8isB2OwX6ygEF6FCsVmRTuXO6x5DhHpQhciOhzbHe/8BuRD+oBfJWLyyiVCP9ZQ==
X-Received: by 2002:a05:6000:178d:b0:429:dc9a:ed35 with SMTP id ffacd0b85a97d-42fa3b0aa73mr6515901f8f.43.1765461420994;
        Thu, 11 Dec 2025 05:57:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEGc99cmBNOvRu/1E0FcEBzDpZsrjVh8bWjY+YIg6PKhABRUKZzIdeQiTlGB1SQ5wUnM9hhw==
X-Received: by 2002:a05:6000:178d:b0:429:dc9a:ed35 with SMTP id ffacd0b85a97d-42fa3b0aa73mr6515868f8f.43.1765461420506;
        Thu, 11 Dec 2025 05:57:00 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b9b259sm5714243f8f.41.2025.12.11.05.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 05:56:58 -0800 (PST)
Date: Thu, 11 Dec 2025 14:56:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Melbin K Mathew <mlbnkm1@gmail.com>, stefanha@redhat.com, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net v3] vsock/virtio: cap TX credit to local buffer size
Message-ID: <zlhixzduyindq24osaedkt2xnukmatwhugfkqmaugvor6wlcol@56jsodxn4rhi>
References: <20251211125104.375020-1-mlbnkm1@gmail.com>
 <20251211080251-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251211080251-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B17Oz6rHlAhFd_eRkKTn-bCTgOHCZR08IZWLV9XpU8k_1765461421
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Dec 11, 2025 at 08:05:11AM -0500, Michael S. Tsirkin wrote:
>On Thu, Dec 11, 2025 at 01:51:04PM +0100, Melbin K Mathew wrote:
>> The virtio vsock transport currently derives its TX credit directly from
>> peer_buf_alloc, which is populated from the remote endpoint's
>> SO_VM_SOCKETS_BUFFER_SIZE value.
>>
>> On the host side, this means the amount of data we are willing to queue
>> for a given connection is scaled purely by a peer-chosen value, rather
>> than by the host's own vsock buffer configuration. A guest that
>> advertises a very large buffer and reads slowly can cause the host to
>> allocate a correspondingly large amount of sk_buff memory for that
>> connection.
>>
>> In practice, a malicious guest can:
>>
>>   - set a large AF_VSOCK buffer size (e.g. 2 GiB) with
>>     SO_VM_SOCKETS_BUFFER_MAX_SIZE / SO_VM_SOCKETS_BUFFER_SIZE, and
>>
>>   - open multiple connections to a host vsock service that sends data
>>     while the guest drains slowly.
>>
>> On an unconstrained host this can drive Slab/SUnreclaim into the tens of
>> GiB range, causing allocation failures and OOM kills in unrelated host
>> processes while the offending VM remains running.
>>
>> On non-virtio transports and compatibility:
>>
>>   - VMCI uses the AF_VSOCK buffer knobs to size its queue pairs per
>>     socket based on the local vsk->buffer_* values; the remote side
>>     can’t enlarge those queues beyond what the local endpoint
>>     configured.
>>
>>   - Hyper-V’s vsock transport uses fixed-size VMBus ring buffers and
>>     an MTU bound; there is no peer-controlled credit field comparable
>>     to peer_buf_alloc, and the remote endpoint can’t drive in-flight
>>     kernel memory above those ring sizes.
>>
>>   - The loopback path reuses virtio_transport_common.c, so it
>>     naturally follows the same semantics as the virtio transport.
>>
>> Make virtio-vsock consistent with that model by intersecting the peer’s
>> advertised receive window with the local vsock buffer size when
>> computing TX credit. We introduce a small helper and use it in
>> virtio_transport_get_credit(), virtio_transport_has_space() and
>> virtio_transport_seqpacket_enqueue(), so that:
>>
>>     effective_tx_window = min(peer_buf_alloc, buf_alloc)
>>
>> This prevents a remote endpoint from forcing us to queue more data than
>> our own configuration allows, while preserving the existing credit
>> semantics and keeping virtio-vsock compatible with the other transports.
>>
>> On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
>> 32 guest vsock connections advertising 2 GiB each and reading slowly
>> drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB and the system only
>> recovered after killing the QEMU process.
>>
>> With this patch applied, rerunning the same PoC yields:
>>
>>   Before:
>>     MemFree:        ~61.6 GiB
>>     MemAvailable:   ~62.3 GiB
>>     Slab:           ~142 MiB
>>     SUnreclaim:     ~117 MiB
>>
>>   After 32 high-credit connections:
>>     MemFree:        ~61.5 GiB
>>     MemAvailable:   ~62.3 GiB
>>     Slab:           ~178 MiB
>>     SUnreclaim:     ~152 MiB
>>
>> i.e. only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the
>> guest remains responsive.
>>
>> Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
>> ---
>>  net/vmw_vsock/virtio_transport_common.c | 27 ++++++++++++++++++++++---
>>  1 file changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index dcc8a1d58..02eeb96dd 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -491,6 +491,25 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
>>  }
>>  EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>>
>> +/* Return the effective peer buffer size for TX credit computation.
>> + *
>> + * The peer advertises its receive buffer via peer_buf_alloc, but we
>> + * cap that to our local buf_alloc (derived from
>> + * SO_VM_SOCKETS_BUFFER_SIZE and already clamped to buffer_max_size)
>> + * so that a remote endpoint cannot force us to queue more data than
>> + * our own configuration allows.
>> + */
>> +static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
>> +{
>> +	return min(vvs->peer_buf_alloc, vvs->buf_alloc);
>> +}
>> +
>>  u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
>>  {
>>  	u32 ret;
>> @@ -499,7 +518,8 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
>>  		return 0;
>>
>>  	spin_lock_bh(&vvs->tx_lock);
>> -	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>> +	ret = virtio_transport_tx_buf_alloc(vvs) -
>> +		(vvs->tx_cnt - vvs->peer_fwd_cnt);
>>  	if (ret > credit)
>>  		ret = credit;
>>  	vvs->tx_cnt += ret;
>> @@ -831,7 +851,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>>
>>  	spin_lock_bh(&vvs->tx_lock);
>>
>> -	if (len > vvs->peer_buf_alloc) {
>> +	if (len > virtio_transport_tx_buf_alloc(vvs)) {
>>  		spin_unlock_bh(&vvs->tx_lock);
>>  		return -EMSGSIZE;
>>  	}
>> @@ -882,7 +902,8 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
>>  	struct virtio_vsock_sock *vvs = vsk->trans;
>>  	s64 bytes;
>>
>> -	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>> +	bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
>> +		(vvs->tx_cnt - vvs->peer_fwd_cnt);
>>  	if (bytes < 0)
>>  		bytes = 0;
>>
>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
>
>Looking at this, why is one place casting to s64 the other is not?

Yeah, I pointed out that too in previous interactions. IMO we should fix 
virtio_transport_get_credit() since the peer can reduce `peer_buf_alloc` 
so it will overflow. Fortunately, we are limited by the credit requested 
by the caller, but we are still sending stuff when we shouldn't be.

@Melbin let me know if you will fix it, otherwise I can do that, but I'd 
like to do in a single series (multiple patches), since they depends on 
each other.

So if you prefer, I can pickup this patch and post a series with this + 
the other fix + the fix on the test I posted on the v2.

Stefano

