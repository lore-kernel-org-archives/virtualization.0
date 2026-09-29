Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6132F3D9025
	for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790700184; cv=pass; b=MH4GC9R/JZRNj8N3AJprgvEPogg+XpxrfMsImU2GGqQ9F1T9+sygFuuDA11CvwnBR6DcTWi330zWe9tluJcowE6au8ULLqCINo1GFhD9qFwoA2ih4QifD+ZdPekEA+NxgNfH67HaDmmwUJGl9eEcJtGG91IltSoht4OSr3F9DWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790700184; c=relaxed/simple;
	bh=KHXHFsSo9+fBYmQYu9qSDHjgM9semQS+PzLf/NCjDeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hnFvpTpAm9uDPnZ/dw3Cz84Xx5Gy8tP93TfaqJ9Co0SNvAGRUjw6JSNjFozsZc18RDYhUnVEZ1kViIBRDoELAim7ckC347giZt9bojpcfAk5CyEDhl+pW4A93GPic6GvMI09QgDKWAqjh57uR67fOSPjwP+gk8dHUwY0T17tCkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=VALgy3cE; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=WsH+tNti; arc=pass smtp.client-ip=185.56.87.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="VALgy3cE";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="WsH+tNti"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-mnhb.prod.antispam.mailspamprotection.com; s=arckey; t=1790700182;
	 b=hI3GGuWSFxKvdCW6jJ2cqy9NIkLRM/6HOLFE9VRuw8w5mD7d4lUcE1uLl+P9ykVD2egGC9x9nC
	  pBNtYFTFXP03R38mnnIrkqTpOYcEGU6LZNsU0S53xl92t6YbqESbwdVRRz5sCmHp3a9+CUjxr2
	  DMfHM1fxJCnyGfSFIZKsBWXI9YBPNzoTht9+2hrdFJSqXDOIICYk2tjbS9esXUE5OyLlCMuLjP
	  GrK2Qh2mN7qDcatoJ8BdAvOGU9x1OMbXTBYfZrJhy8VGF1QS+0oSXIlzuUSGn4/VIwT3fKmvri
	  7yLKOCmF2FFh28TJvvBWJeR2zyK1zB1CucypzlcsYfxEfw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-mnhb.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-mnhb.prod.antispam.mailspamprotection.com; s=arckey; t=1790700182;
	bh=KHXHFsSo9+fBYmQYu9qSDHjgM9semQS+PzLf/NCjDeA=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=Caf3pdeiaRtJtApZXgIt3pT9KthbaHKUmEeEwuprJdOtAjH2WtFE5UgPgQI/Q5prnSgWNWUcKa
	  z6afm76zLPvy+tL8gmH1wGRyaOCyU1o8FmPuGDPD6zPM/B57X5CumK1X22emYd40Rl2Yd+N/JC
	  N0KhFMRBeGxULMj9yOY0of9YOIFp9Mp02Cg0N38MqvrNNYb0ZYmmUsNkX5TxPGGUUj+yfWL7t6
	  OUDR0FlA7rxQfq4fcBi3vwS/XRUAxng6yHWtk/5UjWfPPWmPrhguxCgD8RWWqMA6GvK0poJ4Yw
	  6k8dwitlzq7q3a2txEHkHwZhi0F4C4VGNq6fAWxk0qLs9w==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=OqVG4Putd/h8cvO7RMuJK3aCSwZhVie8fm2yjbsDtQ8=; b=VALgy3cEqyjmfLQgKC9mm/zuv9
	iImKR75MkcfQUP1bJu4ZeZNDYdfXxkJqayKpR+d6aUKzXAQfmEBtz/dsfq5Z27W3jPT32G+GKvwdi
	v1zKQHU+AaaH/k3BmK6nAJOO0bBUl0sGlpj1waVF2KFjCGgjSPYu9HM/dbz1qRrImAl4=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-mnhb.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBauw-0000000486z-4A8z
	for virtualization@lists.linux.dev;
	Tue, 29 Sep 2026 16:42:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=OqVG4Putd/h8cvO7RMuJK3aCSwZhVie8fm2yjbsDtQ8=; b=WsH+tNtiVB94RP2yhRT96NGkgG
	acBqAr3MHWCIoaVMvFYXRsas0EU5jtMy9TywqOFOoAADe85AX0cDj2nmAiPEBFw44l77YsI9xMdNO
	V2fKkDGTmeLXVHQyVKDsLQy7KaMpC36psDt+RglUUJkQhxnkuGmzFDyV+e5KRlYGOf9Y=;
Received: from [87.14.44.235] (port=61710 helo=[192.168.178.175])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBaue-0000000058o-12Ne;
	Tue, 29 Sep 2026 16:42:40 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 29 Sep 2026 18:41:56 +0200
Subject: [PATCH 2/2] MAINTAINERS: add Francesco as spi-virtio reviewer
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-spi-virtio-bindings-v1-2-6a0eef3213b3@valla.it>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=613; i=francesco@valla.it;
 h=from:subject:message-id; bh=KHXHFsSo9+fBYmQYu9qSDHjgM9semQS+PzLf/NCjDeA=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFm7X1UHLZD5tMT6fOaeb7zfYmfeWj53W0tKSc/di6t09
 x5S+M/6rqOUhUGMi0FWTJElZN2Ne3vmmn9L28D4CGYOKxPIEAYuTgGYSMoXRoYb9z5m/c6au1Dj
 hqNeQk6zstmhetNNC3dUMS1VMV14I/s3I8Mpz4dLCtSyFI50br65NeNql2HOmYvqEVIzZk21MM6
 4ZsALAA==
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
X-SGantispam-id: 8d715258d192761359126a1a6015c4ff
X-AntiAbuse: ID - 8d715258d192761359126a1a6015c4ff
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xBauw-0000000486z-4A8z-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-mnhb.prod.antispam.mailspamprotection.com;
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
index f91340fc6e7f..ff70479e99c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29060,6 +29060,7 @@ F:	sound/virtio/*
 
 VIRTIO SPI DRIVER
 M:	Haixu Cui <quic_haixcui@quicinc.com>
+R:	Francesco Valla <francesco@valla.it>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/spi-virtio.yaml

-- 
2.55.0

