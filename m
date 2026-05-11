Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727C42ED860
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517564; cv=none; b=VONhn1pNW6CFQIqE3YCi5OClvl6dP8G5xGAN5E+pbhslY6oXGKP3X34ctBwpaiuUXtlYMOyfpNHSwYBXsz6tWyE3/jv9lxOGNVN6O7pCNFPbfFQbf2jihGr2ptwMOaiVNchCEa+ugSlrGVtnU4ws44ydlA0c9Mcrbe4XpP+shgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517564; c=relaxed/simple;
	bh=4Z/pGmsFR+R5jgi7XomTCcdweLDmhQVgfxAEbIcOHWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFjbAP/1O3UYUciH4dRsgbbGWcl0N9WARxRUJo2Faw+RoBEzhY/W4bKWbn/f+5I2VFd/Y2ub1r81SlWUf0NSVZp/6bWoHGj18/U02qhLZFMCMs0QJtelxvkwIFJDy0q7XvOO9CdGqEkMGYcOlJuQZXL4v1IZ4/gnB6CiELMOXT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VmedHgAs; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VmedHgAs"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-900fa9f178dso488273085a.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778517562; x=1779122362; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ic4BaUG28/kqkN2pOVPcrp/DL/iwy8HK3B1u3S3Yl0=;
        b=VmedHgAsVWTawcYViugkQKv8FOB+B5WrIrXdsv/J53zRBRqxEwQKq27nDTBoIOdSgm
         yuqltYIufFZLFtTnnQRHvcK6FL7QSl0zzBGzUFD2jcgPQEGc4/TIkkR9LmHA83QuLv1k
         CAWf54OjXcYZUXM/iq7GPKYZVP9vjFj7CW1yZ3V45ayemdbcclqYocrQrEh5pMqRf5RA
         JXqVJI4dUlgDJe5IncVHNlKvEvtR9y9yGZiTSzVVJ4SQxgorFwvhg+L9nAGezbf41m0g
         ISureBRPieQFXI2/Vrhf1Ih+X2Rl/amorr9loAJaHhaAPsQsPvPK+l6y8PeAYfnclpIt
         yUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778517562; x=1779122362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ic4BaUG28/kqkN2pOVPcrp/DL/iwy8HK3B1u3S3Yl0=;
        b=KXWcRR55knqC3op1LGs71SSecMjIl32f6Xewc0A6GQC6/ZffeaOvEsExixYrZ5f/th
         BZElNpF1HZTp7FEz9dpQ4/5tLmWjN2vun5+2E+ebyGF9iot602lJ6picgReKAYLu2FbE
         f86p3WWt+nhcA6wnaUnyrXj2T1thzvGbw7rXxx+giEJ5jJyKJ3SNn4gL/F6EQOdAq3CB
         D/kbyVk3w/MqzvUbgKb/w2/w8mXMq1YksO6K3XQnzYr0QGbMK6G0fGUkpwjNqD0Aj6sj
         4b5IYB9QBkFc7M4q3qIIvCWVRu8zCPSfrlvoHQIwhl9XkZFDvgtJXLyLDN/jh5OYUH+Y
         GoVg==
X-Forwarded-Encrypted: i=1; AFNElJ/pVe9XizSoumwVOicyDeHSRVxaO1SRZG4WrXdCe9AKsOGT5tkw+JqyA2H6f0P48EMqakLZ2Cx1Y31Oue1OVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfxIOlnIWlFmltrIBjoEzpb2oAtispCIn3nJM1GXeqSynJntIZ
	WH8nJleotzD3XN1z7tha/kpXs/s0lDIOUzmT00AvxlM7/5n9xtIWbWTRfvqiF1IrByw=
X-Gm-Gg: Acq92OFa0tQvz8rEItsEh5zAclhszcIMiCYN7ZI3XE4x4f4ohaeIt4zbLxlj33zveA4
	usYvVbhAYdzuFuNMPfsiYe+hy7PE+NNpfa+YBYiUVxmQjKUlSUmzi2Jsy3uGQDDRPiUGINKUtGV
	KVTfhfpN/rrFXkbOwrU5Yybvd4nhnkTQD5ouBXQgkjJJ4E+JyzlwLaXSNVQXzJmLSW4Z5wVS+Aw
	o2J5obQkD+49Quj5FgxzZT1Dt3L3yXWxBeubR4GA08oLu5Gw17Y0fGXp5lbBJY/H5oNOI4HboWV
	YVU/y3N9YDvP+eAixA+hnMdP9u3vQZT2cMIyVWHyd+1IHnVKojmZ8+g9JOCn0TDCncO14xbIcQ1
	DbBt5zz2GbS0iBzniiQJ1ok71BBdCR+7uSZZPFlF9+NCh/7makoNvX0N9Rjh6dZcC3H3wXilMUM
	6jMjoP1C/5/IYut3YY8SSTlA88emRaSyyjeSSHJGWfwNCrQbgXSJJL+NirbYjYJUOvuewzYWL9o
	56pA+xTj2af
X-Received: by 2002:a05:620a:3706:b0:8ee:21b3:2eb5 with SMTP id af79cd13be357-9090e2f7bd2mr1517107185a.6.1778517562231;
        Mon, 11 May 2026 09:39:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c9229c8sm3399020585a.36.2026.05.11.09.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:39:20 -0700 (PDT)
Date: Mon, 11 May 2026 12:39:18 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH resend v6 15/30] mm: memfd: skip zeroing for zeroed
 hugetlb pool pages
Message-ID: <agIGNvfVCJucGUyT@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <a39ab8288aceb244bdb31141aa9cf67106c0e042.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a39ab8288aceb244bdb31141aa9cf67106c0e042.1778489843.git.mst@redhat.com>

On Mon, May 11, 2026 at 05:03:08AM -0400, Michael S. Tsirkin wrote:
> gather_surplus_pages() pre-allocates hugetlb pages into the pool
> during mmap.  Pass __GFP_ZERO so these pages are zeroed by the
> buddy allocator, and HPG_zeroed is set by alloc_surplus_hugetlb_folio.
> 
> Add bool *zeroed output to alloc_hugetlb_folio_reserve() so
> callers can check whether the pool page is known-zero.  memfd's
> memfd_alloc_folio() uses this to skip the explicit folio_zero_user()
> when the page is already zero.
> 
> This avoids redundant zeroing for memfd hugetlb pages that were
> pre-allocated into the pool and never mapped to userspace.
> 

Same thing here, seems more like what's actually wanted is to sink the
folio_user_zero stuff into hugetlb.c rather than make memfd.c request
for zeroing - and then have to check again anyway.

~Gregory
