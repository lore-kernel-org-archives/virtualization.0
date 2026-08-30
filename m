Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8471C3B6BF5
	for <virtualization@lists.linux.dev>; Sun, 30 Aug 2026 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788099202; cv=pass; b=UZvaSMwZS1CYruYMsKUP27wqSIpUpJQ8LN4mCCARZdZBlyiAN/+tThQKyPI2PEwvM3tKUASV4vmngniWUzv+VewiyHnP7JQz1U2FX3giBu8U3y0mCBFHB+pmiAnkX6oY1eAJFYqesKQbhpPJsOfSN5S37EqSllN8Q2vLIJHsjtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788099202; c=relaxed/simple;
	bh=2kiaebJ+Y29rKyDA9vC1b/injJL9UjUWKm+oKK61hrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Xdpm0oH8TFKKEnG3m7/INybiiwwkK5dAXS+9Gli6sMxGbSzYxu+IiJwkswx32J6K9ermHVH0rGnNvjd9DeiOAQ2ocjWY7IdLWo/pnN3LhBBj7v6eeGfBpGnWz5nI1BXLSZZBa3oQrHWGYCL4r7ywBxdfTjRpOEOTYcpw+ZQUGD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=Y2POXKWX; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=PytnO4U2; arc=pass smtp.client-ip=185.56.87.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="Y2POXKWX";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="PytnO4U2"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-2mqh.prod.antispam.mailspamprotection.com; s=arckey; t=1788099195;
	 b=ndNTCsblDywQbLsKGWdKo2l9hn5aP+2w38nqHs+tJ44r4bM1SQ9QHhnhvhrDocz9dy9Nzlg01O
	  UgFTGgh57yl3UUotU6iFl7Ozg1uWIivtxubOF/z3WqBFAIC1SP9xOMpiqlPRHa7haLBYdeH6dX
	  ZWlwwb+N/SMqk4943FMD5xsH/CSxzLgkVxjLkpumJMp9jp/TXj8pg66VhxLe5JyO0+fNo5gaNx
	  PYcAz54E9I6NvU6u+jS3YTchCQsZTla8dcIr7W6OwWVFNMwgyzPTyqXKf3JX8eeduIqvWG8vtm
	  Rol4QOFttnIYKS5K0GkFtlKJFWYaQoUDMjUqr/BTPAOuBQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-2mqh.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-2mqh.prod.antispam.mailspamprotection.com; s=arckey; t=1788099195;
	bh=2kiaebJ+Y29rKyDA9vC1b/injJL9UjUWKm+oKK61hrE=;
	h=Cc:To:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:
	  Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=rIEBPRLwnbEv+Y8IqhjVRYD7UwTLs/AH/ZmH2dLBbhilkI7Dlixmlt/PJYfixwCXbxcjaA8gj2
	  X7KKgCjaGRUalqjfYc+p3Plf47P3DYbKoLS+m+gj2Ue3v9ifb5Plkr2EYSU/+V3hH5vTFEuetK
	  ULrWpoiczY++a8GBeF2EfOiaSO7CunL1wXKDERAYWWGP6p1NY86cDU46OeuOcIu6rfl5jijB5U
	  AhdH1VZGZyXfp3dqDNNudihEJyrkoQzHwoM1pMGok2EBXG5zB/cl4sUXOW+s56898o7SYRmdU7
	  mJcuD0ZqcUEy0vaqiAmU5dyDeJti+TO2FOxUuNfS34isUA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=DiHD8En7fq2ugx0Pu3ejCIoYiYpClHsgUceUJ/BO04Y=; b=Y2POXKWX1KT0limFPvd1KydW/V
	tv/UBGU3knbot6+5113QsY6k3K7twJ415sW4ooXGRlPcb5Ne6K8atVROoYOf/an1JXQrVzWwzwx8v
	PAd28LBl5wPAA7YNVg2l8kkeFdb/HFHfhH77pMMO9rKI6PcGeIP6g4WSvBFEqEXT2FU4=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-2mqh.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x0fu2-0000000Ciho-0I4O
	for virtualization@lists.linux.dev;
	Sun, 30 Aug 2026 13:48:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=DiHD8En7fq2ugx0Pu3ejCIoYiYpClHsgUceUJ/BO04Y=; b=PytnO4U2/w2IfKUZiuQ3lt/wQa
	ghrfIgmxTn0X9L1uMAtUSR9sjr6Bi2My5wdzotlnL9gEA2iBnzdd3ZRkj/lmtCs3DWfHdqcViiCxg
	umhOdf9MiQduejSg23gE+j+uP6RYFI0AD0U3T/iaRO1/CzkyEGnGrfFs9NCb6qJJ6r9c=;
Received: from [87.5.139.196] (port=60542 helo=[192.168.178.158])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x0fty-00000000Ep8-01NB;
	Sun, 30 Aug 2026 13:48:50 +0000
From: Francesco Valla <francesco@valla.it>
Date: Sun, 30 Aug 2026 15:48:35 +0200
Subject: [PATCH] spi: virtio: drop duplicate completion init
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-virtio-spi-fix-v1-1-62f486f4acdc@valla.it>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAQBCF4VfRXJtauyV5FbnYWYNxgXaQkne3u
 PxOnf8C5SisUGcXRD5EZZkTijyDMPp5YJQuGayxpamcwUPiJgvqKtjLicE7R4UlT5YgndbIaf6
 CTftbd5o4bG8F7vsBK5m7P3IAAAA=
X-Change-ID: 20260830-virtio-spi-fix-ca33b12bab2b
To: Haixu Cui <quic_haixcui@quicinc.com>, Mark Brown <broonie@kernel.org>
Cc: virtualization@lists.linux.dev, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=871; i=francesco@valla.it;
 h=from:subject:message-id; bh=2kiaebJ+Y29rKyDA9vC1b/injJL9UjUWKm+oKK61hrE=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFlTTPZonj6ls3Uy38dn06zYZ7T1rc+5Iv+vzHnnztMv9
 otr/Lt1uKOUhUGMi0FWTJElZN2Ne3vmmn9L28D4CGYOKxPIEAYuTgGYyJxnDD8Z50c+3nUgUIGx
 /OGx2fsNyjk1JDOf6VgGruf6efhJ3AknRoa7pUFLTl9yvaDf83e2z14p5dxvQWIO1c0CLCtyzx5
 8a8wBAA==
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
X-SGantispam-id: 3288561643737089d9b931376bd79c7d
X-AntiAbuse: ID - 3288561643737089d9b931376bd79c7d
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1x0fu2-0000000Ciho-0I4O-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-2mqh.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

The completion iused for SPI transfers is initialized twice in the
same function, without it being used in between. Drop the redundant
initialization.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 drivers/spi/spi-virtio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
index 2256dfec5407..87ce32b6d133 100644
--- a/drivers/spi/spi-virtio.c
+++ b/drivers/spi/spi-virtio.c
@@ -162,8 +162,6 @@ static int virtio_spi_transfer_one(struct spi_controller *ctrl,
 	if (!spi_req)
 		return -ENOMEM;
 
-	init_completion(&spi_req->completion);
-
 	th = &spi_req->transfer_head;
 
 	/* Fill struct spi_transfer_head */

---
base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
change-id: 20260830-virtio-spi-fix-ca33b12bab2b

Best regards,
--  
Francesco Valla <francesco@valla.it>

