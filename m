Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A117B30B505
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122547; cv=none; b=Mv1eMPLdbSr75TeP4z5tcNUzdrEAeBElFtv3IEj8RXxGgkfYw+UlNbZmS067TqvWbfsg+a2gd3MZsQfz5ZxtfYMC4ux0uT4UEQv5OEpTkDmgA0RETOvLccP3cZtl2RAqmaE0NkNHSmpCj4q5Jl7G95psMWYHqZPeKbwkR1aBfzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122547; c=relaxed/simple;
	bh=i405juTC47mjP/L3x0j2N8/piwVkCo4vW1GsuT9SCQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlv5a5E7N7KU/0l5D2Ob3fFbVAi+baJK+ALP+aMHDAQP+5r6L2Trw5nKdydUfRa0z0CJf/FYTi+a4gUDUYzPv1ldpxsGr8B4/QV422OrG8zkleeVG5kFF32R+NuRIKUTDREbpCBABQb2WQDZwAau28t41/C0tc6flRZnwb3N8Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LGa65hOx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGa65hOx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761122544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X+Qc4y5CsxpArpC14yIHodoUnQoI1Il2pOClkv+r5DE=;
	b=LGa65hOxrBsHdYXYQF5VwH8CGbmqMG+zUkGJqn84tu7kH4J7Yzv7HpbuPGHneLeGwcBBmd
	Qa46nmrPgXzzOa54sQnuX8y8/rv00rQAyWa4xewvUvNJuwNSYdwLC5SXiniag602vwEKzt
	CBUfU1+r/3wmySt+deMgulFS4zGByyk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-KuL9ewF-Mu6PGspWib3k-w-1; Wed, 22 Oct 2025 04:42:21 -0400
X-MC-Unique: KuL9ewF-Mu6PGspWib3k-w-1
X-Mimecast-MFC-AGG-ID: KuL9ewF-Mu6PGspWib3k-w_1761122540
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42814749a6fso2252866f8f.2
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 01:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761122540; x=1761727340;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+Qc4y5CsxpArpC14yIHodoUnQoI1Il2pOClkv+r5DE=;
        b=nj+ceQLh0L6t/0jhdJh5hY12M45EnR3C6uWLCmP0BCkew6Mu9ncqWezfrH7+3liCku
         DScnBownuPfJKcHi8p2giRQN0Opdx6OckvvZJ24cWpVmIKgsDof0vsdWHLSOgAitatJd
         XGz2nGfCE5vY8ow3urLHhJhQiyfnDWQ6Ku7WwZKzgPYjP162zUOwGwsjCc13Bn6B2orj
         JNPCJilepaaXPKxBYhJyGE/oEV7KJNleMjxGS9cQ+3+/F7E/dMuaMVY9k6J/CySaQ8TW
         qGmHDHD2jqjRroEd9xbaFBL0JFrHD0vNJKWMeD5bL1hoYZr3/R4xDR7Io1uJBOC1Me+v
         spmg==
X-Forwarded-Encrypted: i=1; AJvYcCVuEd37HyyfHflLmgAve3E56WGmFH7Pf3L+SeoZW8bfI4EGuqsAar+Awp0UQmLRZH4X8OgqcmfP7XWnYmY8QQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRAzj+aMjwLWoDOiPrOE+gkb5kjfByxQLKeiVgy8o44zTUQ09/
	rEHDjtZWZeW34CJ/+jvRtsmtXQ2rVC9VO9MzSNmyfmZE6f8BuuyJwJ06x4U0O6L4IgdZ/e5I3jh
	4H/4UsUi02iiQNLpInU6+zUI1Q+xTaBcG3vEenjjyfpf7rEalg3UhsCJdw7f8yosJnBQU
X-Gm-Gg: ASbGncvCpAbl5ADEeExzY2vituDCDGc04cXUfr3lYgdsuvgrvfuMNM1kUv0MkFKPR6Z
	9v/FsPJAalPT9/exmqCYLUZwEB+zZ1D2eOHvAoqoOdlKokWKt7/Hr/c4zxxaxISjIWYP+O5stmv
	8iviiFErMkv89K0UUQI7YI6SLKlLl+tW+ylyTYBsnGiVDNBcAV7/pfPP2VnAIO/kkaJkYgCNhcI
	RFWOSu9a6ySTxBDO/KKvT1HiWO6OPjVAksR5Ct1L+QUM4BMVf+ayetMVMTEyQtSaFJ1npE7tybR
	aIW8zBvQ357suEEOwsOzC2cQee8/5ASPatI2h6zZIIK/KY8RHelL0maczBALjo+bBgdDC8q2P47
	YFsRKZ8DIZO0r4dtSOTeOZ6mkJwM7y/D+k4XZdKGmj5scckuwEIoqpO+hHNyxmCZPN+ynRVoMrQ
	qeCkwlEfytVC/H/OR6kyEEJ+JbmW4=
X-Received: by 2002:a05:6000:4287:b0:425:7c32:d969 with SMTP id ffacd0b85a97d-42704d145admr13984350f8f.5.1761122540025;
        Wed, 22 Oct 2025 01:42:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMg9OoxIiF4uh2VUtESc9U54hkw2hijV7jLg75IGaXBj5fTyoFRtMVmXdqz1BIz6FYs6UDtw==
X-Received: by 2002:a05:6000:4287:b0:425:7c32:d969 with SMTP id ffacd0b85a97d-42704d145admr13984317f8f.5.1761122539618;
        Wed, 22 Oct 2025 01:42:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f19sm24212592f8f.9.2025.10.22.01.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 01:42:19 -0700 (PDT)
Message-ID: <ce26f59c-8938-4896-aaf9-ed94723466eb@redhat.com>
Date: Wed, 22 Oct 2025 10:42:17 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/23] mm/balloon_compaction: use a device-independent
 balloon (list) lock
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-doc@vger.kernel.org,
 virtualization@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, Zi Yan <ziy@nvidia.com>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021125929.377194-8-david@redhat.com>
 <20251021165040-mutt-send-email-mst@kernel.org>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20251021165040-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 05Nq-6rp-oVNyaudsok-yNvxTLxc88UgBAbRGqMvutU_1761122540
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.25 22:52, Michael S. Tsirkin wrote:
> On Tue, Oct 21, 2025 at 02:59:12PM +0200, David Hildenbrand wrote:
>> In order to remove the dependency on the page lock for balloon
>> pages, we need a lock that is independent of the page.
>>
>> It's crucial that we can handle the scenario where balloon deflation
>> (clearing page->private) can race with page isolation (using
>> page->private to obtain the balloon_dev_info where the lock currently
>> resides).
>>
>> The current lock in balloon_dev_info is therefore not suitable.
>>
>> Fortunately, we never really have more than a single balloon device
>> per VM, so we can just keep it simple and use a static lock to protect
>> all balloon devices.
>>
>> Based on this change we will remove the dependency on the page lock
>> next.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/linux/balloon_compaction.h |  6 ++---
>>   mm/balloon_compaction.c            | 36 +++++++++++++++++-------------
>>   2 files changed, 23 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
>> index 3109d3c43d306..e2d9eb40e1fbb 100644
>> --- a/include/linux/balloon_compaction.h
>> +++ b/include/linux/balloon_compaction.h
>> @@ -21,10 +21,10 @@
>>    *   i. Setting the PG_movable_ops flag and page->private with the following
>>    *	lock order
>>    *	    +-page_lock(page);
>> - *	      +--spin_lock_irq(&b_dev_info->pages_lock);
>> + *	      +--spin_lock_irq(&balloon_pages_lock);
>>    *
>>    *  ii. isolation or dequeueing procedure must remove the page from balloon
>> - *      device page list under b_dev_info->pages_lock.
>> + *      device page list under &balloon_pages_lock
> 
> Using &balloon_pages_lock with an & is kinda weird here.

Indeed, fixed, thanks!

-- 
Cheers

David / dhildenb

