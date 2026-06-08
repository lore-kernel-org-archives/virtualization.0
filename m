Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CAD27B50F;
	Mon,  8 Jun 2026 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923018; cv=none; b=Vx5dDTuEjz3QzJJmDXWoIN8hiF3o/TXJWUjJlXLeNDbfJqyraj2Rey1wkFQncp3yQJyYvLo/1YgGSRH2ZqxDAiD2HcQXPEa/hjkaxfKQwDQyXxQTXTVtLhlK0y+6oEeBs2J+NvDdxjSm+vyszs9IOZuKAfd6PMYwP2WLc3MRcFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923018; c=relaxed/simple;
	bh=ONLKa3SjpGexyUZUz+OB4ThbnzpIZm9cjt7G1mGtuU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeHIVx43O1cQ1Ii49Cz70iMl9fVSIG7MnMMXU3g9pVJGG1zxWlB7OMWVExXai3ZtoH3GlSTxVGaCwAcGxbXroqRVdota+MIGHDrQQ01qvV8vod3LOJVAeZzrdrGi4FaQt+I3pZtQH2rZGj+OCxTqqSHhRQGSbXGHtr5GA42UJ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ax2evEU/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ax2evEU/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wFSoIlYiJRdf5MABSyRuyjOJ1eim/XMAOiAPmWPfi6Y=; b=ax2evEU/z8zku5iFN5ybCSrJOl
	f8RxcntFgAaTMGUM3dRw+l3qxIA6hLdGcaOwwO5imUanvWjSIX0kvB8DyTBu+4p5co5/gdlAI/fIb
	co37YsjfIqIRXNoRyJjIKvVJLy3R3asDr/62h/YXDHiw4fjcsItj5tTu5oTeKFLk9m8rEr/7SOe93
	n1L+hTszqKknmsEvzB4akay7IpElFQgBwmdPHNCMvZOk7StVD9dVCj8vEwahDSLj4TcTbzW/clg8f
	d5yNjjicKhRBpFQxuhjcjqc4mTv0/2V8YnIBzZviYWOD2NUTIrowev11AXRilq6h2tLZ1TSDamCtv
	HGZMc4VQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWZQZ-0000000DiTT-1d6G;
	Mon, 08 Jun 2026 12:50:03 +0000
Date: Mon, 8 Jun 2026 13:50:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
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
Subject: Re: [PATCH v10 03/37] mm: page_alloc: propagate PageReported flag
 across buddy splits
Message-ID: <aia6e_i2usmEhBhF@casper.infradead.org>
References: <cover.1780906288.git.mst@redhat.com>
 <1a407d39a9ebd95e9de67e44f9ad2db37c9f31e9.1780906288.git.mst@redhat.com>
 <aiaPBRm0Mp_WDPFa@lucifer>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiaPBRm0Mp_WDPFa@lucifer>

On Mon, Jun 08, 2026 at 10:52:28AM +0100, Lorenzo Stoakes wrote:
> > -			split_large_buddy(zone, p, page_to_pfn(p), p_order, fpi_flags);
> > +			split_large_buddy(zone, p, page_to_pfn(p), p_order,
> > +					  fpi_flags, false);
> 
> I don't love adding a mystery meat boolean parameter like this.

Particularly when we have the FPI flags already being passed.  Surely
this should just be another FPI flag?

