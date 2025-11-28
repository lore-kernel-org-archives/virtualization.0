Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F6D2E03EA
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318806; cv=none; b=ZeKXINGR7DQrTnydBDdN6ro2DztiiN8BfPRHwtYt8dE+lg4vAy1i0KPsV825Z6Pjl2qRVAmnqa+8Mucr+8t6SPTQq5bDw+eYv38IZpO0PKbZCWdvQnOdTFFufKhhiiS4CG7GGGE58HqKQP0BnVf7Ya0DLjgO1AM8jMgrWlqxM3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318806; c=relaxed/simple;
	bh=FvdW5UGbfZbg4/JUFTbGCNNccxPDUjVX1PnGr5SdWKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y0OpKWo1PR15f/I9qIOYGdrcMOspWpD/wQ5JrzXTl0FQmjz/YffV5zkYyw9LQqmAIJfdpjNSI159dT1KvHSFAlLhggtdiZtUHDKV5gHnibb4iuRa7gtcGI4l66VPbudonLmk6pfIAG1gkWcChkCB8vqSkxCcy3lPH+zNTF8kuRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWP180F5; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWP180F5"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so1447160b3a.3
        for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 00:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318803; x=1764923603; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqwLZMa4ASc5Rs++C65X8rlK3EmN43I2MLDa5i9050U=;
        b=BWP180F5KnaJ3OOZV8ZrIhLJTi8tGhGlx1RoIAu/8uSOodxXfVc/IzYG72MqKBupYc
         /olv68safgRb9F/yAvP77ja4aWDT5VjEORQHbLVYO8qskyrvrkdfn9X7u6bpbqHGuCKl
         hCBmRpt45Wxl5TZuOgr9IidfqOv7A5gSxrDmZ54SEe5S72T7gi3b6HLIz+RV+gGEuhBE
         1+velu4/MBfOpiXyAFJzFVkiFy/DBlCLMBE/I++NQw0YhBz2X1E099GihUhWtw4yuBLO
         iQhLExS1gALhkcKTb96S61D39PCw9dMhRXiHivgZgVShhMkoCAVIU0s9Ir704sTfXcUv
         Xscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318803; x=1764923603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fqwLZMa4ASc5Rs++C65X8rlK3EmN43I2MLDa5i9050U=;
        b=UjfIifwpYKCh7HJnZjYp2BwfrqwruXkQTGNgyLcBtDa70m+vP6lGoP4Mc/urbR9oZi
         chZuwPubxtep/E5BkqB7qlQhZMy7xCbBb8Nf+BYNu0pdbwTA5yoopradBsPTa2lv/ow/
         Tv4ls2+OQm7DsEt/025LZqHmmfG94Idwdqg4VDiG/FN7s8taWvGkLVSZ4jT7I+frQMlO
         AQYNQn7E5lQy33XeCMwkLL/M4KYvCl+ZdDL5IP3wZspU3XCXIG51PYJxGZPdTzk1c+Ce
         YGpZUZiuTZGsjJqXvaF3G9YWSAAJfFEqFFMs8aymvWzUvf74+M8rilm/uxQp8q3hSeXK
         576g==
X-Forwarded-Encrypted: i=1; AJvYcCXOJGcxU9eGhpWQoulLHQoc3wA2tdUPdv9Mgtj6tPtLd61AH1Nm5i75W23Kni3YXdWmGCXh9YL37w2VeHnR2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVT+e4tbQluEvD4VExohcdUbvB3fRylqCgnBblxco2HoxiO93E
	FhrZOjnFl/8chQkaKA7VJF/6wZSzzyHVIth/2X3sddCFyqUEBxWkLwLW
X-Gm-Gg: ASbGnctBIIdMUZecaZVMVUI8cxfJIPvP6K0vkgSL837JyB5uiaUFxBS9W5RDtnPTYy2
	jB0udJJpwhRXott+yU2nqgAfm0u5rahprEls8snmpW3IihsnqlQ/sfbJhskDkFfjSe6qp1GprpH
	Fu4kXoxOz86zVMJmWpT59UDNfqUY12os9roJ0Dg7bXt7SH1UyQZpTRFKtxtzXRkNKkugRXjZIhW
	4MsVgwW5VGqHSapOQ8Ce4YRFOzwOAs6YpSYyGX3zbJl3fRmZjc4t0M2EYzHktnTRu3lghFayQGO
	HSJodiQoJjcwzfib3rDEAeTcrWiVjVDNJsuqhrp6ieOQqBy1Tzd7sxwYJTvswwqGrU7IVWaz0iD
	4YM24wz+KPZtbhPnMJZdZ9h49ftnjopfBacXVmpE2xd4yd61ZxtBsJWxudlvBjm9hP87O9bfVvO
	3i5fawMsSkrJ6RzaChVg4036/lIA==
X-Google-Smtp-Source: AGHT+IHfWqQfXtBplCGUlpvV4df9l3L0Dj70ayVkP4asUXlu5VvYmL6fwPY6gq5t6aD4a2b+6FhgOg==
X-Received: by 2002:a05:7022:2487:b0:119:e56b:98a1 with SMTP id a92af1059eb24-11cb3ecc3f2mr9865235c88.8.1764318803303;
        Fri, 28 Nov 2025 00:33:23 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:23 -0800 (PST)
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
Subject: [PATCH v2 09/12] fs/ntfs3: Replace the repetitive bio chaining code patterns
Date: Fri, 28 Nov 2025 16:32:16 +0800
Message-Id: <20251128083219.2332407-10-zhangshida@kylinos.cn>
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

