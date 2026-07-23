Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84C737757A
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 04:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784780100; cv=none; b=aqT1UzyTaJ8gwwJlk+7SfExXR8BvjjerLF/7pOmvQXZ+PUPx19de3fFXmEV2xQkH5xBfPPSNsXlBtmhZmwdaor/lWPjecSzt3nqPFZ+JeqsJ0o4anXTWmKS7Uy/czW43xjCL2vI9/kfP0b7D6C2e9KJ6cgAXZbfFNFRNqpR0iyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784780100; c=relaxed/simple;
	bh=eLbfW63CJW0U5KMBsAlteJLD1uU59Z2xXAVfZF5vnbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdBQUr6YvBPSIYsnMg7vahpzL/KMPUEgLz5xrDkTUzT1xa7UyLky+2X5GRz9PPYBLTuKrxnzrxZhBMN0Jj0KU0vW4d/Ym9d8m8Hg22XUUx0s6XpLQCV9e9g7QI174GKKhv8X+pyB+5jLCWuHrAaootBO86jQims6Z43JekTcGMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xtd9vuTg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xtd9vuTg"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caea3f742bso2726825ad.0
        for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 21:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784780071; x=1785384871; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aZBWgpdwomFlA7goEYUZgNUpcpQ2jgXmDN9Ar8IJzpw=;
        b=Xtd9vuTgnxMvTLp54zqozrbm8qIJHtYwGNs3rAdIxGM33AQcdOGCVOxkCVsiqTUjH0
         S5exveNTzmUiUP8nZYE19gbwQq5eNUSd5MsF4QrQvjqtk8K7g4rlsk96PiEsnoslu5J7
         i0KoJkM6iHq6T/yB02lZolS7ouMV+hd3O7jTDKEalLxRNkpdN5pRA58Uv6sTGuomdsOT
         +Cvr5YcvR3b+3zCll341IihhvFK+ex5jdZ2evBz8etUa6rksdbNB2x7JvqZAUL78fXCc
         tHl/p9lpRyC5SixCyJsMkIvxrS3i05zv8iw/O6nYshP3Tr4pzJuCCDFlhHX9GVmSP0zv
         x1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784780071; x=1785384871;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aZBWgpdwomFlA7goEYUZgNUpcpQ2jgXmDN9Ar8IJzpw=;
        b=jcYyLOJ4nBUwtiOTqbFgaIBwhjo4ucoHDCUvZ3z1e2Tzj9rmpZA72NoO1hGw2e4f1h
         qK1Hji2jNI3FBXLYLVeorYHTv36qESQ9dn4egYFv7U24GLQu5esTDqCtT+zaHBE5lhfG
         G2GTM8vpb4VMik9ZW2jHfuqotLxRIL1LtrX4EHRcKRMbuM9c/TM7rfjjzsDHJ3LsXp8p
         qlSX6/lBPzbQoGtkckN+GCUazij+lI81D6Glgs+SJaLMNUmPwBTtnA8x6ATkKEHY9jsY
         wnIDE+JJJsMtiIOKX/Ciq7sPquUogviEMBtcYZK2gWgKHlo9ALiiadgYgB3mBwPxjujz
         3NtA==
X-Forwarded-Encrypted: i=1; AHgh+RoRieZT3XN6VvgzmheHL5NQC7bqLzLYmpRIPqU3MJt5L7XdN8s8iVAFJCjd01OS+ZzjDKtZFsaJZWacr7IlNg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywu1kI3euVNB7/qjHZLHMRjW7kkRYXBXPjh4aClf5URx6O42oRA
	TM5+RAK1sIfAsJRiG5yywARL4YuiQ+QRQ0O2fblRUyMOEoUhHXai15Fc
X-Gm-Gg: AR+sD10uMpr1mbEwKhzmAeRnmTpZdNVLINc/UKxKulsEYkxpCe1+IvOYnB8GiCZ1x3r
	QimpqmgLzWgvHk2Z127Yh5Kn6OXzakPpQVvq0qk396YAwGj+Qdl0LLS+mgnTUpoG40/zNHK6IsK
	sLBhwFQKR5h+CGd6zmRlLDz/5v72I3ShZpWCEnRh0OJlwdtardASRBNaYx9h+9gZ+2Sj+/6mz1V
	CF9OySVoYhGREA1CG9xmmSSyrlldIK1l9v1vFgbz7wAht3FSEAiabZpLy7j9rAKvqg/RB2o9nxQ
	JDRVaeHvZbi/gNlNmo3JqUOUMW5A5Xsv5Ipct7kqHjfWRd+XmjU2/UaQmZcNu7DzKst2D/9FXbu
	CEwUPR7mrmu3OKurT5KpfPMGWNGQpkebmn7IQubniMmZdOr6/ucf7VqYV6VnwldwkaaA4ATZTJ6
	voZ4huDhzRuJpOJuwaNDf4
X-Received: by 2002:a17:902:e80e:b0:2cc:f5b8:4c2e with SMTP id d9443c01a7336-2cfa6b7d0e4mr19002335ad.9.1784780071120;
        Wed, 22 Jul 2026 21:14:31 -0700 (PDT)
Received: from [10.22.76.22] ([118.201.124.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e5e9bsm24915255ad.50.2026.07.22.21.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 21:14:30 -0700 (PDT)
Message-ID: <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
Date: Thu, 23 Jul 2026 12:14:26 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260719220103.684489-1-phind.uet@gmail.com>
 <al3UuvBhfxp82krV@sgarzare-redhat>
 <78225425-1ca7-45fb-85cb-9e04f489e68f@gmail.com>
 <amB15TdzPAEk9A9C@sgarzare-redhat>
Content-Language: en-GB
From: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
In-Reply-To: <amB15TdzPAEk9A9C@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/7/26 15:55, Stefano Garzarella wrote:
> On Tue, Jul 21, 2026 at 01:34:03AM +0800, Phi Nguyen wrote:
>> On 7/20/2026 4:17 PM, Stefano Garzarella wrote:
>>> On Mon, Jul 20, 2026 at 05:57:47AM +0800, Nguyen Dinh Phi wrote:
>>>> After vsock_connect() exits the wait loop due to sk->sk_err being
>>>> set, the error was read but not cleared. This left sk->sk_err set
>>>> for subsequent operations.
>>>
>>> So, is this a fix? If yes, we should put a Fixes tag.
>>>
>>> Also, can you describe how to trigger the issue?
>>>
>>> Because I see this in vsock_connect(), so I thought it was in some 
>>> way already handled:
>>>
>>>         /* sk_err might have been set as a result of an earlier
>>>          * (failed) connect attempt.
>>>          */
>>>         sk->sk_err = 0;
>>>
>> This only handles the case where the function following the failed 
>> connect is another connect() call.
> 
> So, can we remove that with this patch, or better to leave as defensive
> action?
> 

I prefer to keep it here as defensive action

>>
>>>> Switch to sock_error() which atomically reads and clears sk->sk_err,
>>>> so the error is consumed when returned.
>>>>
>>>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>>>> Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>>>
>>> Can you explain how this patch fixes that issue?
>>> (this should be the first information to be put in the commit message 
>>> IMHO)
>>>
>>> I'd like to understand better if this is a fix of real bug or just an 
>>> improvement to the code (which is fine by me).
>>>
>>> Thanks,
>>> Stefano
>>>
>> Here are the steps of the syzkaller reproducer:
>>
>>  r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>
>>  bind(r0, {VMADDR_CID_ANY, PORT})
>>
>>  connect(r0, {VMADDR_CID_LOCAL, PORT})
>>
>>  listen(r0, backlog)
>>
>>  r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>
>>  connect(r1, {VMADDR_CID_LOCAL, PORT})
>>
>>  connect(r0 -> self) -> -1, EPROTO
>>
>>  listen(r0)          -> 0
>>
>>  connect(r1 -> r0)   -> 0
>>
>>  accept(r0)          -> -1, EPROTO
>>
>> Basically, it creates a socket (r0) and triggers a self-connect after 
>> binding it. This self-connect fails with EPROTO because it loops back 
>> to r0 while the socket is still in the TCP_SYN_SENT state, causing it 
>> to be incorrectly dispatched to the connecting-client path. The 
>> unexpected packet type encountered there sets sk_err to EPROTO.
>>
>> After that, it invokes a listen() call on the same socket. This 
>> listen() call succeeds because the kernel's listening path never 
>> inspects or clears sk_err. Then, a new socket (r1) is created as a 
>> normal client and connects to r0. However, vsock_accept() rejects this 
>> incoming connection because the listener's sk_err still holds the 
>> EPROTO error from the earlier failed self-connect.
>>
>> This rejection causes the child socket created for r1's connection to 
>> never be freed on virtio or hyperv transports; only the VMCI transport 
>> implements pending_work to revisit and clean up a rejected socket
>> This patch will prevent the rejection branch to occur in this scenario.
> 
> Okay, get it now, thanks! Please include a summary of this in the commit 
> description.
> 
> I understand that this resolves syzbot's specific test case, but it 
> would be best to handle rejected sockets more effectively in af_vsock.c 
> rather than in the transport layers (if possible). In any case, this can 
> be done in another patch.
> 
>>
>> I think we might schedule the cleanup worker to run in the rejection 
>> path for these transports as well.
> 
> Yeah, we need to handle that part better, I think it's a leftover when 
> we generalized AF_VSOCK to support more transport than vmci.
> 
> Indeed this part is a bit confusing:
> 
>          /* If the listener socket has received an error, then we should
>           * reject this socket and return.  Note that we simply mark the
>           * socket rejected, drop our reference, and let the cleanup
>           * function handle the cleanup; the fact that we found it in
>           * the listener's accept queue guarantees that the cleanup
>           * function hasn't run yet.
>           */
>          if (err) {
>              vconnected->rejected = true;
>          } else {
> 
> 
> Would be nice to handle everything in af_vsock.c in some way.
> 
> In conclusion, the patch LGTM, but please expand the commit description, 
> add the Fixes tag, and target the net tree in the v2.

I'll send a v2 with an expanded commit description and the Fixes tag.

Regarding the rejected socket cleanup, I agree it would be cleaner to
handle it entirely in af_vsock.c. I'll look at that as a follow-up.

Thanks,
Phi

