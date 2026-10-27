Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.56.87.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793086023;
	b=oRPA0PZtf3VAkBbpRrBgmR4HV//acrh3wU6t4XFaWqJGFnJc4tJ9PrytbKmmyqTvK4Rm
	 HeJX3DhzvtlGjB58ceq6yD9z4YDgtYiB/4iokLxsEiQJWOBVwcTnagSa8zL6b+4frthev
	 n4HaBZKD2dVOnmzJ76crBouma9DhV7chSewFeAezmjQH3DB4FL0L24Zo/mAij25THF6lC
	 ThIXbKv8edi5Xnqgta80ra6JZdAqOP31YTUA6IwKJQ0AXRPsYt5kqCVtlQYSKVmg/x86i
	 FxGYDBZKfK7OSKN2QQDs39ARLMkEZ3+4V/5Mp+Zy9R1Basd8olxlzftu9jmAZSkTXSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086023;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:
	 X-Source-Dir:X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:
	 AntiSpam-DLSRS:AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID;
	bh=eB359adIOGVwMJGfc4eVy6ZjoIVNVGA3YSvr7zATIfs=;
	b=rKuxsYEYNZMQ6HGOF1mVHwMB+R6YeZm/SZkmqTaRiZbRsiX6SN+MpI/M8W5F6NpYd3co
	 /+NBvG2NEcgjN+5L15vtMekkQlGOWzqeQ2a7ZyesrehGczhzoxPCuOteod3RG5P+4EYo+
	 ZNz1U1Q2vfrGwoZExxQ97CIMn6h0c9gonmAybwLEotjmLPnGUuO+l0iigk8GnkbJEzvgK
	 yh1FpNMUyxc95iWDreIjVCHzDIP5aKsHHoTX/5p2+7KYZ+gk+/c6PQJAdxo6ilq6Yt5Do
	 kLcozNyDtkO6yBtQVahbC8mUuoTu73OkhfHbbqtEjV0H402kL1N12tmHu+xv5RcYl+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b="n/WzLfLc";
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=L6Aq6yRi;
	arc=fail smtp.remote-ip=185.56.87.6
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5322606A31F
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 07:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5322606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=n/WzLfLc;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=L6Aq6yRi
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-ppm8.prod.antispam.mailspamprotection.com; s=arckey; t=1793086022;
	 b=ZLzHebiQlihVq+w0WKM0JAHHiWhjW17rzu5j+v4h18JwlMpPwTSWjlJwvzoQOpcnjQQKcW9HpZ
	  FuwJCiaBqb400wgfmddph1DTWjIg5x0AJqR2V2KU2s1OWXo4YNoq5XpJ5pKGpLoX1JNHcbTEwP
	  KJEqqRbKLjKopVhvJDrVdWpJHsIPE7rWuT64OPX3OLVUGaFNri4o9onws2zHXfW4Roxw+iq89E
	  af08x7HuMeR2OrasgwM5qD6zHURscJtx3vidzQBl7uxcrdg44U+Otg2HmcDzJEpE0czmOewxec
	  SjM9zIr8C0yhLe9AbzZ0cRRq4YmqEsOiQfqSkmkBLGbrsA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-ppm8.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-ppm8.prod.antispam.mailspamprotection.com; s=arckey; t=1793086022;
	bh=kKoqQLDluHNjJkFcEbygMkV5J8AlSinTWWymUCWvRyE=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=kv5Q0saWyceyc6PF9EsJcPKa4MEE9Ce3a2sVqvLC6Se/daDDP2zlyAviJtB8ub0YgugtsKhiGp
	  3B4FQF5hlXEQSXua9t/FO90wQtw1ORhW3jxrNjg//9uOw0+KX6tKTKSL6JCHEPLnr0lExCEH6i
	  /63XvAS06dovRgY1293S5yXiTflGymyyBk6F400AXWjoJUhon+gv9LOiMEdUQlnR7hZkVybSPy
	  qrQrWvAqu3Wy3DSK3yi7O2RPzyDjHTbjWzYzlk1vOLXYgaIXXkQfA3MsogpQ9oILZqR/5/J371
	  WF7r5LlcqHGBGUdpgVMhO9lzgxoAbFCfh3Cbvt16fnx1lw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=eB359adIOGVwMJGfc4eVy6ZjoIVNVGA3YSvr7zATIfs=; b=n/WzLfLcFEnDjd++OL8GfgsdJi
	2J5qZeT8xKhlnfbJ3hI2Ob1P4sWGrtUGcgOKa8t6p3bo/d7HUV5QJuMW8f7qi75mafYZcs+Lj9BMe
	WyarBvMTl6rCj8h0Eoz97TuyDTZ+bLp/L9C7wavUXbEJB4hoFMBzhcRGfCHsNKZeSyRs=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-ppm8.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xLba9-00000001QPN-3hsg
	for virtualization@lists.linux.dev;
	Tue, 27 Oct 2026 07:26:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=eB359adIOGVwMJGfc4eVy6ZjoIVNVGA3YSvr7zATIfs=; b=L6Aq6yRizkC5hLpz+mF34kln9n
	90V06ZJ+0nbwoiyoYdJtksk0JJzBFp7dA0MKthGg6OSufrlEvnrOEbjZHQhqTan06PTxKYVRsR2Kn
	brVB/LfI9XcMgfZHIjjyFwBA4ImfG6YK8hh1941qU7o4jVbwmB2Jp+7iK5ls6SI9/Vt0=;
Received: from [87.16.26.129] (port=61474 helo=[192.168.178.158])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xLba5-00000000J9d-3lT6;
	Tue, 27 Oct 2026 07:26:49 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 27 Oct 2026 08:26:34 +0100
Subject: [PATCH v2 2/2] MAINTAINERS: add Francesco as spi-virtio reviewer
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
Message-Id: <20261027-spi-virtio-bindings-v2-2-67927b24b9d4@valla.it>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=613; i=francesco@valla.it;
 h=from:subject:message-id; bh=kKoqQLDluHNjJkFcEbygMkV5J8AlSinTWWymUCWvRyE=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFkPgsy/lE9I8hDqymbesanJPuL62+nzu9ySGwqL2tt2H
 GCqWH2no5SFQYyLQVZMkSVk3Y17e+aaf0vbwPgIZg4rE8gQBi5OAZjI7+sM/xMEeOQO8WR+/aK8
 7em1XvkHh95kTo4N5da3YLK6lpjjn8rIMGXxKc5H4UsftXb3291bzhhZlb7ae3r5lOkxOvWcN7R
 OMAEA
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
X-SGantispam-id: 8c7def93a0740c62b7db232ef6b31e65
X-AntiAbuse: ID - 8c7def93a0740c62b7db232ef6b31e65
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xLba9-00000001QPN-3hsg-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-ppm8.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Add myself as reviewer for spi-virtio, following the introduction of the
devicetree bindings for it.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5724645bf703..45a29ad08096 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29673,6 +29673,7 @@ F:	sound/virtio/*
 
 VIRTIO SPI DRIVER
 M:	Haixu Cui <quic_haixcui@quicinc.com>
+R:	Francesco Valla <francesco@valla.it>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/spi-virtio.yaml

-- 
2.56.0

