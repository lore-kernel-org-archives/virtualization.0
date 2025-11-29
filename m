Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B39E265630
	for <virtualization@lists.linux.dev>; Sat, 29 Nov 2025 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764406932; cv=none; b=jJcW2eRmzQdloApGJHbBLNzCCixlf9uWjtV+8WY61ACnu3VIEePpeD1IMmmWAVs3MnPDmA9OirUeHVqRlvdGo7PYlMJU9mDM4e7SNdNCKuRVNTfEZVEa5jhK811iqhs+MqjeKA+5Ix5hs/fB4uhNddqha+eBijTWpEfhcDjzQKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764406932; c=relaxed/simple;
	bh=FvdW5UGbfZbg4/JUFTbGCNNccxPDUjVX1PnGr5SdWKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YOki9CjJTgR2bjOFPTBQuC9K+dl2hCjQkrFWv+6Q00k+bdWOimPClY/JWZs2h1g0jIFoOFc/SlC7c/E00ldCUyEqsIHICb1jVQSSja1k8pziW8yoC53BClbaqaTLvKT35R795tpXOn7rpz7BSi9p/wn+orszplWoIaXtTrZWc5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sut2w6uG; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sut2w6uG"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso2129136b3a.3
        for <virtualization@lists.linux.dev>; Sat, 29 Nov 2025 01:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764406928; x=1765011728; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqwLZMa4ASc5Rs++C65X8rlK3EmN43I2MLDa5i9050U=;
        b=Sut2w6uGhsId2Yk2OtlET3e6SuiWi3wlms/Aov+int5QuSVhkIXpu34Ckemd8b4Tas
         C2Vdyj8S0X5eDm+hwbSCmJSQQF4Y9UfAOMx1yVcb8oXDwSDgU+WgkO0vl/oAEpUnwHdb
         otl1J4G+tKyPA8l35Rla+YcgSI8qNw/1j4IBxFFsHgkUMeKp9vohV8JwnAGICgxEJIaH
         RclDbY+vEffp5mLujhm0DIrS6LZfDWWsi4Z6ltKxuJGOhyHsz5zyOCfYt7+sbxOdoDcZ
         NnC4Jp4WmH75tUBCrn3jiKpM1G+rWLnHY4cRanI/atrElMqEPkjyqTu880UkvEOHdyvq
         WRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764406928; x=1765011728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fqwLZMa4ASc5Rs++C65X8rlK3EmN43I2MLDa5i9050U=;
        b=UGoS3qOUP9SpHVSxNZJ9BTfBO8FiDHroCcBxuokbaQVfAPnXYuYO/nWwNPVy2vgl56
         BqdAMlszMdKyUpAFQrtMI3URNeEqw3kONO7dYT5fwAvZ6Nh3qYS+UmlWIGFNK9kffuwh
         8d0YlJ53StU1oUIg/47SrLuGCh/Sfg4ZcLRA2RpoToNMiZMq/TPc6uW1lLOCHFqn4WfD
         3C0v6KnJYf8Xi/KWyzd4rH9b2F3/VKCrF2oY4h4BtqQEk6twD2cJsA25Tp/Sag+14Q+m
         cnOmA34Ej9uT/h7QgJvvxqt4Aruk+4/iTX7UisPCxNfgIx6Ocp6PKexyJboixzbMTQkf
         sJDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYjffiLOZ1+K2kHk0Z7k+az6vgF8x5vssaoz5XU52sqL536rDMVezR6Vio5PUe9m0h/+TJk5xGGYyIoKBkdg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPcrsAJ2cfQOQtsZfArIkGz3y8QkUgupKNtgC5hk9efGNLFS9j
	6dfiX4IzXvPsO8QW8PjGAYW4cHoangEhTr9vG8yYwaESoBI06epDt3HO
X-Gm-Gg: ASbGncuTEjh14kUNNlo7DHkPfDy1Us905vJ2kRJ6XpKts9x4rgUtAOQCvN12RbBmSQg
	+IAlFWrVsRjpfcdYEieYQb28/XDrXvxmlauvjSETKtgSsrrJmz+uMPKA7gOOBHkGbDjKFWeXKD1
	Twf0RzLXQwfH2B+8pJMScUIJS6pZf3YICxjZFwkdsttKRrh7Z9SW82Th0j3nZBCOpDWSt4XhK1i
	KzWotCHWhg1/3EBI+1RaXEOLKDXxUmx9/uZIxzhJGWHRO1uCG/za5d0lS1Tq4caMv6YjTbBxtDp
	ClxomoTVcKkYZPLK7utfExvFAtyQe3UeXv+5iaXCgXx6JQkGH0w0qAv9WmvZGqEj0kuHZtWj77S
	0ImASq9dF4dbkm1ieX9j1MDgTUaojfvumH/UU6bS+pr5tL8tQLhaR13fr+auheYDJ4j2faa7WA0
	Hmgxxn0WrP6zw2MZrYFTKx+m17/Q==
X-Google-Smtp-Source: AGHT+IFpam2VF00mu2rmyIi1m2lRR+Kb7w2Y0p3kOg5DIMgR5i6hM310V7yybDkza8FyIBCJgjbVWA==
X-Received: by 2002:a05:7022:4186:b0:119:e55a:9bf8 with SMTP id a92af1059eb24-11cb3ef2761mr13917973c88.20.1764406927773;
        Sat, 29 Nov 2025 01:02:07 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm28114394c88.0.2025.11.29.01.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:02:07 -0800 (PST)
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
Subject: [PATCH v3 7/9] fs/ntfs3: Replace the repetitive bio chaining code patterns
Date: Sat, 29 Nov 2025 17:01:20 +0800
Message-Id: <20251129090122.2457896-8-zhangshida@kylinos.cn>
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

