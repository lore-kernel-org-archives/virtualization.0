Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE973590AE
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776955606; cv=none; b=dla+Ra4u4vA/it32DdY7hmwhjq4jPdrt78u/iiIDKJ7GCasMARb9WqR7JddRynJ3CLgEIfmJcDqmUmQI3YQT8/dFGpWFZ4Q0SuOjAy1d5VsusqUkyJm+Fk/7hP4aQsY7A45KrBPcCAMyYsEILIbv3jq9MqFQzGRMA+3UrGVc4uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776955606; c=relaxed/simple;
	bh=FVJvwM5KEFZLpNLphp/KsAxO7UvuDFjnyOYTqZVS/Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BL1P9BqPQlF/+h05yz5swq+vh78b8vAIFcmBH3Y7VgklOxd7Utjp/h3m9Cp4bz8zBzwb2Tlqp44JLVAlrP3BnqvB96rVFPvzSHpD/0ILjE4maYCkgaqI0LD8fNNfZ9H05jre7Awegi1OOKi05QGhikeLgCxcB79ZIKQu4GvRVfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJrHBp1v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJrHBp1v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776955604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8MfwEpFW90pOYwmA/usmJLfbbJthitR1+FeR/wvevQ=;
	b=JJrHBp1vvZqx8y4oj+Mm37/zXNiW/9eqa6I53poZSxqFnfFw52Sgx/kNhWwEtAquP39VUt
	PFTQXNCJP8TaadVpbVayHf+67K5gXEk0BIr0+J4ckS7ypaM6ZRBy9rEkA1SYLB75q1jx2s
	XLkkivgkUhl2xBtaIR2g1XQeBdCElrA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-WUuZWqrfPOK7EP_IY_5Ltg-1; Thu, 23 Apr 2026 10:46:42 -0400
X-MC-Unique: WUuZWqrfPOK7EP_IY_5Ltg-1
X-Mimecast-MFC-AGG-ID: WUuZWqrfPOK7EP_IY_5Ltg_1776955602
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488cc31ea57so52769405e9.3
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 07:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776955601; x=1777560401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8MfwEpFW90pOYwmA/usmJLfbbJthitR1+FeR/wvevQ=;
        b=lnkl7i3h0VHss5vt+ZN6SVGjKoz2ItzUPjSTTstAwpfrQiy7N+RA0TTx07P2/HJ3Fw
         U4lhH4kDMmGy/wIg2jxvFfj65GA5ytn4m4MR/xqu4pJNO9pw+77M+D86noTsJPmwrL8V
         IRETTXz7KgtzWdBOmn52d3jmsXUU71e2Kq6XD/X29nzHp1PUerGbEwnvjf7ZBIPXTnBY
         +9yzZeYX3Qpv4Hv23NkhCk4wK5cgrU5LDwn7NhFkpeOf7khI94QS3HTBCw+1vDGbS89t
         QVfkBVNexDGbDSKWzNeGtc+q8fLpg0IlqxWfiM7mZZpET+JmIDBUbH7QIcUw30SJNZiS
         FARg==
X-Forwarded-Encrypted: i=1; AFNElJ+1QlFJ8LuK93KoIzZof2sh4Tw38HkWS+b+q9xoHEsf6rQ9LQKE6RxT+pNVmwodktHNKFkFnFuIzPKl8nf9+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmU/NH0PT0F0crVQGSwqMhQlUcp4HX4eDE8utOQjXW9WyiWEUj
	hXRn9Yobjy2GRhY2hHGJx2rTlPLIvWOSz4THCYGA2IQ9FhrIS0xNlBDn4ANjB9kddrTnJg8YWqa
	v21OA1DaUXPZHzh6WZP7G3sprq/UNADyBqozhOFvvAyI+aqRY9OOV1U6qn33AjUUTEAfH
X-Gm-Gg: AeBDievjPIE2K7lkBeAO+p0br6ya4onaHv9umPJZrDqgdrCGpEm+gUHN0wP5sjSGsq1
	JAQoZCfbQMaUfiGJ2dRkFtzI4l9vN8kkYP812Ta2LFaZa0tSDO7WUQduTZY9+w4egBqI43vc6qq
	2aD2FgOJJRZB4+AjEpGR3KrXU6Eqpl7vs5sXfwe/EQDg4NEc3HJBqwj/l3KR6Alya1w49lNNBOL
	9AZxsgX9+Pa9gDKmbpPKQlzwf/0uaDeMDul5zKJEMsvsqB5ypRBwoF9pnW1m9R1enB9XRXnlUie
	/ZIi1aWAqbzPn9bSpvFNEIh/yrG5uhh/9REb6UGkkxLhuES5SPYdEOsvpDgu5BU1kI6YAIwRtm+
	13i3JLOjSczIzua5N36Ia4SDe5PVdjVCidbYYttaNM1VlzOvbKOe6MQ==
X-Received: by 2002:a05:600c:3553:b0:48a:52f2:a0f1 with SMTP id 5b1f17b1804b1-48a52f2a5f0mr200255835e9.18.1776955601370;
        Thu, 23 Apr 2026 07:46:41 -0700 (PDT)
X-Received: by 2002:a05:600c:3553:b0:48a:52f2:a0f1 with SMTP id 5b1f17b1804b1-48a52f2a5f0mr200255085e9.18.1776955600835;
        Thu, 23 Apr 2026 07:46:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc100162sm540787515e9.5.2026.04.23.07.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 07:46:40 -0700 (PDT)
Date: Thu, 23 Apr 2026 10:46:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, linux-kernel@vger.kernel.org,
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
Message-ID: <20260423104120-mutt-send-email-mst@kernel.org>
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
In-Reply-To: <88b0765f-7cfc-4e44-83d2-c01a1755c842@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O4L8Sahk5tPupkeTHnNrxLg8UHcpdiudn2YV-7fpEvw_1776955602
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2026 at 04:13:50PM +0200, David Hildenbrand (Arm) wrote:
> But really, that hugetlb code is rather messy. I'd vote for leaving hugetlb
> alone on a v1, and focusing on non-hugetlb first.

I just dislike it when things are non orthogonal.
People are used to: hugetlb = same perf as THP but more predictable at the cost
of being harder to use and using more resources.
Here, suddenly, we have an optimization but only for THP.

But sure, we can merge a part of it first.

-- 
MST

