Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2DB38AC7B;
	Wed, 29 Jul 2026 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340232; cv=none; b=ZxcTCzQhPqPovQ2hPJSG9I4RT5accIcm3XzRHB2uzbgSF+s6jqpSOELv6l15jnhYIQgtP8ZGPlrET6MTE2DRuzujELmhgTAO0yem2QRzZG4/2Y9J/JuemwQ5MoR9YfD1J7NGFraSEGRWxYMw/EYM4VOpJPNsIg54qsb5wCbglaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340232; c=relaxed/simple;
	bh=pwWkIUS9sK37NnKiXpE1htndIOMB81AUrFGe5/y+kLE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Swqu5mOBbUZ/SJ9qHeq1R69A5SY1vnZoAY1uapiSArYohCgJY1/0Nw+ZFdd8VH/Z7CtTix7BUCBcct4vspex4sHitOS1IfVjp7pT4qJC7QgivpO0mSkL/sVNiIFx3+J2NpVcdWMyxfoKP6eGXHpqOHbajK7+hMf+iklZzz/TaEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=e+CL960T; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="e+CL960T"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wp6Xt-007kQ6-It; Wed, 29 Jul 2026 17:50:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=WoKkcEm2o8tc6OKBW/w1WiRDrfEtv48TvFBcds5hUV0=; b=e+CL960TfwnuGQY1qpF9Bz+Qq6
	5QpAX505WcCsAy0X4HJiBo9ZnhgRTIbojfnr/zTvMyptIlaoeoF2Em+nxSsHrD6Pdmj0yTRHgQqxl
	cTAD1TO2gvmFV2b/gZzCrjsIprv3HnjfRjKH98dkPWoA548rrsVBqq+gRd6N2LUV4Sc6+V4xxCWfR
	ZM91TkY35qF1jjxJfkeRFsKCU3bNaF5cMwTe8Kvdhh+dk6/TFo+1MCEQClh5h+ZtrHHASrZA0s5XA
	zJ5x7MnjkbLKewxTEU761e6qiQAjAOmB84M3PGMwHFrC/A4IxnRdvJjFIMyeVf3+E6w912b3RxYQt
	cdc8Jxng==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wp6Xn-0003iG-Mq; Wed, 29 Jul 2026 17:50:07 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wp6Xc-004Cwc-Jn;
	Wed, 29 Jul 2026 17:49:56 +0200
Message-ID: <bf3a61f0-cd82-4796-a3ce-d6de8c8dd7ae@rbox.co>
Date: Wed, 29 Jul 2026 17:49:54 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
 <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>
 <amHN9mOGj7oMak4-@sgarzare-redhat>
 <27412e44-ab4b-4dd3-9685-481875683860@gmail.com>
 <a6cb1b8f-d8cf-412a-a204-3a26e4db0bd0@rbox.co>
 <6b684c2f-1f98-43ea-84c9-9b6f162d5e9f@gmail.com>
 <amhmjLa9DjNFKgmb@sgarzare-redhat>
 <a4c89c00-ddbe-4278-b386-b83d2b859a70@gmail.com>
 <amn5vWcyY0f5ErEM@sgarzare-redhat>
 <e7ff506a-850d-4d7c-8346-c6fef9ad8553@rbox.co>
 <amoACichDryCaVsG@sgarzare-redhat>
Content-Language: pl-PL, en-GB
In-Reply-To: <amoACichDryCaVsG@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 15:29, Stefano Garzarella wrote:
> On Wed, Jul 29, 2026 at 03:20:38PM +0200, Michal Luczaj wrote:
>> On 7/29/26 15:03, Stefano Garzarella wrote:
>>> On Wed, Jul 29, 2026 at 05:46:29PM +0800, Nguyen Dinh Phi [SG] wrote:
>>>> On 28/7/26 16:21, Stefano Garzarella wrote:
>>>>> On Fri, Jul 24, 2026 at 03:34:23PM +0800, Nguyen Dinh Phi [SG] wrote:
>>>>>> On 24/7/26 05:43, Michal Luczaj wrote:
>>>>>>> On 7/23/26 12:26, Nguyen Dinh Phi [SG] wrote:
>>>>>>>>>>>> ...
>>>>>>>>>>>> Yeah, we need to handle that part better, I think it's
>>>>>>>>>>>> a leftover when
>>>>>>>>>>>> we generalized AF_VSOCK to support more transport than vmci.
>>>>>>>>>>
>>>>>>>>>> Speaking of leftovers, I have trouble understanding where
>>>>>>>>>> does vsock set
>>>>>>>>>> sk_err on listener sockets anyway. If it doesn't, why vsock_accept()
>>>>>>>>>> checks for it?
>>>>>>>>>
>>>>>>>>> I can't also see where it can be set TBH. Should we remove it ?
>>>>>>>>
>>>>>>>> I couldn't find it for listener side too.
>>>>>>>
>>>>>>> Removing sk_err handling from vsock_accept() solves the problem, right?
>>>>>>>
>>>>>>> thanks,
>>>>>>> Michal
>>>>>>
>>>>>> Yes, confirmed, removing sk_err checks from vsock_accept() does
>>>>>> solve the problem.
>>>>>
>>>>> Okay, so maybe better on going on this direction. WDYT?
>>>>>
>>>>> Stefano
>>>>>
>>>>
>>>> I'm still a bit concerned about how connect() and poll() interact
>>>> here, even with the sk_err checks removed from vsock_accept().
>>>>
>>>> For example:
>>>> vsock_accept() now lets us reuse a socket whose connect() failed (call
>>>> it r0) as syzbot reproducer does. After listen(), r0 becomes a
>>>> listener (sk_state == TCP_LISTEN) and works correctly -- it accepts
>>>> connections.
>>>>
>>>> But poll() on r0 still marks POLLERR, even though there is no error on
>>>> that socket at that point.
>>>>
>>>> As I understand it, sk_err holds an error that has not yet been
>>>> reported to userspace. In the blocking vsock_connect() case we have
>>>> already read that error and returned it to the caller, so it is no
>>>> longer pending
>>>> Shouldn't sk_err be consumed/cleared when vsock_connect() returns it
>>>> to userspace?
>>>
>>> Yeah, makes sense to me, I'll ack the v2.
>>> @Michal WDYT?
>>
>> I'm worried this patch does not address the non-blocking connect() case.
>> Could vsock_connect_timeout() set `sk->sk_err = ETIMEDOUT` after connect()
>> returns?
> 
> This is a good point!
> 
> So we still need to remove `sk_err` check in vsock_accept(), or set 
> `sk->sk_err = 0` in vsock_listen() to have a complete fix, right?

Yup, that's my understanding as well.

That said, I'm not against flushing sk_err on a failed blocking connect()
(this patch) as a follow up, if you guys agree that makes vsock behave like
other socket families.
