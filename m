Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5818B405F7
	for <virtualization@lists.linux.dev>; Wed, 27 May 2026 05:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779859535; cv=none; b=jSuDBuzPWyhORtCVHosplaWx0qq7YUjfWIDbyb8QRuHQVZw5g6BnGhaXxdWvqT+1CRC1BPn+wiwsGlPntO315SEhrN2C8SHoiCOrDclCEfLxUUVZto171zrPbo7V/ZKknl8zZO5WGYHxGLh3WsfBZmPV25CJkHGqqWI032yL04U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779859535; c=relaxed/simple;
	bh=Jb70IGE0O85wCSQmPPuCv64ibpz7rUZmBKSdNzH8Cng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rmDUenILc2iPvHID1DPdcNOyCMs5fj70d7KXauHFKdh4tDinTjIdG4hPNz5+wbFYemID4sd2uOTUBVR/03mH4zcIdg3CbGDLDzdK2a0quER9KjwgCeOvO+1a4GWwSy8wfUj0Fd/l5iG9a0NA0rnXurVzs85O9LKeyQW0M/PcwNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gYGeMHv+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYGeMHv+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779859533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FIw4sRKy1aKBAfMhIWmMCv5y10kgNoyzfTI86dVZAyk=;
	b=gYGeMHv+y3dQG03EF1/3oaGq4hsv03NRagKTE4wdFbTXvtBHfsejugFSVDBPzbbQh85gKW
	oBXngxgd30AX8r8JUfpEIMifKNYCxojYknPCYC3oirrLxctew/IW+IR71/deE/hgV4gbyy
	H5VUimFH2AFc06tc+PRRTaCziqil49M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-ua9vORUfNLeePxsJxEJyYw-1; Wed, 27 May 2026 01:25:31 -0400
X-MC-Unique: ua9vORUfNLeePxsJxEJyYw-1
X-Mimecast-MFC-AGG-ID: ua9vORUfNLeePxsJxEJyYw_1779859530
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d7b7bacddso7710934f8f.0
        for <virtualization@lists.linux.dev>; Tue, 26 May 2026 22:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779859530; x=1780464330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIw4sRKy1aKBAfMhIWmMCv5y10kgNoyzfTI86dVZAyk=;
        b=gSoAxpoos0fdyUraNoa6/KgNnm074ZjW7tuUlfttXh0WO4qQSnmdS9ieCn9PmZCWgN
         xk+xX+DSMe5I+Cyl/anXyqtUQvvA4pIfHQl7tjOmqxnd5ZyOysIA3U5lAw5U/1pTvtQc
         xXK2NpJw3ilr3oCpGVsORZhb7aWZbQTFsmSsEu2PsKkmvkvVBu9eVu1klLARZZ2n3mLk
         O48piunHYgi7OwwZvozyMDmDMxj45r8gcWGWWCxZAoXE9CgbaDanQiXZd6hs3FFNx5wj
         fE4O1H0neWuh7rH6o6rO3tbwLMgFkwuRLC8s6N3HuQUPIe6XVhZ2Fq56vVxOnnnJp37q
         4piw==
X-Forwarded-Encrypted: i=1; AFNElJ+0Fpkdtzm5Kii0nL9wP4Sv60MalLfRDuz8tV1qtVDqf3D4938SBenDDH4Qmyh9e/P9QBOF+pUSAnxAtdgNfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbpuQULd1GlvRSu/ll0zyLhT5EdU5nNa2dlX4RO0WDMI6crxrl
	9lRHn5Lvl+Aipv50qNF2RcCx39xJsdvxq3hR6QoSAqa4pcDRync4xh/ppSgPcZH0wonYIjS7LZ6
	3Zki8vv3BdLLWbo8vsW/pvuHCYRg7ScRGqUcHQbswn9Rf1fVefJfO1gPmGGt17iHhXX/u
X-Gm-Gg: Acq92OFtOq5BS6JCMPaHQb173Rt5LtetmZYvAsPNDYQoUnvnBpbsxpy23wD8Cp2lJST
	sltDP/1S+WSWK50KUbOMongVl5iLRdZt9C2KwYua9fr66pwDFIE4Wj/DURnVEvc7NlKJ0nP3p0x
	fj6F5m9abBB2zgwp5uDGVaMl8OUIiuadAIAFWBAPbLo7ct/6W2inHk2BH82/0CM1BD/R1PFuN+t
	sKNGVdjb/GsQA0RY8GZOU/oN+f9w5JGZmy0zKHn8pbZebDTi+25JGEftKIh2I1cUks8Sbzkvtlb
	yjhMvFWVeblDdbjfYBmWzIJPFiP3XddzKJbzRlTf9voG7dQJbWIJ70UWtWZ2RhwForamG9bXTjt
	h4l2Dc5C/Zjj+Y9cG1Mc2pNufMEg0IouZ7HMd0ZDg/REEaFkJwcG7wA==
X-Received: by 2002:a05:6000:4803:b0:45e:7c19:a328 with SMTP id ffacd0b85a97d-45eb38a10ccmr34423026f8f.28.1779859530280;
        Tue, 26 May 2026 22:25:30 -0700 (PDT)
X-Received: by 2002:a05:6000:4803:b0:45e:7c19:a328 with SMTP id ffacd0b85a97d-45eb38a10ccmr34422955f8f.28.1779859529704;
        Tue, 26 May 2026 22:25:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb54903csm3490131f8f.6.2026.05.26.22.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 22:25:28 -0700 (PDT)
Date: Wed, 27 May 2026 01:25:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Miaohe Lin <linmiaohe@huawei.com>
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
	Gregory Price <gourry@gourry.net>,
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
Subject: Re: [PATCH v8 00/37] mm/virtio: skip redundant zeroing of
 host-zeroed pages
Message-ID: <20260527012249-mutt-send-email-mst@kernel.org>
References: <cover.1779315441.git.mst@redhat.com>
 <20260521100313-mutt-send-email-mst@kernel.org>
 <eda29390-94a2-c4f6-a3e3-32bea8c6b363@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <eda29390-94a2-c4f6-a3e3-32bea8c6b363@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lvkeuYZZ9j0R_InUKRaP26ekhUOEBklp0kq7hbdEoZo_1779859530
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2026 at 11:23:23AM +0800, Miaohe Lin wrote:
> On 2026/5/21 22:09, Michael S. Tsirkin wrote:
> > On Wed, May 20, 2026 at 06:20:13PM -0400, Michael S. Tsirkin wrote:
> >> When a guest reports free pages to the hypervisor via virtio-balloon's
> >> free page reporting, the host typically zeros those pages when reclaiming
> >> their backing memory (e.g., via MADV_DONTNEED on anonymous mappings).
> >> When the guest later reallocates those pages, the kernel zeros them
> >> again, redundantly.
> > 
> > FYI Sashiko reported a couple of issues. Mostly false positives but
> > I tweaked commit log to make it clearer. But also a couple of
> > real issues. So far I have this diff on top:
> > 
> > --->
> > 
> > Changes from v8 to v9 candidate (code only):
> > 
> > 1. mm/mempolicy.c (patch 1: mm: mempolicy: fix interleave index calculation)
> >    Combine vm_pgoff and VMA offset into a single expression before
> >    shifting, fixing carry loss for file-backed VMAs with unaligned
> >    vm_pgoff.
> > 
> > 2. mm/memory-failure.c (patch 2: mm: memory-failure: serialize TestSetPageHWPoison with zone->lock)
> >    Wrap ClearPageHWPoison in retry path with zone->lock too.
> 
> It seems TestClearPageHWPoison and SetPageHWPoison are missing. Should we serialize them with zone->lock too?
> 
> Thanks.
> .

I don't think so.  As far as I could tell, none of these are called on
pages that could be in the buddy. And all the non atomic page flags
games we play are only on pages in the buddy.

-- 
MST

