Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C552733F39C
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513208; cv=none; b=qhwcEg/uN07ncaTBb3I3wlok8iSGNYUaGwCifIBrwwNefrPRIO8vJszvyz4qNrpIAlmrR06o+gYwwSx0W8WaS2PoSLhp8OMg/ZaCU3ng34faIsfNAMiiHMacVfzh7GFpx/ZsBIjFaQIda2JpeAwJ63X3BWv6cjUTua/cUJdvljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513208; c=relaxed/simple;
	bh=QvaEDsfsbHC1JsrHHy/3NBboJrhxgZRYhVq6UMG0v44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PZ2GmlvsBPSVWGfc/kgEniwbAg5gX8C8/YR7HL5g1kMHJViBY5mF0KljmLBOJih/0gPBtmQ50rdVnReMYDyKgILBneSLhYu9Z0jyg+o5CaF4xiJWm970oUeiskv6lXVSINEyYVghWRXhEcdmkUBb1G+G7BFckjOmE46KSsOY0UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xh7WxQEp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xh7WxQEp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778513205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VtgHwsv3Qeq6g1IIGujUjXaZnU57hLsTfcwqNk6aZ/k=;
	b=Xh7WxQEplJMmTvrk48Db7ztNw3b8Phl3Yc/kEqPcZLvQynjaI+I3KNuMKNB0ExWJzSpcQk
	D59dw0s97vsVfekQ1I0/niIJFT2Ontbn7Ick8k1E8JlN5qKRmKtR7R/0HZ7maEzhz2cRV4
	VH65j26YvBecbxHOFguCmCBTI9oGbjw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-q05yUb4ePF20a8sATEKIdA-1; Mon, 11 May 2026 11:26:44 -0400
X-MC-Unique: q05yUb4ePF20a8sATEKIdA-1
X-Mimecast-MFC-AGG-ID: q05yUb4ePF20a8sATEKIdA_1778513203
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d103e46c3so2736930f8f.3
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778513203; x=1779118003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtgHwsv3Qeq6g1IIGujUjXaZnU57hLsTfcwqNk6aZ/k=;
        b=VW1Snn8MBcVhdg40AFH32xksVMjnv8tVXxE/ebZEJMbM7rge5wNCto1speVE5FQxbJ
         ePMf2i33/kK8HnmHh33VEdTuEKdBweJFNwFj3Py9KmgBFgVuIOutluN4WJvvxgEdAXAw
         WX1VcdBXAV1B+f6aWsPLZAjfrcvMaP4FQkDPXrjooVeRpECyps3xwMArF8zlI2Jqb+1N
         Mzmqcz4aNrhBkViQakeU6XP/lXtV9pZU4gg5MgeAlQq3amQti7kbeNiFwPutwAv+mSv8
         v19Tge7hqKCz2g1xCfNV0D9iOdM33MEMs4mVN9qpDZuj+Es5xE7lhpIxb29e23P4IYj+
         1uBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/UtRHxH3bE6ejZN++X1WOj55YmjPoXlGGB+YkeyWRlLGtONy2EynFwuJxGXN89xSiDB9pHwKi/i1EsDkH4Kg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzc7tPuXqL8oQpx/Ggg3yvSXxWHthAgVxzmCQzZ78D7B8pwcLQg
	L/fPavnOnETJfiJNI7HZkX3pdy0UOoAfufEWm9cafoeZDiXA+wc17innrH0De/G/JVNzKvP1ujV
	jX8NeckhjWhk+2VreBmFZ7rPlOOmw/y6wUWFhZNafbuuuDlCnRYCywayTrt2okz+F5Mfg
X-Gm-Gg: Acq92OHNifIIuCPEJzC/TIOXBL/IlcfEKQdGOcafttxjnFhGL4qnD3W8wwrKwSjNNWi
	fTeHw2AYOGWa12qO4Crstfx+RBFjdMBsV8TAXSGhwP1dp9VfiM0a2eadOU0Zh+2099VQYLbV0Tq
	8H+RN4PfUfOwhxb8XyX4BTouDFLhj7B5iZNGqZwvFTcZtPUE8DhTrEcMB3k77twTROU5kToWxpG
	axTBRWuQefhe6nYTPsBxzrwf7+kxK3LdM9KInMVOGRWufXUxMFJxNCB44ud2w8wVOsUSNb4e7I3
	puF0o1WK4uCEKI6+rO2LX8aXxpJc1+C4rb/Uyc/LlJw8iIKlslRWuDrpxUwszy/Bgz+CxY8OF9E
	r/x5q43nK60r7jsiESG3pd+rUnKCvOx33q4T3QbJH
X-Received: by 2002:a05:6000:3103:b0:44f:da83:2030 with SMTP id ffacd0b85a97d-45463d88e5dmr21406828f8f.41.1778513203112;
        Mon, 11 May 2026 08:26:43 -0700 (PDT)
X-Received: by 2002:a05:6000:3103:b0:44f:da83:2030 with SMTP id ffacd0b85a97d-45463d88e5dmr21406697f8f.41.1778513202344;
        Mon, 11 May 2026 08:26:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a66bfsm23102423f8f.4.2026.05.11.08.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:26:41 -0700 (PDT)
Date: Mon, 11 May 2026 11:26:36 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH resend v6 02/30] mm: mempolicy: fix interleave index for
 unaligned VMA start
Message-ID: <20260511111905-mutt-send-email-mst@kernel.org>
References: <cover.1778489843.git.mst@redhat.com>
 <41bd50fdaae943e1a79215ea4000322e74a823be.1778489843.git.mst@redhat.com>
 <agHu4iaL-3By0YuC@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agHu4iaL-3By0YuC@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4HY6c4_zuTOeezmbbcvlaGXa8Oc81k5PYbu3b9NyMto_1778513203
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2026 at 10:59:46AM -0400, Gregory Price wrote:
> > ---
> >  mm/mempolicy.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 6832cc68120f..39e556e3d263 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -2049,7 +2049,8 @@ struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
> >  	if (pol->mode == MPOL_INTERLEAVE ||
> >  	    pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
> >  		*ilx += vma->vm_pgoff >> order;
> > -		*ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
> > +		*ilx += (addr >> (PAGE_SHIFT + order)) -
> > +			(vma->vm_start >> (PAGE_SHIFT + order));
> 
> There's enough (PAGE_SHIFT + ...) spread around the kernel, i wonder if
> it's worth a define or a function (not in scope, just pondering).
> 
> ~Gregory

66 of these. many are not about order. Popular ones:
PAGE_SHIFT + 3 is bits per page (for bitmaps)
PAGE_SHIFT + 1  is thread stack

definitely not in scope

