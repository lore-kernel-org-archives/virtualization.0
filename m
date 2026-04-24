Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D5B20A5F3
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777033846; cv=none; b=qN6LrXyn9K2OmsLMUNdltI3Uv0F3/6ZBqznrLriOfYAhSc5lIfn+T3y457LaNGi54L84fuafvmkTHJs3qVQZw7HGylJD/3mSDp2tZxlaFonk8ft9oetYqiDXXMySizJ3DKtMIjyMJ7kVzIeQkGe+V72+Fz66t3VBfqvhwB4sGRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777033846; c=relaxed/simple;
	bh=DBu/nZvWAiG4+4kt6lEMhjjz5oEbyqzHaHneSIs7Nxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWVu9tcph9tmyPp0Z2q8tidze71C9WNMeyH57eKFv1I5FnbbDovpGl59I6JwOBO+UMwXcKFVf1KePyR5iYVsDkOMSYVu+26lD7a4a4y+IebA7Yr+G4UvaIjQ4Nd+w8Oquv3B0EBOYFPk/f4lVIhO7uHdnRD5Ch/yfun1rBCf8Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gMC6F2WO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gMC6F2WO"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50fc496c8baso30015881cf.3
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 05:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777033844; x=1777638644; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=17ilqt7I+TGyWbe020Z7XWSYzkU4sazN3E/IBcELplc=;
        b=gMC6F2WOXRafMoDDvFOEUY9DcG2/v7ouVdowdjhmXwt9wSMHbvDOObqTSsUUpfbvmR
         g2+8eV/fVVdb8igaOlmBEIGv9omjlXc+XqkIBfOTD9jpCAGzmXMEqVqkPlAfcFN7Oy/D
         XWhgtVtjWVyyZFTi4w3eExJzw4HwjZPsAjj4FEFlFZU/6aPC3vuPloLilEMB9krHw571
         iIuzJhe8Cnwb17Y/4G0XZU9Dc2Vu7aXhWiVP1HJ2536BERf5SZPZ4VUw9d46qxi+5bQG
         7z1HXC8MWdw3PQ1MRjdNES4bcFBD74oiN3HXTLVequLp2X49UGGOKpXqo260jAI8Azj9
         v5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777033844; x=1777638644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17ilqt7I+TGyWbe020Z7XWSYzkU4sazN3E/IBcELplc=;
        b=d7+g7Zi64dt57izCEuwBKaT6yA3ASlOBeafGXDr04RrSnm6lM85R4GaOj9PkxFpsoj
         JwVUYl7P921Vw/3PeERw7QIcNdYJzmVz6KhybyQfMf/vqZGct5RsraM41ENSsGHgtBzw
         RGWP51BpalUxlb6zMgoCtwFmj/QNGOQgviiqj39OFUA3Kkk8Miu4oLwQyEgLHBLLAaHZ
         /4ErlBPtXGT/0Egqi1RMRqNbPL0o8aCv6X7N80RR25esTta9lLXdBZRE54GnvZ99OTns
         UP/+RSOZnF0VOnDUUTvj62cKqNO8cmn777xpHosLDYj3fmVbr8ox/WqzObCxBYu+Ni3g
         4l5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+6EMaJaIjsdt1dzD/y3VGH8BjPVnGCfyEIIJao7VL9klGtxUdJQ8jy6bQLsRIs4JB8FwYi2nYYKQXrKSqldw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvIxipbc90WfNSmh7x5GiO+89TFX8Pa32iqAZW8kYuqYeGp1Km
	YJfgKphbqATnPiOq0o1uvcBtm4god1XC9LPkMq/IEPLwna/qcETYeJxe10xaVtGO0w0=
X-Gm-Gg: AeBDietG+3J4prj/E5Qk7cp/+LR0i0XqWqYSbd2QtscPTIj7hTymnNPGFtNiUVhgxyA
	0TWWGiVhdcABPJqIUvkyotIMdnsisQl9Je+/3GXscXriT6VkBulZ8+j6vdpTLAZXFLkzyR2O130
	WzWSR+rfoCcTcRFmu1ZnZcTBmMXoaZBBji+YeAfQs1Sh8u3O9rEfhyvZbWXLCv1yO9oJGXaRrki
	+ASZQGUCsOM2y8bA+kkuyPzvHi3AGAVretTIdPi9FvI8ucACWZ5rC9qTzlTi8rXFZk6MJM7VVGW
	Sm90MfH8J7+Hxs6RL9NCcVt5Ic3DhN2BhkBaQN/VEQM3j7igai4X9zBI1Lus0sKFMvIvkPbxMgS
	r+VzaRBqhCX6KwT3PulAqJ5D4kyYyy803ZlaQnemisNYF3wgRKKwWjZ+U3Q/V7zgkCIfwV8ZR3n
	L/vslqL+kP6z5hCFppVa/M5aip3hSV6LVvXadDKENmv3+p/mluXLspaRnOXAFXued/wdLYJG0X/
	E/2r5kbpMm9yWs9Ew==
X-Received: by 2002:a05:622a:4f89:b0:50d:9cf7:18fc with SMTP id d75a77b69052e-50e5b19c3c0mr269700851cf.11.1777033843835;
        Fri, 24 Apr 2026 05:30:43 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-70-94.washdc.fios.verizon.net. [173.79.70.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac81a9dsm184499016d6.21.2026.04.24.05.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 05:30:43 -0700 (PDT)
Date: Fri, 24 Apr 2026 08:30:40 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <aeticBh5XlAlD1vn@gourry-fedora-PF4VCD3F>
References: <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>
 <aekluxNPxF8CN8fL@gourry-fedora-PF4VCD3F>
 <20260422171315-mutt-send-email-mst@kernel.org>
 <aemglPlcwFFHNj1A@gourry-fedora-PF4VCD3F>
 <c165d6af-4a35-4a41-9086-ee307640c044@kernel.org>
 <20260423074433-mutt-send-email-mst@kernel.org>
 <aeohzbmhQAoOODPm@gourry-fedora-PF4VCD3F>
 <88b0765f-7cfc-4e44-83d2-c01a1755c842@kernel.org>
 <aeozRZ9AvW2jTQkX@gourry-fedora-PF4VCD3F>
 <016cc5e5-044c-46c6-a668-200f90a64d85@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016cc5e5-044c-46c6-a668-200f90a64d85@kernel.org>

On Fri, Apr 24, 2026 at 09:28:36AM +0200, David Hildenbrand (Arm) wrote:
> On 4/23/26 16:57, Gregory Price wrote:
> > On Thu, Apr 23, 2026 at 04:13:50PM +0200, David Hildenbrand (Arm) wrote:
> >> On 4/23/26 15:42, Gregory Price wrote:
> >>
> >> Maybe we could forward the vma+addr here and call a vma_alloc_froze_folio() if
> >> we have a VMA+addr to have a clean interface.
> >>
> >> But really, that hugetlb code is rather messy. I'd vote for leaving hugetlb
> >> alone on a v1, and focusing on non-hugetlb first.
> >>
> > 
> > If we're ok increasing the buddy surface this way, then I'd vote for
> > only updating the exact interfaces that MST needs to update for his use
> > case in a base set of patches, and then have each additional updated
> > location (or logical set of locations) updated in follow-ups.
> > 
> > My initial go around with this - the patch was hard to read at best.
> > 
> > But I also think we should also seriously consider not increasing the
> > surface of the buddy. 
> 
> Exactly, that's why I am saying that vma_alloc_folio() is the only external
> interface people should be using with a user address. all other _noprof helpers
> are supposed to be internal.
> 
> For hugetlb, we might need another interface for frozen folios later, which is
> why I suggest to defer that.
> 

Yeah I follow now - we're of the same mind on all this then.

~Gregory
