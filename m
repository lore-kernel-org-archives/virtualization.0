Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13B63F9F39
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766883; cv=none; b=TN2QKSpcwtZkfE+oCIvWOM2Z8B27HSDgzQl8mn6N5olsWh2FM8+DtPtY1AS0HJTPWJ7yRUQuO4kCtNZw/4QlzYGF0p6cEqcCEFReJK1XUt2eHi2CFm3qV4n+vOCp5zmP/rFwphiQYTfcL64hevHbRtO9OrhQdTnU1vyCCpCkn9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766883; c=relaxed/simple;
	bh=D00ilq+euMFH6w/lJjs5RWESbbOAzr8/PYOgGDIN55I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWp4AJOj+4nPNoFPHwlcFNI8lw3n4kMquBmvTiEJomfKQ38Ilq6prY/DLoAwsw1GZdRMpvsyjGHgC2JiswxvCZNazX+21WfJ07tBzNDeof3+R/zz7gmdfX3f6gd2zsQWmPVFGZ+jLTRYN/QXszEGnRmb78dTzwVbO7ChhXkEgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=reQDATcx; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="reQDATcx"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50faeb8317bso59107701cf.2
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778766880; x=1779371680; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sc+w8y4pA95T78hoAVZ6GrlC/xHuPVJr/YU1joizSQ0=;
        b=reQDATcx6WZwF5WLMcck/h1lnoN0uFjZwhi5UCUCpYEG8lf0TEugVUnvIcDF2h9yb/
         Yrh28uzTy5C1ayluxEzQSrNzAe9n88P0wD9uPP/h6f9nkFqLi1MS1CJqLrYPjnYx6fhA
         pPxhBJHAaPtDARquKb7FT32/ZzgUAHeutHioweRyr68ZK0WJkcV1fNBjV96tfP5d7GIL
         iY88aa0FV95uR1zlgzsEs5Ycb3w9Tv6+tIUWe3j7RefNUcTKruW46PsuzK52IhfjOZ6n
         ofZgxVcuZIzkxGyLnmNMZpPk8/WETfYe8hz5NCXDKfWK2joPpRlIeg9cRqhK4IL8ixAU
         QpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778766880; x=1779371680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sc+w8y4pA95T78hoAVZ6GrlC/xHuPVJr/YU1joizSQ0=;
        b=DTb7/Z0LzkhzJLnOkFCo4OQqRUgbP7FxyPrrvpjOWKyp7TynWz2LmcjJdf1XaqK44s
         W015C4Fsp7PxMB1CX7surFxq2LKxH5DETLIUmS77GkPaGytrczVWrynPYvvqRgj4/TeX
         FcCyApkbCUB+w/oL8aTLqwEUdAvPyCPiXUShEyZXvi7k6JscdK8kulHPeKRuqJ9JABT8
         mQFn174bCpUydHByaYWfBl6thuJZ6C9qM1kluok5tXLVrmPE5JdDA0Ao4EkF37ZJvYNk
         0HgG1pAo86K3S/D4uaZb93lVqr/W6jTEUn4sMj10T1vOpQ+P3vR4YxaZJ3kSZxDFMP/V
         /uGQ==
X-Forwarded-Encrypted: i=1; AFNElJ8oFepnh+x72ZHg+/k9/tOPKqH9diWYxQ5COelXcx3FHKY/kUPjGGZNy1izUeoBu8L/n7V9/hXbgmdyd3Ax3w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyv6X5FNjFBMau/ixSI4EZU3nA1BqCAgrOoO0C9S9Vb9l4dr6QJ
	cppNPCy2HwjSSHyo933GgTNLvlqasF1z2tKH4CeVBiJhFC5KQzAgLNwyP1eRBKKEjSI=
X-Gm-Gg: Acq92OHxQCQQ9Rh882YXiMdKFD4ITJNui0tc7FP/6zhJ8jvhVMcORsyKRx6hq7aPg/D
	ilNOPW/SH0MQs8KiniTw7IXNYKBTs2rWb48yy3VEdwyTkzG1hEMKuDagAlxOAEaXZ11VeYBJYO1
	AELNqZUAqbCpL+iYgmitCwJ8ujRq8LVZzPJvruv+L1Cy+PfDq11CPvaeWz/jhmVU99WZ8x1kHpy
	S/IgdXcgBodWdUP1JdbH7VTLwdqqp8//xTKyCMcgrdK7oGIXZ90brstZbtXj7A65+hcLVajzlre
	g7Tsozz39K4jeRNSnO8fw9oSeQX/IMM1e4HfnE2HzP3R2b6bICmG+06/dEumIasVf9JDi91hNK5
	HeiDdmOYvS6M+9tMfnz7BOcYjd9Cbd6fTJrAYKMSh7K5JoInBPU8OvtnFF+e0viA8QAgqCh/pik
	cTIFbeMWcNvAKbql2f72/mNi+ZrnJMnFa+qrETAWLfbAvINnq/T1JzoXf9qWptp5kBmmfMFOdud
	+Wvc0uJzAv9K9JXGBLyt6s=
X-Received: by 2002:ac8:5fc6:0:b0:510:dc4:942d with SMTP id d75a77b69052e-5162f5e3f73mr100495801cf.46.1778766879208;
        Thu, 14 May 2026 06:54:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90bb80ed0sm23810396d6.35.2026.05.14.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 06:54:38 -0700 (PDT)
Date: Thu, 14 May 2026 09:54:36 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v7 13/31] mm: alloc_swap_folio: pass raw fault address to
 vma_alloc_folio
Message-ID: <agXUHItfxSwtriRF@gourry-fedora-PF4VCD3F>
References: <cover.1778616612.git.mst@redhat.com>
 <66119d3bab318d74c1586b99dd70fb74e2da1ec0.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66119d3bab318d74c1586b99dd70fb74e2da1ec0.1778616612.git.mst@redhat.com>

On Tue, May 12, 2026 at 05:06:16PM -0400, Michael S. Tsirkin wrote:
> Same change as the previous patch but for alloc_swap_folio:
> pass vmf->address directly instead of ALIGN_DOWN(vmf->address, ...).
> 

Rather than reference other patches, just explain the contents of this
patch.  otherwise...

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: cursor-agent:GPT-5.4-xhigh

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  mm/memory.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 0824441a6ba1..74523bc00d8a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4734,8 +4734,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>  	/* Try allocating the highest of the remaining orders. */
>  	gfp = vma_thp_gfp_mask(vma);
>  	while (orders) {
> -		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> -		folio = vma_alloc_folio(gfp, order, vma, addr);
> +		folio = vma_alloc_folio(gfp, order, vma, vmf->address);
>  		if (folio) {
>  			if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
>  							    gfp, entry))
> -- 
> MST
> 
