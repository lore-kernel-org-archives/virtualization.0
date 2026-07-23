Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798FC43B4A7
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802412; cv=none; b=s9i+GEsoZOToAD1MK3ueqK5EYMqi8FGp4pn2VzH8/H9jy1kNY0BW4UCygmpQVxZIiyRPEEyjJdw+l5nSCLVd3bElFTd29ODUOnTyWYNyZWbfKQgDgu0qUO1EX0cxVOotESHgrF+v+deKRJVgcmbq4OiOi2tgngtWwYcDvT7+L0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802412; c=relaxed/simple;
	bh=gR+hILfs9JaVILip6p2fY59TZJegMJ+6aegMjs81qKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhEIEyqwc6ZttX+YwCAbl5MHfMyumm5qtg5l1ee7IImrzWPzqmxCXNefIcH/lVmEDJMG//dvLCV5k4wHAEi5QFluPh9M1FcVU9kZodKOSWMfcU6EqQn5QdhttPpm81/oirzPqxMhUQcQdG7mrYYbrYAGteKso5AG4j2S49w4E/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIU4nmeI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIU4nmeI"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cace91f112so5703495ad.0
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 03:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784802410; x=1785407210; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=01n37iktC7STPimw6Zf4vYgQpw8EUgozHpcb0fjUKyc=;
        b=YIU4nmeIXC2R9pPvlB1B+s/XEMP6IUYUbDzezhKljmHd1oKYve8Hre7mfHomyo6iV8
         sEDW8nIT7NscO1GcALHKB+CL9tOqwpmguwT5ka3XVxKerwQhhlP2Qg0igJulvXKh0vf5
         QPYosbIle6sBQjlHWK3jausJSxsYJ5ECZ2WjMRTjT4Ca8d1LWv6ttCqa5d2s3wjrFSO3
         iuL707SZpPPOI55cSFNeD/HYUZJRADMUqza3fm0ipSyyNa1XpBcz8+4Jf8XG2I7jmEhw
         JqZKhhm9Sk7ZSPhPS71qQ75JN+dTpxO2JuTAXyTTRo1ZtWSiKrESTrYixjQSZXPRZHY1
         FrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784802410; x=1785407210;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=01n37iktC7STPimw6Zf4vYgQpw8EUgozHpcb0fjUKyc=;
        b=J2Nt/B8q7jFeeAGAcH6/+8aAY/QmQTUbE++ByrNpAvt9oCsFRiBurlggxVnHmNHBmk
         9xJManlya7YptSZj8w1ob9/T/gY0xUGWzrt6nXIPY2LzASoH/HwYW1MzT75Xz3BlwKmj
         DdlIbEDi/uvtTTn04SXjp2hSK4j7R+ZROQAa8961tv9wcLqO8fbI3iIq8PQfHrocoXsy
         S4H6BN/8x0I4/Digtvxwg2fzSDRCnrim+uWIOcxiJ5AqgMaNpBB5X6Nyn3Jm1OnynBn0
         L5eulvYEFH9cq/6CT068o7dQXq+qZonk1o68VMKBPiDpzlouxNA5/oedkrM0GYVKnM8T
         CqwQ==
X-Forwarded-Encrypted: i=1; AHgh+RrI/jcuIBTBZMAFMW9D457U43hEpryESM6S8uU2pSnyDnltTmIGaRr25M6KJTnjBBKLzdDI0kf7IW7lwc6t6w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/qDEUg+r5eqL2aRkia6ye8FmHo9oH4nB3ZDLeV58x6IJZpd/5
	u22UgSJ7r1MXA0995qLhhazAopy9nRoXnWDWKC640w8uKT3Q+2ZYG+cn
X-Gm-Gg: AR+sD136Kt7pPtiCsaTohEcxGo6i/XK9+q9hWDkjMmYpPkRfYLzAWBmPgfvWLT9xP8L
	zdI2NV4y0+dyed0ZatwsbvZKq3WgAT8TrvasV8IFjGHZA8KWJNN85bRPs6zqQsr1LS/sZ6d5pqq
	1JIwRjqGnHwj0uCWOkeE9qQawR1528eAbbecUj+he13CtAzQlz0jVo03d42TawCf1qA3STPrm8V
	li/RpSWdijdZsv+PFzCL/Cg/RXBwbwk4EYmjtZR+ROFHnWNpxBWXee+LBwTSPRhVZeRyxqcOw2E
	/ecSFWMibS4u7UE6fLZwMbUCxrRb7jyY6Vwhf+2B6hmx2kMyZ2pa43IDaEIcgDGuhED5+5PfXeK
	FnDXXlTumrCr2XIj3tKJPvPuroXPtW1pGsTGc9tQTEtBjRsBG2SbJn15ASZDkTO3aArNSJCs7Az
	y0vg+FDy5EGQE+vV+D
X-Received: by 2002:a17:902:f68b:b0:2cf:32bc:971e with SMTP id d9443c01a7336-2cfa6c66618mr27394975ad.29.1784802409495;
        Thu, 23 Jul 2026 03:26:49 -0700 (PDT)
Received: from [10.22.76.22] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e5effsm31822045ad.47.2026.07.23.03.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 03:26:48 -0700 (PDT)
Message-ID: <27412e44-ab4b-4dd3-9685-481875683860@gmail.com>
Date: Thu, 23 Jul 2026 18:26:44 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
Content-Language: en-GB
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>
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
 <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
 <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>
 <amHN9mOGj7oMak4-@sgarzare-redhat>
From: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
In-Reply-To: <amHN9mOGj7oMak4-@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/7/26 16:24, Stefano Garzarella wrote:
> On Thu, Jul 23, 2026 at 08:00:31AM +0200, Michal Luczaj wrote:
>> On 7/23/26 06:14, Nguyen Dinh Phi [SG] wrote:
>>> On 22/7/26 15:55, Stefano Garzarella wrote:
>>>> On Tue, Jul 21, 2026 at 01:34:03AM +0800, Phi Nguyen wrote:
>>>>> On 7/20/2026 4:17 PM, Stefano Garzarella wrote:
>>>>>> On Mon, Jul 20, 2026 at 05:57:47AM +0800, Nguyen Dinh Phi wrote:
>>>>>>> After vsock_connect() exits the wait loop due to sk->sk_err being
>>>>>>> set, the error was read but not cleared. This left sk->sk_err set
>>>>>>> for subsequent operations.
>>>>>>
>>>>>> So, is this a fix? If yes, we should put a Fixes tag.
>>>>>>
>>>>>> Also, can you describe how to trigger the issue?
>>>>>>
>>>>>> Because I see this in vsock_connect(), so I thought it was in some
>>>>>> way already handled:
>>>>>>
>>>>>>         /* sk_err might have been set as a result of an earlier
>>>>>>          * (failed) connect attempt.
>>>>>>          */
>>>>>>         sk->sk_err = 0;
>>>>>>
>>>>> This only handles the case where the function following the failed
>>>>> connect is another connect() call.
>>>>
>>>> So, can we remove that with this patch, or better to leave as defensive
>>>> action?
>>>>
>>>
>>> I prefer to keep it here as defensive action
>>
>> Is changing how vsock_poll() behaves intended?
> 

I think connect() already delivered the error directly to the
caller when it returned -- there's no reason for poll() to keep
reporting that same, already-handled error afterward.

> Good point, but IIUC __inet_stream_connect() is also using consuming the 
> error with sock_error().
> 
>>
>> I.e. if sk_err should be kept after a failed connect(), what about
>> `sk->sk_err = 0;` in vsock_listen() instead?
> 
> Yeah, maybe this is a bit less invasive.
> 

yes, __inet_stream_connect() does it, and actually, other protocols like 
Bluetooth, TIPC, x25... are also consume sk_err with sock_error() after 
their wait loop.

I think it is an established pattern, so I'd rather keep sock_error() in 
vsock_connect() than move it to vsock_listen(). vsock_listen() would 
only protect the listen() path; I see other places in af_vsock.c use 
this sk_err.

>>
>>>> ...
>>>> Yeah, we need to handle that part better, I think it's a leftover when
>>>> we generalized AF_VSOCK to support more transport than vmci.
>>
>> Speaking of leftovers, I have trouble understanding where does vsock set
>> sk_err on listener sockets anyway. If it doesn't, why vsock_accept() 
>> checks
>> for it?
> 
> I can't also see where it can be set TBH. Should we remove it ?

I couldn't find it for listener side too.

Thanks,
Phi.

