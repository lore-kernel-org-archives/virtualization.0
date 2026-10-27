Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.56.87.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793086022;
	b=pM8vw7elN/T7hdooGeBHEx3qlgWvs3ufr7R+naKjtk7Vj2yr7tYbpXuDAz2k9cr8QcRc
	 6TIPa9XDBvXAgdoQwoQ+vUwBWJ25qyN+nwEECTNq0nbQW3G2HRP+hWDfb6I7/T405COJE
	 ppmt7uX8B7sGqoniygOP98sh5vdgUelUPl2G5EAI9gjMJAfTjEq7qjYsNsoh8POWBtIO5
	 VHeWod5AQn/NvvSq7xoX5Xvphc4SOzgbQCqKjlTV52S6TUqTNR/87nuVaPbDSW9CoO7Dd
	 I4qQoQaGY7l87hh9qG3R0TqnshRKIzeePlfXqDIRLXfUlezkvDR11fJU2m7bL6WzQBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086022;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:
	 X-Source-Dir:X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:
	 AntiSpam-DLSRS:AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID;
	bh=pNrCuIc4nI/9b2HUfvsMvC1mEskTl5Io94M+bohlWuA=;
	b=s3GBLMrZpPi0maj7sEe5AmnlULhuoQX0I3rokgtLVcKNxDIgLPskr2Az96Wql18/4yht
	 REgM1G7yGcKmpLp2L1S0k2y9UyZlmwum2Y0tK1J4KwamA0vGekB+Xl36T4Xaod2I4dF/A
	 NwNVDMvDCZfwAP1e4s0/RdkXhVxpwO0bfEzhUaXOnk0Rugh9LPsUQj9vPN0n2LlTmKl85
	 rsptAStf3stnb46Mo1aSfRmNcIK9hDoshp1oTAQ3puf5QrPlt+evUtKhaqh8V8F8F2ZiZ
	 dQQvozwFkgXpatIuga48wMMYKTk4bu10lBmS40Ne3Lt1dTMlx5y1yjtOi7WKRXGnCsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=dqFmRRT1;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=Oed2ALse;
	arc=fail smtp.remote-ip=185.56.87.2
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A406606A31D
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 07:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A406606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=dqFmRRT1;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=Oed2ALse
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-l70q.prod.antispam.mailspamprotection.com; s=arckey; t=1793086021;
	 b=bzDP8ALErd+5B2bnlTnIdhOkGl6Q4Ybxc/Sus0kzBRRoT45p7BncYcTjYG6DpFNPTaCIC1DQQe
	  EeQVRvbjDpUJTsk5mTHKK78gfAAmDm2JPBWxOyLNFZK5xxC+FkOaXaqKVaJ0r9zf9blxsVRj87
	  G1Zfc/Jn7m1Rw9sgb9Ry0LCFpC2/opVpiQtKyolRadc+KLqwmLoYRQoRnh65wkt3obd6BJFUHI
	  xGEn01ff1tDejRyvF0ZdtJ/s/EOBPljLEw9+ykKajwJ1KiRlM2cLQXIMv9ijsy+XAr2iYCmuWZ
	  pFgud4v5j7iLITZ/EROOVDEHmgZiG1xLgP1XLHEiRhdWnw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-l70q.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-l70q.prod.antispam.mailspamprotection.com; s=arckey; t=1793086021;
	bh=LDK4LugOQZXd6u5/d174ARNfTIWaTg73VhRuc2QL5ek=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=PMaFp8AdOf8JZXUyjpBe8/HE0IXb6OSu58l/VXrOrDf0JtiVo4rB5nZKUWGxozPfG2b4wg6FF1
	  UromU6hOunACzCzcjtIfeFR5/ZeRyiC0BZ3m1DZNseuUOUnK1ExGnBvR79alP00wHV6NrrgD0K
	  ODHf9o8nJNo2jAeMS3WxeUHL7xbQxqXNiqY3ByXc6jlqhg/95W5pKZOxEkrATaQGLfRA/EGUfo
	  pVg7jb2cRB2X6GJmu7wPSA6HU/eC0So06LxYrN4K6b0gnrpoX/il1pQhPk8+4Mdl60p1WJbmSj
	  U7AIggUlo5+x3oGqGtc0MT42rHTFK52gtX+jWPAuwz1QYA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=pNrCuIc4nI/9b2HUfvsMvC1mEskTl5Io94M+bohlWuA=; b=dqFmRRT1KAItv0f88avZshP3Vz
	x2vCrZ97q7D/a8Tj2bnJobMnDIAFY/ZkeUnRyeqJmlQF3enehpkTgEt1mv6sMA6/XXUuKyI1ZbJYg
	hDEVwvaAeQl3M1x4YYNtl2y6ArQEj7q94jrGvMI4b0GxsyuuTRHZ+rutYx9EeR56L59s=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-l70q.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xLba9-00000006vBb-0658
	for virtualization@lists.linux.dev;
	Tue, 27 Oct 2026 07:26:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=pNrCuIc4nI/9b2HUfvsMvC1mEskTl5Io94M+bohlWuA=; b=Oed2ALseIjUH49kWwbydqZ2kYy
	abWprFTLqJF5kool4AYE4TnE4sdyR8DbTZ3KzdzuNAkjIs1ZsZoIHMfyLTB6bprc3YN1QI6rD8PVO
	PJKxJKkiFrXfTn2nScycsiRVzApxdPo4boVWUfvrmA/H82sCCSkLwtZQKKM5SPor9rXM=;
Received: from [87.16.26.129] (port=61474 helo=[192.168.178.158])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xLba5-00000000J9d-0gu3;
	Tue, 27 Oct 2026 07:26:49 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 27 Oct 2026 08:26:33 +0100
Subject: [PATCH v2 1/2] dt-bindings: spi: add spi-virtio
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-spi-virtio-bindings-v2-1-67927b24b9d4@valla.it>
References: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
In-Reply-To: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
To: "Michael S. Tsirkin" <mst@redhat.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Haixu Cui <quic_haixcui@quicinc.com>, 
 Jason Wang <jasowangio@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2532; i=francesco@valla.it;
 h=from:subject:message-id; bh=LDK4LugOQZXd6u5/d174ARNfTIWaTg73VhRuc2QL5ek=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFkPgsz/aMoXTavtuyfE0phhOeXp/YTMRrlpKtfeJ4Ws/
 in6b19iRykLgxgXg6yYIkvIuhv39sw1/5a2gfERzBxWJpAhDFycAjARh+uMDD+mPY+QXKYq2115
 w+m05MZnhSlBRldFxHZ5n7NKlYu1aGVkWHfMubOWMdRymt2Hq+58j8qUnUuPeGWIzNQwY/jVvVi
 bCwA=
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
X-SGantispam-id: 3770073a47b85d9e20f44fe8ae2929bf
X-AntiAbuse: ID - 3770073a47b85d9e20f44fe8ae2929bf
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xLba9-00000006vBb-0658-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-l70q.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Add bindings for spi-virtio based on virtio-device, allowing proper
validation of SPI controller nodes declared as children of virtio
transports (e.g.: virtio-mmio). Such nodes are not used to instantiate
devices, which are registered by the virtio transport, but to define
their properties and establish dependencies with other nodes.

The compatible follows what the virtio framework already searches for,
"2d" being the hexadecimal representation of the SPI controller device
ID defined by the virtio specification [1].

[1] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 .../devicetree/bindings/spi/spi-virtio.yaml        | 46 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-virtio.yaml b/Documentation/devicetree/bindings/spi/spi-virtio.yaml
new file mode 100644
index 000000000000..5fc04a9c62cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-virtio.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-virtio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtio SPI controller device
+
+maintainers:
+  - Francesco Valla <francesco@valla.it>
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+  - $ref: /schemas/virtio/virtio-device.yaml#
+
+properties:
+  compatible:
+    const: virtio,device2d
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    virtio@3000 {
+        compatible = "virtio,mmio";
+        reg = <0x3000 0x100>;
+        interrupts = <41>;
+
+        spi {
+            compatible = "virtio,device2d";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            sram@0 {
+                compatible = "microchip,mchp23k256";
+                reg = <0>;
+                spi-max-frequency = <20000000>;
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 03649f08c7c7..5724645bf703 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29675,6 +29675,7 @@ VIRTIO SPI DRIVER
 M:	Haixu Cui <quic_haixcui@quicinc.com>
 L:	virtualization@lists.linux.dev
 S:	Maintained
+F:	Documentation/devicetree/bindings/spi/spi-virtio.yaml
 F:	drivers/spi/spi-virtio.c
 F:	include/uapi/linux/virtio_spi.h
 

-- 
2.56.0

