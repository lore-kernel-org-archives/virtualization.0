Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9AB45D90B;
	Wed,  9 Sep 2026 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991618; cv=none; b=DMLgZ3dPuKmvCUhDeEKQgEPymmVdAv/DSL/N6FvHag4wN4Sg9gVoZ+8b3dMxm5pieSVviY/Gun3fsPlCZrVuDfnyFM/+tO4NdqItFFcf8rHrwChw6bLDA1yakCGhDhQPwN1amxAhOMlVHndIgQom4YPsCakSwAZ1DJDKw+lEvYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991618; c=relaxed/simple;
	bh=zhamF1YEZiyf2s9A3XkbddvVHeH6TFDpcQeg7jivakw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BfUytD3p5KHb272Ol73S5IEzFMG7mpZPp37MogTKJy3NRv394phpksgN8BBFC5QVyVrOsAyPWf+51uzer7zmYRHgMTIVF0/x0AplS2OXZAFYrt88O+GTH0GYJBVFhwmCj7XJfUr6BzMcj4CKV49WF54ZELWLAEb8GGuPYExJaSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=FdZHrhjj; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="FdZHrhjj"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x4QRG-0022FL-Ti; Thu, 10 Sep 2026 00:06:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=mbtrJSJQDPTCk5h/S+ZCPyq99FhufN14XFpnDQdo3Qo=; b=FdZHrhjjgvEOwHwJoE9h4CqhHg
	FENu0M45lYsCy/8LrpYiUPJCpNhu6vJ631mFuEXRYEdihv1dVAtz0rWVkP4nqofpCf9tJtLLFc7qj
	XRxC68ad4tDE6Eym5/ax0+NfnqlFYDLrABIK3EqkVg7LSIKpeYmVHjlJA5TtCI7z7SE/5tF7bH3JH
	EA76sR6FSYzuRABa2wc4gQFpfeSEwSh60PLPtE1xDVYWaUYanYEKwx0lTj2RWkiugn+XEGQ2B15Cl
	lVV2vkVb/E8o+ExJ7sbiRPZDYw1j963uCY+WsFojMoAlu+OiJQM62BJMTEiuW9fV/xjHVxH8XyJw9
	uxIBAz8Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x4QR6-0002PE-Fm; Thu, 10 Sep 2026 00:06:32 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x4QR1-000J5F-Fp;
	Thu, 10 Sep 2026 00:06:27 +0200
Message-ID: <7cd32cc3-8acd-4048-9008-b5795e43d871@rbox.co>
Date: Thu, 10 Sep 2026 00:06:15 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net] vsock: do not reset a socket in connect() once it has
 connected
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 leonardi@redhat.com, bobbyeshleman@meta.com, stefanha@redhat.com,
 mst@redhat.com, virtualization@lists.linux.dev, netdev@vger.kernel.org
References: <anzT1fREOSyHT99k@v4bel>
 <218226a4-38e6-4a16-a660-6c1bb92f9f96@rbox.co> <an5zJ9Uf94_L9TyB@v4bel>
 <c11d6fe8-fdf9-4b45-b291-e5d5b0ef5cb4@rbox.co>
 <aoVnp0w9jlyFDPj7@sgarzare-redhat>
Content-Language: pl-PL, en-GB
In-Reply-To: <aoVnp0w9jlyFDPj7@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/26 10:54, Stefano Garzarella wrote:
>>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>>> index 622dbd046799..39c42ef016c3 100644
>>>> --- a/net/vmw_vsock/af_vsock.c
>>>> +++ b/net/vmw_vsock/af_vsock.c
>>>> @@ -1807,15 +1807,18 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>>>>  		timeout = schedule_timeout(timeout);
>>>>  		lock_sock(sk);
>>>>
>>>> -		/* Connection established. Whatever happens to socket once we
>>>> +		/* Connection (has been) established. Whatever happens to socket once we
>>>>  		 * release it, that's not connect()'s concern. No need to go
>>>>  		 * into signal and timeout handling. Call it a day.
>>>>  		 *
>>>>  		 * Note that allowing to "reset" an already established socket
>>>>  		 * here is racy and insecure.
>>>>  		 */
>>>> -		if (sk->sk_state == TCP_ESTABLISHED)
>>>> -			break;
>>>> +		if (sk->sk_state == TCP_ESTABLISHED ||
>>>> +		    sk->sk_state == TCP_CLOSING) {
>>>> +			err = -sk->sk_err;
>>>> +			goto out_wait;
>>>> +		}
>>>>
>>>>  		/* If connection was _not_ established and a signal/timeout came
>>>>  		 * to be, we want the socket's state reset. User space may want
>>>>
>>>> ?
>>>
>>> Yes, I like it better than mine. I confirmed it fixes the issue.
>>
>> Great, thanks.
>>
>>> If you don't mind, would you take the patch from here?
>>
>> Sure, no problem.
>>
>> Stefano, does this look good to you?
> 
> Yep, thanks for helping here!
> 
> My only doubt is if it makes sense to leave the `break` there, and add a 
> similar check before resetting the socket, I mean something like this:
> 
> 	err = sock_error(sk);
> 	if (err && sk->sk_state != TCP_ESTABLISHED &&
> 		   sk->sk_state != TCP_CLOSING)) {
> 		sk->sk_state = TCP_CLOSE;
> 		sock->state = SS_UNCONNECTED;
> 	}
> 
> Just to be a bit more defensive, but I don't have a strong opinion, your 
> version is also fine.
> 
>> And should any sk_err be consumed
>> here, too? (`err = sock_error(sk)` instead of `err = -sk->sk_err`)
> 
> I'd stay with sock_error() to consume the error if it makes sense also 
> for you.

Sure, one note: perhaps it's better to always return 0 on
TCP_ESTABLISHED/TCP_CLOSING? From connect()'s PoV these two states mean "we
did good, we connected to something for some time". Currently, even if the
connection was established, virtio_transport_recv_connected()'s
VIRTIO_VSOCK_OP_RW error handling may set sk_err = ENOBUFS, and connect()
would return that. Even though connect() itself was a success.

Anyway, here's a fix for the uaf:
https://lore.kernel.org/netdev/20260909-vsock-connect-reset-closing-v1-1-50298b9ccfbf@rbox.co/
It's incomplete, but I'm not sure how to follow up. Please see the
below---comment.

thanks,
Michal

