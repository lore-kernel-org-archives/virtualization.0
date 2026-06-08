Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4082350A05
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948976; cv=none; b=umMTRJG0N57+E/duHLwDBqTQZBjLxdVxkdHD3R3jFAq+knYOVmYvFX2QVAkpe+VBHn/J10yRGWPqT/mPUGi4bEurK3BQmyrtJIUK/pa4ysCnBNAHSoQTR41Z3k9CUB48yc97DDGFMvDm4X7XqYKfgDrOptJ7QVym1C+eDwBdrAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948976; c=relaxed/simple;
	bh=V+yUVZMaUimdnWSsqGxmPyR0wyyg9bFk3YmZGO2VTP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=o+Q2cDZyU2QuqeAtq8tOO9JYY/g2WsNuxtNhEL4mh4RkwH5VVaDqD+6lRHHn8p8AgXh5LEsVvLbbLUVrblX7hXZcTOgjwOPnMpqvkeQSLrkCBReY2aKNBGsVjvkpssYNswkWOMtVGeClqhgjNTU52pbIQboIVQDGVbr+3dTnYTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4XN1cnD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4XN1cnD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780948973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jC1tTvHqlbFZPbaAWrLUXLjciqPdje/xAc2SJm5nUKk=;
	b=Q4XN1cnDPhATSF4CMr8isaERnn55NBOatAoKAzEanI2mGeChZyAMRtYCy6lfJEmskTKm/E
	ILU//Fipafu+1IaosplbyfWcWEPKGtg/ePwCj4+eh7F1RceK9ya+kQ5PIS/VIzJ+F6T6s2
	9VUqW+XXiNLN3hvmFjRz4C0X04AXSNs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-znCzBPTvPkagBn0Oj-OPHw-1; Mon, 08 Jun 2026 16:02:50 -0400
X-MC-Unique: znCzBPTvPkagBn0Oj-OPHw-1
X-Mimecast-MFC-AGG-ID: znCzBPTvPkagBn0Oj-OPHw_1780948969
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b9cd54f3so38955945e9.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 13:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780948969; x=1781553769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jC1tTvHqlbFZPbaAWrLUXLjciqPdje/xAc2SJm5nUKk=;
        b=DVUVGVydnFgGGxQ+qiHCh2ITn+9enzp8jNnRuTIu6Z4Erc3hIjKrpvLSRTH72gfF30
         9noWMkKuruysWBL4SVRxSWBLsGnQ5AMIyUUqA4OM3gCdd4mXdNH/19qt1zKCgaVTQjds
         92/nEJOyCgn7YjTOMVc+RTbZ1pOVNYOCXHIloe4WjmjVHFjuD5dVz4t4OJqhhxsyqF+6
         EnW7iy0J2ad746waImNavuCEAZhEtw/29HnADc561yiMkOlPU7HdObZ+tgzZCm3xa5dA
         CzYElniDN0MovHRSo4EQ1waYo37JkfdKQOcfyUdBb+bU1TD9TQWz7dV6dTI21A4hQTNY
         RJpA==
X-Forwarded-Encrypted: i=1; AFNElJ8MEzrWZpAQn3g+RkrXJYfHiIDzbDd6L1Ntr5qfhPIi/B1S5IX0XBf6FAypRHidVYpPZ2rvGAf+pHaHjemaRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+rO1TRS845y0bDXzgPwU56ZXnUFnAZiSXHlSx0cqWtKSEfHW4
	z1b2w4Oybsqdgwipz9sdI6w8JRfv5LN4p9VEwnqUdGubED88TuSqCxS0w3Rgb/FHLo6SgccdMn2
	2JbiUa986Ck5jarzqTsg6q/TN64rcxJhKi19nf+I2Xwn6ooww3P8BI8XlLphHSJtDZ0ZP
X-Gm-Gg: Acq92OFNNoQJ8uR7/w3sht20appZMOp3rdXIhhStdFyRTaxVqW7HJAohidzqFg3+e6s
	zV0rLOTSAj5Zwn54dSpHmXq6Gr5T2oD2GV45wEV2vsJGXVuHawKfxS01lJSPJCL64IWXTategYg
	l/VphP+qfAl/xJKLhcSYw32FTt2/K85CeVEEVmsmKN7qf8Q2nDVPfoTuNZ8DCumL5GKCkiLfUoG
	fyzsWkHPLRR5dqb2A55SGWp2pfvjT/dbYa6Mxgrd/SA3OxcxJ2YbG5hJABBzc5bFEADzbRB7prK
	P13AvV3/YxsJSQFYOll9K+pJRD/hDGr+EQ0e9948rBJbi5EjEPG9J3J9A6PKElBxTeFx3GnA22/
	gZdcjBmgXPWPbeLEtVMapZp3EzMMkrxLy+yi25OyNl9Lu6HrCHupTTw==
X-Received: by 2002:a05:600c:8b6a:b0:490:688b:ece5 with SMTP id 5b1f17b1804b1-490c261b08fmr264136035e9.30.1780948968649;
        Mon, 08 Jun 2026 13:02:48 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6a:b0:490:688b:ece5 with SMTP id 5b1f17b1804b1-490c261b08fmr264135465e9.30.1780948968213;
        Mon, 08 Jun 2026 13:02:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d663csm466704125e9.11.2026.06.08.13.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:02:47 -0700 (PDT)
Date: Mon, 8 Jun 2026 16:02:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
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
Subject: Re: [PATCH v10 00/37] mm/virtio: skip redundant zeroing of
 host-zeroed pages
Message-ID: <20260608155918-mutt-send-email-mst@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
 <aibP5W-fGcyPp9e4@casper.infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aibP5W-fGcyPp9e4@casper.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CEMFsvFZ5zkt4huMaO8HAN57jUp2h-_TV0sBDiDFp8Q_1780948969
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 03:21:25PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 08, 2026 at 04:33:46AM -0400, Michael S. Tsirkin wrote:
> > Further, on architectures with aliasing caches, upstream with init_on_alloc
> 
> Further to what?  Did you leave out some paragraphs here?
> 
> As far as I can tell, this patch series decides to trust that the
> hypervisor has zeroed pages that it allocates to the guest.  But
> as far as I can tell, the trend is towards less trust in the hypervisor
> from the guest, not more.

AKA confidential computing. I'm not a visionary, no idea about trends, but
yes these are used more than in the past (not hard given it used to be
0% of the market in the past).

Page reporting already leaks some info like free page addresses, so it's
for trusted hypervisors.

Anyway:
Subject: [PATCH v10 35/37] virtio_balloon: disable reporting zeroed optimization for confidential guests

makes sure guests that do not trust hypervisors are not affected.

-- 
MST

