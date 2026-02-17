Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1438233555D
	for <virtualization@lists.linux.dev>; Tue, 17 Feb 2026 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331842; cv=none; b=BWh4CEizeu8eVaewSJls8kHlSlMi3zykidjiaetRjwwn9gLBAlY7YDy0WRxERwXXuRcIccS26eCsrWNAoYmw0yKrwoFBgcRurM1rcBDgJDTRsGTI52Sw7RBtTJVmRX/Pudi1w5k00K//svmwTQWpjrJ1QZ5JG7aBCQFIDddkFw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331842; c=relaxed/simple;
	bh=0eZcbYVy/RVOWycTRLFEvzMgS8G1c7V8/TBl4IUI77o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXK/bHBUmCY5MvpQfBoWe0I7JzFK8qlhSvO1N+TISAlQV65CxWBpX2/nuPQlJqf/F7PnL5P3a9S9tI/sYLmoOFNCfZ1J4hDzPS+hajTapILJODQgx0LQvRASb+fMJ5A2aSOY8/mxwLzWk86EQCN5Q/tLoTKi+7gJMKAvX50REng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cBgmgFlZ; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cBgmgFlZ"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso35889575e9.3
        for <virtualization@lists.linux.dev>; Tue, 17 Feb 2026 04:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771331839; x=1771936639; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=msDEC8P3Y7O3dfS3sdhcpXjWKe2JYJmxrwEcOrENtGw=;
        b=cBgmgFlZxMU/0lCYMCmh9npst+FYuyB6oTKRfuWItw2sKbp8VpL3OB9CC77sxChRP6
         e7+l/F0kgyN76Mmzoe0bh8s6P9lrApXLOYzjQu+839/Ic9h2c3sLoOaRh55IEu1uHGd5
         +cFWbVDVRvFAthZWot/FO8Oerh/dv9oDJS7jAGOhJgNGN8gE7LTzBkV2ZM//KGQMslfD
         rzzCC7ZeYAQLlNP1BxpS9igdeOaOTL8B9TtYKexHyNhXtxNaKcyDh/tcVYbECRkys5Ir
         QK8PwQ9xucC38BTEuJJZuJKgWlMRQg7x19oI1LvHthJjt1Cpkk8B/NPK8K9GGBPjULqX
         e2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771331839; x=1771936639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msDEC8P3Y7O3dfS3sdhcpXjWKe2JYJmxrwEcOrENtGw=;
        b=mB7OE9Yb3oRNRblpqvAvnsEjTRpaqdI+QjEGYgzcJe8GJ4945XnZXgQWtXXeAqbPYz
         j9RRWaQhVJsV9kKR6SGE9By6K5yDNsjrScigfV9YYrSy+Y2gk1dmsroB5N75X1CVC4Aq
         eCPeUjUxFS2hFLm3fc2XiwpUWv4LkTHOferOB1etn5KTgtDibLiBESgu+/2aG4/Y8Efi
         bfd/orFb+6VTPw5pm3O5W/OgMR5XjPQpw2COD8L9e2g67FqDjzU/4C+ASPDcAub9bXeX
         nJ0qCzq1ErPDMv2QFcCQH1QSvjAyPQlLyUF1RcQc6lhJU4TC5enzBA4EAW53g/eoWs5b
         0ulA==
X-Forwarded-Encrypted: i=1; AJvYcCWWMwy5vyRUWhEJOVhMVqp4vrdEancO//Wet1rW0GES05bzeLyhVC4S9CcjrpErHB6X7bZfIehhN59iczJW6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrQeHUXQhpuah1vGNQCFZ/fPTF6u545yPRPnJ+Gtx6hYMqr7w9
	7lhABM7ofFXmGw9N4TsaEyyOG/+sgZ+daCaTzKtonIZyUWWKNqGcGG6SA45jybRgebU=
X-Gm-Gg: AZuq6aLs7fAczr8Q/mt6LySXiwDp3BstlIcseBH2X3l49nh8zA3J6yzUP7+WkMyu6P9
	eBIUjFkACDr0bKnGP4UgD4ryppH+1Z6rp9vWaPqsLZcYEK+BSafDb+KGh5pD417GPX8V908dIdl
	RiXtqlkx0bz8ooPCzSHKN8um38XYVYHSbZpj0tolAvzLl8FdD6V8OQUWFX9+as+NwW6FbI09vwb
	t8SRkjh9yNPFinnGE3cLYiT/qxy6G3ghlWsC7KE4X4FIOJ89+DYvXkqJKhB5IN7N1uyoRC9Mm1f
	FUXY7vz4Y52q3jh56gI7N7QtSFcx/g2eOOnRWpp5CU0808Nkfx8vsV2XcCCfsPBQhoAjN9TML0K
	ohaBl99TWQ5UVIST88KWxn7i4TE/dTezCQjkeKhuKAblQ6sGbrF7E484W3Vv22r9qAAFKEMJwxk
	FHxrigoBx6SBI6Gn9bZNpcM7FKO637XwHj+H6w
X-Received: by 2002:a05:600c:6308:b0:47d:586e:2fea with SMTP id 5b1f17b1804b1-48379bc887fmr174214075e9.15.1771331839406;
        Tue, 17 Feb 2026 04:37:19 -0800 (PST)
Received: from localhost (109-81-87-131.rct.o2.cz. [109.81.87.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836aa0847asm557596855e9.3.2026.02.17.04.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 04:37:19 -0800 (PST)
Date: Tue, 17 Feb 2026 13:37:17 +0100
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
Message-ID: <aZRg_ZSDkbGWv7Vq@tiehlicka>
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com>
 <aY2BcIHIARSwwQpo@tiehlicka>
 <eca7a8f9-173d-4cb0-93b3-df082b8d0c08@gmail.com>
 <aZLUm95Y-dKkdBWI@tiehlicka>
 <3fe7c5dd-b184-4421-a21c-bafce6aa7b09@gmail.com>
 <aZOHIQj3pJ-9dW_0@tiehlicka>
 <9ae80317-f005-474c-9da1-95462138f3c6@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ae80317-f005-474c-9da1-95462138f3c6@gmail.com>

On Mon 16-02-26 23:48:42, JP Kobryn (Meta) wrote:
> On 2/16/26 1:07 PM, Michal Hocko wrote:
[...]
> > [*] btw. I believe you misaccount MPOL_LOCAL because you attribute the
> > target node even when the allocation is from a remote node from the
> > "local" POV.
> 
> It's a good point. The accounting as a result of fallback cases
> shouldn't detract from an investigation though. We're interested in the
> node(s) under pressure so the relatively few fallback allocations would
> land on nodes that are not under pressure and could be viewed as
> acceptable noise.

This is really confusing. You simply have no means to tell the
difference between the requested node and the real node used so you
cannot really say whether the memory pressure is because of fallbacks or
your mempolicy configurations. That means that you cannot tell the
difference between the source of the pressure and victim of that
pressure. 

I am not saying these scheme doesn't work in your particular setup but I
do not see this is long term maintainable thing. It is just too easy to
get misleading numbers. If we want/need to track mempolicy allocations
better than what existing numa_* counters offer then this needs to be
thought through I believe.

I do not think we should add these counters in this form. 
-- 
Michal Hocko
SUSE Labs
