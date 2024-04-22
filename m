Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD9A52F96
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777002; cv=none; b=RD1NjL8svVqEdMsWfTn3wtCOyv1Kk0ypsRpSm8UXgzfW1ZkdA+LOQNmpeVBZ7fFc2iScxBA6apI+WNvmmlsudB1vlhTjfSxBRA5m/E5epEm571TczAHEMmi2vmMIDdGepAQIDw0em1sSe9fVk3cYDUL9AByz8BuOsPNKcb7l/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777002; c=relaxed/simple;
	bh=z2nE+vxm4z+0y30mt+F2gBSosy9BgCjH8KeavwHv+qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjFbFalnqiKlBR1fwnrjqiLZ/5w2keVGiTl2qfNwKfZzn+tNUTXBnwohMkl4plB63shQlOJldGlR5Rbnrkl1Gllml5WCWe6NGjZlNcLoIoR5VTzcit91ErcLvV8dC1dif+s/86jRB8BVGseIJX9UW6KxYav50IKwy4Nm3IzEMF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CCMtv9TB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCMtv9TB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713776999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jPrpW76zmoMcet4ts7Mcq0G5yVz2e8Ls/phfxBbKBQU=;
	b=CCMtv9TBZ1alJ8BmiXblbW7JWNx+FsfXSALbCpMTL0DKmRC2ElqTWDv2oPjXMfC7tXDHZQ
	oY/cOm8HdUDgti/GF6OpiVX9E1/tOn/DnaW9n/WtVI5nf9vTD/OPYFOgw7YXbY9AwpGga4
	EOI1tstHwbvtGMYDO/H+BdpIkxIXLUc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-0iGaqgg0MMuM66D4_AWhUg-1; Mon, 22 Apr 2024 05:09:56 -0400
X-MC-Unique: 0iGaqgg0MMuM66D4_AWhUg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2dc8418e64cso32357031fa.1
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 02:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713776994; x=1714381794;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPrpW76zmoMcet4ts7Mcq0G5yVz2e8Ls/phfxBbKBQU=;
        b=i0m/c+T7G4srPbn/ptMhEnIxg0AY8e03W85U5cf5rdga0lELbpZLFfYpNBZFaWaDpI
         X5MT26obG6GhqTo8SLwalkHlPJXWPwTDdKiuKXIkNiBXH6/fJh7TA0e7fiJQM/tR2h0b
         ICs+whGK+kQ+dLuBnWhr4fuVTTXyJJ9OjgRFjVwgxjQOqIVjAjNaZOpF3LGQxamywzuU
         zi+weyl9uKj0EEUxMYBhL/JzASx8V0LsgQ5BfJ7GBhU/rfdeKpwYItEyy77Q0xGv8BQV
         1mSqfjNoTSrM0R/5bDzLPkQSRa1OwEqe66nNpW9axnVwo1fJyQCjIcWg9E10Sze9/PFr
         E3bA==
X-Forwarded-Encrypted: i=1; AJvYcCW83+veLCswf8Yth/KQxo3N19d0QSH/E6+p+rWmKujTNWj2EZV+GdW7dEc1HF0tQJO0xGDkmhi4k+3Lhb1ribg8udj/sOBlWkCNOnGhwcw=
X-Gm-Message-State: AOJu0YwBUUCioyz00wc9xm3qY2I8XTMIO01Di2K4vaIuuTHKpIjCWK3Y
	pH7xRsLFwTr90w673wiuEh2PT0UzNmtbTcMucLHIzVuyJFGrrWGEUl5W+irlkvaWr1bwBF8tDeR
	c4pbekFPbFOCymrUbOzPG249ZxJp1vhUehAskO/04+3SX1B6q2+m8sBUsvT+4cRPR
X-Received: by 2002:a05:651c:1a06:b0:2d8:8b44:8ce with SMTP id by6-20020a05651c1a0600b002d88b4408cemr7539295ljb.46.1713776994762;
        Mon, 22 Apr 2024 02:09:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYGdb2JfDgXUyhaukwTa/RvYLRmjHY6G3d0aA9ciHGkOqy9/rMM0nIB5E8N2UXm6TDzYEVZg==
X-Received: by 2002:a05:651c:1a06:b0:2d8:8b44:8ce with SMTP id by6-20020a05651c1a0600b002d88b4408cemr7539277ljb.46.1713776994322;
        Mon, 22 Apr 2024 02:09:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:600:d2fb:3a8a:9944:7910? (p200300cbc7390600d2fb3a8a99447910.dip0.t-ipconnect.de. [2003:cb:c739:600:d2fb:3a8a:9944:7910])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c155100b00418db9e4228sm16013913wmg.29.2024.04.22.02.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 02:09:53 -0700 (PDT)
Message-ID: <17615a07-f9fb-49bd-ad56-df6691c3d362@redhat.com>
Date: Mon, 22 Apr 2024 11:09:52 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] virtio_balloon: separate vm events into a function
To: zhenwei pi <pizhenwei@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 akpm@linux-foundation.org
References: <20240422074254.1440457-1-pizhenwei@bytedance.com>
 <20240422074254.1440457-2-pizhenwei@bytedance.com>
 <6a182645-1f7f-4b7d-a16a-36e9b1684c58@redhat.com>
 <537ac244-74b2-42ad-97a7-475ec27f2134@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <537ac244-74b2-42ad-97a7-475ec27f2134@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.04.24 10:04, zhenwei pi wrote:
> 
> 
> On 4/22/24 15:47, David Hildenbrand wrote:
>> On 22.04.24 09:42, zhenwei pi wrote:
>>> All the VM events related statistics have dependence on
>>> 'CONFIG_VM_EVENT_COUNTERS', once any stack variable is required by any
>>> VM events in future, we would have codes like:
>>>    #ifdef CONFIG_VM_EVENT_COUNTERS
>>>         unsigned long foo;
>>>    #endif
>>>         ...
>>>    #ifdef CONFIG_VM_EVENT_COUNTERS
>>>         foo = events[XXX] + events[YYY];
>>>         update_stat(vb, idx++, VIRTIO_BALLOON_S_XXX, foo);
>>>    #endif
>>>
>>> Separate vm events into a single function, also remove
>>
>> Why not simply use __maybe_unused for that variable?
>>
> 
> 1>
> static unsigned int update_balloon_stats()
> {
>       unsigned __maybe_unused long foo;
> 
>       ...
> #ifdef CONFIG_VM_EVENT_COUNTERS
>       foo = events[XXX] + events[YYY];
>       update_stat(vb, idx++, VIRTIO_BALLOON_S_XXX, foo);
> #endif
> }
> 
> 2>
> static inline unsigned int update_balloon_vm_stats()
> {
> #ifdef CONFIG_VM_EVENT_COUNTERS
>       unsigned long foo;
> 
>       foo = events[XXX] + events[YYY];
>       update_stat(vb, idx++, VIRTIO_BALLOON_S_XXX, foo);
> #endif
> }
> 
>   From the point of my view, I don't need to compile code in my brain
> when reading codes for case 2. :)

But for #1? :)

I mean, you didn't compile the code in your brain when you sent out v1 :P

But I agree that moving that to a separate function ins cleaner, staring 
at resulting update_balloon_stats().

Let me comment on some nits as a fresh reply.

-- 
Cheers,

David / dhildenb

