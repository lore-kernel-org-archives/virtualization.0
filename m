Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7520E374182
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776799891; cv=none; b=Gctwjzz4kh7oBuGUF9AY5q31J5EMTz0rxoFOLs0Bk99gXKazNGwYYfH1fbdW1t5h3Azq7hbnye3cK9dH44hlQL4RQRaEckdDG7Wm7t0E6xR2z8vnkRTA9JADq7PrDInMdMlAxKDmp536RzyutexcxZA3Lt4ayTHRFxSINwiitYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776799891; c=relaxed/simple;
	bh=IinquCqdbzmTntsumlWfMgE9/jz08jueg77OoAkwzCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oaEaGXXlT+c2tR1Eig6p+Oboh1tey7SbL7qA2TsO9ytbe9Xfe0GKO8vxkFblylNLt0k7/OvUvnKA5ShvvSBqwOYptTtsmZ3JWo8QMPFeLiNKwELKm2ep5U6E7sipZrWw9ENvHuARuKCfl+3Wr48tRf7KsvocJgzv7YWfhrPHEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=GLkquT7F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CD+xjxzU; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="GLkquT7F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CD+xjxzU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8EE77EC00A3;
	Tue, 21 Apr 2026 15:31:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 21 Apr 2026 15:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776799887;
	 x=1776886287; bh=hIF2+30qOQFQxzgm1H9H8kdO/7SbRVRzMzpLBLQLkHM=; b=
	GLkquT7FdWJWnMDVjI6VSaP2Nb8SBDofub6/6YlVXIMFR+NzSkQ5+V1MJPvHBaZI
	sY68IG6k0DdSRA2KP21RQJOragdX1ZicrGUQios2dunp6HUpYh/V9wy3SRfge/bz
	xG7mUtDtKIml0fg0+yk/iDmAZBgNBBYsnzf5uf+/whyaM8A0aTuMIUMUoYpC1mdj
	7gQ6t/8DoFK8gZgBO0hDyAh4CG9wmmZ/b1HQFx9C4Nje/fZdUAj6t64mnqYDP2/b
	zX03U2oKOF/93CReJ4r9MeGEhaSoCdgMWRsRon2ovegqv1pA/fmv3FbbqsmxHyxZ
	pksSDT1F+DahG3LtLbItQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776799887; x=
	1776886287; bh=hIF2+30qOQFQxzgm1H9H8kdO/7SbRVRzMzpLBLQLkHM=; b=C
	D+xjxzU0ySCSiWsAENEwREph3gutca+8jb/2ukIXwxWAavXTavcQTte7NHv6vuHb
	R2aMttcBZP/jFtT/pH8hU66polWGOu5RIumYKdCX7qZyUmrZ/LibT9enhVfZEpd3
	cernd/4SagGVD9YZHMSywT2YjWfsEkRCdWKiMBZzdfol1PXPydBe1lhEUMTJ5UsJ
	vVy2t20aWSSl5VQNk6gnGvNyoqVlg50MpVV0bN0UB0Zz4WUezr6nFcN54tbh/3sd
	Ug3QR2RpkpRXZem9ilcz9Ci44ZV6k5ypAxKslhsjYnYEk4Hx0ZW/SshfQcKWOpD9
	kRf6QE8A6YOKWar8XYN9w==
X-ME-Sender: <xms:jtDnafCoGJf4lQKa72JCGiYmN_KXQAVAUnuEU0sZCYInrZUFHbUYdw>
    <xme:jtDnaQNnLX2-HutU1kl6R0xNzIiv33yiPkoEpbvg3fbCe3Y4cMZYZgwSAYNmLfYlX
    P-kZoJBakj7nG3AkgUe3SnHxPb8xGEQAGk2xHpM_u5Rz99e6vgTew>
X-ME-Received: <xmr:jtDnaRNBZbSeQF-lOnpn4com5znlWC-xD7RgoYkCwXabvJfA1HBEYliqdsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeivddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopedukedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgrthhtvghvsehmvghtrgdrtghomhdprhgtphhtth
    hopehkvghvihhnrdhtihgrnhesihhnthgvlhdrtghomhdprhgtphhtthhopehjghhgseii
    ihgvphgvrdgtrgdprhgtphhtthhopegrnhhkihhtrgesnhhvihguihgrrdgtohhmpdhrtg
    hpthhtoheprghpohhpphhlvgesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhgvohhn
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhkohhlohhthhhumhhthhhosehnvhhiughirgdrtghomhdprhgtphht
    thhopeihihhshhgrihhhsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:jtDnactiQNzKnH0OM_z3owk7yhgBtB4G-s6wUU0_E0WISFCVoExi-g>
    <xmx:jtDnae-R7wcg0vLy_AthDU3FDJRIUuzlxHv8ofx6-oIrOUxTc-qrSw>
    <xmx:jtDnaQF0jMqyEL_7q9cJjCxYReLe2wlXH2d-HGxKWWPdZLJtjrDKKg>
    <xmx:jtDnadQJqdhRFqk6tZwmoZVUFVRwdD5Zkyl-SNpISech-Vqyflcm3w>
    <xmx:j9Dnaab64ovIADOud0mfMF__j7V7J04q1aDnCOB-3jA8R2zrqt1PrESl>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 15:31:25 -0400 (EDT)
Date: Tue, 21 Apr 2026 13:31:23 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <mattev@meta.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Ankit
 Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Kees Cook <kees@kernel.org>, Shameer Kolothum
 <skolothumtho@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Alexey
 Kardashevskiy <aik@ozlabs.ru>, Eric Auger <eric.auger@redhat.com>, Peter Xu
 <peterx@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, Zhi Wang
 <zhiw@nvidia.com>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <virtualization@lists.linux.dev>, alex@shazbot.org
Subject: Re: [PATCH 1/2] vfio/pci: Set up barmap in vfio_pci_core_enable()
Message-ID: <20260421133123.36fc0353@shazbot.org>
In-Reply-To: <20260421174143.3883579-2-mattev@meta.com>
References: <20260421174143.3883579-1-mattev@meta.com>
	<20260421174143.3883579-2-mattev@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Apr 2026 10:41:40 -0700
Matt Evans <mattev@meta.com> wrote:

> The previous lazy-setup of the barmaps provided opportunities to
> forget to do it (for example, DMABUF export).  Since all users will
> ultimately require BAR resources to have been requested, request them
> in vfio_pci_core_enable.
> 
> Existing calls to vfio_pci_core_setup_barmap() are now benign, but
> remain because some callers use it to validate a BAR index.  This
> fixes at least the case where DMABUF export could succeed before
> resources were requested.
> 
> This keeps resource request and ioremap() done at the same time, but
> in future the ioremap() could be done on-demand (not all VFIO users
> need it).
> 
> Fixes: 7f5764e179c6 ("vfio: use vfio_pci_core_setup_barmap to map bar in mmap")
> Fixes: 0d77ed3589ac0 ("vfio/pci: Pull BAR mapping setup from read-write path")
> Signed-off-by: Matt Evans <mattev@meta.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 63 +++++++++++++++++++++++++++-----
>  drivers/vfio/pci/vfio_pci_rdwr.c | 25 +++----------
>  2 files changed, 60 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 3f8d093aacf8..4a314213f3ae 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -482,6 +482,55 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
>  }
>  #endif /* CONFIG_PM */
>  
> +static void __vfio_pci_core_unmap_bars(struct vfio_pci_core_device *vdev)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	int i;
> +
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		int bar = i + PCI_STD_RESOURCES;
> +
> +		if (!vdev->barmap[i])
> +			continue;
> +		pci_iounmap(pdev, vdev->barmap[bar]);
> +		pci_release_selected_regions(pdev, 1 << bar);
> +		vdev->barmap[bar] = NULL;
> +	}
> +}
> +
> +static int __vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	int ret = 0;
> +	int i;
> +
> +	/* Eager-request BAR resources (and iomap) */
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		int bar = i + PCI_STD_RESOURCES;
> +		void __iomem *io;
> +
> +		if (pci_resource_len(pdev, i) == 0)
> +			continue;
> +
> +		ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
> +		if (ret)
> +			goto err_free_barmap;
> +
> +		io = pci_iomap(pdev, bar, 0);
> +		if (!io) {
> +			pci_release_selected_regions(pdev, 1 << bar);
> +			ret = -ENOMEM;
> +			goto err_free_barmap;
> +		}
> +		vdev->barmap[bar] = io;
> +	}
> +	return 0;
> +
> +err_free_barmap:
> +	__vfio_pci_core_unmap_bars(vdev);
> +	return ret;
> +}
> +
>  /*
>   * The pci-driver core runtime PM routines always save the device state
>   * before going into suspended state. If the device is going into low power
> @@ -568,6 +617,9 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
>  		vdev->has_vga = true;
>  
> +	ret = __vfio_pci_core_map_bars(vdev);
> +	if (ret)
> +		goto out_free_zdev;

Beyond simply changing to a preemptive mapping scheme, this hard
failure makes me concerned about regressing userspace.  With the
current lazy scheme, we only claim the BAR if the user accesses it and
the failure only occurs in the access path.  That means we could have
BARs that are never mapped.  With a hard failure here, with might be
uncovering some latent issues, and if those latent issues are with BARs
that we never cared to map previously, we're causing trouble for no
gain.

I'd suggest setup should be a void function that generates pci_warn()
on conflict or iomap error, but doesn't block the device.  Each usage
path (including mmap that gets removed in the next path) still needs to
validate the mapping is present for the given BAR and fail the call
path otherwise.

There's also a subtle range check added in the virtio driver in the
next patch, is that fixing a bug or paranoia?  Do we need a helper that
does a range test and barmap test?  Thanks,

Alex

>  
>  	return 0;
>  
> @@ -591,7 +643,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  	struct pci_dev *pdev = vdev->pdev;
>  	struct vfio_pci_dummy_resource *dummy_res, *tmp;
>  	struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
> -	int i, bar;
> +	int i;
>  
>  	/* For needs_reset */
>  	lockdep_assert_held(&vdev->vdev.dev_set->lock);
> @@ -646,14 +698,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  
>  	vfio_config_free(vdev);
>  
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		bar = i + PCI_STD_RESOURCES;
> -		if (!vdev->barmap[bar])
> -			continue;
> -		pci_iounmap(pdev, vdev->barmap[bar]);
> -		pci_release_selected_regions(pdev, 1 << bar);
> -		vdev->barmap[bar] = NULL;
> -	}
> +	__vfio_pci_core_unmap_bars(vdev);
>  
>  	list_for_each_entry_safe(dummy_res, tmp,
>  				 &vdev->dummy_resources_list, res_next) {
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index 4251ee03e146..d1386a31a3a3 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -200,26 +200,13 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
>  
>  int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
>  {
> -	struct pci_dev *pdev = vdev->pdev;
> -	int ret;
> -	void __iomem *io;
> -
> -	if (vdev->barmap[bar])
> -		return 0;
> -
> -	ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
> -	if (ret)
> -		return ret;
> -
> -	io = pci_iomap(pdev, bar, 0);
> -	if (!io) {
> -		pci_release_selected_regions(pdev, 1 << bar);
> -		return -ENOMEM;
> -	}
> -
> -	vdev->barmap[bar] = io;
> +	/*
> +	 * The barmap is now always set up in vfio_pci_core_enable().
> +	 * Some legacy callers use this function to check if the BAR
> +	 * is legitimate, so maintain that:
> +	 */
>  
> -	return 0;
> +	return vdev->barmap[bar] ? 0 : -EBUSY;
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);
>  

