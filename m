Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A803F9CC
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 21:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724104656; cv=none; b=UgXokNM04nd3EI9UBqu94kPXdUViMK8q7UVTsJ+eVol5BsODWd52lph3BUCK0nlRWhJXnrV1+eKoA1e91R3F78YRw6Et2OZQZVw9RqjelniJLildixHE9/EWf5UpuynPR631iTldwe0ZXoZ+FbGNY7CRTiYKJdDhg/PqwWbs+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724104656; c=relaxed/simple;
	bh=LPfLSG3ljxJtkR6OWzsAV3p/VHgK7K2Y5Ov75CnUXYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4mldeq/r1jiY3q/JVbk1h8itW0pG8AawzacZMcBdw3kQyqnJFFcmRpOA30oKfbnBw084sJ1OmvtlhlWLZiPfUbZIIrf3dL1rz2PYwTFjRrHXcvMo25f5c8GbVfUoJO3u700EnqxGoe95JlOQJeWTUmnw4DOJ+OB1XNy8c4jTg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d7vn5/Uj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7vn5/Uj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724104654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ahQahJ0q5P22V3MHwwlFjCZcAlkFWYUOjv9tH/deXMU=;
	b=d7vn5/UjH2pgj87bPrzdx6DLRm1DhtL3NkQSUPUt4lsJd6rOe7vrdWXlsAARNPQMXDwW0Y
	7ouKUdd9qJI5/rxJRUyEznLjIDKZJoESj5CutIiKf1DrN3RI0LLUxOw5ET3x7tfDsJyW03
	HcYUPbuV/kgCuhKXE7vSpFEZjXNCcAc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-micJwJ8LMUaaNTy3u6CMRA-1; Mon, 19 Aug 2024 17:57:32 -0400
X-MC-Unique: micJwJ8LMUaaNTy3u6CMRA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4281ca9f4dbso41226035e9.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 14:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724104651; x=1724709451;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ahQahJ0q5P22V3MHwwlFjCZcAlkFWYUOjv9tH/deXMU=;
        b=BFaTdNUE+D8zhutg8Rk1j8KoQ81lthGVEQOR3Jk3YKRZwbo8vHC1qEedXywt6k8OaA
         l1sJGCg9L2Ri4iqQmEko091YElhJxrV5+V7MmEbsJk7/c9ox++E93BA6d6QqnDtY7R/Z
         fRJ9a5vfZ+y3fiohi2GZq2Tf9eU0aDOh4GcuuAFs5FFolqeJDMfamGAy+gjNNDVC9Wam
         fOgJlPN/JseBAuEP5cO1PC4IV5iRx2ROr13baZyrALTsS424SF5DFGTiVf9I/gEuGR6x
         CnfjhrGtN2cqcn2I2tXfbFplLgaZmPZHnF8h0AFkLIH++c/aX8uCzFQJ64+Sp+tYrQal
         NQrg==
X-Forwarded-Encrypted: i=1; AJvYcCXD7SJzxrGBldMcPNWJcZ+MwQqKRaAhZFWLGXkLh/1Z/CU2sNR1yz/1tZx4HfLaFoOW/PmNoow8AhEJ1gBqWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1C767mTLDzx8pMtvoYDXFpZ8Erx5Wf2joF6uEGR3LyMjjzB+d
	xxSbRruHMh8hTKV6v1Tzv27lr9BAS5QUyeW1tMFeRywwPHBBqgaPOmPMwIixpsOMjxZ91mEUdyg
	Av8K80rfDXZhTMKLsY806Hk5V4Yc1H5a54UfBZBxoaDIJpDOdCEEyKGStw6H1BWtM
X-Received: by 2002:a05:600c:56ce:b0:426:6455:f124 with SMTP id 5b1f17b1804b1-42aa7afda74mr71468345e9.0.1724104651621;
        Mon, 19 Aug 2024 14:57:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVteDNTcasqGVHSWPdhkbKQfuvUwBhxwlMI4zuYBIZmpvff+IH8m/pDdZfTYFc+HeA6R5BeQ==
X-Received: by 2002:a05:600c:56ce:b0:426:6455:f124 with SMTP id 5b1f17b1804b1-42aa7afda74mr71468285e9.0.1724104651135;
        Mon, 19 Aug 2024 14:57:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:4b00:7ba7:a109:29b8:e459? (p200300cbc7404b007ba7a10929b8e459.dip0.t-ipconnect.de. [2003:cb:c740:4b00:7ba7:a109:29b8:e459])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189849697sm11454529f8f.37.2024.08.19.14.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 14:57:30 -0700 (PDT)
Message-ID: <6814fdf6-cf32-43e9-ba20-705ec5238abe@redhat.com>
Date: Mon, 19 Aug 2024 23:57:29 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
 cl@linux.com, hailong.liu@oppo.com, hch@infradead.org,
 iamjoonsoo.kim@lge.com, penberg@kernel.org, rientjes@google.com,
 roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com,
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
 <a366907d-191f-471d-aa5a-fc8f3f88198b@redhat.com>
 <CAHk-=wgGLFV4mkNGwhpTMYrR2sVJVbnJ8RrfaHihDwtR+Z5O+Q@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAHk-=wgGLFV4mkNGwhpTMYrR2sVJVbnJ8RrfaHihDwtR+Z5O+Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.08.24 22:35, Linus Torvalds wrote:
> On Mon, 19 Aug 2024 at 13:24, David Hildenbrand <david@redhat.com> wrote:
>>
>> Right, "warn + loop forever" is one alternative where you could at least
>> keep the system alive to some degree.
> 
> Maybe. Or it might just lock up the machine.

Yes, regarding the security concerns it might be a bit better that way. 
(no security expert, so I cannot judge ...)

So, instead of saying "No, you can't have a pony, stupid", you would say 
"well, let me talk to your mother about that (WARN)" ... and just never 
reply to the real question ... :)

-- 
Cheers,

David / dhildenb

