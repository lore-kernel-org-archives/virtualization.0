Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A4C1A275;
	Mon, 24 Nov 2025 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763990413; cv=none; b=lcHyzaho6o2UmQfGdtnRu1VhVVCfKIblrMfguSMlNTEB9ezadHwpOKEC0viE225HQG14gv+1Bxql41AeBBOYXiPr5i9Vxv3YRo+6b44KujOAOXE37KUSmhsa1tPYLTftnNLivToS8l0OfGCY1dX3BEHjd3T2QCwQM65LZv+nK7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763990413; c=relaxed/simple;
	bh=rx302HjD0z3XjRuQkJynPSzfyeVj6NJsaqjhFRUtBTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igMarh9vyWneg/0QHPsr7EUB8chCYxk6cOfX9d3gswyhIRwlHl8CGrKbpE8pbx0Fw7iXTxANuDuSuBW4UKZA5d0tNr+6u8RPGIjovWg2fEkNuALyXl3rKXK0s3Q5wYSG76vf7QnO0N9Ue0hpMqWNFBhjJ6b5JqAI4Lk5xwgwepE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHbPMqHt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHbPMqHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6005FC4CEF1;
	Mon, 24 Nov 2025 13:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763990412;
	bh=rx302HjD0z3XjRuQkJynPSzfyeVj6NJsaqjhFRUtBTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pHbPMqHtVYO18U4RxzouW1i/vPFowiT4jZrWHcjpgKo/9lDGXHDT9PidMLeqcue52
	 W7va1Zh7/uMzIF1TqXshVASeBRNK3B5oLdFRJDrfo3l24Vsee8cVQIkDOfLK0/KydO
	 AwBMaBDfS1awM22zYiGP6DNbPRMlIkpHVG6p9SsV7e2sum2F4w8SRY02JyRKfD0Oy2
	 la8wIMrPBf1xEPMrEE3+kXhiIPM/U8uosi2IAlAWlMcA6CSrBn2qONGGpazHvvV4X+
	 CoidHPrfPbPcbuCLmGdWudkf0ELt8RL8nYvkGCY5hWVgf97RfxFPmU0lFQdh+Fqz8s
	 epv2HNP/Av2AQ==
Date: Mon, 24 Nov 2025 13:20:08 +0000
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: joro@8bytes.org, rafael@kernel.org, iommu@lists.linux.dev,
	virtualization@lists.linux.dev,
	Jean-Philippe Brucker <jpb@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update my email address
Message-ID: <aSRbiP8JlBppZsbf@willie-the-truck>
References: <20251120134621.277272-2-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120134621.277272-2-jean-philippe@linaro.org>

On Thu, Nov 20, 2025 at 01:46:22PM +0000, Jean-Philippe Brucker wrote:
> Use jpb@kernel.org as my main address.
> 
> Signed-off-by: Jean-Philippe Brucker <jpb@kernel.org>
> ---
>  .mailmap    | 3 ++-
>  MAINTAINERS | 6 +++---
>  2 files changed, 5 insertions(+), 4 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Joerg -- please can you pick this one up?

Cheers,

Will
