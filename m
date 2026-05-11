Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A58407562
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516787; cv=none; b=Xqvn8FzWSJl/KNA3hgEzUte/9kyFHXHkNr1U17sfEynaFugBp+jwzRGnWAtlbLTG2xjLTh/CR7EsHo30lh3tysXXEy5zcQo3y77ZpfC2nvQLWWejyyrdYg0zLsDapMYyids8qnYlVegRoTAe03DXlM4hm2P5QuDI17jg+qGEWjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516787; c=relaxed/simple;
	bh=BGuKCJKu2Ze2cpCK7EZk9megGER4Jsu0/UhoeukgwOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqetuzcBhpep0tS2QhR1B6DoPUNBxN5njturXvyU1BmWRE1vkgM0/4i3p/JLlyNoNls8OD3w9KDQjStiHcmhhXUiaw+wCQh+mtqUuujMIyi5kRyMdlOY1NtGehn3eqejJU8Ey+zpRzX/93Eh4yTuziYRoT0jkcRi/HQ7MObolAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=JpFs4uZO; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="JpFs4uZO"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8e8c0c2d2bcso589929885a.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778516785; x=1779121585; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hqw8rV27s2rIaaJU5shbxCCsz/N1fl7ypBY0wN8aHj4=;
        b=JpFs4uZOjkx7cCdzOf/1OVUrwGKjcTF7TCCTJ2kAx4d9mReQOBBvCSpzLkLxCEfRBu
         yzFAdvmfdvp5t5eQlxn2Hlk7fy0xQJnlKFoffQnz2c5W9AULWmktDHZ2jmQoywhLXtG6
         FPcOJggGOwxPxY7fhEDiMKITv5ZS/VXhib8v6AW7p9BMQbOMiK7uin8UEHj5jSEPeMQN
         zXU5mS9sRx/69jdKKJwJynn0vCNS87P2/kU0jKJA5OulH3++5FglBWQ6IcxHXARBpTwm
         9fTnKK4tBghdMhhTZOEX5u+xSW0pCrQvbDet4gbSsrgK1csvMy0VDQD1K8F4jNk0IqDT
         tbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516785; x=1779121585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hqw8rV27s2rIaaJU5shbxCCsz/N1fl7ypBY0wN8aHj4=;
        b=s79hm4xhqBW87Vmg1AthQd9lqdOf0+uT5tQhbB3P5voY/uwpZ1MAlq+i0P03ude+ns
         baT2jkgkyMQde1M9t3dPs2QDTCf9m/bQ8Jd0WyDGEAgLOUCVMYfLFKceYY7/mD/hFt6K
         hZOX2ZgsrwDS9ixq5igE8pcsrYm5S1yOMnusZ0dXonQ+QTr3oNPG9eDw9/DFaGL2uqgN
         AiJxEscA6sst4HnG+SUR1evi7yiK3G/8T1VyTqrRafmISC47LtOsWhvU4u9UfGg3XVCf
         VkqAiMd7cIS/xAkGHiS7Q+rT9/DyfzHDpcPFjBdp1gBOBrL2i96H/RKbpbuniFrL4BOR
         l9yA==
X-Forwarded-Encrypted: i=1; AFNElJ8Bx4xH8cmwy+eaLhEtoWcMzvOCfvAUlYYHALdRTradPMGW19T+n3m46ubE1l5AuxIRQPJzc5FRTPSX1fgEWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyhpb7H4gNgjzvNI5FJ/9pg64hUUCcLUni3JgGFmBB4JaK95DeZ
	gZgyRhpJDx5ntaTyompcJp04pU+9tpD4nImVrLDquxOS/pT2ETglpB1bMLR5MCWFdcs=
X-Gm-Gg: Acq92OH9TloR9GFPubev7CudmDvp8NmTgS9v5rLdeUnF2RiQij+aFZzaXCbmw/jAWSg
	JqeCIb5VTjUHdzuUXFwr67JX/14opYO2vnjgI5RG3aIyjfMrlI4V9T5c9dHhLWxUjSAh4AnkIx1
	aTT4frrSATPRnTGDC7WAl2U8YEYsBJitjjRFN21KmvKcFFqAkj+upy/VoMyztJ4l2z1Yzexi4bw
	Nb/D1GuhZHH/iIPJ0Ii/fguBnYdV+xtkLGTKQReWR/J5TSRldN6vLpCteuk//ArcnpoCHeSZamd
	jmjyGF7P2UFBLbq+PO1CiBeAWVXrXRRtAzUJm2oKxZ7fY+R/1uX0TVfWmAVCZcKzydgZj3EZAFM
	Tze7sZnUwcnbYlKIhFsW/qywa+b9HA6s0zJFoDIQTjjT8H5ohnIiEMDC2+HPi3HQQ3rmXTM2gsE
	6ldRHykEDdkXYCmJM6/Xd9yZgoPxNYczrg0OS8Re74tWJnDYkNTaXjNvYLRd8CuMPNz93zISM/I
	dVAgF7rW+MH
X-Received: by 2002:a05:620a:25d0:b0:909:e4dc:fb30 with SMTP id af79cd13be357-909e4dd008cmr1293290885a.38.1778516784603;
        Mon, 11 May 2026 09:26:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b9772b87sm1059935485a.5.2026.05.11.09.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:26:23 -0700 (PDT)
Date: Mon, 11 May 2026 12:26:20 -0400
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R. Howlett" <liam@infradead.org>
Subject: Re: [PATCH resend v6 13/30] mm: use __GFP_ZERO in
 vma_alloc_anon_folio_pmd
Message-ID: <agIDLD77wTF8ZN1Y@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <c8768c7c2a4965b5e2dd78680c936b82606cc034.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8768c7c2a4965b5e2dd78680c936b82606cc034.1778489843.git.mst@redhat.com>

On Mon, May 11, 2026 at 05:02:57AM -0400, Michael S. Tsirkin wrote:
> Convert vma_alloc_anon_folio_pmd() to pass __GFP_ZERO instead of
> zeroing at the callsite. post_alloc_hook uses the fault address
> passed through vma_alloc_folio for cache-friendly zeroing.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6

Reviewed-by: Gregory Price <gourry@gourry.net>

