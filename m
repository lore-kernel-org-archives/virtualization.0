Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1277316CD24
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069076; cv=none; b=HL1DadE2ykAVlZvdpAs/AgmqNeabHz6XwujRyxpstWwAIl5sc73TvNYNtxISsm6HP4rIoEWlsOKze43luazQP8v+hXAeBO/EMQGA/Ipo0dpnKV4xUPdQox9jkpP2Q8E4Oc+ak5MceCgHY+lPkAPKZmimuHimc3zSnObQnp1ZQjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069076; c=relaxed/simple;
	bh=q3ZuZR2tKyTZcbB7zD040veZiBxOhEz+81P+qPtlMZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cH4qfdwGeaT8dDdeoVd6V8GGH+PFNQXY2Oudov4VjL9GSFfwBhSaLj5UVHrvlsajm0e8G1TY6j3XLtAFw0DWa8SFKT23AKbe5uLiNdhmSnyvKIkGYUrZjB/R4Oa3dOkee7wHmtcHJ7XHNOVrk1ghXUL94n5sD4jcG4HGfQDrnTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZS/G3WcB; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZS/G3WcB"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so559608666b.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 05:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724069072; x=1724673872; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c1Xamb7BHh3zzuofJjRTL9tIrsrysppjOLQKWaBDkZQ=;
        b=ZS/G3WcB5euqbNX7gbY/yKkcFJQgFmfNpgaQwe/oefaDDO6nQDwkP3+O3bURpQ1NX9
         q9LRwWBKmLlUOu2NdQDpUOfOoyTF3PeSkOtv/vx+3zhm6Eh9CE9qVy70KrfMXCPHH2E6
         MUICFDxTZk4I5hFDoNWsrS5qhEHU7/9K4KuX8sjYFmoARzAetZtgFApHfcbhfl/wccP1
         M+y50xrrW39oPLy9WKk9a0rAxD8/Exccc9oBozOmDVFwHtfmxZo4FGblB+UvzSzDhpHW
         tDs/6gSoxnMDW/QXHvLH9iWCZh+NqR8I53MvIiPTMOFQZHPGBJHo6q833+owLbdDTYOE
         VqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724069072; x=1724673872;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1Xamb7BHh3zzuofJjRTL9tIrsrysppjOLQKWaBDkZQ=;
        b=h0yB3fW+ySdg6LztRjFJJbiwDzHQyG9ljNEg7ui0GQ8IY/SZCzxKOwvMdBh98DM9p3
         1AomQcUWOqIEI6nOm6qE4WtF0TAIlrKUTB9/BcknLo59Hm7B6visml4O/Wmj/rJYycEm
         427T0u57gUSHBOXnrau8jH+CSmc6UPe6iVliKOc9IGzrVZp6hvHeRnN8opEslYivU2vx
         Vc8DeOMFy4Dv2KaPKBRxXbTTqnYfTYfSw0p3Plc9MlYzGd3yzETePIsXPc6l2qST4qoX
         XhlIgGX1o6D9zrlkRUfvMEAekQvTnO/vd9lWWqZe8ejFZByfTJg8x8VpQoTTGlZTzZUx
         j5gA==
X-Forwarded-Encrypted: i=1; AJvYcCWpfeg3E/j8rhh2qvJA2Z/zjjk+a0v+V6Xoc1ZPIiBLKyx0IOVpz65F3qBPW1Nb0YGZF2aOVDB4OAF90mj1pKZlMeREVWSYjTnWvQRbJSw=
X-Gm-Message-State: AOJu0YwLpwbYd53QLNREhlLtVmfOtPpgyxfxeHPKgpM6d/hchRDvC03R
	ZzTzXlxsS3nIf2QC3qstvwTEW6KvMGLOPPMDbxCxwrewJVMmj2U9DVuZFTnttPE=
X-Google-Smtp-Source: AGHT+IHS3lgR/Xmi8I9DU+TaI78Pgihv5BkldEHe0mmYos9hNFUy7u+OItkIMdOOUrsA4yJgZkp++A==
X-Received: by 2002:a17:907:d84d:b0:a7a:bae8:f29e with SMTP id a640c23a62f3a-a83929544afmr781025866b.29.1724069072041;
        Mon, 19 Aug 2024 05:04:32 -0700 (PDT)
Received: from localhost (109-81-83-72.rct.o2.cz. [109.81.83.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfa94sm622231766b.67.2024.08.19.05.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:04:31 -0700 (PDT)
Date: Mon, 19 Aug 2024 14:04:30 +0200
From: Michal Hocko <mhocko@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	torvalds@linux-foundation.org, urezki@gmail.com,
	v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 4/4] mm: prohibit NULL deference exposed for
 unsupported non-blockable __GFP_NOFAIL
Message-ID: <ZsM0zk9gtE81YeZo@tiehlicka>
References: <20240817062449.21164-1-21cnbao@gmail.com>
 <20240817062449.21164-5-21cnbao@gmail.com>
 <CALOAHbD-npQmchiRJpGvOBVOM-Li6oRyMnKAjgiHq3DasiXMUQ@mail.gmail.com>
 <ZsL5LSK8R3B1HsR1@tiehlicka>
 <CALOAHbBtB40Qth3k2yXM7riPaf3nxP0p4W-Ur=h2UK0BvPg4QA@mail.gmail.com>
 <ZsMb1uU2tp6ULHtG@tiehlicka>
 <CALOAHbD9SPvnmKfL2L_RmGiey=LeuFxRa=AzWG4fK=ZcT3tZng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbD9SPvnmKfL2L_RmGiey=LeuFxRa=AzWG4fK=ZcT3tZng@mail.gmail.com>

On Mon 19-08-24 19:56:16, Yafang Shao wrote:
> On Mon, Aug 19, 2024 at 6:18 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 19-08-24 17:25:18, Yafang Shao wrote:
> > > On Mon, Aug 19, 2024 at 3:50 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Sun 18-08-24 10:55:09, Yafang Shao wrote:
> > > > > On Sat, Aug 17, 2024 at 2:25 PM Barry Song <21cnbao@gmail.com> wrote:
> > > > > >
> > > > > > From: Barry Song <v-songbaohua@oppo.com>
> > > > > >
> > > > > > When users allocate memory with the __GFP_NOFAIL flag, they might
> > > > > > incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc.  This kind of
> > > > > > non-blockable __GFP_NOFAIL is not supported and is pointless.  If we
> > > > > > attempt and still fail to allocate memory for these users, we have two
> > > > > > choices:
> > > > > >
> > > > > >     1. We could busy-loop and hope that some other direct reclamation or
> > > > > >     kswapd rescues the current process. However, this is unreliable
> > > > > >     and could ultimately lead to hard or soft lockups,
> > > > >
> > > > > That can occur even if we set both __GFP_NOFAIL and
> > > > > __GFP_DIRECT_RECLAIM, right?
> > > >
> > > > No, it cannot! With __GFP_DIRECT_RECLAIM the allocator might take a long
> > > > time to satisfy the allocation but it will reclaim to get the memory, it
> > > > will sleep if necessary and it will will trigger OOM killer if there is
> > > > no other option. __GFP_DIRECT_RECLAIM is a completely different story
> > > > than without it which means _no_sleeping_ is allowed and therefore only
> > > > a busy loop waiting for the allocation to proceed is allowed.
> > >
> > > That could be a livelock.
> > > >From the user's perspective, there's no noticeable difference between
> > > a livelock, soft lockup, or hard lockup.
> >
> > Ohh, it very much is different if somebody in a sleepable context is
> > taking too long to complete and making a CPU completely unusable for
> > anything else.
> 
> __alloc_pages_slowpath
> retry:
>     if (gfp_mask & __GFP_NOFAIL) {
>         goto retry;
>     }
> 
> When the loop continues indefinitely here, it indicates that the
> system is unstable.

No, it means the system is low on memory to satisfy the allocation
request. This doesn't automatically imply the system is unstable. The
requested NUMA node(s) or zone(s) might be depleted.

> In such a scenario, does it really matter whether
> you sleep or not?

Absolutely! Hogging CPU might prevent anybody else running on it.

> > Please consider that asking for never failing allocation is a major
> > requirement.
> >
> > > > > So, I don't believe the issue is related
> > > > > to setting __GFP_DIRECT_RECLAIM; rather, it stems from the flawed
> > > > > design of __GFP_NOFAIL itself.
> > > >
> > > > Care to elaborate?
> > >
> > > I've read the documentation explaining why the busy loop is embedded
> > > within the page allocation process instead of letting users implement
> > > it based on their needs. However, the complexity and numerous issues
> > > suggest that this design might be fundamentally flawed.
> >
> > I really fail what you mean.
> 
> I mean giving the user the option to handle the loop at the call site,
> rather than having it loop within __alloc_pages_slowpath().

Users who have a allocation failure strategy do not and should not use
__GFP_NOFAIL.
-- 
Michal Hocko
SUSE Labs
