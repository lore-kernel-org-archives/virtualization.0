Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947A8158A12
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724099093; cv=none; b=iwb2OqMGeGqAtHXJawkiBgOPVzZLpK/BiPthdJ7dNe2YVyTs6f8DYxkpOOWe54As433NqSqkB8CDY/eOMCoS0/S+67/L4IWTkYQ4pHgrCTB6inOCYUkimlmWH12rfkymcvLF+kbn/JGHJGeVf6H+GqVEbDsCL/pJNmjsHjs8qEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724099093; c=relaxed/simple;
	bh=THfhdHmRz/RaGBsxb56OWc3c/haqJ5OVdmrx4qq87aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRkgiGvh08fkmd5A5/VQTOyxCxDYV+a/0jugGBbq0iqJmOA6xPbrIwb355ojnIbPrGdeHyYP1iU4WP6XKNoFMDyoxEbJZTTriRSaOL931Q7rVfeNhHVC1nvHPmwsVcPbcZKXyCE9sPMyMbM2pxrHjBHbApNgRvYFHBNekm3pEFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ccAyKnij; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccAyKnij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724099089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+6seMwyVU5neWl8xki3yhNsKRph76e6t60rSxKtH/Mo=;
	b=ccAyKnijvwREG6l+I+96IeXvNSbVmLzhhwbp0l28uDTTne/YHYxQP+vVhdKAn+ELfn12xv
	ANWme1oRDmzT2RJYbu7S+auTrk3SmlUUpOZRwHnVUj/Fv3rfR06J3GVmiKIL6hoGPL7Rpj
	34Y8Ah1eHB1NLL7cwO7nkhLRzX3TU4M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-N4un8aTYMcmQA3sQF-Xp7w-1; Mon, 19 Aug 2024 16:24:46 -0400
X-MC-Unique: N4un8aTYMcmQA3sQF-Xp7w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4281f8994adso40994325e9.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 13:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724099085; x=1724703885;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+6seMwyVU5neWl8xki3yhNsKRph76e6t60rSxKtH/Mo=;
        b=RX/LTDV2+nvT2Vegib8S/Wmtkhbes+sKszAL94BabhLEgclZcSG4sOf9TSe4H2CveD
         CYXYZtBjhcGVlycSZMecUsZg72w6sI0t+DUqpEyGQMMEdhZjMFqzLr6BC1szc5ofvH6L
         qWcPKavwbvIU3JITaFdebfuQKKG/BIIqPsmtq5BK/vGvLOcUDVukWhPXweqV2ceeqOvD
         QE2MZEprl5wv7vRtdzor9nY6ZZUN/HSqFLZTML9GNuPm/ec9xvo8omZxcbkv9cvUpU/+
         QaBY45Lu2cQw1sgD7cqDRWsajJTUNam8ERYZPo3qP6CxXSnKuH2wY63egf9Bh7VhcdWu
         iL1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX70Ux65Pc7chSvx56/mcWcIzz/W/L6GmfvEeg2R/qh6FszusmPPMqWQ8I2ajbmGZI4KT9Om2PT5prfUu+EmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIjm+4EkluZXhJHjEfQotp8/AHiI0vLW3JWSvjKYQnusmYuP68
	hiC/q9NC+INVgpQMcPutHFEjwhpmQ/dOxwO7jFhyy67YPJZEZtuTAK/MhXLqnTjKQsGb+VfXDia
	gkedMffjgqfNYEr7m0UnC1nBwpHL2zDEGJjUMeBkf34NvmaePJb+56UsNktmrzywh
X-Received: by 2002:adf:a39e:0:b0:371:86de:8e8b with SMTP id ffacd0b85a97d-3719468f236mr7387025f8f.41.1724099085490;
        Mon, 19 Aug 2024 13:24:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2AZut42cJzCZ8jf4IwW55HYeB4aVPLbmQ+38Kb9DpjBlhDOk3MzD0rtuSUuTpoIaTu6SoFQ==
X-Received: by 2002:adf:a39e:0:b0:371:86de:8e8b with SMTP id ffacd0b85a97d-3719468f236mr7387006f8f.41.1724099084959;
        Mon, 19 Aug 2024 13:24:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:4b00:7ba7:a109:29b8:e459? (p200300cbc7404b007ba7a10929b8e459.dip0.t-ipconnect.de. [2003:cb:c740:4b00:7ba7:a109:29b8:e459])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898ab469sm11356901f8f.100.2024.08.19.13.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 13:24:44 -0700 (PDT)
Message-ID: <a366907d-191f-471d-aa5a-fc8f3f88198b@redhat.com>
Date: Mon, 19 Aug 2024 22:24:42 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
To: Michal Hocko <mhocko@suse.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com,
 hch@infradead.org, iamjoonsoo.kim@lge.com, penberg@kernel.org,
 rientjes@google.com, roman.gushchin@linux.dev,
 torvalds@linux-foundation.org, urezki@gmail.com, v-songbaohua@oppo.com,
 vbabka@suse.cz, virtualization@lists.linux.dev,
 Christoph Hellwig <hch@lst.de>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20240817062449.21164-1-21cnbao@gmail.com>
 <20240817062449.21164-4-21cnbao@gmail.com>
 <5654b71c-1d9d-4c48-b28b-664662da8897@redhat.com>
 <CAGsJ_4xF0YVS4TiaJwQ=YDeTTXg7hhNJOxzTYWy1cwu1YmLd5Q@mail.gmail.com>
 <416ac265-ced2-4f90-a347-0a256edf7fdf@redhat.com>
 <CAGsJ_4xNmi9nuZaLVjWgBA4cVqyDYVupQ1Hzygbnq98OiP9p8g@mail.gmail.com>
 <54a4619d-e826-465e-9a0f-0a8f37798e15@redhat.com>
 <CAGsJ_4zWNgA1OZJ-iAa4KhDY9TuGb2vji4=FJ=Vn7ve5uF6XzQ@mail.gmail.com>
 <5424dfa3-03db-4a82-a08e-fb31285774b3@redhat.com>
 <ZsN9Eo8HWdEgqpf3@tiehlicka>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZsN9Eo8HWdEgqpf3@tiehlicka>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.08.24 19:12, Michal Hocko wrote:
> On Mon 19-08-24 14:49:55, David Hildenbrand wrote:
>> On 19.08.24 14:48, Barry Song wrote:
> [...]
>>>>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>>>>> index 60742d057b05..d2c37f8f8d09 100644
>>>>>>>>> --- a/mm/page_alloc.c
>>>>>>>>> +++ b/mm/page_alloc.c
>>>>>>>>> @@ -4668,8 +4668,10 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
>>>>>>>>>            * There are several places where we assume that the order value is sane
>>>>>>>>>            * so bail out early if the request is out of bound.
>>>>>>>>>            */
>>>>>>>>> -     if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
>>>>>>>>> +     if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp)) {
>>>>>>>>> +             BUG_ON(gfp & __GFP_NOFAIL);
>>>>>>>>>                   return NULL;
>>>>>>>>> +     }
> [...]
>>> Returning NULL doesn't necessarily crash the caller's process, p->field,
>>> *(p + offset) deference could be used by hackers to exploit the system.
>>
>> See my other reply to Michal: why do we even allow to specify them
>> separately and not simply let one enforce the other?
> 
> Are you replying to this patch? This is not about a combination of
> flags. This is about the above (and other similar) boundary checks which
> return NULL if the size is deemed incorrect. 
> I think those are potential
> problems because it could be a lack of input check which could be turned
> into a potentially malicious code. Because unchecked (return value
> because NOFAIL never fails, right?) return value might even not OOPs and
> become a silent read/write into memory.

Right, that's a different kind of issue than the simple "don't pass 
stupid flag combinations" thing where "we'll fix that up for you" is 
more reasonable.

Possibly NOFAIL allocations with an allocation sizes that is not a small 
compile-time constant already has a bad smell to it, but I'm sure there 
are reasonable exceptions ...

> 
> Whether to BUG_ON or simply loop for ever in the allocator if somebody
> requests non-sleeping NOFAIL allocation is a different story.

Right, "warn + loop forever" is one alternative where you could at least 
keep the system alive to some degree. Satisfying a large allocation 
might take a long time, satisfying a "too large" allocation would take 
forever.

But as Linus says, it's all workarounds for other buggy code, to make 
buggy code less exploitable, maybe, ...

-- 
Cheers,

David / dhildenb

