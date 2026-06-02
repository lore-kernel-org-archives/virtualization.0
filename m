Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142A737B015;
	Tue,  2 Jun 2026 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780396134; cv=none; b=PFrS+onZXc4DQa0x7Vrdrpzx+h31h406q8oW05vDeCEOADBIq+3TnhVvUUJp9bzbNQ46kA+DujmLJ0aTtVfX6+DMsN9lHwlEAXzV37Vp9I1kLoMpOMNIfY2BneCPGG7kSGi4zjVHOztdJpqXsVWAe/LgPEVJZ7ImnadnQhsklfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780396134; c=relaxed/simple;
	bh=yVCVsDkjiwpFvcKF2h0WDhoRqNKw2c3p+cEvLgi8kcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRXa6lc8SrO86KnDaF75gUVsNyvWqeCxIH+4uQcyW686NgWl/WaRn7a/48UPbPkkA/p0J4l8W8cSYHq7s8Vo6MTNnBgKpWZfiARUy4vBjAnU9Q1vjvnC7+EWcrfTn5Cp487Amu2KwyTM9ueYreMP2l+b9Wi4JAkQdWvgKDmQ+Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmoK7cJm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmoK7cJm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1091F00893;
	Tue,  2 Jun 2026 10:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780396132;
	bh=yuY1GULwIJ0+/SB8iNooxI6krh59LZina9UwI7KXrOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CmoK7cJmMUUcfAFhfMQguxkKalyra1Zz/3XCaXeBr9BuS6be4lt8O4V9OuuloneqL
	 eKM8uZvj1vOrjxt0DwHwH4TjLNUt6ssCdTgzo7JY+iO8iSM8qIfmo9OUODr6Hd1+RM
	 A+o0Dl5Gu94V46plhV0Z1ezOCHaZvQ21ScqDsW9dXxhd1yRbOsLOgddlVO5wyDP0+u
	 D5gvFihijo2xP+71fjjNrAxhyXqCyGasP6dO0SAyimVZlq/IaDTGZywEJMYYO3aJej
	 2VwV5yFLOsuwChpvvMGxpuMN8pZTsNCAbONfup81x2+2kCFuNMCxYxGWHXNGgTOHOB
	 w2ZNsWMv342Kw==
Date: Tue, 2 Jun 2026 11:28:48 +0100
From: Will Deacon <will@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: joro@8bytes.org, robin.murphy@arm.com, jpb@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: iommu: iterator used after loop end in resv region insertion?
Message-ID: <ah6wYJM4g-GTBTCL@willie-the-truck>
References: <CAHPEe=G-FZvEXjkE+vAXN5MHXCtsOaUoKwg2RQL6m=om+c20hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHPEe=G-FZvEXjkE+vAXN5MHXCtsOaUoKwg2RQL6m=om+c20hQ@mail.gmail.com>

On Tue, May 19, 2026 at 02:49:58AM +0800, Maoyi Xie wrote:
> Hi all,
> 
> While reading drivers/iommu/ I noticed two places that look
> like a past the end iterator pattern. I would appreciate it
> if you could take a look and let me know whether these are
> real issues and whether they are worth fixing.
> 
> The first is iommu_insert_resv_region() in drivers/iommu/iommu.c
> (linux-7.1-rc1, around line 873):
> 
>     list_for_each_entry(iter, regions, list) {
>             if (nr->start < iter->start ||
>                 (nr->start == iter->start && nr->type <= iter->type))
>                     break;
>     }
>     list_add_tail(&nr->list, &iter->list);
> 
> The second is viommu_add_resv_mem() in drivers/iommu/virtio-iommu.c
> (linux-7.1-rc1, around line 523):
> 
>     list_for_each_entry(next, &vdev->resv_regions, list) {
>             if (next->start > region->start)
>                     break;
>     }
>     list_add_tail(&region->list, &next->list);
> 
> In both cases, when the loop walks all entries without break,
> the iterator has gone one step past the last entry. &iter->list
> then aliases the list head via container_of offset cancellation,
> so the insert lands at the list tail. That is the intended
> behaviour, but the access is undefined per C11.
> 
> Jakob Koschel cleaned up many such sites in 2022, for example
> commits 99d8ae4ec8a (tracing: Remove usage of list iterator
> variable after the loop), 2966a9918df (clockevents: Use dedicated
> list iterator variable) and dc1acd5c946 (dlm: replace usage of
> found with dedicated list iterator variable). These two sites
> in drivers/iommu/ were not covered.
> 
> A candidate fix would track an explicit insert_before pointer
> initialised to the list head and overwritten to &iter->list
> only when the loop breaks early. The observable behaviour is
> unchanged.
> 
> If this is intentional or already known, please disregard.
> Otherwise, I am happy to send a [PATCH] or to leave the fix to
> you. Thank you for your time, and sorry for the noise if this
> is not actually worth fixing or has already been spotted.

Given that there's some precedent for "fixing" these type of things,
it's probably best if you just send some patches for these new instances
if you don't mind.

Cheers,

Will
