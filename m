Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC8230FC1E
	for <virtualization@lists.linux.dev>; Sun,  8 Mar 2026 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772997644; cv=none; b=Yu5OsZQMEPnx0zPQ98qUmYK+HH/8/PRuQHYO4OrtXilPzbOFVryV+7d/Rpcr5gWsn3av6j0ImMZp2fz5auZwkhOp/IcmknW586meYqF0aqtIiB2ymhNBpElGIEyP0cF2nkL0mUPOJxeoys7OdfbddhyTNSsZe9OP/neE93dbhlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772997644; c=relaxed/simple;
	bh=mIM/dD2oEQvrrW6yGLWQSr0OZLs3LodBecK8xi2Eutc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q07pm14EUDPiEUMbSRdL/InfhfCWO38mUvcmLQIXCqmefObJ4dE9donquZ8Y7m4nb9WNuaRsRDE3iSUtQ7z47jMjOYtuFAOiGcHaN9KFPQu3EVDh5TnAqwDyGRjgvGXAmzYVJ35kWh1uj+xqG/taMoKDmkEF1QLINQnj9/PuAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VVqblNHL; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VVqblNHL"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-509006c070eso14574941cf.0
        for <virtualization@lists.linux.dev>; Sun, 08 Mar 2026 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772997642; x=1773602442; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6kmBzNS/25cHmBEwOEgUDbKXqaLe2GkCkxgRM0uJ1o=;
        b=VVqblNHL8AGzzA7wt2UkFh8ONjJip7Rio4WFSMSys58xFMAbnkepgxWpKlJDq51VhK
         pthqH3W+TTBVdZF4hyTJ7UYlfisFdWUE4hN2IIhcLWfcKtovNaGNhoqEqm2/DhkqJUcG
         mqo0GvfdfaTEUnKBHsn1gWkowiGddjMvUJrzoj99ziqKgee68/3GyEAHMjLfOnpyIf+2
         0fZCfoHoZyg2ZSt0EXkAtCMUT6l0JuczMqxngTwMneMoF6CHVtO9SOp1jWV4dMRoz/wh
         tU4CZngddkAcBoiV7VkPqwNHHTB/eTQ4ISPuJkJTHNOhVgbRaEFQoSAk0+tTz9PX4jon
         Y/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772997642; x=1773602442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6kmBzNS/25cHmBEwOEgUDbKXqaLe2GkCkxgRM0uJ1o=;
        b=kTFEJq9hRINrhC8sus4XIiJrCyC5STYDFGttgpd3VvgamNTTSOur2w/YKr2lKL3ChP
         oUrn9AAGSiv8kZL1OEk9MLsOJYazUp7+i/9aXS+iwU5GifHPcq/fJ/xQrpf2G+fuf8+e
         Qt5vwczhPZGtvKnQH+7ufdauKIkmb5oLVTp2Checv+1+zC1wGS7eTXBV9MnoKsQckyN9
         V3/IjUVndSDxwGClOQaAqzMxujI31QfcnOCORT3fN7iIxBQxFLt7N7/6DHS1/7C11yhV
         t9HQyXudnuNJ+qKhtvjh/3E9TL1cF/ew9hGrnF0RAUyLJ5APPdFUWi2FlYRdkIDLSDtZ
         m/8A==
X-Forwarded-Encrypted: i=1; AJvYcCWd2j+rBwn9/kDxP8O+mkl3qnyARBWJYPC14B0ANg/3TfI4SrnSkqbm94mrTDQlLx2QlcR2awaCwYvWDMI3WA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrzvXdebtubXTKj6OOFR7bVxhmf3CZyOJ+xMQaG9jaUZ1RUrks
	cf0gri+KqRPnr6ueLaZwILzD27DKMSDFZvZx3Douu4+n5pyPEwMrgP7ufFL/JvElJow=
X-Gm-Gg: ATEYQzzvfZ8fy6qeFp+aHxkJMmr9bLUXRRpXvpj7aK7CpUPaDicbYgD/mnKoXAbJzjo
	SIsXrbrfD4KUy8mbIMsEllxinaNT3YK4XcUuAK4NEgsgf8ykI+6dhLXHkjjGIR4eSpH40v4vV5K
	ouZ0FKmFih0ANnTLoxheZ/5DHpBcCvTnaOVrRHkPYbvcGLXFSDWupXcBoE3fJbKUSxmgNm21WAx
	XM8vYMLs5K5OoYlLi/abLsFsYxRM/tX/zxGZvjaMs1XEAVmyFLueiULulx3DbyNPxaj3LL01MSb
	Oc3EpfQov+v+TlqiIdOb5Ww52VhF1KehxkVqjvY3a90SzwShwEfdX2FNnHfQMR6ATNlmXJTXHin
	g/iTtwFCbyAOLEBWq03Qn83IorRl0XcKkex7LpazFNj5vuAMB29maM+nrUn3LaCPqj7In0FVfJQ
	lWf4h+qaI0MxpsoozFpSOfs0G9gq0zFNn78k43PZXthMEsUHc0lmZ3843/CQmHnsHE2cHFYyTOG
	gBbLpPEDw==
X-Received: by 2002:ac8:5fd0:0:b0:4ee:1b0e:861d with SMTP id d75a77b69052e-508f46fafd3mr130582111cf.26.1772997642178;
        Sun, 08 Mar 2026 12:20:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-509101c6a55sm19141431cf.23.2026.03.08.12.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 12:20:41 -0700 (PDT)
Date: Sun, 8 Mar 2026 15:20:38 -0400
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>, linux-mm@kvack.org,
	akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
	apopple@nvidia.com, axelrasmussen@google.com, byungchul@sk.com,
	cgroups@vger.kernel.org, david@kernel.org, eperezma@redhat.com,
	jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
	rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
	rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	surenb@google.com, virtualization@lists.linux.dev,
	weixugc@google.com, xuanzhuo@linux.alibaba.com, yuanchu@google.com,
	ziy@nvidia.com, kernel-team@meta.com
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
Message-ID: <aa3MBp0JhUN6zE8i@gourry-fedora-PF4VCD3F>
References: <20260307045520.247998-1-jp.kobryn@linux.dev>
 <87seabu8np.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87seabu8np.fsf@DESKTOP-5N7EMDA>

On Sat, Mar 07, 2026 at 08:27:22PM +0800, Huang, Ying wrote:
> "JP Kobryn (Meta)" <jp.kobryn@linux.dev> writes:
> 
> >
> >   hit
> >     - for BIND and PREFERRED_MANY, allocation succeeded on node in nodemask
> >     - for other policies, allocation succeeded on intended node
> >     - counted on the node of the allocation
> >   miss
> >     - allocation intended for other node, but happened on this one
> >     - counted on other node
> >   foreign
> >     - allocation intended on this node, but happened on other node
> >     - counted on this node
> >
> > Counters are exposed per-memcg, per-node in memory.numa_stat and globally
> > in /proc/vmstat.
> 
> IMHO, it may be better to describe your workflow as an example to use
> the newly added statistics.  That can describe why we need them.  For
> example, what you have described in
> 
> https://lore.kernel.org/linux-mm/9ae80317-f005-474c-9da1-95462138f3c6@gmail.com/
> 
> > 1) Pressure/OOMs reported while system-wide memory is free.
> > 2) Check per-node pgscan/pgsteal stats (provided by patch 2) to narrow
> > down node(s) under pressure. They become available in
> > /sys/devices/system/node/nodeN/vmstat.
> > 3) Check per-policy allocation counters (this patch) on that node to
> > find what policy was driving it. Same readout at nodeN/vmstat.
> > 4) Now use /proc/*/numa_maps to identify tasks using the policy.
> 
> One question.  If we have to search /proc/*/numa_maps, why can't we
> find all necessary information via /proc/*/numa_maps?  For example,
> which VMA uses the most pages on the node?  Which policy is used in the
> VMA? ...
> 

I am a little confused by this too - consider:

7f85dca86000 interleave=0,1 file=[...] mapped=14 mapmax=5 N0=3 N1=10 ...

Is n0=3 and N1=10 because we did those allocations according to the
policy but got fallbacks, or is it that way because we did 7/7 and
then things got migrated due to pressure?

Do these counters let you capture that, or does it just make the numbers
even more meaningless?

The page allocator will happily fallback to other nodes - even when a
mempolicy is present - because mempolicy is more of a suggestion rather
than a rule (unlike cpusets).  So I'd like to understand how these
counters are intended to be used a little better.

~Gregory
