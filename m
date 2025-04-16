Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EE0217F35;
	Wed, 16 Apr 2025 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826671; cv=none; b=dcivax1lsYGmnYzfs7ULMmgcVGWOmQbRG0dRhYJs3yOAiQ2Ddv9ADl9Rad1JwyJZ+/YUW5qrHeosCp8+rfaWGa1WKtTXfTdNU78KA0k7UtkOLV2sjABDMHzkWH6TtWWtY3iNg9LzNm/XpYnfXTiNSF8JUiK0iBxiDvGc0fKZjzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826671; c=relaxed/simple;
	bh=3tJ/br8DjU8waWGCy/RCXHnta0+4Yr9H9+0lpNJh3Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMKwJV6uvvziZNl7J5BUG2YhKj6nfc/Vmxxp4osCBpSVOROtN6my3IptMAHuq9fSKxcLBFzXiR8KSDTJZj74EQCs4aMm3HQvoybGh5YyHW/yKaU+dAQR8NTw5I2ZgPE3xKiyfYyKihX2djHx14676/TwCTzsGjCrGpbNgjBQMMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=F7lkSLyX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="F7lkSLyX"
Received: from DESKTOP-0403QTC. (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id E4B462052502;
	Wed, 16 Apr 2025 11:04:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E4B462052502
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744826669;
	bh=cNocqr+f4jd0PXhGNGZtTNkwX0S/kPbjIgYZzMTwGRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=F7lkSLyXPqicBGROFWe5YEm0hwGlmASQb80YXKtwsZdKz9r/3/gN1PQGdAqShudnu
	 +v0mrjCkpzH953U+sjY/DUzzoont8/OvrTQJoOkYgSiJkUrU4HPTb3sQevwEjmpgcQ
	 GSXZJl3606uFWjUOiB0PQ4koc8SYaXFQ26Yebg0M=
Date: Wed, 16 Apr 2025 11:04:27 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 virtualization@lists.linux.dev, will@kernel.org, eric.auger@redhat.com,
 code@tyhicks.com, eahariha@linux.microsoft.com, vijayb@linux.microsoft.com,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 0/3] arm-smmu: select suitable IOVA
Message-ID: <20250416110427.21bdd561@DESKTOP-0403QTC.>
In-Reply-To: <20250410230008.GA6905@ziepe.ca>
References: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
	<20250410230008.GA6905@ziepe.ca>
Reply-To: jacob.pan@linux.microsoft.com
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Thu, 10 Apr 2025 20:00:08 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, Apr 10, 2025 at 03:50:27PM -0700, Shyam Saini wrote:
> > 
> > Hi,
> > 
> > Currently, the MSI_IOVA_BASE address is hard-coded to 0x80000000,
> > assuming that all platforms have this address available for MSI IOVA
> > reservation. However, this is not always the case, as some platforms
> > reserve this address for other purposes. Consequently, these
> > platforms cannot reserve the MSI_IOVA_BASE address for MSI.
> > 
The fundamental question remains: why is using IOVA 0x80000000, an
arbitrarily chosen virtual address, a hardware issue?

> > There was an [1] attempt to fix this problem by passing the MSI IOVA
> > base as a kernel command line parameter.
> > 
> > This patch series aims to address the issue by introducing a new DTS
> > property, "arm,smmu-faulty-msi-iova" which can be used to hold
> > faulty MSI IOVA address. This property can be passed to ARM SMMU
> > drivers via device tree so that the drivers can select appropriate
> > MSI IOVA base address which doesn't intersect with the faulty MSI
> > IOVA address.  
> 
> I thought we already talked about this and you were not going to be
> doing a DT proposal for a software knob?
> 
> And then you didn't even link to the recent discussion :(
> 
> https://lore.kernel.org/linux-iommu/20250403232619.GA681099@ziepe.ca/
> 
> It is easily solved in the smmuv3 driver without out any DT. Please
> do that.
Given the above fundamental question answered, then we do have a
platform specific IOVA range to avoid, IMHO it must be enumerated via
DT or some other means to avoid conflict.

Per last discussion "SMMU driver have a list of potential addresses and
select the first one that does not intersect with the non-working IOVA
ranges.". If we don't know what the "non-working IOVA" is, how do we
know it does not intersect the "potential addresses"?

Thanks,

Jacob
