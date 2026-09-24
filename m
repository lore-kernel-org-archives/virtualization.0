Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B9B4A2604
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264966; cv=pass; b=m+D6R8EDl4IW30NyQmROoMIJxadxRcSNGFOLyzPso48mh8MCrdERrT0+LQdFAfA0wuPhRHBOg7jTT/s331Cm3VdteZ15t81bdabvq3wfTeLZ2oq05/2FxNz9Mn4c3ABXs+/ffGyyNzuwxNXNh1hQ7zRjHhJUWfzGLOf8+q4T/6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264966; c=relaxed/simple;
	bh=l1Q0IiZDk6Qcq0311vlsTK2bjC6s/OA42Brr4EFRw/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzVLKjSfLLK2Li/9YKkK9ZiMiL6U9H3VHJ/KGvjyxiKs39xdO4LjLKYaqKzmYjtLlNq85zXrHJn4ve5KF0A93q8EP7HrWt9t8Wo67vnn2vztVnYma2uTamcZ90IUFC1qDA+azIxBuYnrbHU3c9ZdV4ISWgj3DtaMiWF4W6bJTJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y8PEPhaD; arc=pass smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y8PEPhaD"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aadefa076dso300036a12.3
        for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 08:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790264961; cv=none;
        d=google.com; s=arc-20260327;
        b=Qq2tunmypTcaYWuCa4jI29J8wxXgHZDnLFQOuf5m9gRSEgesS610eNdD4rjKVgTHYg
         atS/gQiTFPaOlr1bmgybbgTjXIcdQ4EIrCZupvO4rVg37Ec1zs+HS9GcuZjR6S+yNK/t
         6ZbsJFUAbhofNPxUfhY9vgKTwJCx/mWPkx1H6bKRoxIO82rAbMLXHv9oZIMmdEku3tJp
         LhKQ5/m+reCRlYbsaXusW1Ax743Gr7KUBxBoAlHW/niavkqyfbmWmSUk0A/iDLgc26y1
         MnohzIat55jm6hGrAE+gBdE7fIvE4gNTQVBZpRCt0oK8GD2M4g1cDQNYm9NPd0oKandd
         8bkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ni9MwLgYZlL3v8+dEAMfhbtgbNrk2WDN56GHtl6Py64=;
        fh=0OjLRsrFFollLGS5oz9PETcERBmkiVRStijFSsIlqXU=;
        b=UxxlHFE8rZsvRCPE+oDJbi972/ObU5jE4IAQFQsSYHoJC1H+GfbsfrbDuUbQt2gr6G
         sogmDlpj4ue7HtjWoG246+GrCmDcrABtifYRDvYJkIKzwWivLt1neTxe9Htaikb+qBUC
         iyQpuQXGTMbq88bUNM3G5tTcYTUPKR3rQqRxdSTHFU2dx75efCXRu/FOt4x/sgwNcwo2
         ez32HRRPp6uqSc8WFnfuc1urRxpqIEeZrxTyVurtBl01qbS2O5P3c7QeTWFZQS+e71+X
         9KT5ZJ70UM9FpFxWQVxbuqcTWj5E4np4vEfHacugtTUJyqrX7NxPIPk7gOHOWPqIoski
         +Gzg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790264961; x=1790869761; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ni9MwLgYZlL3v8+dEAMfhbtgbNrk2WDN56GHtl6Py64=;
        b=y8PEPhaDjvjI4C/Rbzf7x7W0xwpVJlf3nAuLBrZm9M98z7YNHQ2mVOfFZJ2niA5Z1T
         15AYv4j0w21MqpTnSARKbGC5r99b7h1wFSmOwzRe8Dzm9T/CW+98hb4zCvIoiTd5PV5L
         8f3YirQ6ipe9k8d2XlRn1Ul7/6nHCJBWfZVqKyZGNj0/pzXZ+1d64T78QdQG4wSvMByP
         uDH/gTeEUtUZO69jodjVI0vZnAsbUHmQYUJEZaq3dwp6i9DePtAxUjWSK96rCn3BeiT5
         6AavUYFIbm6ohFupkOGoQJ9Vlu6UNdUBvBkY2GHlP15Qh7GZJOFTSMCo+0QLF39xw6EE
         MRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790264961; x=1790869761;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ni9MwLgYZlL3v8+dEAMfhbtgbNrk2WDN56GHtl6Py64=;
        b=X0W6LjfSgxbR1NF1nnTCP81314HGkf4Xa7B3lPlAdyBh43hu5Kqzpa4Re1pajiKKAG
         cYL35JLP/4qyK4Mi49rZeDp2QTUTdDyRqJ9c+rLSW8lEqu8FKL9YvIXnoXoUF1g0g9JL
         XZsC1eFvJCm/pkA1fAza1xoAgWmDArBtp2hgP/3mkcYxqyZZrNSpiUN00OC1EsKP3toI
         K5TW+CLUKAqYXG9QrPZu64tK9uE7doMiJInpSg+xive8jpiohtzQ3zcRXTm6drldsNWG
         KHW55c80oJH3f6AA/Hzb/yCABBtXWt0i9emY558TLQ+5D8nQqJ0LBo11MFGxvB677jQz
         xqwA==
X-Forwarded-Encrypted: i=1; AKwUvBxeUIO3txVQry0y0gza2jYG7gOcdbVjsg/A2guEwkVCl4yRtMJrIgcHJSItR//V5MS6jz655mnLIQrGmduILw==@lists.linux.dev
X-Gm-Message-State: AFuF++lBKSh+pkObIeEu3+IT1cWmvYa3qt4tRN1LiNfCFY4dm2pU3Yc+
	9r/EzKdpdsDdIym5F9x+nuGcYINWZ3WObKQR77xJCsvF1bjtPz5uJPjCpw5A638AlMEbdYjuk60
	ue8BenHakzfClajNQ/lenRoDq8H2LVbkmfCWSyWnGaQ==
X-Gm-Gg: AYBFou3e6lCLwShx7oOgcXCwad58QA5CQNkhPO0gZGzmuFpnD3s7yVTF5f51vkJC7s1
	JSaiyAQAzsAAClZvE0sy/CKPGV6edIeU0amuXv03tvGbvgggyEyrGoEXiShYQbMC85gRyzqpyXe
	Q5CYUp2JZm0/srudLn6WWz0IamAxlFEyS07qIuhhTQSXg5BvEuDxz4Ed3V2t45bvDC4aDkYldTE
	mToGSq2f2vBKJwDbri+Pi0yXrVTaVT/AWB5j+n37ME4SU/lh+lHwqrTDMFQqb/hr1OWaCNHVPGf
	iA7WtdWqlPQJ86PpGz3Zi7yxBtX5IM9v6/unVve3iGPvAKFHCxNFOTWu76Zs5LUcnKE12O8qBtX
	EGb2mZjZLHyIe6ft5SbVhWX2q
X-Received: by 2002:a05:6402:3548:b0:6a9:b549:701d with SMTP id
 4fb4d7f45d1cf-6aacc508f6amr2199041a12.15.1790264960542; Thu, 24 Sep 2026
 08:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-12-dac8c5eb4aa9@valla.it>
 <arKiOCGrWAKyc-bc@p14s> <arLawAw6kgFT2e0W@bywater> <arP06mWDehsIDh5s@p14s> <arP5AvA51GHrI8aN@bywater>
In-Reply-To: <arP5AvA51GHrI8aN@bywater>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 24 Sep 2026 09:49:08 -0600
X-Gm-Features: AclHuK9rmhqK1cH6j-fLQ3mp9InwiyRIAYoT3KXZouMAk75cYXsRA4d_MaQA2vI
Message-ID: <CANLsYkyT3NopaQy8CpTUrD-MTbif1dvyjaUUcQUWLzcTL7GpcQ@mail.gmail.com>
Subject: Re: [PATCH RFC 12/12] PoC: arm64: dts: imx93-11x11-frdm: add multiple vdevs
To: Francesco Valla <francesco@valla.it>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, virtualization@lists.linux.dev, 
	imx@lists.linux.dev, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Sept 2026 at 12:42, Francesco Valla <francesco@valla.it> wrote:
>
> On Wed, Sep 23, 2026 at 09:48:58AM -0600, Mathieu Poirier wrote:
> > On Tue, Sep 22, 2026 at 10:19:48PM +0200, Francesco Valla wrote:
> > > On Tue, Sep 22, 2026 at 09:43:52AM -0600, Mathieu Poirier wrote:
> > > > On Wed, Sep 16, 2026 at 11:10:57PM +0200, Francesco Valla wrote:
> > > > > Add rings for multiple vdevs, as well as the required virtio nodes for
> > > > > I2C, SPI and GPIO functionalities. On top of that, add example
> > > > > peripherals using all of them.
> > > > >
> > > > > NOTE: this is a Proof-Of-Concept, not meant to be integrated!
> > > > >
> > > > > Signed-off-by: Francesco Valla <francesco@valla.it>
> > > > > ---
> > > > >  arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts | 128 +++++++++++++++++++--
> > > > >  1 file changed, 119 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> > > > > index bd14ba28690c..dfa3b122ac5f 100644
> > > > > --- a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> > > > > +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> > > > > @@ -53,6 +53,32 @@ button-k3 {
> > > > >                 };
> > > > >         };
> > > > >
> > > > > +       gpio-keys-virtio {
> > > > > +               compatible = "gpio-keys-polled";
> > > > > +               poll-interval = <100>;
> > > > > +
> > > > > +               button-v1 {
> > > > > +                       label = "Button V1";
> > > > > +                       linux,code = <BTN_3>;
> > > > > +                       gpios = <&v_gpio 23 GPIO_ACTIVE_LOW>;
> > > > > +               };
> > > > > +
> > > > > +               button-v2 {
> > > > > +                       label = "Button V2";
> > > > > +                       linux,code = <BTN_4>;
> > > > > +                       gpios = <&v_gpio 24 GPIO_ACTIVE_LOW>;
> > > > > +               };
> > > > > +       };
> > > > > +
> > > > > +       leds {
> > > > > +               compatible = "gpio-leds";
> > > > > +
> > > > > +               led {
> > > > > +                       gpios = <&v_gpio 18 GPIO_ACTIVE_HIGH>;
> > > > > +                       label = "LED V";
> > > > > +               };
> > > > > +       };
> > > > > +
> > > > >         reg_usdhc2_vmmc: regulator-usdhc2 {
> > > > >                 compatible = "regulator-fixed";
> > > > >                 off-on-delay-us = <12000>;
> > > > > @@ -89,11 +115,6 @@ linux,cma {
> > > > >                         linux,cma-default;
> > > > >                 };
> > > > >
> > > > > -               rsc_table: rsc-table@2021e000 {
> > > > > -                       reg = <0 0x2021e000 0 0x1000>;
> > > > > -                       no-map;
> > > > > -               };
> > > > > -
> > > >
> > > > Why is the resource table removed?  There is no mention of that in the
> > > > changelog...
> > > >
> > >
> > > You are obviously right, the commit message here should have been a
> > > poem, not a form of hermetic poetry. My bad.
> > >
> > > The resource table here is causing problems with how Zephyr is managing
> > > it at its side. If it is kept in a separate memory location and copied
> > > there at runtime by the remote processor firmware during its startup
> > > (which is the current Zephyr behavior), then there might be a race
> > > condition when the aforesaid firmware is loaded and started by Linux
> > > *and* at least one of the vdev drivers (here including rpmsg_bus) is
> > > built-in. In this case, the copy of the resource table done by the
> > > remote processor might - depending on the async execution of the two
> > > processors - overwrite the status bit set by the Linux driver:
> > >
> > >   Firmware load and startup (echo start > /sys/.../state)
> > >                            |
> > >                        |
> > >                        V
> > >   The vdev devices get registered (by register_virtio_device())
> > >                            |
> > >                        |
> > >                        V
> > >   If a driver is built-in, it probes and sets the vdev status
> > >   inside the resource table @rsc-table.
> > >                            .
> > >                        . (in the mean time)
> > >                        .
> > >   The remote processor starts up and copies the resource table from its
> > >   dedicated section to @rsc-table.
> > >
> > > Depending on the system load and the complexity of the firmware, the two
> > > operations can happen in whatever sequence, causing a race condition.
> >
> > This would happen regardless of this patchset.
> >
>
> Correct, *if* the remote processor is copying the resource table to a
> specific location and expects the host to use that. On Zephyr (which is
> clearly outside the scope here) this can be enabled through the
> CONFIG_OPENAMP_COPY_RSC_TABLE option. I am keeping that disabled, and
> removing the rsc-table node here.
>
> I am planning to reason on this and propose a proper fix in a separate
> patchset.
>

It seems like we need two solutions here, one for imx and another
applicable to everyone.

> > >
> > > This is somewhat masked if vdev drivers are built as modules, as the
> > > devices does not probe immediately but only after the modules have been
> > > loaded, giving the remote processor time to start. Note that this is not
> > > a solution! but a workaround.
> > >
> > > If the rsc-table node is not there, the startup logic falls back to the
> > > classic rproc_elf_find_loaded_rsc_table().
> >
> > We can't remove @rsc-table to make a problem go away.
> >
>
> I need to re-take a look at the NXP SDK to understand what's the real
> purpose of having the rsc-table here. Judging from the commit message
> that introduced support for such facility [1], it seems the SDK is not
> really using it.
>
> Maybe someone from NXP can comment on this?
>
> > >
> > > This is specific to i.MX platforms [1] and is probably not normally an
> > > issue because - as stated in [1] - the offical SDK from NXP seems not
> > > to check the status inside the resource table.
> > >
> > > > >                 vdev0vring0: vdev0vring0@a4000000 {
> > > > >                         reg = <0 0xa4000000 0 0x8000>;
> > > > >                         no-map;
> > > > > @@ -105,12 +126,42 @@ vdev0vring1: vdev0vring1@a4008000 {
> > > > >                 };
> > > > >
> > > > >                 vdev1vring0: vdev1vring0@a4010000 {
> > > > > -                       reg = <0 0xa4010000 0 0x8000>;
> > > > > +                       reg = <0 0xa4010000 0 0x1000>;
> > > > > +                       no-map;
> > > > > +               };
> > > > > +
> > > > > +               vdev2vring0: vdev2vring0@a4011000 {
> > > > > +                       reg = <0 0xa4011000 0 0x2000>;
> > > > > +                       no-map;
> > > > > +               };
> > > > > +
> > > > > +               vdev2vring1: vdev2vring1@a4013000 {
> > > > > +                       reg = <0 0xa4013000 0 0x2000>;
> > > > > +                       no-map;
> > > > > +               };
> > > > > +
> > > > > +               vdev3vring0: vdev3vring0@a4015000 {
> > > > > +                       reg = <0 0xa4015000 0 0x2000>;
> > > > > +                       no-map;
> > > > > +               };
> > > > > +
> > > > > +               vdev4vring0: vdev4vring0@a4017000 {
> > > > > +                       reg = <0 0xa4017000 0 0x4000>;
> > > > > +                       no-map;
> > > > > +               };
> > > > > +
> > > > > +               vdev5vring0: vdev5vring0@a401B000 {
> > > > > +                       reg = <0 0xa401B000 0 0x2000>;
> > > > > +                       no-map;
> > > > > +               };
> > > > > +
> > > > > +               vdev5vring1: vdev5vring1@a401D000 {
> > > > > +                       reg = <0 0xa401D000 0 0x2000>;
> > > > >                         no-map;
> > > > >                 };
> > > > >
> > > > > -               vdev1vring1: vdev1vring1@a4018000 {
> > > > > -                       reg = <0 0xa4018000 0 0x8000>;
> > > > > +               vdev5vring2: vdev5vring2@a401F000 {
> > > > > +                       reg = <0 0xa401F000 0 0x1000>;
> > > > >                         no-map;
> > > > >                 };
> > > > >
> > > > > @@ -149,8 +200,67 @@ &cm33 {
> > > > >                  <&mu1 3 1>;
> > > > >         mbox-names = "tx", "rx", "rxdb";
> > > > >         memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
> > > > > -                       <&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
> > > > > +                       <&vdev1vring0>, <&vdev2vring0>, <&vdev2vring1>,
> > > > > +                       <&vdev3vring0>, <&vdev4vring0>,
> > > > > +                       <&vdev5vring0>, <&vdev5vring1>, <&vdev5vring2>;
> > > >
> > > > Who is using vdev5 vrings?
> > > >
> > >
> > > Another thing that should have been in the commit message. Vdevs are
> > > defined, in the Zephyr application I am using as PoC, as follows:
> > >
> > >  - vdev0: RPMSG (tx and rx vrings)
> >
> > To be backward compatible, there has to be a way to make vdev0 defaulting to
> > RPMSG.  It would also be nice if bindings were define for RPMSG so that it can
> > show up in the list of remoteproc-virtio devices like i2c, gpio and others.
> >
>
> What vdev type is inside vdev0 is up to the resource table (i.e., to the
> firmware running on the remote processor), not the remoteproc-virtio
> framework.
>

We are of the same opinion.  Up to now vdev0 was automatically
assigned to RPMSG but with this new feature, it can be anywhere in the
list.  I see your point about RPMSG not requiring hardware
description.

> Defining bindings for rpmsg would today be... pointless? Since no
> hardware needs to be described for it. The same goes for virtio-can and
> virtio-entropy.
>

Just to make sure we understand each other, there are entries in the
resource table for virtio-can and virtio-entropy.  Please confirm.

> >
> > >  - vdev1: entropy (single request vring)
> > >  - vdev2: GPIO (request and event vrings)
> > >  - vdev3: I2C (single request vring)
> > >  - vdev4: SPI (single request vring)
> > >  - vdev5: CAN (tx, rx and control vrings)
> > >
> > > vdev5 is not represented inside the devicetree because the can-virtio
> > > driver registers a single CAN network device and has thus no need for
> > > such representation.
> >
> > Then why is it part of the remoteproc's memory-regions?
> >
>
> Because a vring description needs to be present for it, or the
> remoteproc-virtio won't be able to fill the entry inside the resource
> table.
>
> > >
> > > > >         status = "okay";
> > > > > +
> > > > > +       virtio {
> > > > > +               #address-cells = <1>;
> > > > > +               #size-cells = <0>;
> > > > > +
> > > > > +               vdev@2 {
> > > > > +                       reg = <2>;
> > > > > +
> > > > > +                       v_gpio: gpio {
> > > > > +                               compatible = "virtio,device29";
> > > > > +                               gpio-controller;
> > > > > +                               #gpio-cells = <2>;
> > > > > +                               interrupt-controller;
> > > > > +                               #interrupt-cells = <2>;
> > > > > +                       };
> > > > > +               };
> > > > > +
> > > > > +               vdev@3 {
> > > > > +                       reg = <3>;
> > > > > +
> > > > > +                       i2c {
> > > > > +                               compatible = "virtio,device22";
> > > > > +                               #address-cells = <1>;
> > > > > +                               #size-cells = <0>;
> > > > > +
> > > > > +                               eeprom@50 {
> > > > > +                                       compatible = "atmel,24c1025";
> > > > > +                                       reg = <0x50>;
> > > > > +                               };
> > > > > +                       };
> > > > > +               };
> > > > > +
> > > > > +               vdev@4 {
> > > > > +                       reg = <4>;
> > > > > +
> > > > > +                       spi {
> > > > > +                               compatible = "virtio,device2d";
> > > > > +                               #address-cells = <1>;
> > > > > +                               #size-cells = <0>;
> > > > > +
> > > > > +                               sram@0 {
> > > > > +                                       compatible = "microchip,mchp23k256";
> > > > > +                                       reg = <0>;
> > > > > +                                       spi-max-frequency = <20000000>;
> > > > > +                               };
> > > > > +
> > > > > +                               lcd@1 {
> > > > > +                                       compatible = "adafruit,yx240qv29", "ilitek,ili9341";
> > > > > +                                       reg = <1>;
> > > > > +                                       spi-max-frequency = <10000000>;
> > > > > +                                       dc-gpios = <&v_gpio 21 GPIO_ACTIVE_HIGH>;
> > > > > +                                       reset-gpios = <&v_gpio 20 GPIO_ACTIVE_HIGH>;
> > > > > +                                       rotation = <90>;
> > > > > +                               };
> > > > > +                       };
> > > > > +               };
> > > > > +       };
> > > > >  };
> > > > >
> > > > >  &eqos {
> > > > >
> > > > > --
> > > > > 2.55.0
> > > > >
> > >
> > > Thank you!
> > >
> > > Regards,
> > > Francesco
> > >
> > >
>
> Thank you for the discussion - is helping in defining further
> requirements and constraints.
>

Well, I certainly appreciate that you are willing to have a discussion.

> Regards,
> Francesco
>
> [1] https://lore.kernel.org/all/20240719-imx_rproc-v2-2-10d0268c7eb1@nxp.com/
>
>
