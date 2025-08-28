Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B240F9D6;
	Thu, 28 Aug 2025 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366314; cv=none; b=eBfDKrVSVdeLesymmW/8dNT+dpkdLEAIYDMjJ5EY0lSVEEOMJgfHvHUXPDjI6wXQ/kvuAN7qFIxNnCpKBxh5TGVZiCNfWdfArIczBB4c2V703o3mgOZqqKeReCyk2SN1EOifrMOmjSu9Q47NuqN/qB+iTqlqNPvLweOAsU5+vLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366314; c=relaxed/simple;
	bh=TpwyzypEujQZAeEzgHHlRrVk+R8i3A3xvfnvM9KGUhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDUlxMJ/d8KYNdc8PS876M1qMcHSRnis70mi47IzlpAmQkqPmYBASzapRiOXI5kTrx5dIbyqKdpHHERiyPhUp7dNVlnNvkq6FCnEzij36HRnCZOIo6YaSa86mWbMx6mTgkOFlI6bu8U/4KYj+KbV8Go2qPPcmg1vjFnzNgPO+CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bahPbd19; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bahPbd19"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c79f0a604aso343874f8f.2;
        Thu, 28 Aug 2025 00:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366311; x=1756971111; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuV0vIwmYzbGp0NvCAEdvEWsqc4i4ounAUIZgXtsn78=;
        b=bahPbd19N5yYu29vE+Gz6Y/Tc6trrqgILc4jzdaeKrb5LWirQkmkWmiWtyvfHSRA1W
         QN3OeNDsdaC1gj4de3hH1oB5WFxuJz82iQmlOZox2JZ8bC02PKSh+zpmFYuuQhHC+7Zw
         bleI4wGOuIve7wjZN4AyrNcl12yscHPip+b3Pxm4nDde8VYwwPsOY625Vg2/2E1dXdJ1
         +faty/1C6fbzcqV53XLuzoRFKpN/q0XKwy9dxwAej2S8S9/qQQ2ND+IKeIAVA1YEbRUD
         tQEK/YYf7LVlxyrsgZu02QbA3adUWh2rlJIA7VoDtXNtD1CeU2aHXzkMDBTc71EuICr0
         Sadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366311; x=1756971111;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EuV0vIwmYzbGp0NvCAEdvEWsqc4i4ounAUIZgXtsn78=;
        b=hyBmQwDx3Tfo1cI0rq+1xvF8AyVEVmJoW7olW2W9fquCpINhrE37pHFnUnwazLRRlt
         1JWksBiF2nx932tB7gmDmJwK867IDzjfnU6FR4UeUtQ0AXSPxlGhEAisa8cl6Rq1fENo
         RWdr5L6gqi+wtxSNN3ePUbn0XC0spETxMo1VZdganGdxlvYvZbodp+LM5UjE6sOXEisX
         3uQ37e9vcF1gwyEdw8WGe5Nt8AF81JEAuuycyEObkbjeyFHUBDORgIHYhFAhXC1xtXRE
         keD6uxJgmM1rWQppVl5OZKYt3omiEhM86dQ1CSNUbqrU9/dCv3cs2Mr9Pv4u1LkB6++U
         ZSnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPVAzuh771Z0cB69grNRjauaJUH+46768pa2Ywyour37ZF26BNmXIAIzWd7+SSwBnWyXMs4uLBjKOKzZvpxns=@lists.linux.dev, AJvYcCW61Z+urbOHUeu/SY5S5kSG7hQF+7zIyoOTdv8MtgV0u5UGPZL6VV9dz/ZsI6ctTVpRdfl3yQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyL708uGIcWg+IEtUfG/TqnT32LXwQ5+EMZ1OzZgoD4DQ1lmPfE
	/gtria6ITpzoyMZyPbcJVamh8HRAwYFclWdUp6dY7BwRFCvyNyUq3B8O
X-Gm-Gg: ASbGncsL/DBNzc6N3QpG+ziORUfMI5J4NZ1DagA9WupFlBQCOrQ4B05kSJVCNpSVgh4
	yHJyH28sg4NS6m5HONGp81KwILFr8SGUFg5PV+gHQzplrusDV4rptB+ZcDD/a6i5WsPEmwFEWq0
	95iA2RZRMMF9u10KslVQyWdE4+p5rwJLaESDJvfqVRkPvyP7a10h3NNnCw0z4SiXA4yXcQc2djA
	tdUvgebS4KB2eRRBd5dl4VRxXt8OvlbZyAgb/fp8Wv5yjRTLVDgAwVT+dJgx/hrIL1LG/oV4tYT
	IxjUM7uSXwQG530WV8DOuT8t05T+o3//5pj0fY67RZCiOC4XbEfSQ2M2esL9x9ktwUimD0btBtc
	WVoKKBrMO7/+iQw1n5nZ7a9IWsNo5Q5y+O2tL
X-Google-Smtp-Source: AGHT+IGYsCTFAB2u+mO+a+/7YQm7WCRYBnf/bqNrDbgJHuGpC+AeSLNYygCiHCIag3yJJPklKDadWQ==
X-Received: by 2002:a05:6000:2891:b0:3cd:96bb:b948 with SMTP id ffacd0b85a97d-3cd96bbc28fmr1837267f8f.47.1756366311260;
        Thu, 28 Aug 2025 00:31:51 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c9c9324dc9sm14883755f8f.3.2025.08.28.00.31.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Aug 2025 00:31:50 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:31:50 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
	SeongJae Park <sj@kernel.org>,
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
Subject: Re: [PATCH v1 06/36] mm/page_alloc: reject unreasonable
 folio/compound page sizes in alloc_contig_range_noprof()
Message-ID: <20250828073150.jyafkufvkjfqwp3f@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250827220141.262669-1-david@redhat.com>
 <20250827220141.262669-7-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827220141.262669-7-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Aug 28, 2025 at 12:01:10AM +0200, David Hildenbrand wrote:
>Let's reject them early, which in turn makes folio_alloc_gigantic() reject
>them properly.
>
>To avoid converting from order to nr_pages, let's just add MAX_FOLIO_ORDER
>and calculate MAX_FOLIO_NR_PAGES based on that.
>
>Reviewed-by: Zi Yan <ziy@nvidia.com>
>Acked-by: SeongJae Park <sj@kernel.org>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me
