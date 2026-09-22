Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC89854CF6B
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091839; cv=none; b=jey2Uzuw5Q5pza4/lzIml3XVfAAe/C99qMzyeU4zPiYpbiTrGTxglQTekHIiI9ci/LWUqHFAEKTg7r/c8MgSScEm0TD+d9QG/eDQbksknJagkyCqYuTzrlGQ5aNglu0Ka0zZVPzy4F75CSGVb582ZuzlgPBzcq51Pgb2obbeMiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091839; c=relaxed/simple;
	bh=MPJa407hEU35uhm5nNbxl1o7nH1It+GZNahj267Ph9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMRKpq4KzzVJugt9R5GwMMHxDYgU/2Xm2f8HV2JZYG7YjzuoRDZ0w49XrdwWVVI6g3OgT6aRayLG0Awnzi6Qq4swC9z0VLA8NRz/jIx3dLEbeHExmPIJ4evp5N1MYwU8SIiPsMJRV1TWZjakMzUW5nSmKFEPY33EIQKbmhmMzKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xDEQN812; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xDEQN812"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24afso24097a91.3
        for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 08:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790091836; x=1790696636; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M3+7e8iXJEjn74p0MvD+DqdSnpalQ9TYucgtTBbjy+c=;
        b=xDEQN812OykqFWBD+YpMJx+rqv9F6tjUrRrYd5yEzh0GF0kRwpeRIiVXvVlKmUvFfT
         dQkz1axgKiIE6PmYxd8K5Y0fY4GnUd0FguDhk1kKXi+1xwLIVvHymBXx/304m5ei12CW
         Vdd9SKK1n59tXLvXDaV4kbTg7MQTO+GKhAyHSTz9aSsoYXVpNxel+EI7Ij/tRhhW0grd
         rbTj0y/FurQRn2TkqpPde4qEX76K6p4CfkSkwADFjSPjOc3NmPGPtwQyaHk6ge3CHUuN
         mLQ+xLf5spW9xrLPk9MGnJjxCLbirtGQqO5XOiYB0708FJZflNqg+CUX5qyPfWUYNfxr
         WW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790091836; x=1790696636;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M3+7e8iXJEjn74p0MvD+DqdSnpalQ9TYucgtTBbjy+c=;
        b=QF+QVSDwPyb9LD81/adQzpRSgPLLtffiKizR/KW/GsZNnplboYFkuhoySEikv7iIGB
         dYwvo8SkQQjaWzhJDWkIMha0lThz4R7FaKWVfgiVkA5VsdN+3utPVdJdbrfE+BakY2N1
         eQFU1BXYOwxQfOF6TqRZlNowV+9ukH51FHqCTy1Ez3MM1nhgYVX85695uNXS5ex1j/kR
         5XBFYad4xfMr5gYeQUOIGjiFA4ug/yE5TcsMLaBvirkrXBVJFpHvPsly94AUPeSlWe2F
         7/GWf2mDWfBldDdnKMijJTswddlxhARsRJ6uHxT5ypBUyoHrEjzFTLBzhFoTyipc6BiO
         7EKg==
X-Forwarded-Encrypted: i=1; AKwUvByKo2PIyPM4meu6rn9xtsNhYMWjw9+P9A6I/3tbIZ2v5hd/GyaGk7Cv9I3qOZQXqGasz9ORm7MNuKd/wGMCaw==@lists.linux.dev
X-Gm-Message-State: AFuF++m6M06P4K7QAR3WW8OMvETG2Ty3SLRavgZohm3PsDuPq5t+puUq
	CU0wTtPLPGzDPCFKxskId3txSow6GhW5thlga4k+6KJ7lcCGFanvo2++G38TRQI34kj8SPcsQTR
	Uy9vr
X-Gm-Gg: AYBFou2c+GDEC48I2C14klbKzuxLFSP7IBRPBRsFoxXvZKtt4/1yTePAqbZkFQaFRcG
	goUXDRVkb+FA4op04Ov59rubnp+kyW5UNOo8gFpAjfvD9ztUOHdxCtKOg3MC/8fv1LqtTB7hAVd
	pTYrWbB6cgRAC1pGxJI7fsmU1iH0DxDIH29omfT9ZuajSaw+UJ84l6o7srO8kORg5W8eJHABe1v
	uAfz2frUBD4E34bD7Gfruit39qILfMa3CMWekJWaiQgF4NcEKl2aZTkSVxiDXdbLSReHf02KyEx
	qmarTE7rnXe8YopGh3GanmF+K0p34cI0igD39ltvuenoDyeWEim9p2c95HTQAtf/kCBQIZdZ46V
	nymodSVRvu8FRZ5FgeRT+SoAYkxa7TU32ESHkj8fQZxjPjt2wUgGE25WVHJRHIZygAxMHacYfmg
	po68ms5KodHbUX0VFfD4wjM2tWv4p2nSSU1ILFC96bG4XG4Qngo/c8mFBzEES6E1E6H9QhfC9i5
	ahW/k+Nl9I=
X-Received: by 2002:a17:90b:1d48:b0:39d:efa9:cd25 with SMTP id 98e67ed59e1d1-3a07306c5d9mr1633442a91.2.1790091835796;
        Tue, 22 Sep 2026 08:43:55 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:1046:ab8:737c:d2e2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dbf69f0sm34882a91.8.2026.09.22.08.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:43:55 -0700 (PDT)
Date: Tue, 22 Sep 2026 09:43:52 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Francesco Valla <francesco@valla.it>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	imx@lists.linux.dev, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 12/12] PoC: arm64: dts: imx93-11x11-frdm: add
 multiple vdevs
Message-ID: <arKiOCGrWAKyc-bc@p14s>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-12-dac8c5eb4aa9@valla.it>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-remoteproc_virtio_map-v1-12-dac8c5eb4aa9@valla.it>

On Wed, Sep 16, 2026 at 11:10:57PM +0200, Francesco Valla wrote:
> Add rings for multiple vdevs, as well as the required virtio nodes for
> I2C, SPI and GPIO functionalities. On top of that, add example
> peripherals using all of them.
> 
> NOTE: this is a Proof-Of-Concept, not meant to be integrated!
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>  arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts | 128 +++++++++++++++++++--
>  1 file changed, 119 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> index bd14ba28690c..dfa3b122ac5f 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> @@ -53,6 +53,32 @@ button-k3 {
>  		};
>  	};
>  
> +	gpio-keys-virtio {
> +		compatible = "gpio-keys-polled";
> +		poll-interval = <100>;
> +
> +		button-v1 {
> +			label = "Button V1";
> +			linux,code = <BTN_3>;
> +			gpios = <&v_gpio 23 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		button-v2 {
> +			label = "Button V2";
> +			linux,code = <BTN_4>;
> +			gpios = <&v_gpio 24 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led {
> +			gpios = <&v_gpio 18 GPIO_ACTIVE_HIGH>;
> +			label = "LED V";
> +		};
> +	};
> +
>  	reg_usdhc2_vmmc: regulator-usdhc2 {
>  		compatible = "regulator-fixed";
>  		off-on-delay-us = <12000>;
> @@ -89,11 +115,6 @@ linux,cma {
>  			linux,cma-default;
>  		};
>  
> -		rsc_table: rsc-table@2021e000 {
> -			reg = <0 0x2021e000 0 0x1000>;
> -			no-map;
> -		};
> -

Why is the resource table removed?  There is no mention of that in the
changelog...

>  		vdev0vring0: vdev0vring0@a4000000 {
>  			reg = <0 0xa4000000 0 0x8000>;
>  			no-map;
> @@ -105,12 +126,42 @@ vdev0vring1: vdev0vring1@a4008000 {
>  		};
>  
>  		vdev1vring0: vdev1vring0@a4010000 {
> -			reg = <0 0xa4010000 0 0x8000>;
> +			reg = <0 0xa4010000 0 0x1000>;
> +			no-map;
> +		};
> +
> +		vdev2vring0: vdev2vring0@a4011000 {
> +			reg = <0 0xa4011000 0 0x2000>;
> +			no-map;
> +		};
> +
> +		vdev2vring1: vdev2vring1@a4013000 {
> +			reg = <0 0xa4013000 0 0x2000>;
> +			no-map;
> +		};
> +
> +		vdev3vring0: vdev3vring0@a4015000 {
> +			reg = <0 0xa4015000 0 0x2000>;
> +			no-map;
> +		};
> +
> +		vdev4vring0: vdev4vring0@a4017000 {
> +			reg = <0 0xa4017000 0 0x4000>;
> +			no-map;
> +		};
> +
> +		vdev5vring0: vdev5vring0@a401B000 {
> +			reg = <0 0xa401B000 0 0x2000>;
> +			no-map;
> +		};
> +
> +		vdev5vring1: vdev5vring1@a401D000 {
> +			reg = <0 0xa401D000 0 0x2000>;
>  			no-map;
>  		};
>  
> -		vdev1vring1: vdev1vring1@a4018000 {
> -			reg = <0 0xa4018000 0 0x8000>;
> +		vdev5vring2: vdev5vring2@a401F000 {
> +			reg = <0 0xa401F000 0 0x1000>;
>  			no-map;
>  		};
>  
> @@ -149,8 +200,67 @@ &cm33 {
>  		 <&mu1 3 1>;
>  	mbox-names = "tx", "rx", "rxdb";
>  	memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
> -			<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
> +			<&vdev1vring0>, <&vdev2vring0>, <&vdev2vring1>,
> +			<&vdev3vring0>, <&vdev4vring0>,
> +			<&vdev5vring0>, <&vdev5vring1>, <&vdev5vring2>;

Who is using vdev5 vrings?  

>  	status = "okay";
> +
> +	virtio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		vdev@2 {
> +			reg = <2>;
> +
> +			v_gpio: gpio {
> +				compatible = "virtio,device29";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +		};
> +
> +		vdev@3 {
> +			reg = <3>;
> +
> +			i2c {
> +				compatible = "virtio,device22";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				eeprom@50 {
> +					compatible = "atmel,24c1025";
> +					reg = <0x50>;
> +				};
> +			};
> +		};
> +
> +		vdev@4 {
> +			reg = <4>;
> +
> +			spi {
> +				compatible = "virtio,device2d";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				sram@0 {
> +					compatible = "microchip,mchp23k256";
> +					reg = <0>;
> +					spi-max-frequency = <20000000>;
> +				};
> +
> +				lcd@1 {
> +					compatible = "adafruit,yx240qv29", "ilitek,ili9341";
> +					reg = <1>;
> +					spi-max-frequency = <10000000>;
> +					dc-gpios = <&v_gpio 21 GPIO_ACTIVE_HIGH>;
> +					reset-gpios = <&v_gpio 20 GPIO_ACTIVE_HIGH>;
> +					rotation = <90>;
> +				};
> +			};
> +		};
> +	};
>  };
>  
>  &eqos {
> 
> -- 
> 2.55.0
> 
