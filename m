Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E71114EC7D
	for <virtualization@lists.linux.dev>; Mon,  2 Sep 2024 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262494; cv=none; b=rTYl6flEeeFCt5E5rKXME1KtasbLlv2EQpHe8AsgFGRDJTLPgFWKvqYdlAyCrnm+MfliqlSndmAUi1W1xS7XOiryBWIW0zEtbYE9UNZbbTdMR+uZha8dY5BINQKdh5WV0mJCM9qmnWMKXwvrHRAuYp4d9F71ZhHI0xnXRhQKnmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262494; c=relaxed/simple;
	bh=Vz32VeYBMiFxhE7zA9P/AdYAwsQR8rtbL2GLLMxjaFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZzYajK/3uS22cnf8OMykHXRs2+bGkIo4wa5tFCUCdle2i8vDiSzLxlumu1FwarN39XtmEpUARd4foPtLM4NjC9cMkfFxby1uyYZ1NQjVLsin6HrpfVC3pOBXfntjrtU/km2jXMlLN26TzaaBV92yZuL5tna6qaQMoQsDS/hd/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDh6He24; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDh6He24"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725262491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0bIolMxRndqsyO/guw3WDJdhsYGZA5z9MoL0tLTnhIo=;
	b=eDh6He24nO75CQ/RsZ9rxXgsYTDDknsZuAPb5CSyH9gkocwRzhZ+SE+zxS9T/GE/j0aExe
	5oZdIMaSllqI0yoskEZKxDRtw+UIhZIzjs/1Ij3tyEO9AHEkwduNbncPqI4ZxtUsW5NQNT
	3BCBhO6uZX2AVOPPqmJndnkEOrlZUqA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-fzJaTSiGOcWa4g3kKk9iIg-1; Mon, 02 Sep 2024 03:34:50 -0400
X-MC-Unique: fzJaTSiGOcWa4g3kKk9iIg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374c90d24e3so708804f8f.0
        for <virtualization@lists.linux.dev>; Mon, 02 Sep 2024 00:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725262489; x=1725867289;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0bIolMxRndqsyO/guw3WDJdhsYGZA5z9MoL0tLTnhIo=;
        b=f8GHa60uH7h+RhZi800RujhDoKpF9HG1RZKqUaY8/0HAKrXSmfKYF+KY/YH8mlAHjB
         yrzbXhg7sjBpQ97KSgperE6i7Xpo3qRnWqwTZ7gF1wcQ49RsdtHpOkA9PP84q2Xniiae
         8R8Ff3/c+6cIkvi8pSRWkJOeCtKQTDdIDw6u4hMLo5OfziP1/Gs26vGQfdAZGORf0rWA
         5yw+n1z9Dj6ACvCEQ/Wo7thRbiQoq68fXam2NitwGXi4okx4a2r5ONI7jdARcZ4WKLJ9
         lMv8yaV2f1TTV5oftXzruFzmPYJfNupLlkHaHG8xVA5fVHadwaoYju2XEffcXxpsCEgF
         qeYA==
X-Forwarded-Encrypted: i=1; AJvYcCViXS3vci1f8i4ZbBwjpCd3iKwHkf1pnLOOOVBVEJbl1sdMW89LyBpkvyo9ENoi1OkJ5I8R7sWwza9+6JN0rg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yywh41MniDtKpgkw/xrhoCSxm2YlWHbV9koKcTOoK0nbwTGZiin
	SiqdrAOrp3R0R9Pekj1rsnqCD+TE1ructWAwYAKe4a5OSbZgn+waKe6aQuXmfnn0iWq8Hm7jDT3
	RkAVyR54O/Tsg8EJIGcLovvEF96ynFeN323O+4xwDcWTJEzoZQq0ct0gYTcmtAOSg
X-Received: by 2002:adf:f892:0:b0:374:c64d:536a with SMTP id ffacd0b85a97d-374c64d543emr2664767f8f.27.1725262488917;
        Mon, 02 Sep 2024 00:34:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3cIKk6MeL/umQ01MQpGLwfX7XhCjaXfQf7ZwqKYRZQgE3Tttjqj0GuxbMVZPg5oas7Ww5fQ==
X-Received: by 2002:adf:f892:0:b0:374:c64d:536a with SMTP id ffacd0b85a97d-374c64d543emr2664720f8f.27.1725262488027;
        Mon, 02 Sep 2024 00:34:48 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989221c2fsm523185966b.197.2024.09.02.00.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 00:34:47 -0700 (PDT)
Message-ID: <a4af4b8f-1f32-4558-9335-b5def75cc35d@redhat.com>
Date: Mon, 2 Sep 2024 09:34:46 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] mm: document __GFP_NOFAIL must be blockable
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com,
 hch@infradead.org, iamjoonsoo.kim@lge.com, mhocko@suse.com,
 penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
 torvalds@linux-foundation.org, urezki@gmail.com, v-songbaohua@oppo.com,
 vbabka@suse.cz, laoar.shao@gmail.com, Christoph Hellwig <hch@lst.de>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20240830202823.21478-1-21cnbao@gmail.com>
 <20240830202823.21478-3-21cnbao@gmail.com>
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
In-Reply-To: <20240830202823.21478-3-21cnbao@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30.08.24 22:28, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Non-blocking allocation with __GFP_NOFAIL is not supported and may still
> result in NULL pointers (if we don't return NULL, we result in busy-loop
> within non-sleepable contexts):
> 
> static inline struct page *
> __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> 						struct alloc_context *ac)
> {
> 	...
> 	/*
> 	 * Make sure that __GFP_NOFAIL request doesn't leak out and make sure
> 	 * we always retry
> 	 */
> 	if (gfp_mask & __GFP_NOFAIL) {
> 		/*
> 		 * All existing users of the __GFP_NOFAIL are blockable, so warn
> 		 * of any new users that actually require GFP_NOWAIT
> 		 */
> 		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> 			goto fail;
> 		...
> 	}
> 	...
> fail:
> 	warn_alloc(gfp_mask, ac->nodemask,
> 			"page allocation failure: order:%u", order);
> got_pg:
> 	return page;
> }
> 
> Highlight this in the documentation of __GFP_NOFAIL so that non-mm
> subsystems can reject any illegal usage of __GFP_NOFAIL with GFP_ATOMIC,
> GFP_NOWAIT, etc.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: "Eugenio Pérez" <eperezma@redhat.com>
> Cc: Hailong.Liu <hailong.liu@oppo.com>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

