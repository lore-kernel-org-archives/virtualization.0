Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2606B2E6CC3
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318765; cv=none; b=Cv7SUil67xkl1D/635VTNeURyCKXkGiYissBpFCf3A2/8g1a7KLwYC1Gate/mhOQ0o/UZqlU2noTwUHGZ/SHHFKEnkBjGkKJ7Rs72TyeNhkNHRGp3sgc2wBd++yi0s9Di4UfOiMooMF7jYD3M0A1ZYys1lN6ncYSAx+lV18QR8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318765; c=relaxed/simple;
	bh=nbYby2EM9de8liKCH6EPXwLAr+CXSG8jGQgCdHY1huE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n4rwibzc1cwO66wQiWoFspK68W2NsyQz/h/OMBzU5PjK4Mkfyzuik8CrKzYHmNxziIS7YDJe7f381+gAReT8pFRRkdAepeWS0mtMdP+DABbqMz+kxb+l9K3f57V1yMmfhuLTZhND+0lBv3w8Lk8NiMW7KFE+Lkkj/LkJKD1k324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3BtgFLq; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3BtgFLq"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so1864640b3a.3
        for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 00:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318763; x=1764923563; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEXNzDk3PZG7Vl6bACrm82r4Ym6fDNxq87feOMpROvE=;
        b=N3BtgFLq/cvdaTHlVBJ2zwKAGS734L+NqR0I+kXcichDYbnjBlJjiURhOHahW1oKjL
         DbEF0raZm3LgoFJL+gpA5O3PU3k1gLRs/IiWClPGJgP31coEUAolCu+lwb92LlB0LrP7
         +Yw+IJcsyjhfdn4Eg7zLIp0QMvvAtkwHvUnJk7BVwpcIS4tDUtbHs6wobiDET4T6pOjH
         Vzq6PENS5HQ21n4EbxasHxfYEk3EV5rvZpGXsLGDT9HI7fXWAwR1QUeexCy95VqstBUC
         7qhaFiOz5GYvG1yHaNFW3Dz9uGSfENUIplIXP+XklRMYJ6m17jAWUYhTBcc4TLjCdN5y
         YgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318763; x=1764923563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wEXNzDk3PZG7Vl6bACrm82r4Ym6fDNxq87feOMpROvE=;
        b=dlmKxAu2CkDMpqXWGyw1bb+oIXLUSJ9H0tDyzFth5dvrhCN11AaDzWsnC65URRVz/j
         ZE77RnGD/TXkXp7Q+XLRYcrS10dwpc78Y65kSieW02GQtznHSWvrEZa4r3TEVEAckcuc
         gjVZ/XMeN8oIC8/qAVkksCZQzbDK0x2Y8dRiVy+MKIkVWR5Po6VE6zmab++4NS4xxZAP
         A6kKm4NTNXwSiLLvO8aGxtWdxT3r4+ZlUEI4geuC2+o+4TiIEXwzNYAiMT995QoGUQ8i
         d5zzDYsNW1dpAzIVn47jFeJ5w1U2OmBGgNTe8/wpzUq4BD41wAcuMsbr2EHXoLEYYD9j
         Yu3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0r8NqBBdWMd9f09xcLZfGvytKqSgyBL9glQPZqkDeZxC40sa8BZ9lGFN2eh8Ruv7xBPRdoG43bMiWKfaOCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyN9nehTzDJAig09G5V5cXn2gDRiwtnG/khCSZOg6YNWjyTOQCq
	QF2Bo7PKEHnl6grLN2rCKwA7Ex9zVdAKs83Xj1LIflum5lfaA/Be29Um
X-Gm-Gg: ASbGncsWxVbS3RN71XwPmEC7Y9adR3K5SazJm1+eIXhIGbkMZqOEbqMNB5D2VP9wgw0
	iIQGZubQ+5o2C/dI4gDa+pVSfnZ3KIkAoUBEclGZl7iyTrQc7Tx+Qt3nnV1Y3nl8joesQs754uF
	tGsbljAQut4sbSfTBL4vQA5YHwuObn+yhVVZ6FUMXu3+wQOuLh36zqZC4Xub63uK5TyzuRUeIZQ
	rH+yf/B059NbLssbg6yoF0Pow4lqsY+r82x5EGhSRZV4aDnAG8KVOouf3WsGUv62iYcfMtCCFal
	RVn5E0ICv4nKoD1MHnu2LyVofnDYtuoP+tyemuzYx2WQJOW3Bv9CkDQBQLQv+Kaoi8bMDu6fNVC
	v/beFkAaPYn6SS/ruMrZmv1ChuaTDQCtkcv2zluLO6L8gZWxeKbg2u192Jy1JkX25xyAYTfBW1l
	t/8Y74TxIYdtWQ7QZPJms94jy6XQ==
X-Google-Smtp-Source: AGHT+IF16ld9QNCqaVETJUBsXYjs2kY4Pw4mcEH3R6jDofKcar8TG/UX/uqF2Rs9fZ+s8kH1ElEzpw==
X-Received: by 2002:a05:7022:7f1c:b0:119:e569:f615 with SMTP id a92af1059eb24-11c9d712704mr11436137c88.14.1764318762983;
        Fri, 28 Nov 2025 00:32:42 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:32:42 -0800 (PST)
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
Subject: [PATCH v2 01/12] block: fix incorrect logic in bio_chain_endio
Date: Fri, 28 Nov 2025 16:32:08 +0800
Message-Id: <20251128083219.2332407-2-zhangshida@kylinos.cn>
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

The `__bio_chain_endio` function, which was intended to serve only as a
flag, contains faulty completion logic. When called, it decrements the
`bi_remaining` count on the *next* bio in the chain without checking its
own.

Consider a bio chain where `bi_remaining` is decremented as each bio in
the chain completes.
For example, if a chain consists of three bios (bio1 -> bio2 -> bio3)
with bi_remaining count:
1->2->2
if the bio completes in the reverse order, there will be a problem.
if bio 3 completes first, it will become:
1->2->1
then bio 2 completes:
1->1->0

Because `bi_remaining` has reached zero, the final `end_io` callback for
the entire chain is triggered, even though not all bios in the chain have
actually finished processing.

As a quick fix, removing `__bio_chain_endio` and allowing the standard
`bio_endio` to handle the completion logic should resolve this issue,
as `bio_endio` correctly manages the `bi_remaining` counter.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c27..55c2c1a0020 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -322,7 +322,7 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 
 static void bio_chain_endio(struct bio *bio)
 {
-	bio_endio(__bio_chain_endio(bio));
+	bio_endio(bio);
 }
 
 /**
-- 
2.34.1

