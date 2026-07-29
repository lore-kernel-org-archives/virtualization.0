Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEEA442108
	for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318397; cv=none; b=qoWgFNsmbZvtxuqMC1U9bK7U4Z+0LOhNSKogIuZfpOFCmMDqfdEeIc+F+2PDnzBZCgLZe8w1A4acURkoCrJL5Wv3hTrsgaNDaSzoZI+Gb8QZPlSo4gV66rr82p1W7bkJiCpaEyswrYBF7wzXzXSK30WQHhisdMRoOZKaIPF1aB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318397; c=relaxed/simple;
	bh=7qQPhbO7x8cevphBaoSYKA87SBMgQmKWwDQX5TBBZrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hcv5GUmMEBJ73Qckun6BveZqPSkLtnnNC2TOOY+2+vkGt6+XxnztrhME4U0BrfxTbfVQapHvipb4sZxyM98ub9uArSapACv3NxIZIlnY472f9NraG3FdRu+9fXpnhmQA62nKAnr8hA/V9K7MA49g3saR+EAnKEzDMmzZdXIa8WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=scJAtKJN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scJAtKJN"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d01663d816so7093395ad.1
        for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 02:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785318395; x=1785923195; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ZX80IHAYk8WquP9pNurg4cyEfZNZ2WQi/VneUnNeO8=;
        b=scJAtKJNhT+oBXFNhjEqcVZc9N8VojNVhtOCFdOuNGc5p7y6d5UvTA92UJ2aIBW89H
         Q2dCa3zv0ibisYA55emlhkhJMKOUkpm4XSbk5lPq54du0kPzW+GWTRapGW47nAlB/oox
         deJeC9gLEPBBb2yrpzg62pEIYddoaw2IJZBDfMNXmwxf5qrCaSaOlXk8eovadyDNjrSS
         n2dQw0t+uZxiRnZ2/o7Hq7RFwjOHWNwhHy3JBxwIdMoFFMWDAzuSNCEvecV/raQICTu/
         GYQz1YLWz6MJNr1ccvAsvax/48wtzMOl2RxQK2O3btaCehDVIrYpXRNXQcgMVyQQZ14Z
         C9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785318395; x=1785923195;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ZX80IHAYk8WquP9pNurg4cyEfZNZ2WQi/VneUnNeO8=;
        b=ZR2xDVm6+xrbdyJCAiTxo1I6vsYYH6zK1nNUOh5BHt+SRRo33yriNnacRHgL/8zp50
         cOIYZm65f3fW9YIgEYKQLCiEEggJC36WUL1coYwkF1JaDbqJHEe8NIJgNEWvrwu1XWo7
         cntmyBsrqeSPK+MoQytUPHcza2ereHwc1ZObQvEPJVU1cUTBBRuHTcNQh3P4EDS7UqLx
         xKUr/1EeYxnW7QdGs+nBYVagA9XvOiZ2cbJ9TYgTi8HYUvrIJPS9s7rcTEf0XK3yVkIz
         uGxgzgqzKz7+QWH0zMBcOg1Vm4Jm93d4+1iECV7dK1DPhazKxh4rr5BtfPNHATKjpVox
         CWoQ==
X-Forwarded-Encrypted: i=1; AHgh+RpN70OiBtU7zREfEYGbCizs584kweWUMrcaDABL2QlfBbACFhjNTlHRUhYpMO6PJeX0jZlDb1FaHQ6smAgIfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YydT/bn+K/ABFYCv3oH47y1oKY9CBFJ+zYBRAoi3t+X3BoYyEB4
	QqvgUkoNMUTZ5U5PWLo+Z2LxW6FhMoEgfEt2oxVLoCeZvEnWWAXUV5a5
X-Gm-Gg: AR+sD112PSIj+jFAIesThi1Mp3SRXCPOB9eGPEjUVbp665mgXikoN0ULpNDBrVgTgYT
	1AY1YDtiJs0GU3WOFxZpH2mwyGpaznwCoPQOaeFyz2nMLcXZJQdiqsjtnuhi8uvhWJcBWr6P4WB
	7U6V78D+6tFowTxqeWaqoeCuOBQhGE3+CJhBHiKHElzIIARyPf/vu3UxagVDxgU+jhVuFBTusoG
	wKLO9zy45L/AOXbqm7buxC8EV8kJPaF8LPTOa5ZCpo6Gsrgew69GJOrcnhgV034OnlQIjo7jOEb
	mlwNjEKsY1q3l5TgPG7h768nzQuGLUdj4b4mNcChym6fu2fRtw3wWh45e5a1BddkZfRwP663+Jg
	GUPgtHrzbZoMHcrXVYs5qP30B1ICtNkVDDleMC6WZiiQrERrSCgGZhEv68rbviy7hnRhGNn3WYs
	JPL4IR4sABGQTMRnoyfh+iDT3iMEHvjO9vEzyHOp7PJMKRuLz+dMBfShibLADXdAG3CVBzfFX1D
	E4=
X-Received: by 2002:a17:903:3d07:b0:2cc:ed57:c7c with SMTP id d9443c01a7336-2d015cbb228mr66348375ad.32.1785318395180;
        Wed, 29 Jul 2026 02:46:35 -0700 (PDT)
Received: from [10.22.76.22] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a4af04sm8816985ad.31.2026.07.29.02.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 02:46:34 -0700 (PDT)
Message-ID: <a4c89c00-ddbe-4278-b386-b83d2b859a70@gmail.com>
Date: Wed, 29 Jul 2026 17:46:29 +0800
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
Cc: Michal Luczaj <mhal@rbox.co>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260719220103.684489-1-phind.uet@gmail.com>
 <al3UuvBhfxp82krV@sgarzare-redhat>
 <78225425-1ca7-45fb-85cb-9e04f489e68f@gmail.com>
 <amB15TdzPAEk9A9C@sgarzare-redhat>
 <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
 <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>
 <amHN9mOGj7oMak4-@sgarzare-redhat>
 <27412e44-ab4b-4dd3-9685-481875683860@gmail.com>
 <a6cb1b8f-d8cf-412a-a204-3a26e4db0bd0@rbox.co>
 <6b684c2f-1f98-43ea-84c9-9b6f162d5e9f@gmail.com>
 <amhmjLa9DjNFKgmb@sgarzare-redhat>
Content-Language: en-GB
From: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
In-Reply-To: <amhmjLa9DjNFKgmb@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/7/26 16:21, Stefano Garzarella wrote:
> On Fri, Jul 24, 2026 at 03:34:23PM +0800, Nguyen Dinh Phi [SG] wrote:
>> On 24/7/26 05:43, Michal Luczaj wrote:
>>> On 7/23/26 12:26, Nguyen Dinh Phi [SG] wrote:
>>>>>>>> ...
>>>>>>>> Yeah, we need to handle that part better, I think it's a 
>>>>>>>> leftover when
>>>>>>>> we generalized AF_VSOCK to support more transport than vmci.
>>>>>>
>>>>>> Speaking of leftovers, I have trouble understanding where does 
>>>>>> vsock set
>>>>>> sk_err on listener sockets anyway. If it doesn't, why vsock_accept()
>>>>>> checks for it?
>>>>>
>>>>> I can't also see where it can be set TBH. Should we remove it ?
>>>>
>>>> I couldn't find it for listener side too.
>>>
>>> Removing sk_err handling from vsock_accept() solves the problem, right?
>>>
>>> thanks,
>>> Michal
>>
>> Yes, confirmed, removing sk_err checks from vsock_accept() does solve 
>> the problem.
> 
> Okay, so maybe better on going on this direction. WDYT?
> 
> Stefano
> 

I'm still a bit concerned about how connect() and poll() interact here, 
even with the sk_err checks removed from vsock_accept().

For example:
vsock_accept() now lets us reuse a socket whose connect() failed (call 
it r0) as syzbot reproducer does. After listen(), r0 becomes a listener 
(sk_state == TCP_LISTEN) and works correctly -- it accepts connections.

But poll() on r0 still marks POLLERR, even though there is no error on 
that socket at that point.

As I understand it, sk_err holds an error that has not yet been reported 
to userspace. In the blocking vsock_connect() case we have already read 
that error and returned it to the caller, so it is no longer pending
Shouldn't sk_err be consumed/cleared when vsock_connect() returns it to 
userspace?

If you think the POLLERR above is acceptable, I'm fine going with just 
the vsock_accept() change.

Thanks,
Phi.
