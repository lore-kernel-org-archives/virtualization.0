Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA07083C;
	Sat, 19 Sep 2026 07:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789803251; cv=pass; b=nP5MJZ800sGQ94/gaPHr8auDTd+TWP8L9WFPM85WE2a7YZmXqxESQwf8l2RFT/mmfmiai4T11KDkpAluktJbGC0nSgc1rk6DbjynO4793GqIBlclDPFmotedLcLApK1DjQpxfu4HPnMul7sgE/EyD2EtVhTOmxDvzNuIa8VEZno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789803251; c=relaxed/simple;
	bh=llg/PF8nMnnpezaHPpy9KBWeZf3PiiHR8A/GPkRQCtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWj/pp3tGWuDjIS8U4sw+bvkS6glp/91kwJoSmJGv4K6Z11/DXf9Tc1bTADDDFGQES+ZltW4vgXwSy+1BAUCTVAWuVzWU8b7gn3dV6itoF7wTE87alYid1+Hao9e2NRtnjQ5PRc30ftRITA/loTznc8RGar+rDCAgFXLhDixfTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=QM7y3zqc; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=UpO1qiOn; arc=pass smtp.client-ip=185.56.87.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="QM7y3zqc";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="UpO1qiOn"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com; s=arckey; t=1789803248;
	 b=OhJk+gykLbfnab+nyPQc2vU/jzqdQkiQDSZoxgRJOXAxk7Cfm2yDGsUSFhFr9Nh3li5SgocvPD
	  ToWZ3IRmeMvl3KiFIYSw+lvVuTnXpffVfMLZ6dUho6HC6c97DVgybZqgG+Z0ACeWziTj8H8KHy
	  R79V1TwIBIRaBe78nv9iSaMt0kEYRyfYBULCIjJGeCpEGwcTXFH/AXTvPBiNu+lxDfm7xhrdly
	  oMJjo/J9hEpx7L9FlHAE8XAt29mhybxzWT/y0MloPgpKP3LbQsK6IhXk4FS2X2BOav+vwSHQOH
	  bwx8+JuufmQO20T8AJI4R6oYaRR91FrzsHM+qBeM30d+Hg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com; s=arckey; t=1789803248;
	bh=llg/PF8nMnnpezaHPpy9KBWeZf3PiiHR8A/GPkRQCtQ=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=V4Njr3XNcf0x5fLmZHSqFsD9oy06ks50IBpkf5zZoOsvO013o4hXE24dIIeJcDxC9sET9Nu6+4
	  tSSgdwgsC6PBUJL4yKNAYlcwAH713KHQhI2NZtSAjlybVk23a0JmRZqqVMTFpySyPtex/UxVKi
	  PYWMoUivTFZ+olfUbK7mdq/O3LNtpzOxbtrjodg2iT8xV79skrx6rEmsSGWBz1rDlYrmKPoKJu
	  e7awLOauUAq/rjYlL+qLvo9Hupmft3dPjdUa8TXyrjZTiOQM3VuuDchUtvmvGcg8M4hnE91R9Y
	  oeodhBF2VweBLYKP/tuTZbUEYKCm85L6tTas5o+BQxL0JA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=1CgMYzN7u/XA+bnop2JDgsNdowKH5ww277Ab2jeFzYI=; b=QM7y3zqcSH2FlgocRfPPmbaMad
	3V+YineFUsBAjj1eS9GdJ5apHLMBjN2XESzhZZzeglXvSZlp1iwbuSFkPcJILFAkxbV9CdUCplI1I
	HOeFBUHCnmKQNRSUp1Hw+yuMYuCnn53BsjWpBoQNXfoISQWUSqwSJpAa9EzYGeterYoo=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x7pa8-00000005bxU-2Wr0;
	Sat, 19 Sep 2026 07:33:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=1CgMYzN7u/XA+bnop2JDgsNdowKH5ww277Ab2jeFzYI=; b=UpO1qiOnq7xdcWjgHZmVoz6PH6
	qnX8EWkbIbCQnHos0YlsXjQrPVX98//3jAxv0fogZLwImFWx8HL4sgPGe3Cd6N7yD0LUfSxLJvPzr
	CCHTUlfULmZRgWrMaDWDzF0qYbREJFaOi177rp4/VFmpRK+nl7GD9XvXkPWjmtJwzthc=;
Received: from [95.75.45.71] (port=45394 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x7pZp-000000006o5-4BDY;
	Sat, 19 Sep 2026 07:33:38 +0000
Date: Sat, 19 Sep 2026 09:33:36 +0200
From: Francesco Valla <francesco@valla.it>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	virtualization@lists.linux.dev, imx@lists.linux.dev, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 00/12] remoteproc: add support for any virtio device
Message-ID: <aq453yukMHiNb1jp@bywater>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <aq1sooGCYUiWbhMH@p14s>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq1sooGCYUiWbhMH@p14s>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 8e767977f36cde42fc16bbf5074ec7b6
X-AntiAbuse: ID - 8e767977f36cde42fc16bbf5074ec7b6
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1x7pa8-00000005bxU-2Wr0-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Mathieu,

On Fri, Sep 18, 2026 at 10:53:54AM -0600, Mathieu Poirier wrote:
> Hi Francesco,
> 
> I have started reviewing this set but given the size and implications, it will
> take me a few days to get through.

I'm going through the review done by sashiko - would you prefer me
sending a v2 with the trivial errors already ironed out before doing
a complete review?

> 
> Thanks,
> Mathieu
> 

Thank you!

Regards,
Francesco

