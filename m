Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C845018FDBE
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751271398; cv=none; b=klhRRvDPekqd0RfduU8JnZr0ymzdPmMDdAEswE1d+Jkg76mqWcAT7xMe8B2L79NvMH3lprY7VRDHTyCONtV3fRAEQkTbG4Guxk3KgoZ7PwcYRcMzyN485R03LNuGJCMPQVodlpk5u0RkRR7KfIm/mTaE45OBVHYeBRA6ml+9dYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751271398; c=relaxed/simple;
	bh=lndIK4MUo3un6mjaLebNKYXjJFS6m/SQ+ummaiD617Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Co/hcu9NbEsZezoZf6XivLdxXCrhBIH9rQm5+0D4Pw1B4/B+ylc7UFIUijVBLU7XRVJSX/eS49NGpThyhKC7oxLR879ImVAxW5IxP6hDQ7lban+BUZ/blrjF2+5cFMz4PmkPrjxcjz58fkUdxlcSWOf/wO0us7ADlwfXfhbp4rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZtM3SejE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtM3SejE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751271395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6VPcb/KjKOGdw4gPzPctO4cFLASxj6NEbu79fmEsFHY=;
	b=ZtM3SejEYG78ZUfPFIIHo9N39i46PCEBp40OQTRKhzt7uA2AoT3QGBJs2CFgqq7xl3HU8W
	fhMEmoYb5qvnDiVBYCLvY0E/1ZgQRHCF5f+O5/U1DHI7NR+0safMmyMu6kE/2fA5G+Q0nP
	a8T3fhmB6dVuHqFUv8GE+vc2nZAL+hw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-UPO69hnFOMuyhPI0vHZsnA-1; Mon, 30 Jun 2025 04:16:34 -0400
X-MC-Unique: UPO69hnFOMuyhPI0vHZsnA-1
X-Mimecast-MFC-AGG-ID: UPO69hnFOMuyhPI0vHZsnA_1751271393
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4535ee06160so13941485e9.3
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 01:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751271393; x=1751876193;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6VPcb/KjKOGdw4gPzPctO4cFLASxj6NEbu79fmEsFHY=;
        b=XOK8sbHmgBHhnZ8JWBgL48IDBIPNSNCFcBWdrEZH1KRbAQIluJghkG4vzFn7dNDI2b
         KrKDCpNf07tf5tKShQDEWN6I5aFLzmdIINsv8jYHxg/OCNFmGiSk2ymfwXGnmzaoSS0b
         ASwM2Zxt2axGTBeZ7BxKmzXowzd4Yiknj9SJj8AT18Xai9asEkLahvNWN6L4MjYAjBvD
         OatlG/w3wZDCLdGdVpMh5Ft3rd/PbtmIWzZ7yiCEUSSJF+Kxt2wMkNPnWWF7hWYI3AHH
         fWiUOAGPmHX5WkmLgpmOzDDjlijPo7pddUm58Ts52DsiEb7nHWKItPknDEYUkbaVqVJe
         nsGg==
X-Forwarded-Encrypted: i=1; AJvYcCX+y7co5umjPt+swnDoLJ1BkI8x4f4XTacRaTIxBTxYpSb5W1E6T5B4t8MUNLb1bcNCRogO3cVPqo5Zrkxrtw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXCIT+dDNt/MExO+Tnb9HcL6yyyozeBpSxUoB1dZpV/ehMGMxK
	ZrDeLM30jVi87QhEYTCgLUJ36TClQwNVRPZGRshVy1twOE2kMejTwfm2ZRtvKEVOi8ptW8nb03G
	JPdWbcOrUkvRkZHQE+adFz36sILYemcRV9Hsq/Xn3HCGr8wuaKwmvWrTmiLV7tBrRBelE
X-Gm-Gg: ASbGncs2S46CrUjYGGV4yrAXPPFv9gTop4Fg7L7zkLnu7p/KX/hTlIKHddOztjUypwi
	c3lL8s4UoCFKazjifmjuUTFj/To9p8jro5YRjUIBPyBuaeBnnUbWRh/SouwV2weXzK+h7YAfKY5
	IHjgVWlJqStaS1lnvJqpRwMirG0BnxGBRjgA1BvG3KzkGYWxLzRaLLmolLbCjaQDBMM7/9BjSYA
	sJkhl8nrgvFxxQe+AS+ITNagdDUhpTFZX8fDWz0Tr67z79O8rgrRVs17guziT/EKWuXW3zu2QZe
	+cxAs9/EDtfqVo4BLYSwk8+FcT/KjcHlosVHVoFt7XJpGTm1NlZRNWgEOu9E4Q41T6ydX6veldV
	9VgZfygZki79sJVFZ1ytD88LQ2gNF4nsI+FiFQj9pM/LNG6/9LA==
X-Received: by 2002:a05:600c:1ca1:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-4538ee70c4amr100852645e9.20.1751271392603;
        Mon, 30 Jun 2025 01:16:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQl/WnpHN3yTrdW2FOwkHhUK3NtUpbFqlzDb3P/Ebo20sSqdyuNoSbnHSjaaA1DLihH3PoRg==
X-Received: by 2002:a05:600c:1ca1:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-4538ee70c4amr100852195e9.20.1751271391970;
        Mon, 30 Jun 2025 01:16:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f40:b300:53f7:d260:aff4:7256? (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e598ddsm9681774f8f.78.2025.06.30.01.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 01:16:29 -0700 (PDT)
Message-ID: <1fee1926-638b-4852-b98f-a0423a94b7f8@redhat.com>
Date: Mon, 30 Jun 2025 10:16:26 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/29] mm/migrate: rename isolate_movable_page() to
 isolate_movable_ops_page()
To: Harry Yoo <harry.yoo@oracle.com>
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
 Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-8-david@redhat.com> <aGJE3r5uSzRj8BsR@hyeyoo>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aGJE3r5uSzRj8BsR@hyeyoo>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9SaddLlWkkut7BPqT9AyvlzNyDesBCH6YizSng_-fmQ_1751271393
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.25 10:04, Harry Yoo wrote:
> On Wed, Jun 18, 2025 at 07:39:50PM +0200, David Hildenbrand wrote:
>> ... and start moving back to per-page things that will absolutely not be
>> folio things in the future. Add documentation and a comment that the
>> remaining folio stuff (lock, refcount) will have to be reworked as well.
>>
>> While at it, convert the VM_BUG_ON() into a WARN_ON_ONCE() and handle
>> it gracefully (relevant with further changes), and convert a
>> WARN_ON_ONCE() into a VM_WARN_ON_ONCE_PAGE().
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
> 
> Haha yeah, back to pages after folio conversion :P
> But makes sense.
> 
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> Side question: In the future, maybe we will be unable to tell whether
> a page is compound or not, without first inspecting page->memdesc?
> (e.g., struct slab could have an order and a pointer to the head page...
> just imagining).

Right, it's not really clear what we would do in the future, but for 
anything that allocates a memdesc, that is possible.

We wouldn't even need the "head" + "tail" bit indication.

For things without an allocated memdesc (e.g., PageOffline), maybe 
compound pages will simply not apply.

Likely, the concept of compound pages as we knew it will go away.

-- 
Cheers,

David / dhildenb

