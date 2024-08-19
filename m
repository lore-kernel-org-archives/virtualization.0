Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308E416F0E1
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073752; cv=none; b=CF8RmrNgbWWpfH5FN4teeYLI8n7qcOQ59+/wQLZHOrFUkxCdixWD3dhCjfuHAuDl/A293jg6j9rihGJxO9r1c08n/E+SViwZRMgOB1JgQevgb33pb0oOLCLZ4DMqJGez4ygoio1YrZPyg+J1bwCQoFGLdyYHEkuDqlC5siFNJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073752; c=relaxed/simple;
	bh=6aMe8pws1ySH7q4Xnw9pdfpgYguYNRQW55wdB0L/sag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AyFyKQ45zGUrtqEEZZU1xbExkYp2k7T2uF4MC6hELMObS/dbpsmX/JgZWuhYrQtSci7eKFLvR6aaNMoBJidCKPGy1YM69v4cRlBh0RXxUaHHrkkgBYcuERTDamTKMFHvk28sxAVp/Vo9OlrLs+0t2hxzJMpwX65ZOIilgvI51sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRtMzhJ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRtMzhJ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724073747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/DsI6r9572h924gDXqtXB9YkpGPQCPv1JN7WXua684A=;
	b=iRtMzhJ4HdWQXvKKXVjx3SQkD1tyujOsMiMjgsaq5YnIrD2WOSrBWD15JEuh8Z+QCNTKg6
	wYxW8Wj/nfvnI2mBG3gMh3bKMrHRXI2LU5P8aZ3bee5RhsfOiiQNHNsG6Pia88dd9EYQqs
	LJ83gCVyXm3X1BH5w6xlxWELc/jdo9Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-yyha-IcTOt6j4epYah3djA-1; Mon, 19 Aug 2024 09:22:25 -0400
X-MC-Unique: yyha-IcTOt6j4epYah3djA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7a979cae97so350349566b.1
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 06:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724073743; x=1724678543;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/DsI6r9572h924gDXqtXB9YkpGPQCPv1JN7WXua684A=;
        b=FPzQTEitf+FN0kmySNTYg0Kiv8+vFe3KeM+O26iGcZhDvNO/HfDA4F+tZ9l1al1YPB
         IlnOj90Y513J00sVRFMLsfSXGB5761uVXOBF8F//89E/B/uWD6TN09jg/2orjBnt9Zh1
         Wm9YJUqrruMTSqk3nKCIjRQDIHkrQrlJgOjhKJiyd9ck2Gh3K/pilHir0s4vA34mKQiM
         zJB7X5/jpuTdzug+acByopp20p3p0eRnb77sZq65GXTWJ+poqaGPWvqRLYwP+owg8cjU
         fkaWSa+KK0+4O5JKXvLqex5oq0FDZD+TczNid84LWqmnUWTJmAZ8V82GbBRZD4iuwLaX
         0SqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkh7A0thXHyA++I7YE+Vl++2MQVI2CoA45onUGeh/Qi9fZhFw4k6fxw81QfEabL6+f15A5kZSqlPTwhCah0PsF4jvyuDl5sEuRBZSAC7Y=
X-Gm-Message-State: AOJu0YyDeMcGueFnFv44rkZdeZiNGC3O52Ql0hCS+5zG/pirVq2BKXtL
	kvunu0ZuwpcV3u+HDHAMYL1rlYTnrLTHCAOQDJEsSFQQ6yf9AnEVx01hwt2Mm/tJzmyixejGkh6
	NGz7UtxBpGUsKZMQoZPqk3C6jCoLmVR4YIPp/+8PhYu7DG56ghr2krqzrmp7Tu2Bz
X-Received: by 2002:a17:907:f16a:b0:a7a:9f0f:ab2b with SMTP id a640c23a62f3a-a8392954042mr672944966b.32.1724073743155;
        Mon, 19 Aug 2024 06:22:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIsu4mY4XJTpA5h5OsvuWIS+ajhlGD30LrE7Nt8TbQ3RU/QWsJG1WzsA4eiyOQVo88O1c+3A==
X-Received: by 2002:a17:907:f16a:b0:a7a:9f0f:ab2b with SMTP id a640c23a62f3a-a8392954042mr672941966b.32.1724073742619;
        Mon, 19 Aug 2024 06:22:22 -0700 (PDT)
Received: from [100.81.188.195] (ipb218f908.dynamic.kabel-deutschland.de. [178.24.249.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfac5sm629789466b.80.2024.08.19.06.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 06:22:22 -0700 (PDT)
Message-ID: <3995846d-39a1-41c9-9544-b74d9dd50a6c@redhat.com>
Date: Mon, 19 Aug 2024 15:22:19 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
To: Barry Song <21cnbao@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org,
 linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com,
 hch@infradead.org, iamjoonsoo.kim@lge.com, mhocko@suse.com,
 penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
 torvalds@linux-foundation.org, urezki@gmail.com, v-songbaohua@oppo.com,
 vbabka@suse.cz, virtualization@lists.linux.dev,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>,
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
 <20240819124924.GA7642@lst.de>
 <a31af580-f420-4b34-8945-0269914a901b@redhat.com>
 <CAGsJ_4z-5ypPGoG6JDwRZGDt5Dby9r1tvh-txFdnkhQaKq8zGA@mail.gmail.com>
 <9f4fa8cf-df02-463d-9715-087a7cd6fc88@redhat.com>
 <CAGsJ_4yYEP6t+e=Q-Vr68S9Rgy=bdqLp34N_Gt_3_fSdNcGCvQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4yYEP6t+e=Q-Vr68S9Rgy=bdqLp34N_Gt_3_fSdNcGCvQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.08.24 15:19, Barry Song wrote:
> On Tue, Aug 20, 2024 at 1:10 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 19.08.24 15:05, Barry Song wrote:
>>> On Tue, Aug 20, 2024 at 12:51 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 19.08.24 14:49, Christoph Hellwig wrote:
>>>>> On Mon, Aug 19, 2024 at 02:33:06PM +0200, David Hildenbrand wrote:
>>>>>> It should all be caught during testing either way. And if some OOT module
>>>>>> does something nasty, that's not our responsibility.
>>>>>>
>>>>>> BUG_ON is not a way to write assertions into the code.
>>>>>
>>>>> So you'd rather create exploits than crashing on a fundamental API
>>>>> violation?  That's exactly what the series is trying to fix.
>>>>
>>>> I'd rather have a sane API that doesn't even allow this level of
>>>> flexibility with NOFAIL.
>>>
>>> yes, i have already sent a RFC enforcing direct_reclamation:
>>> https://www.spinics.net/lists/linux-mm/msg394659.html
>>>
>>> somehow, it is not ready yet. i think Christoph prefers scope
>>> api rather than GFP_NOFAIL which definitely has
>>> __GFP_DIRECT_RECLAIM set. I guess you know I have
>>> at least  5 series running, so it will happen soon though.
>>
>> That really sounds like the right thing to do, at least with the "direct
>> reclaim" problem ...
>>
>>>
>>>>
>>>> But probably I'm missing more details here why this all has to be so
>>>> complicated ;)
>>>
>>> enforcing direct_reclamation is right and will work for a reasonable size.
>>> but for this overflow size, even if we enforce direct_reclamation
>>> in GFP_NOFAIL, we are still failing.
>>
>> Right, someone requested something completely impossible. It's harder to
>> do something here that doesn't return NULL. Except WARN_ON_ONCE() and
>> loop for all infinity.
> 
> Returning NULL can introduce security vulnerabilities. While I’m not a hacker,
> it’s hard to predict how they might exploit this. If we want to avoid using
> BUG_ON, an alternative approach could be as follows:
> 
> while(gfp & __GFP_NOFAIL) some_cpu_relaxed_job;    ?

At least for the "allocate something impossible in size", retrying 
forever makes *some* sense (with a warning, of course). We would retry 
until it works for sizes that are possible.

For the other case, we should just make __GFP_NOFAIL imply whatever is 
currently a "must". Returning NULL here is indeed strange.

-- 
Cheers,

David / dhildenb

