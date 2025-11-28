Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8652F1FD0
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318780; cv=none; b=Xsvf6DoATrVe4ql5aWlvpIBDAP+WpX8rw3qdWk4COWOJu+2V5HzZrVQ2OIgr6zo8dbtdtNaMXgBJjyO846IBCp+2bxK02KUwcJXqmovZ3nSsFp/FnryMtlBn6TT4G7ydOlz17BLUD49JfwVqash8KDTuSiLxosVlESGZaGA7Jgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318780; c=relaxed/simple;
	bh=XfGf+/4TH9UT7Q+DEbtJ2829MlGgMcgOkxUS/OB2JNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LpyR6jPqsVvRxIG9qeVNKO35anLhhnSR3lNca7V8B0tlBjYyr/hTFvABwzs6t+hSvXCGxA/Yxg2Vg26ntS74Vmp8xvRkr5RQkXXB0OuX9OeY/QQMo2Mseod6/B6f8LYVsblvm3HnOdq7dy3r1HYu7Njqe1gdhdwpdTNM+SZH9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYLy3d6l; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYLy3d6l"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso1827490b3a.3
        for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 00:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318778; x=1764923578; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgav++xVu99AZZZMA2bV1F+Nxhf+A3QsmIfb5iyDR/M=;
        b=AYLy3d6l8pqS9y3rV+T50YmF3ZamtXqnYS68ZgS3dl0vYkV/CGZa4/lLxEI03UkEI4
         1vfV8VEkShbVDBjLcc/zqPqzZchkVqVJF0AfPlosBWpYxvA183NsvMV/aMc8Tojv0bGE
         LvAP2qTNnqkCXP3LreqEty63ALemME0sNFZzUW1rdb6S5ukvjxPf6qIDB155lxsozTDR
         BxmLo05a74H4OtJ1gz7k0IFvKOXuJVIo+flLwWMxIBvckk6AB7X1bmkPYwPBwviZgfTH
         yzBCtuHbBiadaNzPk/FyZXXSHlznsoa6hyTAhoUnkq/ZEmaY3gymtfSq6aWW6ZJeNRiC
         HD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318778; x=1764923578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hgav++xVu99AZZZMA2bV1F+Nxhf+A3QsmIfb5iyDR/M=;
        b=WduCdlFxod+FYL0fXc8jU99q2TA1y1P9BCzHUhgIlqU7V3zAomxniULzUycWyRvPlE
         WBDCINliinq0qv0FZLa9wZAccoLa0w7n9iZAxnTwn5dWo1zo4ZFdtR1szkQUgZZfDYSB
         RddNRnXpGAIHXhWbuqCdubXzY0DEFlON1aJWJ4PsfjfZomu4TrPUyNJc0PqjO5gbr1OL
         vElr+2Y2OH/DnkP2pZJNy6FBr+wyU74RcrUjnOp4C1Bemd4tQHdm433RZn8H2a46saIR
         fNz2OGQQlxvBOBj0lXUQCdXCAbnZqoxAfG6xNWNhnEudzA2Vry7PlhOm9/IWo4OIc83/
         Znbg==
X-Forwarded-Encrypted: i=1; AJvYcCXdqO8abNBf4CGgYPkFzAG6zewRRrHxnG+A783mtyRROY+YCy6PA40mtMO7v5uHHy/yqEDukkuKESgr8GXrHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZURGnue2eqEUi1RfdIcNHDz9KkkAN8SlJ25N5ko6Ig5qkcQT1
	fHGbNt2h3tFZTA7TaHf5JEhxpryX7LHvlsoJYoDxNqTGLa2mSkGFMZcO
X-Gm-Gg: ASbGncvSAUzUIzRy0+yi6feigjCSb/4bQgreY2POrsd64y5S9X3b/mAZTOj7ccK+cA6
	2ZbrufMdgrwoxrvlrfkYSQCO3YoyogBYbNioiqDZUUJ6kCZqwJtT4JIwaFv3954/9ejmP9h8Xdj
	zjFU+cbvAxY9sHobgWtf7k+oCMo+5nPNM6hfOZYsVsuQsBE0AgjKr92hhn5Zkyl5DKif8oXUZld
	Ub2st5JfvCz18vooNRwsCmPg2U+/LyLntIKnEN1MFIKLy/vUm9cCl7LKf70KhqsvFJQWoxccWLH
	e1PcvSrwVo8Xb+ql5MfNKPAavfZFmn+kIIL6XW8ODtug2e9gci2qqJCagW7CtRx0YyQaLd9nEsw
	B+wkFqzQgJJnexmfalKsjwbuM5cb88JRw1cZEjCT0dOCQp/odBi9elnnHpW2jesqd73qSxx/qUr
	eVlWOkiO/nCQ/qL5OdEWnBafQLdw==
X-Google-Smtp-Source: AGHT+IHuO0sAEeNowy1+oe3IeEgaIYQcRN0FMbygDOiWMPQmdT1sBtyBJY7y0vyzVSrhuxE7eNWdhQ==
X-Received: by 2002:a05:7022:5f0c:b0:11b:88a7:e1b0 with SMTP id a92af1059eb24-11c9d8539f7mr12036129c88.26.1764318777892;
        Fri, 28 Nov 2025 00:32:57 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:32:57 -0800 (PST)
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
	starzhangzsd@gmail.com,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 04/12] block: prohibit calls to bio_chain_endio
Date: Fri, 28 Nov 2025 16:32:11 +0800
Message-Id: <20251128083219.2332407-5-zhangshida@kylinos.cn>
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

Now that all potential callers of bio_chain_endio have been
eliminated, completely prohibit any future calls to this function.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index aa43435c15f..2473a2c0d2f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -323,8 +323,13 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 	return parent;
 }
 
+/**
+ * This function should only be used as a flag and must never be called.
+ * If execution reaches here, it indicates a serious programming error.
+ */
 static void bio_chain_endio(struct bio *bio)
 {
+	BUG_ON(1);
 	bio_endio(bio);
 }
 
-- 
2.34.1

