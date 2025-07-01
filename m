Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077627587E
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372734; cv=none; b=KlemMNQ29MY815ryfhXrBVGs8jbrkD43VKPByMcft+gsboR0qHthNB6hpYExIyaewH6YMAoa8I8g0aNXhtS1haJqdvNNGlwDVtpntCfsk3X2qAsj1YUA5kNlHz9HAndaRmGS3qSoZkQmpQC3hbOp6V7lVkvDQ6EdKEwQxdvaBB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372734; c=relaxed/simple;
	bh=z/CCrJhSfJ+0N7wRoqbjcqIKdxPJ8urhIm9XK/idS34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgauAgYQUAA/8NfBQHKlKil5LPmX0tvJa3CrXlzcz/RSAqWQkYU0YGx5VSOqLqNpjNVdJmYR5PW2QBxxj+J82qK5LTBpcF27p0frA/hR4dW6M09tCd89UClCcdTl+HNxWxoAoZLYMc9S2K2Y0QQD7PxYc8cT3aRxRKlyUS1uZI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVLmhLt2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVLmhLt2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751372731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tj8pB/rMHLZ+6PtFNz+xS6WiL3VVVwDceOqfATE3uy4=;
	b=GVLmhLt2ND81pJwEeduRSxyYVT/62meUT3WJudyzuE7ts6SoiwqeN32Wre7bF8xXalPD+f
	IaQGKTDLRBhNKE1O6v1yMOg+QVCKmgk0H4JdCQaPbtIuhZA8qDs95GN+a3Kept5ZOxZtHI
	z6Ftgl61sPRaveDk3rJbB4CCtQ7PMtA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-hy3HWGFVPnyO67CHkO5ajA-1; Tue, 01 Jul 2025 08:25:29 -0400
X-MC-Unique: hy3HWGFVPnyO67CHkO5ajA-1
X-Mimecast-MFC-AGG-ID: hy3HWGFVPnyO67CHkO5ajA_1751372727
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45359bfe631so26802635e9.0
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 05:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751372726; x=1751977526;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tj8pB/rMHLZ+6PtFNz+xS6WiL3VVVwDceOqfATE3uy4=;
        b=HCAsplAeOv4oblZ1ITLqGSm/1k9iYNMEtS/VWX77NAPXB+zh6Kcqm7xzvZuYJOp7BL
         gG7CYf21bE9nMYXeKYzsv+DexC2Cck8x9mdmDTPMImwKHDxhnta8wznB8N6t7WP3eNW4
         zbP0Y/pJ1cztJmFYuXA9FmiQ9NFhAD8T0GMKP1gj5lix7DBubnrCTqzJoeJ3ANBbPyqM
         R+As1gL5ZugfH9sOThl3iN1sEGj76Be9yXRETeRocOfcpIqrYz8XznGxe22bte52yqjM
         zij5ESSCCtwsfDhqFcdet5Ha4C05ic+k2RhanQ6yYUsQHpUb19jRKtcoTRb7oPvzROYh
         eSKg==
X-Forwarded-Encrypted: i=1; AJvYcCVclheaCrBYo2BlIRBKxQQt4E+1548sFvnaI70KaufEVes9f7hZUwx8gQiwq/02bCe9rKzzFZn9zfQcUCNYGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEVIL/wAUBg42k0XQq1ta/9pGmdjE+GE5PqocEp289c020ygwa
	JELOCf5YjhKFBt/Yd9m1VjD+2F7oJ0+8E/dFqX+kCGN4nya2bsSd8fFmzkbad/jVV38SH9Y4HnG
	/zs1Xdh92I4wrr1DiZbdTvMe3HUZXvmIIUPPnI4XIBmXXyzWFo0TFWwnQrF74wOYqh6le
X-Gm-Gg: ASbGncuezff59yMamlDD/D67mnKvhEkHcmSvIPPenrOfVRdBAIMBuwMstcSvbg0QFec
	5R9SaOwv5TTIaujEoSoWgjSGl0efFkuynaNo9fj2SMx2oOC8ODCpxMEQQLu6SFzWajlItDzmgIH
	s3PbDbdQEDCo4RA2AH+IKduMAv2U33koGEJYt+7wN2Izzb3dJilmB0FvCRgZ62JTI/pPtm5/mzx
	MRR3ZfpiB939V6HG8i8aJkVHX9KUniZnCnQHAa4XcZx/SNtSzqR8WqHxcekVO+0NWmK8lCgbzrP
	aO50MrGc4OLM997Y0tWXgikv5BqTix2XUUovJ1yRYkuCbiFtjYgbgFWZ6GqpTb9G5jvWkmnVNjW
	vDzw4wv8gP4Pq74fcbOQSDQYve64lcrn7V24jFPNH7wuMY5vMIQ==
X-Received: by 2002:a05:600c:198a:b0:442:ccf9:e6f2 with SMTP id 5b1f17b1804b1-4538ee7df15mr201513325e9.16.1751372726394;
        Tue, 01 Jul 2025 05:25:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtxNR73SFMqIoSFe5cIm5GNMerZkIb6R08bnmv81T1e6WZOFEwjwh+c20OjBL0zx8GNPpXsA==
X-Received: by 2002:a05:600c:198a:b0:442:ccf9:e6f2 with SMTP id 5b1f17b1804b1-4538ee7df15mr201512785e9.16.1751372725799;
        Tue, 01 Jul 2025 05:25:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a43325asm162371015e9.16.2025.07.01.05.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 05:25:25 -0700 (PDT)
Message-ID: <e29af2bf-34c7-4d26-a5d7-f061d2642bd5@redhat.com>
Date: Tue, 1 Jul 2025 14:25:22 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/29] mm/migrate: remove __ClearPageMovable()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin
 <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-15-david@redhat.com>
 <24d2b984-857d-4a11-b016-dc0227d81c88@lucifer.local>
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
In-Reply-To: <24d2b984-857d-4a11-b016-dc0227d81c88@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QTjhrPdKSPGryc8D2h_XeDRro6TGxLOi8BkUPztV5SM_1751372727
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.07.25 12:43, Lorenzo Stoakes wrote:
> On Mon, Jun 30, 2025 at 02:59:55PM +0200, David Hildenbrand wrote:
>> Unused, let's remove it.
>>
>> The Chinese docs in Documentation/translations/zh_CN/mm/page_migration.rst
>> still mention it, but that whole docs is destined to get outdated and
>> updated by somebody that actually speaks that language.
> 
> Yeah I've noticed these getting out of sync before, perhaps somebody fluent in
> Simplified Chinese can assist at some point :) mine is rather rusty...

I already saw doc updates for this. Obviously, I can't review them in 
any way, but people seem to be active updating them.

-- 
Cheers,

David / dhildenb

