Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC99A95E;
	Tue, 25 Nov 2025 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764079738; cv=none; b=Sr6KH7k68KtByKUeQltroC7El7YeJZmAJXRIDtR+V5lzoWMmkGztoL31KUdC1llxXVmT3bz1r1ck5jEc4xpZss3/am0iuvBhdrQ1UhEF2TXy8pLxnwVjRtQ1QcW5da9Y1oGQdXN2BuRrIpjdCoDL7Cw1vEPv44Ro/E9k845O2HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764079738; c=relaxed/simple;
	bh=6shWEwZvxqHiqZ/Czou3bt42w4dc1McXIARMK0/hTh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEKk+IkDZbDlUEm79fTJwdHp7jHh1tDr2B35Yi/N8y4Fyl1S0JpX9zEXElBpK7w4S8iAOOXCou8zpvECH7l5YiEtwodgGIcvwPccy5RFptnXFMpS4zkYm66yLRsKIemF+yIe78BSNzA3u2ToL5radR0lwbNLsuoI4ZkrK8vMJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=UTSUctaj; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="UTSUctaj"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A3B405C40D;
	Tue, 25 Nov 2025 15:08:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1764079734;
	bh=6shWEwZvxqHiqZ/Czou3bt42w4dc1McXIARMK0/hTh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTSUctaj7BEiNZvyAvlKtijcsv40P7JUkkZbyhDTpJ0HUISp/Hya+v/vsn5EbYM4w
	 4Ef8zvC5R8T2xVZ9ly7Ua5fJxbkSYJPZFiXK4jiGTai6Z1vBT+V6b2HKeHDFSu/vaG
	 qDJjwOWUc2qNs0d+FmHtakO3OMA+oIMRg+4bgXSA7jQK425B131oobikVwGbveoG02
	 u8xmKSC+pPplcwn3C5wXy+0MlKMvMiVeAPJoiAPBmsZXEDnKrFNi85KoReBPwwLU74
	 MeiPuwJgQXftGbPBHlgzgJ18yIvfl+7hmcBBA+HHHlejcsp26cb9ntefkRq56Rr5zc
	 CK3zwoTz/jNtA==
Date: Tue, 25 Nov 2025 15:08:53 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: will@kernel.org, rafael@kernel.org, iommu@lists.linux.dev, 
	virtualization@lists.linux.dev, Jean-Philippe Brucker <jpb@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update my email address
Message-ID: <n3avdxsr54rcsnkntcyi6ducdz7xspgkp6mlikekulwmpcrrdn@ys6li34w63zf>
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

Applied, thanks Jean-Philippe.
