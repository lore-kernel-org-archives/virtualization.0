Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233DF2D73A9
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860916; cv=none; b=VvVCov4MIIXark7XvYrB8hIHbBA3aBnzYJbXEnv756oOxCyYnk6ezlgjn+uKtzipPSxApCb6QYsGV5BWSdxKMmnqA0Ebxq8/wotngdu0Bc+72gNNEZQWbJyY6JIoPIo7ZNUXOZ38QjjcG7EELJo4LSHpDpd97rDvwTKMmk9yRh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860916; c=relaxed/simple;
	bh=mow+fg3+RlIbDNumBSEnGyZekiI5a4ukShUjLnnu0Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrnMfK9yvrZUovi3Oj9l7uADJPrG1hN4LwxIi1sSirNSKK0dd+E3ZxwzjNp4aqpKdeHD7sbv8J88Ge9NiufyH0MXxIPuZhoGdm6Cu8euDgpzCEeVxsvr7Xuwqjvd8pw3JoqOs/kUx/DpvuoRVZ3ZaT6KoZ4EaQ72gqb0pdRs29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuK6de3/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuK6de3/"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so1077794b3a.0
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 07:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764860913; x=1765465713; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1iqQ0ov45xjnCibqFJmGxUgMKunIGbHn1CsgPvUOa0=;
        b=XuK6de3/ZGzEfg+APfP6PBj8QmehFdJly4DbKbbMsCTr0501dureYt2YRWFCS+hp9U
         5/KYKfkwsKpptEbzh/kYJDiqatDM1CKwnOThtuilyaKWReqBsUE5QEZFh+57HsUaf3Bw
         c8Kj0xDhen4AE47gbBcfK+J4FheCyGmQM8tFTV+hGqV+4euxElcp56HJEIjRkVaAuTTr
         EzBVrAkmJRzYoUJ4cn5aweaycCVpPm8/nu4qK5yb3JTNQqB9gcexj3hgbhbLGGpCCVo5
         QiXj7RA7uGBnR6/FIF7z1jxd78TpU6/PQQ4LgoZLhz4uaQZd9H3jB6Dik5cLGjyeiJC1
         QZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764860913; x=1765465713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1iqQ0ov45xjnCibqFJmGxUgMKunIGbHn1CsgPvUOa0=;
        b=sEwuIxiUjA0x9EDPWw5BI+pdff7vF0DHTZKIbs4chBiBDaKniBKqOrDE8blWlxSSRl
         9w3MaTVXHf0D1+3ShuBVtIuvQ9WCddgcyjwccZ8fSFAo1B+r7wPexR65BAhoazyT+m7f
         cX/Ac0sBkMw0m7i2HK5Lx8CQm5rhZwW0JuVGdmmGbjrvKHCzy9m1nTTvhvDvU1PYEb4i
         nnEYGvKbqFGVl04pJh2PkudT5pa0d3j6FfetubHT37v5AGDTnqeOaZvqnykbJr3i6l/h
         3OzV8KNQ4HtBUmZBVw6vXNZW4cd3yzpth1QTfhwd9/ZCSZbpOnI6l5+Hv2BqE8nHDFWn
         iiUg==
X-Forwarded-Encrypted: i=1; AJvYcCXdbocv4ebjDm/SsBWxsa1DWR549E3FSgKYQPSJTKDcU1zlhAy+lhChYGyizGZ9g5zgsOm6XoZNk+aRgOdkYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKW8RoCALN3x1vDPHDs7wqn5fF78HkLesRHvZCD3kxlluBhJay
	xURCK/E2v9AeD139AqJ6r7Jo0Le/UkrbnH58Wt777RTvq0Dz/sx9o60n
X-Gm-Gg: ASbGncvaLnwBXNEfR7tmM15A+Qh8byAIblaYZArwXWz5hSN0AcBCoaR0icdOJwXK8X4
	KU45IPxLzX41Oidk4HrTZks6i9F5u5TvzmOPVWpHrn6jdfy4J+lM7D7d+2ejBPr0Tvr/Z0w9LjW
	D3CQtvaO0Mbe51Y+YSBgQsStlAPu8ZNSQ8WJP0hFN3J/hhkOO7AYsZsr8yV73bact+zyQ+cBOam
	RUYEkNEr/BbugAaYi7xMaeHlmaIFhTf+D66AWotXovr1ZxxW9mnFwLbRxFg1qpF9o9iyWQUr044
	6J9cp79kp+Ke5IqCbhgfIk3YscPLobLUcUi2YobWerMSIQPRfyoBYOx2VmM15CrtKy4vzSNNMhF
	lG1kW/LOMMEPsZ7/T1upcvUBx7UQnntydSmvIoWiL+JO6XAei+baJeoLC2a5EawokdZwhycRM4T
	yrTUlAFwjssXGNuOfoL+GzSRYHNKJl7Rre6K1wnFZiehUIkC5LsfMxsaAohzcZ8Q==
X-Google-Smtp-Source: AGHT+IGT33HgCqLOZfJ01RgUk00qwFrULoYZQaMW53xI5BI0UsjXz8kyxp1vtyO+ouK42MOcyxdiSA==
X-Received: by 2002:a05:6a20:3ca6:b0:34e:1009:4222 with SMTP id adf61e73a8af0-363f5e95146mr8047704637.51.1764860912867;
        Thu, 04 Dec 2025 07:08:32 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:c2bc:6984:75c5:9339? ([2001:ee0:4f4c:210:c2bc:6984:75c5:9339])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf686b3b5a9sm2145622a12.9.2025.12.04.07.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 07:08:32 -0800 (PST)
Message-ID: <eabd665c-b14d-4281-9307-2348791d3a77@gmail.com>
Date: Thu, 4 Dec 2025 22:08:25 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] virtio_net: gate delayed refill scheduling
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <40af2b73239850e7bf1a81abb71ee99f1b563b9c.1764226734.git.mst@redhat.com>
 <a61dc7ee-d00b-41b4-b6fd-8a5152c3eae3@gmail.com>
 <CACGkMEuJFVUDQ7SKt93mCVkbDHxK+A74Bs9URpdGR+0mtjxmAg@mail.gmail.com>
 <a9718b11-76d5-4228-9256-6a4dee90c302@gmail.com>
 <CACGkMEvFzYiRNxMdJ9xNPcZmotY-9pD+bfF4BD5z+HnaAt1zug@mail.gmail.com>
 <faad67c7-8b25-4516-ab37-3b154ee4d0cf@gmail.com>
 <CACGkMEtpARauj6GSZu+iY3Lx=c+rq_C019r4E-eisx2mujB6=A@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEtpARauj6GSZu+iY3Lx=c+rq_C019r4E-eisx2mujB6=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/3/25 13:37, Jason Wang wrote:
> On Tue, Dec 2, 2025 at 11:29 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> On 12/2/25 13:03, Jason Wang wrote:
>>> On Mon, Dec 1, 2025 at 11:04 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>>>> On 11/28/25 09:20, Jason Wang wrote:
>>>>> On Fri, Nov 28, 2025 at 1:47 AM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>>>>>> I think the the requeue in refill_work is not the problem here. In
>>>>>> virtnet_rx_pause[_all](), we use cancel_work_sync() which is safe to
>>>>>> use "even if the work re-queues itself". AFAICS, cancel_work_sync()
>>>>>> will disable work -> flush work -> enable again. So if the work requeue
>>>>>> itself in flush work, the requeue will fail because the work is already
>>>>>> disabled.
>>>>> Right.
>>>>>
>>>>>> I think what triggers the deadlock here is a bug in
>>>>>> virtnet_rx_resume_all(). virtnet_rx_resume_all() calls to
>>>>>> __virtnet_rx_resume() which calls napi_enable() and may schedule
>>>>>> refill. It schedules the refill work right after napi_enable the first
>>>>>> receive queue. The correct way must be napi_enable all receive queues
>>>>>> before scheduling refill work.
>>>>> So what you meant is that the napi_disable() is called for a queue
>>>>> whose NAPI has been disabled?
>>>>>
>>>>> cpu0] enable_delayed_refill()
>>>>> cpu0] napi_enable(queue0)
>>>>> cpu0] schedule_delayed_work(&vi->refill)
>>>>> cpu1] napi_disable(queue0)
>>>>> cpu1] napi_enable(queue0)
>>>>> cpu1] napi_disable(queue1)
>>>>>
>>>>> In this case cpu1 waits forever while holding the netdev lock. This
>>>>> looks like a bug since the netdev_lock 413f0271f3966 ("net: protect
>>>>> NAPI enablement with netdev_lock()")?
>>>> Yes, I've tried to fix it in 4bc12818b363 ("virtio-net: disable delayed
>>>> refill when pausing rx"), but it has flaws.
>>> I wonder if a simplified version is just restoring the behaviour
>>> before 413f0271f3966 by using napi_enable_locked() but maybe I miss
>>> something.
>> As far as I understand, before 413f0271f3966 ("net: protect NAPI
>> enablement with netdev_lock()"), the napi is protected by the
> I guess you meant napi enable/disable actually.
>
>> rtnl_lock(). But in the refill_work, we don't acquire the rtnl_lock(),
> Any reason we need to hold rtnl_lock() there?

Correct me if I'm wrong here. Before 413f0271f3966 ("net: protect NAPI 
enablement with netdev_lock()"), napi_disable and napi_enable are not 
safe to be called concurrently.

The example race is

napi_disable -> napi_save_config -> write to n->config->defer_hard_irqs
napi_enable -> napi_restore_config -> read n->config->defer_hard_irqs

In refill_work, we don't hold any locks so the race scenario can happen.

Maybe I misunderstand what you mean by restoring the behavior before 
413f0271f3966. Do you mean that we use this pattern

     In virtnet_xdp_se;

     netdev_lock(dev);
     virtnet_rx_pause_all()
         -> napi_disable_locked

     virtnet_rx_resume_all()
         -> napi_disable_locked
     netdev_unlock(dev);

And in other places where we pause the rx too. It will hold the 
netdev_lock during the time napi is disabled so that even when 
refill_work happens concurrently, napi_disable cannot acquire the 
netdev_lock and gets stuck inside.


>
>> so it seems like we will have race condition before 413f0271f3966 ("net:
>> protect NAPI enablement with netdev_lock()").
>>
>> Thanks,
>> Quang Minh.
>>
> Thanks
>

Thanks,
Quang Minh.
