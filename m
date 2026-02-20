Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1F23161BE
	for <virtualization@lists.linux.dev>; Fri, 20 Feb 2026 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771614173; cv=none; b=XjFgu3dW+6/rrUTqF9IFSxyC2rpbrr/i6mD7YqGVwQOjF9a/ZLD9fw7/b0AMIyo06AUuAJ0/DUq39oHJehZM+unSAgBC446rn5pCTJ/Vf33siuAKaSUxSBJgk094r63LER4+ZIshmiLszA1lcjfBp9bqyAm1DaVtLfo6vTp9HVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771614173; c=relaxed/simple;
	bh=Cd+jqZjh3WAVSRNIVyZ6GsQswDgTs8XBJ+R9F/1aitQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfA4pZcunj1OpJAIDXdxLN5MOAJ6+Uwed52qya3Ptm/z72gZlpNPfydqqildS1+mL7Dq/uX1lF72yFuW9iEqYOcOtJT2jqR4YtBfjoh8bTRvXZHgHQxILm2EFkAVlTT8rPDNfd5PfN+ZzuzEsA+fNdZyFqfNemBlpBAwhKzVuyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Iv3wnoW9; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="Iv3wnoW9"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5fdb47d6131so713212137.3
        for <virtualization@lists.linux.dev>; Fri, 20 Feb 2026 11:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1771614170; x=1772218970; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=trvZR2sCF4V60jHjOkl0avZ915H6as3fJB6OlIOoH5U=;
        b=Iv3wnoW9gsWr+iXQBScecpjE6OvP9MYV7+itRzRrxkUDBHXS8abqU+Sb67KvAJTOaq
         OksVLPNIrUfeiXiUk/5yp6OAsyYd9lskoumNsQ848qKoMZ+zqbuOejkTVpcEFYHmWJmS
         CIh9miA7b2pkIU7Tcke2wga5eQ6OBwoGpnTu9uxjRkaOMutkE68hYqZ7JiNrGNhAH1W/
         Rr69M0Ezw/rxHwdQUYSUeBldYQ670lg+xaoxz1844G4b/q+NJe4wOzpipdwfCUeHxu5e
         DCvDL6yds3Ukn3EKTrfcRc0tgMLMKZi9wCRJClkWV2EW+BesFDxwEvy18e+5LpF7Nz5p
         kldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771614170; x=1772218970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trvZR2sCF4V60jHjOkl0avZ915H6as3fJB6OlIOoH5U=;
        b=eIAbns7qAhwGICEtLLHS5XP+r8OTZEwS/4tnpwAJmiWo5uWFdePFHEK2XOElMaiX4T
         jBvP9jV0qjEPLCJbGDjwcCx/WKhXiLfANNQ3JplcVlQbz+Y8i1+Z7FbH0+mU7CopugCK
         oHqZVjJt6upkod7UGambcDAvJhpaW51zMF58x2AKcU4MrCDWPtzkgldnbTjL7ZAairM7
         6LuKHYL54ahAs5I/aiZxzb+tzyhDHMdoGzyUrv7Fj2MfMatsbxk/pifIHVoVX67owWHF
         AuzF6PkbrFnUseYpuKk5cdyNlllEjFWmkLGWAmeE/LJcCufhhjev0thhM0avjeR3vApc
         Uz3w==
X-Forwarded-Encrypted: i=1; AJvYcCUDV2pvA87OKo4pETrJ8r1le6k3AvyWqesJRQJ8AzVsZt/NxWiz9YD9BIkIX4tuVxNPzaVpUz9gTGCwIpUKgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKwcrETUO8mszLDwVu2FXRy3esfkQGZ6k3g5fg+fw8gx92xNrT
	JaNry1MockhOeQRvzK1cCXv5WKlQb43rCi6//HysBgBVp71XhTuIGVaRBd89edRVRXk=
X-Gm-Gg: AZuq6aJU2n6aI2NQG3yAVBCKEvF569fbAQKwfoaSM3BCP62wjBPBnUtJbQmlR2gHpev
	PIE0KwuT7V6JehRehJ40lBrrziK0G50YGrf7IhN1mu4tA3mY7Y+254lFRNG4ZQnZNcEqh88bMGx
	lC7Rv9PCwuKEUSxlVOy4V4JkXychKZB2rrOLXR2kMdr2KlEuieFik8goVzWtK609DkZ58mZ3FVs
	/lSBY4vd9IShXy/x/KNQW5IdBM6L+2B74/7CpFYy4zQTr7Pjg2Io6kOVOl2mKS7YEg29miJkAnK
	zZ8BZEXZO+5vHXDaRGXiotAHQOrW0WMGogDkXhItS2YxumOT8cy6PlOEmIx4DzVWH2qIiwtZZcA
	5DsY02EsBaYU7/dXpoli3D2/mbO6rLOgB+hLdlZE+xCbKJNk2V8q43mmC8Rc0m4SraRB/quZsdF
	aje90mRKyKKY+GnoGIcRzUdA==
X-Received: by 2002:a05:6102:a4f:b0:5ee:a7e9:f157 with SMTP id ada2fe7eead31-5feb31253ddmr438759137.40.1771614169735;
        Fri, 20 Feb 2026 11:02:49 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6df498sm488911cf.30.2026.02.20.11.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:02:49 -0800 (PST)
Date: Fri, 20 Feb 2026 14:02:48 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
Cc: linux-mm@kvack.org, mst@redhat.com, mhocko@suse.com, vbabka@suse.cz,
	apopple@nvidia.com, akpm@linux-foundation.org,
	axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
	david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
	jasowang@redhat.com, joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, matthew.brost@intel.com,
	rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
	rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	surenb@google.com, virtualization@lists.linux.dev,
	weixugc@google.com, xuanzhuo@linux.alibaba.com,
	ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
	kernel-team@meta.com
Subject: Re: [PATCH v5] mm: move pgscan, pgsteal, pgrefill to node stats
Message-ID: <aZiv2ASYc46m7K_c@cmpxchg.org>
References: <20260219235846.161910-1-jp.kobryn@linux.dev>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219235846.161910-1-jp.kobryn@linux.dev>

On Thu, Feb 19, 2026 at 03:58:46PM -0800, JP Kobryn (Meta) wrote:
> There are situations where reclaim kicks in on a system with free memory.
> One possible cause is a NUMA imbalance scenario where one or more nodes are
> under pressure. It would help if we could easily identify such nodes.
> 
> Move the pgscan, pgsteal, and pgrefill counters from vm_event_item to
> node_stat_item to provide per-node reclaim visibility. With these counters
> as node stats, the values are now displayed in the per-node section of
> /proc/zoneinfo, which allows for quick identification of the affected
> nodes.
> 
> /proc/vmstat continues to report the same counters, aggregated across all
> nodes. But the ordering of these items within the readout changes as they
> move from the vm events section to the node stats section.
> 
> Memcg accounting of these counters is preserved. The relocated counters
> remain visible in memory.stat alongside the existing aggregate pgscan and
> pgsteal counters.
> 
> However, this change affects how the global counters are accumulated.
> Previously, the global event count update was gated on !cgroup_reclaim(),
> excluding memcg-based reclaim from /proc/vmstat. Now that
> mod_lruvec_state() is being used to update the counters, the global
> counters will include all reclaim. This is consistent with how pgdemote
> counters are already tracked.
> 
> Finally, the virtio_balloon driver is updated to use
> global_node_page_state() to fetch the counters, as they are no longer
> accessible through the vm_events array.
> 
> Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
