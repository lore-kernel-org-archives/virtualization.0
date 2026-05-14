Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B74A3446C6
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776766; cv=none; b=Aexlhk6EXFNaygqOoq+GSY1fZG1nkxJ8ApClP+5MvHDCEu/iLe/UrfqlSz1A0nL/86lHMDcLQ1OvxFNg5I2QnNuGpVqLYjeXudYPmEjUwCPRPeKYWwod4mAOpsiJEuiQyeEcNXQp+shykj9WlEjV5IgredMlLJMA4aE5SOB8Qx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776766; c=relaxed/simple;
	bh=xWAjM4uAoB1n0zBuyQM/tzRcDfwzDhKrpzthmbgIqMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIoHHHYnbctBr/ObhB69hMd2cICGUMH38cbCKifs8JF47pmU9dwzkIx7budJrPqGYInOqIfMUw77QjqiLa26M5UOGxm652iBKsYGkWMt8pa+nYfh5veYUgrTwcCuQBX8o5jQm0AS0jXrOlVboBMVSjl9tdzzI9eX14WfOQ2oTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=AgAcOfiP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t80JhufO; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="AgAcOfiP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t80JhufO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5B7F3140016C;
	Thu, 14 May 2026 12:39:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 14 May 2026 12:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778776759;
	 x=1778863159; bh=czap6tucHP4ZLEoUc0IKjMce14SIulIUB8jqYkih+WQ=; b=
	AgAcOfiPJzRrbNu2XlNWzBMjsxyTVVlJDQWlm+2n9bII8lG193x0RQOFEsEXuaSX
	mNLMJhsH/l31xiI398lITH6duL9VYWyzh/xjBkVx7cHgVfDe9ldAUIYsFYMXMuIc
	Vl7Do5Vu2RB/pNMkKD1MOKvCtJX9f8L5Sr7p60wFt7F+Tl+UydP9VLYccCTMp2l/
	dVTlDxHczpGyy9a7z/nUq9PHVnvzLR5BHMdgK4mGnhL2AAmy/79Xvhu1Re1mM3lD
	FBiZ2MNFd+qVy8W9qEyZK3HN0q6QKWA2ig0LSpPOYBYjb+0LcAsd8KIOvlTu1WLK
	Ti59p4wxX+j1S9M9qvJ8Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778776759; x=
	1778863159; bh=czap6tucHP4ZLEoUc0IKjMce14SIulIUB8jqYkih+WQ=; b=t
	80JhufOnBEI9KGjAOdiAn0k03Eq3XoGt6yeH3j36/Jmba8hCLImhC1rcD9zim66n
	o4Nkrq68/wYCiaJq1sOqB+cIhXZm1bLALWPRudunprYCq5iU8bDhW43unt2ovlOw
	gF5NfLxKZA1wVKtp1Ij+Sr8yyb0ZnktUgxKNwMr14IqkQuopMGjHlRIKJ9bYGyRT
	SxEP78ZjEmxgt9fbQI+tAOG9vOpTsDx2nOUKgB2CLpUtiTiO95I3uSElPxCh8sCy
	r6dmDt/kl3lkEw2Kvd98jZQnXat3XswztWdhAVdw5Qw+jZtTESQo+rtMC54PKr5D
	wb+MYIy/jIJotNjIMyGhA==
X-ME-Sender: <xms:tvoFatcUgQFt9l7-eMVhD6AAjJzbGIDwTg1C9dPpqxjLwx0HUyq2FQ>
    <xme:tvoFal7iiGeyk-44eejkt9WAncrGRHThRlialGqxJiX0K_UDwZaa7V6nk05x4HBBd
    1QjiIHPM3XShBpC0QFaJSCB2Q8SgnuXskE8YJ_aMRtNIaIknal9JQY>
X-ME-Received: <xmr:tvoFatKIEFAHuPTnw3OAYf6L-1JmSMNzGVHCw8zUsEqUdaLQoJ7apwqpQv8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdektddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpefgfffhkefhgffgieeufeehhfekgedukeehkeffhfdtgfdvffeujedtvdeu
    ffelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdduqdhrtgdrmhihnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgr
    iigsohhtrdhorhhgpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepmhgrthhtvghvsehmvghtrgdrtghomhdprhgtphhtthhopehkvghvihhn
    rdhtihgrnhesihhnthgvlhdrtghomhdprhgtphhtthhopehjghhgseiiihgvphgvrdgtrg
    dprhgtphhtthhopegrnhhkihhtrgesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprghp
    ohhpphhlvgesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhgvohhnsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhkohhlohhthhhumhhthhhosehnvhhiughirgdrtghomhdprhgtphhtthhopeihihhshh
    grihhhsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:tvoFah6Jt8zzJW-AIyxr5xQatcd1d9S_MbzK0zMDruSO_m_A2XIvCg>
    <xmx:tvoFakZ1ncWSOqLU3V9w8n7C3HwyOrsGYq1JoSN1I_se7-WU61RfjQ>
    <xmx:tvoFagxqCs4EVKtFS1O3pLyxK6YRxW9slerGsiQzsGKGhDwY8NprOA>
    <xmx:tvoFaoOufNy72mRmIh72pWL6ABREHP2NyYJbjqnSqILRvQ6VmU3EdA>
    <xmx:t_oFaoHleEia35NS7rSFDHlVJS0GrtuR9994eCpmEPeHgVkiTFLp1cxH>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 12:39:17 -0400 (EDT)
Date: Thu, 14 May 2026 10:38:48 -0600
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
Subject: Re: [PATCH v5 0/3] vfio/pci: Request resources and map BARs at
 enable time
Message-ID: <20260514103848.577a6e05@shazbot.org>
In-Reply-To: <20260511145829.2993601-1-mattev@meta.com>
References: <20260511145829.2993601-1-mattev@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 07:58:22 -0700
Matt Evans <mattev@meta.com> wrote:

> Hi,
> 
> These patches fix a potential race for concurrent calls to
> vfio_pci_core_setup_barmap(), and a DMABUF missing check for resource
> before the export.  Discussion on a previous series (different,
> replaced by this one) is here:
> 
>  https://lore.kernel.org/kvm/20260415181423.1008458-1-mattev@meta.com
> 
> Responses in that thread indicated there wasn't a strong historical
> reason to require the mapping to be performed on-demand at BAR
> reference time.  It's much simpler to move this earlier, to
> vfio_pci_core_enable(), and that then avoids having to deal with
> concurrent requests later.
> 
> The first patch requests PCI resources and pci_iomap() of the BARs
> from vfio_pci_core_enable(), moving this out of
> vfio_pci_core_setup_barmap().
> 
> Some callers rely on vfio_pci_core_setup_barmap() for its ioremap()
> effect, and other callers use it for its resource-acquiring effect.
> The function turns into a cheap error check that both these actions
> have occurred; that maintains the same error behaviour as before the
> fix.
> 
> The second patch adds a call to vfio_pci_core_setup_barmap() to VFIO
> DMABUF export to check the resource is reserved; previously this was
> able to export an unrequested resource.  Although patch 1 at first
> appears to fix this by requesting resources at enable time, code using
> the BAR still needs to check the resource really was acquired.
> 
> (FWIW, Leon gave a R-B on v2 in
> https://lore.kernel.org/kvm/20260426111606.GC440345@unreal/ though
> this repost isn't 100% identical so I didn't propagate it.)
> 
> The third patch refactors vfio_pci_core_setup_barmap() plus the various
> vdev->barmap[] accesses into vfio_pci_core_get_iomap() which returns
> either a pointer to the mapping or an ERR_PTR() describing why it
> doesn't exist.  This is used by callers that need the mapping, but
> also by other callers to check that the resource/mapping step was
> successful.
> 
> Matt Evans (3):
>   vfio/pci: Set up BAR resources and maps in vfio_pci_core_enable()
>   vfio/pci: Check BAR resources before exporting a DMABUF
>   vfio/pci: Replace vfio_pci_core_setup_barmap() with
>     vfio_pci_core_get_iomap()
> 
>  drivers/vfio/pci/nvgrace-gpu/main.c | 20 +++++++-----
>  drivers/vfio/pci/vfio_pci_core.c    | 48 ++++++++++++++++++++++++-----
>  drivers/vfio/pci/vfio_pci_dmabuf.c  |  6 ++--
>  drivers/vfio/pci/vfio_pci_rdwr.c    | 42 +++++--------------------
>  drivers/vfio/pci/virtio/legacy_io.c | 13 ++++----
>  include/linux/vfio_pci_core.h       | 20 +++++++++++-
>  6 files changed, 91 insertions(+), 58 deletions(-)
> 

Applied 1/ and 2/ to the vfio for-linus branch for v7.1-rc.  My
intention is to have these merged for rc4, which I'll then use as the
base for the v7.2 queue where we can pull in 3/.  Thanks,

Alex
