Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02998154C14
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062684; cv=none; b=rAj6iJ77xU8YIK3y0kktE7/hnQMhNvsqkjgtiisc9YVKz6PQS80ZX+Hl1A6RrMDZcwT0LrgKcbl/M9G7LNdfiwpaZ59qcf1PnROIpA0EgufMdDnj1lSIyx3zSc1Tggt9q+jM+IXSAwNn+FviwjgQyuznPUI0Qvq6jsiD+AGdm5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062684; c=relaxed/simple;
	bh=TjMG4MUhvDaZ09iEpYdR+gEpjka/KCTFnmbU5jQU1AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rA6o6I0uc6pCWfqbKgNvpkxQLIpXlLdoL1a68Ybj6YDNf0MCYmGXGcNxtA3C6/xz6MBMcCQ1w13N34hUbt+NHobGRbx6JHrIpOSpSKe0m4vgGONVyiJGjAPfMMGbjhJ3ghbHyXEqm+POyigxkeEARFC0VSFsdt6SPaQb3t78sus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TjYfE4Fk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TjYfE4Fk"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bf01bdaff0so427854a12.3
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 03:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724062680; x=1724667480; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mCkt14OXmujv3CAVA2IuYr6eddmi2BtZwN2CCnzS0Kg=;
        b=TjYfE4FkBalS3ibJe1Do7aMQkwfKrM9gHX8UCBQElQU+u7lmnUcyrGZiI5luOud+4q
         uvw2I7CSSOpi4tqzrBRVW5fChsJhC+vTV5bYrAIJMou/xiAyhTpIC0xEeSLAx41/8SOj
         TgWTum4UVzrUQiF7CCiWFUoI13ZoZmViijsJ3bmhbgNFSak+TMZ6afpQ2Kj+lbnIsWSN
         D26rzlPs9mc0/ZxOt2HALY5DyTfk3xT2i2VMZqW61NI2Zmy/ciwfcBIEQkjECAqBS4hy
         n/sAK5WpotAZHkZVRdUPpbF5BKxbQ13S2VQsl0DzBdTHlJ1gTRRpufElPiLbJEetdfUw
         c+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724062680; x=1724667480;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCkt14OXmujv3CAVA2IuYr6eddmi2BtZwN2CCnzS0Kg=;
        b=Asf2qCaj2v/isX2hThNiSVH0DFSqbWF6SpDedggM9nnn79IlutGXAxH+WadjFdnWEw
         ah6W049eJDyVjz6PfHbRbaHdhS47hbwaiz66WUerlYPosmnbz8SbhJgWkUAK4fF32ugh
         UFQCAXFjaWwp50JuZh4tpNfHKBX8hRCIofoMcSNx00AuCAu42wGXNJVsT+9Z57W0R9fB
         PiNVCx6DZdK6kDZOAAw9at2eGaJJT+WB7PshxhK6ANfq7by/zNhEl3AOsPUKUrPDp3Ga
         sXbdMgR5c2koUBIuYqgaZjAoxpOnZe44us1+YtfAuSFYATiNFkKWBLe1nHGDCZ5H7hdz
         T5pg==
X-Forwarded-Encrypted: i=1; AJvYcCUbtdEpakzCD1GYBOb7ZuN7+5dxl5HkGOvICwc0VO9MMPyMJVuHJUUWJb4FdXlWXl5A1o1XXb0gXAVSDOF20gF0KJhRvdCBCYHVwT0rtPs=
X-Gm-Message-State: AOJu0YxkDfclYu2Tgu7TRz0tFfCT965xxHqLOnNvHQV5hBKk7RLAVDTw
	mqAcfmejIwqxPaIF7Bh9GrXdG3WW3rBZ9zxGOZwsmZKAOGNN2atCxvDSsFCce8w=
X-Google-Smtp-Source: AGHT+IH7mKVhOvldd+YWFB8xfHwfzyUOR4ddfb8gx/ak3NJGinmjEyEZneQg2pStbUD7tAAmzrehjw==
X-Received: by 2002:a17:906:c116:b0:a72:8a62:65e7 with SMTP id a640c23a62f3a-a8392a38f5dmr607460866b.57.1724062680134;
        Mon, 19 Aug 2024 03:18:00 -0700 (PDT)
Received: from localhost (109-81-83-72.rct.o2.cz. [109.81.83.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396d4b2sm612732766b.220.2024.08.19.03.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 03:17:59 -0700 (PDT)
Date: Mon, 19 Aug 2024 12:17:58 +0200
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
Message-ID: <ZsMb1uU2tp6ULHtG@tiehlicka>
References: <20240817062449.21164-1-21cnbao@gmail.com>
 <20240817062449.21164-5-21cnbao@gmail.com>
 <CALOAHbD-npQmchiRJpGvOBVOM-Li6oRyMnKAjgiHq3DasiXMUQ@mail.gmail.com>
 <ZsL5LSK8R3B1HsR1@tiehlicka>
 <CALOAHbBtB40Qth3k2yXM7riPaf3nxP0p4W-Ur=h2UK0BvPg4QA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbBtB40Qth3k2yXM7riPaf3nxP0p4W-Ur=h2UK0BvPg4QA@mail.gmail.com>

On Mon 19-08-24 17:25:18, Yafang Shao wrote:
> On Mon, Aug 19, 2024 at 3:50 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Sun 18-08-24 10:55:09, Yafang Shao wrote:
> > > On Sat, Aug 17, 2024 at 2:25 PM Barry Song <21cnbao@gmail.com> wrote:
> > > >
> > > > From: Barry Song <v-songbaohua@oppo.com>
> > > >
> > > > When users allocate memory with the __GFP_NOFAIL flag, they might
> > > > incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc.  This kind of
> > > > non-blockable __GFP_NOFAIL is not supported and is pointless.  If we
> > > > attempt and still fail to allocate memory for these users, we have two
> > > > choices:
> > > >
> > > >     1. We could busy-loop and hope that some other direct reclamation or
> > > >     kswapd rescues the current process. However, this is unreliable
> > > >     and could ultimately lead to hard or soft lockups,
> > >
> > > That can occur even if we set both __GFP_NOFAIL and
> > > __GFP_DIRECT_RECLAIM, right?
> >
> > No, it cannot! With __GFP_DIRECT_RECLAIM the allocator might take a long
> > time to satisfy the allocation but it will reclaim to get the memory, it
> > will sleep if necessary and it will will trigger OOM killer if there is
> > no other option. __GFP_DIRECT_RECLAIM is a completely different story
> > than without it which means _no_sleeping_ is allowed and therefore only
> > a busy loop waiting for the allocation to proceed is allowed.
> 
> That could be a livelock.
> >From the user's perspective, there's no noticeable difference between
> a livelock, soft lockup, or hard lockup.

Ohh, it very much is different if somebody in a sleepable context is
taking too long to complete and making a CPU completely unusable for
anything else.

Please consider that asking for never failing allocation is a major
requirement.

> > > So, I don't believe the issue is related
> > > to setting __GFP_DIRECT_RECLAIM; rather, it stems from the flawed
> > > design of __GFP_NOFAIL itself.
> >
> > Care to elaborate?
> 
> I've read the documentation explaining why the busy loop is embedded
> within the page allocation process instead of letting users implement
> it based on their needs. However, the complexity and numerous issues
> suggest that this design might be fundamentally flawed.

I really fail what you mean.

-- 
Michal Hocko
SUSE Labs
