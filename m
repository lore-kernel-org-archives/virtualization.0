Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3CD1865E2
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319768; cv=none; b=g0I92PJL66lIFluLvcuZsbXWO1W1kJ8/E9JgUoy4Sg8SYhOPHy+xc5CxwRmxjWjLuWb27YGhwO9tjR8IYt6fTXpCTEDQbQSjRiOT+iKdRqDgfoapjXXfRYDhhjPZZ+bMTYbtZaEfAAK8TOqHrxOnqXHvQuzOswv4erO7xCrHHdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319768; c=relaxed/simple;
	bh=EfUCXI4QqItHRHCk21g1cMlJJ/7k9QpRFSgWXW6C4AY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OZKzi02mNQDidgq17dU/nzMffiuht+iXN1sJJMyUIhIRbV5waK6+adIsu8+gfHXILZ3HfthbqqLdDrbK+8cj31eJiBKm7sY0UjMHn/tIKpW3DsPaNi9xajLhi9+bHh7rrehgJCrPw0nsmT2Hy5tS+c1fezu1LGvxQRknYVCj4bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gu5k0sfj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gu5k0sfj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724319766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ezYgJew7iLeyr2ng5Qwj2f8wzE1ie+8eKwPQ1ave84g=;
	b=Gu5k0sfjJ+prFgIAR2NVpMtV6hhPN5SXH5qE7T2J6VrosZ/xgKm6y7e/pd8514CmZYsJ5y
	zmK/vHw8m5ifSAvE6uaYegeEdjFeldLK29AxWLehxRbTETp4Xhg/G6rRHB6xsCSPF8mw3U
	HMIRjXegubOx4vbesK/QFRnhwyNa2jk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-XtlnkXFLM4S3uVFn1oio3A-1; Thu, 22 Aug 2024 05:42:44 -0400
X-MC-Unique: XtlnkXFLM4S3uVFn1oio3A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3718e6956bfso340290f8f.2
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724319763; x=1724924563;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ezYgJew7iLeyr2ng5Qwj2f8wzE1ie+8eKwPQ1ave84g=;
        b=RBopQfQ+Nr0uaTIwI+ZfWd4m3kKA5dEXRVTAmhUxV9jGWUD7z6Iwuv7Wz40BeZmwV0
         VLeTHWY79vjSs1BlOfHcGYmR3g9LthQQsGySzMoFLPPhInkewdR5Yko7StYxRidgFFdV
         bnoqxzA040DV39u2WghTy2xIWqrtFT87oTyETnWUC01OGZPn7ofing++MYGfWDLkgqWr
         SZArfgsLYlJ6uod3d4UGL4mZut/GikdOWY75EmhngLRS+OeZSohlmCMrw/q3LrrJU8p4
         xjf+6g2lWYb60vxUGFte0cP5z/XEFyDda/gV8qaaFKBpr/xvI5Z95fluXj8C9z0tuILy
         bkqg==
X-Forwarded-Encrypted: i=1; AJvYcCW4WIdJpMOTWLYsWMoymDTFd5KxEpylr7efYG8KSrjsKBK+hRnMCoBxlS/DeWfJzuqardGhZx7gqmsjc6emcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdkAMK6lufFnyzV2+WDloV51txI60klVrvZWDzQUvJj07723Gs
	CcElE5u/N5Le8bgUFbLBatY4f/Tj36jD9uHriG7m+Zvx5hALaHuTDhqNPArZKc+LOLk27h70Vvb
	zloi6Q5rzx5N7SPsurubLMUc4ZtF+YxxtsQzR/eYYWmve3tLcOe7+wjFBoAFnex3j
X-Received: by 2002:adf:e88a:0:b0:371:8ebc:a2 with SMTP id ffacd0b85a97d-372fd592c12mr3407538f8f.21.1724319762688;
        Thu, 22 Aug 2024 02:42:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU9Plolnns43ZDtWVZ6t3+6h/EBBhWvM0zID2DYtKI8eTDlOKNZOQR1e2EdkP/GIsOoL1i6A==
X-Received: by 2002:adf:e88a:0:b0:371:8ebc:a2 with SMTP id ffacd0b85a97d-372fd592c12mr3407511f8f.21.1724319761863;
        Thu, 22 Aug 2024 02:42:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70f:2b00:f928:47d8:c9be:9d87? (p200300cbc70f2b00f92847d8c9be9d87.dip0.t-ipconnect.de. [2003:cb:c70f:2b00:f928:47d8:c9be:9d87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730815b7eesm1229871f8f.54.2024.08.22.02.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 02:42:41 -0700 (PDT)
Message-ID: <e68a5584-b967-4327-b9e4-c365dc017c33@redhat.com>
Date: Thu, 22 Aug 2024 11:42:39 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Michal Hocko <mhocko@suse.com>
Cc: Barry Song <21cnbao@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com,
 hch@infradead.org, iamjoonsoo.kim@lge.com, penberg@kernel.org,
 rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com,
 v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev
References: <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka>
 <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
 <ZsbtGClLMtaeakdo@tiehlicka>
 <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>
 <Zsb1rM-azd_0gFzg@tiehlicka>
 <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
 <ZscAtVskxgONe3gT@tiehlicka>
 <59e90825-4efa-4384-8286-06c0235304dc@redhat.com>
 <ZscHw1Zkcnx3VWvG@tiehlicka>
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
In-Reply-To: <ZscHw1Zkcnx3VWvG@tiehlicka>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.24 11:41, Michal Hocko wrote:
> On Thu 22-08-24 11:27:25, David Hildenbrand wrote:
> [...]
>> Likely, checkpatch should be updated to warn on any new NOFAIL usage.
> 
> What do you expect people to do? I do not see a pattern of nilly-willy
> use of the flag (we have less than 200 in the kernel outside of mm,
> compare that to 40k GFP_KERNEL allocations). If you warn and the only
> answer is shrug and go on then this serves no purpose.

Like the BUG_ON checks I added. Some people still try to ignore them and 
we end up in discussions like this when I spot it ;)

-- 
Cheers,

David / dhildenb

