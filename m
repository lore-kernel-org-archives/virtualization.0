Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4856801;
	Tue,  8 Jul 2025 12:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976414; cv=none; b=JcDMSwa2X93EMu/uX4v49TWSRaqzzHWtvX4MG+AefqrssbC7r6OCfqRgL6d9ZnNeWwcf/02szdnBBxRws7Ip4W/mmdDXmwtNLewTfh15ON9p4heF65TM37X0xw45HUDh7WEbwCNdV4z545bYxe5LzjdOuNcXSDOxygrEOrxgtK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976414; c=relaxed/simple;
	bh=Kp+7+tPAvccy71FanvJSzbOLd0z4kN89DqWYezw1OYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+Pklfw6CURlFJVa0qebXMuEKLNZCq7/6j2mYp+H2XGX4kTCdXCEyNy2eyDK2HswW5B6i14m0dQNKBhfFy77/qXrsvpPzZTv7gAuK02Y9lWjCbSGVnsz1lnoSP5pirzJcdn7yLGtmwY8PasmiRxeaSJsB5Un6TsXo2/UBcaA+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4Ol3iwJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4Ol3iwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD93C4CEED;
	Tue,  8 Jul 2025 12:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751976413;
	bh=Kp+7+tPAvccy71FanvJSzbOLd0z4kN89DqWYezw1OYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s4Ol3iwJuZ3bPifC90ngIr53J9DwqfI6SbJ5ng6mhsvmmhKJUSP01KISqF+xudx5r
	 OwNqQVnrJ4kgc1lmi+fQdvA0puZRnmrNIscNKhk5x+qQ848zPKeKACjmQZlA8St0fV
	 Wh5vNh7wUnm4qxPx7+pAli1/51YHFmtJSZMusuSZuTl+gmd4JhiDkCdnWCI/H5I1ks
	 daIfLQQN7QeyVcgmSHDG4twzeXB/Ep5gXJRK1YtdaaDN50mReflr3MzMrYthKL7TRa
	 VEK8qO2fuRa1AUaPB9bVOUF38SjH0Q+6EnxeFRNWiQ3OyIyapOpfsk4PRDL5JY2WCt
	 ethkWrczJo/aQ==
Date: Tue, 8 Jul 2025 15:06:47 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, iommu@lists.linux.dev,
	virtualization@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 0/8] dma-mapping: migrate to physical address-based API
Message-ID: <20250708120647.GG592765@unreal>
References: <CGME20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf@eucas1p2.samsung.com>
 <cover.1750854543.git.leon@kernel.org>
 <35df6f2a-0010-41fe-b490-f52693fe4778@samsung.com>
 <20250627170213.GL17401@unreal>
 <20250630133839.GA26981@lst.de>
 <69b177dc-c149-40d3-bbde-3f6bad0efd0e@samsung.com>
 <20250708110007.GF592765@unreal>
 <261f2417-78a9-45b8-bcec-7e36421a243c@samsung.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <261f2417-78a9-45b8-bcec-7e36421a243c@samsung.com>

On Tue, Jul 08, 2025 at 01:45:20PM +0200, Marek Szyprowski wrote:
> On 08.07.2025 13:00, Leon Romanovsky wrote:
> > On Tue, Jul 08, 2025 at 12:27:09PM +0200, Marek Szyprowski wrote:
> >> On 30.06.2025 15:38, Christoph Hellwig wrote:
> >>> On Fri, Jun 27, 2025 at 08:02:13PM +0300, Leon Romanovsky wrote:
> >>>>> Thanks for this rework! I assume that the next step is to add map_phys
> >>>>> callback also to the dma_map_ops and teach various dma-mapping providers
> >>>>> to use it to avoid more phys-to-page-to-phys conversions.
> >>>> Probably Christoph will say yes, however I personally don't see any
> >>>> benefit in this. Maybe I wrong here, but all existing .map_page()
> >>>> implementation platforms don't support p2p anyway. They won't benefit
> >>>> from this such conversion.
> >>> I think that conversion should eventually happen, and rather sooner than
> >>> later.
> >> Agreed.
> >>
> >> Applied patches 1-7 to my dma-mapping-next branch. Let me know if one
> >> needs a stable branch with it.
> > Thanks a lot, I don't think that stable branch is needed. Realistically
> > speaking, my VFIO DMA work won't be merged this cycle, We are in -rc5,
> > it is complete rewrite from RFC version and touches pci-p2p code (to
> > remove dependency on struct page) in addition to VFIO, so it will take
> > time.
> >
> > Regarding, last patch (hmm), it will be great if you can take it.
> > We didn't touch anything in hmm.c this cycle and have no plans to send PR.
> > It can safely go through your tree.
> 
> Okay, then I would like to get an explicit ack from Jérôme for this.

Jerome is not active in HMM world for a long time already.
HMM tree is managed by us (RDMA) https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=hmm
➜  kernel git:(m/dmabuf-vfio) git log --merges mm/hmm.c
...
Pull HMM updates from Jason Gunthorpe:
...

https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=58ba80c4740212c29a1cf9b48f588e60a7612209
+hmm		git	git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git#hmm

We just never bothered to reflect current situation in MAINTAINERS file.

Thanks
