Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A290830AAA6
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262360; cv=none; b=JA90DPM4nvLGQe2stu8wP93tSIRz3EcdqyXj+oP5nlwxBELn4Ll+gYDn5kHkwYl3Fqex+G+RXD/POIUVdwvJnIl47A5iFuQC6JYCRgHXjrxq85nphZlIqVO82R4aQD+/NFDJllh+D4BQ9bFonKtLL2kEwrN55CYssQytHSHa2Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262360; c=relaxed/simple;
	bh=WUcogBBt+16hysVoKsG03e39lN/2nfwARuSyMv7QoWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKTEfqY0Ty/MbSBUova2RxdMe+5YGyILxuZYluJHwEjDgbHWkLoDoMYAw4+V0rpcCdDIl0/GklF/bjAQAkMTZxlBfC5HbWtR3YL+n0VcBS6GUJ/iEF8XwcZRNKOt7dbLcS8honfP7ZovstDJw2Zit2Qba+wXP5l5ksFvSBhyX1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=RuYEtw4p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jrggMLCq; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="RuYEtw4p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jrggMLCq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F29D81400106;
	Fri,  8 May 2026 13:45:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 08 May 2026 13:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778262356;
	 x=1778348756; bh=BzQpbfj2gB2hq1kMTUl7hUBczCfNpeCyjSIC66D0Crc=; b=
	RuYEtw4p3+iPQqwaGpOp1bKL8lSK4PLE6ZfW1yepdy0REMuCtGrpkk23imO61Zll
	wHwKQFubiaZkC2EfsWyWXzlURRpb6+9a8LzDv5cyIljCCI7XszSpa36KtcyHktjm
	BhtUnW7qtLXfAde8q3IXKIvVi3k7kZdVHrtsLcThn/J4pq8YLpCC/SuBfwkSXNyg
	oaANG93BvYhurczW+OoMUEtGzWGImNZ3OJkNfTvbESoucdxlhFSDo5LSn9OM4Nau
	rZ+YANsZTG3+t0SgrpW9Ihw62ysA+vE9ejYRoBonC6P2TiRA5l9FckgEoQJrK6wM
	wYNJA0s1JICLpd0b9l2bMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778262356; x=
	1778348756; bh=BzQpbfj2gB2hq1kMTUl7hUBczCfNpeCyjSIC66D0Crc=; b=j
	rggMLCqABQXTA4Xu+PVcwzI+hS9E27NAJFUEyDGU9UN/onj2q4fIhhmUlA41A90C
	hGSzYY9toRrxI8TbyFY8w2G5xOCLJEMmiunQHrpGy8CumzR45gcYhri+ub4cSgyc
	ZaLfDist1/2k88s8HgCuPVDm5dzNR0Aa/5g/aR064NvUWMA82GmLxTgQqjEA29RT
	gyCbHSOdARwJAJGE/P9NafcddscdLTc5Vs2+W5ZbByr9KomWCWT6By2L1enlsT1F
	Ob43BWeTe4w3reVRAHQCRYOA7aPXmhgDRR+lCq+oiNr/c5w1BeGDUhL5t88MBoGj
	jILyavthdJsfNgb7VhiAg==
X-ME-Sender: <xms:UyH-aTa1ruE-f_oxE9yDQyU9OeP5tRAXkecNMOWkTzrqUlqkzILFTA>
    <xme:UyH-acpeufwrO57GDCPPumhwH4kOapF6N_stR27q5f7FOyzyrU3HXFh_ukwq0k9dv
    RcNQatHMPuuc29L9FNK4Ar6ZgUqXH6E7jIqSH3EQfM8RRP7pYuy>
X-ME-Received: <xmr:UyH-abZzd1FADE5GNMbNN-9kuk0B5HoV1H2eNsfLDxiDqBAgBjTW2BICGqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddtleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepudekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmrghtthgvvhesmhgvthgrrdgtohhmpdhrtghpth
    htohepkhgvvhhinhdrthhirghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepjhhgghes
    iihivghpvgdrtggrpdhrtghpthhtoheprghnkhhithgrsehnvhhiughirgdrtghomhdprh
    gtphhtthhopegrphhophhplhgvsehnvhhiughirgdrtghomhdprhgtphhtthhopehlvgho
    nheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehskhholhhothhhuhhmthhhohesnhhvihguihgrrdgtohhmpdhrtghp
    thhtohephihishhhrghihhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:UyH-af7nOMyxkdGlWWReCP_TYbyKMIUAE1xeJI4b5RBEzs-dABt8KQ>
    <xmx:UyH-aWSS65j0c7jBuCCMfQkWQmLO8t0Y338i5Y4-3Loh_r5sV6wZhw>
    <xmx:UyH-afvruQn0LMwhN3o0jH9HOeHJiO2u1wZD5kenA_X3J8MCgvnVHA>
    <xmx:UyH-aYayh2c780BvlSPshIwXYUxrRkKjZ7WmREj60dooA7wuY3fk-Q>
    <xmx:VCH-aY3fA63EJXNXgPxcuZmpNHZKdHF2H-qYvAfoGN6ihPteuP1BTlAe>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 13:45:53 -0400 (EDT)
Date: Fri, 8 May 2026 11:45:52 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <mattev@meta.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Ankit
 Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Kees Cook <kees@kernel.org>, Shameer Kolothum
 <skolothumtho@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Alexey
 Kardashevskiy <aik@ozlabs.ru>, Eric Auger <eric.auger@redhat.com>, Peter Xu
 <peterx@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, Zhi Wang
 <zhiw@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, alex@shazbot.org
Subject: Re: [PATCH v4 3/3] vfio/pci: Replace vfio_pci_core_setup_barmap()
 with vfio_pci_core_get_iomap()
Message-ID: <20260508114552.6f5b99f0@shazbot.org>
In-Reply-To: <015b1e9c-0a2d-472a-b750-9154800832ee@meta.com>
References: <20260505173835.2324179-1-mattev@meta.com>
	<20260505173835.2324179-4-mattev@meta.com>
	<20260507162141.072483ce@shazbot.org>
	<015b1e9c-0a2d-472a-b750-9154800832ee@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 May 2026 16:30:40 +0100
Matt Evans <mattev@meta.com> wrote:

> Hi Alex,
> 
> On 07/05/2026 23:21, Alex Williamson wrote:
> > 
> > On Tue, 5 May 2026 10:38:31 -0700
> > Matt Evans <mattev@meta.com> wrote:
> >   
> >> Since "vfio/pci: Set up barmap in vfio_pci_core_enable()", the
> >> resource request and iomap for the BARs was performed early, and
> >> vfio_pci_core_setup_barmap() just checks those actions succeeded.
> >>
> >> Move this logic to a new helper that checks success and returns the
> >> iomap address, replacing the various bare vdev->barmap[] lookups.
> >> This maintains the error behaviour of the previous on-demand
> >> vfio_pci_core_setup_barmap() scheme.
> >>
> >> Signed-off-by: Matt Evans <mattev@meta.com>
> >> ---
> >>   drivers/vfio/pci/nvgrace-gpu/main.c | 11 ++++-------
> >>   drivers/vfio/pci/vfio_pci_core.c    | 11 +++++------
> >>   drivers/vfio/pci/vfio_pci_dmabuf.c  |  2 +-
> >>   drivers/vfio/pci/vfio_pci_rdwr.c    | 30 ++++++++---------------------
> >>   drivers/vfio/pci/virtio/legacy_io.c | 13 ++++++-------
> >>   include/linux/vfio_pci_core.h       | 20 ++++++++++++++++++-
> >>   6 files changed, 43 insertions(+), 44 deletions(-)
> >>
> >> diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
> >> index fa056b69f899..e153002258ce 100644
> >> --- a/drivers/vfio/pci/nvgrace-gpu/main.c
> >> +++ b/drivers/vfio/pci/nvgrace-gpu/main.c
> >> @@ -184,13 +184,10 @@ static int nvgrace_gpu_open_device(struct vfio_device *core_vdev)
> >>   
> >>   	/*
> >>   	 * GPU readiness is checked by reading the BAR0 registers.
> >> -	 *
> >> -	 * ioremap BAR0 to ensure that the BAR0 mapping is present before
> >> -	 * register reads on first fault before establishing any GPU
> >> -	 * memory mapping.
> >> +	 * The BAR map was just set up by vfio_pci_core_enable(), so
> >> +	 * check that was successful and bail early if not:
> >>   	 */
> >> -	ret = vfio_pci_core_setup_barmap(vdev, 0);
> >> -	if (ret)
> >> +	if (IS_ERR(vfio_pci_core_get_iomap(vdev, 0)))
> >>   		goto error_exit;  
> > 
> > Sashiko notes we're not setting ret here.  The bots are also paranoid
> > about the unreachable condition that the get_iomap below could return an
> > ERR_PTR.  Maybe head off both by adding an __iomem pointer to the
> > nvgrace_gpu_pci_core_device struct and a temporary one here.  Store the
> > iomap in the temporary variable, use it to test for IS_ERR() and
> > PTR_ERR(), then set the pointer in the structure after the last error
> > condition here.  Add one line in the close_device to set it NULL.  Then
> > just use nvdev->bar0_io below.  
> 
> Right about ret.  On the 2nd, the bots could benefit from a comment on
> the ...get_iomap() below saying that it "cannot fail" if this one
> passes, but hey.  I can add a struct member to track it (bots can then
> worry that it might be NULL, if they don't notice that
> nvgrace_gpu_check_device_ready() can't happen if
> nvgrace_gpu_open_device() didn't succeed, etc. etc.).

While I agree that there's always something that can be overlooked, it
does seem semantically cleaner that the io is tested when it's
retrieved for the driver structure and used from that structure in a
fixed lifecycle than retrieved without testing the results at time of
use.
 
> >>   
> >>   	if (nvdev->resmem.memlength) {
> >> @@ -275,7 +272,7 @@ nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
> >>   	if (!__vfio_pci_memory_enabled(vdev))
> >>   		return -EIO;
> >>   
> >> -	ret = nvgrace_gpu_wait_device_ready(vdev->barmap[0]);
> >> +	ret = nvgrace_gpu_wait_device_ready(vfio_pci_core_get_iomap(vdev, 0));
> >>   	if (ret)
> >>   		return ret;
> >>   
> >> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> >> index 62931dc381d8..5c8bd13f10d0 100644
> >> --- a/drivers/vfio/pci/vfio_pci_core.c
> >> +++ b/drivers/vfio/pci/vfio_pci_core.c
> >> @@ -1761,7 +1761,7 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
> >>   	struct pci_dev *pdev = vdev->pdev;
> >>   	unsigned int index;
> >>   	u64 phys_len, req_len, pgoff, req_start;
> >> -	int ret;
> >> +	void __iomem *bar_io;
> >>   
> >>   	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
> >>   
> >> @@ -1795,12 +1795,11 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
> >>   		return -EINVAL;
> >>   
> >>   	/*
> >> -	 * Even though we don't make use of the barmap for the mmap,
> >> -	 * we need to request the region and the barmap tracks that.
> >> +	 * Ensure the BAR resource region is reserved for use.
> >>   	 */
> >> -	ret = vfio_pci_core_setup_barmap(vdev, index);
> >> -	if (ret)
> >> -		return ret;
> >> +	bar_io = vfio_pci_core_get_iomap(vdev, index);
> >> +	if (IS_ERR(bar_io))
> >> +		return PTR_ERR(bar_io);
> >>   
> >>   	vma->vm_private_data = vdev;
> >>   	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> >> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> >> index 69a5c2d511e6..46cd44b22c9c 100644
> >> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> >> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> >> @@ -248,7 +248,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
> >>   	 * else.  Check that PCI resources have been claimed for it.
> >>   	 */
> >>   	if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX ||
> >> -	    vfio_pci_core_setup_barmap(vdev, get_dma_buf.region_index))
> >> +	    IS_ERR(vfio_pci_core_get_iomap(vdev, get_dma_buf.region_index)))
> >>   		return -ENODEV;
> >>   
> >>   	dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
> >> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> >> index 3bfbb879a005..7f14dd46de17 100644
> >> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> >> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> >> @@ -198,19 +198,6 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
> >>   }
> >>   EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
> >>   
> >> -/*
> >> - * The barmap is set up in vfio_pci_core_enable().  Callers use this
> >> - * function to check that the BAR resources are requested or that the
> >> - * pci_iomap() was done.
> >> - */
> >> -int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
> >> -{
> >> -	if (IS_ERR(vdev->barmap[bar]))
> >> -		return PTR_ERR(vdev->barmap[bar]);
> >> -	return 0;
> >> -}
> >> -EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);
> >> -
> >>   ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
> >>   			size_t count, loff_t *ppos, bool iswrite)
> >>   {
> >> @@ -262,13 +249,11 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
> >>   		 */
> >>   		max_width = VFIO_PCI_IO_WIDTH_4;
> >>   	} else {
> >> -		int ret = vfio_pci_core_setup_barmap(vdev, bar);
> >> -		if (ret) {
> >> -			done = ret;
> >> +		io = vfio_pci_core_get_iomap(vdev, bar);
> >> +		if (IS_ERR(io)) {
> >> +			done = PTR_ERR(io);
> >>   			goto out;
> >>   		}
> >> -
> >> -		io = vdev->barmap[bar];
> >>   	}
> >>   
> >>   	if (bar == vdev->msix_bar) {
> >> @@ -423,6 +408,7 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
> >>   	loff_t pos = offset & VFIO_PCI_OFFSET_MASK;
> >>   	int ret, bar = VFIO_PCI_OFFSET_TO_INDEX(offset);
> >>   	struct vfio_pci_ioeventfd *ioeventfd;
> >> +	void __iomem *io;
> >>   
> >>   	/* Only support ioeventfds into BARs */
> >>   	if (bar > VFIO_PCI_BAR5_REGION_INDEX)
> >> @@ -440,9 +426,9 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
> >>   	if (count == 8)
> >>   		return -EINVAL;
> >>   
> >> -	ret = vfio_pci_core_setup_barmap(vdev, bar);
> >> -	if (ret)
> >> -		return ret;
> >> +	io = vfio_pci_core_get_iomap(vdev, bar);
> >> +	if (IS_ERR(io))
> >> +		return PTR_ERR(io);  
> > 
> > Sashiko seems to note a real existing error here that should also be
> > pulled out to a separate fix.  Given the right offset, this could
> > generate a negative BAR value.  
> 
> Yuck, loff_t signed, yep.  Isn't the real root of this that it
> never makes sense for VFIO_PCI_OFFSET_TO_INDEX() to return a negative
> index here or anywhere else?

Yes

> I suggest instead, to also avoid this elsewhere in future, something
> like:
> 
>   #define VFIO_PCI_OFFSET_TO_INDEX(off)	((u64)(off) >> VFIO_PCI_OFFSET_SHIFT)

Sure, that has better coverage.

> > The test at the end of the previous
> > chunk should should be expanded to `if (bar < 0 || bar > ...BAR5...)`.  
> 
> Not necessary if VFIO_PCI_OFFSET_TO_INDEX() can't return < 0 (the
> magnitude would be 24b so can't overflow the `int bar` it's assigned
> into).

Yep.

> > Do you want to pick that up in this series?  I think it's the only case
> > that lets that slip through.  Thanks,  
> 
> Sure, I'll post a fix.  I don't think it needs to be part of this series
> though if it's just the macro, do you agree?

I was hoping to collect the fixes from this series for v7.1-rc
regardless, so either way.

> Do you know why drivers/gpu/drm/i915/gvt/kvmgt.c has copied
> VFIO_PCI_OFFSET_TO_INDEX() and friends?  Perhaps the shift was different
> (the reason drivers/vfio/pci/ism/main.c has its own versions).  The same
> loff_t issue seems to exist in both of those places, unfortunately.

I think because it was previously defined in a drivers/vfio/pci/ header
that couldn't be cleanly included.  The region shift is implementation,
not API, so drivers are free to define their own region spacing, see
for instance the new ISM driver that needs >40bits per region.  We're
likely going to move to a maple tree for defining regions in the future
so that we can more easily account for such large BARs as they become
more common.  Jason linked a branch with a rough draft of this not long
ago.

> PS: with minor question:
> Relatedly, I'd made `bar` an int following existing convention in
> 
>   vfio_pci_core_get_iomap(struct vfio_pci_core_device *vdev, int bar)
> 
> But I'll make this `unsigned int`, please flag if this violates taste
> and decency.  IMO any BAR/index parameter should be unsigned; most are,
> some signed remain.

Yep, I think that would make sense and avoids needing two tests to make
sure it's in range.  Thanks,

Alex
