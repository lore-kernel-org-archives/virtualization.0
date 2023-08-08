Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AB5C04A6A
	for <virtualization@archiver.kernel.org>; Tue,  8 Aug 2023 02:12:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34E1460BD9;
	Tue,  8 Aug 2023 02:12:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 34E1460BD9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fromorbit-com.20221208.gappssmtp.com header.i=@fromorbit-com.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=AFt/Vuaz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AwU5C-_pNBjS; Tue,  8 Aug 2023 02:12:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 481C060AE6;
	Tue,  8 Aug 2023 02:12:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 481C060AE6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 142EBC0071;
	Tue,  8 Aug 2023 02:12:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94C29C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 02:12:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67555404C1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 02:12:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 67555404C1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=fromorbit-com.20221208.gappssmtp.com
 header.i=@fromorbit-com.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=AFt/Vuaz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OmsdosIxfbTY
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 02:12:07 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E84C040350
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 02:12:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E84C040350
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-26814e27a9eso2649714a91.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Aug 2023 19:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1691460726; x=1692065526;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S5nJ90Y7HkcDKRE+pcPu5keZJ+24iVkBC6PdC2b5uJ0=;
 b=AFt/VuazRx0w4Tn1IU2JUHjsvK9//KmKNKOzUsMjyPWc+WauQSv5qCgAlx5y8wlPIL
 hZ4kYEryWxLgRLeYaQj4xKQmbz2+fwGFdpiEnUYFWB8cS1WKDsqaNRvUwjpvdhEE1wqM
 Pa0gWwQ1zRdGeKwMXonsis/5aIvId3dvX65TjmeUK6fHIDfWZQ6NWrHdG0BFjSgBlwHn
 EPCT/fdxzOXvB1URY1V13teKkeQnNqcDN6h4mKjIkvEjRefZqSa/0jDLGkSWo+riYILJ
 5YWVtmGXaJL6ouBig0rvs/QbDa4KngUZ9XItmSUyw062F/G/EjTZcECBZuQiNzd7pFh2
 XSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691460726; x=1692065526;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5nJ90Y7HkcDKRE+pcPu5keZJ+24iVkBC6PdC2b5uJ0=;
 b=LQxRxfhBXKQ4r4fUPcqTmlzFUfeqJHeheI4a1kI3TXrql14s/6Oi3Z6u3Se+1qg8zW
 K8ju6tL7hJufZyMEdRlOCc//y0JMh6fesUeDyK6G1b1Px2zou/g7uXdtOm4YAYN1YEjs
 5vtrTjNSlflsjVH7rCrihKPLu7LEiVDc/fGcR1hkuZqOfr+X7cdok6+0FIwqUVtMBUkW
 94sQZ8xSdKB5P/iizcimsG+B3Ejrio0SACZn1nYjEhmdSRBSnFNzXqvgcaQAflMxQDRT
 v/zBwRNYVM0TEDPuAk4Tq8W4r4KwDaclIrcR5bsHVOSdH0No6tAjn6M+wpoeTl1+1tSA
 8DDw==
X-Gm-Message-State: AOJu0Yznoy0Jf7QkkA1J+MRd3Fw6nubhEMNDLjSqYsPxlBvWWPmUucqm
 ASjt8FzV8FJmr4Y3Cd8RObWJPA==
X-Google-Smtp-Source: AGHT+IHE8FO8RAjHks3Izbxy+yXIAOFeIsxej7SyncoSZwq8TiDh2J09MxtXtA2ffdHhYGJ2WNjVaA==
X-Received: by 2002:a17:90a:ad90:b0:25e:d013:c22c with SMTP id
 s16-20020a17090aad9000b0025ed013c22cmr8256877pjq.47.1691460726140; 
 Mon, 07 Aug 2023 19:12:06 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-166-213.pa.nsw.optusnet.com.au.
 [49.180.166.213]) by smtp.gmail.com with ESMTPSA id
 jv14-20020a17090b31ce00b00263e4dc33aasm9313956pjb.11.2023.08.07.19.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 19:12:05 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
 (envelope-from <david@fromorbit.com>) id 1qTCCY-002WbH-25;
 Tue, 08 Aug 2023 12:12:02 +1000
Date: Tue, 8 Aug 2023 12:12:02 +1000
To: Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v4 44/48] mm: shrinker: add a secondary array for
 shrinker_info::{map, nr_deferred}
Message-ID: <ZNGkcp3Dh8hOiFpk@dread.disaster.area>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
 <20230807110936.21819-45-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230807110936.21819-45-zhengqi.arch@bytedance.com>
Cc: kvm@vger.kernel.org, djwong@kernel.org, roman.gushchin@linux.dev,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org,
 cel@kernel.org, x86@kernel.org, steven.price@arm.com, cluster-devel@redhat.com,
 simon.horman@corigine.com, xen-devel@lists.xenproject.org,
 linux-ext4@vger.kernel.org, paulmck@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-nfs@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org,
 dlemoal@kernel.org, Muchun Song <songmuchun@bytedance.com>,
 yujie.liu@intel.com, vbabka@suse.cz, linux-raid@vger.kernel.org,
 brauner@kernel.org, tytso@mit.edu, gregkh@linuxfoundation.org,
 muchun.song@linux.dev, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, tkhai@ya.ru
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Dave Chinner via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Aug 07, 2023 at 07:09:32PM +0800, Qi Zheng wrote:
> Currently, we maintain two linear arrays per node per memcg, which are
> shrinker_info::map and shrinker_info::nr_deferred. And we need to resize
> them when the shrinker_nr_max is exceeded, that is, allocate a new array,
> and then copy the old array to the new array, and finally free the old
> array by RCU.
> 
> For shrinker_info::map, we do set_bit() under the RCU lock, so we may set
> the value into the old map which is about to be freed. This may cause the
> value set to be lost. The current solution is not to copy the old map when
> resizing, but to set all the corresponding bits in the new map to 1. This
> solves the data loss problem, but bring the overhead of more pointless
> loops while doing memcg slab shrink.
> 
> For shrinker_info::nr_deferred, we will only modify it under the read lock
> of shrinker_rwsem, so it will not run concurrently with the resizing. But
> after we make memcg slab shrink lockless, there will be the same data loss
> problem as shrinker_info::map, and we can't work around it like the map.
> 
> For such resizable arrays, the most straightforward idea is to change it
> to xarray, like we did for list_lru [1]. We need to do xa_store() in the
> list_lru_add()-->set_shrinker_bit(), but this will cause memory
> allocation, and the list_lru_add() doesn't accept failure. A possible
> solution is to pre-allocate, but the location of pre-allocation is not
> well determined.

So you implemented a two level array that preallocates leaf
nodes to work around it? It's remarkable complex for what it does,
I can't help but think a radix tree using a special holder for
nr_deferred values of zero would end up being simpler...

> Therefore, this commit chooses to introduce a secondary array for
> shrinker_info::{map, nr_deferred}, so that we only need to copy this
> secondary array every time the size is resized. Then even if we get the
> old secondary array under the RCU lock, the found map and nr_deferred are
> also true, so no data is lost.

I don't understand what you are trying to describe here. If we get
the old array, then don't we get either a stale nr_deferred value,
or the update we do gets lost because the next shrinker lookup will
find the new array and os the deferred value stored to the old one
is never seen again?

> 
> [1]. https://lore.kernel.org/all/20220228122126.37293-13-songmuchun@bytedance.com/
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
.....
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index a27779ed3798..1911c06b8af5 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -12,15 +12,50 @@ DECLARE_RWSEM(shrinker_rwsem);
>  #ifdef CONFIG_MEMCG
>  static int shrinker_nr_max;
>  
> -/* The shrinker_info is expanded in a batch of BITS_PER_LONG */
> -static inline int shrinker_map_size(int nr_items)
> +static inline int shrinker_unit_size(int nr_items)
>  {
> -	return (DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long));
> +	return (DIV_ROUND_UP(nr_items, SHRINKER_UNIT_BITS) * sizeof(struct shrinker_info_unit *));
>  }
>  
> -static inline int shrinker_defer_size(int nr_items)
> +static inline void shrinker_unit_free(struct shrinker_info *info, int start)
>  {
> -	return (round_up(nr_items, BITS_PER_LONG) * sizeof(atomic_long_t));
> +	struct shrinker_info_unit **unit;
> +	int nr, i;
> +
> +	if (!info)
> +		return;
> +
> +	unit = info->unit;
> +	nr = DIV_ROUND_UP(info->map_nr_max, SHRINKER_UNIT_BITS);
> +
> +	for (i = start; i < nr; i++) {
> +		if (!unit[i])
> +			break;
> +
> +		kvfree(unit[i]);
> +		unit[i] = NULL;
> +	}
> +}
> +
> +static inline int shrinker_unit_alloc(struct shrinker_info *new,
> +				       struct shrinker_info *old, int nid)
> +{
> +	struct shrinker_info_unit *unit;
> +	int nr = DIV_ROUND_UP(new->map_nr_max, SHRINKER_UNIT_BITS);
> +	int start = old ? DIV_ROUND_UP(old->map_nr_max, SHRINKER_UNIT_BITS) : 0;
> +	int i;
> +
> +	for (i = start; i < nr; i++) {
> +		unit = kvzalloc_node(sizeof(*unit), GFP_KERNEL, nid);

A unit is 576 bytes. Why is this using kvzalloc_node()?

> +		if (!unit) {
> +			shrinker_unit_free(new, start);
> +			return -ENOMEM;
> +		}
> +
> +		new->unit[i] = unit;
> +	}
> +
> +	return 0;
>  }
>  
>  void free_shrinker_info(struct mem_cgroup *memcg)
> @@ -32,6 +67,7 @@ void free_shrinker_info(struct mem_cgroup *memcg)
>  	for_each_node(nid) {
>  		pn = memcg->nodeinfo[nid];
>  		info = rcu_dereference_protected(pn->shrinker_info, true);
> +		shrinker_unit_free(info, 0);
>  		kvfree(info);
>  		rcu_assign_pointer(pn->shrinker_info, NULL);
>  	}

Why is this safe? The info and maps are looked up by RCU, so why is
freeing them without a RCU grace period expiring safe?

Yes, it was safe to do this when it was all under a semaphore, but
now the lookup and use is under RCU, so this freeing isn't
serialised against lookups anymore...


> @@ -40,28 +76,27 @@ void free_shrinker_info(struct mem_cgroup *memcg)
>  int alloc_shrinker_info(struct mem_cgroup *memcg)
>  {
>  	struct shrinker_info *info;
> -	int nid, size, ret = 0;
> -	int map_size, defer_size = 0;
> +	int nid, ret = 0;
> +	int array_size = 0;
>  
>  	down_write(&shrinker_rwsem);
> -	map_size = shrinker_map_size(shrinker_nr_max);
> -	defer_size = shrinker_defer_size(shrinker_nr_max);
> -	size = map_size + defer_size;
> +	array_size = shrinker_unit_size(shrinker_nr_max);
>  	for_each_node(nid) {
> -		info = kvzalloc_node(sizeof(*info) + size, GFP_KERNEL, nid);
> -		if (!info) {
> -			free_shrinker_info(memcg);
> -			ret = -ENOMEM;
> -			break;
> -		}
> -		info->nr_deferred = (atomic_long_t *)(info + 1);
> -		info->map = (void *)info->nr_deferred + defer_size;
> +		info = kvzalloc_node(sizeof(*info) + array_size, GFP_KERNEL, nid);
> +		if (!info)
> +			goto err;
>  		info->map_nr_max = shrinker_nr_max;
> +		if (shrinker_unit_alloc(info, NULL, nid))
> +			goto err;

That's going to now do a lot of small memory allocation when we have
lots of shrinkers active....

> @@ -150,17 +175,34 @@ static int expand_shrinker_info(int new_id)
>  	return ret;
>  }
>  
> +static inline int shriner_id_to_index(int shrinker_id)

shrinker_id_to_index

> +{
> +	return shrinker_id / SHRINKER_UNIT_BITS;
> +}
> +
> +static inline int shriner_id_to_offset(int shrinker_id)

shrinker_id_to_offset

> +{
> +	return shrinker_id % SHRINKER_UNIT_BITS;
> +}

....
> @@ -209,26 +251,31 @@ static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
>  				   struct mem_cgroup *memcg)
>  {
>  	struct shrinker_info *info;
> +	struct shrinker_info_unit *unit;
>  
>  	info = shrinker_info_protected(memcg, nid);
> -	return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
> +	unit = info->unit[shriner_id_to_index(shrinker->id)];
> +	return atomic_long_xchg(&unit->nr_deferred[shriner_id_to_offset(shrinker->id)], 0);
>  }
>  
>  static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
>  				  struct mem_cgroup *memcg)
>  {
>  	struct shrinker_info *info;
> +	struct shrinker_info_unit *unit;
>  
>  	info = shrinker_info_protected(memcg, nid);
> -	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
> +	unit = info->unit[shriner_id_to_index(shrinker->id)];
> +	return atomic_long_add_return(nr, &unit->nr_deferred[shriner_id_to_offset(shrinker->id)]);
>  }
>  
>  void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>  {
> -	int i, nid;
> +	int nid, index, offset;
>  	long nr;
>  	struct mem_cgroup *parent;
>  	struct shrinker_info *child_info, *parent_info;
> +	struct shrinker_info_unit *child_unit, *parent_unit;
>  
>  	parent = parent_mem_cgroup(memcg);
>  	if (!parent)
> @@ -239,9 +286,13 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>  	for_each_node(nid) {
>  		child_info = shrinker_info_protected(memcg, nid);
>  		parent_info = shrinker_info_protected(parent, nid);
> -		for (i = 0; i < child_info->map_nr_max; i++) {
> -			nr = atomic_long_read(&child_info->nr_deferred[i]);
> -			atomic_long_add(nr, &parent_info->nr_deferred[i]);
> +		for (index = 0; index < shriner_id_to_index(child_info->map_nr_max); index++) {
> +			child_unit = child_info->unit[index];
> +			parent_unit = parent_info->unit[index];
> +			for (offset = 0; offset < SHRINKER_UNIT_BITS; offset++) {
> +				nr = atomic_long_read(&child_unit->nr_deferred[offset]);
> +				atomic_long_add(nr, &parent_unit->nr_deferred[offset]);
> +			}
>  		}
>  	}
>  	up_read(&shrinker_rwsem);
> @@ -407,7 +458,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  {
>  	struct shrinker_info *info;
>  	unsigned long ret, freed = 0;
> -	int i;
> +	int offset, index = 0;
>  
>  	if (!mem_cgroup_online(memcg))
>  		return 0;
> @@ -419,56 +470,63 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  	if (unlikely(!info))
>  		goto unlock;
>  
> -	for_each_set_bit(i, info->map, info->map_nr_max) {
> -		struct shrink_control sc = {
> -			.gfp_mask = gfp_mask,
> -			.nid = nid,
> -			.memcg = memcg,
> -		};
> -		struct shrinker *shrinker;
> +	for (; index < shriner_id_to_index(info->map_nr_max); index++) {
> +		struct shrinker_info_unit *unit;

This adds another layer of indent to shrink_slab_memcg(). Please
factor it first so that the code ends up being readable. Doing that
first as a separate patch will also make the actual algorithm
changes in this patch be much more obvious - this huge hunk of
diff is pretty much impossible to review...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
