Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E272654A7EF;
	Tue, 22 Sep 2026 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083098; cv=none; b=E0q2q3UbaaPGRWrDmkxUU+qtfLtbeTn7w5Fm2VSPxThPY5WMq3riePsgvwn9WvhYuWnjr/QAjo/0nqh1yfhoOMiaagglU5/V7n737ZcGJIQnDgVDme6ptgPG931JsoaVDPc6f1tHqAqcYHomYkhQhnt+uB34R5Wka+LV/xgGkXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083098; c=relaxed/simple;
	bh=ZEI88Gn0b0zZlHwOUuegRhARR4CmHDvzZJhr967hWio=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QuSi1YAu/65Qgnk4Sc3KutxKNf22xABvtugPZEqesCz7TMyOAkgK+WgvXlFTCGMLjyklDbz33df+ele9e8aHSAMWFTyZ+ZF3AkbNYWT/6DN6hZESmTmYYLmSkr1d9L9YwPZjXoZMCvWIobxezzgJioe5KAr3aaLRna0PVWlYPnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=hZrn1uu3; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="hZrn1uu3"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x90Nr-005SYf-It; Tue, 22 Sep 2026 15:18:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=HtrBvX1qkX0OQLUKET4ASUR8w4rAoqkM82f1SUuMCg8=; b=hZrn1uu37TTMJo35HAmbHEtt9k
	EasFgRFtONX541AYYK5ybsOuN7+Bek04t46oRvZxXueW+lV/rjCWKSGVo7pgky5txcwHLjj3X80zJ
	azVpW/rI2ld+4qVnEtFvN/gUYorQVQLMDpyzALAQwA6wJzZzioKOMNfZQ5ewyiW2VW2wCl9+/qvaQ
	d1RX3FaUoC4EuteVi5HNQvXY4sHxu+k8owwztnADXQGSD9frLiWuC1liI7J4QmJ8n8P/t3/Ew5sFG
	+TGwIBLk7EZZ7KVVQHSJRwyUm3ZNLzNbP7/MZPLckAhavYqWfmwqG8DBHqFHVLAlFfncJse2C+imS
	DS+tnfEQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x90Nm-0006g5-03; Tue, 22 Sep 2026 15:18:02 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x90Nh-00FylB-Ti;
	Tue, 22 Sep 2026 15:17:58 +0200
Message-ID: <3b3bde52-1f7c-4a7a-b1a9-536e202a281a@rbox.co>
Date: Tue, 22 Sep 2026 15:17:56 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net v2 4/5] vsock: Do not reset a TCP_CLOSING socket
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Asias He <asias@redhat.com>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-4-a1d9abb472f7@rbox.co>
 <aqqFkBYebKK1nZNJ@sgarzare-redhat>
Content-Language: pl-PL, en-GB
In-Reply-To: <aqqFkBYebKK1nZNJ@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/26 14:30, Stefano Garzarella wrote:
>> @@ -1834,23 +1833,22 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>> 		timeout = schedule_timeout(timeout);
>> 		lock_sock(sk);
>>
>> -		/* Connection established. Whatever happens to socket once we
>> -		 * release it, that's not connect()'s concern. No need to go
>> +		/* Connection was established. Whatever happens to socket once
>> +		 * we release it, that's not connect()'s concern. No need to go
>> 		 * into signal and timeout handling. Call it a day.
>> 		 *
>> 		 * Note that allowing to "reset" an already established socket
>> 		 * here is racy and insecure.
>> 		 */
>> -		if (sk->sk_state == TCP_ESTABLISHED)
>> -			break;
>> +		if (sk->sk_state == TCP_ESTABLISHED ||
>> +		    sk->sk_state == TCP_CLOSING) {
>> +			err = 0;
>> +			goto out_wait;
>> +		}
>>
>> 		/* If connection was _not_ established and a signal/timeout came
>> 		 * to be, we want the socket's state reset. User space may want
>> 		 * to retry.
>> -		 *
>> -		 * sk_state != TCP_ESTABLISHED implies that socket is not on
>> -		 * vsock_connected_table. We keep the binding and the transport
>> -		 * assigned.
> 
> Should we keep "We keep the binding and the transport assigned." or 
> maybe add on the other phrase, "User space may want to retry, so we keep 
> ..."

Right, I'll extend the first paragraph.

>> 		 */
>> 		if (signal_pending(current) || timeout == 0) {
>> 			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
>> @@ -1874,8 +1872,8 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>> 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
>> 	}
>>
>> -	err = sock_error(sk);
>> -	if (err) {
> 
> Should we add a comment here explaining why we are doing this?

OK, I'll expand on this. With `if (sk->sk_state == TCP_ESTABLISHED) break`,
there's another bug here.

>> +	if (sk->sk_state != TCP_ESTABLISHED && sk->sk_state != TCP_CLOSING) {
>> +		err = sock_error(sk);
>> 		sk->sk_state = TCP_CLOSE;
>> 		sock->state = SS_UNCONNECTED;
>> 	}

We might exit the loop and get here on:
1. vsock_connect_timeout() timing out; setting sk_err, TCP_CLOSE,
   SS_UNCONNECTED
2. virtio_transport_recv_connecting() failing to establish connection;
   setting sk_err, TCP_CLOSE, and leaving SS_CONNECTING
And to be precise:
3. established connection getting torn by a transport event, locklessly
   setting sk_err, TCP_CLOSE, and leaving SS_CONNECTED
I sure hope I'm not missing something.

So the code above is taking a bit of a defensive approach, but I suppose it
could be simplified to an if()-less

  err = sock_error(sk);
  sock->state = SS_UNCONNECTED;

thanks,
Michal
