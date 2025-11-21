Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4133BBAF
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713098; cv=none; b=mRPjcwRAQWbLBrPzJUhZYq7xBknPxwSuPes6nEawePxegyDNhcNrzynvNPjEY11udFcMIhC/0MaiW8Y7yWCcYTohswR2SajJNRdrwhd/F0m+g7JZRVt83xrv671yDtKs1fEztTfZsNF9rSH4Y+eZ+WRtgcSKGyv2n98AVdJY7I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713098; c=relaxed/simple;
	bh=ERpHvRnw+l3wstR+WAIvwtnoTvXWleFvGGT+ROO3fSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OuvhjKiQOUXhni5nhtKe8QrJu/Qi48bPgDZv8AaV9Lg2VBpbm46PICNWm3CRVOF+FeK5IkyK21HACJDQNWIbO1yLqMpg2iwtq9DymfIm66x/XLUZ5J4OvS6x54Br5yGLKpxUYqOaKU3Y4pHAYOn+XaNsr2OQeWf30iu4WWMuP0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzrvxciq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzrvxciq"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-297d4a56f97so25717085ad.1
        for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 00:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713095; x=1764317895; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1V/r9ZPcuPpDeS+hBrkkwoFJqMj16O3RGCN2/vaCDuA=;
        b=bzrvxciqo/CnwlsezPt6oLQQqLXos5pkXOQx8mW4vyTqKzcpJeNCKQepdZjvw3r5qh
         jEvF8x1lnKeTaA7AP9xeb5UISIi852pSILFeUVo8vb6mi3nWCGs0U+87K3pq+d34Tg5B
         x8eYtq21Wxj3uHvDpQfp8BVwp7sjpJumzd+WtdZneZ2ck2SMY2YgQfiAb/koymStrQgy
         To164Gxv5i51wgsoPtD9iRqqPgHkmQPZ9cKWK1+vocZVXFGpScBhW+HGrS5Zn8jUAgp4
         OrxfubssrFxHv6V9GcLIPitkaclsGyvU1jvevoGznuFM+wOtlNmOjOjURVuBTUbEfgy6
         /KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713095; x=1764317895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1V/r9ZPcuPpDeS+hBrkkwoFJqMj16O3RGCN2/vaCDuA=;
        b=GHA936wwlp4pR7VzGkIqndaSfLU1/pmG5UQeVUCmpZ6/oZ6fuEDHi5QHLNp3ks8SL2
         4H/b83eFIykRQT89fnBuHCWZLbdf2NPyH97SdCE0vovsv74d8IbfTMG0BmvVb4sxBOM/
         OCJ0oLbpTesoUORj8bozXvl5b6MRHditwFoXfe/XvRCVKnwS4EJVla2G6iLPu7wJQgUB
         mv0bLt86uRR4fY915TFMGeu4/aJeuxAY/EE5vTj5Dq/v/wxYFC/Ff0bW7JPa0DT7Oahe
         PGXSbv5bRgC5U1yuFJRJuwr3UNfba6G7T9DGu7OPamXOCUkmObtE6puuhK3k3nVytjYP
         56Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWqctWrlXR505bEl2xShGvTithvqi4WiWkjSIiL+GkdXB2184u2/vTLRVenwQ9hyMnc6d5L9T3Y7Bwh2BqeIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCWXAUmt+J4/AXNL2dPPSnDJbD2HUs8cHpZi7qKnkDOa472bOB
	Cj1FQWIS2IPIKQ6c7s+oUttq7eMceo8cfGaeKt5PVfax+pUzetjK9M+D
X-Gm-Gg: ASbGncuPEQcLQmHDCI+CJceGxMqfg7ZtusSdTfnR9jHKmlAtz8xxdosrfQfNOcqLYZ0
	g9FpItfEPny8pNZ8ERzYocxMz7+GpT6klKWyKOiqw/OI+Ac79dqg1YzO8GHCS3bPPm4q5jTedEl
	U58faKtKIP/7FZAncu4gEDWJICNSgejKmHrpW452ulxLE6vAC3zzSioPVSWFk2cUphzgnsFoWjw
	cns0s+vxStlAJ8rAc9tigbkptPMwy5KJ0ddPK8M4Zs5YPBjp8e+a0yuqtVrUXp51jcKUAXXCVXv
	NUWDaqoGhsHMFABX6tVCYMwTXscu8bTTu0j24p9XLwukPnTgJPaRfwHq8d5uJUcRb9aHH6mr3Zq
	zwDMC3nCPKy0RfdVjUUgD+qTSH6AdF8nJ3XNdwxLTXZqVEqkOY8nCuMmn4Ky6C/H3uD/JhjXv2K
	aVtdaoqxPmTU7PfHRi6iCymrBp3Q==
X-Google-Smtp-Source: AGHT+IEHu/E6NqM3wgnO0PzNJHfm7ylIJ91XqRa53EvuqqhyyBcUb7YMg890bib+mDDMVjekZVw8IQ==
X-Received: by 2002:a05:7022:4419:b0:119:e569:f25f with SMTP id a92af1059eb24-11c9d70b0d1mr568161c88.8.1763713095153;
        Fri, 21 Nov 2025 00:18:15 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:14 -0800 (PST)
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
Subject: [PATCH 3/9] gfs2: use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:42 +0800
Message-Id: <20251121081748.1443507-4-zhangshida@kylinos.cn>
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
 fs/gfs2/lops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 9c8c305a75c..c8c48593449 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -487,8 +487,7 @@ static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs)
 	new = bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOIO);
 	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = bio_end_sector(prev);
-	bio_chain(new, prev);
-	submit_bio(prev);
+	bio_chain_and_submit(prev, new);	
 	return new;
 }
 
-- 
2.34.1

