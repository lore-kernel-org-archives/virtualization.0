Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34712C0F84
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778773651; cv=none; b=OT8GM+/gqI1BXyfem1DgzD6bRKHDaNp6Dei5cOd0OZ3oex3srdnoubP8tC/6EbRVodcQjqZQvxxOWuRm0ArWk+xAvcL8MCTYhT17DTeq/vVbQ4uJDBmfzyQgF4XqVQM+SKMPhvsMMJlYK2h022Vxi58kJyWGJ57Z/89XiKc8/sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778773651; c=relaxed/simple;
	bh=sBS9FZZLijles2p8ZJzPyEoJGKrDkc+L9rT8SXjdOlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oXXG+O15d++Qkwyj1ZsJZIghgv7wk1WD9BqtIz+5Ba/tEF/3fIf5MY+fvc0BWktWiglznRlQUGBUwYtMZjrR8IUEF2qJ7ZGTeox9KRfy1f+hqreFYMM6doJCEvSE156LhApVfULani1vQ983qI7jXK2iAM+CgoDUITgRA5W0So4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hgzh3q1B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hgzh3q1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778773648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bqdtv1pQkNj5ZtCXeAHZim6ZUYoMn7Cztcf2yOjIZPA=;
	b=Hgzh3q1B6on+SeLUhaXlg2qaY3n+0tm+2iP++AHO4wQ3wELAaBXmBh1j7Nno2t4yQMho6I
	dFSlfMezX/n915YPSX+o42HKn/H9f1aVPfcpwqTN24jp+OBSyp2nF/i6T7hPR7qJeE5DjE
	wAIzN985Bz7SRHWiHG1sP6nICEpS3nc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-8lb1_78rNTqSCQewfMtHiA-1; Thu, 14 May 2026 11:47:27 -0400
X-MC-Unique: 8lb1_78rNTqSCQewfMtHiA-1
X-Mimecast-MFC-AGG-ID: 8lb1_78rNTqSCQewfMtHiA_1778773646
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4411a36715dso5839527f8f.2
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 08:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778773646; x=1779378446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqdtv1pQkNj5ZtCXeAHZim6ZUYoMn7Cztcf2yOjIZPA=;
        b=VzgJe3jWWq5n7qMbdVVmMIAHElfVxBtw2adRxv7ZW7ySS2pBUf8jkfnEEKxdQocFWO
         1j5gJraMl+TGGg2c23divbeyfo8z5bTMqRpncYwNdfHDiuuPHQFrlSlUfy/MQyChgDfX
         yt331r7NkpzXPvyXA+5TMTYHxlXCQY9WDBhSy2uvwLxJZgAkJ1xV/0HGTibW67fSiKYL
         4xhZFEjknJYRpkv8wJKOGBDnFAMdxedo65e1ekTo9QZGW0QNJTfgUS8QHVwdCCDMox68
         NGu98JTB63vcoXvBqy450PA64hO6t4Xoj1dtxfAjeQZ0/EE77ZLGLl/cHb439KP8qexo
         6izg==
X-Forwarded-Encrypted: i=1; AFNElJ9Mc4YY4ylzpSwV6spuONzo11ZrF7PlZ0wrMmjhR5awFNbJK76c/lClsBns//vz/SIJv0WpN4tWxNQ0OaqClQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyX5MjS920ATajiGexStkWhEOFB9ahEJgVRS6q7+zXxuLj9+y3G
	pPYatd61covhrePiHsV6FFzlMtckG6nzlZquEeBK8mbyh+yLcFenqkrnyXoXD/O3grZpO/tA2bu
	SjA51rZ0ZfOLps81I3SvMfec9k9ESPfKnjns9uUbAd/VHSC3pXkyrKg20UfegH7BZv/9Q
X-Gm-Gg: Acq92OHqFL1GU3RRXtRFb7qQgkmph5mKMDdxmcjAyVQ/eHeZ2l+IU8DU2s6IF7S2I4w
	80iqEnXfwqGKi7jGZD8tCh0RKVxAoBPwP/rGAKliU4Vz4/0uDOMvBT9eUouqVRlfY1aF+oVH4zK
	5wysZ7Ooy+z+KK07J9fupxCNU+V61s4qxIJan/woAGS7a5PJUEXP6Z0zttoVevADhJ1lhSlwmjg
	WdAbJoK7SaZqFfSUHXTbrwkN2eHLThgmxER4QeGYLe7n7QimZk3NIZY63Ntrc8LDL+AyP4ge5VW
	46jJBmLBoRg2QOoIjoV820p9daCg6kbyvLj8ogCXkr5xYKZvDaQpAam9joRLvt1KJflr1lmRKQ9
	fDd8HscPsTUBi0a6sfVUjijRXa486GxHjPXQ+pxd1
X-Received: by 2002:a5d:5f45:0:b0:449:a07a:967f with SMTP id ffacd0b85a97d-45c5a1a8e93mr14113755f8f.28.1778773645902;
        Thu, 14 May 2026 08:47:25 -0700 (PDT)
X-Received: by 2002:a5d:5f45:0:b0:449:a07a:967f with SMTP id ffacd0b85a97d-45c5a1a8e93mr14113648f8f.28.1778773645241;
        Thu, 14 May 2026 08:47:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm7555351f8f.16.2026.05.14.08.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 08:47:24 -0700 (PDT)
Date: Thu, 14 May 2026 11:47:19 -0400
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
Message-ID: <20260514114637-mutt-send-email-mst@kernel.org>
References: <cover.1778616612.git.mst@redhat.com>
 <feab82b370b3e66b58b9cfbc1efaf26fe6061d2f.1778616612.git.mst@redhat.com>
 <agW3JyLAwVsCZ2qR@gourry-fedora-PF4VCD3F>
 <20260514104735-mutt-send-email-mst@kernel.org>
 <agXrCinY2HmJmhT6@gourry-fedora-PF4VCD3F>
 <20260514113337-mutt-send-email-mst@kernel.org>
 <agXtOeuYNin9nYN8@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agXtOeuYNin9nYN8@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bMM-KHkYmMkfExGN2cpsph_oRnHCmF0LuZT-tlaT7IM_1778773646
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2026 at 11:41:45AM -0400, Gregory Price wrote:
> On Thu, May 14, 2026 at 11:34:14AM -0400, Michael S. Tsirkin wrote:
> > On Thu, May 14, 2026 at 11:32:26AM -0400, Gregory Price wrote:
> > > > > 
> > > > > Maybe mildly out of scope but worth asking:  Are there other flags that
> > > > > should be retained/propogated on a split?  If so, rather than pass
> > > > > was_reported, should we just take a temporary copy of the page flags and
> > > > > pass them all in?
> > > > > 
> > > > > ~Gregory
> > > > 
> > > > 
> > > > Not that I can see, no.
> > > > 
> > > 
> > > You do this exact thing again later :]
> > > 
> > > https://lore.kernel.org/linux-mm/9a22e0f9bbe1278913754db6df76e291a006181a.1778616612.git.mst@redhat.com/
> > > 
> > > ~Gregory
> > 
> > I mean yes, reported and zeroed) Just zeroed does not exist at this
> > stage in the series.
> >
> 
> More of a forward looking question: if we already know we're adding
> was_reported and was_zeroed, maybe we should just pass the page flags
> through entirely and let expand() check them instead of passing it
> through individually.
> 
> We end up doing something similar with post_alloc_hook later as well, so
> I'm wondering if there's a general improvement that can be made here.
> 
> ~Gregory

sure, will do. do you want a bitwise thing for type safety? or just a
long?

