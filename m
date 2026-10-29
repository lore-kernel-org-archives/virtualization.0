Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793291294;
	b=fXZjyPQZsChWz6eL9pu/gUs7flCNT7+aoupGTL4uRo+9eJNSTGu7GSMQb4ppxB+fb9MP
	 oXPOLcjTmJ+GzBCrR8GjgdbzAqqIYikGzVeNIKpp57C/kG099Rw72Ct3jpPvwaDlEFq8D
	 FVwxQpysIlEjNx5WZjjRhFOf+jhNyT9naXX0wDIx74+P+MmICBsAePOicsYrsbg25O4Ch
	 YvoKvXeI5I//A771XyedCOkarzGiRuNGDjzvD8N0NQb54Pjp1PBGGthwV+7sRgXfPupVq
	 s+NUo5N4b2pVHm3PybK2ZvI82WSUma+/Mt4Y7zrR0+JWMb9/19jAx/xlHHu65ut/yRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291294;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:
	 X-Source-Dir:X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:
	 AntiSpam-DLSRS:AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID;
	bh=RG48G2+/Xf5b1eZd34x5S32K2gl9o7f5x/qhJD+ObeM=;
	b=Aeg4M6GeuiCS2LdfyaPNkop4BKqHBgO7raD3I5WbtzjaFVWjraqdz++pcp4XhJ1fN9xV
	 MYr/p+MiGadFI4uhkBQl3lli9+goGe3xHMEe5SVn79pet++jJjYh4nV3/5KLu4iTLkgBR
	 YbbTRcnJcnKFdyBizll3b4Zh8DetA6BYx9xf57VxoiNL3ghMTkPyHe4G8uHkFh3/phi7t
	 EGu1OtLAh62Y3czPFfZkAwU/uL/w3dmdXSlwihs1NI84KAdmnvatGV4uHFiILXjCjG738
	 Y2qWDHUj+MJfvhrsVhG5Q1q488FlAFhWxJLiyEOtgvsdVnLxlORWDE5EfToaDyYeF5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=sdGS3qMC;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=hAVzwnPs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.4
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7784606A31E
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 16:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7784606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=sdGS3qMC;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=hAVzwnPs
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-k52m.prod.antispam.mailspamprotection.com; s=arckey; t=1793291293;
	 b=e7ISYRG4ar3nc6MDaz6vXkf5xDKedYHlNEU9NfMV8v31ypncZ31clOsMRORg0VUEBeK55Xa7Ip
	  N/aKf3PAV0L8y28hG9KbApRruzWmv3U5RDk5cSa/bSI8qT9qu7sidrJrTNBgrUPBvm75afzssE
	  lOEYXFztGC2KVulrkC5q0WKn0sKfGHJ3FrZOCQKEWNWwQYawOImEcX/9VO2a19POphu+G5APnk
	  o0W64E9XicZtbhKid8CvJfGmBENUYzcVdyvF+1nIajham+zACzTS7t1AOW788fQT3+0aMPj68V
	  aoZJGhgMDX58/h1LltBJPLkYtjyByIQs4LGPEoQVBFQMCw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-k52m.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-k52m.prod.antispam.mailspamprotection.com; s=arckey; t=1793291293;
	bh=X6S0PLqxQcZ86t8V1FtbHEUMXPAUo0p9pqPUdS7OlH4=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=DCu1LRXUG9JWgmbirOiv3gPqGK+GZm26XE5mWu/EJfQj+9OgZ1XYYTjXxpNwq6PrObYX5sO5cc
	  QDKX9lsNkXwMCwZmiyB8wFWnAVZfSpFBHpQWhRR2PIG26IUwjgcCFr+sJgI0/tnSSJtB5yF7da
	  ViqmuENkIkDpkoFd+9QvMTtKbrEKIlMBatNnBHQTAwJ00gTS/OijitGhwXU+XFVsKcFo855/dx
	  cgzqS+3iCdMmwVs5yr9qIW1+1eL3TDm5H7hzZJ0jDDYP8Vx7t/V7B0bploHOvK2nu1LbOAYL1o
	  GG5VyRLm8byFDnzQ2CCTJQuKdRoQG7rpj+tCrDOfVv4ocg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=RG48G2+/Xf5b1eZd34x5S32K2gl9o7f5x/qhJD+ObeM=; b=sdGS3qMCSFsUBGSv6jNiHVVeQC
	9crwfnM/NIvNsMaXr058n37xgEsAa7JBRvxbdfNgxAEH2RpybZ3NHrgGBREPcvHdnmtDf7+zHU10X
	oxzs+bt6aM3efvrju7nI7gBK0MDdxwmJAkzOsdvo85+VOu6uPu+FlFlNXnYh1NAQborc=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-k52m.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xMSz5-0000000AIEB-2KKw
	for virtualization@lists.linux.dev;
	Thu, 29 Oct 2026 16:28:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=RG48G2+/Xf5b1eZd34x5S32K2gl9o7f5x/qhJD+ObeM=; b=hAVzwnPscuTIF6qcGIZyE97rI1
	OIT4l7hkBehenDGqpdO8rto1+f/TVE/7s9iQ4ye8Suh7sn1Z4tL4chb9w9gvMU82IcPA498ouI19V
	KVpNZc/afShvPuabha/LEYkXv9ym8UmwTeH5kMVc8725QCD0ppYf2jHuciwt31bSB2iY=;
Received: from [87.16.26.129] (port=60224 helo=[192.168.178.175])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xMSym-00000000LSm-36Bm;
	Thu, 29 Oct 2026 16:27:52 +0000
From: Francesco Valla <francesco@valla.it>
Date: Thu, 29 Oct 2026 17:27:44 +0100
Subject: [PATCH v3 2/2] MAINTAINERS: replace spi-virtio maintainer
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
Message-Id: <20261029-spi-virtio-bindings-v3-2-ef30217abefd@valla.it>
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
 virtualization@lists.linux.dev, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=879; i=francesco@valla.it;
 h=from:subject:message-id; bh=X6S0PLqxQcZ86t8V1FtbHEUMXPAUo0p9pqPUdS7OlH4=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFmPS9iWuvQayt8ridKfMmvezl6lL2xzFmbuuzF1WXT5n
 C6FbUHmHaUsDGJcDLJiiiwh627c2zPX/FvaBsZHMHNYmUCGMHBxCsBEZkxmZNg870d2WhWPmZLj
 fucLnzf/qf+uLLT21PR1m+3YOZs+xt1k+F8a73vYaNErr+0Nm3grwy548mQsuTPl1hdnnjXRNyK
 VDnIBAA==
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
X-SGantispam-id: 50561ee220a5c46ee43665f48be6274b
X-AntiAbuse: ID - 50561ee220a5c46ee43665f48be6274b
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xMSz5-0000000AIEB-2KKw-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-k52m.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

The e-mail address of the current spi-virtio driver maintainer bounces,
since the owner (Haixu Cui) did not update it after changing employment.
Take over maintainership of the driver, which I am already working on
with the introduction of its devicetree bindings.

Signed-off-by: Francesco Valla <francesco@valla.it>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5724645bf703..c0c12d18401f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29672,7 +29672,7 @@ F:	include/uapi/linux/virtio_snd.h
 F:	sound/virtio/*
 
 VIRTIO SPI DRIVER
-M:	Haixu Cui <quic_haixcui@quicinc.com>
+M:	Francesco Valla <francesco@valla.it>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/spi-virtio.yaml

-- 
2.56.0

