Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5E7423167
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515525; cv=none; b=HHtwaPtT7P8F8b+GHnvd0/KTWHGaZFWuUcRHuDZDoAd2esF6FNWrFBbV/PUkkJeeG2ZtSqeHPLrhrYK4cXXW380zLKUxKKN1fb4CmzzPHTMgezYbAJU7BMUBb3yEpcZGhBFm3JDFSahmQvuWkTP4ZN2XxhYE2U3CG+J8gCevrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515525; c=relaxed/simple;
	bh=Oeq9eGMwi8w2iSQxQvmpmvZO/I9zsD0MGIULQ6JiCwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mj/tioHMXQorVNfPZzTh4faGFT510qV4aMMB8Zg3hpXxZMdxkWhjjtYIgt2oHifQPJT3PweSOJREkLIu1+zl6ElKsN01hHkEd+5Wef8Kov3KNw8jtDaHhHd4wfTeF7RffwV8EQn4P3Z6POpQPfDfegOpXscM9hzCD0Bz6f720sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Kzh+gYjD; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Kzh+gYjD"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8d6d5e45c43so492561485a.3
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778515523; x=1779120323; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=53pN36zCncMLyKGWGnOoIrxzjGZ1bpiQo8EJw90qZwk=;
        b=Kzh+gYjDTvhsyKxKXpl/RsZEf2I9hFJVCTQLEddUla5qG9RcQE3K+5n46ClWboa37q
         3T9XHp0/Hvym78He/UwWxs1L6tBwspqAOZdZtKObQmg4h1M/rmHN6Cw0NQCOlO1Tujjl
         a8w6m7TtIVcl6FzqDGz/GBI8/p3S1QDn/6xtUE3UuK4z/E5zAo/8YtL0fKvsElmf6T1h
         6jTN5KcdZFQWdQKqd+i5Yp4DvlqzTd5dAtbChdT5yR3uiW50kTJ9xD3O/DNCEI++5UuT
         kgb8+sA8QKss7dJg8z0aP5cYo3ISZ6FydwdcJ+A/gn2JHCQ7R6NL0wlPdMC32UE2RUAz
         Sv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778515523; x=1779120323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53pN36zCncMLyKGWGnOoIrxzjGZ1bpiQo8EJw90qZwk=;
        b=Tnt24CtFevNtpxHF8ExcUm8jHSzSzKIdw3375VCXCUZts3qG52XFzz+/4xBOvVaAfh
         sVy73ArRliyE2SaU74Ns39RGCRC+QNdaEWj8bnSFZLKKzv1PwKiaGmsKChZmemk99zDF
         Fonehao6RCFNoJbRO5wF94Z77LJqj2w16KhJA7bn8nwN2dIXKfXxYjUvoOVHgC70XDWL
         McLGG+Gus6yIfI62h3Cpq/LH9tIUxyXwFp0FwXGsvFOrlBeC0x/IWr+SuWlFgOG7J35m
         Q977zmso5XPakRf/Qz8Lvq2EH9Czl3sFfp9tSAgBsGTQ+s3lxeLjnNQvsNZA1bQWtabg
         KxAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+XoV/F25nfjorLxP9SyF5KZjccJqPwnFLFiEzGupYMfCX6fRBn69jcl2a+iTj+2zlap6Zwh7JL+JDUKvRaNA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9WXTPf+8OwqZ5TyTs/xOwJSqIidLfSuio9BdmS3uU+wPYTIzL
	3Cwe5qmRV1S8uaZAawn2POkuSdZ5GwPb/hiC6fsxxJeXr5dub2Uwe+BOf57ZEYxrKPk=
X-Gm-Gg: Acq92OHilxv5ORhIUv1NaR5kpxlyYPK6INAMlKxV94uw3PrbmNOndhE9ulSi67MJ890
	4l6h83w42iCKxgDnbHJiLLDuYxrkDn0T9yrSpDkkKNRWZPfGN7g7joxkEouuATkAfuItrrnDzrH
	d5IXyaoinbz4aez0hK2jOwr+gtQlMy7J5yZ9pBRYtJJfEA0VouKdersEK3ebf5ABzZBJh6Z9ksW
	+6nAjtqTSNxAoZu8A8jQzr2yeolKxx5nsrJ+aUTtZ7ww1ABvfFZwvwxavbNXmcmqyHQljm3P2OF
	Jt9mk5i8ip+4HFRH7cLvT/tThBB6wJUuuCKfHk5CZcUCSYlQIPDgfGbZ8Y9yQz35aTLAY0fFR1p
	3h7woyBa3AMRi/qTrZ0ZB+cM1kR2wp9dS0Aq0Ehv1Oe2ycZEvJStTTYQ454Zij+rz8j3rcYonHF
	o0geXbPG5naQNu+ndpeHPeiPR98xz9szO4n+g25HRu2vzs/jTkO6NwYQ3Z+10Ezd1wL7xE1gYci
	Dx5DK7IPqGdPiPtHKRv01c=
X-Received: by 2002:a05:620a:2916:b0:8ed:f377:96e8 with SMTP id af79cd13be357-907badfb617mr2055265985a.38.1778515522494;
        Mon, 11 May 2026 09:05:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd04de9sm3186408485a.44.2026.05.11.09.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:05:21 -0700 (PDT)
Date: Mon, 11 May 2026 12:05:18 -0400
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
Subject: Re: [PATCH resend v6 10/30] mm: alloc_swap_folio: pass raw fault
 address to vma_alloc_folio
Message-ID: <agH-PrpY269pyuJQ@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <369a08b86f51572b2715a9ec577de27ea98000d3.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <369a08b86f51572b2715a9ec577de27ea98000d3.1778489843.git.mst@redhat.com>

On Mon, May 11, 2026 at 05:02:39AM -0400, Michael S. Tsirkin wrote:
> Same change as the previous patch but for alloc_swap_folio:
> pass vmf->address directly instead of ALIGN_DOWN(vmf->address, ...).
> 

Starting to seem like this should all just get squashed into once patch.

~Gregory
