Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822198;
	b=ojz03jh3cRdaksT6F6RCNFhqWKv1BY30NHjdYUUhLblXNhycn9/fV0MDg2GFt0uINdMf
	 8fZDlopXvFMI4OP1c5Wyv7uuLMuzn5cUYVIbsQUqnP/rqvjcCZYoihl4Jw9ZZpRT92h+/
	 RBVbzo1We33e/JYIrtLZfWihoH+aK4TSRiZVdrd42RW5A1wPURcdwlGsRQo4ksyV5tC5i
	 L/9lq2xLvV3wY/WSOtgy1PSE8MoL31YjXis4GxOBa1RbXCQDvnaMIZYjVgXJC419n0tvZ
	 wJBHlLBx9nUPrGmECMNULuQ+DOs1HAgaldXWSvpT0Q/CGg55G175axtx6yu93Cx2a8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zR7X7uE7v/00IVsZHFoE++N3oXIHliCA4DwI/o747n8=;
	b=KyViurQHC3nJ3qiH/uzcvlK+IKc0/lPV7wsrvA+AnFmsdH+H/eovj7F17vYwFymfiCsf
	 NY4voV3u65Tw3w0aSB2B1z7+XlPaHDj+u1tDw/7XeNG+J2i6QcEibOK0TW5EdR1YWSUQI
	 2e77z381qRN7JjNiD1k6Fcs2juBcG6kCQdwc8s0I5o3E8yeOFKXZaFlco13UDtQmdkqYV
	 2o2FtdQ21XFG5p6LRr76UcVP0M6AnfTeKrpnmIdOgq40CtbxQ2/bZigrfEQUmv683NOwT
	 85I472AuzMYb6VyUj+ITVr9aN3AqRjyhz4AXLzwKHBr/eIYa7POqqtFaKdjA7lavESQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=mUu3J0Ya;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69703606EE9B
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 19:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69703606EE9B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=mUu3J0Ya
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3550c917fd3so1627463eec.0
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 11:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1793822196; x=1794426996; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zR7X7uE7v/00IVsZHFoE++N3oXIHliCA4DwI/o747n8=;
        b=mUu3J0YawD8BebrPAdWRL3ufm1bWYxltvI89TxuuN4+GWyig5ZNhfvwoE0UuY1uJJw
         RGEp7g69E+xKUq9m4cnt6jVOeZdcn4mnMy/7F5Pbi2nKre5VmKFVqUNE8LN6q3YDzj+B
         YMjmt7IDGqQzJHynIHlBs17egiIzPdHk0OVPg8Vtl/ueZO37h2CEp+4MRd4A8IKj0ujT
         L/z+4vs4Ufa08lkuU3Hk8YFuiSlVfDc0fLapcz9DJacB7hWLqWIpV9wO+QeUfjpmo4im
         KnTeWykeJb55oztDJm61Y+VkHO7ULYjP2cacAkliSQ1xxL96s3ApbThhWlXiWhn883ec
         M5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822196; x=1794426996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zR7X7uE7v/00IVsZHFoE++N3oXIHliCA4DwI/o747n8=;
        b=F5eT7OLeepvLtHhY1TqR3aeqITvpE4tKQHIR5pU3OrVluT0zN714VuOoETx2Rz4PER
         7LC3s91p+5DgmZklZTl41TuQMsvJfVJuqyk1kTio22f1WjtV+xwXkKhThZ2LaLmSri1f
         Gnv3Xl79YTQz4EMgPLBiVrR3jJmBol3NntCo/b24zSvFAMJtBGf1cwGLYDw2jasTRwto
         /zAHT5wGv8YZkwpilQMn+925vx1vcHu3nMRKfsyAgxq1BDaT1sdv72+Zm3R3tBXuQEao
         KeYO5/ItuB0+ux81WA5eyPIGu3l/1xouky+8oG0oUztou0l36lirWpOZ29hho6A4GOD6
         bHfw==
X-Forwarded-Encrypted: i=1; AKwUvBwg3xamoc4lU1b1IDf3ScYTJdOC/yjGPeAABkLtzqkHgUDChFDN7FOMPbRbmHXltJecMccSUpup1CNrRDLvKA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+zofTLNPWhcEjWrtVYjBYysb5oEmrxO7pIGAhdey5RybRYjZNo
	VSDnrcWy0hZlMpxsahsh76Cx1VF9YFiUKQUsZ9TCqpVDTKIqACyR4XU9uN075jXfFg==
X-Gm-Gg: AYBFou3ALswCmAMNNPgCxnyZfqRXzHACNspwlVEu1LHfYeelEGmEdT8cBFqEQgqj2rI
	kHlSDyTi1BbbdAb3CHKq1rcI0blavchaFY5l4da8RQVzvs20WorBfdd0Mwu91meoRNQ6HWAov0k
	AwXUX3F9Ti4ICTXUzxkXZJOlwAM6VqgkJxcNnbyeYAIyxHKDb7VZiUETZGL/BxAXH+H6B1s4J+b
	TkwSOHAxyEKz7vmRL1EqLjtWGfSCN+mUpcqCY9enKkA/u0OO/LyCKu4I9Vzd7J02Y0llRgg1cI6
	fBGmYnURbU3rYumhXJBmmfEFjZoC0UWOYPTMmTrx3wp9c7YEh/5cVJWiTaqGom0Y2OiPWUa3Rc+
	4HczGRzPUBNOMtE5G4qtUt7NVdchz1qpT8wdP9IG3qvGY3+sp2DWo1eUP0pKBabydC0jBW09b3f
	4cu5gG4kvyhyOZy5j2jaKGUkBv0n7lSujPWAuLCOl/DA7lA+Q+6WO4KzdddOaWn1RKzkQiK7iUa
	j9I/XMza+QldZCIkmoZES8tQiNgV0IYKVIVmgEgH0SKg+0WJJo53uthYw+o+xBnhrPppg+m77Bn
	AyTMYOGivW0fXhzZcTr2+gGeG7qiRpX5Xy6aaA==
X-Received: by 2002:a05:7301:152e:b0:366:83dd:4713 with SMTP id 5a478bee46e88-36a4249ba39mr22383337eec.30.1793822196328;
        Wed, 04 Nov 2026 11:56:36 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38f53a6sm8941712eec.15.2026.11.04.11.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:56:35 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: "Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] gpio: virtio: bound the line names block by its configured size
Date: Thu,  5 Nov 2026 04:56:31 +0900
Message-ID: <20261104195632.1702765-1-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_gpio_get_names() walks the line names that the device returns in
a block of gpio_names_size bytes, which the driver ends with a NUL, and
checks each name only after stepping past it. If the block holds fewer
than ngpio names, the walk reaches the end of the block after the last
name, and the next iteration starts strlen() at the byte after the
allocation. With a block that holds one name for four lines, KASAN
reports:

  BUG: KASAN: slab-out-of-bounds in strlen+0x57/0x70
  Read of size 1 at addr ffff8880026687c0 by task swapper/0/1
  Call Trace:
   strlen+0x57/0x70
   virtio_gpio_probe+0xcb4/0xfc0
   virtio_dev_probe+0xa7a/0xc50
  Allocated by task 1:
   devm_kmalloc+0x6e/0x280
   virtio_gpio_probe+0xc06/0xfc0
  The buggy address is located 0 bytes to the right of
   allocated 64-byte region [ffff888002668780, ffff8880026687c0)

Check that a name starts inside the block before reading it.

This patch is assisted by Claude Opus 5.5.

Fixes: 3a29355a22c0 ("gpio: Add virtio-gpio driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
 drivers/gpio/gpio-virtio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index ed6e0e90fa8aa..32326d91f33d6 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -520,13 +520,13 @@ static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio,
 	gpio_names[gpio_names_size - 1] = '\0';
 
 	for (i = 0, str = gpio_names; i < ngpio; i++) {
-		names[i] = str;
-		str += strlen(str) + 1; /* zero-length strings are allowed */
-
-		if (str > gpio_names + gpio_names_size) {
+		if (str >= gpio_names + gpio_names_size) {
 			dev_err(dev, "gpio_names block is too short (%d)\n", i);
 			return NULL;
 		}
+
+		names[i] = str;
+		str += strlen(str) + 1; /* zero-length strings are allowed */
 	}
 
 	return names;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

