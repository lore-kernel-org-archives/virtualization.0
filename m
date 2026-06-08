Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BA037DEAA
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947237; cv=none; b=Jcch7ZMIM2mNQU63391e/9uV+dDIHrY1gVfcGyAcLO3FbfU7IKpRb+pyi/gOob3F39GnZLo06Sg2HRGrjI8Bo5uvetlR3cwbJiZbzNu4sySxAgpig0YLLvMFpmqfY/dMxgmsOC3LbqQ1DbvQtFLQ41hE4kFrhQu7wNl0twPwmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947237; c=relaxed/simple;
	bh=oX3pYk42Bzqeoce9KeAXxQgg7Plx9HwjbhS1YrGiaE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OG13OGvXjj5bFvmjMKoMfR3CW4XLFybB7NPxlgEwK7v84A1azRoBdGyDzf8ldsa1cmimhXCKnA/YFxlWHARqVTfIB1kYR54pyJ9EMGFXibJgvZOoyXi8YIf2okvTzq70uQdNu4bxJkkQwS15bK2FoIgNYuhzeWGmuXOPN+D9m7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYRxr7uX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYRxr7uX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780947235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3dDLQst0ldE4FdJBA8ABzv/FPI+QsS8HzDNtt2amioI=;
	b=XYRxr7uXFoJVC+KIq1E6V/lOUsO8Oqd67kBTr5l4xhVIloGgjiga4p1A5c5bYccUCizkV5
	R+5ZXdXqAwdU+ub5NqSTu1/QIZKbhn5u0MBWEUPTpb26ir7SZsgsj27swba9yQS4LBwyXT
	3U5mxqykvwiswPfkNOGz7m1lVoqLVZA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-XxfufjUZNhiYMfSz3XH2WQ-1; Mon, 08 Jun 2026 15:33:41 -0400
X-MC-Unique: XxfufjUZNhiYMfSz3XH2WQ-1
X-Mimecast-MFC-AGG-ID: XxfufjUZNhiYMfSz3XH2WQ_1780947220
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b7959b9fso48215705e9.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 12:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780947220; x=1781552020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dDLQst0ldE4FdJBA8ABzv/FPI+QsS8HzDNtt2amioI=;
        b=MiPlkXgnvC3p+qj9FfIAm8kd/YsO+2k+vTtGtL/Hg22btkvCpcM6+YmchY7SIgeDpR
         fliAgJiKx9B7rxzliG/DeOHKRvX6jlKNSo++C5HuPAv9owwouqmt7PW4WW4qbEZw4ia9
         1qGjZ/z5/eo/B0N0gDWusmDv1vGjN6YjmUprykRHqFOb2+Io+heg/8s16MYraZwizvyu
         bNuQA5B7hIs9SWk192VY6OR66KmP/v1/La1sepwFb3pcULXwR+RRQ8ODxza7WoxEjUIa
         BOkngtFkgYC/aXSRnm4cUcllWxFflfMOpglSNcagwhnNRiZfcC8Adhi9HdZ0YbFVojL2
         MdUA==
X-Forwarded-Encrypted: i=1; AFNElJ9I7/un0qqRMXFM8FfRz2ArZrMInQa858MPB5iZYfnLDM2bgJZOjwQbxHJWAr7TSrNRyGJySzlr0vtzNoiwUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyN35RByR/A7CKp9nK9OJgnFroEHXaw5h+PNme8AST1XPrEdJf
	t0vbcsNWOd2mpsbAs41ELcQWeKNP9Fy/3gWgsIwSMo5nNav/j4NaYAZQQHit/dguK19MNBtIqK/
	5iTOTny6dji6ghJz0i2SWc9ockKH0I/6R4577hzmZEN19bU+wseZxNOvHCweA9AZMAueM
X-Gm-Gg: Acq92OHwUaspM0xNlXc+5o84Ukw/wA4DWykOHcnjoj0BLneO1rUunPntj5y5eqt79AV
	7TILrqG71yZdEl1Hd3r3RDDEW8fpks9+87kceGo46d8M4N+vtpfZo8ev+zSpucrZ3GRKaXPbOXD
	+cLN5aaJ1vwfHMapcMVr2Vt3OVLvIOQhL/HW9/wQ0rcFOYBkYVkYtL/CXtHy/g8zGRJyYd8mPGU
	INwZG32b4Tr9Jz4mnyqPLv3NvVZ0ddtzfZ4B3AG6Hw1ayBLRj2CYEajgaUTghAflBVjUqSg4Yh7
	JfQ70rY42DDaMvxnH0XlJGeEQx8F2T9pRdGxnaS6lRr2QN4x66mSRIP9SkKs/eTK81MihT7q/0Q
	OvknMIxPjVDP33XwpGeFWXeaiNEhb3vLK579hfftOMqtbPfFmTzDjXw==
X-Received: by 2002:a05:600c:4708:b0:490:bd66:e522 with SMTP id 5b1f17b1804b1-490c26038d2mr274761835e9.29.1780947220386;
        Mon, 08 Jun 2026 12:33:40 -0700 (PDT)
X-Received: by 2002:a05:600c:4708:b0:490:bd66:e522 with SMTP id 5b1f17b1804b1-490c26038d2mr274761275e9.29.1780947219772;
        Mon, 08 Jun 2026 12:33:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413adbsm420621035e9.15.2026.06.08.12.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:33:39 -0700 (PDT)
Date: Mon, 8 Jun 2026 15:33:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v10 07/37] mm: thread user_addr through page allocator
 for cache-friendly zeroing
Message-ID: <20260608153223-mutt-send-email-mst@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
 <50d410b47fe3f45327783e05bd306d5eaab75e65.1780906288.git.mst@redhat.com>
 <aiaUDTeHDA45ZXFS@lucifer>
 <aiagMc9Ng_AE_adh@lucifer>
 <aia93IzhTgi1vGi6@casper.infradead.org>
 <aia-q026facbptoT@lucifer>
 <d0ff6269-8b8a-4983-8569-d9a8495829f3@kernel.org>
 <aibSPsc33YQiYSMI@casper.infradead.org>
 <ef14cfdf-5f1f-4e3b-846d-fe1462042883@kernel.org>
 <aibVTe5HTk-fF_kj@casper.infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aibVTe5HTk-fF_kj@casper.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U1YqKH-yBW00pqhATbwAXsNRZiSfGAmuXT0c4OMBYas_1780947220
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 03:44:29PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 08, 2026 at 04:37:03PM +0200, David Hildenbrand (Arm) wrote:
> > On 6/8/26 16:31, Matthew Wilcox wrote:
> > > On Mon, Jun 08, 2026 at 04:26:18PM +0200, David Hildenbrand (Arm) wrote:
> > >> If that means that we would handle __GFP_ZERO consistently in the callers of
> > >> alloc_frozen_pages(), that would also do I guess. We'd still have to pass the
> > >> user address down to some degree, through folio interfaces only at least.
> > > 
> > > What I don't understand is how the kernel page allocator needs to know
> > > the user address in order to effectively zero it, but the hypervisor is
> > > able to zero the page without knowing the user address.  It feels like
> > > somebody has x86-centric thinking where cache colouring doesn't matter.
> > 
> > (not commenting on the icache dache mess we have to drag along)
> 
> Well, that was kind of the point of this email ... I did ask the
> question you're answering in a different email so let me respond
> to that too.
> 
> > The thing is that with free-page-reporting the memory is already zeroed by the
> > hypervisor as part of discarding that memory previously (e.g., MADV_DONTNEED)
> > and allocating fresh pages on re-access.
> > 
> > So it's not a question of "why is the hypervisor zeroing less efficiently", as
> > zeroing is just a side-product of reclaiming that memory in the first place.
> 
> We definitely have users who don't want the guest to trust the
> hypervisor.  So how do they disable this optimisation?

What do you mean, how? This is done by:

[PATCH v10 35/37] virtio_balloon: disable reporting zeroed optimization for confidential guests


-- 
MST

