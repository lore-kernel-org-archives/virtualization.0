Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A532853E3;
	Thu, 28 Aug 2025 07:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756367040; cv=none; b=kCySXLPh5tj9Wtv0Gnb5LAjECHEGEbrl8AYM4YwN/5SeI02sFQXDSWtzpoXImCVRTawK/vY+Gh0e0Dx611Um+3QmHFy0cu0FR3iY0/Xuvc7BsZwY7fRGx1Doo1TljBdOpM1qJEQeNdsqdLtKUWJYG3njI4lBU2V0OIeQ5qfcb/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756367040; c=relaxed/simple;
	bh=XDFRc6QlXzcNT8Ow6MyYcXfogrHGk9sBXxgLao67Ms0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pv68KaKVnG0aD8w2YZTjAkIGpbEc/7kHPsq3eX6DJpm8iywKBsa/NjNodEvQRcs5125gWdCZOALgsFEY+spNZ2CDxoQjIgZlxONG1+JSR7fWK9jZfBqgeG4W88LI17MJqjsMpK9oaoRgoLPR9DeMiXX3hWyv1q2YKCiDE/chQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZnKYfIp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZnKYfIp"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afec56519c4so73351166b.0;
        Thu, 28 Aug 2025 00:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756367037; x=1756971837; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCyWFKVmsqDpuka3mORfqvZ6ED5815cQsuT83UfJ0fY=;
        b=LZnKYfIpb5hruvZlOxSWiB7VqccJ0CB0jO5kf0g4y1kkzGEC8jjYHPWhT5y2o9m2EY
         8sVGe1J2PigzzcwHdXAHxFc1WKWA//m5n6GT+rsyclEoxVI7WQnaoUrDYhyU73YT7yXq
         6H+BVzpcxDuQRSH5xKvrYQV5AyiYmXBnZcv3uXB+3Q9V/X4KivqVTnlJQDiF6LOaDDkA
         Tl9HFdIShHJ6hWJIxX4Ilymg0AVPShTPALCSXi6bimGy7wL4wEiwfQweXQ6T4DtI4NaG
         HkB3MM/HLTxOpMVeI6P0KAjSDBdwaUU7cIC6YTcIM03Nqo5fxJ1y9wblLrhuVP997pXj
         AmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756367037; x=1756971837;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uCyWFKVmsqDpuka3mORfqvZ6ED5815cQsuT83UfJ0fY=;
        b=dVHMKTrCzTSoZoe2w7lsqfOHZQfB2abTbnoNZAdyHAT0SQRx9NQqKp856KEVpIltvB
         rGAz8siLDP8W1Pn1kmJ67tfEXj9dv6OOoPAgoORLV/vLtciEH20AOxoYYVG2OERc9uMo
         Y5uhgNhCmI17KkK388FipPae3uiYHaua54QCNssBBZD94YtxitSpV4PJMychr25ooPd8
         EUe5fIc/nJceTUp/LJjkdQuWnItcCXy/b/p8XVrmGLkTDQu34au+HGjCmX+NzcoHASxU
         aX1Ns6tht4L3x2m9Cvw9mxP+UdEaMhZinzqOGjXHAt2inhcpVyPnWVLLh3KTMidme/4J
         CQtg==
X-Forwarded-Encrypted: i=1; AJvYcCW1VEa7GBtMknddaJ15i7pzQRen3TRzM4dcFv0OP3G2xBl3CreRN2yQCrgJlJ8rXNalWrz5WuMteNmcyJwCtXY=@lists.linux.dev, AJvYcCWW/h0+g6SQdTRqjYxv8JoWe3TqG2qHAgdNlLZdT2cgCG129oF0IkPJC8zaDueb6BC+T6QqPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzavVU/s/YRdG3uQXPfDMOs3bCs/Yw/ZJsSMjpLHzb73WYgB5K
	NY9t3iZ6wh0t7FQSPKOuqrWSnXQefHlfMOQZqnIX9mcc7M50WAPrxsdc
X-Gm-Gg: ASbGncsYyW73I+jrfHOBViWIGnz2ixpBrcre6vLGHkdQJA/YLRU6iYJos/2/+h4W502
	Qn7uwO7BI5q7mJLybacbUwhEz0/lJioSu/yHae2MKVnUUgm9tNykPjIws/L5Kc2wCxAcw9dX6J+
	K9nmoUzk8mKzV2TkNisLPFl4ZPGdMW9mh1QH2/Z6mpLH8WxkQ5qDtmAqqfj102/4CGL52RvymS9
	N6mIXIK1VyUt4WUPoNsMbWs6P3UBtdco4Jv+P+e8/SN+2unoAyKIvvhhfZSfXJM/H5VToarcnlx
	EPc4BuxF48vgcKDS/jd80DAjWZAwvq2orYdyUSkKkrXXp0CMKNM3krwO85QblluZ/87Hqwkuc3t
	uRvpFQYmDB15bWSALEDrmdzfUq/dGPaAkCkkkBpXS+AIaT+8=
X-Google-Smtp-Source: AGHT+IFCWGCB9w3JZkSqlrk4a0OYpaWYnOsewLh1z3k9Jb7NB4buZSqln74MwC7LX4UWbpbQGZTMJw==
X-Received: by 2002:a17:906:3717:b0:afe:764d:6b31 with SMTP id a640c23a62f3a-afe764d736dmr1280383766b.4.1756367036783;
        Thu, 28 Aug 2025 00:43:56 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe48fae316sm1165798866b.28.2025.08.28.00.43.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Aug 2025 00:43:56 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:43:56 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, iommu@lists.linux.dev,
	io-uring@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com,
	kvm@vger.kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com, x86@kernel.org
Subject: Re: [PATCH v1 12/36] mm: simplify folio_page() and folio_page_idx()
Message-ID: <20250828074356.3xiuqugokg36yuxw@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250827220141.262669-1-david@redhat.com>
 <20250827220141.262669-13-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827220141.262669-13-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Aug 28, 2025 at 12:01:16AM +0200, David Hildenbrand wrote:
>Now that a single folio/compound page can no longer span memory sections
>in problematic kernel configurations, we can stop using nth_page().
>
>While at it, turn both macros into static inline functions and add
>kernel doc for folio_page_idx().
>
>Reviewed-by: Zi Yan <ziy@nvidia.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

The code looks good, while one nit below.

>---
> include/linux/mm.h         | 16 ++++++++++++++--
> include/linux/page-flags.h |  5 ++++-
> 2 files changed, 18 insertions(+), 3 deletions(-)
>
>diff --git a/include/linux/mm.h b/include/linux/mm.h
>index 2dee79fa2efcf..f6880e3225c5c 100644
>--- a/include/linux/mm.h
>+++ b/include/linux/mm.h
>@@ -210,10 +210,8 @@ extern unsigned long sysctl_admin_reserve_kbytes;
> 
> #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
> #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
>-#define folio_page_idx(folio, p)	(page_to_pfn(p) - folio_pfn(folio))
> #else
> #define nth_page(page,n) ((page) + (n))
>-#define folio_page_idx(folio, p)	((p) - &(folio)->page)
> #endif
> 
> /* to align the pointer to the (next) page boundary */
>@@ -225,6 +223,20 @@ extern unsigned long sysctl_admin_reserve_kbytes;
> /* test whether an address (unsigned long or pointer) is aligned to PAGE_SIZE */
> #define PAGE_ALIGNED(addr)	IS_ALIGNED((unsigned long)(addr), PAGE_SIZE)
> 
>+/**
>+ * folio_page_idx - Return the number of a page in a folio.
>+ * @folio: The folio.
>+ * @page: The folio page.
>+ *
>+ * This function expects that the page is actually part of the folio.
>+ * The returned number is relative to the start of the folio.
>+ */
>+static inline unsigned long folio_page_idx(const struct folio *folio,
>+		const struct page *page)
>+{
>+	return page - &folio->page;
>+}
>+
> static inline struct folio *lru_to_folio(struct list_head *head)
> {
> 	return list_entry((head)->prev, struct folio, lru);
>diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>index 5ee6ffbdbf831..faf17ca211b4f 100644
>--- a/include/linux/page-flags.h
>+++ b/include/linux/page-flags.h
>@@ -316,7 +316,10 @@ static __always_inline unsigned long _compound_head(const struct page *page)
>  * check that the page number lies within @folio; the caller is presumed
>  * to have a reference to the page.
>  */
>-#define folio_page(folio, n)	nth_page(&(folio)->page, n)
>+static inline struct page *folio_page(struct folio *folio, unsigned long n)
>+{
>+	return &folio->page + n;
>+}
> 

Curious about why it is in page-flags.h. It seems not related to page-flags.

> static __always_inline int PageTail(const struct page *page)
> {
>-- 
>2.50.1
>

-- 
Wei Yang
Help you, Help me
