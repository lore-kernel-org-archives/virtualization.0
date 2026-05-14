Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FBA3E2742
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770125; cv=none; b=FXkTQSbK1OSqPsUt4GKqAfpfpVDpzzBCRJOvt4J/hqAMT4xrkGcbZiF+jX8UblPlAqNqQp6ZyJFUrU3LwYDaxAcHd5rygNM5RrB78lnbudmB38qMtSemf671qLXgurMCnz8yq8x1qdR/L3n3CSfvtrJKbuTtGBda1BPITiZxPME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770125; c=relaxed/simple;
	bh=RoTpsSxAqLzGHF6OpqnVTjznAOKm4xLbpMTGt0b2oIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dlwngWKu07x0R/9VeG3EG19D28KkNHz9WelUnDZPjRNblcpUFzqJDCy+dl/YzmJb27bh+A/lMq/nlb2i8WS9tqfVvTbcy5yBeb3bDhSeXpN3QUZUs29IeN8GZAUYNPnDpRh7FpsHWfNnFhq+afcR4jNOKc22wQMdOOh2VIZ0ryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jNSDetyu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNSDetyu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778770122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8lq5bA9PpVd8zAdeuT9RbCrpou31meXet2f2WjOjauE=;
	b=jNSDetyuHW4KP7OyjgEYCWBY1zXGu1rgWZDcmK+ANdt04k5MKPTBSV+OCVmiZ2LwP7vXMl
	/MPSGf2LIjd8GSVNRmh2vmPIGJxst/jDsWOXV5pAuQq6rxdqxmbIsf+Ft3FC0VfHePCfG4
	6bfcYzJbWrCrHFqlReAtLGUhkXHPO1M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-JdghaqOhOyCpfYvh2XfH-A-1; Thu, 14 May 2026 10:48:36 -0400
X-MC-Unique: JdghaqOhOyCpfYvh2XfH-A-1
X-Mimecast-MFC-AGG-ID: JdghaqOhOyCpfYvh2XfH-A_1778770115
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44d79da8cf7so7283115f8f.2
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 07:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778770115; x=1779374915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lq5bA9PpVd8zAdeuT9RbCrpou31meXet2f2WjOjauE=;
        b=X6RC7vC/vcOePQHTwvk2VlWIU5xCIWhkrsqJPI/+oV3JiAJxU3krh0Iu7gkxs/ohbY
         WtCWnF7U3Vp12lergKw4m/iTRfDb0tlaNf69YXBR7xv5MquNLce6585QDjLkbdELhTrk
         1WmW4qmNLc0uR7F9YMEVWq1D80b7x1pqW3/OfDuqyF7bTUJzxSZEGA/EWCje8TqRAVbf
         okoicI4yj7rRAHR/nxHM7H412IX/8Zk9/FLlYeRz5pmhsqVN2rlO2QHRYfQin89+puAw
         2HJNrPvza6AmqRTF5lDz4dm65qCFaopp6yC0VNc70m0a0FxpJXXEGkYk4U3jTnPtvpt7
         PI5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+QolvH039w1SCJG0G5pR8JQDM/GAnzd8XKL4z+54yztxWe0PDKrsywmHJBwCyffBUyGXQrwjjd9qLXvGvP0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yykvt3kpnofD8ThxQ94rme0sHUx+JVQ9dOeBRSXoe42WIPb6VIU
	t0fK62Zjg24Ag4jruGSXmsiQAhedOCuJO0d4shdDYeGwInjFe66a9IKNRHtFvkSCSl8mpDcAbMm
	//Kw1q/A7GEiXWLGNXb/NfbVsv7nBq1sQHs1C9favLFjjq+0U/aszxoW3LvTj/xNaYCFp
X-Gm-Gg: Acq92OGelmXo/Xg1qmLidYCFp52eUT4EReRQ5MVRce+FhT7rptfrLDvNTyHBMSZQmSa
	tuLNR43AEXqac0OyJdeVcFpoT2xjVuVykK+tZXO4PBqieDuxRh/S/Vllb1SzHufMnB5uBdAICrK
	syDtbWqoa/V8qyguiOBQwwgnqvtAJKRMjE4QVn/qSltCMrOOAJfEnJlKdchXSmaepngjsbEdlhX
	SJdNw4dmREbzyOS5UNMsAt+yW+/wc+NR3ql5tV0vbHj5sf4TsRY9DNh3YaCoU2frX6X7fYv66Pa
	jixEnVRYjvN7Mi4FDjYlesy/+hdRpgCXx8ar79/zrj5CrhXUKuypTBh5CDR/7nrP2n5Hz5Sq++x
	JJnetxRH1fSt3EfVSZq7zO1ijjuo/kPOVmMC9AJRD
X-Received: by 2002:a05:600c:8589:b0:48f:dfe3:dae3 with SMTP id 5b1f17b1804b1-48fdfe3dc80mr22680965e9.17.1778770114865;
        Thu, 14 May 2026 07:48:34 -0700 (PDT)
X-Received: by 2002:a05:600c:8589:b0:48f:dfe3:dae3 with SMTP id 5b1f17b1804b1-48fdfe3dc80mr22680155e9.17.1778770114350;
        Thu, 14 May 2026 07:48:34 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe46118a1sm4126555e9.10.2026.05.14.07.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:48:33 -0700 (PDT)
Date: Thu, 14 May 2026 10:48:28 -0400
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
Subject: Re: [PATCH v7 02/31] mm: page_alloc: propagate PageReported flag
 across buddy splits
Message-ID: <20260514104735-mutt-send-email-mst@kernel.org>
References: <cover.1778616612.git.mst@redhat.com>
 <feab82b370b3e66b58b9cfbc1efaf26fe6061d2f.1778616612.git.mst@redhat.com>
 <agW3JyLAwVsCZ2qR@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agW3JyLAwVsCZ2qR@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1IOd2XMw2Pk9tbdyLfaU-dp6yZ5YQ_gt7AhCv51ma9o_1778770115
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2026 at 07:51:03AM -0400, Gregory Price wrote:
> On Tue, May 12, 2026 at 05:05:16PM -0400, Michael S. Tsirkin wrote:
> > When a reported free page is split via expand() to satisfy a
> > smaller allocation, the sub-pages placed back on the free lists
> > lose the PageReported flag.  This means they will be unnecessarily
> > re-reported to the hypervisor in the next reporting cycle, wasting
> > work.
> > 
> > While I was unable to quantify the performance difference, it is
> > an obvious waste, even if small.
> > 
> > Propagate the PageReported flag to sub-pages during expand(),
> > both in page_del_and_expand() and try_to_claim_block(), so
> > that they are recognized as already-reported.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Assisted-by: Claude:claude-opus-4-6
> ... snip ...
> > @@ -1731,9 +1740,10 @@ static __always_inline void page_del_and_expand(struct zone *zone,
> >  						int high, int migratetype)
> >  {
> >  	int nr_pages = 1 << high;
> > +	bool was_reported = page_reported(page);
> >  
> >  	__del_page_from_free_list(page, zone, high, migratetype);
> > -	nr_pages -= expand(zone, page, low, high, migratetype);
> > +	nr_pages -= expand(zone, page, low, high, migratetype, was_reported);
> >  	account_freepages(zone, -nr_pages, migratetype);
> >  }
> >  
> 
> Maybe mildly out of scope but worth asking:  Are there other flags that
> should be retained/propogated on a split?  If so, rather than pass
> was_reported, should we just take a temporary copy of the page flags and
> pass them all in?
> 
> ~Gregory


Not that I can see, no.

-- 
MST

