Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC3426A0DD;
	Tue, 23 Sep 2025 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643014; cv=none; b=PPWqr+bMF6mHND2pQdH6XFxAhWvY9N3hlT4vkLAUxqy8dttawnlYHkb+qzjI+vN0aCBgntMn1HRvy45zdtFaLTlF3CoHfn/iJqVIXYbw4E8GAkZce8QPT1TvBj50jK4VQf0sOteqoVW/fzQRWgsMhDP79QnKSwEbUXP1R5bs4EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643014; c=relaxed/simple;
	bh=pdqBZomuWzF2E2Gt4ZnTRDvbQ1JFQQm8XXayTiLLzPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjvfEvviHSdaFLnO8cnDgu7WHmtyF+a7mSQT71F0aYnT1NqckhySBieEcl2W0q+gBbtaY7Tcf+K33fGmVLgIvD84BQQlcX0IbL4KBOkY+EohtrVl7eB4fscpGM3qSYEVNFSL87V+atMilXuHFPmFrQGfvFm/eAwhsN923Nhk8dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=d6d07kjy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d6d07kjy"
Received: by linux.microsoft.com (Postfix, from userid 1152)
	id 9BA8B2015510; Tue, 23 Sep 2025 08:56:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9BA8B2015510
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758643007;
	bh=JW6Pq0osddemYt/bdOCpAcfjllFX2GB9kYb3rxjKU1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d6d07kjygCRywb698zp2lefj4VDV404AV36O9xh5AE+1GNG0a2jt/0hpzLu8QJQcL
	 ECN8IvpEiBbc7+D9RGPJsYTiQoEkMb8od7hrQWMMJzQRvlsSxnai4rFnr+3usp0m4Y
	 ZbxEKaGcTAem4frcTuE0FBtJbFhV335EYU3Zfcfk=
Date: Tue, 23 Sep 2025 08:56:47 -0700
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Will Deacon <will@kernel.org>
Cc: thierry.reding@gmail.com, robin.murphy@arm.com, robh@kernel.org,
	joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com,
	bboscaccy@linux.microsoft.com, saravanak@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, lizhi.hou@amd.com,
	clement.leger@bootlin.com
Subject: Re: [PATCH v4 3/4] arm-smmu: select suitable MSI IOVA
Message-ID: <20250923155647.GA22010@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
 <20250909154600.910110-4-shyamsaini@linux.microsoft.com>
 <aMw4I0AjKNPY6SOw@willie-the-truck>
 <20250918224322.GR1326709@ziepe.ca>
 <aM0HQ51DelZW_Rt8@willie-the-truck>
 <20250919120839.GV1326709@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919120839.GV1326709@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Jason, Will,

On 19 Sep 2025 09:08, Jason Gunthorpe wrote:
> On Fri, Sep 19, 2025 at 08:33:23AM +0100, Will Deacon wrote:
> > pieces and will need to work on the userspace side. It's not like
> > MSI_IOVA2 is magically going to work (and I bet it won't be tested).
> 
> It could, if someone checks the default memory map a second constant
> could be selected that works.
> 
> > > Nicolin has some patches on the iommufd side to let userspace select
> > > the MSI address instead, but they are not done yet.
> > 
> > Maybe we should just wait for that? Carrying a temporary hack with ABI
> > implications to support broken hardware isn't particularly compelling
> > to me.
> 
> This patch would still be needed for kernel users.
> 
> Arguably the kernel users should just be using the iova allocator from
> dma-iommu.c. This whole hard coded constant/sneaky uapi is just a hack
> to make vfio work..
> 
> So maybe if the single constant doesn't work we could set some
> indication that the caller must allocate the MSI iova, the kernel can
> use the dma-iommu allocator and VFIO can just refuse to use the device
> for now.

So, are we settling on having two predefined MSI IOVA base constants,
and if both of those conflict with reserved regions on a given platform,
falling back to dynamic allocation via the IOVA allocator? Just checking
if that's the consensus we're reaching.

Thanks,
Shyam
