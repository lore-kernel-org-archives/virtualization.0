Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5EB21CFF4
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751975128; cv=none; b=hM7vmASWw0NofnLgzFirLApRkicDonUjrTAxgK+KIzwwE6ThKkGnAVRrrIDrEZSKlHNLk9ZuXAx4ftVgARNUTX9DipcbqVAMN8VFKWaf84iBonJiEXlUpOrxLu554ivFoKw4vT89aujmDlRIFAh4XI6FphXdl85NV5I9nH5b2r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751975128; c=relaxed/simple;
	bh=dDGmDdXbAVgOpktFUq0Y8CUWVS+LmZQ4NuInAHKnznw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=nA6kVgAfIUgSGS+5Vq4hfKfTWPAsZ1WQgOvSrkgh71KlT8Z9ivgE9O5JUsgs5WXKyrhBkNwL7mH/z4RCVLYb39etZF6i7fMpmBxqzs394S/hultxsF6Tv4YWA7HD9FXFTFyMN0mCmHWVlVkAWWkZsP9dQvclrea1pjPtNYaxLKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hTSmuD7o; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hTSmuD7o"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250708114524euoutp02874ae2a8147f7166e165411c840cc85c~QRBfdOzRL1897018970euoutp02n
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 11:45:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250708114524euoutp02874ae2a8147f7166e165411c840cc85c~QRBfdOzRL1897018970euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751975124;
	bh=1ym+ZPwSAJBlUJTRBRpHOrnxcWfoWCspHKNp3aF96Zc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=hTSmuD7oMDEzit2qwO94PA3KuPM3t2VfPla+ZeQLlhsNzfaZcuY74yloqGgMlREzO
	 CsGI/sYzA9Yc1mk5B7u3++o5ws1E5d1puriNBi3OjaJXBAd0aHxnL7ewrUPjNlgXd6
	 LV3oL4gOBjFPocvDRFQB7NcOwi5rH+2xd/RpiYis=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250708114523eucas1p2d8771c6a0d017b9bb67a6528e7582617~QRBe5i9Re1494914949eucas1p2S;
	Tue,  8 Jul 2025 11:45:23 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250708114521eusmtip2651e660db53304d0ed855a7d7f6ea665~QRBcy78Hv2034520345eusmtip2O;
	Tue,  8 Jul 2025 11:45:21 +0000 (GMT)
Message-ID: <261f2417-78a9-45b8-bcec-7e36421a243c@samsung.com>
Date: Tue, 8 Jul 2025 13:45:20 +0200
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
In-Reply-To: <20250708110007.GF592765@unreal>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250708114523eucas1p2d8771c6a0d017b9bb67a6528e7582617
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

On 08.07.2025 13:00, Leon Romanovsky wrote:
> On Tue, Jul 08, 2025 at 12:27:09PM +0200, Marek Szyprowski wrote:
>> On 30.06.2025 15:38, Christoph Hellwig wrote:
>>> On Fri, Jun 27, 2025 at 08:02:13PM +0300, Leon Romanovsky wrote:
>>>>> Thanks for this rework! I assume that the next step is to add map_phys
>>>>> callback also to the dma_map_ops and teach various dma-mapping providers
>>>>> to use it to avoid more phys-to-page-to-phys conversions.
>>>> Probably Christoph will say yes, however I personally don't see any
>>>> benefit in this. Maybe I wrong here, but all existing .map_page()
>>>> implementation platforms don't support p2p anyway. They won't benefit
>>>> from this such conversion.
>>> I think that conversion should eventually happen, and rather sooner than
>>> later.
>> Agreed.
>>
>> Applied patches 1-7 to my dma-mapping-next branch. Let me know if one
>> needs a stable branch with it.
> Thanks a lot, I don't think that stable branch is needed. Realistically
> speaking, my VFIO DMA work won't be merged this cycle, We are in -rc5,
> it is complete rewrite from RFC version and touches pci-p2p code (to
> remove dependency on struct page) in addition to VFIO, so it will take
> time.
>
> Regarding, last patch (hmm), it will be great if you can take it.
> We didn't touch anything in hmm.c this cycle and have no plans to send PR.
> It can safely go through your tree.

Okay, then I would like to get an explicit ack from Jérôme for this.

>> Leon, it would be great if You could also prepare an incremental patch
>> adding map_phys callback to the dma_maps_ops, so the individual
>> arch-specific dma-mapping providers can be then converted (or simplified
>> in many cases) too.
> Sure, will do.

Thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

