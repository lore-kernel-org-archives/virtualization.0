Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EFB2046A4
	for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 07:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268558; cv=none; b=nOwC23PpGeU3Mj7m+aksHXe47vGekJjLofJBecGADsmoRB60rlUOjWFCouVI37JGNh1HVRsfbhWNQ67XLiViFs52R+HbhCgyAImEDDrSDEl8hdq8XBcHEJ4WGDYepsLL+gX/gtLo+bbmeoKftVPOesRoDjwMll2jfGcXfaVjKrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268558; c=relaxed/simple;
	bh=2TX+VQKkEDPh4jVMYOB8FirTibI+S3VlTt0lpJQiw1M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fWCxR/LrJjYopo5j0fsl0DyS0Q3t6OQJAHJQmKi9/JKESauVUQp9sbxIiJpKtO7EnPpMtir1JiE6dnxE8lM49wdFlC18BWu8N5ooO+pQMrjftyYbTX0g4HadionfxYe9TnLv4PluH4FEqG64eoSqivA59mOksHwqGfWP1HzjY/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkMmsnpu; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkMmsnpu"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso555690b3a.2
        for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 00:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744268556; x=1744873356; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NK6DKsleLDedEDUoOJ6FfHyENnTO114saQVV2MVI27k=;
        b=OkMmsnpuM6NSlDlK1iK8b8QRkpUEfgQwbv9SDQcxUZyfLkTC+OXxIriq2VNLlRZ6Et
         vS8m3oIKq6MrRP8Eboy2nsIRx116alU8agFodg5voqO8eBfgyPK/1bg8NRWuKqeLFCd2
         4pAbnY/OG5bsAAex9Xaxp1lAUVQC/a40r9GB/MyU9kdQNcd0EhzFNgLsTSPP3ICfukJ7
         8LNJ+KuJF3goPb7fEW3gpOUNBs2nom6hZD5XQdtpPLySS/chzwB1eXvQQMLDzkkunk4E
         RsW4EXHf1unUJyjC+ClEAfNSumNLpqyJf3V4x3IwzVdMkB86YOzpUx/Ij+zrdWpdXy8M
         u66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744268556; x=1744873356;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NK6DKsleLDedEDUoOJ6FfHyENnTO114saQVV2MVI27k=;
        b=gL8i1Z+umqCJZGUaTGXcE1oCaV4uKBNCY11lP+5b7Z0uSagU6qPNzWDbfy0W2KY/DO
         DEKlwNirw//VgIA/L43fboIj1rPSUI8FUkK55Iy4/0zA1i/cP3t+1iSOtRTi+QJu4m8m
         JrCvZ4cBr6dyErziMTKzZRnzo8fIlvyvN8Cl1xG5g1f2dIflJwUSE3x9zM+DXy92YoWO
         uLlBAcs41+bb0W1rDoqBQQxIsasuV8PLTWRrom5FPZLfkA5EDnfL6N4ehHSBiaS42j41
         i082FicksjQaVvERcUWrnBMplR0uytMSZD/z8y8rh693OWDH5kJ3olK+mxSZMu5usnHg
         St5g==
X-Forwarded-Encrypted: i=1; AJvYcCXobkTJjWUqn7py9+rjVyJNDrqmebDGH4FE+iRhik52R9YcY3v9cWj0PlF+1by9VmPdHBWVGx4nyHPdX0iHIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaANxycFa68TyLwFrGTErMgnPSMQHo7I09uLlB+B6jozUXT6K/
	7f6RYIKJ9kZ/lnYMl/umsHyBZphTvzPtezeU/+0BFd1foGQ5hseg
X-Gm-Gg: ASbGnct9u7do/nE2oP6EzFxmy6qtIfDozkONVt05IHvIttWAYUM2uzCg3KG53HqdTgt
	R7t3/kANQcCVHiUA8RtGG+5wyp7oK1aQYgmvkavsBI0u4HJH50I+uWlt5NT5GLI/SSu+XHilmRI
	/xHVCneXeoxBNirP2SPcYpjAjG3KowMZWyOwHl4XhsWotz3SsqBcP6g/qe7Rttx++H4zpuw/sWe
	QYz8S3SW2ceMLbdqWp8CwtBjWywUU3Xg4BV9BC4nXsT2cYl/tbOeV2U1Mc4W8u/rezg3t8/Dyi8
	9elrahM8MeeD9fW1vtVLVuGoF5UQ6PaGlbPQWHvqbYL7KrKL0bviVdsgGI5ID9lIddOW2g00lM1
	aWFpv+Ot/GwwJNZEHj3w=
X-Google-Smtp-Source: AGHT+IHR7wErMqs6toXfdLAhBSnptfh78wJMNtMX9vyDLNp19zuG+N7r2GGC3hWvA1EXN0f9XAM0vQ==
X-Received: by 2002:a05:6a20:1587:b0:1f5:8678:183d with SMTP id adf61e73a8af0-20169480c0fmr3203289637.14.1744268556356;
        Thu, 10 Apr 2025 00:02:36 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:959f:bd4a:33b6:cab1? ([2001:ee0:4f0e:fb30:959f:bd4a:33b6:cab1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a12c9c05sm2342598a12.42.2025.04.10.00.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 00:02:35 -0700 (PDT)
Message-ID: <b7b1f5de-7003-4960-a9d1-883bf2f1aa77@gmail.com>
Date: Thu, 10 Apr 2025 14:02:27 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: disable delayed refill when pausing rx
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20250404093903.37416-1-minhquangbui99@gmail.com>
 <1743987836.9938157-1-xuanzhuo@linux.alibaba.com>
 <30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
 <CACGkMEs7O7D5sztwJVn45c+1pap20Oi5f=02Sy_qxFjbeHuYiQ@mail.gmail.com>
 <4195db62-db43-4d61-88c3-7a7fbb164726@gmail.com>
Content-Language: en-US
In-Reply-To: <4195db62-db43-4d61-88c3-7a7fbb164726@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/9/25 13:44, Bui Quang Minh wrote:
> On 4/8/25 14:34, Jason Wang wrote:
>> On Mon, Apr 7, 2025 at 10:27 AM Bui Quang Minh 
>> <minhquangbui99@gmail.com> wrote:
>>> On 4/7/25 08:03, Xuan Zhuo wrote:
>>>> On Fri,  4 Apr 2025 16:39:03 +0700, Bui Quang Minh 
>>>> <minhquangbui99@gmail.com> wrote:
>>>>> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
>>>>> napi_disable() on the receive queue's napi. In delayed 
>>>>> refill_work, it
>>>>> also calls napi_disable() on the receive queue's napi. This can 
>>>>> leads to
>>>>> deadlock when napi_disable() is called on an already disabled 
>>>>> napi. This
>>>>> scenario can be reproducible by binding a XDP socket to virtio-net
>>>>> interface without setting up the fill ring. As a result, 
>>>>> try_fill_recv
>>>>> will fail until the fill ring is set up and refill_work is scheduled.
>>>> So, what is the problem? The refill_work is waiting? As I know, 
>>>> that thread
>>>> will sleep some time, so the cpu can do other work.
>>> When napi_disable is called on an already disabled napi, it will sleep
>>> in napi_disable_locked while still holding the netdev_lock. As a 
>>> result,
>>> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
>>> This leads to refill_work and the pause-then-resume tx are stuck 
>>> altogether.
>> This needs to be added to the chagelog. And it looks like this is a 
>> fix for
>>
>> commit 413f0271f3966e0c73d4937963f19335af19e628
>> Author: Jakub Kicinski <kuba@kernel.org>
>> Date:   Tue Jan 14 19:53:14 2025 -0800
>>
>>      net: protect NAPI enablement with netdev_lock()
>>
>> ?
>
> I'm not aware of this, will update the fix tags in the next patch.
>
>> I wonder if it's simpler to just hold the netdev lock in resize or xsk
>> binding instead of this.
>
> That looks cleaner, let me try that approach.

We need to hold the netdev_lock in the refill work too. Otherwise, we 
get this race

refill_work                                xdp bind
napi_disable()

                                             netdev_lock(dev)
                                             napi_disable_locked() <- hang
napi_enable() <- cannot acquire the lock


I don't like the idea to hold netdev_lock in refill_work. I will reply 
with the patch for you to review.

Thanks,
Quang Minh.

