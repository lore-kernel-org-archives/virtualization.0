Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE608429830
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516279; cv=none; b=IBxQzIAPGkPaA9v8hCxA37MWExCw2Ox2rR8kUJhvPk4hNTuFURFoBTaPuXK8LvgGqS7q36zau7nPAG5heblt+ivucm+6wmi+TIL2EZ02YRKeJMa5DIvSlrX6mULsiyRD/KUkfW43MvL8Jz/LneZ6WCKdaNeIWzUAsBfmj6fysCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516279; c=relaxed/simple;
	bh=drn3Kgf2td70TL12R8cZJsDEuW/Xzh3Ghjtpf9wzla4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ3G9VBomtb1jiVcJH1M20Mktau3f1bFP/6Gvyns//N2SZLGSgb0Y7S8xiN1lhhjfxkc8EWu5+oO0EPgwcoA0gYwTACHvU6xD3Ky4k7H8ksw3h5Pk/Duhg75XCRjQCJhdyv+Kd865fhrXy0YxtF0gwDNx0NcrlzLOuA05Xn1420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=JYnojaKU; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="JYnojaKU"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e5bea4045so33286191cf.3
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778516277; x=1779121077; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=drn3Kgf2td70TL12R8cZJsDEuW/Xzh3Ghjtpf9wzla4=;
        b=JYnojaKU/Z9D0p0if6SsscnwgY5K8qJe4Al9x4g1wXkcFp34n5qfuObDdZwQI8skb3
         02B0HAmGs750G3R4KNCCPtey/uOpJSNPTzz4c02wsjgkQY0B2z8r0bQRwvYWDycyq26f
         mMAcakp6VBI/HB7I93k6rrQM+Qsr/MAPD9nYWmg9SdMybkJO8VzB7T7e16do0qiPJ+Zd
         l9s4PgpNrBXcQQ+O1y/32C8Sl1j5p+uCXQsUFSP2cqAu6XfIusc+1T0CNWjR6JbwkXWU
         x8xppHR7OIomll/q8GLp2Vn7OD7P4aEMS2Jj6q4rOJhXwNE/dIzEoDMA4R6W2VhoUjar
         WuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516277; x=1779121077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drn3Kgf2td70TL12R8cZJsDEuW/Xzh3Ghjtpf9wzla4=;
        b=RiLF4CBuUX/h2nfoy1U3Twh3a26YLTl6tQ+O3+qDXUBTPjCchZhWaaZ5Op+4Q77DBJ
         DH4LxnPvUU16gtvNx9TU3HL0whRrFa8PKs+Vc5KXoslemJeAgPmpJOpr+077BaMNKVSR
         4+iy4ufE9foaouXsXZhKYSOieibeCdH13/jJElN//CLHwavWc0Uq8zXwNguMtIVBRuhl
         SaSxAJBLr4th1aEtyFJP3a45OShNjuN/1zU4/k+aYO2niperl/wANvr9ZSAmfhs7XNbg
         PaKVCD0fhBHFnRXYDiV9XFooxGFH4HZqy7D8sc+/4vFGnq1gQOwE9G2VJB7NkDYQNZy1
         TV7g==
X-Forwarded-Encrypted: i=1; AFNElJ/PiZUj11FdBgmcimmdFTQLXlG+MFI7keQTkV5jQi7RvtqcKwxx3QJl+qHkBY7X3Hbne7TNOZPdlch937H5HA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwET4YvUH28YehZPgctAuYbS1lo0RKksW9IW+Q3s/MIBkFrmMK1
	tM9P6tBuIY0Z2CStm50cGtkLj1A9ok31so71hWX5oU52d+zFKfCoGKP9TWjenxxM6xg=
X-Gm-Gg: Acq92OEITbe3sCZt5/nZrMtS6QjRqqDAlNxvyI5XfZH0eU+pjBBZgSEDp551rJxFtNj
	7zVvM2f2BJ5F75+V/SiddC8GIQPhansUlJ6Oos8CHV04cBa4AYzUc86xLaU2h/us3ZVN/tQTDAd
	N3vaQlZWiqixlTr0rmwa0JHn+ha90e+fxgshOZuCp+asDpdyTp/R6Gyw3ZuwOsE4qHErKOLY2mQ
	efYnk/VUSzAL2m9OgZGpUE0PuP/4Dz3Cot/eZaA9VwyhsP0qzQXQeqcjd49beGuM8HNKvkjvAJG
	K0hiTFUb74x1yT+OVo/ofb75iR0msIIb3p3DsnhPNJAUwOkNcBvDcmBrsZKvbzUWOqp/vnHvYmL
	06nfDzSAXFJhDdSBIuGM2OXHIMB5sj7JUhJ7TYXFqvYm5QyJHHQDo70qYHiIqRXPprTbumAvP8f
	XAhK/RdBsXbph5agBSu22HK2K7J5byx9p/4lgJNwKgptmD7cEppwmTfHUd84M3oilCJGqbLuQX6
	wu3ksiwrJpZRp9HHrZmUHwRXHGJw9cj4A==
X-Received: by 2002:a05:622a:1f93:b0:50e:5819:d7e7 with SMTP id d75a77b69052e-5148e7ca3cdmr210623261cf.3.1778516276480;
        Mon, 11 May 2026 09:17:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7e97c8sm93404711cf.22.2026.05.11.09.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:17:54 -0700 (PDT)
Date: Mon, 11 May 2026 12:17:52 -0400
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
Subject: Re: [PATCH resend v6 12/30] mm: vma_alloc_anon_folio_pmd: pass raw
 fault address to vma_alloc_folio
Message-ID: <agIBMCYTKsFXYhCt@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <20ce2bd8227c0149fb205d293b47348c3ef49974.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20ce2bd8227c0149fb205d293b47348c3ef49974.1778489843.git.mst@redhat.com>

On Mon, May 11, 2026 at 05:02:51AM -0400, Michael S. Tsirkin wrote:
> Now that vma_alloc_folio aligns the address internally, drop the
> redundant HPAGE_PMD_MASK alignment at the callsite.
>

Same with prior alignment patches, seems like these should be moved
ahead.

