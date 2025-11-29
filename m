Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6896274B5F
	for <virtualization@lists.linux.dev>; Sat, 29 Nov 2025 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764406902; cv=none; b=bhAxzIrJWpWFMiUbSibVyKpr6wjjXrh9faMzEbiHK346vs7wQMzYY1d+CbGUSZvkeGE6MKcPf6aqDFkmZ3vwxbOdqNjl+s3YaxvPv01HABol7TQXRHM5ULmFapqIKxlXSMmP3YlYjY5lWxGIjQF79BzVHAuX74uLNNGdU7vSSoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764406902; c=relaxed/simple;
	bh=JLIdNXPMejF737Jv1xzF5GicNRibkuRDb9iX4pmjoI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EboZp8lCOqUSw5VTqMHEO77u9lA+mIHjih6QuILcCcWvk6REbwqVGl+/F+a/ArCFOnXeRO3p/HphkXSyGNV+Z0WxNOT3VUfNGi3VoPiKGv3/nfiUXrQ1w8+fUg7LuQrEheTs+QH+dYVZ5zym0owWbAEHrnV7BIW16bZJvJ6O3Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6a4y1ab; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6a4y1ab"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7ba55660769so2181586b3a.1
        for <virtualization@lists.linux.dev>; Sat, 29 Nov 2025 01:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764406900; x=1765011700; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B+NwUppxNtx5dO3GeNOAlGv3QVGc2Q+cteUdMRhiTw=;
        b=M6a4y1abV/WzvZ3r4zY8larKIGFwqUaJUw86JNHPP6XZWflt7Voamr3OhWGKUATPvt
         DktUsOndfhgAKbxDLs0AlCHLN1MSQn0/QsyKFReYO7yp05LmziT+ryAJQngLW7wlv9b9
         pEPm2u6j3ma+zqFXK6Ty9uzaGDweejp67+O6tHYItJLvXGk+BXAR3grL68nejKOWFti1
         ZgE9s5AT7MzKo7diZkGIEceXEhBGtBFVgiKSqHPRMFeY4OQ5Zsi1yyuNyI29r4UnkwJh
         w+5yzaKQ8GRtajv6GvcemKb/z2tcbFgyPUgJE2rstbw40CmRJcq05S6qKCbMD1XnsSEB
         GkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764406900; x=1765011700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3B+NwUppxNtx5dO3GeNOAlGv3QVGc2Q+cteUdMRhiTw=;
        b=TZ3KbfZyKkB5jM/Y+vA+F8B7YJNeGGoah2CQbzYfyFW//uoCVtXjGneVKFhThoGuZK
         eOhryqcMFlwDOxZ0Ea4bxuZKC8V0HpjjPkdrb8Ze5TBiOonKcTaFfMTzSUs9LA5Yo0Km
         5g0sijsfH/MGvnZAtknuV5WhR88nwloo+yywubmebn9kGxMAXjkx1oSS9MAp6gRVQbiS
         XR/7MXHHIzhR55rKyxuxIS14xa5ooZuoOmym/yPJvfR+jJS7OSykD7EKp1bYDA/XllPw
         rZFePpxXAHaCqb1Fbe8I0tAl+Xx+Qxnh29WKdcD3A1h23lLZedBMvT6YQCyUgN0yLRDm
         ZanQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5SfiHetwyLhejmEqoWNmUQM/koWSsk4s0L55GhB1BmiNoIEG8XuddvCdlDyKgS6DVMkQMWKbDL9n+/1I2Ug==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNoqQ7wh6vmxc8NGbK9hLE64CHyKm/UDecMO7c2sNO64XXxd0R
	KV36rHGV+8bb3S81nPxVUe/gmxr3V8Mqhj0GS/3VBhEGjDwJE7EGbVdT/9hysmVmZrU=
X-Gm-Gg: ASbGncvEOrEtNLubf6nP7/BoqS9r5B/fugu2cya+PXdVDis+tMTCsXCGUo8tvhJ38NT
	0xJ4uqIVCUguK2tQCbhPdRvPUwRbM9jfJpt6Pp6l1k5J6GGWXgdpChQnsp7BjTYFmT06EwtV+ys
	JK+XJaDEwD1d/E6kPdStKJZT3AOvBuMVFpk+fforZUM8ksXm08z7OU62Lw4b2QUZvFrO7zr7nUv
	RZ7QeCoaWdOpvOy4G93j5V2h7NTs9wvtaQGXcsAtIHZgOI5FnVfIyuv3gT6FYsryfbc1KSRKpYn
	IL/nHftZaM3VXdGrQSmWQPwbstKZBN/Ag/Qk7atTVgilb/2W48LKnZg3kYfZZkqUUW6mHOkJXAW
	uIwerUguSeWBJh7bF63/QN7RHzxC9siNCaGP67ZE0mcwU/9fLjltCdGx0PhoCoyovttWUuh4d4G
	RMs6pZ6rbcuwgAcUaQ0KOYaoYrANAwbOXPw5ON
X-Google-Smtp-Source: AGHT+IF9fpUjxnsoJ856uo76C4AbEbv+isvtq3QMxPEeI8s0lui+ms4Diwary4B5eKv1gtl0O4hKMQ==
X-Received: by 2002:a05:7022:ec0d:b0:11b:9386:825b with SMTP id a92af1059eb24-11dc87b150cmr7316305c88.48.1764406900072;
        Sat, 29 Nov 2025 01:01:40 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm28114394c88.0.2025.11.29.01.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:01:39 -0800 (PST)
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
Subject: [PATCH v3 1/9] md: bcache: fix improper use of bi_end_io
Date: Sat, 29 Nov 2025 17:01:14 +0800
Message-Id: <20251129090122.2457896-2-zhangshida@kylinos.cn>
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

Don't call bio->bi_end_io() directly. Use the bio_endio() helper
function instead, which handles completion more safely and uniformly.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/md/bcache/request.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index af345dc6fde..82fdea7dea7 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1104,7 +1104,7 @@ static void detached_dev_end_io(struct bio *bio)
 	}
 
 	kfree(ddip);
-	bio->bi_end_io(bio);
+	bio_endio(bio);
 }
 
 static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
@@ -1121,7 +1121,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
 	ddip = kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
 	if (!ddip) {
 		bio->bi_status = BLK_STS_RESOURCE;
-		bio->bi_end_io(bio);
+		bio_endio(bio);
 		return;
 	}
 
@@ -1136,7 +1136,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
 
 	if ((bio_op(bio) == REQ_OP_DISCARD) &&
 	    !bdev_max_discard_sectors(dc->bdev))
-		bio->bi_end_io(bio);
+		detached_dev_end_io(bio);
 	else
 		submit_bio_noacct(bio);
 }
-- 
2.34.1

