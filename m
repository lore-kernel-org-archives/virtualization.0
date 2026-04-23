Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF3E384233
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960795; cv=none; b=aACSLUNuS6AMyrSqe5yNed8BnBTiSMfsyapDBElRy17nyMzHs1vNkV3NFTdZBL9EimhThJVmD5f7IHAUiZVqHdxiNBN13AtUtyyn0vn0tZcaFUUlxD+afm/zv1iPu2qtSOLngyVtp92z1JJVwvwGdkfvbUNeiDkaPoN5zOf0VSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960795; c=relaxed/simple;
	bh=fKB6gCyOLYLrhwAUsqBd+g5sVfW+71hhyWakIaqB8Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VLBlZ3qebMUUZYR9GvcWq3ywHmjmlen19fOVXAH3tekMOeAiu8qa4ZJc5RFTfHr4x3bXJH/0dydL370dCJUx+/e0vvldgnGT0epOYda1sPMZsDZ5FZtfzU9+aZ5VjpxTPHOMhjWOIIykDgBMbvSfffJ4RyAoLwJLOrCZui6JoRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2ldTBXt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2ldTBXt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776960793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPpcyNNw5A670ehN8KSLpk7tEoT3MHJiCv2Fb9unNrI=;
	b=R2ldTBXtPlvOOG6mPA3/WoeiU0Bbq66GkVQE+n+FQRH8a4T/H2bLAbZVes4h6497yVDqZW
	772Q5N4v+bpkMuk71y1Frx8KaW+j15h9id9XitUBdk4CSRlYs+HM8UJr41SGgkeXCYQZ/u
	IE7LWVc4tzjPmHZQqt25C0IhWY91FhY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-OvOWivosNvORRd03LKSzzg-1; Thu, 23 Apr 2026 12:13:12 -0400
X-MC-Unique: OvOWivosNvORRd03LKSzzg-1
X-Mimecast-MFC-AGG-ID: OvOWivosNvORRd03LKSzzg_1776960791
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48a55de6fb0so30257865e9.3
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 09:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960791; x=1777565591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPpcyNNw5A670ehN8KSLpk7tEoT3MHJiCv2Fb9unNrI=;
        b=KdUDra4iNN/nueHuK94GeTmzs9AH83yEUxAk2x88qzptYLmhHzFOZKyuD4DOH6HjWY
         MJuO77LSSr8WPvplDfyslsLR5reAa+xgBtt/qAchT03txpi5lWYOhEJx5XGi58NFSKnq
         YR9EJaCv9/3QCtNPIrPhdlTaVE9uS6T1PWO1xXujRgmOYzkXlztmhBUWrH4MZthyEHb0
         sv1J7w0aaGwrxFm5HTv3ke2mJPg3mL/mFBtMbmAZzzd7u331qEPi71wynetHY5DfiaU4
         wHqgjgllXpLV4i67ytYtEKrthHzBptLKuBdMexI3y13UsrJd3NiJf0ZE22hnnrT/ntnH
         rQiw==
X-Forwarded-Encrypted: i=1; AFNElJ+3HSPNAbEyaswyzZvq0Pn4QNpDY0yvGY2IxwBGS9vHgvF5yrTivCGvRQ8YSJPPixQ3jBQ36GSYnfLPrE7O3g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9a5ExDZludTVrn9HfM7bLUTV3bXA9PEAKnwoybgRUXPRccR6Q
	AzgoUyhkVxJ0mrNc+9u5x0x2W7gfPfD9GlkXhSJDdBMssY/xzTJHNMSxu3t6netF0tQdJPrUisu
	etMG467kCzaRKpy5YRs4mZd0cef7ftf38WItLgqQEa0jBxiF+tZNike6V1PaSme+LjxsQ
X-Gm-Gg: AeBDieteXA4CO+Co9pHUnbbANmVzNx/6HDU4hveISqcZP+Cks+MGr7XUqKfI/dmiCFg
	dtBjNMvMgw7XEjb/UYGU43NDQeQkOV9pfkXtJCBFCdXj1LH3xt27TxRdCwnA+Vxb5X1J2rfJElu
	ANnLbALFCRm3SVuyLPb85l/O/orHpZ1gb4aoCa5UlR4IP4fsm4AgDbpV0Sa4X9zA8deehD2He1C
	dxYtKjf5L4F/N2JtUgnIBy22mmsi/QBSJ4nz5Grq1vbd6CcMZSYYkAyKTXXuhmzc8EvhI2owNvm
	nRFuCfKJM9u0ddKjdyUVVAE4vDTLXCroVe1SFuRpJN6lbkBtPZR/yKQAD+TwFtlkT85SjOTVut5
	7tpKiW80LXdXVAw9zM3hTxCcWK4T8lnSmf7UAqw44M5PendYqVsMGSA==
X-Received: by 2002:a05:600c:1da1:b0:488:f453:b976 with SMTP id 5b1f17b1804b1-488fb7844c5mr438077265e9.27.1776960790538;
        Thu, 23 Apr 2026 09:13:10 -0700 (PDT)
X-Received: by 2002:a05:600c:1da1:b0:488:f453:b976 with SMTP id 5b1f17b1804b1-488fb7844c5mr438076745e9.27.1776960789978;
        Thu, 23 Apr 2026 09:13:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891cdfcd50sm122342895e9.9.2026.04.23.09.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:13:09 -0700 (PDT)
Date: Thu, 23 Apr 2026 12:13:03 -0400
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
Message-ID: <20260423121222-mutt-send-email-mst@kernel.org>
References: <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>
 <aekluxNPxF8CN8fL@gourry-fedora-PF4VCD3F>
 <20260422171315-mutt-send-email-mst@kernel.org>
 <aemglPlcwFFHNj1A@gourry-fedora-PF4VCD3F>
 <c165d6af-4a35-4a41-9086-ee307640c044@kernel.org>
 <20260423074433-mutt-send-email-mst@kernel.org>
 <aeohzbmhQAoOODPm@gourry-fedora-PF4VCD3F>
 <88b0765f-7cfc-4e44-83d2-c01a1755c842@kernel.org>
 <20260423104120-mutt-send-email-mst@kernel.org>
 <1ab6e58f-d984-4bae-a343-1b0d3c973ad0@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1ab6e58f-d984-4bae-a343-1b0d3c973ad0@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0JRczrtgJA8lzPNJNMmVuGc6BBPOIzrtfNjMLmhGC9k_1776960791
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2026 at 05:54:26PM +0200, David Hildenbrand (Arm) wrote:
> On 4/23/26 16:46, Michael S. Tsirkin wrote:
> > On Thu, Apr 23, 2026 at 04:13:50PM +0200, David Hildenbrand (Arm) wrote:
> >> But really, that hugetlb code is rather messy. I'd vote for leaving hugetlb
> >> alone on a v1, and focusing on non-hugetlb first.
> > 
> > I just dislike it when things are non orthogonal.
> > People are used to: hugetlb = same perf as THP but more predictable at the cost
> > of being harder to use and using more resources.
> > Here, suddenly, we have an optimization but only for THP.
> 
> Note that we also didn't care about user_alloc_needs_zeroing() with hugetlb so far.


You mean, that it stays because of the reserved pool?

> It's not that it cannot be done with hugetlb, it's just a question about how it
> can be done more cleanly; and that requires more work to clean the hugetlb part up.
> 
> Best done separately.
> 
> -- 
> Cheers,
> 
> David

