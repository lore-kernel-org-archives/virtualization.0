Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41342F6189;
	Fri, 19 Sep 2025 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267210; cv=none; b=cZSXCOS79ZKkx87WEPk+zdXUmDEe0uGmAM1996o5opdnkTNn+51yEOlKbG241IcW3VgLSfMUeI5PoNrTzngcPUyGphJHEhHWLhdVklKX5mYSk/4kgT5mOCL2jHADGULPXAX1gTjqckQOpJQ3ytM+u/q/y3caUmMhgCHTCoLigwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267210; c=relaxed/simple;
	bh=Lx33AaBsxDOHxkZEXjvlDKiPRuXKJF1OzxalkYoJ7Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZOn7YBWzXWIUVg/IWphl4TJv0vfHMA+yuL81CV+PgdDl6OLQaHVAKPxWXfvPk3QRAEX8mWmMc7eyZ0b72ABEZP29UKT/qPEiOZlH87v3EFTAp6VfmhQzjP9kyTFyLjjC5+1OvLwJkxC27C3TpSWQ/myGV5NxCgDhM/hPC6AqaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnIayxU4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnIayxU4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88238C4CEF0;
	Fri, 19 Sep 2025 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758267210;
	bh=Lx33AaBsxDOHxkZEXjvlDKiPRuXKJF1OzxalkYoJ7Cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OnIayxU4R21x2fQ71+36zLb/cyb1S39xVraWvMNWx5ASXXzFBQYBeWskMMSM1LUYs
	 L3Df5/Tnk9zFsvYVhBRqhVue/HNMc0lX08e0aiJYwDDd/n3NAV0ycbyUApu0a2aQLq
	 vBxGTZ1w1gg8s1Tetdb7nsPFCtHsIi1dCqUnvAl29N4//QZBRFgPUZyT6mH/6Cb5nF
	 RuoiPGKL1l1nCwczm4Po6lA83cjt+yFnWioHNE5lBNL2ZpihKUPffSijkvVcxFP0wt
	 ySoN86uYo4D82No4xfpvCBhxNJZMNRyRi6aZVmzdidrmEoT6JRIb7AurVY0Yg8SdCA
	 tNGhAR4uNLHlA==
Date: Fri, 19 Sep 2025 08:33:23 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>, thierry.reding@gmail.com,
	robin.murphy@arm.com, robh@kernel.org, joro@8bytes.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	jacob.pan@linux.microsoft.com, eric.auger@redhat.com,
	code@tyhicks.com, eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com, bboscaccy@linux.microsoft.com,
	saravanak@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	lizhi.hou@amd.com, clement.leger@bootlin.com
Subject: Re: [PATCH v4 3/4] arm-smmu: select suitable MSI IOVA
Message-ID: <aM0HQ51DelZW_Rt8@willie-the-truck>
References: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
 <20250909154600.910110-4-shyamsaini@linux.microsoft.com>
 <aMw4I0AjKNPY6SOw@willie-the-truck>
 <20250918224322.GR1326709@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918224322.GR1326709@ziepe.ca>

On Thu, Sep 18, 2025 at 07:43:22PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 18, 2025 at 05:49:39PM +0100, Will Deacon wrote:
> > Given that we're walking over the reserved regions to see if we have a
> > collision with MSI_IOVA_BASE, why not allocate the base address
> > dynamically if we detect a collision rather than having yet another
> > hard-coded address which we can't guarantee won't be problematic in future?
> 
> I'm nervous about this. Right now the  MSI_IOVA is actually UAPI and
> things like VFIO/qmeu need to accomodate it's placement in their own
> memory maps.

*shrug*

That's only the case for broken systems where the existing MSI_IOVA
can't be made to work. As far as I'm concerned, they get to keep the
pieces and will need to work on the userspace side. It's not like
MSI_IOVA2 is magically going to work (and I bet it won't be tested).

> Nicolin has some patches on the iommufd side to let userspace select
> the MSI address instead, but they are not done yet.

Maybe we should just wait for that? Carrying a temporary hack with ABI
implications to support broken hardware isn't particularly compelling
to me.

> So, randomly picking an address sounds like a bad idea to me, it would
> almost certainly unpredictably break qemu..

It's not really "random", in the sense that it would be deterministic
for a given set of reserved regions.

Will
