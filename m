Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E114CEE71;
	Wed, 16 Sep 2026 21:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789595401; cv=pass; b=AprValFLFeuCJP0EWQ+ipttPMxuZak4j55kXkx45u12LW4hU6gAutfXvfHgPEWh2mSt6uNJbdLsRmKKs9pTvF/Ja/N7xPWUrf7U9diedT8TeTyqSyQWAc50MId4yFIVPHbQAb9/70xdNMDb/6jy2FQbAE7jidxFwC/eNUSHZvso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789595401; c=relaxed/simple;
	bh=d39hVW/1aGsXzSQ8/+ghN24LusZ3o8IHDAoTyfwdSng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GC1kVYUqY9IKyIpsr8WH4mj0ZqYaDAwsTdrqYBIwfoC+bXDUa4xAz2DrKIyWCoIJ6E1jXmNr0b6Nk6Br91oFUIH6wH3nyMkJWUZoH3gqM7TX9EwOkWMYYVPUFp4kc4BMKHLeNMOccg7czoeZQUthbkdAFUWAGEVwSf6uXYwh4L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=BamQiTeo; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=SCKDfRlf; arc=pass smtp.client-ip=185.56.87.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="BamQiTeo";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="SCKDfRlf"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-xhtg.prod.antispam.mailspamprotection.com; s=arckey; t=1789595388;
	 b=P7rgFnv+ZiJDk5Mr+AqyKtXybCjubosQY+N+54+RtC51TizmasnSm8kBmUtgjupCwj8yHUULn5
	  mEiEfBPmhs8sU8flYDBdUmCSJ0ci8rdZ8Rwd9YDwUve78neKeQCZsaGT7N+K/Lnv/VGXFhjPog
	  htLrAyKZtPDYaAbaljyVMQp1hAGMqhVq9wRijmuvrxMV8dUlrRBtV/5FPQshStOh6XGGwXbHDF
	  ryn7lisQmDqRRJHk6VrZ3HR3GjMMPLP7tox++bTj0xTNLJvg37ZqbBuxiDcw+0DUvqCThZ/fCm
	  Z3QBR/KPPQjpGW1FDRjIaI8d4m6mdIt/KHSeuD69xLOt/A==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-xhtg.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-xhtg.prod.antispam.mailspamprotection.com; s=arckey; t=1789595388;
	bh=d39hVW/1aGsXzSQ8/+ghN24LusZ3o8IHDAoTyfwdSng=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=JW7LuxlJYsAPtqwsvXvBgjgR/REPOlUw68kHBUXJ4BgHNH8uooUzUnTJZsA+BsAeP/VVtZZk73
	  jLSLy0JrJzxBjxY3dGKbHZydtqOSq1VkrYB8mX7X0yhxklsJFYJPzw8GTsA820+1FOLie9CN/v
	  5v43Tco9BuSEnxR0/tHOQVd1ZIIpWq0PSyfYv9Gn1R64Y11d9fnPjbY94CDtOd5bwrRdpmc90g
	  9bw39qLm01tetI2VTgAoZh5HimDF10ie9qH24uPUs6CuAWBiHrW0mBOUuI28GYTvXMdPjAFZsY
	  nq9ub2jRwyXLEdMgfrxyQbb8Y0XXT3CFz0rZWUNlkImj5A==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=Afy2Ioh1Q8MmCQHDm5oT2HBS/WsmsNSsYcd/Fb2zqP8=; b=BamQiTeodBmwLl3fo/mmfZGyQK
	zRwhxstmzZS87XVyfksdFVMvgaeeEGeQbklbkiRQbPOWK69fOApBUMWgliIgdaqzGEOvUMW+Y8hHp
	XyloH6A33PnIoCM7h1YHKX16j2rLV4gMx8SWd25MFpH/Oc4xZDrR7mbNSmhQyBUCSD6c=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-xhtg.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x6xVa-00000003oYQ-2CDW;
	Wed, 16 Sep 2026 21:49:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=Afy2Ioh1Q8MmCQHDm5oT2HBS/WsmsNSsYcd/Fb2zqP8=; b=SCKDfRlfpwVmyCn+wFZ78jXjaM
	JcGjP4XensB8YRLwEPVSQdCv1Ht86LoYxrmAF1lLBrp2dCdOnicBOAb8vEY/D2F4x/r6wZFf8HXz/
	nGDOhr91JAoYEwfb5AG6HvYWDIRWvBg/LlQXkof2xbwt8cizF5CBH40ea1lI/8Kh5pDk=;
Received: from [95.233.221.121] (port=62880 helo=[192.168.178.175])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x6wuT-0000000058P-3LOW;
	Wed, 16 Sep 2026 21:11:17 +0000
From: Francesco Valla <francesco@valla.it>
Date: Wed, 16 Sep 2026 23:10:57 +0200
Subject: [PATCH RFC 12/12] PoC: arm64: dts: imx93-11x11-frdm: add multiple
 vdevs
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-remoteproc_virtio_map-v1-12-dac8c5eb4aa9@valla.it>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
In-Reply-To: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, virtualization@lists.linux.dev, 
 imx@lists.linux.dev, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4023; i=francesco@valla.it;
 h=from:subject:message-id; bh=d39hVW/1aGsXzSQ8/+ghN24LusZ3o8IHDAoTyfwdSng=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFmrWZ+sLG1o+nracmtWSe33Ny3VK8OF0rQftTPl7Aw7m
 Vv7xV+3o5SFQYyLQVZMkSVk3Y17e+aaf0vbwPgIZg4rE8gQBi5OAZiIbhzDf+fWp83X7c5X/u96
 sps55sqef1w3ex493f3j8a/PEROynS4w/OGIVdb8s+TZaoEjJvZvVhxVZ5jyxuMhf9+m8xunbmp
 WOMgJAA==
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 8cdcc9a29b7e5cb4fe202385223b8a60
X-AntiAbuse: ID - 8cdcc9a29b7e5cb4fe202385223b8a60
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1x6xVa-00000003oYQ-2CDW-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-xhtg.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Add rings for multiple vdevs, as well as the required virtio nodes for
I2C, SPI and GPIO functionalities. On top of that, add example
peripherals using all of them.

NOTE: this is a Proof-Of-Concept, not meant to be integrated!

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts | 128 +++++++++++++++++++--
 1 file changed, 119 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
index bd14ba28690c..dfa3b122ac5f 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
@@ -53,6 +53,32 @@ button-k3 {
 		};
 	};
 
+	gpio-keys-virtio {
+		compatible = "gpio-keys-polled";
+		poll-interval = <100>;
+
+		button-v1 {
+			label = "Button V1";
+			linux,code = <BTN_3>;
+			gpios = <&v_gpio 23 GPIO_ACTIVE_LOW>;
+		};
+
+		button-v2 {
+			label = "Button V2";
+			linux,code = <BTN_4>;
+			gpios = <&v_gpio 24 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led {
+			gpios = <&v_gpio 18 GPIO_ACTIVE_HIGH>;
+			label = "LED V";
+		};
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		off-on-delay-us = <12000>;
@@ -89,11 +115,6 @@ linux,cma {
 			linux,cma-default;
 		};
 
-		rsc_table: rsc-table@2021e000 {
-			reg = <0 0x2021e000 0 0x1000>;
-			no-map;
-		};
-
 		vdev0vring0: vdev0vring0@a4000000 {
 			reg = <0 0xa4000000 0 0x8000>;
 			no-map;
@@ -105,12 +126,42 @@ vdev0vring1: vdev0vring1@a4008000 {
 		};
 
 		vdev1vring0: vdev1vring0@a4010000 {
-			reg = <0 0xa4010000 0 0x8000>;
+			reg = <0 0xa4010000 0 0x1000>;
+			no-map;
+		};
+
+		vdev2vring0: vdev2vring0@a4011000 {
+			reg = <0 0xa4011000 0 0x2000>;
+			no-map;
+		};
+
+		vdev2vring1: vdev2vring1@a4013000 {
+			reg = <0 0xa4013000 0 0x2000>;
+			no-map;
+		};
+
+		vdev3vring0: vdev3vring0@a4015000 {
+			reg = <0 0xa4015000 0 0x2000>;
+			no-map;
+		};
+
+		vdev4vring0: vdev4vring0@a4017000 {
+			reg = <0 0xa4017000 0 0x4000>;
+			no-map;
+		};
+
+		vdev5vring0: vdev5vring0@a401B000 {
+			reg = <0 0xa401B000 0 0x2000>;
+			no-map;
+		};
+
+		vdev5vring1: vdev5vring1@a401D000 {
+			reg = <0 0xa401D000 0 0x2000>;
 			no-map;
 		};
 
-		vdev1vring1: vdev1vring1@a4018000 {
-			reg = <0 0xa4018000 0 0x8000>;
+		vdev5vring2: vdev5vring2@a401F000 {
+			reg = <0 0xa401F000 0 0x1000>;
 			no-map;
 		};
 
@@ -149,8 +200,67 @@ &cm33 {
 		 <&mu1 3 1>;
 	mbox-names = "tx", "rx", "rxdb";
 	memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
-			<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
+			<&vdev1vring0>, <&vdev2vring0>, <&vdev2vring1>,
+			<&vdev3vring0>, <&vdev4vring0>,
+			<&vdev5vring0>, <&vdev5vring1>, <&vdev5vring2>;
 	status = "okay";
+
+	virtio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vdev@2 {
+			reg = <2>;
+
+			v_gpio: gpio {
+				compatible = "virtio,device29";
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+		};
+
+		vdev@3 {
+			reg = <3>;
+
+			i2c {
+				compatible = "virtio,device22";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom@50 {
+					compatible = "atmel,24c1025";
+					reg = <0x50>;
+				};
+			};
+		};
+
+		vdev@4 {
+			reg = <4>;
+
+			spi {
+				compatible = "virtio,device2d";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				sram@0 {
+					compatible = "microchip,mchp23k256";
+					reg = <0>;
+					spi-max-frequency = <20000000>;
+				};
+
+				lcd@1 {
+					compatible = "adafruit,yx240qv29", "ilitek,ili9341";
+					reg = <1>;
+					spi-max-frequency = <10000000>;
+					dc-gpios = <&v_gpio 21 GPIO_ACTIVE_HIGH>;
+					reset-gpios = <&v_gpio 20 GPIO_ACTIVE_HIGH>;
+					rotation = <90>;
+				};
+			};
+		};
+	};
 };
 
 &eqos {

-- 
2.55.0

