Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A088833B6DA
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713094; cv=none; b=EIm1O2yzkbvMTEdM/lNeHIz1YY7xUgDGqALt9hhecY4yUy6S/lNqFgPFSozJTMrAoEO5rDASh7D7diMElp/5HFf8S14W3l1P0+2AIgHkMAvZeDAtJ8ylLaXSKoCs7Jabdz+jqaDZCnLnj+UjWjdYOnF571f+mHMIb+K2zJ+BPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713094; c=relaxed/simple;
	bh=+7tflVaH8x7L3VJvig23+lCVNVSwvcR4NvQ6QZjXrp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m4HU4DQOOipBg4Gt9wyX4Wl7TEoJ+czUegfifJ1Vu1x99rxsKhGsPtm4LlquR4yWXfEKdNNDAr8X1fbVeXn3H1zcU6jl4GuK4hUnOPtb+s3XyhbrS3ju+kr38QEDHdWH5gdM4SApArawcHXO1GF8wQyh6hIaxqdXe9S1CTv6NgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVRCLXZk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVRCLXZk"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so2199378b3a.2
        for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 00:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713089; x=1764317889; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsO4Hd5ROz+D0bqFKvcezOn2Jkcskeai3TxWpcHV0vk=;
        b=eVRCLXZkSwgPPjKI3iy1yR8NQJeSEzSkjRJjLCFG1By7Y6Q0vU6tDNA+jeGvLAlq/I
         rhExDE4kCa/F8dg1GWw3CmDvenmMqk1Sh9FjYHQA93G1n8p7Qo+iZCLtV/9Gkpn9XISF
         oncMH2984k75cw+pBqW7oTObmZ7ijjIfFJbqMXSteNuT0YZ7QWKGbFh3WjUzxI3Aigw2
         yTDatYN2WPeZuKpJFEwFAS2wWy6RZHRaieN5AOYOKtRekg+Vdu9LIipErNooq/gGsr4t
         gLUhvRdYkzo5/c+5gbKB2pIcgAj7dxvdVRYnbYDBncB7qGENS4NHGGjJX4N1f/RI8850
         OBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713089; x=1764317889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HsO4Hd5ROz+D0bqFKvcezOn2Jkcskeai3TxWpcHV0vk=;
        b=PJZOpl+ZGOTRrs44C5gN6kQg9nk9HK6Iq0b/Nb5F5UWs6ldBmCziFuPCpSrfoV1Afi
         n9PBhoGgdv6WBDGwP0aUIm3zModdRcfL0wLInSKAS7Mkl78ScM2BlmNqRKpioNg42+U2
         6Y30OOKg3dfVAqQQ21YdGkTrw0Xa68IHbrjA1mmm+jaGMBHvHI3011gRkz4TpPmD9qTN
         1OFOI/wNJcYwYMYGgvTbGX+KQx/4oxwyMp8A1qkulSP1rwYuyehFCxV0vHiTs7I2b7q9
         o/3GXr2qzWKFCvPclX40+To6FJU6bWeR+hePhmyWHq8/suD6OO/bx6sWP5R+/8geGAPs
         f2tg==
X-Forwarded-Encrypted: i=1; AJvYcCUN+yzlv0wCxblLehWQ5KDFGaHygI+Hv7P5hE1IxWQCbHraoV4qS3ZNzyuK/Etq3nx+/5Sk9PCNBaNOKRSk3A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSXWlv0L8K6MLZSoGtiQ0vcid7Cup3qn28yTs+GpW5c8ezMJkE
	1pT02RD0U4zNgK5H4ICKrvB4wt3Db+2XQLwoDwioyKcYVmcRxdHKHb5S
X-Gm-Gg: ASbGncu/TgkN49+NwbDs5STlIIcbjsrtQel+KsKbQ0B/zhvVsKF5AkG4DKcjdO/83Hs
	FKuVMCGIPHw5lFOAKXlLOk2W/5Qn8imysYz/AsjV2ZLgagr0YkZMhVAe0CkY9Nx/3NBxRnMrKjw
	EVY71mtkB6crqyRJQtk/geo+VjOCLrioDBIqp1+rmyTzyVpFVykpxRfbFz7nX3hqPlzkCNfjsDg
	OpanVnlmbLW01Ad7JmEY6WcqalrFffeWVBB8XBCSVYp6kVN7knFLRWRXCkkAz7s6/FI270ZlDlp
	iKzAGMAF2wJZNfhQn36FMHzdTjpTIqlkD+wR2WzhP9xT7NrFF8eoOki+uTbP8n62fyUjLFui2JN
	6FjSEq7VFgWOh+8VfXntXXPSipXYjkyVq7ONckWXL1l6syD2p1W85Yfw+JWhRj2Ga52/CfsVuAU
	KWNfz/6TH20mS7eqwfZNtrjMFfhg==
X-Google-Smtp-Source: AGHT+IFqeRBYEjCaG+tIpPdWA+qVKSXVzOiqtjGknDBSdNDUFTnY7ogPNjlccPCj95LHEh6lRlusYg==
X-Received: by 2002:a05:7022:6b97:b0:119:e569:fb9b with SMTP id a92af1059eb24-11c9d708d34mr570234c88.10.1763713089300;
        Fri, 21 Nov 2025 00:18:09 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:09 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH 1/9] block: fix data loss and stale date exposure problems during append write
Date: Fri, 21 Nov 2025 16:17:40 +0800
Message-Id: <20251121081748.1443507-2-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c27..55c2c1a0020 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -322,7 +322,7 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 
 static void bio_chain_endio(struct bio *bio)
 {
-	bio_endio(__bio_chain_endio(bio));
+	bio_endio(bio);
 }
 
 /**
-- 
2.34.1

