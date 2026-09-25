Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D95D4477F1;
	Fri, 25 Sep 2026 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363654; cv=pass; b=loxDPhV+eQd8VXQY8gQcVZfxce6eayq+F/ailR5tdO1jVajx0fsmjk9MUG7g4E05op4DrruXwrp9ss8XDAqq7iEaki1ooEtIrMfPLoWJcJ5sMEQQK+KdHzPUgqM9LyeyR5MFT6QYoCgLihGaG4sJkZ9zNPDoiWoQMzHIRGAFakU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363654; c=relaxed/simple;
	bh=yx/Ft/8wjagadLROp2/zxX+aa83VVkqcyzW3JXIAwYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8FtsTKs0FuJXwA72Aml4bhHrZSZMBwBLos/Bb02JiSbmwI4fNePYAl/cwge42kon3z+WYxvbUxNNONQJPhmiu649J7HC28MCWozNLp9cE4WLVTTUkAXbEQjIaBZoETdVv4aPVbCGOQ70saHhxCLmoAo++aqeEJrvg20HSPWDmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=rso1CPJm; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=LpL2B+x/; arc=pass smtp.client-ip=185.56.87.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="rso1CPJm";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="LpL2B+x/"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-gx2h.prod.antispam.mailspamprotection.com; s=arckey; t=1790363649;
	 b=YA9ppGGqGRwG3tMbN0MZVVgZNS1ce8kUsHHdSb/ec3/+lFtvB7YMNla936pvwiBsN7BxSeDQlm
	  GTBJcj+pG2FM5VGfJrt+KNFGeeYpd+GzfEwP1tsGWY9pcY6Dh5MRInnPwgnDqufZtlLaACr3a+
	  kfny4s71+6uvuH68xO9Xxs7RPZQmD1yFEIj1edIrBp38L6CL3HC4eTIOd+GhFyxRYZi5nw/0mF
	  dR/rHvzNFJ97/rgZ2u8koIYct/qofS3sHvTRsU4AjhGoFIHq9XdDLMnvS8kAzJZ3xNJgGQiIek
	  1sV8a7eZkUgucYZQSqHlUmIRbv/wbki9rVvAYaI7cFK9Fw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-gx2h.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-gx2h.prod.antispam.mailspamprotection.com; s=arckey; t=1790363649;
	bh=yx/Ft/8wjagadLROp2/zxX+aa83VVkqcyzW3JXIAwYI=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=WEpT+hzb2lNUBu6MFmYgCeJfkr3WKO/Vno4LW+l2Q6maIDuSs+uwuqyPMnh+/Hm3R2HYi8U/3X
	  V1bF81VqDFRwfXKqEXRUsZc2Dk8mpi9uqezYecgryBMasG/ntwJWVxm0S1KH5abWiehAbF8jre
	  3Rglj/svCerP4eN5q1ZGQBbuEjwhmen7uLfypjVvpaWJKx6QpfSZhjr0ckZ+uq7sLGDEsxX2bz
	  ldvQ5g/FD7Q5vZ753qjDcmqpEz85AmNLe97PxtnrFin2C7C9sv4b0s72txNd0LsSTcvnUOo7s7
	  LlDKdWrEP80d78FZ6C2nXpgrJlDIckdMSJB+ga5165LI9Q==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=1cy28oamoCRjiNiWmfH98MKJagA+6yzbPIYdI0DQhmg=; b=rso1CPJmFYHCFaOkIFZ2NioJ4N
	q5c9jKbrJ9xg1Fn/wzZMdqUr5AdnaS3zj9AfMOzmu1kIVmmvnrHxSbWE0IyIKKT+MFFiqNx1DG/Y1
	bU8jgaX5o3ZdSJUSNytv3DtRVUPLjgBajYb7TM6kF0gcXyP2TiycTrmgqmvjLG3S0Q78=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-gx2h.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xABMu-0000000FIZB-0ozq;
	Fri, 25 Sep 2026 19:14:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=1cy28oamoCRjiNiWmfH98MKJagA+6yzbPIYdI0DQhmg=; b=LpL2B+x/aNpsi65IdfB6Ebt8ru
	aamO37IwhtRAj/59mH2tx7/idp18FjYphBv0CK7I8SW+Swv7szpMG2H1j8ufYUcPyRuv2WQHc/1S7
	duO/Kr0wLjfrlTGxgMwOJQtoSWCmyTFwSUK18mT5egF0yW2qgzUMH24GK4uc0Tfu3sIM=;
Received: from [79.45.60.29] (port=60566 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xABMZ-00000000Pn3-1jQq;
	Fri, 25 Sep 2026 19:13:39 +0000
Date: Fri, 25 Sep 2026 21:13:37 +0200
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
Subject: Re: [PATCH RFC 12/12] PoC: arm64: dts: imx93-11x11-frdm: add
 multiple vdevs
Message-ID: <arbGLZ8_xKJTpiVa@bywater>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-12-dac8c5eb4aa9@valla.it>
 <arKiOCGrWAKyc-bc@p14s>
 <arLawAw6kgFT2e0W@bywater>
 <arP06mWDehsIDh5s@p14s>
 <arP5AvA51GHrI8aN@bywater>
 <CANLsYkyT3NopaQy8CpTUrD-MTbif1dvyjaUUcQUWLzcTL7GpcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkyT3NopaQy8CpTUrD-MTbif1dvyjaUUcQUWLzcTL7GpcQ@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 37fd042a67271f839fbe3280a8409855
X-AntiAbuse: ID - 37fd042a67271f839fbe3280a8409855
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xABMu-0000000FIZB-0ozq-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-gx2h.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Thu, Sep 24, 2026 at 09:49:08AM -0600, Mathieu Poirier wrote:
> On Wed, 23 Sept 2026 at 12:42, Francesco Valla <francesco@valla.it> wrote:
> >
> > On Wed, Sep 23, 2026 at 09:48:58AM -0600, Mathieu Poirier wrote:
> > > On Tue, Sep 22, 2026 at 10:19:48PM +0200, Francesco Valla wrote:
> > > > On Tue, Sep 22, 2026 at 09:43:52AM -0600, Mathieu Poirier wrote:
> > > > > On Wed, Sep 16, 2026 at 11:10:57PM +0200, Francesco Valla wrote:
> > > > > > Add rings for multiple vdevs, as well as the required virtio nodes for
> > > > > > I2C, SPI and GPIO functionalities. On top of that, add example
> > > > > > peripherals using all of them.
> > > > > >
> > > > > > NOTE: this is a Proof-Of-Concept, not meant to be integrated!
> > > > > >
> > > > > > Signed-off-by: Francesco Valla <francesco@valla.it>
> > > > > > ---
> > > > > >  arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts | 128 +++++++++++++++++++--
> > > > > >  1 file changed, 119 insertions(+), 9 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> > > > > > index bd14ba28690c..dfa3b122ac5f 100644
> > > > > > --- a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> > > > > > +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> > > > > > @@ -53,6 +53,32 @@ button-k3 {
> > > > > >                 };
> > > > > >         };
> > > > > >
> > > > > > +       gpio-keys-virtio {
> > > > > > +               compatible = "gpio-keys-polled";
> > > > > > +               poll-interval = <100>;
> > > > > > +
> > > > > > +               button-v1 {
> > > > > > +                       label = "Button V1";
> > > > > > +                       linux,code = <BTN_3>;
> > > > > > +                       gpios = <&v_gpio 23 GPIO_ACTIVE_LOW>;
> > > > > > +               };
> > > > > > +
> > > > > > +               button-v2 {
> > > > > > +                       label = "Button V2";
> > > > > > +                       linux,code = <BTN_4>;
> > > > > > +                       gpios = <&v_gpio 24 GPIO_ACTIVE_LOW>;
> > > > > > +               };
> > > > > > +       };
> > > > > > +
> > > > > > +       leds {
> > > > > > +               compatible = "gpio-leds";
> > > > > > +
> > > > > > +               led {
> > > > > > +                       gpios = <&v_gpio 18 GPIO_ACTIVE_HIGH>;
> > > > > > +                       label = "LED V";
> > > > > > +               };
> > > > > > +       };
> > > > > > +
> > > > > >         reg_usdhc2_vmmc: regulator-usdhc2 {
> > > > > >                 compatible = "regulator-fixed";
> > > > > >                 off-on-delay-us = <12000>;
> > > > > > @@ -89,11 +115,6 @@ linux,cma {
> > > > > >                         linux,cma-default;
> > > > > >                 };
> > > > > >
> > > > > > -               rsc_table: rsc-table@2021e000 {
> > > > > > -                       reg = <0 0x2021e000 0 0x1000>;
> > > > > > -                       no-map;
> > > > > > -               };
> > > > > > -
> > > > >
> > > > > Why is the resource table removed?  There is no mention of that in the
> > > > > changelog...
> > > > >
> > > >
> > > > You are obviously right, the commit message here should have been a
> > > > poem, not a form of hermetic poetry. My bad.
> > > >
> > > > The resource table here is causing problems with how Zephyr is managing
> > > > it at its side. If it is kept in a separate memory location and copied
> > > > there at runtime by the remote processor firmware during its startup
> > > > (which is the current Zephyr behavior), then there might be a race
> > > > condition when the aforesaid firmware is loaded and started by Linux
> > > > *and* at least one of the vdev drivers (here including rpmsg_bus) is
> > > > built-in. In this case, the copy of the resource table done by the
> > > > remote processor might - depending on the async execution of the two
> > > > processors - overwrite the status bit set by the Linux driver:
> > > >
> > > >   Firmware load and startup (echo start > /sys/.../state)
> > > >                            |
> > > >                        |
> > > >                        V
> > > >   The vdev devices get registered (by register_virtio_device())
> > > >                            |
> > > >                        |
> > > >                        V
> > > >   If a driver is built-in, it probes and sets the vdev status
> > > >   inside the resource table @rsc-table.
> > > >                            .
> > > >                        . (in the mean time)
> > > >                        .
> > > >   The remote processor starts up and copies the resource table from its
> > > >   dedicated section to @rsc-table.
> > > >
> > > > Depending on the system load and the complexity of the firmware, the two
> > > > operations can happen in whatever sequence, causing a race condition.
> > >
> > > This would happen regardless of this patchset.
> > >
> >
> > Correct, *if* the remote processor is copying the resource table to a
> > specific location and expects the host to use that. On Zephyr (which is
> > clearly outside the scope here) this can be enabled through the
> > CONFIG_OPENAMP_COPY_RSC_TABLE option. I am keeping that disabled, and
> > removing the rsc-table node here.
> >
> > I am planning to reason on this and propose a proper fix in a separate
> > patchset.
> >
> 
> It seems like we need two solutions here, one for imx and another
> applicable to everyone.
>
> > > >
> > > > This is somewhat masked if vdev drivers are built as modules, as the
> > > > devices does not probe immediately but only after the modules have been
> > > > loaded, giving the remote processor time to start. Note that this is not
> > > > a solution! but a workaround.
> > > >
> > > > If the rsc-table node is not there, the startup logic falls back to the
> > > > classic rproc_elf_find_loaded_rsc_table().
> > >
> > > We can't remove @rsc-table to make a problem go away.
> > >
> >
> > I need to re-take a look at the NXP SDK to understand what's the real
> > purpose of having the rsc-table here. Judging from the commit message
> > that introduced support for such facility [1], it seems the SDK is not
> > really using it.
> >
> > Maybe someone from NXP can comment on this?
> >
> > > >
> > > > This is specific to i.MX platforms [1] and is probably not normally an
> > > > issue because - as stated in [1] - the offical SDK from NXP seems not
> > > > to check the status inside the resource table.
> > > >
> > > > > >                 vdev0vring0: vdev0vring0@a4000000 {
> > > > > >                         reg = <0 0xa4000000 0 0x8000>;
> > > > > >                         no-map;
> > > > > > @@ -105,12 +126,42 @@ vdev0vring1: vdev0vring1@a4008000 {
> > > > > >                 };
> > > > > >
> > > > > >                 vdev1vring0: vdev1vring0@a4010000 {
> > > > > > -                       reg = <0 0xa4010000 0 0x8000>;
> > > > > > +                       reg = <0 0xa4010000 0 0x1000>;
> > > > > > +                       no-map;
> > > > > > +               };
> > > > > > +
> > > > > > +               vdev2vring0: vdev2vring0@a4011000 {
> > > > > > +                       reg = <0 0xa4011000 0 0x2000>;
> > > > > > +                       no-map;
> > > > > > +               };
> > > > > > +
> > > > > > +               vdev2vring1: vdev2vring1@a4013000 {
> > > > > > +                       reg = <0 0xa4013000 0 0x2000>;
> > > > > > +                       no-map;
> > > > > > +               };
> > > > > > +
> > > > > > +               vdev3vring0: vdev3vring0@a4015000 {
> > > > > > +                       reg = <0 0xa4015000 0 0x2000>;
> > > > > > +                       no-map;
> > > > > > +               };
> > > > > > +
> > > > > > +               vdev4vring0: vdev4vring0@a4017000 {
> > > > > > +                       reg = <0 0xa4017000 0 0x4000>;
> > > > > > +                       no-map;
> > > > > > +               };
> > > > > > +
> > > > > > +               vdev5vring0: vdev5vring0@a401B000 {
> > > > > > +                       reg = <0 0xa401B000 0 0x2000>;
> > > > > > +                       no-map;
> > > > > > +               };
> > > > > > +
> > > > > > +               vdev5vring1: vdev5vring1@a401D000 {
> > > > > > +                       reg = <0 0xa401D000 0 0x2000>;
> > > > > >                         no-map;
> > > > > >                 };
> > > > > >
> > > > > > -               vdev1vring1: vdev1vring1@a4018000 {
> > > > > > -                       reg = <0 0xa4018000 0 0x8000>;
> > > > > > +               vdev5vring2: vdev5vring2@a401F000 {
> > > > > > +                       reg = <0 0xa401F000 0 0x1000>;
> > > > > >                         no-map;
> > > > > >                 };
> > > > > >
> > > > > > @@ -149,8 +200,67 @@ &cm33 {
> > > > > >                  <&mu1 3 1>;
> > > > > >         mbox-names = "tx", "rx", "rxdb";
> > > > > >         memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
> > > > > > -                       <&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
> > > > > > +                       <&vdev1vring0>, <&vdev2vring0>, <&vdev2vring1>,
> > > > > > +                       <&vdev3vring0>, <&vdev4vring0>,
> > > > > > +                       <&vdev5vring0>, <&vdev5vring1>, <&vdev5vring2>;
> > > > >
> > > > > Who is using vdev5 vrings?
> > > > >
> > > >
> > > > Another thing that should have been in the commit message. Vdevs are
> > > > defined, in the Zephyr application I am using as PoC, as follows:
> > > >
> > > >  - vdev0: RPMSG (tx and rx vrings)
> > >
> > > To be backward compatible, there has to be a way to make vdev0 defaulting to
> > > RPMSG.  It would also be nice if bindings were define for RPMSG so that it can
> > > show up in the list of remoteproc-virtio devices like i2c, gpio and others.
> > >
> >
> > What vdev type is inside vdev0 is up to the resource table (i.e., to the
> > firmware running on the remote processor), not the remoteproc-virtio
> > framework.
> >
> 
> We are of the same opinion.  Up to now vdev0 was automatically
> assigned to RPMSG but with this new feature, it can be anywhere in the
> list.  I see your point about RPMSG not requiring hardware
> description.
> 
> > Defining bindings for rpmsg would today be... pointless? Since no
> > hardware needs to be described for it. The same goes for virtio-can and
> > virtio-entropy.
> >
> 
> Just to make sure we understand each other, there are entries in the
> resource table for virtio-can and virtio-entropy.  Please confirm.
>

This is correct. You can take a look at the resource table used for this
Poc in [1]; basically it is defined as:

struct fw_resource_table {
    struct resource_table hdr;
    uint32_t offset[RSC_TABLE_NUM_ENTRIES];

    DECL_RSC_TABLE_VDEV(rpmsg, 2);
    DECL_RSC_TABLE_VDEV(entropy, 1);
    DECL_RSC_TABLE_VDEV_CONFIG(gpio, 2, struct virtio_gpio_config);
    DECL_RSC_TABLE_VDEV(i2c, 1);
    DECL_RSC_TABLE_VDEV_CONFIG(spi, 1, struct virtio_spi_config);
    DECL_RSC_TABLE_VDEV_CONFIG(can, 3, struct virtio_can_config);
};

where:

DECL_RSC_TABLE_VDEV(<vdev-type>, <num-of-vrings>[, <config space>])

> > >
> > > >  - vdev1: entropy (single request vring)
> > > >  - vdev2: GPIO (request and event vrings)
> > > >  - vdev3: I2C (single request vring)
> > > >  - vdev4: SPI (single request vring)
> > > >  - vdev5: CAN (tx, rx and control vrings)
> > > >
> > > > vdev5 is not represented inside the devicetree because the can-virtio
> > > > driver registers a single CAN network device and has thus no need for
> > > > such representation.
> > >
> > > Then why is it part of the remoteproc's memory-regions?
> > >
> >
> > Because a vring description needs to be present for it, or the
> > remoteproc-virtio won't be able to fill the entry inside the resource
> > table.
> >
> > > >
> > > > > >         status = "okay";
> > > > > > +
> > > > > > +       virtio {
> > > > > > +               #address-cells = <1>;
> > > > > > +               #size-cells = <0>;
> > > > > > +
> > > > > > +               vdev@2 {
> > > > > > +                       reg = <2>;
> > > > > > +
> > > > > > +                       v_gpio: gpio {
> > > > > > +                               compatible = "virtio,device29";
> > > > > > +                               gpio-controller;
> > > > > > +                               #gpio-cells = <2>;
> > > > > > +                               interrupt-controller;
> > > > > > +                               #interrupt-cells = <2>;
> > > > > > +                       };
> > > > > > +               };
> > > > > > +
> > > > > > +               vdev@3 {
> > > > > > +                       reg = <3>;
> > > > > > +
> > > > > > +                       i2c {
> > > > > > +                               compatible = "virtio,device22";
> > > > > > +                               #address-cells = <1>;
> > > > > > +                               #size-cells = <0>;
> > > > > > +
> > > > > > +                               eeprom@50 {
> > > > > > +                                       compatible = "atmel,24c1025";
> > > > > > +                                       reg = <0x50>;
> > > > > > +                               };
> > > > > > +                       };
> > > > > > +               };
> > > > > > +
> > > > > > +               vdev@4 {
> > > > > > +                       reg = <4>;
> > > > > > +
> > > > > > +                       spi {
> > > > > > +                               compatible = "virtio,device2d";
> > > > > > +                               #address-cells = <1>;
> > > > > > +                               #size-cells = <0>;
> > > > > > +
> > > > > > +                               sram@0 {
> > > > > > +                                       compatible = "microchip,mchp23k256";
> > > > > > +                                       reg = <0>;
> > > > > > +                                       spi-max-frequency = <20000000>;
> > > > > > +                               };
> > > > > > +
> > > > > > +                               lcd@1 {
> > > > > > +                                       compatible = "adafruit,yx240qv29", "ilitek,ili9341";
> > > > > > +                                       reg = <1>;
> > > > > > +                                       spi-max-frequency = <10000000>;
> > > > > > +                                       dc-gpios = <&v_gpio 21 GPIO_ACTIVE_HIGH>;
> > > > > > +                                       reset-gpios = <&v_gpio 20 GPIO_ACTIVE_HIGH>;
> > > > > > +                                       rotation = <90>;
> > > > > > +                               };
> > > > > > +                       };
> > > > > > +               };
> > > > > > +       };
> > > > > >  };
> > > > > >
> > > > > >  &eqos {
> > > > > >
> > > > > > --
> > > > > > 2.55.0
> > > > > >
> > > >
> > > > Thank you!
> > > >
> > > > Regards,
> > > > Francesco
> > > >
> > > >
> >
> > Thank you for the discussion - is helping in defining further
> > requirements and constraints.
> >
> 
> Well, I certainly appreciate that you are willing to have a discussion.
> 

Regards,
Francesco

[1] https://github.com/WallaceIT/zephyr/blob/multi_vdev/samples/subsys/ipc/multi_vdev/src/resource_table.c#L88
