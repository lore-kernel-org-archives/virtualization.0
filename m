Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821452EF67A
	for <virtualization@lists.linux.dev>; Mon, 16 Feb 2026 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771230367; cv=none; b=iDYz3YNTxmuTNIE39BWfCR2mfFSuYOJTMAmh3WEIr/C0E3uK0jg/wqaNZRgwSMrPAyeT0F/hhWm5cpJMb2i/V47zNtAYeYqpGqDCrZnpWkpE8XNUMT2L1wUiENnzFPQMOhJJ4DOLibyYI4Y7ZJPIvCZ/ysNbintaFkQ044knvec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771230367; c=relaxed/simple;
	bh=lVYcW124xXUpGqImemRfOTuqz9/8KIKwr6TZK67q7ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwfR/1W7dPPVRzAQR6ml9XMVtNtPdO7VnjcGb3AsNB9+1zc2NZdAJy3CbifR++ZqliFvS459xEUl2ZgfY/GuxTm1Ck7pVBzkcHDrB2jxp+JBHW33jAnZoziBkQdYLhpdMfWlcID1aB9gLVKfMtQGX+soNtLqWFjyDvG/Of4l/Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wuc8B7YT; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wuc8B7YT"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48375f1defeso21247345e9.0
        for <virtualization@lists.linux.dev>; Mon, 16 Feb 2026 00:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771230365; x=1771835165; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xb3Y5mpUx/KX/i4KodCYFSkUEnbxPYW1NpgmoLibx/U=;
        b=Wuc8B7YTrFdp6zRFRKrJFv8ncQgbmEtwFtuphNovJRA38smlO73mds0QYTrGUOFO6B
         cq/BJnMIxdKTm5vnkNegfwQsCiXurBavxFUf7LWn/inpGY1VdEBQDKAoT/gz+5CMNrkq
         RQC87w1i85nK/pwQNWT9Dv7D+b1Wdirg9H6MdE9hHM8aOOqRan5XhojIMYwpXhX13EjT
         Qi+mLmwyJnjz8lYNQLjHSeKpunTjXFAI4uNF9kcHZxaUTSeP9di8wjNeVOWaqnETBm1S
         ogb3XNNJ5xBBq8LsEQGKoMQCM0R9DEX5+cFcDYm60Gr+W26uwNFpsPSBs6/MpdAPde6U
         085g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771230365; x=1771835165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xb3Y5mpUx/KX/i4KodCYFSkUEnbxPYW1NpgmoLibx/U=;
        b=jKXGcFQAwGmJrre8nAxW/8ccwVnW44aLEagoxmH8JlVc3ugnJOYVdzTU4VJ06wDtro
         d5uydMGqw99okfczVZn6WDrLVocjpfsrgysynjS7hpLOElwi6en70PJwxzfSUvx3gD7e
         TnsHPU/rm5ifKgPEMSRWZKJOr839a06SQq0OtDgmA1xCwtMCce4/YSoRrN60AeI0dHNK
         594mCWfH/3533grL92fLKA8nWUbnnJBxcXYEvAPbYwHp3aPeQfW0p99uxs6ipRHk9hk2
         dexlJHP3FO2TfN5+7VmWfPOfW3LJRJx54+17qrewIe97naLSyJuSRDvD0uycZPL0vnUt
         Feeg==
X-Forwarded-Encrypted: i=1; AJvYcCVMv0qkAZyiZSjhTjzH2tFzA4S36DkabTTf4BkKwryCxPyThJplxENioLtXdKE3mMH0ioimsX8wjioxmmqD7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYEGNd3P544xcQCnHESCWd4v5pW3I/05jp0FnW1bC+3KmQ4pin
	seBAlDuL+Na8sZDHJh5fjvYjaGD5fpSDEi4SmzoGL68YYpkP+mdb5c23iSpFTo1g9R0=
X-Gm-Gg: AZuq6aI3+eSBBl2AJx/Z5Zn6IrHGfMTUKewVD844G3gQifoXQ+0qKPtLQXswAhazxhl
	A8A1XyG2iFzeBOWADpg2thzc2QauJz8VDyiGMJTpcSO9rhn3ESIjYR2F/oVkch5tqzWy562eWcK
	tq45jYZrgGvFrKYGwgIRooereIuFRf4mNdxwPTrBKPFeSIeu2tY3sfyYx0qtEWg17AudzdVu9ye
	z9uWniQV15SmbIBnhI/duMiYzfiqcJZVKs8amqri1D8DE9s4oWmmwawmNt9O/iXP04qUnOyKxhf
	jVViVvPU2pnWY9FSA6s/oZFbdqPSI3cJeVBMXWRHPXY5y6nphphoVHar7VeLc2fxjZMiIN0lnab
	k4t5YPhMATSAs5XqbIk5dsxd6G72HuDg/qYTfCee1J7oiI0DGSRqu4O81umRBVcmCzdSZlTjQQE
	CGPmzubB/Xigae3QuwYgqVfzdsfUANImKAn6tz
X-Received: by 2002:a05:600c:c170:b0:480:4a90:1afe with SMTP id 5b1f17b1804b1-48373a78d47mr149302415e9.34.1771230364694;
        Mon, 16 Feb 2026 00:26:04 -0800 (PST)
Received: from localhost (109-81-87-131.rct.o2.cz. [109.81.87.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a337dfsm81435315e9.19.2026.02.16.00.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 00:26:04 -0800 (PST)
Date: Mon, 16 Feb 2026 09:26:03 +0100
From: Michal Hocko <mhocko@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: linux-mm@kvack.org, apopple@nvidia.com, akpm@linux-foundation.org,
	axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
	david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
	jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
	rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
	rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	surenb@google.com, virtualization@lists.linux.dev, vbabka@suse.cz,
	weixugc@google.com, xuanzhuo@linux.alibaba.com,
	ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
	kernel-team@meta.com
Subject: Re: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
Message-ID: <aZLUm95Y-dKkdBWI@tiehlicka>
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com>
 <aY2BcIHIARSwwQpo@tiehlicka>
 <eca7a8f9-173d-4cb0-93b3-df082b8d0c08@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eca7a8f9-173d-4cb0-93b3-df082b8d0c08@gmail.com>

On Thu 12-02-26 13:22:56, JP Kobryn wrote:
> On 2/11/26 11:29 PM, Michal Hocko wrote:
> > On Wed 11-02-26 20:51:08, JP Kobryn wrote:
> > > It would be useful to see a breakdown of allocations to understand which
> > > NUMA policies are driving them. For example, when investigating memory
> > > pressure, having policy-specific counts could show that allocations were
> > > bound to the affected node (via MPOL_BIND).
> > > 
> > > Add per-policy page allocation counters as new node stat items. These
> > > counters can provide correlation between a mempolicy and pressure on a
> > > given node.
> > 
> > Could you be more specific how exactly do you plan to use those
> > counters?
> 
> Yes. Patch 2 allows us to find which nodes are undergoing reclaim. Once
> we identify the affected node(s), the new mpol counters (this patch)
> allow us correlate the pressure to the mempolicy driving it.

I would appreciate somehow more specificity. You are adding counters
that are not really easy to drop once they are in. Sure we have
precedence of dropping some counters in the past so this is not as hard
as usual userspace APIs but still...

How exactly do you tolerate mempolicy allocations to specific nodes?
While MPOL_MBIND is quite straightforward others are less so.
-- 
Michal Hocko
SUSE Labs
