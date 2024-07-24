Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AB714D2A6
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811391; cv=none; b=h1oCYzTV9dUzwHZDQt+HNEcvQ2rs/jyVAvOxuAIbjGe71rpqkK1zHr7D8dMaHuubHrTrm48iHGGfaZCgR9jiNan9TEEIJdEkvenGasiWvfhh4J+Aik1lE5SagXhu87BBmOtRehvFJ4vRZb8M0TYtE92EqIUKkAYEa/kWDIvzJhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811391; c=relaxed/simple;
	bh=yaYGQq9TiAhkw/yYr1g3kBH0FZMAhrt604C0L61UsCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b9+spTSXElsytj+jCEvCon8O+C6/9hhwuNCTptcwkVyq5JVq1voOJIzfjAIWGT8v4idHnLmLqwSyXFIG4QEwEPvHAbsX1ClMQauAmcc3G1rYVKfowtOlFV+esOr1XQr2bKBObGC+iwWhLbQXS7Ap1I/nbvDsI3NX30BvgaLPUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFp8by7W; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFp8by7W"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc6ee64512so6844535ad.0
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 01:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721811390; x=1722416190; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaowiqzVj3yQOimauedr/ghucF3yzQBuOx7BoVz5+GM=;
        b=FFp8by7WYohqlCNmjJW+UJgVPr81b/ayHrvb88lDfzupLr838+9X6VFVolp4YbctTG
         so48rSwcpBNWtgTU7wwjcj80bctOgOebuxsnMYgWnO9yV1JEv1ibN3rWApPczhxojI24
         XQU7F1tOxisCO3WQES4HacDW4jSZMMXjzMzFBMjtV6Rwx//qiMldRUeI2I2ZgNtmerRw
         7z+ou9uv1kGtGFQ7sW2BBKYAF2TRyJqMScJFjAGmYzuguZMWG3FIuCbiejpgb/WLLXKZ
         y5oswA9IeoYupxQRx4Hgbfwt341N8zHOQVTy00rSvrRqQbZgcF5Es2aDbDskGqwxzBVX
         WSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721811390; x=1722416190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaowiqzVj3yQOimauedr/ghucF3yzQBuOx7BoVz5+GM=;
        b=HFGKdUVSa83i+OFL61aCqGstEatH+C5jcQd8LBRm/3HxzNb29kWPnHElrysbbR23Tv
         ZH8N8uTxFIz2BBoqa6l06EKZty1w9IOtUGweyhNsiKrglkZs8LK2d8510GRMLidlL+IV
         sJl2GfnqFPb5C7XZurGIW89MOe+KdR/zCUXzsFQw0SUzbumvqnIwJJsJFmoXwnR0BQKi
         bgqenRbhvZeVaAdqIThuerE7n3wdLdCpU/nVBEUAQF3fqWnAtw//vFfmPKcL4rg2OlTy
         24ydbxul0c3olbUk7LO6Wdg66bAJooPvz68Jb7sHOTlbUyYU4cnHl1VrvwbGL616SlHy
         ZJJA==
X-Forwarded-Encrypted: i=1; AJvYcCV/Z/XDpUFmUE0Ch898m1Ddrprs1fDhln7sF5cBw1+kDdJQMAMGy2z9c/r88baJbWRFE9VvdXhCFFQZsmet2dzVQR8WYcywYf94SiXa5js=
X-Gm-Message-State: AOJu0Yw12RYtdJ0uZwFmvJoAm/GeipBV7BTEOpEuK+7wVDwTEBtPnUnZ
	vddzayNQhOFGU3Pnmu8tbhRVDpAOO0+8H1kImBZzK/XY5RN9wgVN
X-Google-Smtp-Source: AGHT+IHBaN5zWjD+QYzelALbqfDtXFJwLgPdUHQr2nxg27JIeStuZsN5ZALjv5EKQtcBJytZ84SsXg==
X-Received: by 2002:a17:902:c40b:b0:1fd:d6d8:1355 with SMTP id d9443c01a7336-1fdd6d8198amr11561625ad.17.1721811389918;
        Wed, 24 Jul 2024 01:56:29 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31855fsm89021895ad.156.2024.07.24.01.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 01:56:29 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: 42.hyeyoo@gmail.com,
	cl@linux.com,
	hch@infradead.org,
	iamjoonsoo.kim@lge.com,
	lstoakes@gmail.com,
	mhocko@suse.com,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	urezki@gmail.com,
	v-songbaohua@oppo.com,
	vbabka@suse.cz,
	virtualization@lists.linux.dev,
	hailong.liu@oppo.com,
	torvalds@linux-foundation.org
Subject: [PATCH 4/5] mm: Introduce GFP_NOFAIL with the inclusion of __GFP_RECLAIM
Date: Wed, 24 Jul 2024 20:55:43 +1200
Message-Id: <20240724085544.299090-5-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724085544.299090-1-21cnbao@gmail.com>
References: <20240724085544.299090-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Introducing GFP_NOFAIL and gradually increasing enforcement to prevent
direct use of __GFP_NOFAIL which might be misused within non-sleepable
contexts with GFP_ATOMIC and GFP_NOWAIT.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/gfp_types.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 0dad2c7914be..1666db74f25c 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -339,6 +339,10 @@ enum {
  * recurse into the FS layer with a short explanation why. All allocation
  * requests will inherit GFP_NOFS implicitly.
  *
+ * %GFP_NOFAIL employs direct memory reclaim and continuously retries until
+ * successful memory allocation. It should never be used in contexts where
+ * sleeping is not allowed.
+ *
  * %GFP_USER is for userspace allocations that also need to be directly
  * accessibly by the kernel or hardware. It is typically used by hardware
  * for buffers that are mapped to userspace (e.g. graphics) that hardware
@@ -378,6 +382,7 @@ enum {
 #define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM | __GFP_NOWARN)
 #define GFP_NOIO	(__GFP_RECLAIM)
 #define GFP_NOFS	(__GFP_RECLAIM | __GFP_IO)
+#define GFP_NOFAIL	(__GFP_RECLAIM | __GFP_NOFAIL)
 #define GFP_USER	(__GFP_RECLAIM | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
 #define GFP_DMA		__GFP_DMA
 #define GFP_DMA32	__GFP_DMA32
-- 
2.34.1

