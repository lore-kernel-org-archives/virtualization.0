Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3307635295C
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503902; cv=pass; b=VmIEruXvbdyOE3kmOYbbC5Vep2NwbG1mXB2nYdz0YMIiACNuVExkGDWXeb+roxxMoDd9hsO4vy/FSeedOaD4j+gyC32WiMeItR4fLomgwf7U7aAu2O3HbYHegCVC7AY3bUg/XF5Ta6+OVkUD/mmytFR+x72yn6AuHaZvxQX83Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503902; c=relaxed/simple;
	bh=/gTHqcQaCpZHlArmpH9FpeT++7PaaL375Ym+hLAGZOs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZpV1DaMeBuIeN5Pp5lQah5o1cdg+/NXbdC1tn30LnO4p5MIvlEFylXvQdDtxoYo8/IGRUkr/QAP61Kz/4hGiGuzY+pnIk4NF9zGKOeyrNmCkQkAMZmVcKyRhikJNHG4Q3BxBxDFjoOlYq04CWIPcbNKHKJf/XkUt5Sxm6BuKoPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=dbB6bmhw; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=Mctx5oz7; arc=pass smtp.client-ip=185.56.87.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="dbB6bmhw";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="Mctx5oz7"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-xhtg.prod.antispam.mailspamprotection.com; s=arckey; t=1789503899;
	 b=IsiAa8UDzp6yIKtu5GV1JbrNpbu8xH723osGTKGDqkQVLOQksNwK4QvCOM7zq/n98qrPp4SWPQ
	  rGjQWT+S5+5J9a3490qqUM8qCi01RZf/YciTAaBJByfX3yoP8YbSJf3GsmtdcPyqH8EEN86ebK
	  rnKEDkJabsVvYtsTcV+1tI3vVYmqFrWtAVCKiEuLaQUBYUEekpMSJP4pGSWGiC6m385WvZIo6m
	  zKoF4Oq0CMojKazZUgWFf/FigxpKrbQS2SvD6oy/tW0ACLs6UxHrKN5ZDqqz3/cCCCFuAooRVY
	  3/C8uQopZky2qwj5JiQuZEJapHXQwkf9yhU4I/s+o9c7fw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-xhtg.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-xhtg.prod.antispam.mailspamprotection.com; s=arckey; t=1789503899;
	bh=/gTHqcQaCpZHlArmpH9FpeT++7PaaL375Ym+hLAGZOs=;
	h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
	  Subject:From:DKIM-Signature:DKIM-Signature;
	b=r94o/8uqfDKie2zv8qBO4785FQFCdeygyTdFteTfuTlxL8nG2j4LpLfidyJkPfqrTwetUqNR28
	  apilHqgzhOPkjkPTcG1v46E1pS3zjkwtYQG9arUe70VP9wVvO1Mng6WdnZmB0D1MjG0LOXnOjZ
	  tFJa7NP8JGttD8OEAw9VVu17p3Q7M+Zb9Fxi0yXKSj2yC7OYbk50t1iR9XtR2wc24czBVVbGBx
	  vawZR3EnWrlItFmQsnRNgITQa6g7hGpzcZeR+eb7thjsV5wQ9bLB1DCpv+m0ctkOkLPwesufSe
	  LpqmDDURBnbTLK00OcJKjLaws3AZOELkQNOIknvTHxTbLQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
	Subject:From:Reply-To:List-Unsubscribe;
	bh=0H1Zt4rRwH8/Itmi8SgfMZVzgpmWywqJ6/D/I7hQCQk=; b=dbB6bmhwpsrXtZ3SWNYrFWpdaq
	apdfi5UmWS1rpl8/9EiWGbf+zHjpWRc8y6s+1zFxGOzjS9y6eyjA7SsVHyCQ/GdfiRGMjz8GXvxx6
	FFc8bKYJTo6sYG9wHKWrGX4eak3vCu5IAjMGG3fiYkm3fQl77QRPlw+pMQYJN3kRPrTI=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-xhtg.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x6Zhw-00000000zy5-3G2m
	for virtualization@lists.linux.dev;
	Tue, 15 Sep 2026 20:24:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Date:Subject:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=0H1Zt4rRwH8/Itmi8SgfMZVzgpmWywqJ6/D/I7hQCQk=; b=Mctx5oz7Qm8K0GkjHKyeMWCLI/
	sn0lmS3ppopbY+Sed5j/+OSkEQMD/UsuTnc1aaetD+EtUkso90+IQ38XlA8DfaGpb/5ymesijh9gW
	zkyvS0cT1GDU3FEEjpIwqsvZRR78C9mGNdqHmInshTkdOOkdDIXSP0v1PgCj7pbyW3S4=;
Received: from [95.233.221.121] (port=64541 helo=[192.168.178.175])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x6Zhs-00000000HDi-0bgk;
	Tue, 15 Sep 2026 20:24:44 +0000
From: Francesco Valla <francesco@valla.it>
Subject: [PATCH 0/2] spi: virtio: fix max frequency setting plus minor
 cleanup
Date: Tue, 15 Sep 2026 22:24:35 +0200
Message-Id: <20260915-virtio-spi-fix2-v1-0-7a474cb1b13b@valla.it>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrE1SFQ2uIha0g7FAOjQScXfF8
 nvJ+y8Q8kwCdXKBp8DC6xKRpQnYqVtGQnbRoJU2qsoKDOx3XlE2xoFPjeTKXHfKKlMRxNfmKe5
 fsWl/y9HPZPc3A/f9AIykIk1zAAAA
X-Change-ID: 20260915-virtio-spi-fix2-ed832a0c069e
To: Haixu Cui <quic_haixcui@quicinc.com>, Mark Brown <broonie@kernel.org>
Cc: virtualization@lists.linux.dev, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1075; i=francesco@valla.it;
 h=from:subject:message-id; bh=/gTHqcQaCpZHlArmpH9FpeT++7PaaL375Ym+hLAGZOs=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFkrV7bGThG9rmnzfu3/QzYn5705Fu/yJCHB+I9cynvPT
 wcv5Qe/6yhlYRDjYpAVU2QJWXfj3p655t/SNjA+gpnDygQyhIGLUwAmYiXH8D/xR90dNqbsgAWv
 X7cy7To4SW9a1r09yYv9GzMu/eA2uXiS4Q93eXGWvL5xOef944dbf023L6kQ+FrHEb5I8NCH788
 k3bkA
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
X-SGantispam-id: 57717de1a6d6b2aacf82a6b14b959e1b
X-AntiAbuse: ID - 57717de1a6d6b2aacf82a6b14b959e1b
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1x6Zhw-00000000zy5-3G2m-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-xhtg.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hello,

while developing a virtio-spi device, I noticed that the spi-virtio
driver in not honoring the indication on the maximum transfer frequency
supported by the device that this one indicates using the config space.
Patch 1 contains a fix for that.

While at it, I did a minor cleanup inside the function parsing the
config space, where a value was stored into the driver's private data
without a further usage, wasting (a very tiny amount of) memory.

This was tested against a (still unreleased) virtio device running on
a Cortex-M33, with remoteproc as virtio transport.

Regards,
Francesco

Signed-off-by: Francesco Valla <francesco@valla.it>
---
Francesco Valla (2):
      spi: virtio: fix max frequency setting
      spi: virtio: drop unused field from private data

 drivers/spi/spi-virtio.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)
---
base-commit: 9b87fdc9af2fbfcdb5c24a64139685ef80f6573f
change-id: 20260915-virtio-spi-fix2-ed832a0c069e

Best regards,
--  
Francesco Valla <francesco@valla.it>

