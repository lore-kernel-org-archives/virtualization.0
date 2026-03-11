Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDCC3E63A7
	for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252386; cv=none; b=E6ItCNZq8AjTTPrzVA+Dn/26TzyyUYXb2qQVyQ4qWjgA+xoSHo/Sr86lM0V4kRqqk3TRsKXb+WYzt+bmVo+028Kx9iTVCZW7EsAqrmXOq6FGXnjtXt7gBz3OTX4cxA5ZGvWbHOyvaKgxxv80MOOmOhb7wHz1Llfybd3bxS05P5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252386; c=relaxed/simple;
	bh=it9qpp+UfqJRbKkDfvBHAN3iPpbPBunUvUAjiJOtfYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iW6xM/zoNqGgnO48m1hlWoZO1VEaSM8WC5Ve5Gu4l9jFfD1NPvWWZhJ2kl4X4UvIXBA3eEjPBLmjSXpgo4A6kPpinn2bAYW5bsIQrBrIWDpXmMZytD/bj5mK19/Pye7FTeMq+wuc6KdTVkTxgoGxbrEf2my354LWsDMHIgW9No4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=dY0jl7Qi; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="dY0jl7Qi"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cd80f56b27so10902385a.1
        for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 11:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1773252383; x=1773857183; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bczgafP3myIIT3/uXjN5TcydziqRd7nkpIhTtM1x3Qc=;
        b=dY0jl7QiS3i5RJ3o9my8IvNxokJPTHivks9SPd98JXLLJjsfnCQ+Jdxj6d6jWDK+ro
         7Nu9oqc/o588QR6OoLn3FfPrx1QoGIltyl6NBZe99/mVe40abqwLh6MmHfxU+wtunzCG
         mytUEx3F8FdbZtMJDvxs7caBZVJA96Z+Oz8Q2dxwpBYzEZDio7PWbiH9KpmpgH9fPpjo
         tgOFb3H8Fm5CRNnNF/bYtGvvOz/t9UI9yaFLkPu8yIs5zVJNA4YAt3QLuN0s4caY10Qn
         t6QZxDdJEJxJGM74Sbw9RvhUGFbOiV7vX3L6CZHR8W4mz5qh1ylJl3XyCBmS3CcczPM2
         dkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773252383; x=1773857183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bczgafP3myIIT3/uXjN5TcydziqRd7nkpIhTtM1x3Qc=;
        b=X0iKFcz2ZoP7rJQeR1T68yu5zlftVe5JKK3lJjJtZpYRvBTjwY7v914ppdIBRjFDN5
         NRjjXRXYo92dbHLElqhwUyMF9ZynEyihd6rilw+QfXuyJR5LkcLRrlW72JmA4N4NuImu
         k+k5xkr4cHQJZPPqdN4gkqdHROxGifTVKkJ9Qo4H6/Pta7GdK061uDyDt2j+xGsKILbx
         1BcNP10AYotbJRYjlADFPnS68kGNy95kynnKuhRFh+9fjVU8pXQyDrPyysKiL/9bBVZG
         sVAq4lIA7coMp8FjLQX2AxlY8imoBvXHdpUOEPsngFuR3EnlRgA7zkgNFCPqflhreVU5
         MeiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr+NLdaD00hM8s+HR3ryhISm553+7+jWrV073+6uFq63jhTRmsCI6HvvGWrf8Kd8jCUBtwi7R4a5qc30H8Fw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYJWS9vciImMzM5Lpj0b+mCxpcwUZgVjyerz8ztdXff5qkzGM/
	1cSIRYrFCcr9jEN9/nqYvUFfmAySSpRdHePu5JWCDowmv1hekfctyS8wU5fZ9e3jQco=
X-Gm-Gg: ATEYQzx22P5zQgT8t8G5vr9FIVRojsD/qtGYUR3Y9/Zv/f6hQRxvaHK65Q7+wwpSKnV
	xaS2Q+9qoIizM5mmceAaCK4AJY5+K7X9K2+xhLouYNc0+E3kGFXcn7XpY1z0LoOTpFDx7/qh7WK
	FQPFbrY4DoNMTwbOZii95SaxYpRocuBW8NFeexvVEQmZd2aOlO7TpoIUIl51bKjECApbkEo1FZo
	WYVQo6qLCiT0b4SxV0fKNbsu0BYmnqr7C98Es4Nu4hWDwUVRwbjPZRHrJxZnwMDOWz/eRfvchDZ
	HN87Zm/gGJsJp6+QdN0ZBiSqHhN1FmefdTaYsUlJxozSNpo4ENBENVO/zRxObT29Q3i4alSnZmD
	i1x/zK0IxpEJSh26Ak5yPbAVt4/w7R5DmkviVzFPrNEXeHpCJZR//d3G3wb+GTXulQaRQffVhp5
	1fl5nOb+pBJcGcXeHTudnykA==
X-Received: by 2002:a05:620a:4053:b0:8c7:1118:c514 with SMTP id af79cd13be357-8cda19b1a5bmr446088985a.17.1773252383193;
        Wed, 11 Mar 2026 11:06:23 -0700 (PDT)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21540f5sm172182185a.45.2026.03.11.11.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 11:06:22 -0700 (PDT)
Date: Wed, 11 Mar 2026 14:06:18 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
Cc: Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
	akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
	apopple@nvidia.com, axelrasmussen@google.com, byungchul@sk.com,
	cgroups@vger.kernel.org, david@kernel.org, eperezma@redhat.com,
	gourry@gourry.net, jasowang@redhat.com, joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
	rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
	rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	surenb@google.com, virtualization@lists.linux.dev,
	weixugc@google.com, xuanzhuo@linux.alibaba.com,
	ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
	kernel-team@meta.com
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
Message-ID: <abGvGjqke_3gYe6I@cmpxchg.org>
References: <20260308192438.1363382-1-usama.arif@linux.dev>
 <c64681a1-2069-421c-9e62-bb63e4ce261a@linux.dev>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c64681a1-2069-421c-9e62-bb63e4ce261a@linux.dev>

On Sun, Mar 08, 2026 at 08:30:47PM -0700, JP Kobryn (Meta) wrote:
> On 3/8/26 12:24 PM, Usama Arif wrote:
> > On Fri,  6 Mar 2026 20:55:20 -0800 "JP Kobryn (Meta)" <jp.kobryn@linux.dev> wrote:
> [...]
> >> +static void mpol_count_numa_alloc(struct mempolicy *pol, int intended_nid,
> >> +				  struct page *page, unsigned int order)
> >> +{
> >> +	int actual_nid = page_to_nid(page);
> >> +	long nr_pages = 1L << order;
> >> +	enum node_stat_item hit_idx;
> >> +	struct mem_cgroup *memcg;
> >> +	struct lruvec *lruvec;
> >> +	bool is_hit;
> >> +
> >> +	if (!root_mem_cgroup || mem_cgroup_disabled())
> >> +		return;
> > 
> > Hello JP!
> > 
> > The stats are exposed via /proc/vmstat and are guarded by CONFIG_NUMA, not
> > CONFIG_MEMCG. Early returning overhere would make it inaccuate. Does
> > it make sense to use mod_node_page_state if memcg is not available,
> > so that these global counters work regardless of cgroup configuration.
> >
> 
> Good call. I can instead do:
> 
> if (!mem_cgroup_disabled() && root_mem_cgroup) {
> 	struct mem_cgroup *memcg;
> 	struct lruvec *lruvec;
> 	/* use lruvec for updating stats */
> } else {
> 	/* use node for updating stats */
> }
> 
> This should also take care of the bot warning on mem_cgroup_from_task()
> not being available.

mem_cgroup_lruvec() and mod_lruvec_state() already do the right thing
for !CONFIG_MEMCG. Add a dummy for mem_cgroup_from_task() and you can
do a single, shared sequence for both configs.
