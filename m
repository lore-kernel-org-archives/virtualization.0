Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324FBC04FE0
	for <virtualization@archiver.kernel.org>; Mon,  7 Aug 2023 23:28:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93523410BE;
	Mon,  7 Aug 2023 23:28:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 93523410BE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fromorbit-com.20221208.gappssmtp.com header.i=@fromorbit-com.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=adlg0mZ+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B057feSWALrq; Mon,  7 Aug 2023 23:28:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 77EF340965;
	Mon,  7 Aug 2023 23:28:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77EF340965
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48384C0072;
	Mon,  7 Aug 2023 23:28:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2F14C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Aug 2023 23:28:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BDC9A60EE0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Aug 2023 23:28:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BDC9A60EE0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=fromorbit-com.20221208.gappssmtp.com
 header.i=@fromorbit-com.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=adlg0mZ+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bpDgMF_frv8m
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Aug 2023 23:28:49 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F56060E5D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Aug 2023 23:28:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F56060E5D
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-686e0213c0bso3592050b3a.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Aug 2023 16:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1691450928; x=1692055728;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0xqamAux0UTVG6klbJHwJNM84FqVsjBhqmY+h06Y7S4=;
 b=adlg0mZ+HbNffKaKec2p7cVEI4EUlpFfVSVpmG5fvHzHnQEOdBYZjEy4QnkJtTu7lu
 YmN6EGaH1vJkJ2ZOmqiBcV/yaN6Y4JVna47CjKD7nPXpOiMzYNw9UySGma80pWoaj7Dk
 jUxXtUXqouB4bUXn3WeUBdMeMQNzv8NtKVfvER+m7KEKe99ZrQWUTG4Y9TUCDw4Kbcew
 TFF8/aAopaaIk2YO3rVVNpTSZmvFLss5lfJ8bn13k+LTkCPg51SMuEfV97r2Zvr+7s3C
 AcdJXj3qJcnQFWBnyvELMIWQLaBKzEk7yCwrvdFLv4Z0y5aFUIdjan9j2uUGZT7xZ3GX
 Ib8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691450928; x=1692055728;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0xqamAux0UTVG6klbJHwJNM84FqVsjBhqmY+h06Y7S4=;
 b=LXJfJ0OGPLmwTa2zOkTyqLyws6tuuTFAAhmpsK3Yn34ta9NSz66zCRlNk5DboZXnSg
 tHgWmkpWK1Tj3uYoGp45wfu+c76MkOB7pdXZdR1hsj5zQH79RfRFrEHmqkZ0eDoViKGZ
 0T+cvPo20tYd4KmH8b90PiZYqlpEpe0TG5Sl1+Hzqw3pgemONfUDDGft8lYNC9aUNdxF
 FEVGmNTCNfjNoFSpwd/R2qJUuw2fKm5jswTrJQfBkHwhhNuns4g0pScy/deGCddx9zEP
 eQOlbgKFNAK0zwqMH1q/s1Op6STkSg5G10/mkKSEwQqoNEZxk+7WtULwDEe6sbGBxysp
 6FmA==
X-Gm-Message-State: AOJu0YwWtx/KvfpCevhxbB4xnIfVMwWPaeMssRrvbbiYYC5sn7eBRhV8
 bgXOB09f/pO2hPJ4yRt1hQOdNg==
X-Google-Smtp-Source: AGHT+IHWcHOenJQfOaWa9c7YDyMdy3l3j1H0rEzsEcwqog5HJ9HhPve3KCBNDXb4QQT+YEAg/cljWw==
X-Received: by 2002:a05:6a20:8e04:b0:13c:8e50:34b8 with SMTP id
 y4-20020a056a208e0400b0013c8e5034b8mr12892217pzj.35.1691450928413; 
 Mon, 07 Aug 2023 16:28:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-166-213.pa.nsw.optusnet.com.au.
 [49.180.166.213]) by smtp.gmail.com with ESMTPSA id
 e18-20020aa78c52000000b0068620bee456sm6663729pfd.209.2023.08.07.16.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 16:28:47 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
 (envelope-from <david@fromorbit.com>) id 1qT9eW-002TeM-1d;
 Tue, 08 Aug 2023 09:28:44 +1000
Date: Tue, 8 Aug 2023 09:28:44 +1000
To: Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v4 45/48] mm: shrinker: make global slab shrink lockless
Message-ID: <ZNF+LLUpKWHDEG1u@dread.disaster.area>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
 <20230807110936.21819-46-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230807110936.21819-46-zhengqi.arch@bytedance.com>
Cc: kvm@vger.kernel.org, djwong@kernel.org, roman.gushchin@linux.dev,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org,
 cel@kernel.org, x86@kernel.org, steven.price@arm.com, cluster-devel@redhat.com,
 simon.horman@corigine.com, xen-devel@lists.xenproject.org,
 linux-ext4@vger.kernel.org, paulmck@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-nfs@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org,
 dlemoal@kernel.org, yujie.liu@intel.com, vbabka@suse.cz,
 linux-raid@vger.kernel.org, brauner@kernel.org, tytso@mit.edu,
 gregkh@linuxfoundation.org, muchun.song@linux.dev,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org, netdev@vger.kernel.org,
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

On Mon, Aug 07, 2023 at 07:09:33PM +0800, Qi Zheng wrote:
> The shrinker_rwsem is a global read-write lock in shrinkers subsystem,
> which protects most operations such as slab shrink, registration and
> unregistration of shrinkers, etc. This can easily cause problems in the
> following cases.
....
> This commit uses the refcount+RCU method [5] proposed by Dave Chinner
> to re-implement the lockless global slab shrink. The memcg slab shrink is
> handled in the subsequent patch.
....
> ---
>  include/linux/shrinker.h | 17 ++++++++++
>  mm/shrinker.c            | 70 +++++++++++++++++++++++++++++-----------
>  2 files changed, 68 insertions(+), 19 deletions(-)

There's no documentation in the code explaining how the lockless
shrinker algorithm works. It's left to the reader to work out how
this all goes together....

> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index eb342994675a..f06225f18531 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -4,6 +4,8 @@
>  
>  #include <linux/atomic.h>
>  #include <linux/types.h>
> +#include <linux/refcount.h>
> +#include <linux/completion.h>
>  
>  #define SHRINKER_UNIT_BITS	BITS_PER_LONG
>  
> @@ -87,6 +89,10 @@ struct shrinker {
>  	int seeks;	/* seeks to recreate an obj */
>  	unsigned flags;
>  
> +	refcount_t refcount;
> +	struct completion done;
> +	struct rcu_head rcu;

What does the refcount protect, why do we need the completion, etc?

> +
>  	void *private_data;
>  
>  	/* These are for internal use */
> @@ -120,6 +126,17 @@ struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
>  void shrinker_register(struct shrinker *shrinker);
>  void shrinker_free(struct shrinker *shrinker);
>  
> +static inline bool shrinker_try_get(struct shrinker *shrinker)
> +{
> +	return refcount_inc_not_zero(&shrinker->refcount);
> +}
> +
> +static inline void shrinker_put(struct shrinker *shrinker)
> +{
> +	if (refcount_dec_and_test(&shrinker->refcount))
> +		complete(&shrinker->done);
> +}
> +
>  #ifdef CONFIG_SHRINKER_DEBUG
>  extern int __printf(2, 3) shrinker_debugfs_rename(struct shrinker *shrinker,
>  						  const char *fmt, ...);
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index 1911c06b8af5..d318f5621862 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -2,6 +2,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/rwsem.h>
>  #include <linux/shrinker.h>
> +#include <linux/rculist.h>
>  #include <trace/events/vmscan.h>
>  
>  #include "internal.h"
> @@ -577,33 +578,42 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
>  	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
>  		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>  
> -	if (!down_read_trylock(&shrinker_rwsem))
> -		goto out;
> -
> -	list_for_each_entry(shrinker, &shrinker_list, list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(shrinker, &shrinker_list, list) {
>  		struct shrink_control sc = {
>  			.gfp_mask = gfp_mask,
>  			.nid = nid,
>  			.memcg = memcg,
>  		};
>  
> +		if (!shrinker_try_get(shrinker))
> +			continue;
> +
> +		/*
> +		 * We can safely unlock the RCU lock here since we already
> +		 * hold the refcount of the shrinker.
> +		 */
> +		rcu_read_unlock();
> +
>  		ret = do_shrink_slab(&sc, shrinker, priority);
>  		if (ret == SHRINK_EMPTY)
>  			ret = 0;
>  		freed += ret;
> +
>  		/*
> -		 * Bail out if someone want to register a new shrinker to
> -		 * prevent the registration from being stalled for long periods
> -		 * by parallel ongoing shrinking.
> +		 * This shrinker may be deleted from shrinker_list and freed
> +		 * after the shrinker_put() below, but this shrinker is still
> +		 * used for the next traversal. So it is necessary to hold the
> +		 * RCU lock first to prevent this shrinker from being freed,
> +		 * which also ensures that the next shrinker that is traversed
> +		 * will not be freed (even if it is deleted from shrinker_list
> +		 * at the same time).
>  		 */

This comment really should be at the head of the function,
describing the algorithm used within the function itself. i.e. how
reference counts are used w.r.t. the rcu_read_lock() usage to
guarantee existence of the shrinker and the validity of the list
walk.

I'm not going to remember all these little details when I look at
this code in another 6 months time, and having to work it out from
first principles every time I look at the code will waste of a lot
of time...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
