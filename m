Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D62701A1
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363970; cv=none; b=kAITP/mNT/+CiEeg8yXUTF6ypYTg1ei11mNQoBuOaRRF5A0ZST6v0+1XHKp8oekxALq98wNZeAD31OvLWgU4rZ85SDc/2hxSuQ615puGI7wiXqwXt1wPTYyP/JCrSe8AevRH0wXG/xckQMhWghQImmaP8MBrLU5na/ebRlYJJNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363970; c=relaxed/simple;
	bh=CZbTsPgBVdn4bO8eTvEKO98v/qxoHiPrOp0BaetB2HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXYb7n8woDK0cDYDfrp2Mqn9e3D9tg+iw3DZJa3kgoi09Iir2FEhUwA9HqR0xbpuS1b6UhcrLDmxHSOe5mCgUKLu6ok665fvF2Aowi9cbdFtCtTRxrCZEHnC6drKj9VQqhe4YFn7pbD9v8Er2a8tY1F/EMz7AwvBV9lxF2o3H6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BEJX9QUT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEJX9QUT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751363968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s5FbtO3errtBpeKUR76CZ44Npcbx4IGE5AODLlZshxc=;
	b=BEJX9QUT1xmIXLPC5jF8cW8u+I5RhaXxpIz/5x7Ii+6Q3MSZv8rfu8uohB4MmMM4LktBh2
	dTsBfAEQehGE1P0Mt35pc5xtxQRjq9nKzkMw7Gxs0ZI7113j0yU4V9Q58GB8vK4pcWNJHj
	19Reh2oN1+MCOQ9NxQ92DzC+cRMD41k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-SHEd-JYYOOSkSu-tJCWaLw-1; Tue, 01 Jul 2025 05:59:25 -0400
X-MC-Unique: SHEd-JYYOOSkSu-tJCWaLw-1
X-Mimecast-MFC-AGG-ID: SHEd-JYYOOSkSu-tJCWaLw_1751363964
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45320bfc18dso27235105e9.1
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 02:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751363964; x=1751968764;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s5FbtO3errtBpeKUR76CZ44Npcbx4IGE5AODLlZshxc=;
        b=o0eriwwqnpP0+yrthGmIX/I2LTO2DrpkHlqE1GBG/EObtB/yppdxLFVsSdzPsn5R7R
         VyIetlLHF6bol1cJmTxvL2DGH8FxbZAJhncFrI5jYubLKFT8WEsWGozZRqUUq6WFR8uC
         IKaH9oCxXH7gUCl6bbl5vI18twLMy/O6/Fthv041+EdeQmXxG0VVsUVjcu2w3nYyw94/
         pw7G9nxrolGAa/F7DKSIg0v2N37M90Si+OHE7GK0CUOt2/a0shGVsFzU73AVERU12ozr
         OjphK4tYd3SNFL+jAre8UV/fOmbk5+5zmqsyxBCXjbJPlhMcFBbLgV9IieiFgS6EfuEx
         OzQA==
X-Forwarded-Encrypted: i=1; AJvYcCVu/ixnivH1d3az0z3C1c9q6YTMrJn/kTvr0h1YfGJkIEsOFUA7q6c/ZMbLzGG7AlzYIc+cst6Gj+Od6Vd4Xg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqNLKhsIG9OZIBAB9QTgaTHo7pwA1lAD//HJ4gPWG6ZOlfuTrE
	YiKRIl067+TkrnNUFaDjKXK9lXuFMXXY+q7or++JF4KXK63uDUa/I44WsNLAE6TNPPxvDNWnQ0h
	2pYVGzTVOHQWs3JnqCak82LZ5AHri5l337jRiNkAfwD96ubwn4vmrJTFwLzeQ8CC+clZc
X-Gm-Gg: ASbGncsRg+Q42gQbUZh+vB1oeE5Z7fKpEj4N1GLElrAn6HAAsbj77/2zGLmBShNeXam
	W8Z5JN6lKYa9EL3MUFm4eHq07kSH7h2H/+hCSgEwUXgidbtlxgp+0/EHm5YL0H2CXjSSvMDUtzO
	yo4P8DvowTvuT7RfzB1gVQYd/rWGQ4ORYsBs082O75/irdTKsuWqKQm2qX2xEtISudZrIJrnrnX
	Y2i+JtBDDBj4/ruCUyjxKr/DFuA7l6WNikouM6bN2z9/I3+kTNlCPJqJDxz5kc1W7qRgwwhpVB9
	eAkLugoULzL/hupSPiWeOFaQ7opdOuMGhZLBfFbNHtPnOt/RLgOYyzCsUYUH40WamgJZzx7DLN/
	Z6ll10wAZbVV0EUVOWWXh9xBOJEGsX82TfORAxSJeDh9P+BXVZA==
X-Received: by 2002:a05:600c:46d1:b0:453:84a:e8d6 with SMTP id 5b1f17b1804b1-453a78b99f6mr28499755e9.1.1751363963610;
        Tue, 01 Jul 2025 02:59:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjLr31Z+2oCDlzuGbqPqujQfl0PqoJx+I5knwb0T0k9x67wj+nE45Xj7xMzEAJ3P+tl4wHBg==
X-Received: by 2002:a05:600c:46d1:b0:453:84a:e8d6 with SMTP id 5b1f17b1804b1-453a78b99f6mr28498875e9.1.1751363963053;
        Tue, 01 Jul 2025 02:59:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e7481sm12965847f8f.14.2025.07.01.02.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 02:59:22 -0700 (PDT)
Message-ID: <8652503b-f00e-46af-b4c0-bec60ebb15ac@redhat.com>
Date: Tue, 1 Jul 2025 11:59:20 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/29] mm/balloon_compaction: convert
 balloon_page_delete() to balloon_page_finalize()
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
 <20250630130011.330477-3-david@redhat.com>
 <f9cb1865-aa9d-409f-bce5-7051480c1a71@lucifer.local>
 <277e094d-b159-411f-940d-13b62493f6c5@redhat.com>
 <7b8a62f1-3e81-4012-8b44-219498f37152@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7b8a62f1-3e81-4012-8b44-219498f37152@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: To_Wz1yJ4xwCsGOzpybHngb4mNB88aFuu07_0sWQwGE_1751363964
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[...]

>>>> -{
>>>> -	__ClearPageOffline(page);
>>>> -	__ClearPageMovable(page);
>>>> -	set_page_private(page, 0);
>>>> -	/*
>>>> -	 * No touch page.lru field once @page has been isolated
>>>> -	 * because VM is using the field.
>>>> -	 */
>>>> -	if (!PageIsolated(page))
>>>> -		list_del(&page->lru);
>>>
>>> I don't see this check elsewhere, is it because, as per the 1/xx of this series,
>>> because by the time we do the finalize
>>
>> balloon_page_delete() was used on two paths
>>
>> 1) Removing a page from the balloon for deflation through
>> balloon_page_list_dequeue()
>>
>> 2) Removing an isolated page from the balloon for migration in the
>> per-driver migration handlers. Isolated pages were already removed from the
>> balloon list during ... isolation.
>>
>> With this change, 1) does the list_del(&page->lru) manually and 2) only
>> calls balloon_page_finalize().
>>
>> During 1) the same reasoning as in 1/xx applies: isolated pages cannot be in
>> the balloon list.
> 
> Right yeah this is what I thought, thanks!

I'll add some of that to the patch description!

-- 
Cheers,

David / dhildenb

