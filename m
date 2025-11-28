Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C992FF64C
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318817; cv=none; b=cncTRwDDE8/QNnjgQB9/jamM7R6WeOvtIAQIoMTaSkWDzjEWH5st5Od6JfqtxcOpnxqL/WYHsEAGsTFZr4UpdoumQPX2oMELq+m77wrUPK7gwncfPmWS6iWzXDwaI4Dtz3+JjsOgsgqZs65EPG4I/HbnNoxPKJwYxEVYBJO597A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318817; c=relaxed/simple;
	bh=MIUxfeIlXsLJb7D1x07khmxiQaV6FMQZLzsNI6cDMOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cygI5R3EtucQyff1lC+qu35EBATopFKqFaIVGafRLx+q4Co6/h+LTVS1rNBsPdDGoql969hOxYCrcTNaz8UB2pDwCivssnAVRbJnhgeRO31e0X6xSV5NW9IlXXCnKlLtlYkQfGouBNFSYmctqwC3FIvdDaXy5tjqCzU6KaQ3yAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H97JsPo1; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H97JsPo1"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so1098700b3a.1
        for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 00:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318813; x=1764923613; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZsPDOjyUTRUehf6LhbOb026Dy93eapwVzPzgOc2prg=;
        b=H97JsPo1LV0dEJ3lm1aMvcWUzzRN9xS2cObapnNjcpA3VW9LbbgDmGMoiXLcZSoOpi
         JRyi7/VdLgs1QpfW5b1MEZ/EBaO0tfnwAIvAiGSEgI2SswH5RYqc0VhsC+KgeqS551bf
         1h1Xjso8J8yvtkuee3N5VTm9s1bFBoccdp0eflPRPCKijwWPPWmMG8KXmCS3pyWOpUgE
         D5q3O/GV5lK4A48yOVngdFyx5xRn1nriqI2bl0shQdRBlnlfZDx8jQKHjfqf/1Jm8vut
         2G93wRuffSM3+xsXnwEm4wTAZEAZD5bLOgCxvdtgEHYsDJTm6eln9M8RGVKPNqHhoVLG
         X/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318813; x=1764923613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rZsPDOjyUTRUehf6LhbOb026Dy93eapwVzPzgOc2prg=;
        b=fiCkqTK01U3sDCpPFkod36ykezKdiVDnPXEnKpOM2aN6g/MCvwGRw9srlCEDkV1Yqd
         gQ2nBj5rLdkHLak/v08uHx86bhH2Pn0JpXgqcdcWR1Qf2Tou8w481BXC+KAAW5QE4YWv
         5dm1qiwa9zksoIjOEkSEldt0qZ+JYToHHBwAl2KrMw1PuSlan5XSbxBOkaDtf/wg0qn1
         TDjSqOhTIFf1TNatZI0xRUnOYRH2iyS1zToLeP5njk/sNqUfXUVnbi4o3gG1j8taS+nI
         Nsf8SS6e0JkHpD68/Q8uDjGiL27it5N7PVE9BIO9o5haluLi3IMdZIwwpzKyaI5fBkg1
         P2Jg==
X-Forwarded-Encrypted: i=1; AJvYcCU3itmFxDUam5l1c46v2uY4ZLWkK98ybNBuFWmsshxqqTzuYyHsedx1b7fg+zE6ghErrD/ulU+V0yZ5hoqeqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZ2GEKHYdI7eyPqJdMro8nx0nlJnIl5opo8GRCOZK/Yo4rph6n
	jxlZoQlNI6+LYHOqML0qtvdbmsrbrJ5QisoHD8V3Zx0IE7mvsPOYvKw4
X-Gm-Gg: ASbGncveonZtSU89CwjVW1boZd1wMaENRhmD8e6w88/7NSiZnGN3iUSuudR32uMIqeA
	8J4cSm6rGfuP4hkkBVpG1/U+TMnq7m2pSTZ9njQBa3mTePRCykSpHy5IFdNpsKqfrBH6rt/hp5S
	PeYjuVViThIttRJUPSgVL7ZFGRgfWRYoRpdISXgg9hZJtDuOHt9k9xNOzQmR9y+WqMicakv84Fn
	2+zGfehPuO7AMWe+8ydvJ7hE/cpXMNLrfttyQX1PvgAJwWCf/nmen/mtYUDAqc+Q3uWZq+cGD7A
	ihh3PIXQZhQbkobvwFzlgPuWbcb5iLYUzkxnPNqedq4J2wqyLY6VMArR7+j5X7+HT9Hqoa4BI87
	SGYEA1hPcoz9+cg9mopXKSfonSOQnuNL6BUdAow+EvvvCsHU30PAJcpw1UfCDNHW8LbBXGVU5Co
	RxBQDnc+HfGvulXTeEolEh75WWMWAB19dPkIsY
X-Google-Smtp-Source: AGHT+IHqHdLof6s224+GbtnJAk22/n625R68t5gW5XXJrnH8NN05gDy1A3OVkHY/4+FwyWeG7e9t0g==
X-Received: by 2002:a05:7022:3886:b0:11b:9386:a3c8 with SMTP id a92af1059eb24-11c9d867ff0mr21572562c88.41.1764318813388;
        Fri, 28 Nov 2025 00:33:33 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:33 -0800 (PST)
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
Subject: [PATCH v2 11/12] nvdimm: Replace the repetitive bio chaining code patterns
Date: Fri, 28 Nov 2025 16:32:18 +0800
Message-Id: <20251128083219.2332407-12-zhangshida@kylinos.cn>
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
 drivers/nvdimm/nd_virtio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index c3f07be4aa2..e6ec7ceee9b 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -122,8 +122,7 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
 			return -ENOMEM;
 		bio_clone_blkg_association(child, bio);
 		child->bi_iter.bi_sector = -1;
-		bio_chain(child, bio);
-		submit_bio(child);
+		bio_chain_and_submit(child, bio);
 		return 0;
 	}
 	if (virtio_pmem_flush(nd_region))
-- 
2.34.1

