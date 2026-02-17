Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D148B3EBF12
	for <virtualization@lists.linux.dev>; Tue, 17 Feb 2026 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354374; cv=none; b=KnFuH2xp9YknydzA7Lkm+ngRHhVFuBjaJ6BptItmrWdhTxEXdGMOfGMeGUk9kzcDZYOWNV105uaopb9OS9WARZeGhJFHHHyQpL9IVq7mrg8F/j1qSYATqFBSDluTLBIYQmUdW0KuUddIUwi8r2FPydsI0ovU+oYWpxSEnQ56n1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354374; c=relaxed/simple;
	bh=3ehpeb06kDgzJNWm4laQeCVtUuswr0jIzd35eu4fzxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq+abkmjeHwrjCyJkO2O8mVSsoBb8MiBO/PZtfD2HnpeP7wLxx+ZDDFCYbSTuWxWOXme0htsZL3L48wsCipn310IeQMnISyf1baH79WZFhpJX8pErysvktFLOItsfjwWJYFP9eypLxt/qVXSkMg9AzLgzJdyYtkxrFMyrn+jCVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tx/y6SA+; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tx/y6SA+"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so42657855e9.1
        for <virtualization@lists.linux.dev>; Tue, 17 Feb 2026 10:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771354371; x=1771959171; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x46hiGoEyZZRfdFs36nFSz1+AdsW3p14nQ3Wm2zf6Qc=;
        b=Tx/y6SA+eN74gIvS6hqJsbUEbc9A5qSYDkhIMKIr+uIZyovOR5TmEqswx/9HUdTNR3
         w7IgHsBgu69zJrafQ/41314oZWTUkqfdP/G1qBkw4RP0ufPfJY9SOMb/sEmaTDLMG0NO
         SmFouMwwNsnd2MV4crW/++ySKk5gpudWdGAN28MOT9hXxQE+1An9pK7RqL7wigZ+GTrq
         MiBAXWOb+lZ29uDMpjsSc0EoDmVl+TduW2o7p8RXJlG8038p6/bsgLHBbQ03/08hsqMX
         3qLZW3na7iLpUGEiAWW4KF0+XS3eybAOv/22v4nxa9HMEwT6eqTv3O8fQNUPezGXdAVe
         V6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771354371; x=1771959171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x46hiGoEyZZRfdFs36nFSz1+AdsW3p14nQ3Wm2zf6Qc=;
        b=P5MsdEkjDtT2QbMtHBO8he6JQCuKg49HNQoav1xy8zf2gYUMYsDVMNwt7j/xE1Bax/
         dpNzV+WZTWck/56lViCniDnvyDDJ15EZevSsjXa2pe37OGgJgBUj3+7eISwG5YYSwBLn
         X0KeownOlTP+vjqrtqIw//PzJm0Hdu/Ly/t29Q4DBTulbqz2t5O7w4bogzJj8YLakiWd
         BPcyRrZ3rPAHDd21EVM0dIP3Yuc4zOvQE5F/gE79IpJetkfR+mUkPjBpPd7jJpWVzjpU
         2yjKGatxcI7OgUxv7CksJoJ+uNbVlt1W5EJfwRgL3VIbG/HrX+LQk5vMkAStbt3uiKz5
         rpaw==
X-Forwarded-Encrypted: i=1; AJvYcCVUPBGyD76woFFkim4qjYfX7b2gOO0EU7YJ7O9cTt1cS71HAN1q7ue2ql6L1FOuiTr4Y4jR0AdofmM2c85AhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxLIMCWkr17cIPcbv1JpATEBCpTuEhTbCMsAwlkcTFSjet9oTn
	7eomfMCLgENKBSXzJveah7u3NCOnzZqVJtd5vaUeczo7HzeJhSABWL21o2cjMtDLuuOUP4zT3CG
	UCJZUwas=
X-Gm-Gg: AZuq6aKWCx5ukzjmtUURq7vKOhvoycUnrrVs9nZRM2DwOjBb33br2Hcv3FUdSz+G1MR
	5b+FZOWRwtB8SIJP8yTn6W2DiUz3ZDnQQPCQkwug6uFig6CC23KDLcRPJ1/9gcKno9/LxRVys/3
	7s5CwTbISP24LDZIBwPylAB1rN3Zmd3KQID2WQkVdwTdL4VgE2pkqIcCJablgUzrTPhSUQCO1BW
	LERMI9tQsIFrfKutltJxn+u+HQx0TxC4fdKGmMmj5wgBOdBNb3K+dG5H5tcEZcLfdgHgwIr5L+4
	Pw5AOPEZ4D3CMwPqQ/hpnKaj/8Ggv5V2/4gUn/AdBNZ6BvHkVgsjSLgJkXLxxx1l5SSokX3Wxyb
	xudmB+skxoU5e38SK9Fj+aa11Il7gUk7rs+7SzLYlfIZx4YyWHMLEcbt6JDXVSy7tSJepwmAMMN
	/LxuIwcX9GP5h3DcBLjL0PlDIbPXMdfLJwMoXk
X-Received: by 2002:a05:6000:1acc:b0:437:678b:83c2 with SMTP id ffacd0b85a97d-4379793eddamr28020353f8f.54.1771354371131;
        Tue, 17 Feb 2026 10:52:51 -0800 (PST)
Received: from localhost (109-81-87-131.rct.o2.cz. [109.81.87.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796acf5b9sm34218187f8f.34.2026.02.17.10.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 10:52:50 -0800 (PST)
Date: Tue, 17 Feb 2026 19:52:49 +0100
From: Michal Hocko <mhocko@suse.com>
To: "JP Kobryn (Meta)" <inwardvessel@gmail.com>
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
Message-ID: <aZS5AY5bnPjAmgN1@tiehlicka>
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com>
 <aY2BcIHIARSwwQpo@tiehlicka>
 <eca7a8f9-173d-4cb0-93b3-df082b8d0c08@gmail.com>
 <aZLUm95Y-dKkdBWI@tiehlicka>
 <3fe7c5dd-b184-4421-a21c-bafce6aa7b09@gmail.com>
 <aZOHIQj3pJ-9dW_0@tiehlicka>
 <9ae80317-f005-474c-9da1-95462138f3c6@gmail.com>
 <aZRg_ZSDkbGWv7Vq@tiehlicka>
 <c71f5dc7-d337-4510-96c4-38a83fca29ef@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c71f5dc7-d337-4510-96c4-38a83fca29ef@gmail.com>

On Tue 17-02-26 10:19:08, JP Kobryn (Meta) wrote:
> On 2/17/26 4:37 AM, Michal Hocko wrote:
> > On Mon 16-02-26 23:48:42, JP Kobryn (Meta) wrote:
> > > On 2/16/26 1:07 PM, Michal Hocko wrote:
> > [...]
> > > > [*] btw. I believe you misaccount MPOL_LOCAL because you attribute the
> > > > target node even when the allocation is from a remote node from the
> > > > "local" POV.
> > > 
> > > It's a good point. The accounting as a result of fallback cases
> > > shouldn't detract from an investigation though. We're interested in the
> > > node(s) under pressure so the relatively few fallback allocations would
> > > land on nodes that are not under pressure and could be viewed as
> > > acceptable noise.
> > 
> > This is really confusing. You simply have no means to tell the
> > difference between the requested node and the real node used so you
> > cannot really say whether the memory pressure is because of fallbacks or
> > your mempolicy configurations. That means that you cannot tell the
> > difference between the source of the pressure and victim of that
> > pressure.
> 
> What if I excluded the fallback cases? I could get the actual node from
> the allocated page and compare against the requested node or node mask.

I think it would make sense to send the per-node reclaim stats
separately as there doesn't seem to be any dispute about that.

For mempolicy stats try to define semantic for each mempolicy first.
What exactly do you miss from existing numa_*?
Do you want to count number of requests/successes. Do you want to track
failures? In what kind of granularity (track fallback nodes)?

-- 
Michal Hocko
SUSE Labs
