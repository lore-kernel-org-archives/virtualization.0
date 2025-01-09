Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA4E21B1A8
	for <virtualization@lists.linux.dev>; Thu,  9 Jan 2025 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430182; cv=none; b=ZfPBK0u2Tq2PXv5L8FN0cHwScTabEZslVqWn9QRP0XhvFOsKhbVESg4vdHEBiMGRlTM2ptu2lwjEFHdxgc712j5mXNA5WF6Bb2NotykVYMBxE9/TWb6xqGFuo9kHOlqNkjOY4sppTnzR8euYsYRGWe0owY40VvxLxMrQ0eQwv1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430182; c=relaxed/simple;
	bh=8dqpi+3F9iCh0CcG9gTM7Zeb5SSODkpsvXGULp+sSA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iiTUGNAuiYdLr+qB7vu2d/0/mmqoig1FRD51FQrR7gIHcZdDV1JvpjZ7hQU81jhkBo0wDIkP3tcyP3gXiJeW3Hx5bbqraZzd2gRspsF/VzD7NuJK2WjGecmPeeg41+4YFp4RAD4Rn+8oxknyBbfqJepx5dYu8LbWd8a/3nSotkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XsweSqdn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsweSqdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736430180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kkO1Khp0HMapbaFR2ikf7uwESckJYrFFK8Z3Z9FYmUA=;
	b=XsweSqdnksI0ZHKl+MC7CRKarhcQhbTnm2N72BpZZ+TBuiSH3TSnRnbabzcoTyYklfWLFQ
	HbnCCQ2HJ2cFb0jbbZG74sQHb1zbAl+Qrj4LD0FMiDOsrEoHz6idVOHSuu3hX1Y+55v12z
	qHLSQLeUkYsT+b1x9mFeQLRF4WN93io=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-sgekwoUgP7-o0y_QljiT1g-1; Thu, 09 Jan 2025 08:42:58 -0500
X-MC-Unique: sgekwoUgP7-o0y_QljiT1g-1
X-Mimecast-MFC-AGG-ID: sgekwoUgP7-o0y_QljiT1g
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-436219070b4so4775565e9.1
        for <virtualization@lists.linux.dev>; Thu, 09 Jan 2025 05:42:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736430178; x=1737034978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkO1Khp0HMapbaFR2ikf7uwESckJYrFFK8Z3Z9FYmUA=;
        b=bRU3+KuGfl9WU8RvxxBXa6XA959UkKnnf1ChTu948Y1O+KFt2la4ndS0n86GvRSt+B
         WkV+GON2TCw8k9drbTTf8xgyaD1jaTFlaJsP7AeRG6gIp7LHxd8/IoPdC69Fw842LYG8
         8hl45mnErP2IXT3i52zMJd/hcSTdcmeRReldUMSfdRnpcTq0mJ6Oek2PqNGJSLEaxLED
         SkKMFMUcPy12Myj/UAVaG377gj4uKVYnVoYuH7KP3rjHeKGhjMpaHOJNcj1WlS+r9hTM
         H8Uvn/12ofI7BpLoJl62NJljmzul6wk6k18UiScx0WcYSpfVVHu/D8kDJ++c1cuAlNqJ
         5xYg==
X-Forwarded-Encrypted: i=1; AJvYcCWTtHaVpGykYCC3hK7CjXC8jInjDg/HvwX5WC1C2bBZN8aDISdzL4y6LJxzNzhDKwC1DC3U2lYeJBACBTK2Ww==@lists.linux.dev
X-Gm-Message-State: AOJu0YycTNqKNU4xb4YbOO5Hr3ee0Oj8J+6s5Dmzq5wfBykjGkqBD7yz
	3lBp9aXEf8g2+nrssumocBSxYDiweWzrDGnskKgOsGaXwdtgWS7g5mo4WxYQsN7f2MCw1GscOS/
	UEBqfz9gCIcJOZUzWANMb5vv4iQ1sDMQw+BUFDiB+Syfa1YgRm9xZ/bJh0GUtX3gt
X-Gm-Gg: ASbGncvycqS70ZyMs/jjNziBWMc/bXnPrgHm1BMyV44+xmeFTGMTDtzmrcZAfHSqlSf
	idforyLjBrcLyQsAXk8MOjDHiM9JluCZ7/cze+wLeaIBnyPTQSg0KYWNUpJWwDIUDsGFex/2eHD
	xGZw9kvmjF28AATvvbU97JsjqwORhUoBCsMNeXxfmaQjRYGNbVNq+nO2KZj5XDvUBosxnA4G3tt
	Nxdgk4STnQmU1bv43Co6zIywINNDGiIxqQ+P+pPmDdJZdyBqNYxAkAOsY0=
X-Received: by 2002:a05:600c:1f86:b0:436:51bb:7a43 with SMTP id 5b1f17b1804b1-436ee0f8af6mr486105e9.5.1736430177653;
        Thu, 09 Jan 2025 05:42:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5m4tfgVUXXtQrzZe1N8yHzwLbDrucPzBnV0KJqzaPNouhBoh4EpWaQZfS/qgi6tjX8hNSVA==
X-Received: by 2002:a05:600c:1f86:b0:436:51bb:7a43 with SMTP id 5b1f17b1804b1-436ee0f8af6mr485655e9.5.1736430176950;
        Thu, 09 Jan 2025 05:42:56 -0800 (PST)
Received: from sgarzare-redhat ([5.77.115.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0bdsm1871927f8f.3.2025.01.09.05.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 05:42:56 -0800 (PST)
Date: Thu, 9 Jan 2025 14:42:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wongi Lee <qwerty@theori.io>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	virtualization@lists.linux.dev, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Luigi Leonardi <leonardi@redhat.com>, bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Hyunwoo Kim <v4bel@theori.io>, kvm@vger.kernel.org
Subject: Re: [PATCH net 1/2] vsock/virtio: discard packets if the transport
 changes
Message-ID: <wix5cx7uhthr6imrpsliysktyae6xwuzpvg77uscswyqwszzfb@ms5osa4ckdcm>
References: <20250108180617.154053-1-sgarzare@redhat.com>
 <20250108180617.154053-2-sgarzare@redhat.com>
 <2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k7Obs0l6RTJIkANuroAoxG7gRSYmsD1zdRavS4b38OQ_1736430178
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jan 09, 2025 at 02:34:28PM +0100, Michal Luczaj wrote:
>On 1/8/25 19:06, Stefano Garzarella wrote:
>> If the socket has been de-assigned or assigned to another transport,
>> we must discard any packets received because they are not expected
>> and would cause issues when we access vsk->transport.
>>
>> A possible scenario is described by Hyunwoo Kim in the attached link,
>> where after a first connect() interrupted by a signal, and a second
>> connect() failed, we can find `vsk->transport` at NULL, leading to a
>> NULL pointer dereference.
>>
>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>> Reported-by: Hyunwoo Kim <v4bel@theori.io>
>> Reported-by: Wongi Lee <qwerty@theori.io>
>> Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  net/vmw_vsock/virtio_transport_common.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 9acc13ab3f82..51a494b69be8 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>>
>>  	lock_sock(sk);
>>
>> -	/* Check if sk has been closed before lock_sock */
>> -	if (sock_flag(sk, SOCK_DONE)) {
>> +	/* Check if sk has been closed or assigned to another transport before
>> +	 * lock_sock (note: listener sockets are not assigned to any transport)
>> +	 */
>> +	if (sock_flag(sk, SOCK_DONE) ||
>> +	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
>>  		(void)virtio_transport_reset_no_sock(t, skb);
>>  		release_sock(sk);
>>  		sock_put(sk);
>
>FWIW, I've tried simplifying Hyunwoo's repro to toy with some tests. Ended
>up with
>
>```
>from threading import *
>from socket import *
>from signal import *
>
>def listener(tid):
>	while True:
>		s = socket(AF_VSOCK, SOCK_SEQPACKET)
>		s.bind((1, 1234))
>		s.listen()
>		pthread_kill(tid, SIGUSR1)
>
>signal(SIGUSR1, lambda *args: None)
>Thread(target=listener, args=[get_ident()]).start()
>
>while True:
>	c = socket(AF_VSOCK, SOCK_SEQPACKET)
>	c.connect_ex((1, 1234))
>	c.connect_ex((42, 1234))
>```
>
>which gives me splats with or without this patch.
>
>That said, when I apply this patch, but drop the `sk->sk_state !=
>TCP_LISTEN &&`: no more splats.

We can't drop `sk->sk_state != TCP_LISTEN &&` because listener socket 
doesn't have any transport (vsk->transport == NULL), so every connection 
request will receive an error, so maybe this is the reason of no splats.

I'm cooking some more patches to fix Hyunwoo's scenario handling better 
the close work when the virtio destructor is called.

I'll run your reproduces to test it, thanks for that!

Stefano

