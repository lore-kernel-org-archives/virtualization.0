Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1A3E928F
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777055824; cv=none; b=andyLL5vOnPII6ljW56KJeM4BwD+rx5aXzHjJ+BXpry1hVevlynffP4tI7PD7YNE1od5DaCLZR7aCm5JVzPwxXOSuqHIyJ4CKK9Y/ZaxErCy8yDdbwGFhLvsYwK2rxj1uFW+pMLA9oTqYkLuIcr9G8E79HTru0XUPYoBPzcO1/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777055824; c=relaxed/simple;
	bh=X3unbKjXkfIxpZgPYPCXBXdaO16pNyP21Y+UN+3Q6ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MH+WVz6lHmNO1n9mxd4Weat0CepXrxP6H/FJE2rbGMZBFDE7ZQXoS3hz79KHaZT9/D66obRs1xqh+GfXDibT7NC8zHPsprhlkiu4HziwMC+XLvacds6Y8xDpK5V2SOcZ/jkDqUTocAvtrylal5tSs583A3l8iAzTHkaLnKL2O08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MyMwCATa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyMwCATa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777055822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EzZh79GGJvnyX3o1poX9T4TAY2qDXkiWPDaOxeNq0iQ=;
	b=MyMwCATa8nsPgevCg4hTMPeEE9XV7ryGf95FoozOdlmhuZOLT/olxYwPZ2UJTSL8V9DDN1
	FnH6PgnpOqglWib6ZruBwN4STC3z4vzOMYkZjXuAgugN4JwstWSLJiZIIGzaZUzZEZKvf3
	qCc5Efn+BBc8+n8zpwbdeFqki+xJJW0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-OHQCq3Q_MLKRittdIe_kFw-1; Fri, 24 Apr 2026 14:36:59 -0400
X-MC-Unique: OHQCq3Q_MLKRittdIe_kFw-1
X-Mimecast-MFC-AGG-ID: OHQCq3Q_MLKRittdIe_kFw_1777055818
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso88514815e9.1
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 11:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777055818; x=1777660618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzZh79GGJvnyX3o1poX9T4TAY2qDXkiWPDaOxeNq0iQ=;
        b=j1QcnniWgxsR9uuJ+BUJkuWAa8tPNyPuOhJGQJje4yIUhc0dGxNY6lkdz+cEmkWY8e
         p2x6ss5S0wyyk1+2ls7UuWV/ApBdUyx8wv8w1Saj4372uMvEOdRawVdNy3e0sSr/5U8j
         7IL+BM97uwkRf8Bt7fMEL+mzos1MioWZqwZRjhpVHYOWx87l3p/JgrjmCCw5V7dbYmOH
         Sm0rYYMPEnhxeyIVeqhTN6MbECPdxvmdpLian3OvVDTq7apHcZUdM5SlXeg7Jy2Zx7hh
         s3GuNE4lEpj2xb/TgPbAmFAAXU0+MLh6NSeOhDsYA0Pv10yqgFumeyq5FyGsddz2qhY7
         TTyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/CAB/sM8h+En/NFT2uoo4ktmwFW4qXnf07YpIE7kT89kN5xaaSUeg4u0MpEc0XgYJvciUGN4Icw/cXoWKQdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YziHBa7fD9RQu4LnOtzMhlP6ynWODB2QQT9BaaDG0vjGTLY5pti
	rLSX4VCqyt7CdqrCHX0WYzqZo3x0M8tBVo1+dK9m7O/zL0CHLw7gHqf2lgX7jisQxXYoUB52zly
	LNQ6x4b4rpIpcPoHYbtMT+aLPeusZ5gujJkloj4XXMLCJWiskbreRoMAlcHZM5WatEXq0
X-Gm-Gg: AeBDiev+YbQYbL0G9JnFM9cPpb3+WL96kTCTTj1zTzadjCZr6tMniuKIWzILOI9WeJw
	p4P2wPBPwCBU1CU50p0ybxSUxdIyfdgLwsIaN5aYvC559RbDx3xkZNJSWuS8Q3eHAo794InujO3
	88S9BIbmrz+ELoSBp0lx/6CuphmBDdD5nOjoOKJ/i9MGKinWTKd0IQ2CTtwMAbSggMAQ0zyxb3u
	1Ilzoe/zvcnX8WiXXPuz95BbWaZIMhVUQ6XaNB1zST/pHrRzaGHVLKFNbly/C/ZPi1EPy+p96W7
	ZQys26L92hHd52uFGQajsBYkij5tbPqNntS4UT+2lFFSnIdoske4hnZ04XTk2h14uMmKm1i1uXO
	F93LFX1eqwLZrmqov97jWqvZfi6VFEAlSMqtq/LtVrBTM47svM+h2e9/Z0iJj9SA=
X-Received: by 2002:a05:600c:5295:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-488fb77facemr466165835e9.21.1777055817640;
        Fri, 24 Apr 2026 11:36:57 -0700 (PDT)
X-Received: by 2002:a05:600c:5295:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-488fb77facemr466165305e9.21.1777055817177;
        Fri, 24 Apr 2026 11:36:57 -0700 (PDT)
Received: from redhat.com (bzq-79-177-155-147.red.bezeqint.net. [79.177.155.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55dc9f58sm607291535e9.6.2026.04.24.11.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 11:36:56 -0700 (PDT)
Date: Fri, 24 Apr 2026 14:36:51 -0400
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
Message-ID: <20260424143541-mutt-send-email-mst@kernel.org>
References: <20260422171315-mutt-send-email-mst@kernel.org>
 <aemglPlcwFFHNj1A@gourry-fedora-PF4VCD3F>
 <c165d6af-4a35-4a41-9086-ee307640c044@kernel.org>
 <20260423074433-mutt-send-email-mst@kernel.org>
 <aeohzbmhQAoOODPm@gourry-fedora-PF4VCD3F>
 <88b0765f-7cfc-4e44-83d2-c01a1755c842@kernel.org>
 <20260423104120-mutt-send-email-mst@kernel.org>
 <1ab6e58f-d984-4bae-a343-1b0d3c973ad0@kernel.org>
 <20260423121222-mutt-send-email-mst@kernel.org>
 <4e12d67b-60e3-4bf5-a229-43c0d2c62cfb@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4e12d67b-60e3-4bf5-a229-43c0d2c62cfb@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m3i63ZgvJUkwC1_YBmVwiX7E_CTKrKJZx_VfYKxdSGU_1777055818
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 24, 2026 at 08:33:45PM +0200, David Hildenbrand (Arm) wrote:
> On 4/23/26 18:13, Michael S. Tsirkin wrote:
> > On Thu, Apr 23, 2026 at 05:54:26PM +0200, David Hildenbrand (Arm) wrote:
> >> On 4/23/26 16:46, Michael S. Tsirkin wrote:
> >>>
> >>> I just dislike it when things are non orthogonal.
> >>> People are used to: hugetlb = same perf as THP but more predictable at the cost
> >>> of being harder to use and using more resources.
> >>> Here, suddenly, we have an optimization but only for THP.
> >>
> >> Note that we also didn't care about user_alloc_needs_zeroing() with hugetlb so far.
> > 
> > 
> > You mean, that it stays because of the reserved pool?
> 
> I meant, that if we are running with init_on_free or init_on_alloc, that we end
> up double-zeroing right now upstream. So nobody cared to optimize that part so far.

on the aliasing arches you mean? that double zeroing?


> -- 
> Cheers,
> 
> David

