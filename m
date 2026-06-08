Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F98D305057
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934377; cv=none; b=Q8NMPDOFQYWz7zfPBkbB7DpEwhfsT2NLpznzfzK5aM2I2fiJDizep+odKWvopE6uVSBc/rvz2Hyb780ef2sA/QbkPgCLcWsbx/Nd9yubJiPkpGbel31VaNfhmPLtokKwIeIYkYLvVi6hWYFV/GJLfufe3xjTMOtlrXhD/MHTlZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934377; c=relaxed/simple;
	bh=qMImqFKBGpzY00AeIsw8tOiayctAVrs6Ww0bY0rFBjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ohq4lDXJSc/o4cnhi0w9GFBVxgLg2IH2Vypbj3ES4JHFQ+JmmixHtC0NZWKeILOMA/yskxMFrOYpPwz/poOYVZb1mUYoeghVu35jZ8hpuGHwoZZEkDcDmeHCWbpiHed6GbmkroWzlMYYu77E2PGigtDZcvihGf4sAWTggtYShgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=IPtGONuL; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="IPtGONuL"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-915671abde5so375172385a.3
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 08:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780934375; x=1781539175; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iMleNw0mNiEoxYUiy61FpITmPtoPBIE8+C8594s7Zxw=;
        b=IPtGONuLDFOhEHQdW8lkcTUTA8t+xielawn5A0EDWzAGziQgQ3bd/3vRsbV2t8gNZB
         LAsZrdm9RTHhY5onrZ9T55rMSHQNjIeB5aBi/nsTz00XjJI6VG8SbLRgusqFb0Qvor83
         dC5asnJRe0smR14Gh0A3nOxtm4IMt0OKjFV4ptjrv7yBvzvoo4/A1hLcukIXFb6DY3qf
         0X9shCk7KeGa+LCKMAArNJnRMVoBxWuKx3rr5XHrGRJ/N+ZDo0MwiSv80DXWEC0gZZ/O
         iEOZoN67keSyNR8S4z45hojeBk696ga3ody/291iRiEgJDogVEPAbsGoUw2sd2GMeWjr
         usOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780934375; x=1781539175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMleNw0mNiEoxYUiy61FpITmPtoPBIE8+C8594s7Zxw=;
        b=PkHx/pzAsSxCRgFPKHPeHObuvBePcWU/sGky/rJujNNpJKI5tMeRJuOm81raON97lB
         PQ2YjJTj/sVO5Ent2M4NOepwBkACPESqjhrgtY+Nl+NwVfc7AgtdScdkOZXReLFt+zST
         2GxpFad5p0W4tSJLXGduJSP1sWSs43/pmdUU0zkcKbMNxicz1NvdWWzhUCd0aTdlic6a
         33X2ltWypzoqsMCqPsiVaPGnflDRdQXXs+S4qfcYEo80w0vWlPKHHjipSq0CKcZ1J2zR
         TsTxiqfZZoN+KmoCIHnrDLGJjpH2Bf7VbqD9LxFqTAe5Bn4bbL0pVMWOBirxKvpSY6Rb
         +D1Q==
X-Forwarded-Encrypted: i=1; AFNElJ8/33vTcrZxZhNu+1yWTYkGySGaUHnHZyEUXnp9aH5fxkG3WaTpaw6ZNoNdhDZ+R/q7viRMo9w7B24hBNs6RQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqmPmC/dDymXCjPsSj7x5nKQ9CyncVWRMOt+nzJZmcnjfcqE8h
	AUvvqnLJzUW+b+SQu4B0dPhu7bLi3CswQkJ8BHbGK8jFV1wHFg8NneUnHugBLosfNAA=
X-Gm-Gg: Acq92OHWzQ5L/Y50EdM4PIrTh8rhLAPHdX9DGVhlvdacV56jtS/4ne0q1zKYpPiPfA3
	3Hoq3CLk1JC3Ma0fM33VmHYeQodNWK0dLXvTDYXg1Boickx/joEMoPtNAHDy1v4c+y9EkpzJp4B
	IMywsF9qtvcua1KKOjY7SpdMTKJeuhwgnezQv5fLzhEYuG6KZ/YExnEolXiSOzrYX20Tb2Q1azw
	3LXk4RIRVL2nSy6qrX8R+NYeLe0mZRqhKyOA/4DczcTEytOlnHoNItmWl7jpVrvBn8GDpWKLa6h
	A74SHtYpxT9kaSt1FCJNpcsrY7+WdbNCCLV9EOpdljVdWvwCF+XxjJ0MsVFTtdGeunMrpapf5el
	8wVHv1Q/axSZsaTD1x/RmqNDHUxQx0nNJPnRqxoMO0y23mVgNRUdzXJjr4AldeUwuRgJaoKm6Oq
	UF6vctwwHV0H7+bGAFGyjZuYHxeEY7lE8Xj8zynl/hJurmJn1PTV9eXizQKnGnuQBckl8In//+S
	TpTMmU8B2+a6uPN8Q==
X-Received: by 2002:a05:620a:a189:20b0:915:a4c1:8c45 with SMTP id af79cd13be357-915a9d7656fmr1848442185a.34.1780934375430;
        Mon, 08 Jun 2026 08:59:35 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdc6755sm168719846d6.18.2026.06.08.08.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:59:34 -0700 (PDT)
Date: Mon, 8 Jun 2026 11:59:32 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v10 16/37] mm: alloc_swap_folio: pass raw fault address
 to vma_alloc_folio
Message-ID: <aibm5OFmiFK6lCqH@gourry-fedora-PF4VCD3F>
References: <cover.1780906288.git.mst@redhat.com>
 <d2be78654e9dcc7cf5b8a542c2c8f331187c80c9.1780906288.git.mst@redhat.com>
 <aiapFvxPXuPd4-OP@lucifer>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiapFvxPXuPd4-OP@lucifer>

On Mon, Jun 08, 2026 at 12:37:20PM +0100, Lorenzo Stoakes wrote:
> On Mon, Jun 08, 2026 at 04:37:41AM -0400, Michael S. Tsirkin wrote:
> > Same change as the previous patch but for alloc_swap_folio:
> 
> Please don't say 'same change as the previous patch' :) explain what you're
> doing here. It's a pain to have to go check otherwise.
> 

MST you need to slow down a bit.

I gave you this same feedback 3 versions ago:

https://lore.kernel.org/linux-mm/agXUHItfxSwtriRF@gourry-fedora-PF4VCD3F/

~Gregory
