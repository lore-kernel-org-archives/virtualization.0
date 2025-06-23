Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D865626B747
	for <virtualization@lists.linux.dev>; Mon, 23 Jun 2025 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692804; cv=none; b=UmuCxjV10DtweL+Uwmtq6nqqNiycTQ0LhUe3tAYa2DBcfGoyytoUPnC1ZgDgHYjPP5ABzAmleMV09L0YcejcoyHYLyb+aaeIBPkRJUBWoWBo3yHQb40QI0tFwwG1gSxVEt75E7I4T+uUtOqujhXBTKCnlyES2IBNzDysa5frcM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692804; c=relaxed/simple;
	bh=pVYWUUtxxjRs+wa8zf1bcU9rpSdWdx+QpbNmNwl8dnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgSwuUaPyg0EovHydTM2Ue5EZftZmTKknbtTM51iR13PF57nHFQWVvgmgOarx91kx8mrFs3kqvIoHf0lOsiA7zsUnWZzl+xtppbo5U6hVx/3r8Zu7tTDc9Au5YaXTDgGv3l1ZNEBpCesz7UNqh4OmTADmyLjCP+HwtTWhLKAySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RDZmzvfa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDZmzvfa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750692801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VMFE5XFmCnZwpDxXjyOQUDgj/ACDl6iF3epiv58I+/k=;
	b=RDZmzvfaz7IG6YylJnFAHsKGCpWDq65zQg7fQxtwTwQAV1BT3lNPut/AeX+DXHyQYmQfei
	KThuBjkfZwfOW+igcKDyX73JHk6UdJ/O9ocLStWJeJx5v/12bvn22X+lgj9GkCF3tVoO1e
	pZSEHIRYQ+VeSTflku5w2W6oqU2cfII=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-Ce64-nqGObq8prpsw6ocYQ-1; Mon, 23 Jun 2025 11:33:20 -0400
X-MC-Unique: Ce64-nqGObq8prpsw6ocYQ-1
X-Mimecast-MFC-AGG-ID: Ce64-nqGObq8prpsw6ocYQ_1750692799
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a6d90929d6so680498f8f.2
        for <virtualization@lists.linux.dev>; Mon, 23 Jun 2025 08:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750692799; x=1751297599;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VMFE5XFmCnZwpDxXjyOQUDgj/ACDl6iF3epiv58I+/k=;
        b=xI4s8MsrXWRu1YRJe1JsZChqf/DX4SkYPw0C/5j/n479B+Ckf7SsmmN5EuIdAbl41f
         bf3mgd6LoC8QV8Q7B/vKjN+v2PrjzOsk4scRq3BXDrlM6+J0nu7o38RQ9LLxoT3xTS51
         zpralLl9XxIfqG48sQY0q9vU7ZsMJt19VQKq2ChGGgzGvsW1wI7TnVGS281D0lJglAaL
         rGCS4iDsVDm428FpLI7DnbVqe8a0qk0013wVSvVWqlC3ljWd1ztCi0Qro9E1mygle5ea
         ydLyMhYpPoJUOt9Lokk372Es05C7/tSo6uMH49N5ts6WFcyWD5/1IT8uuc7hhCPemIbm
         /OLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTH7PZ4JwfAZMcbgX+vv9A9QThyJ2Vft9RSRaTYd5dl1y/WcQn0c6yurxflcOFWKrymqWi1zxs7x4JPqeoXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWoLuYmMdvMoruZffoNnU8AKhL67Oz//6zdgGpHcW3PgXy2yHB
	9KLlKEljMymWoiYGrmQ19GJMRbR3hSSslexyUHnKcQ2zKBVr5sw3jBB5riSIDm54PVvELr0Fqgb
	EcqdxAkV+0U7rd38o8Avs3CjRkfMoV17ZuaAQtAVupWmZ2+LhHn8d/Y1zrnMFmlYktLUA
X-Gm-Gg: ASbGnct7e9Ex14r15DVVxVP2DjkHNo0YnVVwh6VDzLMwk30oVgiq1vwI2W2nRo2QoqN
	IkbLoScZwXIorHeNWR/w857n75PamZIxlJO+2fJR9ElIBkIKUAP3Wcwe88g6CvLCkw9jHUa0K92
	bjW+iYSl9i76qSFbzsyNOGWB+mej91vbcA/ZKc3eNZ0P2V7FY69WefRVMezxZGnFo3fFDa7e1ub
	UFDiBo7LPf5LpQY0KKl8Y4kEhSzstk6nmCRHR8EFmQi5cko4hwEAH0ZdZNmAIxfklUoMPLi1dZ/
	heWE0oC2z61mYlcr4yg/OifjvdMsVsIIsr/IxgIoiJV/fUjfQCQ0pLpBMHC4hJU6S4aOfhbc2E5
	lOQzDdJXif8lhh2vnp0CPMFOPHkgqC4R5gbWkuGi3tKo1nw96yA==
X-Received: by 2002:a05:6000:387:b0:3a4:edf5:b952 with SMTP id ffacd0b85a97d-3a6d130453amr12674296f8f.36.1750692799188;
        Mon, 23 Jun 2025 08:33:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE85hMTnbdKxy1bT4Kk698V7XUcW8rVuxvFEPAA18LssuPVWWrj7O2eHAW4gMzCB9Bjo1Zu+g==
X-Received: by 2002:a05:6000:387:b0:3a4:edf5:b952 with SMTP id ffacd0b85a97d-3a6d130453amr12674261f8f.36.1750692798755;
        Mon, 23 Jun 2025 08:33:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f18152sm9522292f8f.27.2025.06.23.08.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 08:33:18 -0700 (PDT)
Message-ID: <bef13481-5218-4732-831d-fe22d95184c1@redhat.com>
Date: Mon, 23 Jun 2025 17:33:15 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/29] mm/migrate: rename isolate_movable_page() to
 isolate_movable_ops_page()
To: Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>
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
 <20250618174014.1168640-8-david@redhat.com>
 <9F76592E-BB0E-4136-BDBA-195CC6FF3B03@nvidia.com>
 <aFMH0TmoPylhkSjZ@casper.infradead.org>
 <4D6D7321-CAEC-4D82-9354-4B9786C4D05E@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4D6D7321-CAEC-4D82-9354-4B9786C4D05E@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m2w7Ky1b5meC1_7CELdZKzvODNEZwEBvJkCCiD5-mS0_1750692799
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.06.25 20:48, Zi Yan wrote:
> On 18 Jun 2025, at 14:39, Matthew Wilcox wrote:
> 
>> On Wed, Jun 18, 2025 at 02:14:15PM -0400, Zi Yan wrote:
>>> On 18 Jun 2025, at 13:39, David Hildenbrand wrote:
>>>
>>>> ... and start moving back to per-page things that will absolutely not be
>>>> folio things in the future. Add documentation and a comment that the
>>>> remaining folio stuff (lock, refcount) will have to be reworked as well.
>>>>
>>>> While at it, convert the VM_BUG_ON() into a WARN_ON_ONCE() and handle
>>>> it gracefully (relevant with further changes), and convert a
>>>> WARN_ON_ONCE() into a VM_WARN_ON_ONCE_PAGE().
>>>
>>> The reason is that there is no upstream code, which use movable_ops for
>>> folios? Is there any fundamental reason preventing movable_ops from
>>> being used on folios?
>>
>> folios either belong to a filesystem or they are anonymous memory, and
>> so either the filesystem knows how to migrate them (through its a_ops)
>> or the migration code knows how to handle anon folios directly.

Right, migration of folios will be handled by migration core.

> 
> for device private pages, to support migrating >0 order anon or fs folios
> to device, how should we represent them for devices? if you think folio is
> only for anon and fs.

I assume they are proper folios, so yes. Just like they are handled 
today (-> folios)

I was asking a related question at LSF/MM in Alistair's session: are we 
sure these things will be folios even before they are assigned to a 
filesystem? I recall the answer was "yes".

So we don't (and will not) support movable_ops for folios.

-- 
Cheers,

David / dhildenb

