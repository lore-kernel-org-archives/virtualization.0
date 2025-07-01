Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4582274FCB
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372666; cv=none; b=Cpl+tJEf+tT2lDuvFe0EEfzJGaaOt+fIh3i/7ORni9JZR24dCLdx10G2YZiVcPpV4xU2K+990gWH/29kfJLpzKHHPxDFgyEwS9ToJF22I7Vp3rt7b+usV/4VFLxToDNIaI06/Lj2r6mk6toxHgl2GOTgjOM50qlmRIEfrwYCRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372666; c=relaxed/simple;
	bh=mJDe2P2PEm8RQgbD+K+iqN6Z01/60G9GraL4XRuTDXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lifv8r1ULP0LbD2soH72C2w8CN2Gkbx9DNwk/NChAIREFnQforsqr0ubjLxE3LvvP5ZbMNyKl4SqvzcS5GUwzo90YxqCWXeUPg1SJodmkLpvlcuGuLOvAudVmbdbzLUTnjpBtAvD7U7Mv/IyQ0uqr+HlzI9v2hxMvluUBYqXU8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cSspd3/1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSspd3/1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751372663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5dMJcBXdQ77pxzaJeebTFi4ceGva0cqGC9EQBAzQ3z4=;
	b=cSspd3/1v+9jmlWwADDMDYebO5uuIT1H51iqtDTSGDR2RfmvzBgMxWxznf1PJ8V0An9FG3
	0KBtqcCLOJnfjcXDquYwoiiwH2Iaoslb7LvOh8BXWjDmzUU7mE/jtN6lrHORUHr06Ppqe2
	9gbVc+4047YiF4tAPBDXW3Z1aNX15a4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-YqDQmo37N26iSL1Mnd0L3g-1; Tue, 01 Jul 2025 08:24:22 -0400
X-MC-Unique: YqDQmo37N26iSL1Mnd0L3g-1
X-Mimecast-MFC-AGG-ID: YqDQmo37N26iSL1Mnd0L3g_1751372661
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-453817323afso33537265e9.1
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 05:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751372661; x=1751977461;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5dMJcBXdQ77pxzaJeebTFi4ceGva0cqGC9EQBAzQ3z4=;
        b=d2xWHizvL5Ngi5+5pTKIe78OljbQPyB0KrHgvQfgn8I15IeoPEMPyyo+m+k2bx+yVr
         mSviwmI2qnQ40Kq0plGj4HDJVTflS2F85+cIeZMLh1TEN99FXqGJS95ije3n7U1oZaTv
         7Sq2FEfNvXqakyQV96iCNcdKJt0KQEaTDgxF9MdadxvFaENntaQdG+ObQrWEC8cKBMAw
         rBcbnGqGx1WHk/7i+19b6Xh8kNQ8mOLxrX6EOr7jBjzQgY6B9etSeQ1IG0G4Oqy2jOve
         e/rFx+QBhwjHm/tVKGBEb4ZX1nYkgGVg8f8BMk3O8ajzGEbq9RLuDNcFjDEadagd0L7X
         CXhw==
X-Forwarded-Encrypted: i=1; AJvYcCXk186o3+v6Qjo3uWm/0BScZl9L5/qYjIhRmpsVjT1nkY8ht5VwMq1vtMwnedZtPloUskULqfhPkaqI0Zl0hA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZ354Mme+YpoIMLZFuIb42w7+uvxc7N7LKU5nPP4Cor6WPxFbP
	5DU2yM16+PUq58xA6BgYFH6OjXv4Vg6oa3ulPkCA97Fwif9cPp60OcvEB2/l6X/l0oLppvfieWM
	fCb87Q+eS95PIWvqITtT5rlheCnZ2iKxuosmJny1/hDAdZgeSTpVqGI9ulmBzGkk1fF6M
X-Gm-Gg: ASbGncuUVVdk/f1uIS/m+O6h7Cbz1r5COxnu3sQNIF2L/rPDVbgoSYstKLDtBhE1/kt
	rc8E93+nSo/p+V6bfySJInsFjR52cKL2s3n813TKRDuaoq2ShzBbdUYCCkKUBZgvutle0CTK+jj
	6iSQpnS0QdcQBeynP58V3885Uz8U5V+0nY508yVcyLGUW+0wdNJTJco+0mb9wTD+4ofLkt6MMNR
	gwRQ1VHJB7eyRi5QRVmzmXUPy8Sc6nGX6QFO7i83TBcGQ+RKqfQlLqtr7CzhKydV/V5opE/Lqfd
	V1U/Y5EEJXcwZkyna+WLfeobx0gSzW7Bj4/tLhYrwv1PeviTHKngpzaCehX/+LnRh+/VylxShej
	spdGnPqeOwRrxbqt4j38doSthOZ6qVceDTF+i5xD8p/tiGOxUMA==
X-Received: by 2002:a05:600c:458b:b0:450:b9c0:c7d2 with SMTP id 5b1f17b1804b1-45391b6b96dmr142402255e9.11.1751372661134;
        Tue, 01 Jul 2025 05:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpzHsO7mLLjpgLiPRtxtYPNX8uoCOnkHlcMoEUMymXcRW48dybZJfjs9S76N4KxHcaVdQlIA==
X-Received: by 2002:a05:600c:458b:b0:450:b9c0:c7d2 with SMTP id 5b1f17b1804b1-45391b6b96dmr142401905e9.11.1751372660588;
        Tue, 01 Jul 2025 05:24:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a4213f0sm165518105e9.36.2025.07.01.05.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 05:24:19 -0700 (PDT)
Message-ID: <ec23fcb2-a1f5-4da3-a2fc-09abe317f17d@redhat.com>
Date: Tue, 1 Jul 2025 14:24:16 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/29] mm/balloon_compaction: stop using
 __ClearPageMovable()
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
 <20250630130011.330477-14-david@redhat.com>
 <65804db3-71c0-47ff-8189-6a1587d4a0cc@lucifer.local>
 <94333692-0093-4351-a081-13e202dd2322@redhat.com>
 <4d1d7aa7-15c7-4c2c-8cd7-0853dcde7940@lucifer.local>
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
In-Reply-To: <4d1d7aa7-15c7-4c2c-8cd7-0853dcde7940@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wp9hyO-NYvtwzZAwZG8pfHurZxlvT4cJW-UbrniYiEc_1751372661
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> OK I guess this is fine... :)
> 
> An aside, unrelated tot his series: it'd be nice to use 'deflate' consistently
> in this code. We do __count_vm_event(BALLOON_DEFLATE) in
> balloon_page_list_dequeue() but say 'deflate' nowhere else... well before this
> patch :)

Right, dequeue is actually deflate, because one couldn't use that 
function for anything else as it stands.

TODO list ... :)

-- 
Cheers,

David / dhildenb

