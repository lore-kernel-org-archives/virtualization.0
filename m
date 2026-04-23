Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E483C8736
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979856; cv=none; b=BLk48pwkZN43Q60tZcAGQmIuZ6VT+42fOiSl330EPoqeZ0eQnS6ciLrEiOcyFJozsRdVTMjUdPQphpH28/8yy40cA03sps5nrg+t7EwgC8TrICl3UXdD44OXJBHBFu3gQQSvYWNpKl5blM0mriEQ6TrOO5CNjfri5Kt1FJs+1HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979856; c=relaxed/simple;
	bh=xHwxWO9g5rK/tr1U7wPQrlic1lDEF00YKfIAEMkLA1E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBr6tFCBt/xULJCAsabPwr8wFWaReYtHhd5dwIPXwDrTWPpkcsvlCOdRitLGHZY+6ptRdtBqr7pP7oU1gPT0wKiFHJhPZwvj6XRJOhCchxrRuc9i89OAEe84tAo4JD3rM2+onFCEpMY9+qhPvUgpxVZGZO8QCZGAmruywK0MRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=i5gYdgQI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TQJwWkP1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="i5gYdgQI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TQJwWkP1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B3171140008E;
	Thu, 23 Apr 2026 17:30:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 23 Apr 2026 17:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776979850;
	 x=1777066250; bh=8Z0lLzQLNegyzgevEzRkhq+PE0zBvvVLsc+TGhBvyEg=; b=
	i5gYdgQIybsWimzdDCH9EtAJxdiKDjArmkMKKbMF03mcM+feamCD+/zYofF5dJNu
	xM4aTIkzaGfd/sN4naWR8FM6Vt1E7LCOZ8DGYYNjwvInXYd7Wg+JLbzXJKu/6SP/
	W65qnIDzOLbnaYUta6LohkvEFlE/oyJArtF+f8vF0c/ma+gbXfaZq2w3D0CjTFL8
	TPDrJcImNNB/2bhqtskbI3jPuI/h9j2rqA2qGyrJOIXb1ISC64gDeBDfgPfucvV4
	1dIwfDM9l4lSyshdgipF3N2chZyX3jVsZMhTbGuymPc+3i/SiGxtB15voA7wtlFQ
	SVAhK9+pR7V4AH4/JJNaxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776979850; x=
	1777066250; bh=8Z0lLzQLNegyzgevEzRkhq+PE0zBvvVLsc+TGhBvyEg=; b=T
	QJwWkP1AzTC6RaoohWxo4s3BESdaHHwnL6ZM0mcLuSXAksAzTNW907PsBF9WVim6
	cbpfu7/HFwT4GrZOphf3ZgUN14tyLPLDNyUPXs5z4iWu7myRN9CY9zfE7Pcz9W3T
	kUL3N/gOlPaerNEUOiaZhiXEOkrOqqIcixXkdDUhglZFzb1V/P/pSYWFiPJSaCac
	IiF7izTarurw7SauW3GNvRobp/lSMfUFW7S9xC7N8xZ+EPAm1DjvhXLrgIEddMN1
	TGO2/tFpA3B9zHy05M2YVLGL4UEoqknlrO8JTln1RnViM8W5TWCeESakr9jfXizQ
	zjNz6JfURtbGB/qYIMQKg==
X-ME-Sender: <xms:iY_qaa76BxnPB_VXyE_0gUeYvKA1jgCbTCx9VLxfIqJCeuaMCW60ww>
    <xme:iY_qaenoq_In-MT-GcM5wK0_9m1InMzb9zOK9FsGU4CUPF7CzPzB-OH6A6WVRpsWr
    4cOkJBdfocVciK4lH9_DKytdlNErUBIjcn_3dAge8VCDKRBFdxe>
X-ME-Received: <xmr:iY_qaQE0_5chV9n_hWPLtCB-K-oyOG-ezcEd17axOyjArKJ7GBrgrKpROzk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeikedvgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:iY_qaSGmdmyimUF-9TETytGqkZJurJBMDqqUijElM2D1bqnjPnZb8w>
    <xmx:iY_qaY2B0dZif5VignW4obgEnOVfRngX-gHqF_sajiNAsmlc50ABPQ>
    <xmx:iY_qaUdur8dalpoXCH66UQPDjdXaKNjM6ZpV16Qbpau1hZwmfr7NVw>
    <xmx:iY_qaaJ98HkW8zhXl-w4xOmAeFxpuzamXrbdYg5Gt6j3rMotaxxCtg>
    <xmx:io_qaYwTuRcivIlRYIxlUWdHg0GE7vCPCOfmnwZNRmObu0iUgRu1mMuK>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 17:30:48 -0400 (EDT)
Date: Thu, 23 Apr 2026 15:30:45 -0600
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
Subject: Re: [PATCH v2 2/3] vfio/pci: Replace vfio_pci_core_setup_barmap()
 with checks for resource/map
Message-ID: <20260423153045.772af596@shazbot.org>
In-Reply-To: <20260423182517.2286030-3-mattev@meta.com>
References: <20260423182517.2286030-1-mattev@meta.com>
	<20260423182517.2286030-3-mattev@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Apr 2026 11:25:08 -0700
Matt Evans <mattev@meta.com> wrote:

> Since "vfio/pci: Set up barmap in vfio_pci_core_enable()", the
> resource request and iomap for the BARs was performed early, and
> vfio_pci_core_setup_barmap() now just checks those actions succeeded.
> 
> There were two types of callers:
>  - Those that need the iomap, because they'll access the BAR
>  - Those that need the resource, because they'll map/export it
> 
> This replaces vfio_pci_core_setup_barmap() with two helpers,
> vfio_pci_core_check_barmap_valid() and vfio_pci_core_check_bar_rsrc(),
> to make it clear which behaviour is required in each caller.

TBH, I don't see why we need the distinction.  Thanks,

Alex
