Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EE62FF660
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318823; cv=none; b=CDioFsVKGV0hep1WvO+1tlCCzY3N9rwRKqJW9dv0XkBtE3wezmpS5E48AYt7Tr2DU1OgW6DjJWUsY7VcGH0S7JTd1Iu2kDCPA5ouOzDXwJvMx4rawqGD12QvdpZ0gqAbCTe9o899m5Y3YwvWPs0O+kbashn9CJ9JR5XfKXV8CoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318823; c=relaxed/simple;
	bh=HTuaf3JKiz2KHLk/jbQPL7NkOb05byK6j+tq4J3zrGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qFflAwhAaRI7kh5DRGHpoxLVEnO+Yfpi4Ajs6JLE/o5eTnzYYx9ytbj/EEgbzGboFn1+hzwBZfqFDtBsSklIcORzDdiRJe540p3B8sbwdzGq8zlxD6nfvPq+06ddSD2ScByJKgGTd47jyuGk8693y5ou1+rDoKbRL8ykOiinUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYJ7GAme; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYJ7GAme"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso942620a12.0
        for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 00:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318818; x=1764923618; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JuZTiXTtCfnBMrxTr4djU8x13PVqvGl4QPuQVkzEeA=;
        b=SYJ7GAmeEdS8ECds/Mx2umdfnzhizauVV/jrQ3jwPmuX1L+WvRK6172NUEKe01eVcS
         dT/D1EXbpemUIblLAUGfHxPCWaT/vOEPR4VDs+FV6//OVcBXcBzjN2htjX5t0UY7j7un
         6HYJaMexBEAjekQWHBx8As78AdDacsNhFoEncV/WltITY7speVDSb7CwWw6I51ER0cwg
         BKblSgGoMVb6APfwiBiiAvheyD+CPe0qURr0THAo/39yRNgoJdVbYp1COmPso+NUK9IF
         GCM06OWuUpjtsl9IaYZ9SF4TmWsI7rdKZA8s6RWUjJ83WEe8gA6GVKcmWVUHTXQcXAZg
         y4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318818; x=1764923618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9JuZTiXTtCfnBMrxTr4djU8x13PVqvGl4QPuQVkzEeA=;
        b=Dcy3XKYAE0n2SXlV2R04NP0rN/ahjGet/ivJT9HXpHggB1OUt2upUl8rxNv3ABh+p+
         FId/IApBv8pnDfHVB1oewRhmnZ0dn0kQEyro0Og4O73b15iIeo3oXFg/uHvNmwpl0QYA
         NOE/ggVQfqKUGNUjTc93bY0h4/SW/r3qv4YKlMipPKCn+/W671VmyY5JXblLrVkTgmYh
         aXEXVk63+d0mB4KehLDhPn4g/dpFOno4RwO0uJ+zDS/oG0G2SSfn9Fp0shwSQwfUVEIi
         FPqOcgu6uTH2huOos221GgBMxA32Z5SahkdPsvCNpYf3p91jgzx7bgzmVxBEgbkaarWj
         FH3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWm3opGOGRKPPOcAjCcK8uRK3jOP+zxm5ObKkDYkq1PTbv1owPzFC94GK0wmbUadNAQEvamNOPvUPr7hZliGw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxo1sW9YP/jUwME4L0BchO5hT3XvTtORGk887Vy83CBVXOU3+Yp
	lr0pMGYSXkUsBzeYuVfQIcqBPLYz25cNaKmL7JJTRRSNw7q6Ri+aZ/pX
X-Gm-Gg: ASbGncuy7KMZ0brWb8ruqPLTgOi2HJz0OMDzCgSsM1hQd6lVNS1Q4I4JGBotY32xn4J
	Mfb39hNlOxh53diWjC3t+G8e63Mv4RQ0Z5WKFpxcTvMsSOUGNWBgtUT0wlClqdKRgfPI7d+R+NM
	/F7B6cRrC6GwWi1GpC5MrYfLIheNgtdAumkNtPdRc4SKCtOk9p/VcFD0xbE4Yd0CHD+n6yJInyB
	yCcoLWmZc3KQ3KOa3RJwdipxI/vVVGY4ipEXrXW7M3b0q+s+YqIjOlXkezvhD8CPm3kPhNmSWBI
	mt0On7khDjB/eRZHoNsnkJT7/zm/JXj6q6xTK1bmDtVQyAa9yKyv2dFgtZ1V2x3bwtrEN+D3WXI
	u2xavO1MkhhBZhqx7E0fD1gG/uSYnLjWCTGzsxYMkUf8/stIwREWa58IqIsV6yEUDT2b+QRu/sJ
	DE/lp7bXyIa/opDOvHH+68Gpe8CA==
X-Google-Smtp-Source: AGHT+IEiYKFOm1UmbHzu9Io+L0ipF/pftCo6ih2XEqCkxPLrZNrFMt6HrxgMvpe9BJ/P01XRe5CPUg==
X-Received: by 2002:a05:7301:162a:b0:2a4:3593:ddd7 with SMTP id 5a478bee46e88-2a71953bfaamr12018765eec.4.1764318818087;
        Fri, 28 Nov 2025 00:33:38 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:37 -0800 (PST)
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
Subject: [PATCH v2 12/12] nvmet: use bio_chain_and_submit to simplify bio chaining
Date: Fri, 28 Nov 2025 16:32:19 +0800
Message-Id: <20251128083219.2332407-13-zhangshida@kylinos.cn>
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

Replace repetitive bio chaining patterns with bio_chain_and_submit.
Note that while the parameter order (prev vs new) differs from the
original code, the chaining order does not affect bio chain
functionality.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 8d246b8ca60..4af45659bd2 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -312,8 +312,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 					opf, GFP_KERNEL);
 			bio->bi_iter.bi_sector = sector;
 
-			bio_chain(bio, prev);
-			submit_bio(prev);
+			bio_chain_and_submit(prev, bio);
 		}
 
 		sector += sg->length >> 9;
-- 
2.34.1

