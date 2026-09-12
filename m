Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F131E823
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240857; cv=none; b=u28OpO7q4ZByfYjW7QS1I13wWJ8Zg45MBG6e/d3SL9s3a/Tefszqe9HptJz+haWHzJF32A51ghcDUP0oreXiBNqoDXpB9czSud5plu0KXOHlH5RLUgnMt1li6KU8PL66KJ7XSd1eUKWV1MIplgB0xVJFWz9exZsdz07LWKmZ/zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240857; c=relaxed/simple;
	bh=8UedceBHV1ReG7aNmhHRoGHArSjtWlHmGMhHS9YGRsY=;
	h=Message-ID:Date:To:Cc:MIME-Version:Content-Type:From:Subject; b=t3HZIHU5uUkuRrTTX4ZyNkOvwdkq2hIeq1p2qef11qs2Wgqls7TtOc9brEtKITeUbqpDYZWCXh4slkW84iC44tWtnZQnn1KLo/tGhNgcKITnp1eytkNimly5Pp2szXHz6dgZVYdyGeoCJKweMZA4wKMqMa7Wg2ea39h130chXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyAwE8j2; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyAwE8j2"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8692a856865so1155088b3a.2
        for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 12:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789240855; x=1789845655; darn=lists.linux.dev;
        h=subject:from:content-transfer-encoding:content-type:mime-version:cc
         :to:date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OX3Pozv54J9l6Nkqxs8/upeHX+6WfThlkm/5RFYWGow=;
        b=HyAwE8j2qJEzDgzuQ90I/3Ox6rRQ5K9GTFADZeGz/FLiAdWzSI3tBMqiA+3/lGWiYz
         0iEiU1YZ1pc2oGUEDyA3NlZGBx/oPDvEIgKXgi5JyhuyoOsWuU/ZPcjez3l+s54QRUbo
         fnzXLB9HLih+ezI5gwjDjdNb+ch5OH4yAKtQ8lCgyozmFfXonqK8ygfAE1eGTQifP1aJ
         jqNezUD0GJ3cMckk+rf9qkEVZLfOfzO5tqzUEJIVuKm/cW8hqTDagSiWYZ0SZS/ZF63T
         XKQjeH1d5XE3gHkKROjEIn5xX6TgUWaChptx3wpLIBwrjNT9xh+GZGpaJ229hJfV3koi
         c9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789240855; x=1789845655;
        h=subject:from:content-transfer-encoding:content-type:mime-version:cc
         :to:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OX3Pozv54J9l6Nkqxs8/upeHX+6WfThlkm/5RFYWGow=;
        b=dUwRIuvPWuDjoS2eeeG3SWkRKfxvm3gx2VaAYd5hGfSe4ePTBW1+2h+IVl4tGXqQ6p
         hk7XmhR2mw7bwAbi6HYR8Fvrndi6GmRND/MFxJAKT29svTeX0VAhGZ4RDo77obKwvPho
         2R4A9d8OfghilckD5r2GuM6LjDmcxaw3RaT8wDdB/TjP+vbJh5LKOiWeUE4LAWA3MeSL
         9N9rIqmVG2nNGN2HryQofTfhukaZQGr5aJDwldQxtHDg2nE4pHOmsSBpsbEDsIiiJw+/
         LIDPllRBHpFeKvs2tZ7uy0j7y1+fqJ3EtU8D2tvp6KfactxjG9dQ0xisBdPDJScz4l18
         Z4Ig==
X-Gm-Message-State: AFuF++nhdP4fGDYg+RxXTSAjR0MD/4XbRykQG5qHsbwG9WvkQ8RGLGUM
	HOuEabf1ybghNlYelWAc3Iyv59CMYOmaQAym33i2zeJ+8Lycn3vdPRL+
X-Gm-Gg: AYBFou0UZIt0+gRPDDi8t3YRWVZ7igNBvlGVDbfCc1KxVL37Try3eH07tji0ynKdOil
	97NFvqDjhKjBU+O/xSieY9XOJEG4gHt2+V7cPUZDZMq4aWcFWsD0+gPfjkNGmQtR4BGLmfcl23V
	67QljEobBZmBdVcTqZw8r4rSH+/dj8nFdT/c9YDsGyQaxVRibFLx9ZEXZbBeKAQEoPGw7alXKHx
	M5WmoIfbWhcKNZuVwHBwDg1TUsLkalqzAhQ9JEE7dhGoXmz6Q36/hG7Iuzg9L9aHkv4KWgnQ14f
	3z+tvxwXuwiiXamcJY+zMhmo3PLyp51UwkfumEfvVWwxVGUPVse3EKuK2oafB9d//0qFVN7G/lM
	SZTZDK3egmRRdH0Ta0eOSF53HCRDpd0jIw7RQsQFFCax9adp1yORIVO4aZ2DINceG8DXRfx7OUT
	NUxHWv5CeWpCHKorpwBd9BjzF3isV4YMzaKr8Y6IMpOQ/zpOB5YL4K0w0lp2iweWsbKD09nGctH
	p2YGJE1+BLKuM1+kSDxcVOeytQ9Rah+kpguCLVQ
X-Received: by 2002:a05:6a21:7a96:b0:3d0:f57d:c87a with SMTP id adf61e73a8af0-3daecaa8db1mr20707602637.0.1789240854916;
        Sat, 12 Sep 2026 12:20:54 -0700 (PDT)
Received: from spi_send.eml (61-227-63-170.dynamic-ip.hinet.net. [61.227.63.170])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c652ab29sm2693923a12.8.2026.09.12.12.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 12:20:54 -0700 (PDT)
Message-ID: <20260913032049.11209.alvinhuang0603@gmail.com>
Date: Sun, 13 Sep 2026 03:20:49 +0800
To: Haixu Cui <quic_haixcui@quicinc.com>, Mark Brown <broonie@kernel.org>
Cc: virtualization@lists.linux.dev, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Hao-Qun Huang <alvinhuang0603@gmail.com>
Subject: [PATCH] spi: virtio: Use the per-transfer bits per word

virtio_spi_transfer_one() puts spi->bits_per_word into the request
header, so a transfer that sets its own word size reaches the backend
with the device default instead. The SPI core has already copied that
default into xfer->bits_per_word when the transfer leaves it at zero,
the same way it does for xfer->speed_hz, which this function already
uses.

Per-transfer word sizes are ordinary SPI usage. mipi_dbi, for one, sends
a 9-bit command and reads the reply as 8-bit data in the same message.
With a 16-bit device default, a one-byte transfer asking for 8 bits goes
out as a partial 16-bit word, which the backend may reject.

Fixes: f98cabe3f6cf ("SPI: Add virtio SPI driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hao-Qun Huang <alvinhuang0603@gmail.com>
---
Reproduced with a local KUnit test, not part of this patch, that runs
spi_sync() through this driver and the real split virtqueue against a
software backend reading the request headers: 9 of 13 cases fail
without the change, all 13 pass with it. Not tested against a real
virtio-spi device or backend, so the framing on the wire was not
observed.

 drivers/spi/spi-virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
index 2256dfec5407..3e181bd8bc94 100644
--- a/drivers/spi/spi-virtio.c
+++ b/drivers/spi/spi-virtio.c
@@ -168,7 +168,7 @@ static int virtio_spi_transfer_one(struct spi_controller *ctrl,
 
 	/* Fill struct spi_transfer_head */
 	th->chip_select_id = spi_get_chipselect(spi, 0);
-	th->bits_per_word = spi->bits_per_word;
+	th->bits_per_word = xfer->bits_per_word;
 	th->cs_change = xfer->cs_change;
 	th->tx_nbits = xfer->tx_nbits;
 	th->rx_nbits = xfer->rx_nbits;

base-commit: cba2348ab114391f5b1a00fa65c5b739f13f0563
-- 
2.43.0

