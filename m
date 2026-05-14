Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA0279329
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778785020; cv=none; b=q/wFo2p74MFnq09P1IGh+h7KnBTH7hdppNRqxvJRbY+XGDUUcWwugfsxTK5wHyBtMwdRsl49JDxIgHRSQgVYJZrcupukL0OLSLF5f4m7zpZu9OIrb5t7Dr+igY85kxn9koQ0fFoUNlwx8P7wf0W6Tl73PrMwajPidM8glZY3DY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778785020; c=relaxed/simple;
	bh=PTJYSe0IvbiXAB6GYmp0kp0T7miMLyPrJGEmhAbWNn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMlmXRhn8JM3SGtpEIu7qBWvsqK8x1WfUW3IbTjKx+s+4ElndvOAGF85Im0X5m2nERuPk7y1SaGeaOZ8ze95SI+/uSEikGXs9HdlnX9upqN5TvsE4hGxBZMDY3tWfW2nA8xn3lJAB33vCRSvxmXCvAWwMc0xP8S6gXkAIkfbVqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GztpC7oC; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GztpC7oC"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-90b2fcf90a0so23514385a.1
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 11:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778785018; x=1779389818; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V8Dmb/0xFR5yj63uM1EuYrYGpP68khCa5e0rkyGQMeU=;
        b=GztpC7oCdmh7vjcazdotBpUczBgeh29XNVAtStApiGQn1DMuyXjxS7O8aadei7Z1Ff
         b8ioTZSer4v4PiSCfy4CA6JCrtc7+JL0/dbL3S7ZxqUfHFSG3aAlSndT3G5g8yXGxM7X
         OwPVQ5InvVFH2k9PoIM3ipxK2EdAh12HuZkRF0Mswu8BlS9XLVKnKOtF4AmIcWcSNTT4
         FD4OzcukUw86Oe5gz+Y3BgsPM/Nmf4jeawLgpxrjwe5jXKWC5Wxmb2JKu86aoIC+htwt
         HNfYt2Gv3kOT6dkxL4Qd1NAt1W4OHNNQQ270fGxBo2kdd7tUTKAeV+xZwwq0eNgL3b3d
         PPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778785018; x=1779389818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8Dmb/0xFR5yj63uM1EuYrYGpP68khCa5e0rkyGQMeU=;
        b=RBA1GyXXAG1Lk9ZehS46t28h9MylT4IuM6dIVgBhOm/hL9ncFzk/aIKGq/rFflAVtO
         q+1o22tSNElgwo0ltNC2Am5NnojaPAKhEO7SLqgxokfeRz72pNlF8QRZgFKBNuMqsp33
         9hlaWwFkacD/A+Oumt2qzUZzGfNhYM2EF7r24Qqi4FkGfA71P8X7F79VO97hwo0Cj9UE
         SICdc8uR/q5ih7kqu3kUK1siONeV6aK4Nt/SAHrJYbGIQn4hZdPGCTGuW6YDi/M6+x11
         K7sA4FePaNNwtYSM2qF8blZqoIRsiWCMf36uDjbNeajXS9f45jR3NzigIxyjrbyZXQbB
         JS6g==
X-Forwarded-Encrypted: i=1; AFNElJ+enx7K6QSvyEvQMOJGyBVPxd/V70vf68xOQ0Vw6+vGP6DIFaVeM3h/fB3UXA0QcNTFPBrdUFpPLr6FhrKvWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTkh7WenZQfo+AJL7XUq5Nhwd0fpgqlP/YDdUXoSnoVpoxWiDK
	0gDVA3GQ19Dx6FFw744WojE1XrlUN33Nq+lyjJCSi5Hz0Mt/BhZoKZVggeZmHWbixC8=
X-Gm-Gg: Acq92OGn6OiRJhZHIZsHzWhsT8xxuGwoc2c8Cfk6P0bQhzJKh8qgTLd43jOYkjSKW+K
	QLYz1meeKDPMLN2C6ruVcjo+Sx12PJG2yjSKtjWtC9miXMCZ4r7YsSY5ctUlMu3X1hmG+Jq90Kk
	X9RA7vggg3ZwJfwSFk8ZUTh7yNlkFKKATojhEqBk4OdhAVHyKnJLADk7SPrkhD779WUbHOZmceT
	ODl0dhf60Ncm8vn3cY9IUg1LyR8BJxilGo9vukbVVg1Q/Zm/VoHjk8yDXhrNQfykc73e2TSyODz
	C+oi1XSCWiybRyzs7pnwoFuYJ/7s27OFpp6Z5X7SOOdrecSw3QOhSe1SoQEpkAPE2dO2pjqaYye
	SheWDoXwrEOt6Od9w3/PGZjfUsZm8ou37I0tnv9Dgy+o6qg11aSh+Wr3yu0l2rASfARGoRRNOPB
	WYTTdwr7NRJfCXFlqIVtQDoliu34h06k4tDzlYzMbQXe+XnmiFSWSoatuk0P5zM+qNlXFONy7Fw
	JbM2hMhB+bx
X-Received: by 2002:a05:620a:2587:b0:911:c5c0:d5f8 with SMTP id af79cd13be357-911c5c0ddbfmr149858785a.9.1778785017499;
        Thu, 14 May 2026 11:56:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90874e4besm30437366d6.2.2026.05.14.11.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:56:57 -0700 (PDT)
Date: Thu, 14 May 2026 14:56:54 -0400
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
Subject: Re: [PATCH v7 09/31] mm: use folio_zero_user for user pages in
 post_alloc_hook
Message-ID: <agYa9s5B7OWG-kjR@gourry-fedora-PF4VCD3F>
References: <cover.1778616612.git.mst@redhat.com>
 <45d1ea85b574399459a64fdba28fcf04abfa3e7e.1778616612.git.mst@redhat.com>
 <agXS7dMmtJrPhu9W@gourry-fedora-PF4VCD3F>
 <20260514135214-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514135214-mutt-send-email-mst@kernel.org>

On Thu, May 14, 2026 at 02:00:31PM -0400, Michael S. Tsirkin wrote:
> On Thu, May 14, 2026 at 09:49:33AM -0400, Gregory Price wrote:
> 
> There are calls with no __GFP_ZERO but they do not allocate userspace pages.
> 
>   - drm_pagemap.c: GFP_HIGHUSER -- no zero. But this is a DRM device
>     page migration, the page content is preserved from the source.
> 
>   - test_hmm.c: GFP_HIGHUSER_MOVABLE -- no zero. Test driver, pages get
>     content from device.
> 
>   - mm/ksm.c: GFP_HIGHUSER_MOVABLE -- no zero. KSM merges identical
>     pages, content comes from the source page (copy).
> 
>   - mm/memory.c new_folio = GFP_HIGHUSER_MOVABLE
>     - no zero. This is CoW, content is copied from old page.
> 
>   - mm/userfaultfd.c: GFP_HIGHUSER_MOVABLE - no zero. Content comes from userspace via userfaultfd.
> 
>   - arm64/fault.c: __GFP_ZEROTAGS not __GFP_ZERO. MTE tag zeroing, not page zeroing. Page is zeroed separately.
> 

Right, so in all of these cases, it would be just as correct to pass
USER_ADDR_NONE I imagine :]

i.e. the user address is irrelevant, and the caller is responsible for
     sanitization before return if it's relevant.

Otherwise, passing (user_addr != -1) the buddy takes care of it for you.

Just an obvious security bonus to all of this, but by no means a
requirement for your set.  Just an observation.

> 
> I'd do this on top if possible.
>

Yeah reasonable.

~Gregory
