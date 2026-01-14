Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181662F3621
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411671; cv=none; b=cVqvDtPkmXz4jg/VeLiS6eM3sKZrs2qVUAT+5cZzUiQfPwJs5IEn+vitqoH+R0R0rEyk6LR7YHnrnSCKwsrM6mpZUPpLA3G0VIlHQFPV3s8q9fdZTT4v2TTFIeGEE3ChJ2VVR8PeERVxSWACEmsfWGgovoPQMlL4IxqS1LOEuuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411671; c=relaxed/simple;
	bh=BqCvlqSVSE09C2/snd3R+i7XS2A8CrQ1CJT3b7m8rA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1qjy+au1eLVzrUrAxhZ3ftGFBTM7jUZu8OI0aGn2/yzScIhLt7mzmSZNu0h94ZLCH9+KW4Bx8VfTeoi/LbehInHChJex5MDL358G4lQgaJ8SKB72A+Kg2DNnHV81tUBxJWZp+5TjWPF/u/gy5isaq/rlmcUrHcd5kGpnli6eHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cz2iWRN2; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cz2iWRN2"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8887f43b224so144142416d6.1
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 09:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768411669; x=1769016469; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U4FdywhLVayjs/og8ka5nlrVNCvxPIqbw9riK1WrSno=;
        b=cz2iWRN2Cgftt1m4UShmW/new87Q9pJzsHAsCh9b5LpX06uJhVYrlx7MeKTxBDBK07
         C9Mv7GlwvmpfMIu9SoFr2XMDRExhXVBPtxQgQzg4hhccHzInyq5PGOszWY11v8ZU4HuF
         w7qoIeCW/oEVczlc4DkCJsGBOUKiXzMkTHPQwZ2/EYboHc1PdSdGqUOm2Tup7iWG4rYc
         vVrHnPokMkwhAAVF5ZFpxbEeh4m6llYIQYMxUH8imhtvQ+NaUrKz1eQ51zCc6tceDXfq
         l7Kl+lV6Ad8PFbOpbdM5xYS3nftfDPEpql1THgBAyPgZgTaDp3QQS8JurzJ9Rgdqf1Yj
         bXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768411669; x=1769016469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4FdywhLVayjs/og8ka5nlrVNCvxPIqbw9riK1WrSno=;
        b=WiR4xC3+lgmn9K0n2AFPcd3UwzciDlITRKmxM9N5atEeVz67ewHUCZvgLRlGJq7XJf
         lMhmrbB/+RQYzBMACnS6Dphu92l2GifbQolGng+MMAK417H0jcOrVe7GkH23NULlX/wP
         BImZOUZgfGFno3nL/BGjTnqg6C8K2dkhFVUNC1mKwNFmcdDSjq+A+YmIO1c8X7b1/WuL
         SKrEwsT6l5SxL+xvA6VEqVz4WwDjOJJRp3uEmJ3foan0po8JfwCQEVkzlVY4SsJbVlJo
         2OVMjQSPckqohPGcicuGEaZhyBi+CwJaiA/CtSgAWjGypgnt9JMTCUfI54kZ8hFkt9ZW
         tUtg==
X-Forwarded-Encrypted: i=1; AJvYcCWdbzIFs9kjk0oyp6Op6zuv3ZQ0W3xuLsrhC+/MqB2CZM1UQNgO2wKAohbkKaynzzUxtlj80PYbyKCNtJ29BA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXQVBuZlLXc0cX8Cn2lHYLW/V5qEbZVAkegQOp+NaMYtmDHgDi
	UrBNkwxm89DUZeoQtVCFQiG0B6ykR8kCzM3LgIofBCRXVghIm4xpU+4yf2/vlJ0+pAY=
X-Gm-Gg: AY/fxX6T+6FxrrVcM7Zjp6e2m8o1tXQFth6jbjJN5BjKwHYFzLyimgF/aeqMccY/rpF
	+HpQ84vPJfXopFA3jTNl2qj2bXB8nsJ5Bdjkd9fEa5zcBjp9sB3uZDibMlDOBpNU1Qi1O1euGo/
	z6XH161cMxL3Zay9nOgDMGv4FSoJbjnh8arBdEpr31WEoZCvYtIzw9b9dafh13dDcNo1AWemU4g
	ZfbuKkEQyK8eNDTu/5niQszzL590jB73xuL0ajmBjRehDlu71yYkFm50kc2Y4lNGNQXrAIc73qc
	D/1Qw0nJ/lmPyzDwAu12oLQ6CR9sC1LuFhNY+diqUaHIehFoNsHsQuLE8/TJ+QoPsLTxM+Y4YaE
	aDPn9dkdE8DKM0wpZyLyczbo+vtivnzLywkMkp2nq1Gab/VELBiCOjXWuycN6Jx/UHXNbEPoHlD
	AvffSozDd8MK6BHlivzi9269/QFnJd2AXiqP4x2mQc1j4502HquD5mf7mENyGKxZ74mmJboA==
X-Received: by 2002:a05:622a:14cb:b0:4ee:1f22:3615 with SMTP id d75a77b69052e-5014827ba2dmr51922171cf.51.1768411668907;
        Wed, 14 Jan 2026 09:27:48 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148dd75d4sm18287131cf.2.2026.01.14.09.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:27:48 -0800 (PST)
Date: Wed, 14 Jan 2026 12:27:15 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH 3/8] mm/memory_hotplug: add APIs for explicit online type
 control
Message-ID: <aWfR86RIKEvyZsh6@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-4-gourry@gourry.net>
 <b3d435d2-643f-4dad-9928-bc7fb5080181@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3d435d2-643f-4dad-9928-bc7fb5080181@kernel.org>

On Wed, Jan 14, 2026 at 11:21:34AM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/14/26 09:51, Gregory Price wrote:
> > Add new memory hotplug APIs that allow callers to explicitly control
> > the online type when adding or managing memory:
> > 
> >    - Extend add_memory_driver_managed() with an online_type parameter:
> >      Callers can now specify MMOP_ONLINE, MMOP_ONLINE_KERNEL, or
> >      MMOP_ONLINE_MOVABLE to online with that type, MMOP_OFFLINE to leave
> >      memory offline, or MMOP_SYSTEM_DEFAULT to use the system default
> >      policy. Update virtio_mem to pass MMOP_SYSTEM_DEFAULT to maintain
> >      existing behavior.
> 
> I wonder if we rather want to add a new interface
> (add_and_online_memory_driver_managed()) where we can restrict it to known
> kernel modules that do not violate user-space onlining policies.
> 

I originally did this, but then add_memory_driver_managed is just

__add_memory_driver_managed(..., MMOP_SYSTEM_DEFAULT)

at that point, just update all the existing callers of
add_memory_driver_managed(..., mhp_default_etc) and make it explicit in
those call spaces that this is what's happening.

> For dax we know that user space will define the policy.
> 

Actually this may not always be true.  A driver spawning a dax on probe
might also end up selecting the policy... eventually... maybe... I might
be planning to add that glue between CXL and DAX so I can add some
config similar to the system-default policy to avoid systems with
multiple memory-devices being forced into the same policy

(e.g. CXL memory device can online auto in ZONE_MOVABLE, but the other
 device can have its own policy).

There's a weird corner case for CXL auto-regions (BIOS configured
everything but left the memory EFI_MEMORY_SP - so comes up as DAX).
I'm trying to keep those systems working the same as they have been
while the userland policy stuff catches up.  Early CXL patterns are :[

> > 
> >    - online_memory_range(): online a previously-added memory range with
> >      a specified online type (MMOP_ONLINE, MMOP_ONLINE_KERNEL, or
> >      MMOP_ONLINE_MOVABLE). Validates that the type is valid for onlining.
> 
> Why not simply online_memory() and offline_memory() ?
> 

stupidly: I thought online_memory existed lol, ack.

> > 
> >    - offline_memory(): offline a memory range without removing it. This
> >      is a wrapper around the internal __offline_memory() that handles
> >      locking. Useful for drivers that want to offline memory blocks
> >      before performing other operations.
> > 
> 
> These two should be not exported to arbitrary kernel modules. Use
> EXPORT_SYMBOL_FOR_MODULES() if required, or do not export them at all.
> 

hm, not sure i understand this.  Maybe you address their usage later in
dax_kmem_do_online and dax_kmem_do_offline, i'll come back around on
this.

I did see you were asking about why we need the offline state.  I'll
come back to it there.

> > diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> > index d5407264d72a..0f98bea6da65 100644
> > --- a/include/linux/memory_hotplug.h
> > +++ b/include/linux/memory_hotplug.h
> > @@ -265,6 +265,7 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
> >   extern void try_offline_node(int nid);
> >   extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
> >   			 struct zone *zone, struct memory_group *group);
> > +extern int offline_memory(u64 start, u64 size);
> 
> No new "extern" for functions.
> 

doh, habit matching surrounding code

> > index ab73c8fcc0f1..515ff9d18039 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1343,6 +1343,34 @@ static int online_memory_block(struct memory_block *mem, void *arg)
> >   	return device_online(&mem->dev);
> >   }
> > +/**
> > + * online_memory_range - online memory blocks in a range
> > + * @start: physical start address of memory region
> > + * @size: size of memory region
> > + * @online_type: MMOP_ONLINE, MMOP_ONLINE_KERNEL, or MMOP_ONLINE_MOVABLE
> 
> I wonder if we instead want something that consumes all parameters like
> 
> int online_or_offline_memory(int online_type)
> 
> Then it's easier to use and we don't really have to document the
> "online_type" that much to hand-select some values.
> 
> (I'm sure there are better nameing suggestions :) )
> 

mhp_do_the_thing(int online_type) :P

I can think about this.

> Should we document what happens if the memory is already online, but was
> onlined to a different zone?
> 

Yeah i'll do that, it should just refuse, since that's what dax does.

> > + *
> > + * @online_type specifies the online behavior: MMOP_ONLINE, MMOP_ONLINE_KERNEL,
> > + * MMOP_ONLINE_MOVABLE to online with that type, MMOP_OFFLINE to leave offline,
> > + * or MMOP_SYSTEM_DEFAULT to use the system default policy.
> > + *
> 
> I think we can simplify this documentation. Especially, one
> MMOP_SYSTEM_DEFAULT is gone.
>

ack

> > +/*
> > + * Try to offline a memory range. Might take a long time to finish in case
> > + * memory is still in use. In case of failure, already offlined memory blocks
> > + * will be re-onlined.
> > + */
> 
> Proper kerneldoc? :)
>

ack

~Gregory
