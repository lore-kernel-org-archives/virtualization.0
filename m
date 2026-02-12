Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26A81632DD
	for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770880116; cv=none; b=jFc05TK2WsZduwe8809yTzH4rX3OBGc3dTk27E95qN+najvnA6uatn+pGnLoA070M/GeLurc4rOeGm3XI0W++9uG2PEQ+Ue9muV0qh3xq0x54ltPIWcTipDSSerGEmtWYLiHUiLCEfxg6I+YKmhDKUpw6yM78Q/2LdeJYhWBxDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770880116; c=relaxed/simple;
	bh=CjcgXdxP+xjqkyXNcKDlN8l9OSb+idOpSc3Nc4bhWQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RSS92IHo+I64m7g3ZJ7dyRh56zuuNH0B4F5sh7jm/5Lfc5VOuSUyb1Ao1TaNg9WgMJ550hfCU0ebEMX1RIARou1SkYwnahq+1Qt+tZQ8ug65xE2h4X/jyABCgU2zyn/jeEjF9amlXIlUBCxyO4JVs0HnNT0fCu7B47o29+ScQA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cscbGRzT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cscbGRzT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770880114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6szOd8jTk+em3arREJHLemha25ur2Z/Igpvrny3vPyo=;
	b=cscbGRzTHbm3WBXYvK291fCVCbKX1D65rU+nO9t2zvug7TGRuZVqCkD47BpVwty9YOyxRj
	36z1Ft1lAdK2+rXsQrbjHg4rL+5iNdqgld/7cNsZTNFnBo81WvpRdLwfyzqXkljx2UzwPF
	IxRjpmEbhC+beED+TPnzRf0830oELVI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-oWwZRESsOnCpq0JT0FsADg-1; Thu, 12 Feb 2026 02:08:30 -0500
X-MC-Unique: oWwZRESsOnCpq0JT0FsADg-1
X-Mimecast-MFC-AGG-ID: oWwZRESsOnCpq0JT0FsADg_1770880110
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-480717a8ef9so14937035e9.1
        for <virtualization@lists.linux.dev>; Wed, 11 Feb 2026 23:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770880109; x=1771484909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6szOd8jTk+em3arREJHLemha25ur2Z/Igpvrny3vPyo=;
        b=hCWCNK0e20XZWbr3rDT9wPEcysMK8y3ZH6IoN601TBSrgX/NM5WSVWnlUQv1WBPrI1
         xfUx4Y4KufsbKKsU8e/vKD1LnImnNl5Dz4i6I/Z3bNXZBl1VDPbhsoJ5i9ze03xRL0oB
         ciHfTzwW1oL3/mDfMr1DGZxHeksvtxsB7OLVuXgkcKFrVlBdlN0o2z0CUuOV2KG3Ye7M
         IXjLcsCgfPBpiEC8L3bB0YvWb4aF6F436fsC/889zJ5fgQF0WGspBjny1V4EqKGJnhfJ
         tThLmx8uaMQsVlNQGy+uujnGLAu0dTQOA9VadZKEnIKXnZ1HIK7gJDwXvoSCZXhw9skp
         +r3A==
X-Forwarded-Encrypted: i=1; AJvYcCXcGPGAll6hX9V/L8rK4ynVkX8WdkP2QXwkpUQ2CDUoKnH0fygI8QxnaMlvbIlIEqb2JqsSAZo1ExZHV3gmpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdDzBSp/N6k9FqL3u7/upsHSyf3u6b2dI5UQDRwB0RrJ9wCvAi
	4vfxiz3CoPUdM2GxUv+FiFCWmMtCWQzWJiOUYa2eMej+Srif1IB5KpayfrWc/gcRaneCai42Onv
	WkEPikJ+lwgZMtqzrq9hZ2hHO/hed9I1xBKDpMzNteWbzRde27zO/f5kPwsrTJg+H/Jpd
X-Gm-Gg: AZuq6aIe8xp1e5KJPum5ladcIAXRNIlz3o+SxkE9jbCdG/nghKtwBQfMgN2KOusKZjN
	/UCd5Co4wL2zsEe0fGHwzEPbEn89qZvNGXxNbQM+zqNYWz+ByUnKbxJ9mkVr3rMrSVhkjK+sYR7
	dkc5FDf5jLNmBU9tMe1sAwZqbqqxgLqlIHCSr9IHJZQNsR0y+nmituK2Y9JW/0XJHd9vtK6G//U
	K5xypbkBJxolWbTGGFBY7RmSnC8KY51qlOVmQJt/CFDegrZ0XN+qHQWVG6K3WoONUZvuZjogH15
	vZ4Dv332Nw1JNulDXPAhRvEYnGa6UQS2UJq1hErTdEa1KH3x1BEAj6Xzsrvk6PHnaV8HLaFqDXz
	xJsp6i3EDBVsfVTEVw7DEy/3kWoglJClqFalhoPZgdfkYzQ==
X-Received: by 2002:a05:600c:4e4f:b0:47d:333d:99c with SMTP id 5b1f17b1804b1-483660425a9mr18452105e9.18.1770880109529;
        Wed, 11 Feb 2026 23:08:29 -0800 (PST)
X-Received: by 2002:a05:600c:4e4f:b0:47d:333d:99c with SMTP id 5b1f17b1804b1-483660425a9mr18451585e9.18.1770880109005;
        Wed, 11 Feb 2026 23:08:29 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d989165sm119619155e9.2.2026.02.11.23.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 23:08:28 -0800 (PST)
Date: Thu, 12 Feb 2026 02:08:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: linux-mm@kvack.org, apopple@nvidia.com, akpm@linux-foundation.org,
	axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
	david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
	jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, matthew.brost@intel.com,
	mhocko@suse.com, rppt@kernel.org, muchun.song@linux.dev,
	zhengqi.arch@bytedance.com, rakie.kim@sk.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, surenb@google.com,
	virtualization@lists.linux.dev, vbabka@suse.cz, weixugc@google.com,
	xuanzhuo@linux.alibaba.com, ying.huang@linux.alibaba.com,
	yuanchu@google.com, ziy@nvidia.com, kernel-team@meta.com
Subject: Re: [PATCH 2/2] mm: move pgscan and pgsteal to node stats
Message-ID: <20260212020724-mutt-send-email-mst@kernel.org>
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-3-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260212045109.255391-3-inwardvessel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6Z0xA4JK6w-r-KUqLw75-37EKGuDo8L6NY8BlS7bw7A_1770880110
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 11, 2026 at 08:51:09PM -0800, JP Kobryn wrote:
> It would be useful to narrow down reclaim to specific nodes.
> 
> Provide per-node reclaim visibility by changing the pgscan and pgsteal
> stats from global vm_event_item's to node_stat_item's. Note this change has
> the side effect of now tracking these stats on a per-memcg basis.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>

virtio_balloon changes

> ---
>  drivers/virtio/virtio_balloon.c |  8 ++++----
>  include/linux/mmzone.h          | 12 +++++++++++
>  include/linux/vm_event_item.h   | 12 -----------
>  mm/memcontrol.c                 | 36 ++++++++++++++++++---------------
>  mm/vmscan.c                     | 32 +++++++++++------------------
>  mm/vmstat.c                     | 24 +++++++++++-----------
>  6 files changed, 60 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 74fe59f5a78c..1341d9d1a2a1 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -374,13 +374,13 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb)
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_ALLOC_STALL, stall);
>  
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_ASYNC_SCAN,
> -		    pages_to_bytes(events[PGSCAN_KSWAPD]));
> +		    pages_to_bytes(global_node_page_state(PGSCAN_KSWAPD)));
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRECT_SCAN,
> -		    pages_to_bytes(events[PGSCAN_DIRECT]));
> +		    pages_to_bytes(global_node_page_state(PGSCAN_DIRECT)));
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_ASYNC_RECLAIM,
> -		    pages_to_bytes(events[PGSTEAL_KSWAPD]));
> +		    pages_to_bytes(global_node_page_state(PGSTEAL_KSWAPD)));
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRECT_RECLAIM,
> -		    pages_to_bytes(events[PGSTEAL_DIRECT]));
> +		    pages_to_bytes(global_node_page_state(PGSTEAL_DIRECT)));
>  
>  #ifdef CONFIG_HUGETLB_PAGE
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 762609d5f0af..fc39c107a4b5 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -255,6 +255,18 @@ enum node_stat_item {
>  	PGDEMOTE_DIRECT,
>  	PGDEMOTE_KHUGEPAGED,
>  	PGDEMOTE_PROACTIVE,
> +	PGSTEAL_KSWAPD,
> +	PGSTEAL_DIRECT,
> +	PGSTEAL_KHUGEPAGED,
> +	PGSTEAL_PROACTIVE,
> +	PGSTEAL_ANON,
> +	PGSTEAL_FILE,
> +	PGSCAN_KSWAPD,
> +	PGSCAN_DIRECT,
> +	PGSCAN_KHUGEPAGED,
> +	PGSCAN_PROACTIVE,
> +	PGSCAN_ANON,
> +	PGSCAN_FILE,
>  #ifdef CONFIG_NUMA
>  	PGALLOC_MPOL_DEFAULT,
>  	PGALLOC_MPOL_PREFERRED,
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 92f80b4d69a6..6f1787680658 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -40,19 +40,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  		PGLAZYFREED,
>  		PGREFILL,
>  		PGREUSE,
> -		PGSTEAL_KSWAPD,
> -		PGSTEAL_DIRECT,
> -		PGSTEAL_KHUGEPAGED,
> -		PGSTEAL_PROACTIVE,
> -		PGSCAN_KSWAPD,
> -		PGSCAN_DIRECT,
> -		PGSCAN_KHUGEPAGED,
> -		PGSCAN_PROACTIVE,
>  		PGSCAN_DIRECT_THROTTLE,
> -		PGSCAN_ANON,
> -		PGSCAN_FILE,
> -		PGSTEAL_ANON,
> -		PGSTEAL_FILE,
>  #ifdef CONFIG_NUMA
>  		PGSCAN_ZONE_RECLAIM_SUCCESS,
>  		PGSCAN_ZONE_RECLAIM_FAILED,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 86f43b7e5f71..bde0b6536be6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -328,6 +328,18 @@ static const unsigned int memcg_node_stat_items[] = {
>  	PGDEMOTE_DIRECT,
>  	PGDEMOTE_KHUGEPAGED,
>  	PGDEMOTE_PROACTIVE,
> +	PGSTEAL_KSWAPD,
> +	PGSTEAL_DIRECT,
> +	PGSTEAL_KHUGEPAGED,
> +	PGSTEAL_PROACTIVE,
> +	PGSTEAL_ANON,
> +	PGSTEAL_FILE,
> +	PGSCAN_KSWAPD,
> +	PGSCAN_DIRECT,
> +	PGSCAN_KHUGEPAGED,
> +	PGSCAN_PROACTIVE,
> +	PGSCAN_ANON,
> +	PGSCAN_FILE,
>  #ifdef CONFIG_HUGETLB_PAGE
>  	NR_HUGETLB,
>  #endif
> @@ -441,14 +453,6 @@ static const unsigned int memcg_vm_event_stat[] = {
>  #endif
>  	PSWPIN,
>  	PSWPOUT,
> -	PGSCAN_KSWAPD,
> -	PGSCAN_DIRECT,
> -	PGSCAN_KHUGEPAGED,
> -	PGSCAN_PROACTIVE,
> -	PGSTEAL_KSWAPD,
> -	PGSTEAL_DIRECT,
> -	PGSTEAL_KHUGEPAGED,
> -	PGSTEAL_PROACTIVE,
>  	PGFAULT,
>  	PGMAJFAULT,
>  	PGREFILL,
> @@ -1496,15 +1500,15 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>  
>  	/* Accumulated memory events */
>  	seq_buf_printf(s, "pgscan %lu\n",
> -		       memcg_events(memcg, PGSCAN_KSWAPD) +
> -		       memcg_events(memcg, PGSCAN_DIRECT) +
> -		       memcg_events(memcg, PGSCAN_PROACTIVE) +
> -		       memcg_events(memcg, PGSCAN_KHUGEPAGED));
> +		       memcg_page_state(memcg, PGSCAN_KSWAPD) +
> +		       memcg_page_state(memcg, PGSCAN_DIRECT) +
> +		       memcg_page_state(memcg, PGSCAN_PROACTIVE) +
> +		       memcg_page_state(memcg, PGSCAN_KHUGEPAGED));
>  	seq_buf_printf(s, "pgsteal %lu\n",
> -		       memcg_events(memcg, PGSTEAL_KSWAPD) +
> -		       memcg_events(memcg, PGSTEAL_DIRECT) +
> -		       memcg_events(memcg, PGSTEAL_PROACTIVE) +
> -		       memcg_events(memcg, PGSTEAL_KHUGEPAGED));
> +		       memcg_page_state(memcg, PGSTEAL_KSWAPD) +
> +		       memcg_page_state(memcg, PGSTEAL_DIRECT) +
> +		       memcg_page_state(memcg, PGSTEAL_PROACTIVE) +
> +		       memcg_page_state(memcg, PGSTEAL_KHUGEPAGED));
>  
>  	for (i = 0; i < ARRAY_SIZE(memcg_vm_event_stat); i++) {
>  #ifdef CONFIG_MEMCG_V1
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 614ccf39fe3f..16a0f21e3ea1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1977,7 +1977,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
>  	unsigned long nr_taken;
>  	struct reclaim_stat stat;
>  	bool file = is_file_lru(lru);
> -	enum vm_event_item item;
> +	enum node_stat_item item;
>  	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>  	bool stalled = false;
>  
> @@ -2003,10 +2003,8 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
>  
>  	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken);
>  	item = PGSCAN_KSWAPD + reclaimer_offset(sc);
> -	if (!cgroup_reclaim(sc))
> -		__count_vm_events(item, nr_scanned);
> -	count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
> -	__count_vm_events(PGSCAN_ANON + file, nr_scanned);
> +	mod_lruvec_state(lruvec, item, nr_scanned);
> +	mod_lruvec_state(lruvec, PGSCAN_ANON + file, nr_scanned);
>  
>  	spin_unlock_irq(&lruvec->lru_lock);
>  
> @@ -2023,10 +2021,8 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
>  					stat.nr_demoted);
>  	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
>  	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
> -	if (!cgroup_reclaim(sc))
> -		__count_vm_events(item, nr_reclaimed);
> -	count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
> -	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
> +	mod_lruvec_state(lruvec, item, nr_reclaimed);
> +	mod_lruvec_state(lruvec, PGSTEAL_ANON + file, nr_reclaimed);
>  
>  	lru_note_cost_unlock_irq(lruvec, file, stat.nr_pageout,
>  					nr_scanned - nr_reclaimed);
> @@ -4536,7 +4532,7 @@ static int scan_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>  {
>  	int i;
>  	int gen;
> -	enum vm_event_item item;
> +	enum node_stat_item item;
>  	int sorted = 0;
>  	int scanned = 0;
>  	int isolated = 0;
> @@ -4595,13 +4591,11 @@ static int scan_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>  	}
>  
>  	item = PGSCAN_KSWAPD + reclaimer_offset(sc);
> -	if (!cgroup_reclaim(sc)) {
> -		__count_vm_events(item, isolated);
> +	if (!cgroup_reclaim(sc))
>  		__count_vm_events(PGREFILL, sorted);
> -	}
> -	count_memcg_events(memcg, item, isolated);
> +	mod_lruvec_state(lruvec, item, isolated);
>  	count_memcg_events(memcg, PGREFILL, sorted);
> -	__count_vm_events(PGSCAN_ANON + type, isolated);
> +	mod_lruvec_state(lruvec, PGSCAN_ANON + type, isolated);
>  	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, scan_batch,
>  				scanned, skipped, isolated,
>  				type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
> @@ -4686,7 +4680,7 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>  	LIST_HEAD(clean);
>  	struct folio *folio;
>  	struct folio *next;
> -	enum vm_event_item item;
> +	enum node_stat_item item;
>  	struct reclaim_stat stat;
>  	struct lru_gen_mm_walk *walk;
>  	bool skip_retry = false;
> @@ -4750,10 +4744,8 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>  					stat.nr_demoted);
>  
>  	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
> -	if (!cgroup_reclaim(sc))
> -		__count_vm_events(item, reclaimed);
> -	count_memcg_events(memcg, item, reclaimed);
> -	__count_vm_events(PGSTEAL_ANON + type, reclaimed);
> +	mod_lruvec_state(lruvec, item, reclaimed);
> +	mod_lruvec_state(lruvec, PGSTEAL_ANON + type, reclaimed);
>  
>  	spin_unlock_irq(&lruvec->lru_lock);
>  
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 74e0ddde1e93..e4b259989d58 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1291,6 +1291,18 @@ const char * const vmstat_text[] = {
>  	[I(PGDEMOTE_DIRECT)]			= "pgdemote_direct",
>  	[I(PGDEMOTE_KHUGEPAGED)]		= "pgdemote_khugepaged",
>  	[I(PGDEMOTE_PROACTIVE)]			= "pgdemote_proactive",
> +	[I(PGSTEAL_KSWAPD)]			= "pgsteal_kswapd",
> +	[I(PGSTEAL_DIRECT)]			= "pgsteal_direct",
> +	[I(PGSTEAL_KHUGEPAGED)]			= "pgsteal_khugepaged",
> +	[I(PGSTEAL_PROACTIVE)]			= "pgsteal_proactive",
> +	[I(PGSTEAL_ANON)]			= "pgsteal_anon",
> +	[I(PGSTEAL_FILE)]			= "pgsteal_file",
> +	[I(PGSCAN_KSWAPD)]			= "pgscan_kswapd",
> +	[I(PGSCAN_DIRECT)]			= "pgscan_direct",
> +	[I(PGSCAN_KHUGEPAGED)]			= "pgscan_khugepaged",
> +	[I(PGSCAN_PROACTIVE)]			= "pgscan_proactive",
> +	[I(PGSCAN_ANON)]			= "pgscan_anon",
> +	[I(PGSCAN_FILE)]			= "pgscan_file",
>  #ifdef CONFIG_NUMA
>  	[I(PGALLOC_MPOL_DEFAULT)]		= "pgalloc_mpol_default",
>  	[I(PGALLOC_MPOL_PREFERRED)]		= "pgalloc_mpol_preferred",
> @@ -1344,19 +1356,7 @@ const char * const vmstat_text[] = {
>  
>  	[I(PGREFILL)]				= "pgrefill",
>  	[I(PGREUSE)]				= "pgreuse",
> -	[I(PGSTEAL_KSWAPD)]			= "pgsteal_kswapd",
> -	[I(PGSTEAL_DIRECT)]			= "pgsteal_direct",
> -	[I(PGSTEAL_KHUGEPAGED)]			= "pgsteal_khugepaged",
> -	[I(PGSTEAL_PROACTIVE)]			= "pgsteal_proactive",
> -	[I(PGSCAN_KSWAPD)]			= "pgscan_kswapd",
> -	[I(PGSCAN_DIRECT)]			= "pgscan_direct",
> -	[I(PGSCAN_KHUGEPAGED)]			= "pgscan_khugepaged",
> -	[I(PGSCAN_PROACTIVE)]			= "pgscan_proactive",
>  	[I(PGSCAN_DIRECT_THROTTLE)]		= "pgscan_direct_throttle",
> -	[I(PGSCAN_ANON)]			= "pgscan_anon",
> -	[I(PGSCAN_FILE)]			= "pgscan_file",
> -	[I(PGSTEAL_ANON)]			= "pgsteal_anon",
> -	[I(PGSTEAL_FILE)]			= "pgsteal_file",
>  
>  #ifdef CONFIG_NUMA
>  	[I(PGSCAN_ZONE_RECLAIM_SUCCESS)]	= "zone_reclaim_success",
> -- 
> 2.47.3

