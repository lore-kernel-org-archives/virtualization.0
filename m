Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA51E3DDDC4;
	Sun, 16 Aug 2026 22:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786919416; cv=none; b=g+RI9muKDqGao1aptFz1WNWKwuphIZbhwNaxLV9u8zaAm5L26iD94b0hOlrUoL9qZSwt6J7CWDcJDbHvaUaQOE3sXF6Irnkn/gHMKxcYJdigjYC++pPjktJeKmppoxHFT+lbQivufDYqpWzxcj33jAgOGEWc5iJoecLH3sCKlzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786919416; c=relaxed/simple;
	bh=zIhT7jf41Gb2jOkl6bG9wa8zUTjMgebSiT5x72tTtNI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HrlbUwqyRwT3YnUWbRhxJtA1Wgm0YYmY55aEsL7mDZ1utkkEIIZUT5jq6MKSIPoz8wpoKbvnLRs2u66/l0tGHagdzy3s7i9teID8SlqaC5s+DpoBdJLixUP5MOffDZgar97Tmc0HMnESvTCc1c0YnFvIrcHcZKQkCWfR2JAaZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=fmEjm67f; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="fmEjm67f"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wvjML-00DUrV-5X; Mon, 17 Aug 2026 00:29:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=RlY0ATfcV/Bq10bobASFAcIaySoEPBqjFaIHmJLDUQc=; b=fmEjm67fPvmegbJn+hmqFrt8pa
	rRjkpRrErn7pkDs8DiUiXkEc99FkkioHTh2Sqg2lG+eDOJLEZx4IxDv+ZMILWLSn4cD2X/RhfMxB4
	U4M5440MaKO9ZfbIhKE6wbrZcT5dVe6s8DEBG2Ug6Nr7mlLfm5VV7Ndi6v6E85KWEqjs9f+pl6IFt
	lmPzO7bK5t0oHnWf5IWiCEAA3D10+IRK3LDxWwEQrKSCrpiOH+R3vjCiVdglVNqxv9nSMpqXLspzJ
	itp19CgQcIWQW2OUS+y1/NKSTjNlHzKIqMkIQK3tIXy0PBiOnmdLJLMnlgnoc3FVzd+bZQTX4K5l/
	GBL5aUCg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wvjM8-00077y-Kx; Mon, 17 Aug 2026 00:29:28 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wvjM6-009Fh4-8h;
	Mon, 17 Aug 2026 00:29:26 +0200
Message-ID: <c11d6fe8-fdf9-4b45-b291-e5d5b0ef5cb4@rbox.co>
Date: Mon, 17 Aug 2026 00:29:11 +0200
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
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, leonardi@redhat.com,
 bobbyeshleman@meta.com, stefanha@redhat.com, mst@redhat.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org
References: <anzT1fREOSyHT99k@v4bel>
 <218226a4-38e6-4a16-a660-6c1bb92f9f96@rbox.co> <an5zJ9Uf94_L9TyB@v4bel>
Content-Language: pl-PL, en-GB
In-Reply-To: <an5zJ9Uf94_L9TyB@v4bel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/26 03:45, Hyunwoo Kim wrote:
> On Thu, Aug 13, 2026 at 11:42:17AM +0200, Michal Luczaj wrote:
>> On 8/12/26 22:13, Hyunwoo Kim wrote:
>>> commit 002541ef650b ("vsock: Ignore signal/timeout on connect() if
>>> already established") stopped connect() from resetting an established
>>> socket. The check only looks at whether sk_state is TCP_ESTABLISHED at
>>> that moment, and the state can change while connect() sleeps.
>>
>> I guess this makes my fix incomplete. "Fixes: 002541ef650b"?
> 
> It is incomplete, yes. But this has been triggerable since d021c344051a, so
> I'd keep Fixes: d021c344051a.

OK, I get it.

>>> A peer RST moves the socket to TCP_CLOSING, and it is not removed from
>>> vsock_connected_table on that path. connect() then wakes up, fails the
>>> check, and resets a socket that had actually connected to TCP_CLOSE and
>>> SS_UNCONNECTED.
>>
>> Thanks for the details. Do I get it right: connect() misses the fact that
>> socket might have already transitioned TCP_ESTABLISHED -> TCP_CLOSING
>> during schedule_timeout()?
> 
> Yes, that's it.
> 
>>
>> How about:
>>
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index 622dbd046799..39c42ef016c3 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -1807,15 +1807,18 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>>  		timeout = schedule_timeout(timeout);
>>  		lock_sock(sk);
>>  
>> -		/* Connection established. Whatever happens to socket once we
>> +		/* Connection (has been) established. Whatever happens to socket once we
>>  		 * release it, that's not connect()'s concern. No need to go
>>  		 * into signal and timeout handling. Call it a day.
>>  		 *
>>  		 * Note that allowing to "reset" an already established socket
>>  		 * here is racy and insecure.
>>  		 */
>> -		if (sk->sk_state == TCP_ESTABLISHED)
>> -			break;
>> +		if (sk->sk_state == TCP_ESTABLISHED ||
>> +		    sk->sk_state == TCP_CLOSING) {
>> +			err = -sk->sk_err;
>> +			goto out_wait;
>> +		}
>>  
>>  		/* If connection was _not_ established and a signal/timeout came
>>  		 * to be, we want the socket's state reset. User space may want
>>
>> ?
> 
> Yes, I like it better than mine. I confirmed it fixes the issue.

Great, thanks.

> If you don't mind, would you take the patch from here?

Sure, no problem.

Stefano, does this look good to you? And should any sk_err be consumed
here, too? (`err = sock_error(sk)` instead of `err = -sk->sk_err`)

thanks,
Michal

