Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED18C4A68A4;
	Tue, 22 Sep 2026 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108464; cv=pass; b=A1Cp44LcozyXplCK59wSeH1jjx8RlrF5a/JuV3jfNog7VhWOtb8qYxWwVhBdjO6scjoQ5ygq4h3KhzgUfITArF9GMcAotYPg1+ObMQgu/Oddl/pm9msxVibTXgQdePSp1kFvQGkYmIiYNZv+09pyaXWlOI1J8BG0noUdJzO8bdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108464; c=relaxed/simple;
	bh=0WVIKbcOsdwoXz5omIyem/bJ7sFg+LvjnvYwgCd83rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvsPDPx55AclLh7XrHzdYXTAIW16Y9xYCByOks7Oddr94yLybzymCD0okFRdKPriGOFYOzRFTzuP82B9fFc3U4+6ZLDt/NHqRw7hiV9ZKniV9KsdFQLApT+TXkXSduPodKnBnsebUr2jXANfvP7TIwT06uUH9B4dICAJq2lbDLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=nQZoE4Jj; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=EpfMWehE; arc=pass smtp.client-ip=185.56.87.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="nQZoE4Jj";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="EpfMWehE"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-gcsk.prod.antispam.mailspamprotection.com; s=arckey; t=1790108432;
	 b=pcRRbPVKZJIXja2U2gfESEhEielTadnMe5oS4Lsic0ihCNlIWehNBhwTk2wS8Hp7qN9J4ca/0o
	  YTZ5MkgGW5TkaOdCcQ5QPncYRrWwMfgPZY/WxVT9GkQdbBbkKwJJMTRiRFx/MbcoruOK3vOTKe
	  1Vem8b8YbcEK7Uw5J2r/RIqTv+KnL8natMtaygHexhjp81cpwKEoeKsPjg/6SQdUSFFNcwG17j
	  zP0EBc1MLHiPEWlDaMtMEUCINPdmkJEX2ANeEpHkN109TakXv2qupip+aUPSNkn0+vMFK/OXBu
	  dpRgCpokVfUPQ4HX63q3YMGxSOnBQFpKWmheiXSYOXUjow==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-gcsk.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-gcsk.prod.antispam.mailspamprotection.com; s=arckey; t=1790108432;
	bh=0WVIKbcOsdwoXz5omIyem/bJ7sFg+LvjnvYwgCd83rQ=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=CUxW8E+Ke3UpYppDIqiTR/29o3v9fvpL3HQfdU7oM+23DXslL5JDWT8wAz9vgNM9ptL0V/RLoB
	  ZDuFqG3p4VyZltVnwy1N4BcS8m3xsSXV7sPq0QAv0fJMCM0bxkKDGMADu1cHCzQ5LPjJ6X+VyG
	  UlWl232UcvYPQbgCw94HxR/NmbPBV/bEk9zQ/yTIiFf89tTwfBx5yi2fz8rn9EOLdXLNigUCxH
	  nbv+IEbJujKIizYmJ2zftFZlRg/Bqj5VBJSxlybignVmSc8hw7puOG7rW1R2YiaQLY5EwID5+J
	  oFeO2HBSQXqeXSdmZaF2hk5dm9R5+qB3m/pvEy0b+QQd0g==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=eKnrLV23HgV/Tt/v6XD8WD1ByL0WlpYBpZXbv5lCaho=; b=nQZoE4Jj37RSYtL8GhXgR9HPqi
	lTGTfRzdX1vF6gsX+Yk1o2YVs7o4xIokfKEj3/9H+3YOND9yOZ0pOtDV28kgDM8zkktXbzJh/y5ab
	5HTEklbGItgkq5o0MxLmmE0pCqGKpPBQq90E5HFWu98rMTSl8Fp7ErJJyuHyi9KTRmVg=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-gcsk.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x96yR-0000000DOAJ-08iR;
	Tue, 22 Sep 2026 20:20:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=eKnrLV23HgV/Tt/v6XD8WD1ByL0WlpYBpZXbv5lCaho=; b=EpfMWehEBuPf3r4MM/IaAgqfdL
	vt5NbMHtSb89q+lrYJjXn+wXkZtPuUlklXIMYNDeID8m8kSGbs0RtfVQm5Fvy/JydWJpS6pmLQpUY
	0UQBM3zyxD3O9XzFYG+D5rR24UPr2Wxf5g2AY0BoWJIIicCE4puC96gknCoAF51ur4Wk=;
Received: from [79.43.46.244] (port=63142 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x96xy-00000000NML-2uZM;
	Tue, 22 Sep 2026 20:19:50 +0000
Date: Tue, 22 Sep 2026 22:19:48 +0200
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
Message-ID: <arLawAw6kgFT2e0W@bywater>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-12-dac8c5eb4aa9@valla.it>
 <arKiOCGrWAKyc-bc@p14s>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arKiOCGrWAKyc-bc@p14s>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 9c99f88c77eeafcb81f84f34bee45c22
X-AntiAbuse: ID - 9c99f88c77eeafcb81f84f34bee45c22
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1x96yR-0000000DOAJ-08iR-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-gcsk.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Tue, Sep 22, 2026 at 09:43:52AM -0600, Mathieu Poirier wrote:
> On Wed, Sep 16, 2026 at 11:10:57PM +0200, Francesco Valla wrote:
> > Add rings for multiple vdevs, as well as the required virtio nodes for
> > I2C, SPI and GPIO functionalities. On top of that, add example
> > peripherals using all of them.
> > 
> > NOTE: this is a Proof-Of-Concept, not meant to be integrated!
> > 
> > Signed-off-by: Francesco Valla <francesco@valla.it>
> > ---
> >  arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts | 128 +++++++++++++++++++--
> >  1 file changed, 119 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> > index bd14ba28690c..dfa3b122ac5f 100644
> > --- a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> > @@ -53,6 +53,32 @@ button-k3 {
> >  		};
> >  	};
> >  
> > +	gpio-keys-virtio {
> > +		compatible = "gpio-keys-polled";
> > +		poll-interval = <100>;
> > +
> > +		button-v1 {
> > +			label = "Button V1";
> > +			linux,code = <BTN_3>;
> > +			gpios = <&v_gpio 23 GPIO_ACTIVE_LOW>;
> > +		};
> > +
> > +		button-v2 {
> > +			label = "Button V2";
> > +			linux,code = <BTN_4>;
> > +			gpios = <&v_gpio 24 GPIO_ACTIVE_LOW>;
> > +		};
> > +	};
> > +
> > +	leds {
> > +		compatible = "gpio-leds";
> > +
> > +		led {
> > +			gpios = <&v_gpio 18 GPIO_ACTIVE_HIGH>;
> > +			label = "LED V";
> > +		};
> > +	};
> > +
> >  	reg_usdhc2_vmmc: regulator-usdhc2 {
> >  		compatible = "regulator-fixed";
> >  		off-on-delay-us = <12000>;
> > @@ -89,11 +115,6 @@ linux,cma {
> >  			linux,cma-default;
> >  		};
> >  
> > -		rsc_table: rsc-table@2021e000 {
> > -			reg = <0 0x2021e000 0 0x1000>;
> > -			no-map;
> > -		};
> > -
> 
> Why is the resource table removed?  There is no mention of that in the
> changelog...
>

You are obviously right, the commit message here should have been a
poem, not a form of hermetic poetry. My bad.

The resource table here is causing problems with how Zephyr is managing
it at its side. If it is kept in a separate memory location and copied
there at runtime by the remote processor firmware during its startup
(which is the current Zephyr behavior), then there might be a race
condition when the aforesaid firmware is loaded and started by Linux
*and* at least one of the vdev drivers (here including rpmsg_bus) is
built-in. In this case, the copy of the resource table done by the
remote processor might - depending on the async execution of the two
processors - overwrite the status bit set by the Linux driver:

  Firmware load and startup (echo start > /sys/.../state)
                           |
			   |
			   V
  The vdev devices get registered (by register_virtio_device())
                           |
			   |
			   V
  If a driver is built-in, it probes and sets the vdev status
  inside the resource table @rsc-table.
                           .
			   . (in the mean time)
			   .
  The remote processor starts up and copies the resource table from its
  dedicated section to @rsc-table.

Depending on the system load and the complexity of the firmware, the two
operations can happen in whatever sequence, causing a race condition.

This is somewhat masked if vdev drivers are built as modules, as the
devices does not probe immediately but only after the modules have been
loaded, giving the remote processor time to start. Note that this is not
a solution! but a workaround.

If the rsc-table node is not there, the startup logic falls back to the
classic rproc_elf_find_loaded_rsc_table().

This is specific to i.MX platforms [1] and is probably not normally an
issue because - as stated in [1] - the offical SDK from NXP seems not
to check the status inside the resource table.

> >  		vdev0vring0: vdev0vring0@a4000000 {
> >  			reg = <0 0xa4000000 0 0x8000>;
> >  			no-map;
> > @@ -105,12 +126,42 @@ vdev0vring1: vdev0vring1@a4008000 {
> >  		};
> >  
> >  		vdev1vring0: vdev1vring0@a4010000 {
> > -			reg = <0 0xa4010000 0 0x8000>;
> > +			reg = <0 0xa4010000 0 0x1000>;
> > +			no-map;
> > +		};
> > +
> > +		vdev2vring0: vdev2vring0@a4011000 {
> > +			reg = <0 0xa4011000 0 0x2000>;
> > +			no-map;
> > +		};
> > +
> > +		vdev2vring1: vdev2vring1@a4013000 {
> > +			reg = <0 0xa4013000 0 0x2000>;
> > +			no-map;
> > +		};
> > +
> > +		vdev3vring0: vdev3vring0@a4015000 {
> > +			reg = <0 0xa4015000 0 0x2000>;
> > +			no-map;
> > +		};
> > +
> > +		vdev4vring0: vdev4vring0@a4017000 {
> > +			reg = <0 0xa4017000 0 0x4000>;
> > +			no-map;
> > +		};
> > +
> > +		vdev5vring0: vdev5vring0@a401B000 {
> > +			reg = <0 0xa401B000 0 0x2000>;
> > +			no-map;
> > +		};
> > +
> > +		vdev5vring1: vdev5vring1@a401D000 {
> > +			reg = <0 0xa401D000 0 0x2000>;
> >  			no-map;
> >  		};
> >  
> > -		vdev1vring1: vdev1vring1@a4018000 {
> > -			reg = <0 0xa4018000 0 0x8000>;
> > +		vdev5vring2: vdev5vring2@a401F000 {
> > +			reg = <0 0xa401F000 0 0x1000>;
> >  			no-map;
> >  		};
> >  
> > @@ -149,8 +200,67 @@ &cm33 {
> >  		 <&mu1 3 1>;
> >  	mbox-names = "tx", "rx", "rxdb";
> >  	memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
> > -			<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
> > +			<&vdev1vring0>, <&vdev2vring0>, <&vdev2vring1>,
> > +			<&vdev3vring0>, <&vdev4vring0>,
> > +			<&vdev5vring0>, <&vdev5vring1>, <&vdev5vring2>;
> 
> Who is using vdev5 vrings?  
> 

Another thing that should have been in the commit message. Vdevs are
defined, in the Zephyr application I am using as PoC, as follows:

 - vdev0: RPMSG (tx and rx vrings)
 - vdev1: entropy (single request vring)
 - vdev2: GPIO (request and event vrings)
 - vdev3: I2C (single request vring)
 - vdev4: SPI (single request vring)
 - vdev5: CAN (tx, rx and control vrings)

vdev5 is not represented inside the devicetree because the can-virtio
driver registers a single CAN network device and has thus no need for
such representation.

> >  	status = "okay";
> > +
> > +	virtio {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		vdev@2 {
> > +			reg = <2>;
> > +
> > +			v_gpio: gpio {
> > +				compatible = "virtio,device29";
> > +				gpio-controller;
> > +				#gpio-cells = <2>;
> > +				interrupt-controller;
> > +				#interrupt-cells = <2>;
> > +			};
> > +		};
> > +
> > +		vdev@3 {
> > +			reg = <3>;
> > +
> > +			i2c {
> > +				compatible = "virtio,device22";
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				eeprom@50 {
> > +					compatible = "atmel,24c1025";
> > +					reg = <0x50>;
> > +				};
> > +			};
> > +		};
> > +
> > +		vdev@4 {
> > +			reg = <4>;
> > +
> > +			spi {
> > +				compatible = "virtio,device2d";
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				sram@0 {
> > +					compatible = "microchip,mchp23k256";
> > +					reg = <0>;
> > +					spi-max-frequency = <20000000>;
> > +				};
> > +
> > +				lcd@1 {
> > +					compatible = "adafruit,yx240qv29", "ilitek,ili9341";
> > +					reg = <1>;
> > +					spi-max-frequency = <10000000>;
> > +					dc-gpios = <&v_gpio 21 GPIO_ACTIVE_HIGH>;
> > +					reset-gpios = <&v_gpio 20 GPIO_ACTIVE_HIGH>;
> > +					rotation = <90>;
> > +				};
> > +			};
> > +		};
> > +	};
> >  };
> >  
> >  &eqos {
> > 
> > -- 
> > 2.55.0
> >

Thank you!

Regards,
Francesco


[1] https://lore.kernel.org/all/20240719-imx_rproc-v2-2-10d0268c7eb1@nxp.com/
