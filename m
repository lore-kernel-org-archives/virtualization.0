Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F76285C91;
	Wed, 27 Aug 2025 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287763; cv=none; b=eRqMFzPbw7ODEZ83IsxvK+KT0UxYLOscFr/3p2iA8q5e3mmnPpud4QB4XTNQEsoHRwxY2uTQMWAxOsxsSQgmKja7o6AaRS8bqfLCaCXaVrJUfYBrxYslfRFB7q6JK48Oywwf9dRgBDDkpFhTjzm3fPir4z61hZa2cwnqOlu7ZuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287763; c=relaxed/simple;
	bh=A0KNxlVGHuvT2hmaoiFbUd67u8sxODxt85QG+mrnbSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yp/kCsucQxYIfQ0hY3l7N6oS7xBfBRUDNCVxCVbQIdITBdMkXVmGKPJBVvrKqqLcFt4diQErH2bsUNKFAjN3+8Zr/+58cxXDE6k/c7nz0TkBMj6cvfw6b1EgMLxNx08j/QLBgOZlDqg3yExJuTbqF1+GqonpAzD4WWmnvh3F17o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgwu/AQu; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgwu/AQu"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3cd59c5a953so29126f8f.0;
        Wed, 27 Aug 2025 02:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756287759; x=1756892559; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s4gNirUawo/2N73RGh/VZFmiZovBEw6Zvsz5pkyBSog=;
        b=cgwu/AQu+8kJH7NXekshnpHIodjnM51rYtYIs7aQRLfWhshi5JZIuONnDY1wlnc8X5
         0p+OV5MNRMEZRQ0rjDU0On2KaTx5ZTi3q7c4y6eK4saAL+vsmxD/4uvsymPSomvQQK3h
         WWby+6yqt3e+RIn2ch3GrECUaTDJfFvp3RDaoc+rEJqeHSWZZGvUZGTHOVUUGnKNBeeG
         +ZLFPmJmF7q1boqcTSz2JlVtC+4CTVdKxBXHIzTSPF0nMh9yV3fphLSp/8K0uQEMrxsx
         BA8BYkZRIgsU8CK18n2QEGLo3V1zSuvDajKH/LyBt1sM2/H+SZUEUy1TTjjp/AH5H8xN
         sEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756287759; x=1756892559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4gNirUawo/2N73RGh/VZFmiZovBEw6Zvsz5pkyBSog=;
        b=DRN/JX4Mxu6IZpUCUOI6FbpJGBQFx+M7mx80VRbyjtSPSA/nyFJv2X1pTbEujtqMdY
         WI96HcaVvrOeNP5P5DWpaGl35V1jUaw/Me8bvRgxuQnxGAP3GshmVeKmxgWuWH4tPdaj
         eNYgQT78DVhIBfUZXNtmVFXRgFnBu/xej0t1yV3y4RRKCTeArYlK6J24fM5wtIU0Dm1a
         dZ6U+pKGCY51ifKxEwTmqO2ynwS2ruIIJUaVrRbTmHUiiJRaeWmkpuBnvmWVsinvPYQO
         LNYuf6TQ3q6sfEMqrKyG6J3I0I+l0xzzxMyecW/mTv781p1Fbguh3GFs/cd8yrC5An2v
         g7EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSqEIfa/ezWmCKAWuSVJ3EhCkHi78AHQuvbkTpOsT8DQTuJVrIG9wCS1EYncHvPrTEnWiiHirSnR336y/vTQE=@lists.linux.dev, AJvYcCWGrbUSxAofllmSlK+uXwIGYTND16Bf+Xf52zmkcvwxpuAcjrWlvV0G3RnzyW2bTTyE+6Vlog==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcJQQ+pn2FPgJApQfwGIhPQzZ9jWrSE5visknzbnlZATTXvSy2
	OhV8QEi0QcmQQ8AZHVgsB8R7BDlFaGLfbc9pl56H7JF5UViMEl5me79H
X-Gm-Gg: ASbGncsNOpc6HtYJGU31WzugRr1cZlWxeK9TPE+WmE2cYq4u+DMoYDx7PuKeLqojF6q
	y4NYp37MdW5mNqvjqQIZqAXreT5I3xQ6UsMJA8pD0gUoxad6s8GEbc9mppjlrxup3eyqziu60HW
	OLQ699e514m2QcGWZ35+FLBrTV+W1Q1UFOKQM/JWvAyK5WY7gjQ8Yr3Z33/sFxWbHdmZ7+JtqJq
	Wyj3upGBmnyMiCdiKEbbG/CXqANUGthniqTKRuHsdWg34XJNdqJiaGKCN8gkFXBqTLn2fb+PToJ
	G5dXFVlUTsESOZK5c1h1FPL+0KT5p34llGcBKydYCUuOrR4beaBg5z74m+lnW19m77+n4dlARcr
	DAG31QnoLSjfWwYrOj7hy1DzUGgtamPA0LA/u76KqfCVDwE6hDAx95dArEm+EODPWeQ==
X-Google-Smtp-Source: AGHT+IFkjO5GHbU1+2MUuKQvNL0fwH2etmLb7S57NgBpdq01aCYpWSgROxwdQQpXxfO8aoPZevSNpQ==
X-Received: by 2002:a05:6000:3105:b0:3b8:d672:3cf8 with SMTP id ffacd0b85a97d-3c5dcb10b6amr14770182f8f.43.1756287759105;
        Wed, 27 Aug 2025 02:42:39 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:4a1a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc4b102889sm3363615f8f.51.2025.08.27.02.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 02:42:38 -0700 (PDT)
Message-ID: <46d09557-1873-4d97-b073-ce0c7296b954@gmail.com>
Date: Wed, 27 Aug 2025 10:43:59 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 18/35] io_uring/zcrx: remove "struct io_copy_cache"
 and one nth_page() usage
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com,
 kvm@vger.kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@axis.com,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Marco Elver <elver@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, netdev@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Tejun Heo <tj@kernel.org>, virtualization@lists.linux.dev,
 Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, x86@kernel.org,
 Zi Yan <ziy@nvidia.com>
References: <20250821200701.1329277-1-david@redhat.com>
 <20250821200701.1329277-19-david@redhat.com>
 <b5b08ad3-d8cd-45ff-9767-7cf1b22b5e03@gmail.com>
 <473f3576-ddf3-4388-aeec-d486f639950a@redhat.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <473f3576-ddf3-4388-aeec-d486f639950a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/22/25 14:59, David Hildenbrand wrote:
> On 22.08.25 13:32, Pavel Begunkov wrote:
>> On 8/21/25 21:06, David Hildenbrand wrote:
>>> We always provide a single dst page, it's unclear why the io_copy_cache
>>> complexity is required.
>>
>> Because it'll need to be pulled outside the loop to reuse the page for
>> multiple copies, i.e. packing multiple fragments of the same skb into
>> it. Not finished, and currently it's wasting memory.
> 
> Okay, so what you're saying is that there will be follow-up work that will actually make this structure useful.

Exactly

>> Why not do as below? Pages there never cross boundaries of their folios. > Do you want it to be taken into the io_uring tree?
> 
> This should better all go through the MM tree where we actually guarantee contiguous pages within a folio. (see the cover letter)

Makes sense. No objection, hopefully it won't cause too many conflicts.

>> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
>> index e5ff49f3425e..18c12f4b56b6 100644
>> --- a/io_uring/zcrx.c
>> +++ b/io_uring/zcrx.c
>> @@ -975,9 +975,9 @@ static ssize_t io_copy_page(struct io_copy_cache *cc, struct page *src_page,
>>            if (folio_test_partial_kmap(page_folio(dst_page)) ||
>>                folio_test_partial_kmap(page_folio(src_page))) {
>> -            dst_page = nth_page(dst_page, dst_offset / PAGE_SIZE);
>> +            dst_page += dst_offset / PAGE_SIZE;
>>                dst_offset = offset_in_page(dst_offset);
>> -            src_page = nth_page(src_page, src_offset / PAGE_SIZE);
>> +            src_page += src_offset / PAGE_SIZE;
> 
> Yeah, I can do that in the next version given that you have plans on extending that code soon.

If we go with this version:

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov

