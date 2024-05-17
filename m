Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0D410A13
	for <virtualization@lists.linux-foundation.org>; Fri, 17 May 2024 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715924113; cv=none; b=JzdIcAY4LUKtqojbZBcvMhH4sYrJu+849sptuzwghJesI6nv2KDZ3K6Y7T6GRVk1KCCRq1HmwQDvqqwU7TASniIDfP5hKOuyl4TgnjCXks+3rKI1Kgdn2syw/o+OShFPCUk4fPI4/MRSpVie/1qvnnZeIFyG6Z4nVqZnaeMgbMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715924113; c=relaxed/simple;
	bh=pGrY5t6tYxJ+Ol4BPllW2+FIJlPa9HzXLo7RcvJ3oGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NssTkMnYaC0H4vfu07TjJAgXQXUddWqOVB5eBpcmCwTG1Ihvsh9sjEhWbXyQ2cbyDYMA8nNlYyy1YHfXD4uEXGNLMt3gFS+WpW14pKEZuYYZXJsiyy2g+fEkhMKEAc4mIP6ac2wW7yLa9HxvUDdUpbV4u0M+2wackvpJT3xj9Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdNMT44o; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdNMT44o"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2012B60BE3
	for <virtualization@lists.linux-foundation.org>; Fri, 17 May 2024 05:35:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wCh6EBXoLBnN for <virtualization@lists.linux-foundation.org>;
 Fri, 17 May 2024 05:35:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=lynch.wy@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6067F6086F
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6067F6086F
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SdNMT44o
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6067F6086F
	for <virtualization@lists.linux-foundation.org>; Fri, 17 May 2024 05:35:10 +0000 (UTC)
Received: by mail-oi1-x241.google.com with SMTP id 5614622812f47-3c99a70250cso681033b6e.1
        for <virtualization@lists.linux-foundation.org>; Thu, 16 May 2024 22:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715924110; x=1716528910; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCiaoaoXNeiwrVzi+T413aFo5GLUosF3kcMYkiNgPQw=;
        b=SdNMT44oWEUMXFb9wVPLzFL310NMHW9bUc56o72PNO+KUTmflYccx0o2rdAmgmTan5
         gSAahXvEtbWCvj8FwkUmKVDsyJd+QDifs+yg8i+jNMKyhw+Ck/KD7NXTkJRcIeNQxoRL
         J7V6qy+sOKf6uG6uIEMRyukLRJYrGUSiTzffKoBuufy8Rbjzr6F4BDdUMXNumdxCMZQy
         N5hCX8XrX4P6Q/Q5C6/LG8jZ8yKpwEvOO5tF7o723+RoLO6HZ8FdhvXZvkwLtlW0/BEs
         +MA0DZO7VeoCEhAVVP75tUJlGxKfCiYxdPb5CN+0vCr/ykKJSKuh0in5W2L9bMxYBNi0
         t5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715924110; x=1716528910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCiaoaoXNeiwrVzi+T413aFo5GLUosF3kcMYkiNgPQw=;
        b=fDeh8HxYqqbzVEAlfblC4t2qwQgNDqxtdBFdnuPLHRO3IT2fYSEouv4RMe4bELw8AC
         b7D+yUhQMu9ZWihexr5SC1YaIFRmW+Z6DBeE49c2QzVE4ZTfGow28uJtLPNXPU+wV3JK
         Z0TobY1q59vGELLF8tR6B0aNas/bTwzin6+o3IEmcQJ4x/fSqFvwJ94xgMVL4+5SWI9o
         hJ+bMrvWYtiq+LVRMf3o5aUlY8acpm+K/76fnLFVABPGQk1h2nmefltQm+ltf6Xr9kvJ
         BDPkpVYe+L/b2TbufdZpc5JYL9ZLvt3zd1MuzVosZWGVo2BXZC/bAdOhK0+WoI3eSURh
         FCuA==
X-Forwarded-Encrypted: i=1; AJvYcCVvnT9OVtMU7YDtOwZfgFAZbCezmu9TScmB6W9V8jWN47jdevLBi5OSznJZjj/ArMSmLmfXhbZCHUkYvhMLKzXPBsrxZWvaRhh2ChndlGW4deYwcy2BMx8hWQ==
X-Gm-Message-State: AOJu0YzGJMfxKIXFKaJ1aVgI/T0lcNbcNAT+C8A+zCpN4n2CL0+Nk7oZ
	dgimP71g1tfTGfSUGk1JpTtGRf+gbe1Yebvw5L/sxPDP3Muy6w80
X-Google-Smtp-Source: AGHT+IHfaXGHiU68JYr23tVt2b4s8EoAl3p/ZFwW9L40JxLBGCgWyaJ3rMLtYHINMq+OVLW9r+I8oA==
X-Received: by 2002:a05:6808:3ae:b0:3c9:68ba:6e14 with SMTP id 5614622812f47-3c9970b1152mr22597474b6e.44.1715924109947;
        Thu, 16 May 2024 22:35:09 -0700 (PDT)
Received: from localhost.localdomain ([112.30.116.152])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f67b526b44sm3269834b3a.149.2024.05.16.22.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 22:35:09 -0700 (PDT)
From: Lynch <lynch.wy@gmail.com>
X-Google-Original-From: Lynch <Lynch.wy@gmail.com>
To: andrey.zhadchenko@virtuozzo.com
Cc: jasowang@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	Lynch <Lynch.wy@gmail.com>
Subject: [PATCH] Fix Issue: When VirtIO Backend providing VIRTIO_BLK_F_MQ feature, The file system of the front-end OS fails to be mounted.
Date: Fri, 17 May 2024 05:34:51 +0000
Message-ID: <20240517053451.25693-1-Lynch.wy@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <5bc57d8a-88c3-2e8a-65d4-670e69d258af@virtuozzo.com>
References: <5bc57d8a-88c3-2e8a-65d4-670e69d258af@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/vhost/blk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/blk.c b/drivers/vhost/blk.c
index 44fbf253e773..0e946d9dfc33 100644
--- a/drivers/vhost/blk.c
+++ b/drivers/vhost/blk.c
@@ -251,6 +251,7 @@ static int vhost_blk_bio_make(struct vhost_blk_req *req,
 	struct page **pages, *page;
 	struct bio *bio = NULL;
 	int bio_nr = 0;
+	sector_t sector_tmp;
 
 	if (unlikely(req->bi_opf == REQ_OP_FLUSH))
 		return vhost_blk_bio_make_simple(req, bdev);
@@ -270,6 +271,7 @@ static int vhost_blk_bio_make(struct vhost_blk_req *req,
 		req->bio = req->inline_bio;
 	}
 
+	sector_tmp = req->sector;
 	req->iov_nr = 0;
 	for (i = 0; i < iov_nr; i++) {
 		int pages_nr = iov_num_pages(&iov[i]);
@@ -302,7 +304,7 @@ static int vhost_blk_bio_make(struct vhost_blk_req *req,
 				bio = bio_alloc(GFP_KERNEL, pages_nr_total);
 				if (!bio)
 					goto fail;
-				bio->bi_iter.bi_sector  = req->sector;
+				bio->bi_iter.bi_sector  = sector_tmp;
 				bio_set_dev(bio, bdev);
 				bio->bi_private = req;
 				bio->bi_end_io  = vhost_blk_req_done;
@@ -314,7 +316,7 @@ static int vhost_blk_bio_make(struct vhost_blk_req *req,
 			iov_len		-= len;
 
 			pos = (iov_base & VHOST_BLK_SECTOR_MASK) + iov_len;
-			req->sector += pos >> VHOST_BLK_SECTOR_BITS;
+			sector_tmp += pos >> VHOST_BLK_SECTOR_BITS;
 		}
 
 		pages += pages_nr;
-- 
2.25.1

