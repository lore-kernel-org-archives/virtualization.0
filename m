Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371A3402B89
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515441; cv=none; b=JEtIUBSD+GzIYZAMUgjLmISQIf8NaF13qyqwN0SSh57eUBuNCT/xDjOyJVUFehDe+Vo2kaoy7Vy1qLUvOyJOl245hueCqbrV8kbtgu82AQa+M5h+hqBs5KdTee71yn8RUBFVuMy/ia4t3FMeaocs/mxuwGuJUnNhyoC94vgogC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515441; c=relaxed/simple;
	bh=ZOhCqyox8od94l1n2MQHg0B7xGhyCrDi4HynyRd67Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjP8NMpsh3ILyFg5LC1SdLHy/m2dHGRK2nNj9lpltcn6cgjeSh1ChIg7YnS5o2CG8P8Wh/EvwQKeiyN2lROb7YZA5nQ3wcj6hZq26PI4KFMAssz+TNzedD3JncMUthOH4arau0o6mD4WruH+IndwYaCrutwPPjc4BcTBywm7VZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=k1Pp+thw; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="k1Pp+thw"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8e8c0c2d2bcso587299285a.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778515439; x=1779120239; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dApXG6ORKOxT92uQJAxaYBkfzHSro0hmS5CsQzIt91A=;
        b=k1Pp+thwiDDmKt39CCPR0f59Jx70Xzz8dZu5iIH0dChukK0D1I9SMT4PinyUOeyg+j
         MyoOYezo+3klMzMcXcTX0AWgvZJRgLQthxLfTO7V3z9qB/dQNuBbjyZSCqgBv/zTP6L6
         8tQNqJyUKYVENOb6GBjYs7FvC8220iK7kF6f9mvG6mi75HAX2yLfO+P+tNT3VSGOUQdx
         lGBLktmj3uytS3Pl80vwkO2RqKqEuCgUx13P7WSxgdOVGl1zdpyGOv+KOQJCu0OtIL0W
         fRzMf+T/3nlj8nxmFuJLu/qrRlh6uXlBuWU8FfLbQF9Gi83NiEVl4/rd5ywo/hPbiHA/
         Gfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778515439; x=1779120239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dApXG6ORKOxT92uQJAxaYBkfzHSro0hmS5CsQzIt91A=;
        b=ODQiJGIcPRtPTo3718mjTyP78Pn7qHJpa/NnOS+aIGGV4uoQVH/yS77XdZIgXH3qk7
         zMEEoE5AqEciB18aLz96aWiwkyWKEitPoOpnfDXYJkvubtCyiU0W98M8vXWT0j2j1v8h
         JVWWR/f/Jfyf+QHFNjUWd6/QzEZeiMbVzCd9x0/X780f9MQxef4yt5i+bnHbmO7waZVR
         TfZqC/vHL6wpKzDJpnUkBkvMM/ubD14AopteMY/ldE113PuXInXAQSknEjsQQb3G6Rl8
         ZX4jNClrQUOcxMVgfcKuauuciZPrh1wOEQTT7ie08kCTLxrlUK6qcla5EI1NEgf19rb6
         /hlg==
X-Forwarded-Encrypted: i=1; AFNElJ9T9g2QO7am83OUEQAbHfgNhEfxNn+skbHZztU3uJNOJV2AaYw+raiFAAYUz8nOq06SM4VFFogwIt8xD3/gLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDw1pnnHgC3G9Bnxn7lNp46rQlV7mz0B1WgnQyYcZmdEsPP1sf
	D/rnGEnkRl69QgYsg6uQ9krPeSefQRRZVlTH79lJYkpxEHRqyVD75B/OkeoyO3IZyZQ=
X-Gm-Gg: Acq92OEO00Mxyj/ehSZjIWNI6hgOUs/UvNKBPXjQI2/4Y4NmlhR28lu4V9OnEPKL8OB
	4eLUsmR1ZUKQsvGix4MR6JROhT7pVbP1kZI2RZoXQOQWQ44beKrtHJsG1e+EkaQab2ISKI1p+6p
	EIkKEnXOw00zuSYugtczjA1e/+PgrXm+ToSv6yANTcCHWxQ1rHTwG7uXA1ROc5XrAz64ky5XvSQ
	95Azx6nmP0WWmqIsfCWC9j/MLyYqlb+tRXMhaq2ZazdxDIov3gbpT3I0PNux6QFeAcg3oY3xVcS
	wy+BNLVfNyab5XQlzcoI+rA77fHhBNZaowJ4kOLb4IAK+mMOvIzHDNJOBqFmtFvmXeBErgOPhcy
	flyVe+GsW7S5J9Pnf8URUldeBhVbAsW7SFQ4t1MXyjZ77lhE5qSrY6tzkiyS7wrITJQHzLcKwrw
	DBoOpC7HmFqRg1zjvS4mX7KNxL65i8q6qAC6atOjD8vXkQPZ0iR21FXkk0BZJSbkHm2u5g05K9y
	dt+m5prCjEX
X-Received: by 2002:a05:620a:410c:b0:8f8:c91a:212 with SMTP id af79cd13be357-904d3fa3d5emr3775977985a.13.1778515437606;
        Mon, 11 May 2026 09:03:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b9c542cdsm1091199885a.0.2026.05.11.09.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:03:56 -0700 (PDT)
Date: Mon, 11 May 2026 12:03:53 -0400
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
Subject: Re: [PATCH resend v6 09/30] mm: alloc_anon_folio: pass raw fault
 address to vma_alloc_folio
Message-ID: <agH96dQDtDR_qYHU@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <96bbd5dcc37aed93a9b7733780bdcba4fdacfa3d.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96bbd5dcc37aed93a9b7733780bdcba4fdacfa3d.1778489843.git.mst@redhat.com>

On Mon, May 11, 2026 at 05:02:32AM -0400, Michael S. Tsirkin wrote:
> Pass vmf->address directly instead of ALIGN_DOWN(vmf->address, ...).
> vma_alloc_folio_noprof now aligns internally for NUMA interleave,
> and post_alloc_hook will use the raw address for cache-friendly
> zeroing via folio_zero_user().
> 

This patch seems rather far detatched from alignment change.

I wonder whether this particular improvement should just be pulled out
ahead to shorten the series.  It doesn't seem like it would cause you
too much churn?

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: cursor-agent:GPT-5.4-xhigh

Reviewed-by: Gregory Price <gourry@gourry.net>
