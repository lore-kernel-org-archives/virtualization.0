Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56A533EAE7
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713107; cv=none; b=lJ0yV+Qh/N1v4L4KlCyUH5Lm+T9KJ08Z8LO4iiG1uTEnPCvJ20OzR/EwC3di9OTuHgZB3zhq2D1xgBTjjCCAyKBAZ8Dgv0eGiCX86O0RcMmfoCIGSovlSxovpyL/4H5boaifU4p1LLqx2yRp7BtgXWI9O7/zVsGWEIv9RMRVUCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713107; c=relaxed/simple;
	bh=IQk4UzcYY75MLGhtAKmFDWXe3EWxpLfeGLiZbBZmOTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ICVkKCgOHQ3zI6B2OLg2+E0lN6Y9hZ6vl/qFVTy5+aqEcAWxt3DT4n3ypkZBSCZyBj49rYwFy7MlW8Coursq0ngwEyA7ci7sv9C6INwG0OH+QmBa7NyNrZ808h1riBd/WmCSNxYNaUEFYZe4UXQiDvGZSwApKK/yoL2KOci2Yh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNn2zvaH; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNn2zvaH"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2a45877bd5eso2695359eec.0
        for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 00:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713105; x=1764317905; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9uQUsysFrv2eFtHnu17b6ejhzRgB/BOqXyxbR99K8c=;
        b=VNn2zvaH1dla8AYLvTewYko7Ry4+H1pNkClbU0EHjR4Pjax9W1Z5AeUzKGkGmapwhu
         Zn/eAHO2juPdsB+bdpwRogURwMXs8AjraBZkeEUWo4Y0hBjlpmviRmvj2PRGII8MZZ/W
         02vzTPtd6NbjOs/QdX7o5rEld+t9ZNsnTSSTG6M9Vm+3TGaAfXtITwX3dBqopZ64U4o3
         dQB0I/BumzvDR3g9L+V56HYdYVsP9rWr9pWOM3z5qNrAzwA4jw0CiCGhUCIafLlbJkNW
         sFCBTEoUlAorSrrXs5VOvL9XCDjYwx3SpOEHu05B/XNz8ZDg63tj5kt5NErXdmAqTR6w
         A/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713105; x=1764317905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I9uQUsysFrv2eFtHnu17b6ejhzRgB/BOqXyxbR99K8c=;
        b=OYkqQx1SOgKsdoUAXFgJksxOKQWzVDF9R8MdQ98VPcglXCZP9rFWcsrBuN54t8H23M
         vi5tIdXTtZHBJM5ak/MsMKlHeiebzTAPbsDU6DVQf0VSjkys8V0fbOzzqXiBamQudLkc
         h4EqrLYJSFG2EsvoCo6sTI9v/SburvOIsv1Ncfai2OuZFxV6Shx2bZtWAtry1lgBe7gM
         K96rjj3TafnsPTSWkEd2sxhvbHGRm7e1LxTOrJL4jrYeG/iHy48UB9k8eS97/rj8jXmu
         QXGd9RVs7EjHiWq3oDSQ3YSNEQX81SXOn7tl2DwIEHK3O0SiJ3ebwTXbmyBSYHJ1VlNO
         3h4w==
X-Forwarded-Encrypted: i=1; AJvYcCXAig554876G+KEQgORm4MWEW7SJXH3FWX4YNnoNjo7aCp9NQmvYdsiXHuPjBydnqnFr+4dumwNi12DvjPn9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFQ5bNHqV+kXsXXm1/j/nInHPjQ5G15SXWfdp29eke/j9xutoy
	ymKWCSV9Nv8oqlGZ0Qw9Oz6mXAx9j4DctLD3JMZdZMtb3fwOFbjdiY69H19tpVbHGas=
X-Gm-Gg: ASbGnctYUcQfkGbsswFWZn6uCRGL4uRR5ASjYY0wMtFcp4JaEY6Tt96RJpOV6MeOe2H
	xn4FqucNPmzt0rCzl8Z92ygstDXAcaIsTQo7pSbMeJ/4ROz46k4XPJa4kgYxr0Z+BcdCaCaWBPB
	oprhcC4JO7ntiQO/DCYiC5wmqyqWhILFRorVEUefLj+4t2MOsJDTOBj1XrtDR3DhhTAYfRKDWAs
	v6OpEqeU8ymh62j/94y5NaCU9qI+Po1WqTmVDMAyrVKv/qnMnGEoq3nWlK0BxZHILEvbQ8n761g
	jUj8mg6SIbcVi/XFm7KSSqo5+xbK/1fMKQRN/ZwMUVPbyMODCUHe5qLDskxh2PVifsS4ZVPNdfb
	0+r4zlMAFCrv7ThERiWFP1Mrz84NPF67UWLawDAm2ZXZOkBdP9nQpYtkQ9wdKdNljnInqxBdV0L
	+LyABGN8/PN97QZWZpFXuyopw3Tg==
X-Google-Smtp-Source: AGHT+IHMz3ddZnRtvaJ/THHwP1wUMl1t1R0JBJZczRRfd42vINt7DVj8VsCW+6dMTczCFjZ0JXIsxw==
X-Received: by 2002:a05:7022:a93:b0:11b:a738:65b2 with SMTP id a92af1059eb24-11c94aefcabmr2003355c88.5.1763713104659;
        Fri, 21 Nov 2025 00:18:24 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:24 -0800 (PST)
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
Subject: [PATCH 6/9] fs/ntfs3: use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:45 +0800
Message-Id: <20251121081748.1443507-7-zhangshida@kylinos.cn>
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
 fs/ntfs3/fsntfs.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index c7a2f191254..35685ee4ed2 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1514,11 +1514,7 @@ int ntfs_bio_pages(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 		len = ((u64)clen << cluster_bits) - off;
 new_bio:
 		new = bio_alloc(bdev, nr_pages - page_idx, op, GFP_NOFS);
-		if (bio) {
-			bio_chain(bio, new);
-			submit_bio(bio);
-		}
-		bio = new;
+		bio = bio_chain_and_submit(bio, new);
 		bio->bi_iter.bi_sector = lbo >> 9;
 
 		while (len) {
@@ -1611,11 +1607,7 @@ int ntfs_bio_fill_1(struct ntfs_sb_info *sbi, const struct runs_tree *run)
 		len = (u64)clen << cluster_bits;
 new_bio:
 		new = bio_alloc(bdev, BIO_MAX_VECS, REQ_OP_WRITE, GFP_NOFS);
-		if (bio) {
-			bio_chain(bio, new);
-			submit_bio(bio);
-		}
-		bio = new;
+		bio = bio_chain_and_submit(bio, new);
 		bio->bi_iter.bi_sector = lbo >> 9;
 
 		for (;;) {
-- 
2.34.1

