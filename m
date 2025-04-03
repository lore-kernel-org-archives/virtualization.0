Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F11253F29;
	Thu,  3 Apr 2025 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708908; cv=none; b=hei7RZLFZoy/ANRjO6WL4dpqDFoSB2tp4z4X884KjUnIm+CxkavMkHHMtMefIDyIEijj3G5dgZ3oD3rx4L/BXDdDpiVlDxM3cGUhI23J2L9D/Jqps1+MxULIMbVMCrsmFYyTBRFnxl4SmgqHbmbTTBo2E8fNbDD0fFG7OGvdjtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708908; c=relaxed/simple;
	bh=0VN27CkAPisN4M9bSrNziMSMrZTpXl/LiYh23z7nmus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZKDt7mx/MMRfIxwE1Wd64hfKZ1PJ988c4wCEhh4iBhKpJP3XtJMpNG+6xCKfLQo+94sQYMpqML0CUSai+j7Ou5GmwusIvja6Ot/OtUl+g6Q8BsarvnZ9fSKQUpHGjzWlzJTbg8o8j/wGdzSp35tYU00j5WIAOpl2xdbIsH9vK9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XV7c57UK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XV7c57UK"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9BE67202565A;
	Thu,  3 Apr 2025 12:35:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9BE67202565A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743708905;
	bh=tToTvqgjKjFgEpiH/wvd2sZhq/aLX91Kukol3CuCkpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XV7c57UKnez5RKqG/At88TciQqS/Rn/wFVhMqxC4ViVJKqJ+xmD1pMNLdpmTrUQCA
	 GXSPQxVF1xo03IZU1KvzigOm5aaMWdk9WjKQRQ4uKvkjmxfT9czgFWyZ8PDGQfDZeK
	 UY+VF1RFjpwsXMo0AgZSlbu6Ro82uyp1n7tLcT14=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: jgg@ziepe.ca
Cc: code@tyhicks.com,
	devicetree@vger.kernel.org,
	eahariha@linux.microsoft.com,
	eric.auger@redhat.com,
	iommu@lists.linux.dev,
	jacob.pan@linux.microsoft.com,
	linux-arm-kernel@lists.infradead.org,
	shyamsaini@linux.microsoft.com,
	vijayb@linux.microsoft.com,
	virtualization@lists.linux.dev,
	will@kernel.org
Subject: Re: [PATCH 0/3] make MSI IOVA base address and its length configurable
Date: Thu,  3 Apr 2025 12:34:58 -0700
Message-Id: <20250403193458.158085-1-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131003618.GB2296753@ziepe.ca>
References: <20250131003618.GB2296753@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jason,

> On Thu, Jan 30, 2025 at 03:21:37PM -0800, Shyam Saini wrote:
> 
> > Unfortunately, it is an HW issue.
> 
> Well, that's pretty bad to have built HW that can't DMA to low
> addresses at all.. But OK.
>  
> > Are you okay with this passing custom MSI_IOVA via DTS approach ?
> 
> It isn't up to me, but I've understood the DT maintainers would reject
> this as it isn't is describing HW but just a random Linux software
> knob.
> 

If i understood correctly MSI window IOVA is hw property, if yes then it should be accepted
by DTS folks, did i misundertstand that?

> I think you should make selecting the sw_msi dynamic in Linux.

My understanding is that if we have to make it dynamic, we have to use iova allocator
that would need iova_domain as a member of struct arm_smmu_domain,
and allocate iova for MSI window dynamically using alloc_iova() in arm_smmu_get_resv_regions()
is that what you meant when you mentioned selecting the sw_msi dynamically?

later we still have to [1] re-adjust the final iova list to IOVA range - resereved regions (msi)
[1] https://elixir.bootlin.com/linux/v6.13.1/source/drivers/vfio/vfio_iommu_type1.c#L2232

so either static or dynamic, we seems to need MSI allocation

Please let me know what you think about this?

Thanks,
Shyam
