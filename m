Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BB952CCD6
	for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790700184; cv=pass; b=Wtyus1H1QlzZ4K63/Ef2eB//HD+xSaH5SSEoZyubEz2Qrz+VpiCFf6TmNku2zU9S54wZ5CJ9n0cai4Nk43Z9qqS/JS7UFybWahOxJNq5jvriF9hK2KSc6YQhayNfRXPBhstInhXAvnR1nXvATeh7GN9kBURboF1Zsj2M5DlrzZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790700184; c=relaxed/simple;
	bh=NEO6eN6wS0lPN8V/79gLlvdQ8qhVcM1fQpGV/gBb6rU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AG3FabXdsS4yHor8P1lm5MQJcuqqXaJ8+nuBFHtR0vU/6DEhQaCwiA1mM+ZJtEu6K0xDaVZrCsHnwX8a4K5mxQk7KS1nRsrl62qu3OvthIPkwzr4iLhg8/cF4zVEfO1ykxz5yXHhXKyohi0t1gwwVAcdeS1xsGX7xq67CqOWD5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=Z4UjOa3V; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=C0OvlziK; arc=pass smtp.client-ip=185.56.87.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="Z4UjOa3V";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="C0OvlziK"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-97jw.prod.antispam.mailspamprotection.com; s=arckey; t=1790700182;
	 b=S7o8+x38axiIe12tIESmgpFzt76prI2ngl6UG7ukXQ3HyU7IvVuFzVoYJO5Kt+FuGxCeG1ymnV
	  8XySOUEY3TqmqJy+rVNakq4z2MfxOLUN+gMhRhhdHwns1dsPT0e+r8muXJHSL1WNVfgk9zea6J
	  impxxAOvknfs4gxBNd8Gda5QC4S9hfgv3dUNhR27o/wPIA7CM6ryBY2uUIYWoa9/cMQbfBDNY4
	  /IjGCv3bcwRQgsb5wluM4hP0kqMNfqD8wEkcVXHO3ejMdTB/0G8bTsgHq/tKSN0v28RtYx9alp
	  /rZG6cQjYu8yanOoiVXrLG5Erw1kcwtMuXrtfuvD8kxlJg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-97jw.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-97jw.prod.antispam.mailspamprotection.com; s=arckey; t=1790700182;
	bh=NEO6eN6wS0lPN8V/79gLlvdQ8qhVcM1fQpGV/gBb6rU=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=lWLzo3JYIlBUwQtWtjdQck23xir3I6tXKY/e9I8tlRzJFfwkRNKzF50nvdfArtxUCeDmcmIEbY
	  K0fsvyfO5JG/sqs+jBU67pu9x25wJmkrOcnv4+0AEmr+pUEujck/VFHJxob+D9tqfoa7++3urJ
	  94Zfbh0ZkTMyh3WJXyyqFT+BDET2Gc/QdGi3fnU5+a4zlG5OmjzS5LYh3pxuFBxUkaCUc2RDMH
	  wpIuVW3QJRRqPmYrEM3Sl7Cfzs5QYVfZR5vfLKiT1IOiQfgCP37ycOm+lWZgoO0a1a4kXDdWiW
	  LhXGcOqtRtb6uo9AY3xNr+vgPin+396rH2dBvJI60scl9A==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=GZnRLTX8nqK922cINDfyYF7LUeobLxPNi6zQddqL96w=; b=Z4UjOa3VvgIPI/3BYjBkfIMBlq
	Or6d/0FxDcgOiiOePth1ukdX2b30JLnuARkdH8P9p3iG6zDQf0QNnucGrrKJIH+agQWka7coImfq0
	RkgseBzZHfa6mHisJD56DZCt83rOczJu7n8cCaNebpDEqW9vWFATeYP4ZSW3KGLZ7AZ8=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-97jw.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBaux-0000000Ddmh-03yc
	for virtualization@lists.linux.dev;
	Tue, 29 Sep 2026 16:42:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=GZnRLTX8nqK922cINDfyYF7LUeobLxPNi6zQddqL96w=; b=C0OvlziK0x75uMAV1h1PiXonjd
	Fr4GQnyaJ/Xvvngq4KrpN2iJ+e0qsrS6+0dJTtHLjZDGjc9hgfRtOU4m3tx6AN9j1Xu1dcaIrcq+B
	UR+qb0cCBVT4mhk5Cjtkk4D+cJvMjxHjcN14Y8ZuQ9mzohVP9ycaL3SE6by/b8N/82Dk=;
Received: from [87.14.44.235] (port=61710 helo=[192.168.178.175])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBauc-0000000058o-2w5Z;
	Tue, 29 Sep 2026 16:42:38 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 29 Sep 2026 18:41:55 +0200
Subject: [PATCH 1/2] dt-bindings: spi: add bindings for spi-virtio
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-spi-virtio-bindings-v1-1-6a0eef3213b3@valla.it>
References: <20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it>
In-Reply-To: <20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it>
To: "Michael S. Tsirkin" <mst@redhat.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Haixu Cui <quic_haixcui@quicinc.com>, 
 Jason Wang <jasowangio@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2447; i=francesco@valla.it;
 h=from:subject:message-id; bh=NEO6eN6wS0lPN8V/79gLlvdQ8qhVcM1fQpGV/gBb6rU=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFm7X1XPNfFK/nbpun+WSs3a8kjnrQm103iMXF28l2xY8
 X+zu+vxjlIWBjEuBlkxRZaQdTfu7Zlr/i1tA+MjmDmsTCBDGLg4BWAii18xMiyt0eIJ8BUx4Wdh
 r33ummq75pGY9Unf9XJ5NprPE/8kfGNk2NsZxTzv4aPJIobZvacFUu+1SBf+99RoWJL24OiXvr5
 jjAA=
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
X-SGantispam-id: 1f22385bafb5a565c634ae0cc2586f4a
X-AntiAbuse: ID - 1f22385bafb5a565c634ae0cc2586f4a
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xBaux-0000000Ddmh-03yc-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-97jw.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Add bindings for spi-virtio based on virtio-device, reflecting what
already exists for gpio-virtio and i2c-virtio. A node using the bindings
is not used to instantiate the device, which is registered by the
transport (e.g.: virtio-mmio), but to define its properties and
establish dependencies with other nodes.

Add the new bindings inside the MAINTAINERS file.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 .../devicetree/bindings/spi/spi-virtio.yaml        | 53 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-virtio.yaml b/Documentation/devicetree/bindings/spi/spi-virtio.yaml
new file mode 100644
index 000000000000..5b8639dd2e1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-virtio.yaml
@@ -0,0 +1,53 @@
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
+description:
+  Virtio SPI controller device, see /schemas/virtio/virtio-device.yaml for
+  more details.
+
+properties:
+  $nodename:
+    const: spi
+
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
index 360977678f70..f91340fc6e7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29062,6 +29062,7 @@ VIRTIO SPI DRIVER
 M:	Haixu Cui <quic_haixcui@quicinc.com>
 L:	virtualization@lists.linux.dev
 S:	Maintained
+F:	Documentation/devicetree/bindings/spi/spi-virtio.yaml
 F:	drivers/spi/spi-virtio.c
 F:	include/uapi/linux/virtio_spi.h
 

-- 
2.55.0

