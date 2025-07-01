Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5AA280337
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398728; cv=none; b=aABXzBAJ228A8JMwcpa4QPCUwkb3U+C9zqYAXYNC4t2a7Lcps8uqFLYzkCj4EbQ7L1fJ5NP2VmrGbeKYPhsf3e9xLZeQeqvhVSBf10JDnTVzzg3FS44VVjOC2clVFX8uaPta9/bI9oAIt1KMvah8tZJg1G7/Dci3IdlaUC9oZgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398728; c=relaxed/simple;
	bh=/gDBtxT109hf9ai3868bZtZVWwsPmd555OsHp/op8gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gR/jpTuhRo7iPE/5EX5ZTxUHWEBFj7X4iZU70RxwI7/rR5GiYPJrYluF6sMtPyi2L72TJyjhb0U51P7tirSSHOJOEGzkZbZ5CknLLpV8Lvw73XXGpOaGVU1eP4EUvE+ODExNX79Yxw21C98nrlGDnfdWm88Jn9oWGntXTBEIIc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mbm+FGYc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mbm+FGYc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751398723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lElXDuIbz+447o51stvN3qhEUqBMiy6QYykeUTYpuzk=;
	b=Mbm+FGYcQxsNXjNqKfW9xD609kiFwGkS5Ik+QXPEVdEDqQUejhCXKSfUAI2kFkHAi5D1JV
	src3mENW5fFJL8vkceOLGDiFecxiQDMTHFacEhpjyynqDorPI8hbBJca3MyMtAZmr9u1mM
	CN5yq991zukcDi1zg3wAiSxnDPdgmdA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-l7GqPvKSNim1Brp91l31Gg-1; Tue, 01 Jul 2025 15:38:40 -0400
X-MC-Unique: l7GqPvKSNim1Brp91l31Gg-1
X-Mimecast-MFC-AGG-ID: l7GqPvKSNim1Brp91l31Gg_1751398719
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a3696a0d3aso1719326f8f.2
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 12:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751398719; x=1752003519;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lElXDuIbz+447o51stvN3qhEUqBMiy6QYykeUTYpuzk=;
        b=lSLZQFyAc5hwULjHPh9fQrgvO1mJqnh43EgPN64ZbSAstE20FpTJzIbFwoUHQD9VPW
         9pVVMvgUq6ec3Jw6z0Cne5Y5GdpANa1D2SMcr36Amu3RxNH83oJFcskzzJJq9R+zsFdL
         4bo3Pw0Kjmg02GGpUV7dRxKTRxL8tgSfJ4CEAS219ck65WvJz8V0pnCaUEiAQ+bpJIYk
         5JnOJttJwlqszNPbsUOYK/00VFKY7zJmlIzMxxUJlemsm1V0ONR4rC6eDIUNuPdwQksD
         xr+Z0z7seLT/+1JVWBOzln8laaK08JTpVPY5WHT4oByk6SRl2sus98a9ARyMlA63RUmh
         lkKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnKaqpK35LI+DGVTTQzme3x1NxNTOQRE01G4pEbvUFbBXAmm+mjOs1Py7x8Kuj24vrBsHllH3lDoWO+e7Khw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxf9iwTruKaQSdDridJKI2z5p/SF3WyAXJKk8WoyZQiOdSZNBFL
	8Tw6lOfo3DwCEGG8wm6yi5rdY25Ux34SfFoDJXp8bCjkwoTbzuvU/X90z/yhlyyNTMQEx+iOl6s
	fIQcJmOjEchnUjwHCPe3Is3PV2lZcpaUkhhAWA/Wnd8iHMpQiWwr7tpIP5rH3gd96F2dD
X-Gm-Gg: ASbGncstskPOEPiBRPmNtsI+8iaMimE+jIQILFRaxVYv3E59Jj9pg4wBcCXEUQyNwbu
	wJXtMO1YtvUin3QH4FtT0oauYU2kG4uLVWWhdEWIGgl7vbfC2dIEeXGQMnVz/XKt8ZQy+uFcVgM
	NBaAJ3G2i+x0URaStdZDF1q0KVbEZWuzqNzS75JyEos8llAtNY8EqkED2hiOB7n3Vdpjmu4Pjhi
	+wFMHWjWeN1IRUjO8t4x1TgOmzqev2r4KLjxABnZOzhpczQ5ruRcjMdRcV5Snpv7v9FlrTGKUwe
	Rx+EOboFlTgiBBeY+YtLbS2YTZfNpWCatxdBuQ/B8A9S6HYV0oFmj5psuaicH1lRD+QBWEyrPN8
	AjEGQx06yH5tcYABCooJWY5ywmNRL7A3zkrTS5K/BBTJHlhkghg==
X-Received: by 2002:adf:9d87:0:b0:3a4:f7af:b41 with SMTP id ffacd0b85a97d-3a8f4a15c99mr14175381f8f.15.1751398718879;
        Tue, 01 Jul 2025 12:38:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLFyo8RcgMuSgcAM1cNXXfDuXZjnZVKPC4QmHAvknSOXyWUZGyTCuS2ZP2Izn55tZDj/Vv7w==
X-Received: by 2002:adf:9d87:0:b0:3a4:f7af:b41 with SMTP id ffacd0b85a97d-3a8f4a15c99mr14175369f8f.15.1751398718397;
        Tue, 01 Jul 2025 12:38:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52a5asm14214194f8f.54.2025.07.01.12.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 12:38:37 -0700 (PDT)
Message-ID: <bf300002-7020-44c2-bda8-e4fa718832bf@redhat.com>
Date: Tue, 1 Jul 2025 21:38:35 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/29] mm/migration: rework movable_ops page migration
 (part 1)
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
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
References: <20250630130011.330477-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250630130011.330477-1-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vtdnzg1TRc_JsM5W0HFXjnNO1-ylDaluAXuIKF1dm_A_1751398719
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.25 14:59, David Hildenbrand wrote:
> Based on mm/mm-new.
> 
> In the future, as we decouple "struct page" from "struct folio", pages
> that support "non-lru page migration" -- movable_ops page migration
> such as memory balloons and zsmalloc -- will no longer be folios. They
> will not have ->mapping, ->lru, and likely no refcount and no
> page lock. But they will have a type and flags :)
> 
> This is the first part (other parts not written yet) of decoupling
> movable_ops page migration from folio migration.
> 
> In this series, we get rid of the ->mapping usage, and start cleaning up
> the code + separating it from folio migration.
> 
> Migration core will have to be further reworked to not treat movable_ops
> pages like folios. This is the first step into that direction.
> 
> Heavily tested with virtio-balloon and lightly tested with zsmalloc
> on x86-64. Cross-compile-tested.

Thanks everybody for the review!

I'm planning on sending v2 probably later tomorrow, so we can get it 
into mm-new.

So if someone wants to review parts of this series either (a) do it 
until tomorrow; or (b) scream STOP and I'll wait with v2 a bit longer; 
or (c) wait until v2.

-- 
Cheers,

David / dhildenb

