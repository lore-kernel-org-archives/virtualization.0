Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2AB2DCBEB
	for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751031861; cv=none; b=MtRroTqcKnxpKYJN92Z6SET92UOZlYSRfOnyCBCCQ7/JNLNnNV71jKLhOjx9wducH9don+pQwkPF1oPQrGbH8YDdvtE3v85z3HwpOB0x3ilAkcFaOMB3cxxKN2tqe7nJ9WNVet5EjCOVSAwvf4tKNGOTG3yXN7Tqw9sgUJLjs1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751031861; c=relaxed/simple;
	bh=5rws0OIbeHe2CRb1G1qFVEHOO3Qznulp1JmZYPqVS5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ev8WnZ2aCz0AOotOqlLsOlqs7fE/dMnpwXLnyE6uLA+HNzH6sdYP+xBWe0/iunTRZl97OVWHPJkOmaXdsek8QsUxd+tJl0xn0Cx1VOM4UqQr4ld5Ln2Skw5Eq2+VI/S1sYZMuUqDWbOKPqB0PNl1RvNrHNfjv0OG9kEeGvAmp1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WhvmDKIT; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WhvmDKIT"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250627134412euoutp022e0410b873d5f15db65e9aa0719f6f3b~M6jFZ4ebb2625726257euoutp02J
	for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 13:44:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250627134412euoutp022e0410b873d5f15db65e9aa0719f6f3b~M6jFZ4ebb2625726257euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751031852;
	bh=XkLT3H6zpZxdqKr2mL/WBFZuhTWHNBcRcJJv1Mo/N0Y=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=WhvmDKITyLEkhw3MRTwTgoaWKOjFTMjKnV8wJOos+T/cXs8qV0a45KyYKjjHHphNR
	 ejlC6A7c/3G9ZGM0g5x9rtRdfSUOXwvaNPvqe2cEjseVkiFdxFjJMEeYZdJBH545i+
	 hY7QPcy7sQUOkaipwLKySn5wWBeenoGfWxQTqISc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250627134412eucas1p153bc3e4a1c0897bca604e6864667b66d~M6jEutC8v1155611556eucas1p1O;
	Fri, 27 Jun 2025 13:44:12 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250627134410eusmtip109d5d74275daabf2f21b42eb7440b88b~M6jDFXzcn2675526755eusmtip1I;
	Fri, 27 Jun 2025 13:44:10 +0000 (GMT)
Message-ID: <35df6f2a-0010-41fe-b490-f52693fe4778@samsung.com>
Date: Fri, 27 Jun 2025 15:44:10 +0200
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
In-Reply-To: <cover.1750854543.git.leon@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250627134412eucas1p153bc3e4a1c0897bca604e6864667b66d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf
X-EPHeader: CA
X-CMS-RootMailID: 20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf
References: <CGME20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf@eucas1p2.samsung.com>
	<cover.1750854543.git.leon@kernel.org>

On 25.06.2025 15:18, Leon Romanovsky wrote:
> This series refactors the DMA mapping to use physical addresses
> as the primary interface instead of page+offset parameters. This
> change aligns the DMA API with the underlying hardware reality where
> DMA operations work with physical addresses, not page structures.
>
> The series consists of 8 patches that progressively convert the DMA
> mapping infrastructure from page-based to physical address-based APIs:
>
> The series maintains backward compatibility by keeping the old
> page-based API as wrapper functions around the new physical
> address-based implementations.

Thanks for this rework! I assume that the next step is to add map_phys 
callback also to the dma_map_ops and teach various dma-mapping providers 
to use it to avoid more phys-to-page-to-phys conversions.

I only wonder if this newly introduced dma_map_phys()/dma_unmap_phys() 
API is also suitable for the recently discussed PCI P2P DMA? While 
adding a new API maybe we should take this into account? My main concern 
is the lack of the source phys addr passed to the dma_unmap_phys() 
function and I'm aware that this might complicate a bit code conversion 
from old dma_map/unmap_page() API.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

