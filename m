Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A6E277C9E
	for <virtualization@lists.linux.dev>; Mon, 16 Feb 2026 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771276070; cv=none; b=RAtPb814uUr1RRvfaXtQv4bQ5m9hGTbbvVMK1h6Nmvh2di80wGFcIBLi0d8R1xkJVOAlr6tIExfgMg8tWWPRMtsdrUKgtNMMBxio3m+WAfYMypV+FtYR4qViKrAfqySBfXg2BzhKfChnylJ86D3p1/hmgJao9P/Hh334BG06WJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771276070; c=relaxed/simple;
	bh=ahY9nzIrmb3VN2PNtTKd4XYo5vjVSwt3GAvd5/xCOrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXo4k8hGdySiTafCtVPUmOqK8OsalR86jd0StTAVqBT7js6jmpGBNNz4ivSlkb2yrsmiWAd3wWBsx5jfYgPGvCi41iZcFdVaosa4A7aWTeCWq9O8Vu9+Z6vcXDxIalky4GRp7zQcn4MTrZQdPa/IthMzxI3DjNLFAcON6Udmfyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qt336r5y; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qt336r5y"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48375f1defeso27876725e9.0
        for <virtualization@lists.linux.dev>; Mon, 16 Feb 2026 13:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771276067; x=1771880867; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpRBCfCaKwzFeCSlkRPtiCqwRuCq3qQsbgDvpARfGfQ=;
        b=Qt336r5yvFRjpGwvAEXbcGY65R74f9awJJOyz3CzHJkEMcUFWmrQBVQ4EVf9GfPfKn
         y2nmeP9KtxO3RdTWD2g1MN0sb2NSLjiTLRQD/eZMi5hcaj9gJ9e+P/SfywMchyqPDX51
         Z6VTe30gzdRAAIh9Z6IXJd6NSbhhCi396HfSuZlFSs5p81wByTyyuxgobWRD57K4kzg5
         cuYZv/fJPs9L+3O1UywKPLt+62NdorRM3Ee8wJ6Sh2PgyXREdzMac3auRgA3aTEViB8w
         rRxg5UauEPE/tNhuQ6Q8hD4w2Kw2jLBVgB5XAOqsUOtOYI8FliaLUXjQmFbB+KGYwjzJ
         5wUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771276067; x=1771880867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpRBCfCaKwzFeCSlkRPtiCqwRuCq3qQsbgDvpARfGfQ=;
        b=W6lvLLQ6FAaBlmSRrMJ1rwVRwbSiY4dK/sdMWIvavK1tL/hqq+zO8gcYq2vLFcv/st
         r7q4qRe00YtzomKyE9g0Qo1IZYSaFkJVwAqmnq7aQqHDe+r4TGGMKqM8akevGjf/sfMP
         u/OeIZMm59phNIPq+850XBzVe9fQiy2KcaIlLktU6zmhpDTTURTlxEZbcx6wQOttD7zX
         liNCH9Jo2P3F3AxlcpAoCb7VI7agi/hF0F8W/5s7l52CpdT2aDsQ03JdslKkGx7RLyMu
         NXqpyoERRyIvgLg6wwz+brlvyFdtBv1xb+aZGNimGLoj1krCC5ig4JO3d/fYZ1ymsaeF
         DlwA==
X-Forwarded-Encrypted: i=1; AJvYcCVg2+sVu/psEr5lKN9BUBEqiJEFX2QrTBSxP9EOQ1mYbbd3OgmhblBiz6DTnKG8BS7B6+hVqo7UMPgFYYCUNA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAoavAoNmQ25w/Iy5ebfvCK1I1eOLrS3tTSiixJKDju/MNclvI
	VLt3rmyoN+GFruyoh84oZc/fAELyOqqzxIDsgajT1pTRidSVm1x9fe88O5d21YSeP98=
X-Gm-Gg: AZuq6aIC3+gEmufzs6ELT5llQ1/sP3FZHA1HCluGso3R2XZbG91/CHzswefEUWmMnfh
	o39uZl9xRIZs2GzIUNrx82NxL36Atx9F/0yDkppDX13n9LjM3qJG7njFune62Rz7JjNI1kyumwO
	0eWy3pqcrscqS7/HcA3bg6GDy70D3HyBZg+VqeLMifkkDVJpB3HYsPPxdSIw1sSTVYlAvrS3XlY
	g1PUrPLA/0FT/RcMweZfMg5ZDEAB6FVyfHBpH3kCJoP+PdHVlQSNmDpJrrJBRvMHAPERAlxDF+g
	av0bpZpqoO5q+X110Hjr9/EJzndeGnneh2N2yvS+iwQZXFH9OQ2UTa9LFkkIyFGJtJg7NquJSNS
	CmhF2JiHP047yfylNHDnwP9y2u3VIeORvu/waIVTmoJDFztFWV9PQM3iuLKb13JjQhpZ1vqXogO
	78+mZF/14a3sVaNpC82Qbk1wLasj9zbptjAkzk
X-Received: by 2002:a05:600c:19cc:b0:47e:e2ec:995b with SMTP id 5b1f17b1804b1-48373a1271emr193576735e9.9.1771276067044;
        Mon, 16 Feb 2026 13:07:47 -0800 (PST)
Received: from localhost (109-81-87-131.rct.o2.cz. [109.81.87.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d77b3sm519573895e9.2.2026.02.16.13.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 13:07:46 -0800 (PST)
Date: Mon, 16 Feb 2026 22:07:45 +0100
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
Message-ID: <aZOHIQj3pJ-9dW_0@tiehlicka>
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com>
 <aY2BcIHIARSwwQpo@tiehlicka>
 <eca7a8f9-173d-4cb0-93b3-df082b8d0c08@gmail.com>
 <aZLUm95Y-dKkdBWI@tiehlicka>
 <3fe7c5dd-b184-4421-a21c-bafce6aa7b09@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fe7c5dd-b184-4421-a21c-bafce6aa7b09@gmail.com>

On Mon 16-02-26 09:50:26, JP Kobryn (Meta) wrote:
> On 2/16/26 12:26 AM, Michal Hocko wrote:
> > On Thu 12-02-26 13:22:56, JP Kobryn wrote:
> > > On 2/11/26 11:29 PM, Michal Hocko wrote:
> > > > On Wed 11-02-26 20:51:08, JP Kobryn wrote:
> > > > > It would be useful to see a breakdown of allocations to understand which
> > > > > NUMA policies are driving them. For example, when investigating memory
> > > > > pressure, having policy-specific counts could show that allocations were
> > > > > bound to the affected node (via MPOL_BIND).
> > > > > 
> > > > > Add per-policy page allocation counters as new node stat items. These
> > > > > counters can provide correlation between a mempolicy and pressure on a
> > > > > given node.
> > > > 
> > > > Could you be more specific how exactly do you plan to use those
> > > > counters?
> > > 
> > > Yes. Patch 2 allows us to find which nodes are undergoing reclaim. Once
> > > we identify the affected node(s), the new mpol counters (this patch)
> > > allow us correlate the pressure to the mempolicy driving it.
> > 
> > I would appreciate somehow more specificity. You are adding counters
> > that are not really easy to drop once they are in. Sure we have
> > precedence of dropping some counters in the past so this is not as hard
> > as usual userspace APIs but still...
> > 
> > How exactly do you tolerate mempolicy allocations to specific nodes?
> > While MPOL_MBIND is quite straightforward others are less so.
> 
> The design does account for this regardless of the policy. In the call
> to __mod_node_page_state(), I'm using page_pgdat(page) so the stat is
> attributed to the node where the page actually landed.

That much is clear[*]. The consumer side of things is not really clear to
me. How do you know which policy or part of the nodemask of that policy
is the source of the memory pressure on a particular node? In other
words how much is the data actually useful except for a single node
mempolicy (i.e. MBIND).

[*] btw. I believe you misaccount MPOL_LOCAL because you attribute the
target node even when the allocation is from a remote node from the
"local" POV.
-- 
Michal Hocko
SUSE Labs
