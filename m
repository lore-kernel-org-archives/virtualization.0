Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759E1287258
	for <virtualization@lists.linux.dev>; Sat, 29 Nov 2025 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764406935; cv=none; b=WZxDnmxPms0OgzC3+kGmSN3xJ/CvSFN9A7rxr2uKYECHHWt4eRvItR8iOvxOWNY+nTXYx9GGriDd+GEllyIqyGoVJvnaYi7eVdg9K4GO08m65fO50CNq/13nuS9Ihr1TJdm+Z3qmDGXMBpwoueCyaQg96USDXvvOgWJS8Y9hDFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764406935; c=relaxed/simple;
	bh=TbxNohFMmSKnHTWH+mnyMfPFRdWdcWW/LS3/VsufZdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ER1tGsVbbMoSxa/nzLxdPQBW5rzdbVsH2knnpmURwjbfPuoXSR1flbQxDBW/3yl86mW9ApXg4rxvK3Mrfca9kDCRiCERBcAYgR4MgMA58Js9ul+7MVzXZ8VxDP07SmJLRTPcE6mcK2BUKT7xR6ruXnYaAjmEPdN9CKikS3+J2Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgWuOnQX; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgWuOnQX"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bc8ceb76c04so1731985a12.1
        for <virtualization@lists.linux.dev>; Sat, 29 Nov 2025 01:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764406933; x=1765011733; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJti1W24hnwF4OFg7cS4jWnw0eZv9xglyyGrmFluATQ=;
        b=hgWuOnQX99396ehXb19QLKMdMdZWUo0QQHgRe01NqGq3QAcSdvDripPyBli7jDvqDF
         DwUTro9xPzIgu48uV3Pt7jAHXabSgojUSr9sMifskoyUKGFSA3jp0+a80H2+Zku4hF1X
         TMLXiB3i8+ExCanBjmhQVREr7P/ahEydUKE/UB6KWHo/e3oHarvuj71sFcbR6eAlk0IP
         gWClZ4DM76elBnI9b9NqFHpUE3D952/d47v9CT1Dz2vDwzgjmz1PD9SsrwXCuZ0RwdV8
         wCLWNh1Zu+cgEUc04k9gSTiFDCR3aS9zxDT5vWx8u0T0hqDPAspHI+HiyMlqb6v9i5b7
         3Xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764406933; x=1765011733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jJti1W24hnwF4OFg7cS4jWnw0eZv9xglyyGrmFluATQ=;
        b=BdsaFxbVyFmmgahvX58SpZdpmUrzI6I1deQk6WE5zoLXSe4p6lwGYTSpN5jcga4az3
         jCINrGZ4GVGtmL633VdUNUcOtwOVwRY3g04L9ZSZDVRXKzf5ducEPB6rocrd9fY49Xha
         ZAPuNesJEj73Kq6aPqqB9znlDrIxQ97OZoOJ90xAXrrTg/B89DX3kyxepnWP2rSZAAeo
         yRw+fJOs8YA0YPDNwLTTjU+H5lRRGqF9InfUv3Aq4TB/vgoOdSVob1LvHf2nFbVv2Zmi
         epJv7O2qFVPxVqYgaB49IBgHYJC0TJVcYCRQci+8XJ7KH9EPuVUFnggpAfRGoEQEKQty
         b7Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXzbwt9xBANujVRNrINvhFf3T9MDJvmTXK+koHW+JL9/13a9VEuSL2o3DGsMA1WU7NsDb1N33e/1DjgmLmPsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPEbpMXmNlubbVNKr+J4ywPPJdkQy5ntosaH2H7YeVh1+inanB
	8IAFEQW/iBPHHmpyhuNhHPevSSKEQEFYHbCNk6f97CKHn1TSu798sOIa
X-Gm-Gg: ASbGncvcCvZUC8Zv4HR/Ghs+3Kz9j5g4D+4L+d7fe8aquk1XZ++bmvNRUs+/iuJmrR8
	GUMkYtNabLXhcd5fS049DayB0S0fhINnn9I69EK5MTNnemdVX++CxIuU3GwWpFt+E9lUQ8GPe7w
	0NepyyiHerqFobmd5MipkJWcnQeUsObSv7xFqFX7pC972nE0j9uQW7NNkc8GbszQZQpI/EqOvO1
	EsuwviB4FFHHVXQAMI04AeoK79ZzOg7h5ZE6ZtpCygam8alpNKbq0c5rCQJGZE5oJPlF+7cFH+e
	GsddB9sC9hdvZk+BVsSpfuXhC8MUJgJJkGdeYKluuHPDBtxAYHhz3eeiNGhaCIEoWL58Ghfs+Ou
	VATep02rhVck1poKZa3R90hcADrCSZ68p6baDiQ8jJZVG9DDKmSTgdcEPsZhdC+1BffQ8QQrTuE
	deB4dX9lkhMgK4bRL9eGK794emJg==
X-Google-Smtp-Source: AGHT+IFlPlVYDb7yoZVR+mp1/g2QkqJgugDSidMl3HlYfTA53/2piBoQC1SYt0i5BZxdW5Dqskhrig==
X-Received: by 2002:a05:7022:3c84:b0:11b:9bbe:2aac with SMTP id a92af1059eb24-11c9d863a7dmr14635218c88.40.1764406932641;
        Sat, 29 Nov 2025 01:02:12 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm28114394c88.0.2025.11.29.01.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:02:12 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	agruenba@redhat.com,
	ming.lei@redhat.com,
	hsiangkao@linux.alibaba.com,
	csander@purestorage.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v3 8/9] zram: Replace the repetitive bio chaining code patterns
Date: Sat, 29 Nov 2025 17:01:21 +0800
Message-Id: <20251129090122.2457896-9-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251129090122.2457896-1-zhangshida@kylinos.cn>
References: <20251129090122.2457896-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Replace duplicate bio chaining logic with the common
bio_chain_and_submit helper function.

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

