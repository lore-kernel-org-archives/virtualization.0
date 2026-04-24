Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF493E51FD
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051223; cv=none; b=GkJTTbEC61eSPDMK5AbC9aZ0SxerxMkp+F2UQsUwrNrTjPQaYUjreAtXYmKoP3/ybKmMfa0MDEbpLI1oqVHrG8XfA0D+5TYweEKxhIGrkm26PTfpjG+jHG2l3YA8vl31Oda7twL2EddNT7tHLEJTUt0AgE6CnP66tPl/0+Of04I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051223; c=relaxed/simple;
	bh=AxY1iBfldFApit6wrZ5QUICwTU+6rIbIaZnkDEgOhjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZfK0moqTLlej4QC7xtDOPzU3XINvtAJSMr2VY564Fu3E6cdNcT+zOvlWjj49ZEf2FaBO3slcyt744pV7Xg3tJLhNY3ad1SzzAtRBqfteIqQdmVMATtmawelgLFkz8oK8ur2lG3v8vQb05ovYm6NeWY7b1WO76dfp0APJsKmR6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=JC+7GT5y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TY305PFk; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="JC+7GT5y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TY305PFk"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 066DA1D00221;
	Fri, 24 Apr 2026 13:20:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 24 Apr 2026 13:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777051213;
	 x=1777137613; bh=TUFSU68QEk06VYkcHkAK1Vo9g8/0LlspZiKHCAsM4EA=; b=
	JC+7GT5yxaMnam4UaNBzI+adixh8/LIqK+y6HrkjFQCEBTI73kVv/3yi7dYBTrYk
	FpHPU4LjM1FEgPYFivJ7g1jcho8GZh49CIeDJK/2yszMll+kgvRf6bvk7o4QXIZ1
	SJxPwKFAF64atr9RQox3L4iIOQeWYQ5z49AVl342l2CqbBz5GNpGwd7NWl+z+BJc
	niBHqu39IciS2jMGseL3KSaXdW8LIQCWDe2ERRri2YxVisxcf14uu8gNIgYdbHGW
	tFwJK+5lVic2KjUA6e5sKp69qwYl2ReXIXPVkKAXmcXCIq8Pk+GrIyfuR5TsCbWp
	opBa9PNa9NebGdWVd5NhgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777051213; x=
	1777137613; bh=TUFSU68QEk06VYkcHkAK1Vo9g8/0LlspZiKHCAsM4EA=; b=T
	Y305PFkDP8MDR5LXJE7xXsiP0kdPYdfVgo4DIT6HA6flrs0/UiXpYvfaovEb54T9
	VXAoOZyiInKco3UrhE6vnSbriLxaKNDxu4MmK3a5FbIFITeSo8RcDJR9o0/4D9qA
	7pJhoUNZxUKlYZZPTgHs+lf0HXRStAN/CGZm0J5MFzIiZW8vyotQlnPsjZ8XKekk
	k618by757PIwC9eN0CCTcdc0WNsRo5okRl14z29OjP/hXmFAOEEQ6zPXPYDMBczD
	xwnCN8xPRbWElrjJ58O5WJDXRXKnDDEgvExsMcnFuhfGn/YOstAuoQ2dUz01iBRL
	TAs7PRrnLT8VBCeq6/xrw==
X-ME-Sender: <xms:TKbraXYK_q0k-qkGFWlXZNFoRBonI6skq77VkZNc8Uh6lZqWC9mMOw>
    <xme:TKbraRFR_m0aaDOzkaErP6FuOGXNezbkfrDT2fboGqfUBJDRhgE-boONyW3rvD1bU
    fHBqeHM7fZKJWyq3kNcJ-Hwtm8jqLtlgPlyDfijbRr9yq0PyyHPMw>
X-ME-Received: <xmr:TKbraQl9idhYMdsG9OAZqu4PikXwOyni6KQHfhfC-U2Ng4LtGu1Pc5T0Rqk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejtdeiudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:TKbraYnuVGg_XjqZaofI-mOKf57VJPTd24qUxefAZUgt0MVsOd-LlA>
    <xmx:TKbradXFY7mRYVhTI1QaA1iPaiHQeLZljV7brQD_u4Vbvy8Vmdqtfg>
    <xmx:TKbrae8wrwserRFnxpHxlwKjFkIG3MtAHYJxz15EF5oMccK1uU9AoA>
    <xmx:TKbraSpPmVl2p1BaZZ-4kP8V4j4irR2z7lJ6ZU-j_gmaUhn5skwuUQ>
    <xmx:TabrabR_i0koucaHq70kgsxaCUnGUOVLU7rP3CRR5-A3s-eSOMArsF1e>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Apr 2026 13:20:10 -0400 (EDT)
Date: Fri, 24 Apr 2026 11:20:07 -0600
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
Subject: Re: [PATCH v2 1/3] vfio/pci: Set up bar resources and maps in
 vfio_pci_core_enable()
Message-ID: <20260424112007.592fd6c0@shazbot.org>
In-Reply-To: <729d6593-f88b-42bf-b3a0-8c364d9ca5b4@meta.com>
References: <20260423182517.2286030-1-mattev@meta.com>
	<20260423182517.2286030-2-mattev@meta.com>
	<20260423153053.6833135e@shazbot.org>
	<729d6593-f88b-42bf-b3a0-8c364d9ca5b4@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 16:15:06 +0100
Matt Evans <mattev@meta.com> wrote:
> On 23/04/2026 22:30, Alex Williamson wrote:
> > On Thu, 23 Apr 2026 11:25:07 -0700
> > Matt Evans <mattev@meta.com> wrote:
> >> +
> >> +		if (pci_resource_len(pdev, i) == 0)
> >> +			continue;
> >> +
> >> +		ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
> >> +		if (ret) {
> >> +			pci_warn(vdev->pdev, "Failed to reserve region %d\n", bar);
> >> +			continue;
> >> +		}
> >> +		vdev->have_bar_resource[bar] = true;
> >> +
> >> +		io = pci_iomap(pdev, bar, 0);
> >> +		if (io)
> >> +			vdev->barmap[bar] = io;
> >> +		else
> >> +			pci_warn(vdev->pdev, "Failed to iomap region %d\n", bar);
> >> +	}
> >> +}  
> > 
> > I see you making the point in the cover letter about the resource
> > request vs the iomap resource, but we currently handle these together.
> > If either fails, setup barmap fails and the path returns error.  I
> > don't see any justification for now allowing the request resource to
> > succeed but the iomap fails.  
> 
> The primary effect was to let consumers see -EBUSY for a resource 
> reservation failure or -ENOMEM for an iomap failure (whether through 
> this patch's vfio_pci_core_setup_barmap() or the next patch's helpers), 
> and that keeps the error signatures identical.
> 
> A weak secondary effect was that a BAR that gets resource but fails for 
> whatever reason to iomap it can still be used by most clients (assuming 
> the general usage is to mmap).  The system's pretty sick if this is the 
> case, so as I say it's weak.

Right, I don't see that's really a necessary add at this point.  In
fact while we expect users to access through the mmap when available,
we don't actually have a way to specify that mmap works w/o read/write,
which is effectively what this proposes is a valid state.

> 
> OK, if you prefer the combined approach and don't feel the subsequent 
> single-semantic check helpers (need mapping, need resource) are clearer 
> to read then I'll recombine them, though:
> 
>   - If vfio_pci_core_map_bars() just sets barmap[n] iff both resource 
> acquisition and iomap succeed, then a later check can only return one 
> error from either cause.  I'll go with -ENOMEM unless you prefer -EBUSY. 
>   Using something else can again make userspace see previously-unseen 
> error values.
> 
>   - IMHO vfio_pci_core_setup_barmap() should still be renamed (in a 2nd 
> patch) since it doesn't do any setting up anymore.  Cosmetic, but 
> cleaner to parse when the callers use vfio_pci_core_check_barmap_valid() no?

I'm not sure how important it is to preserve the identical errno, but
we can actually do that too.  Make the enable time "setup" function
store the ERR_PTR in the barmap and change the current callers from
"setup" to "get-iomap", where get-iomap is a __must_check return that
callers test against IS_ERR_OR_NULL().

Or maybe better, collapse NULL into -ENODEV so callers only test
IS_ERR().

There's even one user in vfio_pci_bar_rw() where this provides a minor
simplification.  Likely the others are just wrapping the get-iomap call
in the ERR/NULL test to get the equivalent behavior.  Thoughts?  Thanks,

Alex
