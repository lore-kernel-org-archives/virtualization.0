Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4229C334C10
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763548591; cv=none; b=qts/xobkVljwoYd5xqzQNdA1dVzyuLQ2hLsg6PooQs1FPn6dBbNwaohTPC89OHGUpgdES8jCnMIXfV12dW7IpzlEXwidRlOFF3RANqmIUeYnwVwKkmWr2mUzjtIC2fdfcj9EKls66GYVJUTTMJVc2Z3hlP2m6m5Ap+/0+xqa+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763548591; c=relaxed/simple;
	bh=kcdSh/PleBZTikfdfxnDkRlvpKVEXW64pLQbMvoyV0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tdqmFpcmvflTdVlCtemvPqYR9i2dMvxLb5X9yYf9irt6v2E+y7Y4jmwFsp/BtvKycq6Bj+zvaCtWtpByUmZpfYkUi8dT9Y/gtCfbHRyCO2JrdPSHsL1UfS/vqawj0+xxCnojesyggeACZZ1wCBHkF4betyJq4IHmRnKeWEcx6qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfzVWmEp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfzVWmEp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763548589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gf49AAxeoAe3fsAYRgAbyAHDAwCYQHRIMr0VODeYCYE=;
	b=cfzVWmEpTHRglvvlGvSpz38Y++5VfC/fGAhB9ZvEPwC2PCrSVQlCKylnAex9AsHgg/LOAy
	w+FrNAHnwN4rhCGDpiy17Z5cdHkho1Je0NDaqSdvLAOyrt9GBBBaqI3kgDaIK6f3XdUaY6
	xvK88kKTGhkmL2uVrb5D9GRm8vWslko=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-V9Jw4QGSMUSw6MICQCixlA-1; Wed, 19 Nov 2025 05:36:28 -0500
X-MC-Unique: V9Jw4QGSMUSw6MICQCixlA-1
X-Mimecast-MFC-AGG-ID: V9Jw4QGSMUSw6MICQCixlA_1763548587
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b22d590227so796635185a.1
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 02:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763548587; x=1764153387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gf49AAxeoAe3fsAYRgAbyAHDAwCYQHRIMr0VODeYCYE=;
        b=pz4bYjippaaosGkJh996Iasj6osn+5vHu0Hb/7BDkz3+AgmRXQjIkVGQ++k2/7rtkR
         VbBteHBfLaRtA5f+8FbELcpCwTYSxB0GEzgSTCz8sf13j9xMI0wVUUoqgojag5560X5W
         ZjQkTzBoRBNhZAege8pGT7uHx1FAzozM2kRn/Y7D9Wm6ovdKL22bIRgTIsQlQ0phaMWe
         L4a72TWhBqVSgpVyxsCqPSbyYazt11jEZHsakxNncz1dQwLzZnnmwqp2OgdrPW4PziUY
         7FS8X2BvgXw61L8jMV5EBFTBsmKImdp1svTvdcX4yg7uVLOjqw0ETUwO2u9hzE4xL7jZ
         kfSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9obGGyM9hHMVYqatvY5KUFL7Eje0Y9YPTrVmB98GhqWkO2brCUB6kO4Vv+AbKKA/GTuBALZ8Nwo0UeXOxUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyifCjNaM04C9uT2OAJFOREMjLVXAaUBj8buZi0tKWOcNUwySjz
	k+sNHgIGggOdr9H4hIE6rV89e0i0S0Nmp/XcRT/BmwmLS3kWsOU088sW7WvWtI2Cb4A0WSm3Q2m
	3QS6DPQSOBrXy5tMadg/Qfw5EnKWICUcADwon6+959kyYg/HNuU41jiu3yCHlmFeT10Y8
X-Gm-Gg: ASbGncu/TmvTpAMV9BnLRfjh34GBC6cQQS7YGTCMtBVu4QwCaxa4wxMb81J+pz6XNJc
	SFForUZRqpC+5haOhVpQzYQXadUwLf5l6D8kFSzdwomOP7xrt8RYB+5gxDTqBsKnFB5RuB34+/A
	98yDw9YRvHiAoAYyr/H5kQgnDoZQlIdk+ALpIp0YcHqrfRrkd81jvRfonTY+c/27nFmhrBF0z4D
	XZ9JliIL4QJ6Jij1P4mQitQTbsLqRE3V3PwnBT6bnEpgYtomj+YynKudF6JBRzqoVw3SGkPfMt/
	mSKVmNEhlbDIcH4A4PK+F6kjNxJeBUwoqqq6nuwiUZWOvkTVP9FXzH6Pl8sxtVytbvsRF3XTLoT
	Jgu0Ts3CaPZkq0KyocTbaJkXdVNYK06JKRCN6i9WhzOhoQA8NePw0UJuHOG5+kQ==
X-Received: by 2002:a05:622a:10f:b0:4ed:6a9c:7234 with SMTP id d75a77b69052e-4edf2168c05mr266308361cf.82.1763548587548;
        Wed, 19 Nov 2025 02:36:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGVGJYPcB6hMM4y6xFLsb0pmmyzT45mb5Y4pZPNRH1v2gTnyuz3m9keijTXuBrk/slwac9+Q==
X-Received: by 2002:a05:622a:10f:b0:4ed:6a9c:7234 with SMTP id d75a77b69052e-4edf2168c05mr266308091cf.82.1763548587068;
        Wed, 19 Nov 2025 02:36:27 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede86b3adesm124475941cf.1.2025.11.19.02.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 02:36:24 -0800 (PST)
Date: Wed, 19 Nov 2025 11:36:15 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: Ignore signal/timeout on connect() if already
 established
Message-ID: <rptu2o7jpqw5u5g4xt76ntyupsak3dcs7rzfhzeidn6vcwf6ku@dcd47yt6ebhu>
References: <20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co>
 <dh6gl6xzufrxk23dwei3dcyljjlspjx3gwdhi6o3umtltpypkw@ef4n6llndg5p>
 <98e2ac89-34e9-42d9-bfcf-e81e7a04504d@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <98e2ac89-34e9-42d9-bfcf-e81e7a04504d@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Va-VxpfuAtssCMvDTanI1lCJz8J-r1P_gH2zAHp_at4_1763548587
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 18, 2025 at 11:02:17PM +0100, Michal Luczaj wrote:
>On 11/18/25 10:51, Stefano Garzarella wrote:
>> On Mon, Nov 17, 2025 at 09:57:25PM +0100, Michal Luczaj wrote:
>>> ...
>>> +static void vsock_reset_interrupted(struct sock *sk)
>>> +{
>>> +	struct vsock_sock *vsk = vsock_sk(sk);
>>> +
>>> +	/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
>>> +	 * transport->connect().
>>> +	 */
>>> +	vsock_transport_cancel_pkt(vsk);
>>> +
>>> +	/* Listener might have already responded with VIRTIO_VSOCK_OP_RESPONSE.
>>> +	 * Its handling expects our sk_state == TCP_SYN_SENT, which hereby we
>>> +	 * break. In such case VIRTIO_VSOCK_OP_RST will follow.
>>> +	 */
>>> +	sk->sk_state = TCP_CLOSE;
>>> +	sk->sk_socket->state = SS_UNCONNECTED;
>>> +}
>>> +
>>> static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>>> 			 int addr_len, int flags)
>>> {
>>> @@ -1661,18 +1678,33 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>>> 		timeout = schedule_timeout(timeout);
>>> 		lock_sock(sk);
>>>
>>> +		/* Connection established. Whatever happens to socket once we
>>> +		 * release it, that's not connect()'s concern. No need to go
>>> +		 * into signal and timeout handling. Call it a day.
>>> +		 *
>>> +		 * Note that allowing to "reset" an already established socket
>>> +		 * here is racy and insecure.
>>> +		 */
>>> +		if (sk->sk_state == TCP_ESTABLISHED)
>>> +			break;
>>> +
>>> +		/* If connection was _not_ established and a signal/timeout came
>>> +		 * to be, we want the socket's state reset. User space may want
>>> +		 * to retry.
>>> +		 *
>>> +		 * sk_state != TCP_ESTABLISHED implies that socket is not on
>>> +		 * vsock_connected_table. We keep the binding and the transport
>>> +		 * assigned.
>>> +		 */
>>> 		if (signal_pending(current)) {
>>> 			err = sock_intr_errno(timeout);
>>> -			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
>>> -			sock->state = SS_UNCONNECTED;
>>> -			vsock_transport_cancel_pkt(vsk);
>>> -			vsock_remove_connected(vsk);
>>> +			vsock_reset_interrupted(sk);
>>> 			goto out_wait;
>>> -		} else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 0)) {
>>> +		}
>>> +
>>> +		if (timeout == 0) {
>>> 			err = -ETIMEDOUT;
>>> -			sk->sk_state = TCP_CLOSE;
>>> -			sock->state = SS_UNCONNECTED;
>>> -			vsock_transport_cancel_pkt(vsk);
>>> +			vsock_reset_interrupted(sk);
>>> 			goto out_wait;
>>
>> I'm fine with the change, but now both code blocks are the same, so
>> can we unify them?
>> I mean something like this:
>> 		if (signal_pending(current) || timeout == 0 {
>> 			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
>> 			...
>> 		}
>>
>> Maybe at that point we can also remove the vsock_reset_interrupted()
>> function and put the code right there.
>>
>> BTW I don't have a strong opinion, what do you prefer?
>
>Sure, no problem.
>
>But I've realized invoking `sock_intr_errno(timeout)` is unnecessary.
>`timeout` can't be MAX_SCHEDULE_TIMEOUT, so the call always evaluates to
>-EINTR, right?

IIUC currently schedule_timeout() can return MAX_SCHEDULE_TIMEOUT only 
if it was called with that parameter, and I think we never call it in 
that way, so I'd agree with you.

My only concern is if it's true for all the stable branches we will 
backport this patch.

I would probably touch it as little as possible and continue using 
sock_intr_errno() for now, but if you verify that it has always been 
that way, then it's fine to change it.

Thanks,
Stefano

