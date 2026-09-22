Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB2A4C77C8;
	Tue, 22 Sep 2026 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790058597; cv=pass; b=VmaoYJ98aj56z4Bx49Q0djSM7rbPL/vGCix4DG6Ewc+W9zmsEo0Z7Dt3/cSAX7mMP/7/NqoQmG0N0u0jATeIlRQIEOwkUuxSKZMGSzzY2+dXaUg+eecdBDRAwmRqpELT0U+0DttSPaOXUQ1siEuz4xPwVco1BMzCAlO3rEVvtrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790058597; c=relaxed/simple;
	bh=0Y/NG4nMOalFGTSNp/BfF0N3WtHCZpwOLy9J6i30EqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5bGmmAh/VVtZNoOFyu1GvSH2YQQm6JvELO2NZ/yl11aZCS4R7NU41SwwchY5I6cHnUTzu8RIN8rr9x6v/Z6cCR39g9M1LkoFmMW4+ahzY239tDjIaSFp9eZtuRxb8Bx3hjr8Bv5i7Tyba+s2c/zDjKH9SSawODYo3SqqB13bSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=2S39SToW; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=T5UqOveD; arc=pass smtp.client-ip=185.56.87.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="2S39SToW";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="T5UqOveD"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-xhtg.prod.antispam.mailspamprotection.com; s=arckey; t=1790058596;
	 b=SYSo5LeOU/TUDjRWeiCRSNrsJY1RdtonEuXcO0Tp8EThLegw/7o7Nsk38Yi9nEndGhkEvgDsE7
	  4vmwQiGlcDZor+XHnaz4jHofwNxUW+OaLLyHlgIya6KAFXOdB7rc07/MAGjqKn9bvEkWBOXWWP
	  fA9Z0FWVaz26IdtnN9oALEAF2NVau15byp5pBkdp5pSq3BNlOZbOr5BhhAB9LbiTIxpSWe2Aqi
	  i/eVB0qt3EIEkk3iFlPS2rE7WmTWQ1g283kIlybyZND97Em3BVCJoR2l6W6gjEBlyCm4htdE3i
	  CcvVkUYV/p1vRAhgEKiTSq+IhB0IaWs77jAbaddngqqsrg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-xhtg.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-xhtg.prod.antispam.mailspamprotection.com; s=arckey; t=1790058596;
	bh=0Y/NG4nMOalFGTSNp/BfF0N3WtHCZpwOLy9J6i30EqE=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=nLFwcEVeCnhiaR+v4C5ZsFuOYlE6TsLkutfp1JjEQ2VISzagLPHESw79VGfPrh11+YS3bY9SZF
	  dm0uRq/P/leXrUfW16Vcx0LrY2B49pwiSEpgdUx2Ql8IBZO8exoJd/VXwwc4zC+ORkeWxINdXi
	  q7JTesk6UF7mUnF3xjxNHn4bHyY5nsVCQBx/5DwRiGaqIaqvdFoHmuRIwnIFEvWrkzKoWtrXu6
	  M13rfQfA3HM5b8IgKEsj2NVjO9ROPOv7z1L5yrEpWvh+dbrqTZNHHU7DsBQsm19apO3yf8/cyc
	  C4C6PV4NBHSGEphjeqinovdCXgjh/vEmJK9TwRj9rpvW5A==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=5TziHwaXDLNZErCA1Nv3YhRq2q9+6p4PN2Do0dxKr38=; b=2S39SToWOKjfbbp0s7YU0bl5MS
	x/R8aAYJwtb3PD2w1cX53X+suRYOf9Kn31WHJMc16CV8hLsNo7DTafmNJ7hOUOxHjDsJ+5kuqfvF9
	rQHzL3FcYmA2O40pil5CadpUofVAbiKwFLKNsabSmkt8j8XzIbsaHm2BhQ2w/J/lvWX8=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-xhtg.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x8u08-0000000H2ur-0gFT;
	Tue, 22 Sep 2026 06:29:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=5TziHwaXDLNZErCA1Nv3YhRq2q9+6p4PN2Do0dxKr38=; b=T5UqOveDeSk52U3za0f9ytME7m
	zSVTX1ALLKtdubMCZNXtEZz3wf/27Dn9KwpzimGgCV3BJ9XriUrJYEKbSc+CYOb6rZxWE4+/+xnTL
	Vlfj3qwDvFZqXE45GDc0jKkhkeLenT+u4HxOrUuAXVusycaW9qvA1txxbpcC7QJPHlAM=;
Received: from [79.43.46.244] (port=63244 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x8tzG-00000000GBl-2f8i;
	Tue, 22 Sep 2026 06:28:18 +0000
Date: Tue, 22 Sep 2026 08:28:16 +0200
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
Message-ID: <arIfj-1Ji6HEBHLJ@bywater>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <aq1sooGCYUiWbhMH@p14s>
 <aq453yukMHiNb1jp@bywater>
 <CANLsYkySF+eF-FURnnT6UJv7P5Sg2HdfMSBZnZy_BLyCMvuofw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkySF+eF-FURnnT6UJv7P5Sg2HdfMSBZnZy_BLyCMvuofw@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: d55d3712a4d35f3ccddf463955b8e99e
X-AntiAbuse: ID - d55d3712a4d35f3ccddf463955b8e99e
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1x8u08-0000000H2ur-0gFT-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-xhtg.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Sun, Sep 20, 2026 at 09:31:11PM -0600, Mathieu Poirier wrote:
> On Sat, 19 Sept 2026 at 01:33, Francesco Valla <francesco@valla.it> wrote:
> >
> > Hi Mathieu,
> >
> > On Fri, Sep 18, 2026 at 10:53:54AM -0600, Mathieu Poirier wrote:
> > > Hi Francesco,
> > >
> > > I have started reviewing this set but given the size and implications, it will
> > > take me a few days to get through.
> >
> > I'm going through the review done by sashiko - would you prefer me
> > sending a v2 with the trivial errors already ironed out before doing
> > a complete review?
> >
> 
> We can wait if the errors are trivial.
> 

Not all of them are. I have been a bit to naive about the bounce buffer
management w.r.t. what can happen if a memory area is not specified and
I will need to rethink/rework that part.

Regrads,
Francesco

