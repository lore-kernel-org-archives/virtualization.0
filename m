Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EA0269AFB
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751357844; cv=none; b=N9ccR83GZc/J6vSWhXU6xIkV06rXT1J1gH7NFk/LId8TQLRZcLkorH2/BJtAcYUQpRzqHHbWX7Fg3zlf0rJp9nPcL/mCo9aSYJrIrNVlVelUH6uWabYhgupdctpI3SjPM1PbDW17nC14lt/m8/TtDUc4wjyURBBn8K6gsHfrj68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751357844; c=relaxed/simple;
	bh=XzvzBePiOeMuczS3zI3DfZmbDgAQbVwGs4qZ/eLDHuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfOPV8/ToDyBwh0kUj2lfsBFBoWuI2lftYsRyfPeStXDxcPm0UwHdfGTe322KnMvqu/pHeKZqnHCVpB3SP1FGZMjHiBI5cIIRJzWioAIYvqq6QJ43urghYcHakAFbeE5kMzK1GMe5jUPB4KoElNyQNrFIVM3yQxEFHXdfMvF5c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K1P8upsu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1P8upsu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751357841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K8bPxYBe4mprhdcI39oiC8vcqiTtmEpc5GUJmK2gTGs=;
	b=K1P8upsuEU5h+fsfDIIdev6Se54vFRwgRG2+aByeX5nGo/+zwYKRWYM/pwLdZjcKStmIP5
	bHgLsrDMTuVpHK0a7bZnLa4G0MiS72mlnnYzDi9dy4IQV2XVUQIsGZ6GK3dm/0Hea3UWg9
	MC9lNC/N+brRkc5FjalFzTPUQytftNU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-pGIb4kbAPzm43FChqP1exQ-1; Tue, 01 Jul 2025 04:17:18 -0400
X-MC-Unique: pGIb4kbAPzm43FChqP1exQ-1
X-Mimecast-MFC-AGG-ID: pGIb4kbAPzm43FChqP1exQ_1751357837
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so2678298f8f.2
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 01:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751357837; x=1751962637;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K8bPxYBe4mprhdcI39oiC8vcqiTtmEpc5GUJmK2gTGs=;
        b=rLWNNbaqY8hK423uBd1eKRxBxeoWYM1tzek/D8MXYmPo6vuqlaHq6c4iIwYTxAV0V5
         4DCKVbJwJH7kVMhM4aEcWnM3ybhFzUEz/IZN3aTI9Qp+4OE2Dv4Jl/rl7/a4yWBMKsmi
         vZTn8rYkmuhQOQPI5IGGta/LRKHB88Od4e4ycmOhBYEdpIwsarZ7x44Fl0kJXp5AHFKX
         ywRxOtjUaXv5TPrh8m/eFSXk6D4vG8lGsZWKCKieQEdWvnLzcnEF9hPbaA+miCqGc/yf
         9LWy2TjRsgBXdVjqF0XXSQm+s1F3qQul6yQSruKZVgopkySqYuI+sAOia3CwPQ4E9v+v
         ZSGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3NTbVia621J8xZ+FuZhQhfynxtu8fVvNJouLhrHXMQqO49fMe+1+m9r0EABrCyRvfEHydslQ7+MLWhrds0w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3Byi8Qo9oSPAALwUNOIxWsw5/7YGktvbKdObyszcW8m4XJ13b
	MFsA+4DFXJWOHUrJ1D3Ves2DcY4zCxXsJ5zOYEkOeS2hALFnBjA7WgKxBFinrXeMwivjST6QY5o
	WqtFbRXLV2iHiZpHOtO1TM98kZNCDOpRN6RmBG/7kP3i6EA7KvSMcnC/Cj/0z/3hRqiRZ
X-Gm-Gg: ASbGnctrv40G1ZsD/QDXnzNt1vcvYACdrbL95zZGniZA8/d2OO06RnLGUQ/bgabnCjN
	OAgKWj9t5WhCg1iJTkjB6fdg8gYP3KgRZi2sVkq2Qx0Wc4G3KP37NHG+dDbIkyVEJG77n4gmPPw
	KQCw3G7DmPUpuZpGLFMs2iXmwuniQW/BPf5cuQDDIHKj5qodytWYxF+jfDaKwFuM6SE1UUIdp/8
	7Ki1FBzmmAgvh9JQPgMADg5jm2UKvyNPPcbtcIeIl++0wz2YgjHV3aR1vsmtAwoEc/GKlajgJTf
	OvcHOI1htPs/BK9v5wk8U0QjzpaOCh5ROcpAJvQfc/iMDJQz5/NFvV+yyL1qvqbwbJuTrMBI33Z
	uWaz13xXNY5895X9YmAxrI5FGUEpGmN36ZFURXzP+DrWr5zeVTA==
X-Received: by 2002:a05:6000:2d09:b0:3a5:5298:ce28 with SMTP id ffacd0b85a97d-3a8fdb2a72fmr10414447f8f.4.1751357837354;
        Tue, 01 Jul 2025 01:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERLTCKBmcbHu7zgy5EThqO5Z94lv8XJhhKMgPqWhai691qAKiOAkty7NG8qpu22orfEJT0Zw==
X-Received: by 2002:a05:6000:2d09:b0:3a5:5298:ce28 with SMTP id ffacd0b85a97d-3a8fdb2a72fmr10414417f8f.4.1751357836794;
        Tue, 01 Jul 2025 01:17:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e528a9sm12735286f8f.60.2025.07.01.01.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 01:17:16 -0700 (PDT)
Message-ID: <d4d8b891-008d-4cbc-950f-2e44c4445904@redhat.com>
Date: Tue, 1 Jul 2025 10:17:13 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/29] mm/page_alloc: let page freeing clear any set
 page type
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
 <20250630130011.330477-5-david@redhat.com>
 <8c5392d6-372c-4d5d-8446-6af48fba4548@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8c5392d6-372c-4d5d-8446-6af48fba4548@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jIvtUa3nHZf-b5koP9ojSGOr5d1ryV4kjkBaawyWb0E_1751357837
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.25 17:27, Lorenzo Stoakes wrote:
> On Mon, Jun 30, 2025 at 02:59:45PM +0200, David Hildenbrand wrote:
>> Currently, any user of page types must clear that type before freeing
>> a page back to the buddy, otherwise we'll run into mapcount related
>> sanity checks (because the page type currently overlays the page
>> mapcount).
>>
>> Let's allow for not clearing the page type by page type users by letting
>> the buddy handle it instead.
>>
>> We'll focus on having a page type set on the first page of a larger
>> allocation only.
>>
>> With this change, we can reliably identify typed folios even though
>> they might be in the process of getting freed, which will come in handy
>> in migration code (at least in the transition phase).
>>
>> In the future we might want to warn on some page types. Instead of
>> having an "allow list", let's rather wait until we know about once that
>> should go on such a "disallow list".
> 
> Is the idea here to get this to show up on folio dumps or?

As part of the netmem_desc series, there was a discussion about removing 
the mystical PP checks -- page_pool_page_is_pp() in page_alloc.c and 
replacing them by a proper page type check.

In that case, we would probably want to warn in case we get such a 
netmem page unexpectedly freed.

But, that page type does not exist yet in code, so the sanity check must 
be added once introduced.

> 
>>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Acked-by: Harry Yoo <harry.yoo@oracle.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/page_alloc.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 858bc17653af9..44e56d31cfeb1 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1380,6 +1380,9 @@ __always_inline bool free_pages_prepare(struct page *page,
>>   			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>>   		page->mapping = NULL;
>>   	}
>> +	if (unlikely(page_has_type(page)))
>> +		page->page_type = UINT_MAX;
> 
> Feels like this could do with a comment!

/* Reset the page_type -> _mapcount to -1 */

-- 
Cheers,

David / dhildenb

