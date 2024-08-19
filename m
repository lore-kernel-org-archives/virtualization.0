Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F77816B3A3
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069395; cv=none; b=NcrF1hF9gVuSylSKW3rkF1+IOnOVfcU1OfX1jzabwgdU+qj+XM8XJ2zhY0EbtawyJjNxiH+ElINA7a5JT6loI+SJrMFyfUkbZKcMxiR9R5IWykbtFwMUQB5zO14IUU5cZzX6BHsNvLOfonynvP+d718VW053F0XFkcEkAGjb4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069395; c=relaxed/simple;
	bh=1qFC1tpBxnVXFXaZYhqt8aobMEcV/uog1+ckPe2nGlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQNcVaYsnMfIKm0rztH3tkkEBv4EvCF3jg6dnJl9XvzR3Yt4g6VY8rLSUzsWB/Vf4oLottZu6I7Kes1GvL8ISfzRhb1SWcg3+HAaW/gAHAGM1Q5pVpUCr4ybCie/Wa6YAzZdI8QsTdFOUCyLSdpojOXyUF4WO3UbIrWXSVJ4ZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QkNPrZQi; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QkNPrZQi"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso50395191fa.3
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 05:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724069391; x=1724674191; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VsXc2LF6RY+Mbl+0XKQZtcelxbPxf1NuiraWq9n6YWk=;
        b=QkNPrZQiHHCfIreLQW/zODuXVQD0/jV7+MK2OZtGvj/bf/WqYrVIeSr0OICqezs/ul
         C2u9eB+bPj+LEzX/2xKJRG+6DMvLz1qyOOY1/8EAthA/Lr96Xf6YJkiyLC2jP9KUMZGN
         C2x3flQ6b1pp2o0I2h7NJXWDgjkhAOwUQ3QbidTVNde5iFxDhyQHO1kQ+EJwStFZyo9l
         NEffyZUVH/Km4kxslsBNQ1gtgpdGhXRwaH6eLUp9MGoMgsaT6ptNiFgREvfDOJ57PIqb
         +UdIZVTsTGLqwdk4rCabQY15gl114/FuiIj2w0c0YbURq4zOcfd91pXl/+aVOjpGWmDq
         pm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724069391; x=1724674191;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VsXc2LF6RY+Mbl+0XKQZtcelxbPxf1NuiraWq9n6YWk=;
        b=dX73yPEMjws4fXlIhNZV8UhqQJGBaMLzV9nhjAXEmIvdBq+/Yehxfe75o8AMuZ5eR4
         6uzTX+xj/PvJhhPKL3EfUVJzR/Ze1VKLvYIEBC3wb4KMyoh8/2lS5XKLVs4lvwMzrTaP
         Yllpr59PKqqkLDvazymGjd0IfOEwmdprWsYAAoAY8PZM13wZaD3onptyvQz5smkiV2dn
         1K/lfbrQQcER97Gm4hcToMuAmdcJP34d0LQf8hisvLWkTkgx6NO6RA9AfVySRYf+aK0B
         LugkioxS4RyA3nddB3ZvpOpAaxs7FducBfOW40ZWa8ReNmcRSvkBPmLALEskLlio/HZ1
         jtLw==
X-Forwarded-Encrypted: i=1; AJvYcCUMgLfYs4vVCcvaY1Qk7slvg2RMlWprL7UvtEgNtm3cK5fG0SiO+Np+kUPquYOB2RDO7reOlxDR9A3Bnw6zdpKJQl/leq61jM2pNWony5c=
X-Gm-Message-State: AOJu0Yza44z9NsR/KXTvM5IGRLVg4+ODThl/gbmLS/pfv2TpDq5OdMGI
	+pYVZZWzRVrGxvfJVXMpk264cTSjeBL6Q611Vnedv6Izv3M+nEEV8B+Z2HEXCJIEFKijhOCRaTN
	S
X-Google-Smtp-Source: AGHT+IF3tfkg4bHEJaHO7fC9laXoEarCWgUUsjT+mRti4XGeALMRYiGfJyow6r+v1G/f4J/p5pqqTg==
X-Received: by 2002:a2e:9b50:0:b0:2f3:abb4:4f08 with SMTP id 38308e7fff4ca-2f3be58574emr69486761fa.12.1724069390888;
        Mon, 19 Aug 2024 05:09:50 -0700 (PDT)
Received: from localhost (109-81-83-72.rct.o2.cz. [109.81.83.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc081cf5sm5475615a12.90.2024.08.19.05.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:09:50 -0700 (PDT)
Date: Mon, 19 Aug 2024 14:09:49 +0200
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
Message-ID: <ZsM2De5v06eJsiG3@tiehlicka>
References: <20240817062449.21164-1-21cnbao@gmail.com>
 <20240817062449.21164-5-21cnbao@gmail.com>
 <CALOAHbD-npQmchiRJpGvOBVOM-Li6oRyMnKAjgiHq3DasiXMUQ@mail.gmail.com>
 <ZsL5LSK8R3B1HsR1@tiehlicka>
 <CALOAHbBtB40Qth3k2yXM7riPaf3nxP0p4W-Ur=h2UK0BvPg4QA@mail.gmail.com>
 <CAGsJ_4yS=8kXruzVxzx+u+nyXG-5OfdjxSZeq_WzyOGfpu5btw@mail.gmail.com>
 <CALOAHbDKwmtRcowx=V9Qfk2AF5=gg6_kTZC=jfPcB7=fmd65LQ@mail.gmail.com>
 <CAGsJ_4yyYaPSG+aRQdFqh+Yk-gN4Ah=d7FxmUVdSU5H3Aeo7pw@mail.gmail.com>
 <CALOAHbCG=_W9rrf+hgkFYF6+1LZuEeEjpyiexu9iseGOaDJ+QA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCG=_W9rrf+hgkFYF6+1LZuEeEjpyiexu9iseGOaDJ+QA@mail.gmail.com>

On Mon 19-08-24 19:56:53, Yafang Shao wrote:
> On Mon, Aug 19, 2024 at 6:10 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Mon, Aug 19, 2024 at 9:46 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > On Mon, Aug 19, 2024 at 5:39 PM Barry Song <21cnbao@gmail.com> wrote:
> > > >
> > > > On Mon, Aug 19, 2024 at 9:25 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > > >
> > > > > On Mon, Aug 19, 2024 at 3:50 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Sun 18-08-24 10:55:09, Yafang Shao wrote:
> > > > > > > On Sat, Aug 17, 2024 at 2:25 PM Barry Song <21cnbao@gmail.com> wrote:
> > > > > > > >
> > > > > > > > From: Barry Song <v-songbaohua@oppo.com>
> > > > > > > >
> > > > > > > > When users allocate memory with the __GFP_NOFAIL flag, they might
> > > > > > > > incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc.  This kind of
> > > > > > > > non-blockable __GFP_NOFAIL is not supported and is pointless.  If we
> > > > > > > > attempt and still fail to allocate memory for these users, we have two
> > > > > > > > choices:
> > > > > > > >
> > > > > > > >     1. We could busy-loop and hope that some other direct reclamation or
> > > > > > > >     kswapd rescues the current process. However, this is unreliable
> > > > > > > >     and could ultimately lead to hard or soft lockups,
> > > > > > >
> > > > > > > That can occur even if we set both __GFP_NOFAIL and
> > > > > > > __GFP_DIRECT_RECLAIM, right?
> > > > > >
> > > > > > No, it cannot! With __GFP_DIRECT_RECLAIM the allocator might take a long
> > > > > > time to satisfy the allocation but it will reclaim to get the memory, it
> > > > > > will sleep if necessary and it will will trigger OOM killer if there is
> > > > > > no other option. __GFP_DIRECT_RECLAIM is a completely different story
> > > > > > than without it which means _no_sleeping_ is allowed and therefore only
> > > > > > a busy loop waiting for the allocation to proceed is allowed.
> > > > >
> > > > > That could be a livelock.
> > > > > From the user's perspective, there's no noticeable difference between
> > > > > a livelock, soft lockup, or hard lockup.
> > > >
> > > > This is certainly different. A lockup occurs when tasks can't be scheduled,
> > > > causing the entire system to stop functioning.
> > >
> > > When a livelock occurs, your only options are to migrate your
> > > applications to other servers or reboot the system—there’s no other
> > > resolution (except for using oomd, which is difficult for users
> > > without cgroup2 or swap).
> > >
> > > So, there's effectively no difference.
> >
> > Could you express your options more clearly? I am guessing two
> > possibilities?
> > 1. entirely drop __GFP_NOFAIL and require all users who are
> > using __GFP_NOFAIL to add error handlers instead?
> 
> When the system is unstable—such as after reaching the maximum retries
> without successfully allocating pages—simply failing the operation
> might be the better option.

It seems you are failing to understand the __GFP_NOFAIL semantic and you
are circling around that. So let me repeat that for you here. Make sure
you understand before going forward with the discussion. Feel free if
something is not clear but please do not continue with what-if kind of
questions.

GFP_NOFAIL means that the caller has no way to deal with the allocation
strategy. Allocator simply cannot fail the request even if that takes
ages to succeed! To put it simpler if you have a code like

	while (!(ptr = alloc()));
or
	BUG_ON(!(ptr = alloc()));

then you should better use __GFP_NOFAIL rather than opencode the endless
loop or the bug on for the failure.

Our (page, vmalloc, kmalloc) allocators do support that node for
allocation that are allowed to sleep. But those allocators have never
supported and are unlikely to suppoort atomic non-failing allocations.

More clear?
-- 
Michal Hocko
SUSE Labs
