Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861192DE1FA;
	Thu, 28 Aug 2025 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366680; cv=none; b=oNbCdPbr3LBaAV+pp1eSvAd78IagWY73BxCTmzYJ4pr7DbrNW3kU+gztRyLWX5qKAG37r3Exc5Ud9s/rWb34IunXyHrW8Mm+L8v9L8Yh0auhb0j2Ke5vGDPB8C1KN9qVUywyIfxlCbSPi3oYqKoiNXfzFu8qfuFN0rNHg93EP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366680; c=relaxed/simple;
	bh=Evx+qHc0PZj/WJzWjKhVcHVcvE7nkS3TygD2JsAVLCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnKX7GTeApjwqNIyVHJnSYf8q9NWNqmX/h+aMZyS0PBlXOpplg43Z4frUnKcKdUJ9yvNq3vAQn+h1tKWjZGy43gH9/CQ8JvcS2GPCDNhy8mxNra+wwgf94r2J5ftI48NpNir/iDGAYG+et05bms89nDp39e7Co6FyjPlSepoopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXSKoQ1C; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXSKoQ1C"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6188b6f7f15so727949a12.2;
        Thu, 28 Aug 2025 00:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366677; x=1756971477; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVrt2ctwbXgHbo+Hn2TZ0gCxiv/sLljbJFjbqAY/TQU=;
        b=FXSKoQ1CSS4xz8tr4anUsdknv/dLu3ldoyKFfrv9dsAGCR/c9DswvhYSX6iH/w7S1b
         BbXTcPUuIloaejLsU3ss+SXtSns1ZY8ufM6gNTTbZlmB87c6bRl+soG3I3KmdQPEkDHF
         K0bwladRI6OKvmjHIWiBBBUK2owsjkWnD7r3h3E5bfXg+4qdYpqKMh0btvCZKRXJTx2k
         e2B8HUb2xar3yEleYY0OCqZ9nvzkCUTbmgj7oAtj7oH2pIOehcIq90Qs7GXLY7FWKICo
         2wTHob/p7EmxzhwV4BHe2/gANtr9TETEfeFgYDsKs0VOCP9lkklW6CXgidNn1UV+EJCX
         r7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366677; x=1756971477;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TVrt2ctwbXgHbo+Hn2TZ0gCxiv/sLljbJFjbqAY/TQU=;
        b=kXlwbKnHzd7wErqG0YYQcN3puqxkJmHUZ7Y/JDgXHTPPoJ+O/me2Qc4nR8S6kmNinS
         C9UVO27Zmu4YUNKXMEMJ/n8PFRfw7wzAb4If88/cbU4/svw1P/o7T1vUUOTdc/TCYuXV
         /jqYuFVjeY14kdd1NlUb1gsbPqMlxPFA67SgiNdyMqaFfqurFNP7h/SIte6PaSSbqv9d
         Z/tJBaZbkNPUTWkDSOAZG/e7L3UWqlizUuglggQgLht9Q2unUDAF+e7BR/1YsDenUJyX
         uVOhm2uYowfmW+A5XYXWI/IYdqyNn9ChamzdkBbtLBsafpEIHe8M1/c4PqKYeAZYWwPf
         561w==
X-Forwarded-Encrypted: i=1; AJvYcCULCgMpvADfxnzaHVb2RvtcrROXm1n8Qz606mXHcJIJTTP2xCiXEIMJLsGUVZggIqhBz6avPg==@lists.linux.dev, AJvYcCXNeJqB6ZIxYifTfD/n1Et8S2gYZwVhamEG5dS3uq1wOZ7KfhgdsuXBfGWtMaKMGt67SkN8gvphEzAZN4aAD48=@lists.linux.dev
X-Gm-Message-State: AOJu0YwLBaH+Aezb0rKpPxRnfdBECyXulqSkciDLnBwadxw9z2nhn0rZ
	CqHx5+KS2LM8gZABUMps6sdUAfZumqAezVM8CNSxQxC9n+fWUAepM2jo
X-Gm-Gg: ASbGnctP6VoJuiUC3Va0CG8/5sKnCdxOKF/WyNIAixUh8eXfbF+wttzcr3s7P0avm7n
	gKQIXWKpoXwZiy06rJJvVwvwKIwiS8lhjH3Pd1dYjHwV69O6hMsMpdzSWpNvYqxgALPpT4LMvzD
	pOwf8ai2Uh/2FH6sQVUiQKUYeJa1cU0jz8NIx3saX98V9ajIU5oryAgQz/Vlz4kmmWN1xXPO3uI
	hLRUuuap+Au/TBybxn6A4S+8pGiDDxGPmxPtQ9i9JLcR5dUjydTB3zsBReTUDxOy7rRb105sII9
	4qfTI5UlGDxOn+IySsqd/W9oi+8DXAooQOV0qMsIO1GT1dchJfbyjjLmqomfiYBTBpZyLhBGDBg
	642x5lPXCAf/h8I8F+nikeUi0nm73lxDS7VHjFCVjwu7RQ0I=
X-Google-Smtp-Source: AGHT+IHzpXzU7IRYTRL9u8s1GDWZ3U5CYmUtBakw/pIBZX/rgdseIwaMMauanPlQhlJ9DDnzYy2q2w==
X-Received: by 2002:a05:6402:52c4:b0:607:28c9:c3c9 with SMTP id 4fb4d7f45d1cf-61c1b453182mr20154119a12.6.1756366676733;
        Thu, 28 Aug 2025 00:37:56 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cdb00baf9sm715248a12.33.2025.08.28.00.37.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Aug 2025 00:37:56 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:37:56 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
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
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com, x86@kernel.org
Subject: Re: [PATCH v1 11/36] mm: limit folio/compound page sizes in
 problematic kernel configs
Message-ID: <20250828073755.gyq5cyafrxb7lnw2@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250827220141.262669-1-david@redhat.com>
 <20250827220141.262669-12-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827220141.262669-12-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Aug 28, 2025 at 12:01:15AM +0200, David Hildenbrand wrote:
>Let's limit the maximum folio size in problematic kernel config where
>the memmap is allocated per memory section (SPARSEMEM without
>SPARSEMEM_VMEMMAP) to a single memory section.
>
>Currently, only a single architectures supports ARCH_HAS_GIGANTIC_PAGE
>but not SPARSEMEM_VMEMMAP: sh.
>
>Fortunately, the biggest hugetlb size sh supports is 64 MiB
>(HUGETLB_PAGE_SIZE_64MB) and the section size is at least 64 MiB
>(SECTION_SIZE_BITS == 26), so their use case is not degraded.
>
>As folios and memory sections are naturally aligned to their order-2 size
>in memory, consequently a single folio can no longer span multiple memory
>sections on these problematic kernel configs.
>
>nth_page() is no longer required when operating within a single compound
>page / folio.
>
>Reviewed-by: Zi Yan <ziy@nvidia.com>
>Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me
