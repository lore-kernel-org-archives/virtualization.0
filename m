Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716DB3DA7E5
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511593; cv=none; b=Qczbb0xMT1aeLyHYHM1COanDNTOkwoN99n2jkN++3wDkTO5Li9NxE+eQix/yDGK6N0/+S/SbjfAzuBE5DP69SKm9pJVGq2iSQ+OFWk9T5nwCYHthfSR42kQsCfNOQ0qKZQrqCwXUxs6jvGg7ENG2cfa1Ob7xtjOl4WsLoIXZ/ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511593; c=relaxed/simple;
	bh=wpi1AMcW2tPPmZcxQdUUPjQAl76NDRV9zcdDLvVS+oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRioaRdpCT9bMtfokC3E3M0PI5aYkfMK/6d/TXFiePC8UbdL6o2HLNXq/CHtGpcQhGVuP/rpCJCC5B3hQcxesTIwyyW53AY9nXyEBLWtxGOwyYR6HZO8X5d8f8cz2+gZMP1zF35hjH8SRgA3fsF9oLdJ7gXohPuUOSS9EbrfzuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KZkjH9kC; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KZkjH9kC"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ea8563c693so480319085a.2
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778511589; x=1779116389; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7h6hiVH0/NZ6Qfi9mJnbfpbwuzxv04Y7rZxb6Vb37aU=;
        b=KZkjH9kC7VVm5cdIvWXBwtBxbG3vcWtBCJwyeTAKjY1JWS/PA7LB73TI5Xdxvg6/ry
         MpHXJgP30USP8nysXhWiQ5ANgFBUOv8VzW8mW2tfp5GG1sH4bv/rC/qeXfx85ClzpIFy
         Sy2NavnLenK/lWLFB6ylN3EEWZYR/qVZ/8Ykyo+b4/7GKKM88Z/NXCdOFbMYeyaR96bH
         rtLEI0x6+kdMAPUFmYN3lJFkLu5GmvzH9Bd4rtxxUrhEEazHIriLrQFMBpQFI6aszez0
         iyZ1qVSPGTy9GQgH1nMgk2dDPyp5e49ysjZmN2znvZ5iSTflu0BJSY7+MnNt8CvtS3+G
         kvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511589; x=1779116389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7h6hiVH0/NZ6Qfi9mJnbfpbwuzxv04Y7rZxb6Vb37aU=;
        b=CPaXmcI7vp91ClA1VzV6oA6EG5LvVriSmfihttv11dADByqKhz3/coiakmRx/kJvtu
         b6am6b/WJDbYgecQkTgjhOa8tGhbZjjmLZl9jPKNCMES6Oi8iZXx4vN7BCslCjX7aOv+
         FGuhAAKauKcBsaO0HipDOBXfQV5dSNdXWhV+HmFbhMa7FJNCfWOTbm1yE+0U3uQC0xsB
         5zhjwJ0A74o/ou1glVmrBzhlmBRFYNGmuakxHXpqWhpo4juJ1/2rkIRqvUe3anWzR5N0
         XAREYuhvvROparsTfoOtK2RXZJJpA745Z87UeK/mH1Yp4mBYum+1KfWmENpK6hLvn5YZ
         NM8A==
X-Forwarded-Encrypted: i=1; AFNElJ+RUHJoIDJTNgW8LaXDpq/ggouLsJ5HFwzVr9LRscbMs1GLlZybe1n7lPbH/MRwt6NpPBO0Hcdud/pPjuRt+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIHeXwqsZAOq/q8Izi5yH97gZGeSftfcry7jCqX7NQ22Fdv2ze
	7TuRtIHCRKeaIwfLW9399oHPY4HfEiAKMkh3tM6Kvz34ocgNDyTPi8AtnqKYGvzGHQY=
X-Gm-Gg: Acq92OEFHz66vh+ETN2HOBj0jYwDimiFwz9KuHz0Ji7xQvYVkbWiKymcI8LIgdlqf5Q
	fMhLWFLXFM5vCkoYqxFQ+/85RdXY4vD9iq7V7uOZumALgRY+T0j63VHWtJtfu1V6XFdD0uMkUyw
	4s6bguoMnXX4Mys1Lhcqir2hsCG93Nx7P8bDQf58UzT0ZmGnZKg7MAkEyTjISVbGxn3CTwVISWF
	bDTrfWuV8Gcku6mxcgy449kXVV/7sjSIYx/FPtlAFaWIUpxX9h0bQxiqkKhtEEv1PpFT6BF09Fw
	ImT6Xx88u9Qk84gQUBplQQer4bixoHMANBdv3aPIXVfIWV9D/OA5jnl/1ycoKmErIaW4X60TRj+
	pXFj/eDNeJkfS1V6vFuwlo6jqxGqnoUn+sX8k4G41Zu1cHzab7uIyWWSZlg70g1o++aO/kmOEA3
	CZvWbY+76iHSOIwJoptC/wPuBLNhssbD5hUhR9qDyAXbIhVXjxtvHkUWhFpVkyFb3mGEGDYKQax
	Fc3dGVhLqm8E3Hp+LHYX9c=
X-Received: by 2002:a05:620a:1788:b0:902:afae:fd39 with SMTP id af79cd13be357-904d70c4754mr3575981085a.57.1778511589271;
        Mon, 11 May 2026 07:59:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91c813sm3112985985a.33.2026.05.11.07.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:59:48 -0700 (PDT)
Date: Mon, 11 May 2026 10:59:46 -0400
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
Subject: Re: [PATCH resend v6 02/30] mm: mempolicy: fix interleave index for
 unaligned VMA start
Message-ID: <agHu4iaL-3By0YuC@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <41bd50fdaae943e1a79215ea4000322e74a823be.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41bd50fdaae943e1a79215ea4000322e74a823be.1778489843.git.mst@redhat.com>

On Mon, May 11, 2026 at 05:01:49AM -0400, Michael S. Tsirkin wrote:
> The NUMA interleave index formula (addr - vm_start) >> shift
> gives wrong results when vm_start is not aligned to the folio
> size: the subtraction before the shift allows low bits to
> affect the result via borrows.
> 
> Use (addr >> shift) - (vm_start >> shift) instead, which
> independently aligns both values before computing the
> difference.
> 
> No functional change for current callers: the fix only affects
> NUMA interleave and weighted-interleave policies. Current
> large-order callers either pre-align the address
> (vma_alloc_anon_folio_pmd) or do not use NUMA interleave
> (drm_pagemap). All other callers use order 0 where the old
> and new formulas are equivalent. However subsequent patches
> in this series add large-order callers that pass unaligned
> fault addresses, making this fix necessary.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

Should this just be pulled out ahead as a fix (assuming this
set takes more time to bake)?  I get it's not causing issues today,
but the interface is otherwise technicaly broken either way.

> ---
>  mm/mempolicy.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 6832cc68120f..39e556e3d263 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2049,7 +2049,8 @@ struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
>  	if (pol->mode == MPOL_INTERLEAVE ||
>  	    pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
>  		*ilx += vma->vm_pgoff >> order;
> -		*ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
> +		*ilx += (addr >> (PAGE_SHIFT + order)) -
> +			(vma->vm_start >> (PAGE_SHIFT + order));

There's enough (PAGE_SHIFT + ...) spread around the kernel, i wonder if
it's worth a define or a function (not in scope, just pondering).

~Gregory
