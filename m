Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F7A2836B5
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970443; cv=none; b=r9DosdnVTBmth9i0PU6Wyts/tQzWJ9XmtdKRSvfB1JuEsgaFFfbPOVG1xgSvmCBeZz7ch4TDh0a0fJ0wSe0Zo0ksxz36kKFumXJi6wDCvEzQ+lx9JYkacQbM8DczxFEJFzU1CMK5sJANjEIzVJEfIcRTMBEQVdShXVmZ308wML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970443; c=relaxed/simple;
	bh=14manGusg8Qgqx1rKMesK88ejf15XhHcScCCmKXCkgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=FPaMU4tvx7mxXany6DyzXVHtrgGbio0/Uqey3ff6eBthYUHyL6OelCH6t3ykoaYqM2v6LHhpE+bmoEg82EtktVrYX1S9rfzc0ALnNIRQGB5KRXIBQO6tigNOoD/7qQfujTXvGKaBwzDgJ05JIGsCQrz2IGRMra4GHlm7Wq+jBsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=F008LidY; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F008LidY"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250708102712euoutp01f528973a4c78bda2a0ba279450904eb6~QP9ONuIwy2622426224euoutp01b
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 10:27:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250708102712euoutp01f528973a4c78bda2a0ba279450904eb6~QP9ONuIwy2622426224euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751970432;
	bh=CvHwMYp2XIGbJnf/9QWS8C8NtBZtZV/va6aW8p1Pd0k=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=F008LidYzvfh2j0RaYHTMgLK3oM6mF0Yc30pV8DYIYJ63cif9vHmCcNRRBaOZXuE5
	 bNk24ajaoAplrZQOsXjt1dEV2BYlfoenSYAE1z/tvVb0mjKVzlBGiCFN/CP6TshfXE
	 SMyPamwp2HmagXjrE5FMphrgU3Cfd7ZXMqQ0EBV8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250708102712eucas1p1199b906d3c40b7ff5066a92aacd7b14c~QP9NsRWhM2715427154eucas1p1l;
	Tue,  8 Jul 2025 10:27:12 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250708102710eusmtip12ad336592b93f91919ed398faf3d4122~QP9LytFDz1124711247eusmtip1B;
	Tue,  8 Jul 2025 10:27:10 +0000 (GMT)
Message-ID: <69b177dc-c149-40d3-bbde-3f6bad0efd0e@samsung.com>
Date: Tue, 8 Jul 2025 12:27:09 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] dma-mapping: migrate to physical address-based API
To: Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
	Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will
	Deacon <will@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
	<jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, Alexander Potapenko
	<glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov
	<dvyukov@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
	Desnoyers <mathieu.desnoyers@efficios.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
	<jglisse@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, iommu@lists.linux.dev,
	virtualization@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, Jason Gunthorpe
	<jgg@ziepe.ca>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250630133839.GA26981@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250708102712eucas1p1199b906d3c40b7ff5066a92aacd7b14c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf
X-EPHeader: CA
X-CMS-RootMailID: 20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf
References: <CGME20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf@eucas1p2.samsung.com>
	<cover.1750854543.git.leon@kernel.org>
	<35df6f2a-0010-41fe-b490-f52693fe4778@samsung.com>
	<20250627170213.GL17401@unreal> <20250630133839.GA26981@lst.de>

On 30.06.2025 15:38, Christoph Hellwig wrote:
> On Fri, Jun 27, 2025 at 08:02:13PM +0300, Leon Romanovsky wrote:
>>> Thanks for this rework! I assume that the next step is to add map_phys
>>> callback also to the dma_map_ops and teach various dma-mapping providers
>>> to use it to avoid more phys-to-page-to-phys conversions.
>> Probably Christoph will say yes, however I personally don't see any
>> benefit in this. Maybe I wrong here, but all existing .map_page()
>> implementation platforms don't support p2p anyway. They won't benefit
>> from this such conversion.
> I think that conversion should eventually happen, and rather sooner than
> later.

Agreed.

Applied patches 1-7 to my dma-mapping-next branch. Let me know if one 
needs a stable branch with it.

Leon, it would be great if You could also prepare an incremental patch 
adding map_phys callback to the dma_maps_ops, so the individual 
arch-specific dma-mapping providers can be then converted (or simplified 
in many cases) too.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

