Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.56.87.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794156127;
	b=mBDYmDnkok5oDjY8xOFtLXgMkujs44v0lDUQWOqS9Ma4Ukbcy7nhiIAVVO43P9tsxV6t
	 YDynyKX3g8VsVBL8pR6kf/mWB4yAhzG8NAbP/1Axw2/6QIDTwnHiqZtCgCGvyly8LD/Wk
	 wA5lWN9qHZlISBBb6H/SXK/3wWlV2bfbR5fKsnDQK0Ug+J/rFx85UHOA0NPBjpdRIzfBF
	 yefgsO7ddyOmOgGhbIDuUdo5cq8xKLCMf5IF1tJCsgPyKUr20FxJhalsS9bMtdcBP5BN7
	 wwzShTTI/ZvQtAWFws2xhUueRBk2w26yax5U1xbp7hVxPTowKp3+xCqXjwZ03uY2WuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794156127;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:
	 X-Source-Dir:X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:
	 AntiSpam-DLSRS:AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID;
	bh=w1Tj2Z9J9o8m8hRTXD11Mow03qvAjz6ecNswvnSZWy0=;
	b=ZyU3OsiatvKo/mZdoQGmLVY9Z9CgzK4x1/LK+7A8jBM4EgrzADtGy8iUr1tqrAgLqCa8
	 1x5n9ikYQSP09JEy8YAtCIlsxydtEgY9VzI1lPHpJA0MSebxEz0jmw7sSOESzBjjp4R2l
	 CDWGbdt0oag5aGjDwSA8TIf4XTKeuJpSRV1teOhQyMmXq/Qikgsxrk/mpHndbiUUbtdgP
	 Gj96/xI5KR8ovX3O6J5ESl/9S4jHNPhnXczuAG3qXtRghjBYlKWX2sqP8IAt5mz8IRWQQ
	 ph4yW0LrEwH42grN/PIs17ExiJRYOHuSdkU3YwmhIks6z6qsHro/xmkTFO8vKkIlaZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=LGpWfZ1g;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=igLB8vWY;
	arc=fail smtp.remote-ip=185.56.87.10
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBC6606A31C
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 16:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DBC6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=LGpWfZ1g;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=igLB8vWY
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com; s=arckey; t=1794156125;
	 b=bybM9Ga7ME9od3Cr6I8lBNOgshLto7oy70cTNZfbDpO7pefMaNMc1DfRYxyqKJXlic0BCMcfiz
	  HA+rwxqb+jZCb74A0NzkCyAfpRhr+LAd1CixWuiHLQHnIF4lbRRkS3QO5EBGqiaLqO6i1HCyyh
	  WqBplTEgWaDDIlaUwhuzZJXUBwPYNyBrzpHlgP6MK3gC0FXm2AXjV8gbIjCUFYyFaP5+tSBNzH
	  p5v4FXjZ8g6wcZYGFsKRY+X4VpeIIpRCJcDeLRPuuZoW3RPvxI7iNeN7zjc5buEWymTAgcDzbi
	  N575lAa1UZBAlBDwGoyh2/qmFPN5xQUp/YnHTFsd+rrVYw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com; s=arckey; t=1794156125;
	bh=K8+bAteAwtybhhFDjzqGVKnebM6Q9hxkFp+VHoMl8LY=;
	h=Cc:To:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:
	  Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=HFc33x+6LGa+mrZfn8sazmR2UdM+DiViO6mZITa4qtK+amnvXH7QBF+40Rh4FWuv2j9wcE/67h
	  GKGIph0SRmVxLym8zHpKHNV4F2nsNCOPObbNThscdj2//s+meP9zU+YeCdi7MLfa7wDPgF4d3B
	  Fo2ROvoelv4AZgPXwsSCZRCHPAbW1MAFP7rrH1CDp+a6sMFNc7ZFJs3vvBQEq52ZjEuCT2PzYc
	  FxJZ79GxhEMNKFpANr2vUyh4uCs8NpvjeqV45L+PJMSs53vXse8PsvhGjHEj2qEhHhdI6so8w3
	  A+ASwKX5o5uUUmHWjlZwK/G7YoHyJDetKnIT5TkvsCRUMA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=w1Tj2Z9J9o8m8hRTXD11Mow03qvAjz6ecNswvnSZWy0=; b=LGpWfZ1gSn0kbk+wI3Ph28bz2O
	7dul1SsKIP3mqpT1g7u3RepCNm4zRdJFYV52qXlm7ThqUwqtXAgxoJSgOxI3KcKqbDMfmJ5tB9Ptk
	42NxntNofvMIOFNdyHs8KPj/s49QoduxoaR0SZ8PXSLsdsIAGLbNIBshsKzWGHAsq4zI=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xQ5xt-00000006KKA-0YqH
	for virtualization@lists.linux.dev;
	Sun, 08 Nov 2026 16:41:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=w1Tj2Z9J9o8m8hRTXD11Mow03qvAjz6ecNswvnSZWy0=; b=igLB8vWYf1YOB70o7UUC+/TzQX
	rIQXNKSVcwI1q2CCUq8DiQLW52vqAgI86W5tlrqP4GTQ3y3HBWwsMCJZP4utGOIF3Uazr2k2xis9N
	1xYWHU5b6zXjSGvFSHILMmVbB9vo+w8n7z4pCPILX7P5r805YzRJSpHYdHyoTaxEC9Mk=;
Received: from [79.17.15.196] (port=59083 helo=[192.168.178.158])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xQ5xk-00000000Aqg-1BMM;
	Sun, 08 Nov 2026 16:41:48 +0000
From: Francesco Valla <francesco@valla.it>
Date: Sun, 08 Nov 2026 17:41:47 +0100
Subject: [PATCH] virtio: check for driver remove callback before calling it
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
Message-Id: <20261108-virtio_drv_remove_fix-v1-1-23da1a7c3900@valla.it>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQqDMBCE4avIPjdgIlXxKlKCmlG3UFM2GgTx7
 qb18RuY/6AAYQRqsoMEkQP7JUE/Mhrmbpmg2CWTyU2pdV6ryLKyt06iFXx8hB15V8++q1FoU7g
 KlL5fQZr/3fZ1O2z9G8P6i9F5Xn7P++B5AAAA
X-Change-ID: 20261108-virtio_drv_remove_fix-5ba8e3123d7e
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417; i=francesco@valla.it;
 h=from:subject:message-id; bh=K8+bAteAwtybhhFDjzqGVKnebM6Q9hxkFp+VHoMl8LY=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFkflnnrv/jz8u28v5s+PvhYNWFPnu2GgIzbVqs1d9o2W
 v5Y32dwpKOUhUGMi0FWTJElZN2Ne3vmmn9L28D4CGYOKxPIEAYuTgG4yEaG/xWXOOOs7dZ8P77W
 Tiqw6en7Izf77av991TICv+W2MD44C3D/4KjN38YWn42m/5lb+Ty66/SV7NMK3n21e948K7H/hU
 TfdkB
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
X-SGantispam-id: 1bb7aa1b19c0193652ec8d238db60cb2
X-AntiAbuse: ID - 1bb7aa1b19c0193652ec8d238db60cb2
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xQ5xt-00000006KKA-0YqH-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

The .remove() callback of a driver is normally not mandatory, and the
increase of devm_ functions availability makes it even less so. For a
virtio_driver it's not marked explicitly as optional, but nothing
enforces its presence, so check for its existence before calling it.

The NULL dereference that led to this fix was seen in the wild for the
spi-virtio driver, which is currently the only in-tree virtio driver
without a remove callback.

Fixes: 74b2553f1d13 ("virtio: fix module/device unloading")
Signed-off-by: Francesco Valla <francesco@valla.it>
---
The behavior of the spi-virtio driver is not conformant to the virtio
framework guidelines, but that will be tackled in a different series.
---
 drivers/virtio/virtio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a8588d7ad109..067d32c67b44 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -374,7 +374,8 @@ static void virtio_dev_remove(struct device *_d)
 
 	virtio_config_core_disable(dev);
 
-	drv->remove(dev);
+	if (drv->remove)
+		drv->remove(dev);
 
 	/* Driver should have reset device. */
 	WARN_ON_ONCE(dev->config->get_status(dev));

---
base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
change-id: 20261108-virtio_drv_remove_fix-5ba8e3123d7e

Best regards,
--  
Francesco Valla <francesco@valla.it>

