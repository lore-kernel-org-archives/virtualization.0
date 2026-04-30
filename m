Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D1938F643
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580040; cv=none; b=pLoKoKowgMUG1XKXxu6HmcERkAimWp6GclLI//s8g05mYD/ALKg014L36rYMD0+GlwVHtcuB8jZLkzN+OLG3Z1louR+IDCwzXqFkfaTSMDChWJ28yFdIBad471IwGphobY5apwvUDdKd2rxGXDigNfqjk/agtCjIor2a4viGrG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580040; c=relaxed/simple;
	bh=aDsCu3z80QPVoVoKfmhKYpp3qc/i+wge3CyQtaksykc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLEcj2AsOrdqRrttFECmmqHVls51uy60/fHiROuQGUI4XW2DQka56HuM8tnhpxk+7GGM1OuTj6RyYXUjWYGmUfqi44BF7dj+3xyz6M5NDdwGhjxcX5dWpO9JgbXgrNOE+gadPZEpAK9aQR4lrmjqjGNaFc1MpHQV3PlEPX8irdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=F7zDOruJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QhcpOjG3; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="F7zDOruJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QhcpOjG3"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5F7B91400116;
	Thu, 30 Apr 2026 16:13:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 30 Apr 2026 16:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777580038;
	 x=1777666438; bh=cIWUfOtmNgofCmZE+cELVNsQTIEZ0ZyUaH/wBFQLd3I=; b=
	F7zDOruJQXQ8mLKLQJttYHVqPhz09unuo2SGsuJcrRI8wic60b5zgSYVPzIkrVQ5
	+n+9LSAygmWqPOe2IXqaqDqPyZ2DHHL8CVkiqxCdAJFFjpeoVKK8CjgSWElz1vjM
	WL7LF6XWshYPfKlWEe8vpcJkG2/4udHeF3FC5hnGxJR6sKSPkFxM/dIKcHVkzbH0
	aDRvr1VFLhTTMZIII3ZNJ5T7401pK4Bg5KnFigcQDyQ93WGNxb4zLcWmHvDU3WlL
	yY9m+eSxOQ8q+SX29el8e6Nr0lhWhSImA/RGib1Q/yKGKsB7lijvKFEPdJoGcSoZ
	5WHg0aNfXuFzzbZnuD0IbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777580038; x=
	1777666438; bh=cIWUfOtmNgofCmZE+cELVNsQTIEZ0ZyUaH/wBFQLd3I=; b=Q
	hcpOjG3lfcddc6eaEvhvdn6vYzAItFt6ozbIZQLaf3XPgRziuQkR+pCDXhpus3H6
	9MZE+j+dC7uo5nwLEGC1GGTw+VJvXsGF0sIkWBvoyzSmqUyO/tPd9MS0LXplZrjl
	9xXg8IYlZn/gy9VaASoolAV1zllMcBYHO+uqgRbf5UzwByXNgLpVQeLGtcV6MfXy
	7Vk3N0JXTJK2+uyz1fm2zicskGmIZaPe0OfB6lQJanhCF4BG9y7GKgzBYiJiWHtI
	vPpu4CEKFSiat/zaWKGVsyhSfH2CKdTRSnXrnHHsVvzgvwjdADfbrgA4vfNk0Jy6
	j4x9jmpUeK6qYb98UtMAA==
X-ME-Sender: <xms:Brjzacx-HVQm2Mn9FMGLs8sWrnaTacE-3jvv1UXr-Wk0UfQtRxXf3Q>
    <xme:Brjzaa8dMD_KYvYPIDoUS68uqrkdPnzIsNlz0YA9w_KWKtiaBXxIcjrxa1K9q08-f
    REAeEUDgX6wrTkwy3OQ4Cwb_ES75IFfGiN10e9Ub8ByhYhz5_XIog>
X-ME-Received: <xmr:BrjzaU-QO04gCh9B3WRaXu8QMEpVu9C_d5gD2g-qmMkQCKQMN645cLvN6Ys>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkedvhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:BrjzaVcHAPtVFjtDb_HWWqg6tTw7C8HolPzWF-Xba0bePE5AKq7LIw>
    <xmx:BrjzaYtpbmYP8qkYjiF6xMtpAN5v5Ig1duBthFxWz43ngN3Tu-uZ3w>
    <xmx:BrjzaW1pFAha9sv0dnSXQCY19H014t3qx5aSy9oTdN6myl_-DjucSg>
    <xmx:BrjzadCQmxkOqmAMZNBIESxSI4NUc3NVOLYNwIjdjime7ghPfSzSww>
    <xmx:BrjzaVKPw4NE4431AbwDHoDXn7jT24j5rxx7DCMG0ekhusPejP7mrUQG>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 16:13:56 -0400 (EDT)
Date: Thu, 30 Apr 2026 14:13:55 -0600
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
Subject: Re: [PATCH v3 3/3] vfio/pci: Check BAR resources before exporting a
 DMABUF
Message-ID: <20260430141355.2751f9ff@shazbot.org>
In-Reply-To: <20260430100340.2787446-4-mattev@meta.com>
References: <20260430100340.2787446-1-mattev@meta.com>
	<20260430100340.2787446-4-mattev@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 03:03:22 -0700
Matt Evans <mattev@meta.com> wrote:

> A DMABUF exports access to BAR resources and, although they are
> requested at startup time, we need to ensure they really were reserved
> before exporting.  Otherwise, it's possible to access unreserved
> resources through the export.
> 
> Add a check to the DMABUF-creation path.
> 
> Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO regions")
> Signed-off-by: Matt Evans <mattev@meta.com>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index f87fd32e4a01..3bc7d850e258 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -244,9 +244,11 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  		return -EINVAL;
>  
>  	/*
> -	 * For PCI the region_index is the BAR number like everything else.
> +	 * For PCI the region_index is the BAR number like everything
> +	 * else.  Check that PCI resources have been claimed for it.
>  	 */
> -	if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX)
> +	if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX ||
> +	    !IS_ERR(vfio_pci_core_get_iomap(vdev, get_dma_buf.region_index)))

Polarity of the test is wrong, should just be IS_ERR().

It would be good practice here to front-load the Fixes: patches in your
series.  I'd suggest making this patch #2, using the existing
setup_barmap API, then include it in the conversion to iomap in patch
#3.  Thanks,

Alex
