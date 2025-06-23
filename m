Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D783E27C869
	for <virtualization@lists.linux.dev>; Mon, 23 Jun 2025 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693432; cv=none; b=XFldFHaj1FQvct2roiF/vDOuw8VV1TsAdDCjDH3CSXYeAHqyrLhfEYYw89PWxn9wq9Et/vq5XSPkx4y8Dvk/sW4jxMX2Kj34/ctepUnCBY+A1pbh+Q49U5DzOLV4ZMwbgfAtIP1kH8adLvgHgeO69qRh/CKX90L660HAcXHSeUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693432; c=relaxed/simple;
	bh=EwKqjwcbw/T8RoZ/GrVIRDOq6nqjAfGLuMcMbDFjahE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWzurX2WJ6pVSk6dyp/APDY1rAl62GdDpMqSrWlYR+4Es3XoFAVDIFQQFsKWCU8uxeiVLwowaMXJDK6unyqJx5n831M2f/dZcIUw84J0u1tfSwdJH/OPr00sg+58I912Uf4TqroV3MJxvlNEK/8JFKchi5lCbpDxOty5CDAMeWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2ztAdYl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2ztAdYl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750693428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=23Yqz6D5y7M7u78E7VkUTuP0Y7WfwouQlTdg1wTNEMo=;
	b=U2ztAdYlAvtJ5Imi4YBHAuLNrwNxEOJkLKtYnUcO2koAqbobMuQ04sI7S78YnFz7iHQsqS
	9WlU0LrRe8mPUr/M0uVJ/dTBED6AV9JNOQx58DFGgNnqob8hKamziebJXEA5GSYRVNisSe
	uVbqawzL5aV5Af1LYzJve5dDs8eFabw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-GrVBQdTaMX6-URerdcf3Kg-1; Mon, 23 Jun 2025 11:43:47 -0400
X-MC-Unique: GrVBQdTaMX6-URerdcf3Kg-1
X-Mimecast-MFC-AGG-ID: GrVBQdTaMX6-URerdcf3Kg_1750693426
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451dda846a0so31637275e9.2
        for <virtualization@lists.linux.dev>; Mon, 23 Jun 2025 08:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750693426; x=1751298226;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=23Yqz6D5y7M7u78E7VkUTuP0Y7WfwouQlTdg1wTNEMo=;
        b=phj4ut4657C3It5wYDwS0AbN4huzU/dfMDIHsHqnSWUzp6EDAvbkkgOdpeBcQxS1xA
         njf68PP5mtY3famTYkJxX9GK5ej5HoFPd4sdkf54/J4MdBmW5pe9w661b3n+cic76MU4
         1EBhoznPaxdesCkTEpCe3SQ1m55FpABMdO0uURg6G5cIKWW8Zoy75GsdLSEP5ozxoG6t
         oFmYdvHUOzQmOycm2W71U5yfCgjGef5nPX94rx0xLqo2wrPiIbiKHg1kT1OZGk2fNaHN
         aLh+rvZB7Ewnrl156pzh2foE0LdXQpWx+lvyg9ED8ha9IcRz/+axxPP/XKI++F6TRw6T
         Rkwg==
X-Forwarded-Encrypted: i=1; AJvYcCW676D6ADFnwDY1PT14rB8E7j3TqdMp14Q6KF3cCm3G64K2vPtqKzknRntW5qQl0gwkmZ31gaDRq/JTF+6TEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YznvKF3jxqsugjIZLoBIwFpKAXn4vmWNqBnToi9vxodyFiu4kcb
	X9JNkVOglqCJ3rCIIgq6j2sN10eg1CbogDc/0UZhgnaO5cGKr4BfHKdqPZyN9mgUfAX1Ob5RtLr
	iwhbWqZ6vIjKeboJ1cM48CHeSG3r6I3WOfbarTBLPwtLybox83ceDsxgDhuZ+LDZFxQXM
X-Gm-Gg: ASbGnctxOJPKG1xtS8boDKpIPI4uQT4TpfIPlrr41whnafmhcYOpIGj6sIT2f0hD0wv
	r78GdlNxlAYxTQABwtP99H1lQO+nyNWLqlk+Ic5JC9G6pLK9Euoindfn2tFh6c4qduoK0apXxB/
	maA+KQ2uyI5Z6Tu1AChu+O8BWHoVsJgdwK0R4xTHWXb1aT7Ik/V+sTVhdoxM80J1JtivuTjhdUJ
	fnMZ5ZFWBZGT4vUWPZIQpOLnTNrYOSfdEJUYl4td0cu634Aa8rwTBJF42stRhUzb9QvzgwdnI4+
	swIMayn6oFFBmPmUwAxg7D4dupYTlmpRFtBhQ16e/OrJ0rvUth4VrP67OMPgx97sBVTRzKxqFBr
	pXIItW8TsN2EqyXqGx+nju7NuifjSB/sgWDiE0zikpZTkn1B6/w==
X-Received: by 2002:a5d:6f1d:0:b0:3a4:cfbf:5199 with SMTP id ffacd0b85a97d-3a6d128a528mr11275063f8f.9.1750693426107;
        Mon, 23 Jun 2025 08:43:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhqtrtlxl1Gchv2dH1mkzO8col2pfRQZ6piZoDOacwDoi8xsHoL99bl7bc3fGu2ZE5CWTyNA==
X-Received: by 2002:a5d:6f1d:0:b0:3a4:cfbf:5199 with SMTP id ffacd0b85a97d-3a6d128a528mr11275028f8f.9.1750693425658;
        Mon, 23 Jun 2025 08:43:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb672sm115985825e9.6.2025.06.23.08.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 08:43:44 -0700 (PDT)
Message-ID: <3fc57897-4eb0-4f39-8428-bbf10d51b83d@redhat.com>
Date: Mon, 23 Jun 2025 17:43:42 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 14/29] mm/migrate: remove __ClearPageMovable()
To: Zi Yan <ziy@nvidia.com>
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
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-15-david@redhat.com>
 <501877A7-28C9-4203-84B8-E05E7A0E24F8@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <501877A7-28C9-4203-84B8-E05E7A0E24F8@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Uv0MI7Xx5K4JREbaquqrrdOC0DviyvXBBe7aVRASrIo_1750693426
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.06.25 22:15, Zi Yan wrote:
> On 18 Jun 2025, at 13:39, David Hildenbrand wrote:
> 
>> Unused, let's remove it.
>>
>> The Chinese docs in Documentation/translations/zh_CN/mm/page_migration.rst
>> still mention it, but that whole docs is destined to get outdated and
>> updated by somebody that actually speaks that language.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/linux/migrate.h |  4 ----
>>   mm/compaction.c         | 11 -----------
>>   2 files changed, 15 deletions(-)
>>
> 
> The comment for struct movable_operations needs an update too.
> "
> If page migration is successful, the driver should call
> __ClearPageMovable(@src) and return MIGRATEPAGE_SUCCESS.
 > "

Ah, thanks, it will simply be "should return MIGRATEPAGE_SUCCESS".

There is more magic to it (the driver must setup the dst page as
movable), but probably that might all be reworked soon.

-- 
Cheers,

David / dhildenb

