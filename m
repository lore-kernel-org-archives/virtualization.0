Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D4927B348
	for <virtualization@lists.linux.dev>; Sat, 29 Nov 2025 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764406911; cv=none; b=Uf0EynDQURRjFgt6FsfsLjg4J8rjIzr6nQXcQMyOFT/6vZn/y9FeZwHHkDpYkte7Ts6/NbyaKrRM9oACy6QkX0TTTSblDTcnzqr8nvDrlLgsb5QYEM/b/aGfiQRHVrFu2bCjuGPmi5s5aniO4aceXaH43OTWOYm2+Q/1S+lmN4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764406911; c=relaxed/simple;
	bh=b80xEn7EdjxWTN/ci1ysQxp/kAR6AhTP55Nuwyj6diA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l8e9ZtKzBKj7hqZugGy3PtWNACa6Rh4h1tnHZuEv5cL+I5obH9yeacHQFh4NPxh6ws9aPttF1W0N77cBToaFtQOirvSGVUuh8Qv0o509FcrKDCQCnlOZDCTH4E62JsOHzXpIaIf0avA7o/p+iUXrswz8UzhW1HDCwc80VPay7Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLyrqbuk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLyrqbuk"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso2248170b3a.2
        for <virtualization@lists.linux.dev>; Sat, 29 Nov 2025 01:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764406909; x=1765011709; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fxHcLru6xJPrGlRM61sm3BLmSBVukho7BhSnyNPRbc=;
        b=MLyrqbukzkn8SamVb8Thn3xnr2bbO0XnWS/6TQQTg4yTWquuGrj3yH7GRCrMAyJBAt
         +2cZoQC4jtbPTuWQF4P4shPfcgMjEqf7Ooy2qYcVXYAHYk+fmQxubZzNFe0kbjZZmeeO
         VgSWOyLZkf5MPNW2wIoNNGrmz/dbr2R/1ZFMmaiQwmwfbhyh/zxEZNPp//0tmynEp91Y
         xFLBxLth+B8ycpWR7xKBgdR94fiZ2eI//5GSObNILUw3LxkVRJrFn+P79fX5Nv7FFtnK
         i2kRKZ7ZV+IBNDDaAVToknx1N2e9nv5PC8flTzNrUBzHoqE/biJPWPg37+Q4WU0uhAuN
         Ggdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764406909; x=1765011709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1fxHcLru6xJPrGlRM61sm3BLmSBVukho7BhSnyNPRbc=;
        b=WHdj3IfNcyJsZDne3f0XTpWFRRI907mpKoI74fzMURPQdkfimAktsh8TrLW1kgb/7S
         rDF4pH+7W2S6c+cMhN8ipqYSTK14xfXPwF8eb9QY33PMtEnV6AUhNtjylaV0f+5tPWkP
         m614/zJkZ80+XPl6HxPRZLcT4yhFUXLVW8XjpDCU2SjcZf0VUcMRxIR7AFFu9kdVlVLu
         jRLoBEUehZNjHzeZanQbs4mOG47eRjouf1PrLo/klIE80GrETrXnz1id2zQqFCo4vdOd
         mmEZp7iIehz5LvNJFjkxfHlLzZ2fweSPqJlzyIk/Z/gv1sfXGLamaskRu7oiuw7Mv9fY
         d5eA==
X-Forwarded-Encrypted: i=1; AJvYcCVD/F9rmX3WcKRsuKiTd6gzuEVILh3KNq9h9iSGoEl/xSD97LQN5OutW+3t2FSf5JQgaoWAPq9mHMiFaBd5Bw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyTY/OQ17KeUadCvmc8p+0Dae9fe5jGTL9TK9I2pbEQAz/9yrB
	OebHI+wd37x/7TfBn7YhSlDk+W4vV2hWnZwxjvD/F1Pqi938UoyQ+99cGD0GMpHyW20=
X-Gm-Gg: ASbGncupzXgaGqa8cQlaO1197hpg8BXbqlIP62qLsbJ5lsOPUsDPiPJQqIBdzNew/4X
	1olBamWR11C+IkSAO3JBmSML5YTuz6lyqW6zjcYOxoo+p1cn5Q1Geyu33YzZkJNvV3w2Im2d1ZG
	kHec5lxMzDYSOnXscp3sJf39Bj1EJ3WWw5V835gedkJW7L16unwowO2gaQ4x4xgdYQDS2uSS/4F
	zersstsW5VMy6AW6Krici7HCZfIfhEaFj+01Q/iKTNIwGQPSLghl21pSwSud6unCPNpihGsYrm/
	AJIvlh+cHMf0NwlSETC2DB+dH/3z7L5tTCQdJCbCHt2fb3/K2vjPAuXc0hpfzUcuafYvZvBxFmE
	ejQwCmm7N1pQIwG8qUUhs5Is0iyyCKGpGe7Yy1Aws94el8pi1p2Q3OsfK19df6Nvftw9ILKgaYT
	o+IHdfsS20KlAb+geYM6SHL0/+Pg==
X-Google-Smtp-Source: AGHT+IFEuvilLkDJGqcsWwCIedr283xueadWd1RQPKrotWNJSiN6yvq7rXU8DgdpE+SxH743dNudrQ==
X-Received: by 2002:a05:7022:221a:b0:11a:2698:87c8 with SMTP id a92af1059eb24-11c9d710498mr16125897c88.1.1764406909336;
        Sat, 29 Nov 2025 01:01:49 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm28114394c88.0.2025.11.29.01.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:01:48 -0800 (PST)
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
Subject: [PATCH v3 3/9] block: prevent race condition on bi_status in __bio_chain_endio
Date: Sat, 29 Nov 2025 17:01:16 +0800
Message-Id: <20251129090122.2457896-4-zhangshida@kylinos.cn>
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

Andreas point out that multiple completions can race setting
bi_status.

The check (parent->bi_status) and the subsequent write are not an
atomic operation. The value of parent->bi_status could have changed
between the time you read it for the if check and the time you write
to it. So we use cmpxchg to fix the race, as suggested by Christoph.

Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1b5e4577f4c..097c1cd2054 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -314,8 +314,9 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 {
 	struct bio *parent = bio->bi_private;
 
-	if (bio->bi_status && !parent->bi_status)
-		parent->bi_status = bio->bi_status;
+	if (bio->bi_status)
+		cmpxchg(&parent->bi_status, 0, bio->bi_status);
+
 	bio_put(bio);
 	return parent;
 }
-- 
2.34.1

