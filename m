Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328543BE147
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 22:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536938; cv=none; b=MahAUIKjIGeOSgCSNwzp52UQNLc8WN6a7RJCr8WiOEJcQuFEZzAlRVJCsm3Py2FwmGBNFjoO8AinE+LvBBYnRA0f3l2lZrXgzy3glEEpLVxiNuKMWmE2oArlRkqXJ6VS5WaxqGE27ilXp47Y8gKlwqmomb7MYQoOtWRpOoO5YSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536938; c=relaxed/simple;
	bh=0E8D3kXGWa1CK2OkvFiF5AfugnJch9kKBYGtLoNzmsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kqV7J+ZwM7UgR1ePDxSh1uFuJ9XRaZgM4JuQx9lO3sUTxxJMdYVuNuNVB2P/qOvgIEvtkUGqHxaFTjhRidxgRHIFFHDNcw1mtmBSJLxF0GEgrtyGwG5yy7nOhMyDkucu4g0atP6f3A+V2SNoe9HqH1EGks5xNF42njBwQ1Oy164=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dbEGeKC6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbEGeKC6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778536936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ik2ijbC6NTpwxKezKUy+hGJC+FJRCeUEYZIMUAfimrQ=;
	b=dbEGeKC605yBsNhYWkn1Z7cjM2L6/Vlh4jOIPYYT7oDLyXFRho5Fi0j2H+eaVkhxHgu7uK
	c7Ze9KyAzjpBPGyDVAwXKlbfyAH2ZHyz5Zhpzmmoc6RQMVL+dABMGU0wmNRYTbVR17nFPN
	cZgE3UbAllFzeArI3rgFKW7miqEanPc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-TtUkw2K3OTikSug3x-LatA-1; Mon, 11 May 2026 18:02:14 -0400
X-MC-Unique: TtUkw2K3OTikSug3x-LatA-1
X-Mimecast-MFC-AGG-ID: TtUkw2K3OTikSug3x-LatA_1778536934
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48d121738feso41751725e9.2
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 15:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778536934; x=1779141734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik2ijbC6NTpwxKezKUy+hGJC+FJRCeUEYZIMUAfimrQ=;
        b=XRDfMhxG+NgdqZJyWDPWBggaDBQ19cbeq2KEBmlaEZt4obKP6B8NEt264sJh0bl5Vm
         EX1Bz0fby9tYsNOjejc8nwiUrSUwvqp9c9DSriiy/uYqSN2Rj8xZQroQjyS6hUMDb+if
         XcsXoakNMJ/TdMWmYSW81KcZvlMIWemQiU8uAfdzlpA6m0e6xwcP0oDwmpR0LX9LJAxg
         qx45WDMzKJqqvO7W3fYMLRtZ1lKVmSmSzCAnVajlL4KT5BjPer/42bjcyc66bJfcnvUf
         WCzLRwaDPHxaOD0bGy0RSW8jHTSkc8kY9Hcx30LPY99o+QTjTaorJI4lGY5tzZD8XKaU
         Ujtw==
X-Forwarded-Encrypted: i=1; AFNElJ+u4ijziWbG671bFChDSjYyQzApncwXJO6Kobj/gIfVSJtxettqgQE1e6Fwh2sUWx6UdSqlXikU9zhRI8VFww==@lists.linux.dev
X-Gm-Message-State: AOJu0YxV5Z902SA/VE+hgnizN5Q93LxMoQD4exxiGTTQ3zgNnurJiIVQ
	BeUHTB42twg/f6EBhTKJcRBhlOZRSRI8MpiaDRrQqzebPbDjfS6iQaF8nXxjhLc7vgreHYhK51P
	apDdaIhvKbHPc2wdqs8w1FiQQgXq/L3qNPqcF3CLC54tjatgKuueCaJbyrYAcYsi65VrS
X-Gm-Gg: Acq92OEZb9Zcp4MMQ1JEXk6F5KegiMRr0vcgtufRq5YKs0AUR6t2oLhs2DJKZNefvwH
	IjZKJ4FPZLNPjUsi72zNnNsdlS0rNPdC9/SNSf0HO4F8kCFKsygsUlYbN6tASCFYK9UHupKz7yW
	iVyNkpqqwxD7hHg6LsD4rrBeFVMq+G5jPMGtJRzisAhHoqDGYkpwRtVf9DIcxfM/ALKWBZtTUW6
	fJFiXmzOL9MjmRClN4K/Kuady6FqqqHI9rZcG+wgqF2g9N3ZtoacG5vOQPUQXOXiMTuCnDeW2DU
	DIwCFlT5WDHaCOgyoOX+7IOpTsTnFFSOAgje6dGv8EeZXq61WYzY45hlZ23nhtzl9zCsRkQggFg
	ULhoqS4T1PhAPdPenKYv4a3zpPOBXKl5JIM36JCz5
X-Received: by 2002:a05:600c:4c17:b0:48e:8974:c377 with SMTP id 5b1f17b1804b1-48e8974c4c5mr28774075e9.29.1778536933615;
        Mon, 11 May 2026 15:02:13 -0700 (PDT)
X-Received: by 2002:a05:600c:4c17:b0:48e:8974:c377 with SMTP id 5b1f17b1804b1-48e8974c4c5mr28773545e9.29.1778536933039;
        Mon, 11 May 2026 15:02:13 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491e94c0fsm29095912f8f.32.2026.05.11.15.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:02:12 -0700 (PDT)
Date: Mon, 11 May 2026 18:02:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gregory Price <gourry@gourry.net>
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
Message-ID: <20260511180017-mutt-send-email-mst@kernel.org>
References: <cover.1778489843.git.mst@redhat.com>
 <369a08b86f51572b2715a9ec577de27ea98000d3.1778489843.git.mst@redhat.com>
 <agH-PrpY269pyuJQ@gourry-fedora-PF4VCD3F>
 <20260511174032-mutt-send-email-mst@kernel.org>
 <agJPpxyu4gKqq8rj@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agJPpxyu4gKqq8rj@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FUsuoBnuW6a1ALEHRsrrsK_f8z0GDLCR7tJ9qDz7myI_1778536934
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2026 at 05:52:39PM -0400, Gregory Price wrote:
> On Mon, May 11, 2026 at 05:41:16PM -0400, Michael S. Tsirkin wrote:
> > On Mon, May 11, 2026 at 12:05:18PM -0400, Gregory Price wrote:
> > > On Mon, May 11, 2026 at 05:02:39AM -0400, Michael S. Tsirkin wrote:
> > > > Same change as the previous patch but for alloc_swap_folio:
> > > > pass vmf->address directly instead of ALIGN_DOWN(vmf->address, ...).
> > > > 
> > > 
> > > Starting to seem like this should all just get squashed into once patch.
> > > 
> > > ~Gregory
> > 
> > I mean I was told the patches are too big and too hard to review.
> > It's just same, independent changes made in several places.
> > Does it matter if they are squashed or not?
> >
> 
> Mostly i think the ordering of the patches thrashes from one set
> (alignment) to another set (USER_ADDR_NONE).  If all of one set was
> pulled ahead of the other then it would be easier to follow.
> 
> This particular set seemed trivial enough to just be one patch, but i
> don't think it matters all that much.
> 
> ~Gregory

I can reorder and put alignment before threading, sure, that's trivial:
these patches are all independent and cause no conflicts when
reordering.

So far the main work will be the hugetlb thing - it really parallels
what I did with post_alloc_hook, to think of it.
Will take me a couple of days, I'm behind on other tasks.


-- 
MST

