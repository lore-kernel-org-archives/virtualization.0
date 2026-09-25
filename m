Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A4D4E66C0;
	Fri, 25 Sep 2026 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364781; cv=pass; b=C7lJGJPekDqOPSQ/V1na3tILAi2yQz7aAdyeDSIDlZ6rYy+31hBFVt5Q99DL2ILaekyzTE5VJZNp9Z1F2DVohjCwykr0Zwg2sPYjIm55N084R6DqgDBw9NijNpcJvk/3LhMD9O+O1wsN2uA2EhF6WHC9CrthACw9f8Z5Wsn1V8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364781; c=relaxed/simple;
	bh=pfEa9sDfSqmUqAkVSivfg+jwsPnAd7JEdfM7bR8Kono=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PN4nmJbkfiUeiYZF6FkHWLOkHp/02OfOb25jF5ONNlqVMwoGHTFg0pPF5NrnmnGe6u0kIm3HsxGmN8NnaEPSOeFCzmytJRG4wgYQNS/fCV1+h9+wMwqGoh17JjXpQdMw/lidoM/5pncjJAhinTdvNjbfjUuI2tSBY/z94Fnx8+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=WWs9S7hX; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=u7hR3YJo; arc=pass smtp.client-ip=185.56.87.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="WWs9S7hX";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="u7hR3YJo"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-97jw.prod.antispam.mailspamprotection.com; s=arckey; t=1790364779;
	 b=aFKo8KGCTzLifXlM+Yv7AqCEoJL4FAo3saj3zmdzydYlPWXEdiefT2Hv7mlTY7AAHPd0kZVLvf
	  FvHxJxjxDkWrB6m77TwNLyCgU+q7OgAsMgfSxzTzpJjcnayYohtmEZ1XDCdFZVgW02yIbGCQ1/
	  UrbtHY4qMVDQG/uDLpJQuOHThP4hRBBaZT6OmBgCSvDa3tAgDjhbIjmGY29lQ5gmSYJRo3xWXL
	  sTCn4Ht77/wLYJVgg1O7TI0RnRmfefxxpG8UU5GAMZ15vLNbDAcQI1DbUsMSeCN/me8YUFUWTc
	  pJD6A5oVu0vACY0sxkdUaNhqXbleDLc8PFiWoIRUTyolNA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-97jw.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-97jw.prod.antispam.mailspamprotection.com; s=arckey; t=1790364779;
	bh=pfEa9sDfSqmUqAkVSivfg+jwsPnAd7JEdfM7bR8Kono=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=Ewr6xcrlR2o+qBXHsHFjN1/QDm//fp8MEMwjLckJwpEnBiQDnFBrFFIYBvjjVvlwOqhgCutXF1
	  OyveQAM40EUUp9q55FZYYTtfyIseWzAYd0SX1LPBl2F5eDk21UFIkJQZs8HXXuSlPC0LRN4fEn
	  VH/HZmLa1be4o0LFKmBhulr1wIciMXpYxRHsEuWPuv8d4SZlIfwBUByzndG93s3A2DgcfLmekW
	  uVEafh0tS7u5ZH0aSOBfuCVPnc3ws6dNYateArFsTKFxh7ynkcZBb11Hqg5SQebPTHj225IZW9
	  QtN0i1azPW20mc4EVRI2F4Jy0BsNrwnu44QWQFRNDIMZTA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=jhm3OuOGKpGPipHzsmUmu5dKRRI8/O+LClIrmyA+BRg=; b=WWs9S7hXbU0FcUbna1yXYO/XWr
	TqyY8eR9fnbfIG13WbABmMOfa/vCHBXhzDuh+IwQaQcDLytEdr3xo+Mybjp9mzYRJKi4oh0AefOGH
	hSihEP651R4W0imta//zlE/syy2/2Q9Fg0ZTkJprLjiRE1nGRkuudcVg0SisUa7W9qnM=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-97jw.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xABFA-0000000479C-2lWN;
	Fri, 25 Sep 2026 19:06:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=jhm3OuOGKpGPipHzsmUmu5dKRRI8/O+LClIrmyA+BRg=; b=u7hR3YJo8ZSr2SisSaLcNNA9di
	zA3XUxiLlksid/DDe+DIdECQZUJAVZ8/bjoeEVS6W00sscP2aJdJg+YMk9CymkCki0s+B2TN9sXUw
	6yvzhxIdhakmJQceVp/tAluydMOcnP4JJIpwNXm+4k/TQhLzQ89o8WJWqAP4miEIjMK0=;
Received: from [79.45.60.29] (port=64306 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xABEv-00000000KZm-1aVj;
	Fri, 25 Sep 2026 19:05:45 +0000
Date: Fri, 25 Sep 2026 21:05:43 +0200
From: Francesco Valla <francesco@valla.it>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	virtualization@lists.linux.dev, imx@lists.linux.dev, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 06/12] remoteproc: virtio: add bounce buffering for
 data buffers
Message-ID: <arbEmz1jy0V7gjrU@bywater>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-6-dac8c5eb4aa9@valla.it>
 <arKlvZGqu2nt6Ci0@p14s>
 <arLXthhYbKkwZ9zY@bywater>
 <CANLsYkwNOukGX68=NVvwNP7iudP3EcKN6C2L2o9nVCTRxFVxFg@mail.gmail.com>
 <arP38OEaabFFu8lJ@bywater>
 <araOI_duKIAbphq6@p14s>
 <1b55f680-2413-4db1-b928-ed5741696d07@arm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b55f680-2413-4db1-b928-ed5741696d07@arm.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: b4b494bfe2759520406af1bea050b67f
X-AntiAbuse: ID - b4b494bfe2759520406af1bea050b67f
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xABFA-0000000479C-2lWN-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-97jw.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Robin, Mathieu,

On Fri, Sep 25, 2026 at 05:48:25PM +0100, Robin Murphy wrote:
> On 25/09/2026 4:07 pm, Mathieu Poirier wrote:
> > On Wed, Sep 23, 2026 at 06:05:35PM +0200, Francesco Valla wrote:
> > > On Wed, Sep 23, 2026 at 08:44:41AM -0600, Mathieu Poirier wrote:
> > > > On Tue, 22 Sept 2026 at 13:39, Francesco Valla <francesco@valla.it> wrote:
> > > > > 
> > > > > On Tue, Sep 22, 2026 at 09:58:53AM -0600, Mathieu Poirier wrote:
> > > > > > On Wed, Sep 16, 2026 at 11:10:51PM +0200, Francesco Valla wrote:
> > > > > > > Depending on the driver originating them, data buffers used for virtio
> > > > > > > communication can either:
> > > > > > > 
> > > > > > >    - already be allocated from the coherent memory area that is
> > > > > > >      accessible by the remote processor; this is the case of rpmsg
> > > > > > >      and the rproc flavor of virtio-console;
> > > > > > >    - be allocated from generic kmem, and thus not accessible directly by
> > > > > > >      the remote processor.
> > > > > > > 
> > > > > > > Exploiting the map operations, which are used by the virtio framework
> > > > > > > when VIRTIO_F_ACCESS_PLATFORM is part of a vdev's feature flags, add
> > > > > > > bounce buffering for the second case: when the map() callback is called
> > > > > > > for a buffer, one or more pages of coherent memory are allocated and
> > > > > > > data is copied to them, then they are exposed to the remote processor;
> > > > > > > the data is  then bounced back on unmap().
> > > > > > > 
> > > > > > > The first case is not impacted, since buffers already suitable for
> > > > > > > remote transmission are passed through.
> > > > > > > 
> > > > > > > With the bounce buffering in place, any kind of virtio device can be
> > > > > > > supported through the remoteproc-virtio transport, at least from a
> > > > > > > data exchange standpoint.
> > > > > > 
> > > > > > Is this _necessary_ for the imx93 platform you are implementing feature for?
> > > > > > 
> > > > > 
> > > > > If I don't want to fundamentally change how the remoteproc integration
> > > > > works (i.e.: using buffers only from a pre-shared area), yes. While in
> > > > > my test environment the Cortex-M33 serving as remoteproc is able to
> > > > > access the whole RAM space, that is not always the case.
> > > > 
> > > > The first sentence tells me it is mandatory while the second says it
> > > > is not.  I understand the use case but don't want to bloat the
> > > > subsystem with code that is trying to address a problem you currently
> > > > don't have.
> > > > 
> > > 
> > > Let me rephrase: while on i.MX93 the Cortex-M33 can theoretically access
> > > the whole RAM space, that is not a good idea from a security point of
> > > view and can be the source of a number of bugs. The target is to
> > > statically define a static shared memory area (as I am doing on i.MX95)
> > > and only use that.
> > 
> > As Robin pointed out, have you looked at using a restricted-dma-pool for that?
> > Note that I am not familiar with the concept but open to go that way if it can
> > work for us.
> > 
> > Robin, can you point us to a simple example we could look at?
> The only in-tree example is mt8192-asurada.dtsi, but even there the
> fundamental principle seems exactly the same - the system interconnect is
> locked down such that there's only a particular region of "shared" memory
> that PCIe DMA can access, so the restricted pool is placed there, and in
> that case can occupy the entire region since the wifi adapter only really
> does streaming DMA - restricted pools have some limited ability to act as a
> fallback for coherent allocations, which won't work for everything, but does
> happen to be enough for that wifi driver.
> 
> Here it would be a case of reserving some of the shared region for a
> restricted pool alongside the "vdevbuffer" coherent pool, adding it to the
> memory-region list of the relevant device(s), and usually that would then
> just work, since the setup is all done automatically by the core DT code.
> However I know remoteproc does some funky stuff with child devices, so it's
> quite possible there might need to be something more done there. But still
> far, far less than reimplementing a whole other bounce-buffering system.
> 
> Thanks,
> Robin.

I took a look at the restricted-memory-pool - with which I wasn't
familiar - and seems exactly what is needed here.

I am working on a new prototype with it - if everything works as
expected (I still did not have time to try it) it should only need some
very limited glue code, cutting the modifications in the
remoteproc_virtio driver by 95%. I'll let you knwow.

Thank you for the hint!

Regards,
Francesco


