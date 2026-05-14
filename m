Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4833AFAE7
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759589; cv=none; b=FxPXObOKxyL8UhA0Tk7WdyVTuvp+lLAmQRUXuwHPzxPsYWJzvaBEz1WeTV7cCyAtc4r8RTcBul35EnaeOK/PeY9dV5FYCltKXWtazn0pkCYlhVbG77mSq2Tp/1E1y5fD7IaQO0XpssO2gNT0KDf7KsOnGvSTgZntCRdsErVwEOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759589; c=relaxed/simple;
	bh=NAZ+7tU/aW5rVI3AoGCdnIgQQvyFD3Hx7JdW/noCRrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sS9u2qUo6T07ssoW98fcNgUj+LDRj4Zrpsu0yBcvHLnwAHRVNKmzSYBP2Ma1W+Y4pBFl4jDPQovoRagezwiznrbAi6ppLeGJVlv6/lOOUyamBgeu83AOHS7GSa42n7xruv3O/QKF1w/QZhYq2x9Fu1Z4As6XIk5HNRnMo3Fid08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MXeFAjPV; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MXeFAjPV"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8b6dd874471so103175196d6.0
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 04:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778759587; x=1779364387; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ty9zU0lNlVt9XsC+dbjcc2MTK2ZG8WC14RYLl53PeRE=;
        b=MXeFAjPVPevTW59KtyRZCr4MRzjx0yV4whuNdaPrD2GJ43Gw0CqJ6u/Ar47wdW7ycc
         RsDDzMEqwTcSwaqofTxBzYPgK6wLEc/KJzp7PJiMJkZufDemDyuhBpCdxlyhN8Yio7wm
         n7epd34QsT4XHFBf4piGWrf4dYTl9JUKIChH9VAoByPryqpLfZhGm7KRVez9o01UXkPk
         mly3pQDWpYjSBVrjb7fwKXKM+DhN0eJjfDZRmRERTWtfjMsg2p82ARh0g+IH4cFLrYwo
         Ou3EcsfO37SBiP4CaovBrP5irqFfhlEqyT0UQSL2zrILfpiG8zFCkWcnktbldaKii4xK
         foIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778759587; x=1779364387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ty9zU0lNlVt9XsC+dbjcc2MTK2ZG8WC14RYLl53PeRE=;
        b=CIrrY3tX4WpYdXM9zXuP/ZPWpHROt5VAYs/dUySIWNgO3B91ObWz/BVbl7qLtTPvxv
         6dxDGr47CN3gVeQUwb6bBmSXGi0hdrrXO/wDc/Q6xtk40tdhWSNrrVMj2naoJn17FfgR
         nlJWEEfQb/1La2moW3UQfAHncYseorxn5xf/RMKDbH5OKnieLf5wY99B0Ydz/axPrUkO
         59Bjp0NiZMBg47blfsUjDoYTpRRi2IiGzJG8ApBG49Uf4haJo7p/SuWegaX50DbksP+K
         RJEkMaMeWXmwqOxJ0n6f1yt6+honFs2oJvbqvdUMN+FnCrkYDt+WL/ycONPxiZxQgZjO
         c0vg==
X-Forwarded-Encrypted: i=1; AFNElJ+e/peLdvdtoxPQrYGmT4lBjY2cLZLvKdytyeZZgRBP/aLbvYdtKlT0UqwrWVhpovVbUxKUy3OigYoZHj05aw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVSm0nlf0YmktWjJr6e+lcQku+TBdyIl6X5fSYCNpqN2Kc4ZCW
	DhNzo1lUfKcjaWO4vTIZy2XEtRVDrELJoiH1EvjyivkO9/tONf9RkE7PFioHX3tqsDY=
X-Gm-Gg: Acq92OGiUMV9OhGEAwopPeqFxSQmXjNXihvbMzJ3cYDPNVyvDVBTRkGWOMR/OQaOgMn
	lU9ieixz3Jr4/OPr5Q2fYFCbuMJhNoqNbnUgVqajEJ/nX0yiwX5rw7rqwbHpWxt6cyto8njm8K8
	CRc3xqVj7+uZUBpPsyd71bEnnYqarmP3a3wwDH2QHxBZnl2gVBikRX0WAbVruLvCBk15ttkg+2J
	a+3i/CyDH9E/eFK+dNbs6TY5JHOEddg5UeULo9OvsSx8xuGNypnORM5E5f/u0jciBzTdkjiNCsf
	dmshWZCCr8yrZN4gdFqCx+77/lthDinXKbE33iDdqsgPBH06eTwsaJ6j3qIuOzkhJtKhhjXboJn
	XgGHGNlrbklSQ7Wm6yzYWhMbX0ypnXQQaYtur2Nc2eFtr2ZnDO2CG0iGGYkHhePUSVmZP+Ygrze
	UXd1Ch+7CHHHuA/tqOU9siLNQZs5SAVghBxfgKQXHiZ6EIiMNByEE3SYMuTYA/1xg9u86sb+cwg
	obRNCdo5gbI
X-Received: by 2002:a05:6214:2f90:b0:89c:bcbd:c26e with SMTP id 6a1803df08f44-8c7bb4b1e07mr116683036d6.25.1778759587110;
        Thu, 14 May 2026 04:53:07 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c35cdb1sm21031116d6.46.2026.05.14.04.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 04:53:06 -0700 (PDT)
Date: Thu, 14 May 2026 07:53:04 -0400
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
Subject: Re: [PATCH v7 04/31] mm: hugetlb: remove dead alloc_hugetlb_folio
 stub
Message-ID: <agW3oGO8qwWPnbRI@gourry-fedora-PF4VCD3F>
References: <cover.1778616612.git.mst@redhat.com>
 <0143c5e2086fccb05703500c9269a899d4784768.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0143c5e2086fccb05703500c9269a899d4784768.1778616612.git.mst@redhat.com>

On Tue, May 12, 2026 at 05:05:26PM -0400, Michael S. Tsirkin wrote:
> Remove the !CONFIG_HUGETLB_PAGE stub for alloc_hugetlb_folio().
> 
> The stub is dead code: all callers are in mm/hugetlb.c
> (CONFIG_HUGETLB_PAGE) or fs/hugetlbfs/inode.c (CONFIG_HUGETLBFS),
> and CONFIG_HUGETLB_PAGE is def_bool HUGETLBFS with nothing
> selecting it independently.
> 
> The stub is also broken: it returns NULL, but all callers check
> IS_ERR(folio), so a NULL return would not be caught and would
> crash on the subsequent folio dereference.
> 
> Remove it now since follow-up patches change the signature of
> alloc_hugetlb_folio and would otherwise need to update the
> broken stub too.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6

Reviewed-by: Gregory Price <gourry@gourry.net>

