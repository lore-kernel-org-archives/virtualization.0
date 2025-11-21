Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4360633B6D4
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713096; cv=none; b=ESXiUjTRUFz6nxcpaeA0aSCbuQXe82jqLv4kuvhyqox4y/SJOvJ7uiAJ05zWDQnt0hJSiFzDPBMe9Ia1C6hhkFlZ0QFMNJvoEX/Ng+etO/LeLSqQVh7BU0z5XxE6QruAnW4CkqUvSwdMP2VuEKnVT4TUeS01QneZONtnOFVvIdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713096; c=relaxed/simple;
	bh=/P1RYgORKxwE9EU9V7IqZbnP/9QJ+9L8NguSmQu/jJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NX60KWvlUCkUB8KPNhZdOU6o3Z0aVYlRnc4vm8zSxB8CjOnuV28ckRg9CQqz+nzSrOoNFi3YkV1m7Mwc0qWnRnmg2gZo7zY9qj3AmiHHU45fRIKtHtHqPJP3eSpRzCU1/1VSfBWIEdafSUBQKLOUV3p+SG46xtIvf/2mQkJODNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ux4cdNZh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ux4cdNZh"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297dd95ffe4so15293005ad.3
        for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 00:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713092; x=1764317892; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2hQwsn6Sms438Pv0Q4ngdJSSkLE/b11prNvkoKJDYo=;
        b=Ux4cdNZhOIRxJHlRCny6td3/DzWatVslk3asCxXsD2aD6hdz59p8GjJP23zVwuMilf
         N3ga6/vIFhOb5/IW8NXv4qgP8wl694CafA+Mi4pOM6dhEp9p8SCrrukojIykaIo7ZKva
         uuFN+9KU9ithdxb7YuL1ajag6EWwRkqkexOpmridCxuP+6CIBSl7Tg6IrEkMslZj/2Hq
         19mgbnDYrCSFi3W7+U7vBkVUziM0fRiKR/TK7V2hRvOlJAZLsMIXwu8LAZThNrpawnUS
         AwR3d1PvjaTw9G6y+ljlYiv6h5BgvtRv355eaNCeL2EQSpHZMaTFKS7hNw98rfWqKVC1
         B74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713092; x=1764317892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/2hQwsn6Sms438Pv0Q4ngdJSSkLE/b11prNvkoKJDYo=;
        b=Q9IHgJmnQFlOkAyDzsW3yTtNWfvc3CN1WlSVJoW2Ct8QPkq4PPJkm+g2m+yxE+UaJR
         KPiXIYxxahqWuWG7sDWZMtY4TdEEHPE15nglHAysTlQFHoYhdEt7/IaWIs8ti8IM7dTu
         UP383yQeipl5CnvagJd0lcDnOiOV+HOl4F8JwjFWQwQVkBK12KReeyDqb3XY42C9doD/
         UHmNz9ZJhtja5rsBSDdB04iTGJYecSEKDQdzmM89JpDkYAJ5DrOIcb0F7vGm+tdPKCT3
         YqsjEGLEES9qsx1Tewx6IvSkfLQiWSW8pSXJA1N6yXOrEKLjOayFjKFeOV83+6s5FBqM
         NOXw==
X-Forwarded-Encrypted: i=1; AJvYcCVMDVW1s69Mfu1E23XDHHCq7PNZIIaU0sdmEG7zs7JGtMfCE+KQDF6MRC80uswfEK54AZ3lnW5+2goXxnf4IA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIQJN3OpF9lHDSZq6tH+N0NoYY6HIOCZU1sU5QWDO0kkUvf83w
	TibfRmOuwM0RMwXhrbCxbg7KlZaIK6wN/VQviLFh9QiXbtbkfRai/JcO
X-Gm-Gg: ASbGncva0OQiC6t4sPNUwoKGpU5oma1hzMBnJh11b4lM/49fQj14WmlhBlkwq4BIEPs
	WxXKbMwwPH4NW103tp3fBk3sWtKH46+61DsHnv0EpHY8TmR7o9YRlisbG124yncNQbzQgKwNs7z
	w0dW66gsC+WB8BRD1k3A8w70mAmN8GUzwlBTRRgeYQMyOvIRGUEGSYmUkD7PRLNkwrK3AZfO+PJ
	Ig5R9scYZfyXA6lOpkMDn49ftRylgD+eGnQBzBrYsy3odIyWAjHobdemQEK0oRiGi7bBqKzU240
	GBCo6k6IFTAtiI3jexFlchL2PnVoiW1Nz/BpYC0ofrciRo65YtDquayrlY3eN4N0kHrmjgJOhDY
	/r+wA4EPLHusk4YsBxmLBu3mKDdWIis2WbDo9FUIY9c+xFm8+zYB8YcF3RRsOcnVx++bPZWTeLW
	6M/EJJc3JdOogaIoePBYvRvcMKhg==
X-Google-Smtp-Source: AGHT+IENbSLlagXc9NX/smNIF96UgKjh9NXUi+KBRvhy18+CUMO6BxslQvGRE/2mRUDvnGhRtmvCRg==
X-Received: by 2002:a05:7022:ba1:b0:11b:b3a1:713c with SMTP id a92af1059eb24-11c9d60d20cmr498283c88.9.1763713092239;
        Fri, 21 Nov 2025 00:18:12 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:11 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH 2/9] block: export bio_chain_and_submit
Date: Fri, 21 Nov 2025 16:17:41 +0800
Message-Id: <20251121081748.1443507-3-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 55c2c1a0020..a6912aa8d69 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -363,6 +363,7 @@ struct bio *bio_chain_and_submit(struct bio *prev, struct bio *new)
 	}
 	return new;
 }
+EXPORT_SYMBOL_GPL(bio_chain_and_submit);
 
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
 		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
-- 
2.34.1

