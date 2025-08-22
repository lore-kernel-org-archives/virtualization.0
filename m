Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9A5295DBD;
	Fri, 22 Aug 2025 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862291; cv=none; b=CreXJZkkX8G/YoEbv/cPPpLzZCbNmCjCPTfpPQCaFpdpVOx7QOf3QtKnsTNuga4QF3TWHnO1WYMGvWNUbTat4rrj/51UX8gH104cluzoAb2l+QwEa25v71v/rbxOO+mrXHrJ5wUeRsD4Y7T1MnBT/li7uUsqEFfeIgCp2HDKwt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862291; c=relaxed/simple;
	bh=QxTICeIhRMERCgTBkORqT0sL9XBucsgusTgs9XuOzso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8WprZGxOwvTmSdbeAYopeC0ONHtMtWGLfrQJCAxEqmUF7cgoPFe+r4uhmTFJhSHnJbZr4uaO4hNReN8lYrLLfr7eORWonNE7j7K9F0ms8lHr9RpiSLrxl4GEOmZphL8dm2wFyQPMQUBkf84J30l96rIlQ9KtHDImiPlHTK2WZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3OIvaYH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3OIvaYH"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b05fe23so11578395e9.1;
        Fri, 22 Aug 2025 04:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755862288; x=1756467088; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SfbHPH5Jjp8Rpz5+ZFUkvP8crb1ywqdy8VPh1hjPgaM=;
        b=c3OIvaYHQeLrCpQ1l8dJkh++KwQt6JB9VSeRdu8POBzHVYcLl9nnRoF1N5pIfZHumd
         92e+8VmDhr3Tdw/IstPLieo8TLAkb9YAyIxS+i0DqdBFg7X2rYjyBMDrtBSY4PClEovB
         fOitLOpbUZ3bNZQ/HlFCrtO/vhODYRka5Zz4jGXvWMn5ECuj7yXOKvWbAU0sCWlBCoMT
         MYOmnsHQwUoZ7w0dgHi30dszRTyTOZZMQNQLVSVzGMHs+P+zWE32xtLNlbmYjrbNYF71
         B3ESHHDdJOTpm9H5cytrxeTxN6oDgJcDuvsQPOiNVo+U1/V2CBDt5w9OCX5yOnymiO6G
         em1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755862288; x=1756467088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfbHPH5Jjp8Rpz5+ZFUkvP8crb1ywqdy8VPh1hjPgaM=;
        b=rVsjwC/yRWXorWEqHz790Aw8A4WcZDMEz8k7evO+DTYYwoJtj/08zgY6jDh6IVHqYY
         r0Ypbr+nmAJPeUB3nSmcoJQJYMnCWa6HF7IcjPllCL1SM1STOrqD8nOOhg/aOOEwaxBi
         0ImkTMZb7w89kHpxKDIgKashR9DSWRE50EZ8r4pVIAeJfLqBQYjRC7JW+O49797mioo+
         O5JgGdb+0/MTxqtkIPazgCu3ciOc7tQyMS+8JdVDRzZiu0k8onzAhcwHzT65UhrR4Evx
         bdEzd6FqW7EgjeE3mbblmOb0jdoezpW1HDmmUP3vJJ5RHkTxv5d/Z2hEEjNvzvumZLdO
         pvZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv9hiu8MVtERAhhR3o9dwpXbdsrNmjVcLcsJjcCVvuv2GCVg+T3pZpXuulDtTTKwGGlQUmnw==@lists.linux.dev, AJvYcCXlj/5INN/00Bhc2HqHkCZ+TwXHRDou7wgv+BR+5j9fmwwblGGAgLJ1ZI7gtOedfBIYfhhh+grvkN5AfZmRfK0=@lists.linux.dev
X-Gm-Message-State: AOJu0YxVYJfclk4dz4e5AxtJz2Ehj1aWQOtxyzA4qnmkmfFQsEznKM0j
	o+sMGEwBSlz4iR7JOv4rgIEVYswALXaciEB1UOdAP/nl+JHXQyp7T2gV
X-Gm-Gg: ASbGncs9ZtwO9P/f73+osi0G7H8Q7Uaa3pLTQG2jxNouRxLV/QMFR1TMc/IOGnarLBu
	qsb25/sZNhKXS7rGriSE80/q6uRlSc6a7zmCUUKig6BTy7eGMSwUORfXqLkU/wMIe17Hy5X/ZRd
	W+bivqnik6Y8oS9rzUF2NNoum1XPa/OfspEJXsEPM7u4fMNdZvb0LLfPvg1StVZZuHD98LPclb4
	/gZx1zlHE9G50c3/cG+SojmIApcrmcv72sufSdyFMdh4qwFgo5Nb/0NZmQ04hKISZ+wwBVJd0sB
	uauDt3No/7wNfB7DxMNq9JFsRI5iyyN2Z78UNitU/4UkLwnVL0MCtlaOcIHakztXDbUimrkBLVH
	jkk+jPZyinb1JIwaYcw/B0BAPssLvqDyiE+S9GyIY4+D5nekPYITJk/w=
X-Google-Smtp-Source: AGHT+IGRxFKrTZ5eDvBkmi1zEgN6s0gJ3t3AoyWptSyZJnQ5Bb32czELomyx9FMDxkr1p0nFemiRbQ==
X-Received: by 2002:a05:600c:4747:b0:459:e094:92cb with SMTP id 5b1f17b1804b1-45b517ad81bmr24844685e9.12.1755862287996;
        Fri, 22 Aug 2025 04:31:27 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:1b93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50e4241dsm35921185e9.24.2025.08.22.04.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 04:31:27 -0700 (PDT)
Message-ID: <b5b08ad3-d8cd-45ff-9767-7cf1b22b5e03@gmail.com>
Date: Fri, 22 Aug 2025 12:32:58 +0100
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250821200701.1329277-19-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/25 21:06, David Hildenbrand wrote:
> We always provide a single dst page, it's unclear why the io_copy_cache
> complexity is required.

Because it'll need to be pulled outside the loop to reuse the page for
multiple copies, i.e. packing multiple fragments of the same skb into
it. Not finished, and currently it's wasting memory.

Why not do as below? Pages there never cross boundaries of their folios.

Do you want it to be taken into the io_uring tree?

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index e5ff49f3425e..18c12f4b56b6 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -975,9 +975,9 @@ static ssize_t io_copy_page(struct io_copy_cache *cc, struct page *src_page,
  
  		if (folio_test_partial_kmap(page_folio(dst_page)) ||
  		    folio_test_partial_kmap(page_folio(src_page))) {
-			dst_page = nth_page(dst_page, dst_offset / PAGE_SIZE);
+			dst_page += dst_offset / PAGE_SIZE;
  			dst_offset = offset_in_page(dst_offset);
-			src_page = nth_page(src_page, src_offset / PAGE_SIZE);
+			src_page += src_offset / PAGE_SIZE;
  			src_offset = offset_in_page(src_offset);
  			n = min(PAGE_SIZE - src_offset, PAGE_SIZE - dst_offset);
  			n = min(n, len);

-- 
Pavel Begunkov

