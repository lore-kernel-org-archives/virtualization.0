Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.56.87.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793291299;
	b=06/xsl7yYXXrjdjwqHdcweNEChs87rm/LBM2iiMxKr1mQsibHu4aVV83+LWm6vCEA80R
	 VoUzM85qjVtahsiGhAcLmIOrSfQ764tBVOgoYDgvgIPXDMjKc6dt3rgtu1yrhvXxdWzJA
	 /W+HGzjHUnIa7rDl1YRhKyVUfF+qSrXRz7G2rqNzwvZd++1Uc9hI0b7xR7VxGpOIBBGYl
	 Ybvb4x5wgc8TexkMFcHyskfZdCKNyVbWdzRu3tmVTdqbhqjfTkIYxJHMJwbOLkF1SgAuG
	 Hnr6Fmwpa9fqx+irPkus7hGBX9Cp6M+mfAgX7/eNaBYazO7z6Qrp9sHo5vRejRVJIOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291299;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:
	 X-Source-Dir:X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:
	 AntiSpam-DLSRS:AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID;
	bh=qzZZ46lO4KbnLO67zSOK1gQ54aowsw3oRwEUjqeFz+0=;
	b=0P4zP0Q62T3qzfHgKR/mNCgACaXGI/e99qTIQBfxmXg980nTu88XDfUwdf669zY6X69S
	 bXk0uVDB4v525qhNLHqFmmHzSXBhd0WC4JF4wEkrTCXw78ivEMvekkI96qva84HFKqQHo
	 rkbupPIDgWjs6rgr6cwGMRk3I0Kru3A5KaIK+VSpa1RIQ9yO1fk1KmxtkOO552Pp5SKTq
	 txgBB65k3dXw5d9DbL1HOCsHTNua3UzF7pnVF4tIdYJKKt5JivyT+9plEJSAtWlPrGXyE
	 x1ioPNj0Fv6ZKA05kvpHKvxR2Genoyj9/H34VblohGbfX0BZ4bhn1jULIWAIhtSZVcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=S42QvQtT;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=WZgR0WO5;
	arc=fail smtp.remote-ip=185.56.87.7
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F1606A33C
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 16:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 427F1606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=S42QvQtT;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=WZgR0WO5
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-h5rs.prod.antispam.mailspamprotection.com; s=arckey; t=1793291298;
	 b=IMXkIHnHp0MEfTpZ5QxkfIQ0mXhszoSw2F/l+rLn4Pqw5Q/wZm+TN9sQASSN9wsAwqvHkuYH3p
	  bi8EbajLiKqai82VLk4ERN7QgrxNVD6e5u+l08SpYiYl8/ZVDVZ/r+LuKhIo7IB2IeS3wNHr9I
	  IUVq/M14q8zOCuVniF8kCMb/53LVkfSmdY+RcTGVxg3TOQK/gFV1vXK0a5PrJHwhvqIXvFAaNd
	  RkG5yp4a6asAm7L0XNrKDQv897hO9ySwkRpfFRxhTzPugkxXsFqEhg8TDtgmklP3K7UHY+Ep/B
	  N3UZC7Za/FEZEpCa05YT3bQoJmillIYxsQulm1mcpcaidQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-h5rs.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-h5rs.prod.antispam.mailspamprotection.com; s=arckey; t=1793291298;
	bh=7b/4UNnisenlSzsvuHFwODw1hJLbDH9CfkQsAIZ2bPU=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=htUucZyekTIMNnUZaQtQsQXMmfSPFeLhUwF2NrnUeHbuemVKBfyM4wMDTZ1JevX0N0ea40Vh7s
	  +LVPqeVjDT6utTBaUm6auqw8sZGiHhLSpxlYbcf7D7Wro/Iw6VJAIVncktRNjDaezoJkKWRAGM
	  /DF7zmbIGC0doEpzZ2pU9ABj2Dmu+GrVYneKKmeT8JU4P8PRg5+QosOGiqXYFBmfZbqUx/2tpr
	  abaPgO/bRgrOXsi/wvUJinI0c/V9DdjGUGzyiBdOC7cYUvMOC+SbQ2O54UytldUQvMHhZMn6kJ
	  erL+XcZcAaZSL9zuyOEtDxgZycLzdjR1xRnCrn1ekoMAww==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=qzZZ46lO4KbnLO67zSOK1gQ54aowsw3oRwEUjqeFz+0=; b=S42QvQtThoaZaWQfx0uZMLVv9e
	sT0DiUnSNWJGrx5E6TnD6+pNamFCbEnXOUKfVpKzb9UPiYn5SBUwvFawip9mrZ/Z2ZVwz7KjTHvle
	Nq0py9dkWYJgePfEP7KaNkjhcWz1wK6Xp3bXd8TYX+3Yv+rMZxKR8XBO8GSyCxidR4Ug=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-h5rs.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xMSz4-0000000936S-15sg
	for virtualization@lists.linux.dev;
	Thu, 29 Oct 2026 16:28:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=qzZZ46lO4KbnLO67zSOK1gQ54aowsw3oRwEUjqeFz+0=; b=WZgR0WO5GkOpt6JEDqE5J7VkIM
	8yH9x2HH4c9GfuP6utiGDonzti4sk01RUOSv+p0YOcQUnKbukIKKSpZKLMREzyimyvhFyx9mA/io4
	H3pul+vWnlVGN1YgKvdGatyrr2sLGGvoxY+QxJvJ/o0VhH/426M+M91cnTu801/0ssFY=;
Received: from [87.16.26.129] (port=60224 helo=[192.168.178.175])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xMSym-00000000LSm-0Rqv;
	Thu, 29 Oct 2026 16:27:52 +0000
From: Francesco Valla <francesco@valla.it>
Date: Thu, 29 Oct 2026 17:27:43 +0100
Subject: [PATCH v3 1/2] dt-bindings: spi: add spi-virtio
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
Message-Id: <20261029-spi-virtio-bindings-v3-1-ef30217abefd@valla.it>
References: <20261029-spi-virtio-bindings-v3-0-ef30217abefd@valla.it>
In-Reply-To: <20261029-spi-virtio-bindings-v3-0-ef30217abefd@valla.it>
To: "Michael S. Tsirkin" <mst@redhat.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Haixu Cui <quic_haixcui@quicinc.com>, 
 Jason Wang <jasowangio@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Francesco Valla <francesco@valla.it>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2605; i=francesco@valla.it;
 h=from:subject:message-id; bh=7b/4UNnisenlSzsvuHFwODw1hJLbDH9CfkQsAIZ2bPU=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFmPS9j4AgrnsdxhU/x3WnsKT13UxK//uHx/2fCcsr2/6
 Fed8hGljlIWBjEuBlkxRZaQdTfu7Zlr/i1tA+MjmDmsTCBDGLg4BWAiO7oYGe5P+i0R/4hN+3uA
 ZczDyTrpXbtmbFtwKED91/2Jkca17+8xMjSHnV27dsGRP1HHjzQ8fc/A0N50v3tnpY9BnvqKJKv
 L1dwA
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
X-SGantispam-id: cdeba2f074e68eb5d45a88aab6af0ed8
X-AntiAbuse: ID - cdeba2f074e68eb5d45a88aab6af0ed8
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xMSz4-0000000936S-15sg-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-h5rs.prod.antispam.mailspamprotection.com;
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

