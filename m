Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C42F2F9DAB
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318790; cv=none; b=tXgOuoZS/UdC/vjTVOZwQGxA4C49tJIgmm2Bp7aWs9c8cjedocNAy1RHJ7VBsaHITzi+B4U0E1ThrR6/Q/mILykpFTeRNtRsg6TVxQe/O/m7Xwu2W5nBdsLU1zsCkvZspJYpSRSUX1CN6uoxh3ApiAWZZPeL2VX2bJ49jtkVFyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318790; c=relaxed/simple;
	bh=eIesZROL2LjNY0DrQ6P8R8b1cwhdKxEhWtmo1wbXnYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gOnqx3WNgwlIThIG2JyLVL8sY6rRh05/3XDCeqaJ8B2hmuWfxRhdBIELEmj6ayHjhopfzphZhhHkGq7UCvNI0i+xrfTOeWe3BrhiQ5ggwVia8kfoUI09kPyAk0d0TVyca1A4coRXnooscUuREBtdhLlvu22YaTPeI3Ina/E/+QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/Tctji+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/Tctji+"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7bf0ad0cb87so2032762b3a.2
        for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 00:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318788; x=1764923588; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAlkzqFb5MzFCJaoNDunPaLLzQJH14gDGKiKCNGaT3E=;
        b=M/Tctji+zir8RrMJa02kHnbrPuoppwKNRP11A/OWIxzOrDNDFfeYfPrJqH8NOFr3Lg
         U51Lkt9+FdI5+MGSKkwWfVBD15CQfETA++ib5U3O1lwSsBsVVL0cFEbU4bdP4JhGtgNN
         fjA83q1t8qymBzzqEhqfHWVLzfPkaQrbj66xnfpTfj3qhP8YOs6sFe+ztMQWGgiJX+CJ
         oTeL3k19OeEYtlWOMcFqsb51c3ThLwd8sdwyPwaJSmEAgOwD2rfkqtbQ9m+qWhxqhGpe
         XWCcvSJn2o9qL7D2Bm5O4tfXWwEN0oAVkq5V05AQfn6449WZgMHygL77ft0IAnedO2K6
         1/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318788; x=1764923588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PAlkzqFb5MzFCJaoNDunPaLLzQJH14gDGKiKCNGaT3E=;
        b=N3A57p9vy/jKsEaC9bimK2UGM0VtdfAscAj5oiNMzhA84EiZ/HhPQqKXtOArCOH6DT
         E4c+Nxp4My3IHCoP7ZJKvSV+qk12LGwzHwLYfH2w4vpCe+m9/R/5tanJdeYJWxgEdm1e
         ENbAMbzb5ZjNlFraAfnbRfM9BwFDhlsrKu8pAjETNV22rat4/Eb7fRWYccDaxc7zhkyN
         jqaKky4O7lLwIFOIJqgJekqWkCudyRKJmn9fGVFmB2YWohUu1KRq3Sf3h2AeJwg987e6
         Wv35ALEMX4EL6SfWDivnITg1gPeAWHhYAP25chM6lU3DlFmsjYG/nNhC+hbBO5pnDto0
         q4kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAclD82uVR4A4+ACeQHoXzFYrCBJ2q6hspvGUb8O/o0xV0aiIuci36K4Gpqby/4AVqi/sUj44odSI11zjEtg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8RNuPsbsIMoUQC27CT1CHMHjb6eQAgiyHl46VlcOaQj9J7nVg
	wabdC13mjoKq9IseQ/4Y0pLpP3WszaxyhmBfw76rCnB5g7NWZ+KtCvG/
X-Gm-Gg: ASbGncvNZFCW9VDbLyFPKLcYxsmAcWnnDy8KapEA7W/cUKkJWq5B06GP1MRKeICI4DZ
	K7LgF79dJt+SMfwdzFlzlM2NQACvJu9lkFjJHRshEdBPiBw1pePRsJfX0ThPAOw+Ltppv1y/qyd
	tus8LzUqlG4DzziELbJiclYXKjKal97RR0JDvvYpqdk0JZrqb/pmPV8aYx89XZbG65xzRtFB6ra
	3rRh39QcHfpIFmHRGNEIFszvmwPxW0lkahyU/iLsmelFppaWx8OnxsNHlvK7JQyhlY6hiGJemEb
	jQbgltIwqhUwzFA4CKivhhW9bc8BebQlb4hCIxSBZFJyTLdSDdVCZQ7CwvEC/CWcxnOhH9FsEU/
	wxfkCHV2xVZyo7pviungz2yNwzq2C4bk+ccWSrvcgfbNnfWYeHcTkthLbOAojt5NUq88WtL9nxK
	odx970ZGi0HWbMtNFfNJJUh9cpsA==
X-Google-Smtp-Source: AGHT+IFIaFCQuKpxcLcZ63tEcOt0hGjrfoUQN9LWUQ2kBfICDUhGuL68J3zsB+mI5c6KDSWUdB+sFw==
X-Received: by 2002:a05:7022:670f:b0:11a:4016:4491 with SMTP id a92af1059eb24-11c9d84c6f8mr17988575c88.24.1764318788462;
        Fri, 28 Nov 2025 00:33:08 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:08 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
Date: Fri, 28 Nov 2025 16:32:13 +0800
Message-Id: <20251128083219.2332407-7-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
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
 fs/gfs2/lops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 9c8c305a75c..0073fd7c454 100644
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

