Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778274DE711;
	Wed, 16 Sep 2026 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789595386; cv=pass; b=NsPgJpdskjG68ekByQOc2ib3/1ZHYT/Io65X0GgOLOisUxItHJgVH2+rR2rJOSBY9XJLzVNX+vR/6EqcPbe3wUmMZL0720GlK7EnQaw3R/Rx/5DtX1JwfS1UIxtlDDONAaP7D1OzNjS92KRd1XF5eRAhcxAd20/ZSF9bNIxaKCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789595386; c=relaxed/simple;
	bh=SArq2+UwtiAN8KF2iej4IW97HFnrOvv94ZfX1GMeV2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bwS+wkKN7XxOj4W+ScjCZ4aPb58hkNeebOkog4WQqv2Kb8MFIf0E4x5MPE3czOKeRjSgEGAcUxgRk3iPrls3guEzQj/Xg/YSkarkH0VyNHlA3aO1f8GS+07BjhNPRvpjImpsNuOkW03+9zC4ILuOfIaY6kPTCE8aroIHGC8gXvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=V2WpfNv7; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=akkfbjnQ; arc=pass smtp.client-ip=185.56.87.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="V2WpfNv7";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="akkfbjnQ"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com; s=arckey; t=1789595373;
	 b=VsOgyCQrJ/MTHu7wy9u+b7JaVQ1DVge1R5hHcJ97cWyaauskZXzqdjALcLyF6xhjbGhHd5233i
	  8TBfUj/G4b8hhxzlE2GJvuAXo1VQTrvDKXxYDn2i7vW0gVCv49onhN3ay48CFMVnDMzA8B2OKz
	  nufPHFUWlGVYAGeJXU1qb91HtvAcRQUKsfJBZ6FqlWNMvd2EDc2oNLTarYUhLgU8aI10pz6smV
	  n/kVxGWJIuhtwZMB9lKdsbYrd2QimgKe9aV3arDzsKiOHi8x4jkyg3fwvYWzWjVHUD401tzpiv
	  x7afHyJ8IfXOBk3ifuq1KE+mahyoqJMkEXGjpf8uwYeaNg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com; s=arckey; t=1789595373;
	bh=SArq2+UwtiAN8KF2iej4IW97HFnrOvv94ZfX1GMeV2c=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=gnRdzN+VEFYE2ugcdqCgOcb9G8+PQrjOEGhRU4DC2VxHwIJyILcQEah8NExdEpgUUU5rGksOwh
	  0Q0SLAnIpm36UEA2uTiqremmucJwivLXbw5mJMZgS6yuIPMSGttCviLZQStnSj/MVQ0jWOqy2C
	  qc5H7LymW0u4w29xpCwoqGHzc2Py1EKGEmAjDLJq2zOUAAISmCu6/16AioO2K8ICWU9JEiyOIe
	  1Qnkod94diC8LYXPY+AJlZ1gaGwXwHqk6rBsOm0wi3PJ+b2ScIgtBHyYdZ5HPp6FfmDOVBMCsk
	  A7sfFFWG4NsMYx80wGQYO4ZhkKMrh8jCXgD/lPbHH4RUmQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=/1xXAR7sHjfiShKLvtMcClqJDZUo+C9C2NEO/Y0JRUM=; b=V2WpfNv7yCSjevyfcJdlwp4QEM
	jyc47u7zrZ/mqoIgtelLQdhe2aT0oOpuaj6HUL7lSY25GvbVKsrggEzGYPhBwGltu5p2bx+X0WsR9
	rSFKUMuNxsvIC6r+I95Z8gGgccmIulHj5wqnQhNZIZsWTncTnI46D0TROhKOwT5mQhq0=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x6xV9-0000000C8pz-2IrX;
	Wed, 16 Sep 2026 21:49:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=/1xXAR7sHjfiShKLvtMcClqJDZUo+C9C2NEO/Y0JRUM=; b=akkfbjnQKAX39GctHP0syTEnII
	DLYHpi+xCRoGyRpbvM7sB13vwPQrXehzIp2YtpSBCHtIOIu+7xVLEfyYX80mTiU+GUeDYw7PabRsr
	KtMW8JOZbi4InQ9KtQj//etRtThJILkS16sOkj3jS8Sia8fkYxykfu5iqGFUs7yjKpp4=;
Received: from [95.233.221.121] (port=62880 helo=[192.168.178.175])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x6wuS-0000000058P-3B0Q;
	Wed, 16 Sep 2026 21:11:16 +0000
From: Francesco Valla <francesco@valla.it>
Date: Wed, 16 Sep 2026 23:10:56 +0200
Subject: [PATCH RFC 11/12] dt-bindings: remoteproc: imx-rproc: support
 virtio
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-remoteproc_virtio_map-v1-11-dac8c5eb4aa9@valla.it>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=884; i=francesco@valla.it;
 h=from:subject:message-id; bh=SArq2+UwtiAN8KF2iej4IW97HFnrOvv94ZfX1GMeV2c=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFmrWZ/MSVkl8zrTvFOW0TZozZQTHX5Tr3Okt99Tdb57f
 s0JnZ2fO0pZGMS4GGTFFFlC1t24t2eu+be0DYyPYOawMoEMYeDiFICJxC9hZFigZPTpgLCvUXRH
 WHH7rYUSvwtd5q7ZWCf876rHPkMdPjFGht13JldxuRXvP3L6YLFt1pQvnkZZRUwBkqFH/v9mejv
 RgQkA
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
X-SGantispam-id: 2c1c98afea440222a3f78b7ab00f1b96
X-AntiAbuse: ID - 2c1c98afea440222a3f78b7ab00f1b96
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1x6xV9-0000000C8pz-2IrX-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Add support for virtio devices description.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
index c18f71b64889..32fc415c7028 100644
--- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
@@ -92,6 +92,7 @@ required:
   - compatible
 
 allOf:
+  - $ref: remoteproc-virtio.yaml#
   - if:
       properties:
         compatible:
@@ -118,7 +119,7 @@ allOf:
       properties:
         power-domains: false
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |

-- 
2.55.0

