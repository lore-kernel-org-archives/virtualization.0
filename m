Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45192FE063
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318810; cv=none; b=Wmvu/aJOnZHytAKKw3HdKmQ1SmWD9g4R42EOvDdGxpk5kQihokbd6Y4xpxFHvT7xWXfhW1cCKK7Cp5IACiMkWmQQDveAa0Il1DK5Qw7d9FIy7d8IV8atQkjZLQBgwD3tcwcsd5lZ+uWEcniR+7IL4rUUSl+UZ/+8dBT+iHZtOOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318810; c=relaxed/simple;
	bh=TbxNohFMmSKnHTWH+mnyMfPFRdWdcWW/LS3/VsufZdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jnsbvc+BTQu9d7XU97Q+pWAtfGHCYCCYl4fnfEFyqRtX6GgByelshKBaXbnm4MaaDElk5+rmwHsAW4ZiFCvOIRZpya17nHWvDQH/GGg/EEvbsT+6MJqyanDETttlpJz+n8ZPDnveKn35e3tKU5VqzKqLhvw26soEnVoHhm3FGKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EE62MRX0; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE62MRX0"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bdcae553883so1459167a12.0
        for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 00:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318808; x=1764923608; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJti1W24hnwF4OFg7cS4jWnw0eZv9xglyyGrmFluATQ=;
        b=EE62MRX0atIaRAQP7wjFlyAOKNbJKyyLvIE6107ew5CLRL4pGzUhJwgHmkMnXm95G+
         BNM5FVWwaHisy0BhjrJ+gYlTvGsgoKc2k3IjfNvGt+WFJwq4t5MUyxKjvvN6iYVNVRYi
         +6TAMomOaLm20VKIXU1dhb6XT3w62E0yvhHLv6tA7HhexPOc/wd32EfBzNhlXIdc1FzU
         dH/f204qY0hTQkLX6T/GZjHSoeiGVBLL2bZPUlzXGlyQhuH9A30Llv3dHOpEjkFK+two
         jF9p/qBz4fs/tkQenQm/tHYai6SAxdSxvzSdyCEutvIQb6kYCnXUyEuirDBJcf7YaMt4
         ehcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318808; x=1764923608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jJti1W24hnwF4OFg7cS4jWnw0eZv9xglyyGrmFluATQ=;
        b=OX/B4mRqQtU4ObJ0aBGCXPdG01ippM3CmRaoe49rz3DMiKOTtFkm5cJNFjTfjduch8
         NMD3J5tUyfiVc3+NOHYLqI3+EbOd7KkSGKKBe03SgfR5bi+GK6oeDZPs3+O9tp5N6VIi
         8PPuh/KH8xzUbpBwu9P8bMN51ok1z9zbaIY6Xc5CA57KcZX0MWyFfvb/p0zfj1qd4qDt
         jupPFXqlsqvj3OTIHHf9HdgMjPHHFNXZw1mBvrBVp/ph1noNIPIs/58zJGA2OwNB6ZQZ
         tgwn5ea8VP0STRYc4SOIa6KP3AfEf82jyoSZZ4m7nDQc7WouMXGnb+AfOz1oyShenKbB
         v45Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyyWgSJfYqYce86lFb/nh6v3lWWpkq4vjFbxN6h+Acno79uw3t7EBxwU0ETZ6x3/ZpDNJTKk4iPjpeivzuzA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrhnejbxgRdpVHjjocfHgYZ9aFE8LTMoZNDoPYP9WvGzQXUFfV
	HjGIWfRxVWqD6v90I2jzg2shS5c+PvD/gwhWwBVY/XuxWaIEViPgwQnc
X-Gm-Gg: ASbGnct0U/Wa0gB/FsfyIf/u0lt+TEwcBQXCNm3Ex+7XCikhq641nslGTmZwA5j8eBM
	vGJkLjz9cG3RcKzZSFETw2xbLHO82UeDeUqIRX9dIxVtjgX+YhdWMnkU0pTIIiGpf6okURABvS7
	Haij8AtVy+uNN8Okfpw4zxIN6lvhlQTwWsoBmCBWd0wha7424DTQuQSKPTqSiuRWs3Gd057QjF+
	lu51esQzRbJVGfd+/K4auP6MUMwhAUSTx5YVta0hfZ1/03Grh7Aatw1bAoe5P4rfu7ZmTmy8uOY
	4xxiO1vj03O6+3FdGzetDI6UwbXgxXnZcM8Gc0ZbB8Vye4FDx97/XMIL5e6mPExB6NghZi6QxdP
	Nquz3bWI95uyQu2yLJI1tgnt55tnYW2fG1t2nUTQ/0d0l1flXiUxoNZbdqawk7o3EeBFtmljoBZ
	NCs0rSxzJ2CnSBtev9USqK0vASx0PXJmd5iJB+
X-Google-Smtp-Source: AGHT+IHDsMToqUoj0PcNSA32TYDuHE8zhBuDir1BrYt+w5Y/wAZYCWlUzMNg1Dgih3T9wVkLcbd8Tg==
X-Received: by 2002:a05:693c:2488:b0:2a4:3593:6464 with SMTP id 5a478bee46e88-2a71929687fmr16240699eec.20.1764318807899;
        Fri, 28 Nov 2025 00:33:27 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:27 -0800 (PST)
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
Subject: [PATCH v2 10/12] zram: Replace the repetitive bio chaining code patterns
Date: Fri, 28 Nov 2025 16:32:17 +0800
Message-Id: <20251128083219.2332407-11-zhangshida@kylinos.cn>
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

