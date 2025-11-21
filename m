Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A41633F394
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713111; cv=none; b=SseXm8oNjssId/l/f/rfzpqWCMl2ykQIs9Y0YeaQgU90lrMyCOzvTfNIGg8vqLhb2A876j9pIfEk8BrShq2YlXz494P8l+3wluklXoZT6mrsHjt9XDu8bEHR/kVdXzfm2AVeZXJcFwyp56o9HiNaVPhPvKIypmya8uoX+iuz+bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713111; c=relaxed/simple;
	bh=9fX1h1fO3q+pLGnSgKJ0rzYXjH5JwLqWD06FUxR/tqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NEA3viLhTjs7Hag3BkeZx/UvBDaK4DHiTOWp4LNuRa59c2i6kWMbQNJ+S5pBywDcMs/Nefe97z6KIwFpiCr6xekb39+qMGBdD0D9WGIItRA92kWe3QLfz2stIuRjzApg8X+2sv123Zh6Co6GNA7u8uWHMMcURsmv72LuiQebmzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMVRxlgx; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMVRxlgx"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-11b6bc976d6so2581408c88.0
        for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 00:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713108; x=1764317908; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teKvOHrBXVsyNlkTSBs+xMQTFkH6mnVNybU85CGmBRM=;
        b=GMVRxlgxUKkxmXrH8OK4KajPk6P2S1PiunQl9efrhxecpOcy5ShTn4IAogq9pARwtD
         UUTWSh0q5Y3jdVSzeEdmLKGLLlW0TjpscHFS0Q1S6JTXoIr6AolNu+guQUTbw6x5WX4T
         g4xXmXk+9vjBOEU3/pyPQpzXpaeDOz+kQjSX/lMZgKfZMgbw81zlfWIXnreOAEcaLZ81
         00AalZAqjL+NRVf+gLq0CUbKhEOEjZp+I5IyyNukiR5q1pU8g44uaJR5Jhe5On1ep9/F
         7ONqGVl1p1TGkJvSxn4GJp2Hjo2RjjG+ds51tUXzIcmUHJ7sQbHTT2Sfx7fTlEl1/KLk
         hf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713108; x=1764317908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=teKvOHrBXVsyNlkTSBs+xMQTFkH6mnVNybU85CGmBRM=;
        b=Smw8Npmw4ovD50cPzBq1oeTzJ+6Wv79HlRI8g5suQ8RjYTLlmlLY5ETs15hosi0WVI
         YZZPl7VC+19kUuRD8htHu6F3h+NYNMpID/6kG+f0nsfN014oloFQKBIHA4FnuHSviLGh
         SAxVQiT1oQrqltT7asf6W7MbCMvTRhrvkacjmF3HzaaA7GlfdVrnC6w4PL74pYXCdpRr
         7+VoZSRiU0MTEm2ZzcaDHEei7KCbh8jl9sXXrxEPvGTeFWurQWMVXOqXgLWXB/JNW7Mu
         jk7Fmx9uGblYUK5E/unhdzQDmi4xRdE6aCvxmJ0eJ4YHDRQcsAqCWR+pq9SzxLrNg2w/
         v4FA==
X-Forwarded-Encrypted: i=1; AJvYcCWNlB+L5BcizN8B2zMC/QnauPBuWJCy4O7oUo8c4lVyfDkNtY1voPw+dgXXNV8IpEp6hcHPhNdi2g1XNT8laQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyk4aRt0i4IgqW4Nx01osTN+Tv/XJ5WeccnBcfodjXtrzGwkPz8
	dqfaWlokmHObgEcWpORIzWLmgSGQ3bRcebfXqVcm1JExbO/zSJT/8VFm
X-Gm-Gg: ASbGncvWgqd55l3BCQ+CGBUx6lkwX54m22xZlOhcrKpDqnX0i7o1Xmpnc8OOfYF/MAn
	Kydfncs8KJOkxoY5hL6JIpzBbLShKOYxG/6rRusQxegclqVlGTr4ShtqwRAeE8zpc9xNIiUaktG
	kOlr5x1mDFRBbFbIGVGaI9WcMvlDr8Qz6G7Z/ll4o81966+Wk+PXSaTfjpALyeUXgX7dcO8o+QB
	XW1BzBsj2qRj57IjkVxquwvRdZJLtpTRzTbPlNV7/YSqDJaJyUQN2tS+FajxJpiTfzcKUXFqjsy
	o8O8D4Du0Tp6n19Z6+xURjpQocNtsBBUTeJH8ByLHgG9Hi+gh7pPz6B4WII3GRKNPKtX25eSEg1
	ZbV50ylct0tL7pmxr8L6EEIMTycxa5QeMekndvSkzcaqp6f97iBJPUxMHMIg2lKjl1loin8/QNP
	RflkvWAEFYUgn4oSDsMDTWeoUikw==
X-Google-Smtp-Source: AGHT+IFrMbMVzab5Rj4WbT0evERr8uBJOd6ao5iaP3Dv1k5XAo7Ky5wuHi6tXAqFVzNQo5RQ6s2gYA==
X-Received: by 2002:a05:7022:fb0b:b0:119:e569:f85d with SMTP id a92af1059eb24-11c94b90cb3mr1713151c88.20.1763713107996;
        Fri, 21 Nov 2025 00:18:27 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:27 -0800 (PST)
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
Subject: [PATCH 7/9] zram: use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:46 +0800
Message-Id: <20251121081748.1443507-8-zhangshida@kylinos.cn>
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
 drivers/block/zram/zram_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a4307465753..084de60ebaf 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -730,8 +730,7 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 	bio = bio_alloc(zram->bdev, 1, parent->bi_opf, GFP_NOIO);
 	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
 	__bio_add_page(bio, page, PAGE_SIZE, 0);
-	bio_chain(bio, parent);
-	submit_bio(bio);
+	bio_chain_and_submit(bio, parent);
 }
 
 static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
-- 
2.34.1

