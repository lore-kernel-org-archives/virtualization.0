Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB8D484240;
	Wed, 29 Jul 2026 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331259; cv=none; b=Qt7bKARFQKqFMpf0bqNnZyWr70GtbbkkGIgItqZ6u+2hOcrSGV9Ga0z/tWmf46+CIFx0FlMkk6GhBaBsaebtIOXbsau9cC0DBAj7wkgEPep15YH6c1+Y1vWJOCNzhYmyCoAZ1dauj+QOaGDSlxxYXOJjLR4KQgLXMEhY1Bch/4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331259; c=relaxed/simple;
	bh=akxrUrDhYOOFfKBK9i6/7B24Hv/iYbTsiZysYFeWN0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKVVaialm4SHaGCPVMfipIrVGOTNpc7swd4jKVhOLE/8vBRxS59v3CEOIlfiAyxeFAtOSoH2x1LkrEMxhWsFfcafZ4N5tERboTupDSdoGrDjAhBuDIb46Pu3LSyNJEWUkKmUpxnv3pcqIpaZRuyhGqwDHrzmghx+YDAGfQiL9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=VlD9AJwD; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="VlD9AJwD"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wp4DE-005iDA-Er; Wed, 29 Jul 2026 15:20:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=l2AhfwZpq4/nyCVpWilyCoRgTY/Jqy9BkNX9w+bR0kk=; b=VlD9AJwDPLGoWu0lZaoh+A15mu
	AMBNnsSfiIWbDYh1wV5NCAXwwmkCnE8/fOhS3pX4mWmRODWMTHrTTt7lY+hz8HfcEITQfvEdi1PCL
	ePi45kvHHhJtQaEzviaQZMt5ZJdgMU9MmkMsPAUwjLj/RrvqzxOXqwuuU9sCQ+7qNhNISxMV9t7K3
	X4qRlxFPMsHK0RBT1SJ2c5vmLBCLm+U7MofpuPbJghBOh85hyrMVTBlwLR8qkVa1MO2YhkOf+XhhT
	D+qq52c38hJ9rxUMYE6uht50DAd5/7slW03YOasCIDM+wX4hTG8AuUCQRlUHt1QLbOiBIHAaZczAO
	tuLuA3ZQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wp4DD-0005dM-Ns; Wed, 29 Jul 2026 15:20:43 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wp4D9-004Cj9-Gz;
	Wed, 29 Jul 2026 15:20:39 +0200
Message-ID: <e7ff506a-850d-4d7c-8346-c6fef9ad8553@rbox.co>
Date: Wed, 29 Jul 2026 15:20:38 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
To: Stefano Garzarella <sgarzare@redhat.com>,
 "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <78225425-1ca7-45fb-85cb-9e04f489e68f@gmail.com>
 <amB15TdzPAEk9A9C@sgarzare-redhat>
 <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
 <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>
 <amHN9mOGj7oMak4-@sgarzare-redhat>
 <27412e44-ab4b-4dd3-9685-481875683860@gmail.com>
 <a6cb1b8f-d8cf-412a-a204-3a26e4db0bd0@rbox.co>
 <6b684c2f-1f98-43ea-84c9-9b6f162d5e9f@gmail.com>
 <amhmjLa9DjNFKgmb@sgarzare-redhat>
 <a4c89c00-ddbe-4278-b386-b83d2b859a70@gmail.com>
 <amn5vWcyY0f5ErEM@sgarzare-redhat>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <amn5vWcyY0f5ErEM@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 15:03, Stefano Garzarella wrote:
> On Wed, Jul 29, 2026 at 05:46:29PM +0800, Nguyen Dinh Phi [SG] wrote:
>> On 28/7/26 16:21, Stefano Garzarella wrote:
>>> On Fri, Jul 24, 2026 at 03:34:23PM +0800, Nguyen Dinh Phi [SG] wrote:
>>>> On 24/7/26 05:43, Michal Luczaj wrote:
>>>>> On 7/23/26 12:26, Nguyen Dinh Phi [SG] wrote:
>>>>>>>>>> ...
>>>>>>>>>> Yeah, we need to handle that part better, I think it's 
>>>>>>>>>> a leftover when
>>>>>>>>>> we generalized AF_VSOCK to support more transport than vmci.
>>>>>>>>
>>>>>>>> Speaking of leftovers, I have trouble understanding where 
>>>>>>>> does vsock set
>>>>>>>> sk_err on listener sockets anyway. If it doesn't, why vsock_accept()
>>>>>>>> checks for it?
>>>>>>>
>>>>>>> I can't also see where it can be set TBH. Should we remove it ?
>>>>>>
>>>>>> I couldn't find it for listener side too.
>>>>>
>>>>> Removing sk_err handling from vsock_accept() solves the problem, right?
>>>>>
>>>>> thanks,
>>>>> Michal
>>>>
>>>> Yes, confirmed, removing sk_err checks from vsock_accept() does 
>>>> solve the problem.
>>>
>>> Okay, so maybe better on going on this direction. WDYT?
>>>
>>> Stefano
>>>
>>
>> I'm still a bit concerned about how connect() and poll() interact 
>> here, even with the sk_err checks removed from vsock_accept().
>>
>> For example:
>> vsock_accept() now lets us reuse a socket whose connect() failed (call 
>> it r0) as syzbot reproducer does. After listen(), r0 becomes a 
>> listener (sk_state == TCP_LISTEN) and works correctly -- it accepts 
>> connections.
>>
>> But poll() on r0 still marks POLLERR, even though there is no error on 
>> that socket at that point.
>>
>> As I understand it, sk_err holds an error that has not yet been 
>> reported to userspace. In the blocking vsock_connect() case we have 
>> already read that error and returned it to the caller, so it is no 
>> longer pending
>> Shouldn't sk_err be consumed/cleared when vsock_connect() returns it 
>> to userspace?
> 
> Yeah, makes sense to me, I'll ack the v2.
> @Michal WDYT?

I'm worried this patch does not address the non-blocking connect() case.
Could vsock_connect_timeout() set `sk->sk_err = ETIMEDOUT` after connect()
returns?

> As cleanup (separate patch), should we remove the `sk_err` check in 
> vsock_accept() ?

