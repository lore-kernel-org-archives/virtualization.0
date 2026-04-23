Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127483126B2
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956235; cv=none; b=NviOBpmShOn0dAdmq/+O7w/YOWDzn8SwN3qj5Ti9rMz0jmZQ4dreHT4Ku7qzc8PwF8f+FuJy30/qZ7GNqPvB8DXKI1SLGZaXu4pcLdXyy/ncXeIWQrVAdC6dD2limodQtCrmSJ9ji6oEjffouD07VBuO3TcrKjmjP9ty5l1j5vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956235; c=relaxed/simple;
	bh=fIawO2hxPLFjqOkLBkMpxy2zyH+AEclGIIHs3EfYteo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7ucg1T8DNBQC10qU13O5Hs6uLSKBypUjv/aV8SEen7EEiyRse4k/UHIJZuQ9bXZSPaoZdQyvS1i9JaVrRoX7RRGbnIDfz/yTLqND4Pnh0Ue1qbBVqt+x3rEhrlCUs6Dfgg3kRdLoXbXaOkjy2MT4VgNHOHsJuFt8y9jNuT0etQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=N9xWu++n; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="N9xWu++n"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8aca6bd57cfso64342496d6.0
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776956233; x=1777561033; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nAoC6Cd2m8uJEAdJCqdAkQcG7d/SgM3iZ532Fzycwn4=;
        b=N9xWu++nAtEP8WrBxFHyOPIOXVHIgRhXLv881JfJ1V5vB1remo+75Hj+q5ui3B633K
         7NpwV3+Gf7MupTtiKsQez3nbofospL4rAg0K+YLT3aBR40zJ5GcTJtID9UIrQNCj2rAT
         XUk6fVALV73FbliZI6JCCEPHgwPKz/8lM6cTcVtYN02QI7WcGSxGeVkr/5c6GtJ1a03z
         yTW6Tx/Je0Wk67wgrEHoly5SduBGi4NkF4NZTtqAzFHHAu5w50apZX5AWcIHU4vUC6Xw
         4TSKiFxfQb3YyPvOPTFGp4VaJY1sg2Xq1aF5+oRKBJmLEwLCyBPLId7fHFEG26QBXk6d
         IFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776956233; x=1777561033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAoC6Cd2m8uJEAdJCqdAkQcG7d/SgM3iZ532Fzycwn4=;
        b=ClAX6UtNZI2rIZ+55mWLp4WYCQG105Tw/GseoM847aqodP4tDVyDNQCEuoAm8BF7fw
         b3d7LqXRUFkuYYTVQux8EEey9aJ0hoUv4gfXMzAkric2hicUQc7yDr1zRjxQYzKo3mBt
         3KNUlrd+33ELy6+pguwsmpuMrva3lpUPGoknSVzuJf3SmH9pueVmk9TLPVgTv/W9F17M
         Mditcm6DtWVQ93UxEhNp3FA7A2uMDV5AF3muBwIDu4yQHUZNId64w6j5dEn9Jr2Kxon0
         2vqw9t0tfI9d8A1X5mXrwkXtYnWVgxNdhPLd2EZOopV4fhhWDnEEmtNXVEhFGlsUvaVo
         qw8g==
X-Forwarded-Encrypted: i=1; AFNElJ9fFyG4i9Q3cObHi7IdJm5V5JM+IXsL1in2rXiXxDpFdTgv4RVjxbtsdN9c0dbjzCuYqwCKe/uE/TNArl/D6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBl694UHb2oVYr2kv3JMK07JTThNyDCwotxamU8jrH9pEQOAii
	0b1FYWHCytRDPErziSNzt6+yux9MesS2+79ymgw9OSacqEO+ucCYGQEc5aMiWO0MuUY=
X-Gm-Gg: AeBDiev3EoMpJW5mLkMYcsf6k4bwnJnT4m2FNhHSsnQUz+/Z03j9/swH0XQtZiyP6Oo
	nYDgqCHo5C4Gu2rHJwLGZBqYTRFz7Xu8D3F3AEEs5PY9j3nUQIV+H8zX9lD8thRrzz9xJEZNovS
	sqfNSkMh8j6VAguCtIisxZCTbcd5yll7phdIbjR7M1KufxyfKcKs4ZnNaPeJDR+okLsm705Hk6u
	l+ClQxjlYDCC3IgldsTrIluyoRuQc7YI+fs8NkdBnRevD+18h44FRywIUCGrN+2EZpisQPS/9Os
	AnobKcCrKbWwwLYvBaNqwqUmXw2L3aOYAKYYES8oK5JS6woxz3KABFPJkFPS2coS1tySP3X6OSd
	sMSRlmwvQ1OsKiQ8n+zBsNw1gYpxJBhOY5uY2wK7EljK+LOFzRDqoLut2JUo/8L5s++CxSV90Bw
	7CCnSTDksFgRc5TENUJYuRDJXjztQ6CO1UdE+CW4nHeS6YEP3frOY/G3aQ+KX0BpJewoyk0rny2
	YLf0vWdNvulghSU3I5t
X-Received: by 2002:a05:6214:4e03:b0:89c:5289:4be6 with SMTP id 6a1803df08f44-8b02805a894mr389230206d6.13.1776956233021;
        Thu, 23 Apr 2026 07:57:13 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-246-228-50.washdc.fios.verizon.net. [71.246.228.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5c26csm164285926d6.31.2026.04.23.07.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 07:57:12 -0700 (PDT)
Date: Thu, 23 Apr 2026 10:57:09 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 01/19] mm: thread user_addr through page allocator
 for cache-friendly zeroing
Message-ID: <aeozRZ9AvW2jTQkX@gourry-fedora-PF4VCD3F>
References: <cover.1776808209.git.mst@redhat.com>
 <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>
 <aekluxNPxF8CN8fL@gourry-fedora-PF4VCD3F>
 <20260422171315-mutt-send-email-mst@kernel.org>
 <aemglPlcwFFHNj1A@gourry-fedora-PF4VCD3F>
 <c165d6af-4a35-4a41-9086-ee307640c044@kernel.org>
 <20260423074433-mutt-send-email-mst@kernel.org>
 <aeohzbmhQAoOODPm@gourry-fedora-PF4VCD3F>
 <88b0765f-7cfc-4e44-83d2-c01a1755c842@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88b0765f-7cfc-4e44-83d2-c01a1755c842@kernel.org>

On Thu, Apr 23, 2026 at 04:13:50PM +0200, David Hildenbrand (Arm) wrote:
> On 4/23/26 15:42, Gregory Price wrote:
> 
> Maybe we could forward the vma+addr here and call a vma_alloc_froze_folio() if
> we have a VMA+addr to have a clean interface.
> 
> But really, that hugetlb code is rather messy. I'd vote for leaving hugetlb
> alone on a v1, and focusing on non-hugetlb first.
> 

If we're ok increasing the buddy surface this way, then I'd vote for
only updating the exact interfaces that MST needs to update for his use
case in a base set of patches, and then have each additional updated
location (or logical set of locations) updated in follow-ups.

My initial go around with this - the patch was hard to read at best.

But I also think we should also seriously consider not increasing the
surface of the buddy.  We already have two patterns (either you need to
call folio_zero_user() or you don't) and adding the wrappers to handle
this internally means we have 3.

It's a nice to have, but i'm not sure it decreases maintenance issues.

Just my 2-cents for what it's worth.

~Gregory
