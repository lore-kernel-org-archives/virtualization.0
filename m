Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144C2248AF
	for <virtualization@lists.linux.dev>; Mon, 10 Mar 2025 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602235; cv=none; b=SIhfQ/T/9O7teYlXKRClwAi9ZqS/E7LllZvFhg0VOfAj1HakqSdjvrJ/CUCLn9tuo06Y3niOcqzn9yVJ8ocgtA9RdtE1au2+o+fBHO2O9avXhoN2uDEXqrPQhwb05hKWcClX5/nfZzfbB9clk7PzhY/Qi4NI3dABvQBSPyedwVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602235; c=relaxed/simple;
	bh=KfKRHQ8QFUYVsqgaPCXNdrqSt2cCVkpxSjrd0RLuCLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFVlwUzR3bGU7LSC+SSCR1Q2aMn30AfO+oZzw/qyPygTxmuskoShV8Hhz9xWLVmIhlGtW6JKDFgnjlXn0tXWIlXq2oZDVrMjcuOiKvWFom+lU4bLxlmDz4ogVAX3K0y29Rc5ID74kF7+wpfQTC2ID4p4yhnIRCcCyWaYRZzhecM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYXzAa1S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYXzAa1S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741602232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/12pVfGrHfAC9KyGDgoRmy2bzHmGQuVzoa458sMOedg=;
	b=DYXzAa1SCuY+uxS00o72mMeDv/RwWOEWWHeQEj2seVBy7L7tl5Fd4wRm9J0Xl2QRgIXqnL
	BPRKzrH26JpG2+3RziEIUb/YvLeLpSpN7BFn+jJ/UO9/HSZZdwcJAW8Wvt/yLciDkFtqeg
	jVExuSvf4H9PbMBj1kYL1+LUBRVAoww=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-wN-HYlNJNym5iE9hFS-OkA-1; Mon, 10 Mar 2025 06:23:49 -0400
X-MC-Unique: wN-HYlNJNym5iE9hFS-OkA-1
X-Mimecast-MFC-AGG-ID: wN-HYlNJNym5iE9hFS-OkA_1741602228
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912d5f6689so2509970f8f.1
        for <virtualization@lists.linux.dev>; Mon, 10 Mar 2025 03:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741602228; x=1742207028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/12pVfGrHfAC9KyGDgoRmy2bzHmGQuVzoa458sMOedg=;
        b=gBBF1XmgbP5gtOKJu/MWvte8GKaEyfimt8/wCGJCq1kxNC8Qz2W9kTbJuZ5l4qXwx2
         taWEP7K74qNQrN2qRjlNtVL/AJ84L9bWrdaR94ZUU41HyCHDnQKl6OxBJm2iDxLBByjm
         EGA/SLVXuubiHKkaif3mo3BfMT7gjG+OiT3ApgeeRnccFI2z8Cr4vHvqAQtw1nrdFfMi
         sODrtIZqWJJGJceCGWEqc8+6+6u/gH0xIAKEaBUeNGCYKiyo21T9qrKr5gODgmXo+5NW
         JY3LseJEeW1HfOWoLTm9aro3MIB+2Yz1wPV/kN/K/8vTW4n/36i++A8lFlx6ltjfkB8n
         H2DA==
X-Forwarded-Encrypted: i=1; AJvYcCU1yFeu4Dteh558yNS1Pe5gUyh6DxVxx8bi+Kh22l7oQniFQTKA+TNYZk89rSfgGnA4aDckve2vfkuH+hrYCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNa5Ypy84fnfMmCXaDGMxHhu2TWsw7tgneTeQeEqqnRXTUbkKB
	uG9SqdM7614j636K6MBPYIa1lPzhi1t1YeomgQ5iWkiqCEauB2THzdRk3IYNCWOAYsV03aP0knD
	RzQIEIEcUjLhdv9Ed9pOq7WbOD02pCw7TGoTt7OXiW/gLHyPQFK0GrfKISIefcTcP
X-Gm-Gg: ASbGncs9G73n8glm+9vk534yVKR6QiByUBwxJhXR3quKlJG9HhHxXOI7wlND8w1wuiU
	k4Ed6+/2KQi7D9O/4cfu+ELe3qNmnGFPNriAAxrunlrei1BEOY6UvLgZlhPjsYteoFVE09fSMI7
	DgwOYqjiapLDUWUBP1CtkRnEGC3C0wdYzvvb6HXZVPxAq12ylMmg8TEXhAOicmE+MbgGTy9Ku1l
	Qolv7zEnCre69QN8g5F6yuGaLnHOJ9WHOhQJUJ9xY4TG7D8on7myuQO/jxKxVrXIL+bpbmARhg/
	wO4rTmxWiVsE9VumxJHEhM2ejXhP/uE530XHWOgvl54ZYoLZQPVcRII=
X-Received: by 2002:adf:e007:0:b0:390:f4f9:8396 with SMTP id ffacd0b85a97d-39132d7ff8bmr4952024f8f.28.1741602227911;
        Mon, 10 Mar 2025 03:23:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTlUKdfWg/n6nLhAEk75JdM460Sx5llLCeap2DgVS7ohzTSeVMGhEWCd6FidoOs3NkTtglMA==
X-Received: by 2002:adf:e007:0:b0:390:f4f9:8396 with SMTP id ffacd0b85a97d-39132d7ff8bmr4951998f8f.28.1741602227497;
        Mon, 10 Mar 2025 03:23:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdff72sm14634492f8f.36.2025.03.10.03.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 03:23:46 -0700 (PDT)
Message-ID: <de5b9722-905c-49e6-87dc-3fcdeb07fb09@redhat.com>
Date: Mon, 10 Mar 2025 11:23:45 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-next 1/2] vmalloc: Add atomic_vmap
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
 akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
 dmitry.osipenko@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-mm@kvack.org
References: <20250305152555.318159-1-ryasuoka@redhat.com>
 <20250305152555.318159-2-ryasuoka@redhat.com>
 <Z8kp9Z9VgTpQmV9d@casper.infradead.org>
 <3bfd4238-6954-41a3-a5a3-8515a3ac9dce@redhat.com>
 <Z8nEqDQhjU-Ly8Js@phenom.ffwll.local>
 <51c11147-4927-4ebc-9737-fd1eebe4e0bd@redhat.com>
 <CAHpthZqn7ZZW1ekFQe7nN0+xfsNvMQMKhjMNcB3EyQ18yfQhiA@mail.gmail.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CAHpthZqn7ZZW1ekFQe7nN0+xfsNvMQMKhjMNcB3EyQ18yfQhiA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SXevOBuwtABMEMTfcwfvwy4AeCKxUl3QewyysNdAi3I_1741602228
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/03/2025 09:07, Ryosuke Yasuoka wrote:
> On Fri, Mar 7, 2025 at 4:55 PM Jocelyn Falempe <jfalempe@redhat.com> wrote:
>>
>> On 06/03/2025 16:52, Simona Vetter wrote:
>>> On Thu, Mar 06, 2025 at 02:24:51PM +0100, Jocelyn Falempe wrote:
>>>> On 06/03/2025 05:52, Matthew Wilcox wrote:
>>>>> On Thu, Mar 06, 2025 at 12:25:53AM +0900, Ryosuke Yasuoka wrote:
>>>>>> Some drivers can use vmap in drm_panic, however, vmap is sleepable and
>>>>>> takes locks. Since drm_panic will vmap in panic handler, atomic_vmap
>>>>>> requests pages with GFP_ATOMIC and maps KVA without locks and sleep.
>>>>>
>>>>> In addition to the implicit GFP_KERNEL allocations Vlad mentioned, how
>>>>> is this supposed to work?
>>>>>
>>>>>> +  vn = addr_to_node(va->va_start);
>>>>>> +
>>>>>> +  insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
>>>>>
>>>>> If someone else is holding the vn->busy.lock because they're modifying the
>>>>> busy tree, you'll corrupt the tree.  You can't just say "I can't take a
>>>>> lock here, so I won't bother".  You need to figure out how to do something
>>>>> safe without taking the lock.  For example, you could preallocate the
>>>>> page tables and reserve a vmap area when the driver loads that would
>>>>> then be usable for the panic situation.  I don't know that we have APIs
>>>>> to let you do that today, but it's something that could be added.
>>>>>
>>>> Regarding the lock, it should be possible to use the trylock() variant, and
>>>> fail if the lock is already taken. (In the panic handler, only 1 CPU remain
>>>> active, so it's unlikely the lock would be released anyway).
>>>>
>>>> If we need to pre-allocate the page table and reserve the vmap area, maybe
>>>> it would be easier to just always vmap() the primary framebuffer, so it can
>>>> be used in the panic handler?
>>>
>>> Yeah I really don't like the idea of creating some really brittle one-off
>>> core mm code just so we don't have to vmap a buffer unconditionally. I
>>> think even better would be if drm_panic can cope with non-linear buffers,
>>> it's entirely fine if the drawing function absolutely crawls and sets each
>>> individual byte ...
>>
>> It already supports some non-linear buffer, like Nvidia block-linear:
>> https://elixir.bootlin.com/linux/v6.13.5/source/drivers/gpu/drm/nouveau/dispnv50/wndw.c#L606
>>
>> And I've also sent some patches to support Intel's 4-tile and Y-tile format:
>> https://patchwork.freedesktop.org/patch/637200/?series=141936&rev=5
>> https://patchwork.freedesktop.org/patch/637202/?series=141936&rev=5
>>
>> Hopefully Color Compression can be disabled on intel's GPU, otherwise
>> that would be a bit harder to implement than tiling.
>>
>>>
>>> The only thing you're allowed to do in panic is try_lock on a raw spinlock
>>> (plus some really scare lockless tricks), imposing that on core mm sounds
>>> like a non-starter to me.
>>>
>>> Cheers, Sima
>>
> 
> Thank you all for your comments.
> I understand adding atomic_vmap is not possible as vmalloc is not compatible
> with GFP_ATOMIC. I'll re-implement this by pre-allocating the page table and
> reserve the vmap area while the kernel is alive. It'll might be
> allocated in driver
> codes so maybe I don't need to add any features in core mm code.

Maybe another way to do that, would be to atomically kmap only one page 
at a time. And when drawing the panic screen, make sure that for each 
pixel the right page is mapped.
Would kmap_local_page() fit for this purpose?

Best regards,

-- 

Jocelyn


> 
> Best regards,
> Ryosuke
> 

