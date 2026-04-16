Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9844F38E121
	for <virtualization@lists.linux.dev>; Thu, 16 Apr 2026 22:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776379454; cv=none; b=X0yhdoaOyQNplRCazOyjjyy1rrOVLFgdAqoFiJxo4nW56efalZIx8oQ/97i9zJYXs9UzbJmwqY4fn+NQQBG0K8RWAWuawPcTjpzsDjq/tj81Azsh8s/vDs7friLv3UYj0qC0wBN1FkVCUbgoNZby+2ojpaGB31qEULaThxl4xRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776379454; c=relaxed/simple;
	bh=j2SsrKwHx1PlDFiTIav3oazP14sDhn6ZApe2Ilkm+Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxG7Qoy1NeMTNNTSGSXXgUyj1guab3iYVCgL6++PkRKcs2nbxwFEtnvzyHeJ+qwNKvXVFO5jFmOfnlBvEUjdB96ZIwdmohK2IRDXTT2DA0wJRQXjokl51ugqy1tqwHHjtFLTHCYH1//LpY2W7tlYfsRiN+/ldCqVjg2uFusH6Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=HhgnRCy1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JYT1CsFh; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="HhgnRCy1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JYT1CsFh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 32EEE7A0256;
	Thu, 16 Apr 2026 18:44:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 16 Apr 2026 18:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776379449;
	 x=1776465849; bh=+4+ocCvoeYhWO4RzU4Nm3ZoHgVf0pZuK3DortIW2CKo=; b=
	HhgnRCy1WuVQcusHdDhE7few+0xNjlHmBsIxrbYhuGMhb0238PJM3qEi9K0FPG7K
	3ptKxhENkfYEmo6ZyZux0/sEvsWBLWufnX5u19mfvjtyM2ZW8SP/C9BEdSzFdRS3
	wG6WKNjXQxA6ssk+34/vhTfeBtHVQTgPHhwYwy3jkGmBsmiSHn0vfhxg5a2arZlv
	TffsJmUMGQKLwiXvpu/cS2XEwGAF30iEEdoOzeUggULpLtDmXJua+xn+7UgMK3F2
	Vv26cTWk6GMUdF9eNDW8LHnKqb9eDehL28/GW1w73Z0X9HMcKd1Stz578rfB5clB
	Sr893vaz0WfTS4PH5IKsEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776379449; x=
	1776465849; bh=+4+ocCvoeYhWO4RzU4Nm3ZoHgVf0pZuK3DortIW2CKo=; b=J
	YT1CsFh5zI2TKxT8+C8QxctR4tUVFEnLhIndnWEkyWpFg69znQMH622ijsDKN4lu
	P8iyRn5vCw1MfrCLNTxtywSxKktc3CjqgjgS6MQd2UBef2q+UH0KDT4n1amn209t
	Ad4Ilyhb6v3GobElri+Hqpkap4f24QPWOPdJ/fVMjX+zJExJKGGdrHvUj0VThF9G
	gf3zWjb/nYG72lzTl1u85l5epqTNMJRuNn7BOsy063BBt6d/+TWhV36yuYvsMKeB
	Prdkpq0Ahhkd2yD0Mfs6bonx5YPR/ujO9zCDut3YP1qNVIgqzoJi4Gj/Lp0RB9Uc
	zzK/0gVAocj0MUilhqNww==
X-ME-Sender: <xms:OGbhaStC4DV0und_riSZ5-p6y9YbSv6p54zAf-KaF9rGy6VMqJVOyQ>
    <xme:OGbhaSKnONjOE_R-A6JiXlGu2otUlY99-cXPvo7aNZ7YKHi7O5s5tQtCuFAHnDTfW
    kjG-NS7qm7fas5QWXd44KqGqdbTApIjRHabwj2G06n_NfhW5JmJ>
X-ME-Received: <xmr:OGbhaUZoX5Icq3rfTzGpARLKNBO0HHIGFip6nMc5uHjg10LKDQknZdAeefU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegkedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopedukedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgrthhtvghvsehmvghtrgdrtghomhdprhgtphhtth
    hopegrnhhkihhtrgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepjhhgghesiihivghp
    vgdrtggrpdhrtghpthhtohephihishhhrghihhesnhhvihguihgrrdgtohhmpdhrtghpth
    htohepshhkohhlohhthhhumhhthhhosehnvhhiughirgdrtghomhdprhgtphhtthhopehk
    vghvihhnrdhtihgrnhesihhnthgvlhdrtghomhdprhgtphhtthhopegrphhophhplhgvse
    hnvhhiughirgdrtghomhdprhgtphhtthhopehlvghonheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepvhhivhgvkhdrkhgrshhirhgvugguhiesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:OGbhaYLl_ntaWte04DOQO7Xa3xQ1maGJZYVucQrgmyUIJL5xupgRUQ>
    <xmx:OGbhadqjMWhmeUkNStkVCbt3X0pEEtFxASekWh0LhxxrpZlMs1oe-w>
    <xmx:OGbhaRA3a3GNN3w3yScyIB6ZORBMb0431gKzljYP0AbtHJ7tYUbg1Q>
    <xmx:OGbhaTeRldz7Cuisj0iP_0raEg3rUPrQEg6yTon_F-idJqn_w-B_bQ>
    <xmx:OWbhaUUkP2EXTAhJLjSlpmbD5pJxTzysOFJxEnaMo_6m_rKq0X4vw4Ya>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 18:44:07 -0400 (EDT)
Date: Thu, 16 Apr 2026 16:44:06 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <mattev@meta.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yishai Hadas <yishaih@nvidia.com>, Shameer Kolothum
 <skolothumtho@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Alistair
 Popple <apopple@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Vivek
 Kasireddy <vivek.kasireddy@intel.com>, Kees Cook <kees@kernel.org>, Zhi
 Wang <zhiw@nvidia.com>, Peter Xu <peterx@redhat.com>, Alexey Kardashevskiy
 <aik@ozlabs.ru>, Eric Auger <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>,
 alex@shazbot.org
Subject: Re: [PATCH 1/2] vfio/pci: Set up VFIO barmap before creating a
 DMABUF
Message-ID: <20260416164406.7fb3bb0b@shazbot.org>
In-Reply-To: <20260415181423.1008458-1-mattev@meta.com>
References: <20260415181423.1008458-1-mattev@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Apr 2026 11:14:22 -0700
Matt Evans <mattev@meta.com> wrote:

> A DMABUF exports access to BAR resources which need to be requested
> before the DMABUF is handed out.  Usually the resources are requested
> when setting up the barmap when the VFIO device fd is mmap()ed, but
> there's no guarantee that's done before a DMABUF is created.
> 
> Set up the barmap (and so request resources) in the DMABUF-creation
> path.
> 
> Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO regions")
> Signed-off-by: Matt Evans <mattev@meta.com>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index 4ccaf3531e02..fefe7cf4256b 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -272,6 +272,15 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  		goto err_free_priv;
>  	}
>  
> +	/*
> +	 * See comment in vfio_pci_core_mmap(); ensure PCI regions
> +	 * were requested before returning DMABUFs that reference
> +	 * them.  Barmap setup does this:
> +	 */
> +	ret = vfio_pci_core_setup_barmap(vdev, get_dma_buf.region_index);
> +	if (ret)
> +		goto err_free_phys;
> +
>  	priv->vdev = vdev;
>  	priv->nr_ranges = get_dma_buf.nr_ranges;
>  	priv->size = length;

Wouldn't this get a lot easier if we just setup all the barmaps in
vfio_pci_core_enable(), conditional on pci_resource_len() just like we
use to filter in REGION_INFO?

I don't recall if there's some reason we've avoid this so far, maybe
others can shout it out if they do.

We already tear them all down in vfio_pci_core_disable().  It would be
a small patch to add that, which we would mark as Fixes:, then a small
follow-up on top of that that removes any then redundant or unnecessary
callers (all of them).  Thoughts?  Thanks,

Alex

BTW, cover letters are appreciated for multi-part series.
