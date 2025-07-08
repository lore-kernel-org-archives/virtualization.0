Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793D8221D87
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979391; cv=none; b=tvVgBxFs+FuBZ3nRk0ut2GNCmmMWZ10QDpME/XzX+DAYJ+L2yaK9RaHxvCWCKedoWmdWgTje1mqiZPBMYBbwAVgTJNZ3X2Wzw/bUPTE4EosMg8lTuAXyRU3wFLcJ0XVvFYxr0Cb7WbzgCg0P860dXeuTuQf2itqy93aCPqlwM/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979391; c=relaxed/simple;
	bh=tJRA7m1/e900tlxVd4Za+3wH7OTzUtyyJem1XRv1vJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=DlUGzEzlxPAbeKiBHzYuqc2bQkc93BH0U/tItI9iNxTV2rByoBj29FG5K65YCyHc9WiTlpGn+9BsHSvIGxk4WjVePj68v2qdaJiSXCY4NTxOx2dn+DXLiXOevZ6/0XZWNp+2xyxFHxIA222iQf5wwksBh12rb/8leNjk1EcxFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rUMpLiKt; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rUMpLiKt"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250708125626euoutp01481090aca999c360f1cc421345410614~QR-hIpaRH1038310383euoutp01B
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 12:56:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250708125626euoutp01481090aca999c360f1cc421345410614~QR-hIpaRH1038310383euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751979386;
	bh=7/XLYR0OqGT6q8wsQL9awTM8RahowyCK2kF3Lml5n78=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=rUMpLiKtylansmwZEOTSLIDw3e88apapi9cZUeM+VwB6dnZwW74YiawcqeB7aNHsz
	 phmldqGZGmgcE5mbHZFMvy+/ua/qmdnZrQIXXdjq/6DIcaz3yi5eWLpP0dS+1ew2NU
	 O2DMyf6ZjkU0E5KGbps8p5YBy+HTdwiEMA3XvUgM=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250708125626eucas1p10fea4e2440d7273510ca606b8c879240~QR-go19vo0583905839eucas1p1z;
	Tue,  8 Jul 2025 12:56:26 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250708125622eusmtip2e8d499202aebc1a18605d526cd72bbdc~QR-dBQdu70489204892eusmtip2-;
	Tue,  8 Jul 2025 12:56:22 +0000 (GMT)
Message-ID: <39d43309-9f34-48bc-a9ad-108c607ba175@samsung.com>
Date: Tue, 8 Jul 2025 14:56:21 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] dma-mapping: migrate to physical address-based API
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Robin Murphy <robin.murphy@arm.com>, Joerg
	Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Michael S.
	Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alexander Potapenko <glider@google.com>, Marco Elver
 <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux.dev, virtualization@lists.linux.dev,
 kasan-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250708120647.GG592765@unreal>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250708125626eucas1p10fea4e2440d7273510ca606b8c879240
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf
X-EPHeader: CA
X-CMS-RootMailID: 20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf
References: <CGME20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf@eucas1p2.samsung.com>
	<cover.1750854543.git.leon@kernel.org>
	<35df6f2a-0010-41fe-b490-f52693fe4778@samsung.com>
	<20250627170213.GL17401@unreal> <20250630133839.GA26981@lst.de>
	<69b177dc-c149-40d3-bbde-3f6bad0efd0e@samsung.com>
	<20250708110007.GF592765@unreal>
	<261f2417-78a9-45b8-bcec-7e36421a243c@samsung.com>
	<20250708120647.GG592765@unreal>

On 08.07.2025 14:06, Leon Romanovsky wrote:
> On Tue, Jul 08, 2025 at 01:45:20PM +0200, Marek Szyprowski wrote:
>> On 08.07.2025 13:00, Leon Romanovsky wrote:
>>> On Tue, Jul 08, 2025 at 12:27:09PM +0200, Marek Szyprowski wrote:
>>>> On 30.06.2025 15:38, Christoph Hellwig wrote:
>>>>> On Fri, Jun 27, 2025 at 08:02:13PM +0300, Leon Romanovsky wrote:
>>>>>>> Thanks for this rework! I assume that the next step is to add map_phys
>>>>>>> callback also to the dma_map_ops and teach various dma-mapping providers
>>>>>>> to use it to avoid more phys-to-page-to-phys conversions.
>>>>>> Probably Christoph will say yes, however I personally don't see any
>>>>>> benefit in this. Maybe I wrong here, but all existing .map_page()
>>>>>> implementation platforms don't support p2p anyway. They won't benefit
>>>>>> from this such conversion.
>>>>> I think that conversion should eventually happen, and rather sooner than
>>>>> later.
>>>> Agreed.
>>>>
>>>> Applied patches 1-7 to my dma-mapping-next branch. Let me know if one
>>>> needs a stable branch with it.
>>> Thanks a lot, I don't think that stable branch is needed. Realistically
>>> speaking, my VFIO DMA work won't be merged this cycle, We are in -rc5,
>>> it is complete rewrite from RFC version and touches pci-p2p code (to
>>> remove dependency on struct page) in addition to VFIO, so it will take
>>> time.
>>>
>>> Regarding, last patch (hmm), it will be great if you can take it.
>>> We didn't touch anything in hmm.c this cycle and have no plans to send PR.
>>> It can safely go through your tree.
>> Okay, then I would like to get an explicit ack from Jérôme for this.
> Jerome is not active in HMM world for a long time already.
> HMM tree is managed by us (RDMA) https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=hmm
> ➜  kernel git:(m/dmabuf-vfio) git log --merges mm/hmm.c
> ...
> Pull HMM updates from Jason Gunthorpe:
> ...
>
> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=58ba80c4740212c29a1cf9b48f588e60a7612209
> +hmm		git	git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git#hmm
>
> We just never bothered to reflect current situation in MAINTAINERS file.

Maybe this is the time to update it :)

I was just a bit confused that no-one commented the HMM patch, but if 
You maintain it, then this is okay.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

