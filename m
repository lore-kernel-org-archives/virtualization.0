Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C14276046
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411991; cv=none; b=G4qNiYeTa0sRRbNBAL1cTYyvT3QVWpZ8+5Tef2nJK671nhdVMLaQmupJbqvxhj8qwRW+UOmVgPvfVXv+fpwri+/e4AwO5ocGIgeuwVEkDZtXHhHIxqudspmpAv54/03781TpKpxiOKjaqcs+F7N1JGCLvu3laqvk8N36rwKROAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411991; c=relaxed/simple;
	bh=8O9PPhw4HJ1ghVcptQLNcB4UFjagJSyTGDFo/SN9nX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyIObixvY/0qkr+JHb25i0bltYoRmz2gAcIdvDvaWv+v3oXZ87y2CFJYgif7widNcxyDZMn0bySBeMgTmbgxMeA0FmXjsOCIJXEEaRMD7ZmJa/KkzX9Y9K9Ne/z6TTSNRAMAzp87GUNQirz7Q5f2VRukSX9PvI3PfG608zBqA9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QNcIv3cU; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QNcIv3cU"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c5386f1c9fso9712485a.1
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 09:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768411989; x=1769016789; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bCjYai9Len2QQEYBKyLKOlFSVdw2VqJPxFxPg7dhnMU=;
        b=QNcIv3cUeE+0QLsWEfGEwsWa4dVTYsM4X+PZUfYg65Q4yTIDZAHtqRCRY6Bvd/bdRk
         6Ew7U/8JrQgPuXXcgFWu9UOEsrCK9qVzbs3SgW2/LnyWEi2d0HGvXUtJE35o14/3qmuq
         J24wJOVveWNkAcxnpmhqduX7RvwC45k9enDvxNTpI+7DC0px7LSE6WitclAFjxK5LuVc
         tGdcdy8DGsMTmsRGpvbc6HQ7HQS6YYYrLlgUXZDlRWlbgEiUaxg/xtBnfiGj5m4kRRAF
         Ac98JUZZ3BfWXLg/x8wP5dIsT8Tqzc0698Icu/H86q8Qgz3BC9YZbR0NiqFoHJ4KL1wj
         gT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768411989; x=1769016789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCjYai9Len2QQEYBKyLKOlFSVdw2VqJPxFxPg7dhnMU=;
        b=cgXuQ7ScSqjBBV/CGqP0C3p/nDzp9TVa06o6/v1H6rSazqnxGpCWCg5Kc/5hc9HojK
         YayRY78B2Whj+u6lqEL7guEPIdnDz4ZkEs+5ogHkq64/gh1z8wnEL3NVa+ryJmGJD1fH
         viPj6qYN200MkqpL0Ej0Jvv6iR+1K8zQxAeqEW3n36SL3bMbBy002vusVt04t1rM+5vG
         VITxHPG66WzbYVxXVOE3y9YEegYAB5Sm+5hfq91qo0+drEgXs8vGkooU7nQOXo70UgkT
         KlpdRB4NBJnz+gj2xD8rWaLHX/gbq8xiWtSpEUqbAz7CrTZ1ebd0eRVUJdB3Mf+PdYU3
         6pQA==
X-Forwarded-Encrypted: i=1; AJvYcCUn+rsf0pG4ChgCyCVKJIiuN05sqwtQcePV8dsPJgeAa0O5H2un0mHgoqT86Wdm+0BEAGglMyQ/BAsjWHFcFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPNYaiwFzjcYhnuFPNaZjPIPNbFVANIdiejGKOvhZzJm/tidOS
	HtnXPYNNj2Pf3EuKTPrBkmsCxFWZsYZk+drjiIPH+ehJno7yDu3tSzas6L0JqW4d6a3gDgY/PiH
	djznUcCs=
X-Gm-Gg: AY/fxX49IvdVCDNQQ3Y9oD70kLiJXHPpithM4Svs6ag+YynVcKd8p3Ag/Ad49YNEQNN
	PPYHozGwWBwgAAyFDWOkj4ZAfc4tnqlfUzPTXuvYr1nn9oNmszxl3kJMdkeHpp15BA/TSVZ6IvC
	NJcfqDvhgIiNgi9TQZoyxUHa0i6KeZm2tDsgwZxRs1+QjdiRC34gxRC2pz4DwHRxnmd5NYK5iEa
	8bSdeghn044N4/rqt02LQIuVr1U04pSjXXLjhAbLoN8kXRYj+3HPF77reSImemgM3IRXG/98LyT
	GdTUQg0Xl0Kj9rnFlmuVV/vQ8QAMjKon/1BOfjMQBpYo6UrfxYYxbMgyC4ZUMX2AsedgHZW0ohV
	ByXs9IrN6PCrD/DVDO5S0ot2X+PVTWJKVW4fqc+B+b9ZbDg+lUgdHcufix1+s5rR1p45u65sQlk
	xptquvnsgHb0Fl3/GzGj6E62pt7eP/W17r4e3RPXY9hlhoR01wYx1AyQ+BfFJcvtzW5qSscw==
X-Received: by 2002:a05:620a:458b:b0:8b2:7290:27da with SMTP id af79cd13be357-8c52fafd245mr470291685a.12.1768411989233;
        Wed, 14 Jan 2026 09:33:09 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530b6e7d4sm198764985a.28.2026.01.14.09.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:33:08 -0800 (PST)
Date: Wed, 14 Jan 2026 12:32:36 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH 7/8] dax/kmem: add sysfs interface for runtime hotplug
 state control
Message-ID: <aWfTNGMqn7S3b9z9@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-8-gourry@gourry.net>
 <3555385d-23de-492c-8192-a991f91d4343@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3555385d-23de-492c-8192-a991f91d4343@kernel.org>

On Wed, Jan 14, 2026 at 11:55:21AM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/14/26 09:51, Gregory Price wrote:
> > The dax kmem driver currently onlines memory automatically during
> > probe using the system's default online policy but provides no way
> > to control or query the memory state at runtime. Users cannot change
> > the online type after probe, and there's no atomic way to offline and
> > remove memory blocks together.
> > 
> > Add a new 'hotplug' sysfs attribute that allows userspace to control
> > and query the memory state. The interface supports the following states:
> > 
> >    - "offline": memory is added but not online
> >    - "online": memory is online as normal system RAM
> >    - "online_movable": memory is online in ZONE_MOVABLE
> >    - "unplug": memory is offlined and removed
> > 
> > The initial state after probe uses MMOP_SYSTEM_DEFAULT to preserve
> > backwards compatibility - existing systems with auto-online policies
> > will continue to work as before.
> > 
> > The state machine enforces valid transitions:
> >    - From offline: can transition to online, online_movable, or unplug
> >    - From online/online_movable: can transition to offline or unplug
> >    - Cannot switch directly between online and online_movable
> 
> Do we have to support these transitions right from the start?
> 
> What are the use cases for adding memory as offline and then onlining it,
> and why do we have to support that through this interface?
>

the default build config does this, so anyone using the SYSTEM_DEFAULT
will have to at least support this unless we want to change peoples
existing systems.  They'll expect to use the existing pattern.

That is:

add_memory_driver_managed(, SYSTEM_DEFAULT) -> offline
echo online[_*] -> memory*/state

If we disallow "offline", then we essentially leave it "unplugged" and
the second line (existing user policy) breaks.

I thought this would be considered "breaking userland".

I could see disallow "offline" if the memory is "online", and just force
"unplug".

> It would be a lot simpler if we would only allow
> 
> >    - "offline": memory is added but not online
> >    - "online": memory is online as normal system RAM
> >    - "online_movable": memory is online in ZONE_MOVABLE
> >    - "unplug": memory is offlined and removed
> 
> That is, transitioning from offline to online or vice versa fails with
> -ENOSUPP. User space can do that itself through sysfs and if there is ever a
> good use case we can extend this interface here to allow it.
> 
> Or is there a good use case that really requires this?
> 

There's no good use case, just existing users and expected behavior.

~Gregory
