Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ACE12C52E
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053810; cv=none; b=X+4wxfCzVr55wphfgi1qpaf28A6nPCxhJHjLwy22vup2qrFFtZ+MSN75WgSa+orzfAHa5EEMS0ZjT0IhNNxnOKn+dRqgy8UIRvzOohz5zCSAr2+MDQEkn/tX2IZvOzLv10vfXvbW5FIF/gaU7IGO8fRcacmB7IpFUGoZzEEtqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053810; c=relaxed/simple;
	bh=5OYto3pUsrkQDQI8NkwAsb/yCvYe4wBNfZByh/JmYI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jqdpg0nLpfO4T2+GaP49RweAZyLPm3lk4aq1fZaYtFxbBi93pKCZ63opKgTrv51vdvsyoxcRkYcISBDlTolCT7z/ginzAtBFhcdDp2czqyFtVW4QCC9TVAL69gLw+N7TUUCt5aS3xheK0xaw+pXolS/R+95t3hXsCs1+ADXlWak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PvGoBinT; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PvGoBinT"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bf068aebe5so24577a12.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 00:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724053806; x=1724658606; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TZy1R/aGokLe46oAtBLjuw7d3h1Spy9qlLcDxS6nr+M=;
        b=PvGoBinT3X/a+E7eW2ZiEjf1JENGKO9Ol5fgRkLhg+T4wIY//9wkSCx2OOBdbVev+u
         N2WSHhIySDrsISMQkCoBHGCT5pMmHqUicrlVEwBmPjL0p6GN/BMVx3BFJ5WC94aVIrUh
         g2OySswBOOs8zWLP+wp7Wie65fNgXnk4agQMYtnN6+40WdQaEhOi3kgKrCYKDVJyW9Oz
         8tQUWTLOQS31ic2c9ndhbTE7QsjRlHXoLulTnehfV4gBX0qRMK6YF2s5KguKS5g9OVYE
         KGU3L3rklLFZYdh/30GL8bMcE9QrmbKKpGczqpv15SAGO3J5RJBxVWxRYzSCQqbhWGZT
         Jd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724053806; x=1724658606;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZy1R/aGokLe46oAtBLjuw7d3h1Spy9qlLcDxS6nr+M=;
        b=Toz0apTwL39p1yHMQ1GEytnkU44vQmquymu2tC+Aj1WElFwpeKFTCTX+UODCiHEj5O
         qOnNn4or+MiDaxNFwscSRKVev8UW1ixKOl822JOa/0NMc2b4T1AyGNoHRy7NUsmZJFoJ
         Yw7b2m5HjNs4PGzQeymwztlS6XnncZTZdORh7VuQFcZKstb6LPSf0W/l6aJwEDnRqZXz
         NHimxtgIuoS1o4SiTHYRzTe+8aFiwGMTJ1PJNJibnmJVEKK6lAmTdR6VJwTm+uxTwhVh
         BB12VZXLjBtBACHXnLa8WyYGp50MZ4FWknlt+6L+xthF3uV+dv1JDH1ee1h2bgomaCyG
         clqw==
X-Forwarded-Encrypted: i=1; AJvYcCX8OZ5QN1uACFnDxBS15sl7Q67K0KLuP0d00HX0zNfCuoyGWZLO4SHmELFVbMtGKpa8ejFgHndVPgN4xeoHX+0XDHfvqIQ2wk+CARIpSao=
X-Gm-Message-State: AOJu0YyChtVEEtYQNIfaJi1mWXlcQZSVNEgWeYMJOOZFCr3cs6Z8x7+Y
	t7Ch2v1A6w1jWe27bF1SgouBN396h+JkpPOsjxcptQOHde80lYlPxvlZMr9iOR0=
X-Google-Smtp-Source: AGHT+IG7tile/06Xpownlqx6q8Tlrt9mUJtZaMBoQ5z0zzagdeFkMFHBefIzXhIlqDXtAF7x4PLKjg==
X-Received: by 2002:a17:907:94d4:b0:a77:bfca:da57 with SMTP id a640c23a62f3a-a8392a1149bmr663686766b.44.1724053805986;
        Mon, 19 Aug 2024 00:50:05 -0700 (PDT)
Received: from localhost (109-81-83-72.rct.o2.cz. [109.81.83.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839471e1sm599610666b.152.2024.08.19.00.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 00:50:05 -0700 (PDT)
Date: Mon, 19 Aug 2024 09:50:05 +0200
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
Message-ID: <ZsL5LSK8R3B1HsR1@tiehlicka>
References: <20240817062449.21164-1-21cnbao@gmail.com>
 <20240817062449.21164-5-21cnbao@gmail.com>
 <CALOAHbD-npQmchiRJpGvOBVOM-Li6oRyMnKAjgiHq3DasiXMUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbD-npQmchiRJpGvOBVOM-Li6oRyMnKAjgiHq3DasiXMUQ@mail.gmail.com>

On Sun 18-08-24 10:55:09, Yafang Shao wrote:
> On Sat, Aug 17, 2024 at 2:25 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > When users allocate memory with the __GFP_NOFAIL flag, they might
> > incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc.  This kind of
> > non-blockable __GFP_NOFAIL is not supported and is pointless.  If we
> > attempt and still fail to allocate memory for these users, we have two
> > choices:
> >
> >     1. We could busy-loop and hope that some other direct reclamation or
> >     kswapd rescues the current process. However, this is unreliable
> >     and could ultimately lead to hard or soft lockups,
> 
> That can occur even if we set both __GFP_NOFAIL and
> __GFP_DIRECT_RECLAIM, right?

No, it cannot! With __GFP_DIRECT_RECLAIM the allocator might take a long
time to satisfy the allocation but it will reclaim to get the memory, it
will sleep if necessary and it will will trigger OOM killer if there is
no other option. __GFP_DIRECT_RECLAIM is a completely different story
than without it which means _no_sleeping_ is allowed and therefore only
a busy loop waiting for the allocation to proceed is allowed.

> So, I don't believe the issue is related
> to setting __GFP_DIRECT_RECLAIM; rather, it stems from the flawed
> design of __GFP_NOFAIL itself.

Care to elaborate?
-- 
Michal Hocko
SUSE Labs
