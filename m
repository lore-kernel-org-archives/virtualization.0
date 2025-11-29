Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17512737F9
	for <virtualization@lists.linux.dev>; Sat, 29 Nov 2025 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764406907; cv=none; b=Y28siFWNSn6jJuUJ1uq3/0KQ+ODFksOdMtWAOYdwo7Wh9wpm4VWDWXuMcoDhE6Vm/pZ3UvClc8aSpf4DpjvMwVvz3yH9gMZWoZVT8VdfxywkuYNL5+eIJMBmULMDkE5cNtdv12YsYkwAi9W7byB9TFyiJxNdXLmM9fp5F4IHUPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764406907; c=relaxed/simple;
	bh=jExYI2jaoXiycbQo0Q43ubPRMYOXkZVZRm5nOe4POx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fOhfgU8rKMSNITWGp7ETCvyF/pT4pYDWX1iqkU16LmIkrhIrdVUj2VbL+HFx+uX70r4ogWH//S2eTNyJWU1fIo3fEi2FCa3j+vaPXUj/yyMyVe2/ZF9fISyr7TJCe57N+GdeYNlBiFmrEGQm5SCKj9YRTxzcllrqzVM+z8lQVvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=in2La/Yg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in2La/Yg"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3436a97f092so3171655a91.3
        for <virtualization@lists.linux.dev>; Sat, 29 Nov 2025 01:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764406905; x=1765011705; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06c4CDfEOBNFQOCEh49v+FDqCuxNhXoe5zY9J+9QjgY=;
        b=in2La/YgG5cokcEGw9rEvn9aOJceRQPBAwry2vn+vlKpRsswVXek4p3DyF1GCEgYrc
         rg3KSRCdwxBuTeWHq6XAy+9B9iB9xKRPNqm4dsI+5AdEycq3pQMcLLEIF2b+LMpJg7zc
         TW6epimDM4E/0wLFfZdDF64VK9zhVvR5EMo1HYZ9h5QZp39VQLB6kj/k50kBL2GJVYOc
         iI61wJ2yj4ZbCWv6C0zYDY5RoMdvB6iiVvPxj9qddUw/EdCeYVRwIBWbrc1L2dXNbTlu
         5sZyLrYj3fy9H3DNsQYxUi/SH80CLUe9oT7W+8+0FoIJDjjSrhyo/HTcTMJzwYnnceza
         8U6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764406905; x=1765011705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=06c4CDfEOBNFQOCEh49v+FDqCuxNhXoe5zY9J+9QjgY=;
        b=CcsZd2Qrz64vii/geK/J1EpXyfOXA0XBEXNmGGS/qim0//lLJHEiNkiW2dbWsZo0mn
         Qef3OE5VhcdyUq9s4bEb8LVLgQThxcxXbWsQM+ZQHYLeCvWzmeNjRQclnExt2GuNnur0
         7yXD9FATmSl/aOFuEUnEouoqMTD1aVWlsE72kKO/5SdBievTRt93L5YOnbYKG7AZyvvq
         qiFr2ggNBeL0cc0+R31/a8OKC0HcJHemgnhjEQOa8p5YvBOtegE5yzvL/39VyA0hXvA9
         BhY6M1NoOHarrm8uQLPy/7d4ChigkHRia9yVbKzmv58UOBuQ3J+Hsk7UcIMxE3FnXoZd
         ojlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhjW84o3TBL+QDAFmYZCZbq9ni9+uEnGvANn9Q9hoVtwRLerqX2yommNm4Z/WKr2G7EGti2nOnSXxawmLeFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOhE8asVkxq5au5bhuFk9FDZ2zBraV7VSRIj/+uE52plQVy4nK
	aBlpfVqYb/qYQgqzJu7DCuifO8gqxypg1FAr2VWR7JhSA4EsSNal0Odt
X-Gm-Gg: ASbGnct9LsPfJP2641HbEK3HRJokNs9DYhHbJ6M+BFY1c7B2i5bWIFWLtvi5q22FBky
	uiR9QWNkvJ5lrCZYgksmEyXGD3QnUYfkQ/kvYsfW6VBvVqvnbtmbaj5BWcoO30U+DmQbXGtQCMm
	4pFzHVHBtP8qW01e2LzvP1uxBKaXt2vaVr3CLgi8IGgdCLhjThmm27DImdmrq/lxfxa7cTWe59/
	0ryzr/q+5hIbDk3MlBcv4ujA5ppv3hFplNseXKcACVUYNlygZycSj1+PpZQ/XNaHPAKXVMBBhc9
	qtED8GSpsfYmUy6GlZsesmg21Hb+3W9CwgpuuHQA0duV2+OYVdKlIfLIU01LdMAv9TTIriq6oiq
	x9H+aq02VAECs7y5APwhi4Lok05GZG7SHXwSxNG+3W5HCJ1idgHt13T4T7bi7p7+QhdOBR813Qo
	BpM03CXOvkS8WOS4CxDiZhswUH7Q==
X-Google-Smtp-Source: AGHT+IEFFhMF6u7tNXXwfE6dPq1pkaM+HsOKRV95Dom9e3MOSpru2Keq8NWtpHMva0MzTN1ZATf4vQ==
X-Received: by 2002:a05:7022:62aa:b0:11b:c1ab:bdd4 with SMTP id a92af1059eb24-11cbba4ab67mr12173129c88.38.1764406904816;
        Sat, 29 Nov 2025 01:01:44 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm28114394c88.0.2025.11.29.01.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:01:44 -0800 (PST)
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
Subject: [PATCH v3 2/9] block: prohibit calls to bio_chain_endio
Date: Sat, 29 Nov 2025 17:01:15 +0800
Message-Id: <20251129090122.2457896-3-zhangshida@kylinos.cn>
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

Now that all potential callers of bio_chain_endio have been
eliminated, completely prohibit any future calls to this function.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c27..1b5e4577f4c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -320,9 +320,13 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 	return parent;
 }
 
+/**
+ * This function should only be used as a flag and must never be called.
+ * If execution reaches here, it indicates a serious programming error.
+ */
 static void bio_chain_endio(struct bio *bio)
 {
-	bio_endio(__bio_chain_endio(bio));
+	BUG_ON(1);
 }
 
 /**
-- 
2.34.1

