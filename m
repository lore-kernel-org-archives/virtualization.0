Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51A23655E9
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600820; cv=none; b=VqIw34snKxLqipYW33cwiutB3Ro5RwThriAqSnxBDrWIpUztQhQBXWf8lVoZ14ir8OqyNY3vz/OEcPgzObZtGwEMThHA4p9Au9eLYAOkb1gGsCd6LmwQNL1eUBWek3gLD6KaNosJW4WvWovTst0bUNvCu8K5TlxbbJxvLoQL+P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600820; c=relaxed/simple;
	bh=85MVWieRjIr9XeWPe00hVIwtpgpudGUooADPlWLQ24Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XL0RC7rjOeKJS3vyzeMaxfDyDBvQ+Z5hK6i8KThsV8GdeA3Pi7gOZjm6elFrNlzSPqQJTC6jFnIdxMxJOJbcY3XQUhfsGHtkxC5E2rBZhK7yRrnJ3q7f3bEfefsUvaODtMjlbttbysIXyQh8Y4IjBY7s1Vy03IMXpmxozL7raJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iYwkEbu8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYwkEbu8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778600817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bz4SWbhgAVm51cXT8NXKcag9UUTqJROZ/+vdmfbYWAM=;
	b=iYwkEbu8ofxRHC3kDpGFd3nrWbs9OCNzXaErMkIJrsA6d5piSSO8hqsWfpA+f4nXmbIpwL
	CTeg/Jct1lS0maqjko7e5tIbHcSTP3sFGQVJusOBLTWkHHon1t8k47TGWftRguF+KJO1x/
	jDsqHjGuyrHas7ICMmWAPqFEt+4q3C0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-C3Fn9dnJMm-k-lXLmlZ4Cw-1; Tue, 12 May 2026 11:46:54 -0400
X-MC-Unique: C3Fn9dnJMm-k-lXLmlZ4Cw-1
X-Mimecast-MFC-AGG-ID: C3Fn9dnJMm-k-lXLmlZ4Cw_1778600813
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4411a36715dso4134051f8f.2
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 08:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778600813; x=1779205613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bz4SWbhgAVm51cXT8NXKcag9UUTqJROZ/+vdmfbYWAM=;
        b=SdUGDHFUpP6w9gWUVW5azSvesLX0bCW7diJOz/ZzGb5b9S350/cZgjp7ecnyVTt6sf
         gGJ6PG1WX4qZU2BOCWk/zRGwmYMauwtLimViB8q/Rx18IpZc1QFIy9PQS+WS6UNB7dth
         jaTveOb5eRtzJB4MEPFHa4G7WF3/ugzDMSnf2gFM/Mv2SCNkYL9bOoZXuoQD2ynUvHi+
         F+4FzxOBeMXCUj4LSghYxqvpW8ix9x58idImsIeHjnHQ670ZtWoWS6WRKgBPwE/nRTVj
         BfKAKD/X9kU0Yg/QPKcm69mMnFETFOVIZNM60A4PNCUa6kTw8fm5jn96ZOXPfkTYtZRd
         e3Ag==
X-Forwarded-Encrypted: i=1; AFNElJ8QcGxC+MUxJ45LJdtG0J9hIYKgcT4q56VuKE6BHIDNa55o7nZ5q6p+MKMLOua9nSSrrR8GLryXBKQYOD22qA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRNrcvi3yGF6StmMkdhdNCV4RRKIW9LNptaMmzymlsWQApX4v6
	04LOfksweDPyhYuX7125cnUdGhY0ht7lxdNREysOoZb09Tr1pGE1bBhuW3XiYvcanPB/Cc4tuiC
	cIqfAjP1itQ8Gj/2BodhZu4sn+m1e2BpjCHT+Z2bbh2Dvt7l5R53G0WG9tiLNwqDwF+Wd
X-Gm-Gg: Acq92OGSKcheEj9NXls63BU0kdZoMYTajI25rl+ZmGDEiE0mkA7X3wBfZL1Thr6qWOc
	2yErc+mh7Axy+871jY01ziY71j5QeCeC6ND9nXRaiy8trwZYje6/MXKQhExQHEHN/Wus4CWHbSq
	BRgMEp6kyhTpXP9DZfLaywNI8T0PztXe6OejZpV4TsJlX1AXuG296mJrhPGPbl89PLO09jY/N+5
	gx00DsobLiWqG6ITRG/Y10Z+a02+mrFpg0tz0URxHTGojOp1vLPayH1G40jSf1JmvD8tQK+Yoo9
	nfhhmYKHrubCQvmvk0Z7zDIA1RTVPoHXmsSHY+RrOFBwsQYW/rsM75fPZV8vC6gDQd3zSutP2MY
	F11/ge0UEwe4N9yTLdEX1oRUbZ+xYwCOG0o3dHorA
X-Received: by 2002:a05:600c:198a:b0:489:1c1f:35f9 with SMTP id 5b1f17b1804b1-48e8fe50bbbmr58590555e9.9.1778600812916;
        Tue, 12 May 2026 08:46:52 -0700 (PDT)
X-Received: by 2002:a05:600c:198a:b0:489:1c1f:35f9 with SMTP id 5b1f17b1804b1-48e8fe50bbbmr58589455e9.9.1778600812271;
        Tue, 12 May 2026 08:46:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454913049ecsm32654384f8f.19.2026.05.12.08.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 08:46:51 -0700 (PDT)
Date: Tue, 12 May 2026 11:46:46 -0400
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
Subject: Re: [PATCH resend v6 17/30] mm: page_alloc: propagate PageReported
 flag across buddy splits
Message-ID: <20260512114352-mutt-send-email-mst@kernel.org>
References: <cover.1778489843.git.mst@redhat.com>
 <6d98a35c94fa44b550afa66923c620511e2826f0.1778489843.git.mst@redhat.com>
 <agNJ2BFRVTKINliT@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agNJ2BFRVTKINliT@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2izB9NthwtQhbtUBvjiLsbnZxMxrf7F27PTrQW3WCKw_1778600813
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2026 at 11:40:08AM -0400, Gregory Price wrote:
> On Mon, May 11, 2026 at 05:03:19AM -0400, Michael S. Tsirkin wrote:
> > When a reported free page is split via expand() to satisfy a
> > smaller allocation, the sub-pages placed back on the free lists
> > lose the PageReported flag.  This means they will be unnecessarily
> > re-reported to the hypervisor in the next reporting cycle, wasting
> > work.
> >
> 
> Is this issue generated by the changes in the overall patch set, or an
> issue present regardless of the proposed zeroing avoidance feature?
> 
> If the former, then maybe just submit as a standalone patch, seems like
> a useful improvement regardless.

The former but then the only issue is more reporting, and
I couldn't find a benchmark that would quantify the performance
difference.

So the value of pushing a fix by itself is pretty low.


> If fundamentally tied to the zeroing-avoidance feature, then nudging
> this to the front or end of the series (depending on conflicts) would
> help focus the review of the core new feature.
> 
> ~Gregory

I can nudge it forward sure.

-- 
MST

