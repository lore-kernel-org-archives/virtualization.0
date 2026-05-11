Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E263FF89D
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510876; cv=none; b=i5jPmvEBR7vEpM+4ftvsXsQ1MPHZu3wKPFesySDlq4+lVFblvAVG6fR06upcOus/MBkcA46eFfRS879sS3TXr9LMpuN7vxcEnTasGSrYF9l/3TXbGZZim5pYBJevKnRMTAcAFr1bzXJjpHWLqS1bw2o+3bQ7/1jqxOmKy/h+Was=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510876; c=relaxed/simple;
	bh=pxBN/r/JCPtPLRxaBeEvGHeqAnUjkiQNVKSST/1w1Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/JGBDy9BlZrdxLw4evroKFm8t9n+astCmw/hCDH6VHLYVua70skTUdRkDdukoZ2ysNoPzukUSWrKZM4ERopRcVs1LoiyvHy7Xlgjjt3qMvhncbimjFl4zARaJz7s/zLNQNoC9I5s88NhVirFkqHXIKC/RHIfP0YpI0+QMrmKo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ubcYjz+y; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ubcYjz+y"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b4eb1fd5d0so41591476d6.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 07:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778510873; x=1779115673; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CfR3U2d6Rd/6gIydstfYEs6i0NLkEBQ6d0p0pnkzOKQ=;
        b=ubcYjz+yYdmaLFWUym4/4kSKccK8xafHckPFsJwuSHqbKCRyi4ORlX8R5AX14a95et
         HWUD9DoXUk7CZaRHZDGyOhApAipI4qsJ784Q5NDOAQdd6f49fhxe/n0AmZM0nh6F4AGH
         USFl39IHjbjh9BRpRGDstwYwn5kFiH9nPFXnUk86kFgZtGRuSpf7kNAjzt6gON+2s5Z/
         27hLWzkStAhLyyTLlxNqLDrWIaIDNV9ab5LZzfkhWZG6G866NYDQVPR57fb/bJIE5ojD
         s6+/YVVBKwmjY59wylf+APRr38kHALvHQ2FRRRsjBZOLw2i9QZUNGaI/E2Nfv5FbZoFL
         NhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510873; x=1779115673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfR3U2d6Rd/6gIydstfYEs6i0NLkEBQ6d0p0pnkzOKQ=;
        b=jRdbb3JDjyTJD+mQQpUBNUCFb7gUlNfNv5WHMPuCZavjLf1g5CtDHTyRv33j4mMNc/
         rMp1rzH38A4UmUmqQFY7YiKBqJOxGm4eczIPZ8GBJKxolwQhjvdItdJ20Cv8gz3VkBXD
         T7sV2s4d3yZ+PbYfa0f6M9f8RrTBvfQ3bZ4Tuc7Qmv5ITnuZthoiV4Lo6R0aduKqklGT
         C1jqg0ZWgIGzShXe4Gr0ttoXIJvmD7SzykYwVAqm3gw3jOtbO5Rx/bJCfEqWdsj2KKHf
         ZymkWobXT46MEbo7LOVZ5Fpoih25QJmyBjJd4hKoXR/3lkFH8UjW2NcN1TTl/pgRlNZR
         X8RQ==
X-Forwarded-Encrypted: i=1; AFNElJ+2Xpe2MXvi/yauQDKHPrEN1NmdwZnHztwY1+pqR5fUMN9ZkXjZUDMFg+38+FTxJWvkC03qlKu3rYeZp21dTw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNwSSQ3bno/MtI+Zqwshow5BBw26qp7w3D0ACKZ++3HRQtSi/W
	zC7pvnlhiBlzRCX+W4hQ9qgR/FAPhdAOGoeoV8g/Hwos2hCJE87266nFeGDsOUxWTYU=
X-Gm-Gg: Acq92OGX28Xu/L0WcgSBBlUaQefOMledNf14B5ysxac9oO/GninW5jiboQ5bMKngYBX
	Alc5ijaNyMpI09x0Vc6nzAYaHKNxApO6BGITSZJygu0bOeqX2gcqp3VVLXrO7x34OvxJaHpa/xO
	JfUoYcvnYcG2ShmXmFwGbbZLaWcELOKyxebbzL/NBlhPnjFn8HGGLnpcV8QRjL8KLeXjar52YHs
	WeQ8pEazDA15dk54zu5u8XhrIZjGk/SZa1IElzVUi+NYtZ/faE3A1b/l3mX0V26rcrSwKLEkEos
	MSJSN0HCsd523hu+nD4/iXcqbRUYxHNsgVcyQ3zBfLntiwpie1EuJRmCh0Hv8Kmktp3+3hr4wfA
	+/eV+2a1y3eMOgE9vhkcSZ7PMwTq9j6KaIAnbqjzXcYW4B7Df5Jlju/lFK6ZnLCmSdTXAI4oQFh
	YE65Wl8f4FPZP7ZT/PI1k40E5ARvWCxdxK5/QcBYV5Or9cAo8136XbK0GvHTHZuhijC+Lxsq6QZ
	t1Z0nHr7HqZcI99qRWCLjY=
X-Received: by 2002:a05:6214:c84:b0:8b0:2d20:ff8e with SMTP id 6a1803df08f44-8c1a4712947mr154948486d6.25.1778510873086;
        Mon, 11 May 2026 07:47:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf39c82420sm105832246d6.33.2026.05.11.07.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:47:52 -0700 (PDT)
Date: Mon, 11 May 2026 10:47:50 -0400
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
Subject: Re: [PATCH resend v6 01/30] mm: move vma_alloc_folio_noprof to
 page_alloc.c
Message-ID: <agHsFsEIU8b9RiJr@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <a26c5850219e349f8a666282aa8003a82a4819b8.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a26c5850219e349f8a666282aa8003a82a4819b8.1778489843.git.mst@redhat.com>

On Mon, May 11, 2026 at 05:01:44AM -0400, Michael S. Tsirkin wrote:
> +#ifdef CONFIG_NUMA
> +/**
> + * vma_alloc_folio - Allocate a folio for a VMA.
> + * @gfp: GFP flags.
> + * @order: Order of the folio.
> + * @vma: Pointer to VMA.
> + * @addr: Virtual address of the allocation.  Must be inside @vma.
> + *
> + * Allocate a folio for a specific address in @vma, using the appropriate
> + * NUMA policy.  The caller must hold the mmap_lock of the mm_struct of the
> + * VMA to prevent it from going away.  Should be used for all allocations
> + * for folios that will be mapped into user space, excepting hugetlbfs, and
> + * excepting where direct use of folio_alloc_mpol() is more appropriate.
> + *
> + * Return: The folio on success or NULL if allocation fails.
> + */
> +struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
> +		struct vm_area_struct *vma, unsigned long addr)
> +{
> +	struct mempolicy *pol;
> +	pgoff_t ilx;
> +	struct folio *folio;
> +
> +	if (vma->vm_flags & VM_DROPPABLE)
> +		gfp |= __GFP_NOWARN;
> +
> +	pol = get_vma_policy(vma, addr, order, &ilx);
> +	folio = folio_alloc_mpol_noprof(gfp, order, pol, ilx, numa_node_id());
> +	mpol_cond_put(pol);
> +	return folio;
> +}
> +#else
> +struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
> +		struct vm_area_struct *vma, unsigned long addr)
> +{
> +	if (vma->vm_flags & VM_DROPPABLE)
> +		gfp |= __GFP_NOWARN;
> +
> +	return folio_alloc_noprof(gfp, order);
> +}
> +#endif

Can this ifdef not reasonably be done in a header?

I know the old path relied on basically mempolicy.c being in/out of
scope based on CONFIG_NUMA, but we should make an attempt at keeping
page_alloc.c clean on this if possible.

~Gregory
