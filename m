Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4004230BCB;
	Tue, 26 Aug 2025 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756246751; cv=none; b=QeL3Jux2yNd1/n+Uchz6MuajeBedk6Raq2dKob6ZvgnV3qHfP51klPMALUjhnv/d/oKLFAvXQ09/vG4cN2Ux4bTyfo7A2LUruvlUAIxKJ/kpCtrP+/XnZRxBZPy8L8Gi9A6Is98IKbvyQltQjzHnzpTctLtE4z0+gjqa8Nv1anQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756246751; c=relaxed/simple;
	bh=dDASlBP0MFIq8lXobKcU0ACkjKAUEd5X5sCs3eQWVxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeNpZI9RwjL6Hbdkyzz4yEEc4b2+2FUPLgto0FFmOCmUffpYZSdQZfUNaDfyd5vxyeC2OsB5IdkaPmtJAcyVOGKgpJkfVli2ipyQnAVoRdTMIrotVZZmsMQG4FuAY0//YPQYBJIqp/Ksh9Cn7jP+Jt3nl8e2g80wN9F92zA4sOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EXd25FO/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EXd25FO/"
Received: by linux.microsoft.com (Postfix, from userid 1152)
	id 6C8812019D4D; Tue, 26 Aug 2025 15:19:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6C8812019D4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756246749;
	bh=8rtcCqNEwRzPi2I5Hkbq7ADSY01CvO5xXBkS7wksSvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EXd25FO/CTVn1QSOUQbXEMJ929gVepWWEUf8BzPGH1O47quoc3mUJI794aVUEr9uu
	 WdMwUuZ4w6tMKjQ0o4OYxTeRjLqYZSem40ZIsqBPVC7iGR5ZVMolKhSMwD/qaNeGiq
	 +pioNVkMiMZzPQAY70cl2TtQL6bM+1BVZxhP+Tx4=
Date: Tue, 26 Aug 2025 15:19:09 -0700
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: thierry.reding@gmail.com, robin.murphy@arm.com, robh@kernel.org,
	jroedel@suse.de
Cc: jgg@ziepe.ca, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, will@kernel.org,
	jacob.pan@linux.microsoft.com, eric.auger@redhat.com,
	code@tyhicks.com, eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com, bboscaccy@linux.microsoft.com,
	saravanak@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	lizhi.hou@amd.com, clement.leger@bootlin.com
Subject: Re: [PATCH v3 2/3] iommu/of: fix device tree configuration for PCI
 devices
Message-ID: <20250826221909.GA3227@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250806215539.1240561-1-shyamsaini@linux.microsoft.com>
 <20250806215539.1240561-3-shyamsaini@linux.microsoft.com>
 <20250808121515.GE377696@ziepe.ca>
 <20250814233018.GA31418@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250815003958.GE599331@ziepe.ca>
 <20250815023236.GA30997@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250818155310.GG599331@ziepe.ca>
 <20250826011557.GA2980@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250826123653.GC1899851@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250826123653.GC1899851@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Thiery, Rob, Robin, and Joerg,

On 26 Aug 2025 09:36, Jason Gunthorpe wrote:
> On Mon, Aug 25, 2025 at 06:15:57PM -0700, Shyam Saini wrote:
> > Hi Jason,
> > 
> > On Mon, Aug 18, 2025 at 12:53:10PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Aug 14, 2025 at 07:32:36PM -0700, Shyam Saini wrote:
> > > > On Thu, Aug 14, 2025 at 09:39:58PM -0300, Jason Gunthorpe wrote:
> > > > > On Thu, Aug 14, 2025 at 04:30:18PM -0700, Shyam Saini wrote:
> > > > > > or were you referring to [2]?
> > > > > > 
> > > > > > In that case, the PCI child node data needs to be parsed, which is
> > > > > > currently handled individually by each host controller driver.
> > > > > 
> > > > > Yes, this looks like it may be what I was thinking of, the pci@1,0
> > > > > specifes the BDF effectively
> > > > 
> > > > In that case, we'll need to parse the child DTS nodes properly
> > > > within of_iommu_get_resv_regions(). I'll include this in v4.
> > > 
> > > Kinda surprised this isn't happening already? It would be good to
> > > refer to the original specs and describe how whatetever you propose is
> > > aligned there.
> > 
> > Just to confirm, does the v3 version of this series look good to you?
> > If so, I’ll go ahead and respin the series with the iommu_set_sw_msi()
> > change and address the other review comments from Jacob.
> > 
> > Otherwise having pci devices nodes in the fdt or dts needs additional
> > handling, let me know your preference :)
> 
> I think you need to consult with the DT/OF owners on these questions..
> 
> I've forgotton so many of the details here.
> 
> But once you settle on whatever the DT representation is it looks like
> the right direction to me.
> 

The of_iommu driver currently does not correctly handle parsing
of the memory-region property for individual PCI devices. This
patch addresses the issue by explicitly setting dev->of_node for
PCI devices, enabling proper parsing of the memory-region property
within of_iommu_get_resv_regions().

Could you please share your feedback on this fix?

Thanks,
Shyam
