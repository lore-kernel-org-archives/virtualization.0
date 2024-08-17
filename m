Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D3CBA2D
	for <virtualization@lists.linux.dev>; Sat, 17 Aug 2024 06:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723875941; cv=none; b=U/lbC6cJMtNyJyF2swRnm8k4ie3ruR4OIf5H0jzZRnM54WbVfFAb+dnhPhzoQ0ohL/RZfKLRm0m4mX/BJv8CoLKfFJYoyuleKm+xYTcCUegOj+YVQ6XIYjmFIKgGt2qfn+i2dPP2kCM4k26XF6zSfEjZf8RXHB0gJvfpwqTEItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723875941; c=relaxed/simple;
	bh=j8TmWYZ5AqPrE22RnKJHbiVEX1QhW/f0MKWiEEz/HDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpDulC9TpzD8Jr+yzDnM87WzG7QEbhest05HWgAgg0tGgkmKE0jhlAeR44K0mwv1M34+tUhHo+04qxkqcvt0GWA7a44EA9XlMLy3ZqeIoLELmft0XDHIt63zQr+dTUFo3bmxbX8/jT1MQ5to2naD2DC6Kyh00xrp0dSmPoeIx9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZXj7S28; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZXj7S28"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d399da0b5so2287749b3a.3
        for <virtualization@lists.linux.dev>; Fri, 16 Aug 2024 23:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723875938; x=1724480738; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2X4VWKinXEGDbq8ESQflLvHDAModiFDrwO/8XuMbq2s=;
        b=jZXj7S28e34tywK5tL8O3So1ePyCcFrxaji2ukBq4e4AgM93GMNXSeXEYvHzz8xP1z
         oR3ivnd5yGAY2ksHyjWVOTMRpFv46cg+qXzEya1B+GaruiL4JMc+sfsemHMr2vD10ArT
         ejKLc4dSzI5ydmHnx5UCBrugdZA2zSMXZCry7P5dntKOrmYW9gNol8Kbcd9Y2wxt0pgp
         LdbBWRsZXiie46KOgFB2UJ3BMeEKkT7PJjh1AqORM+jg2yDAPYbvHMM/SdcFrTbPw2DE
         akY8jXz7utx+tlOW0ttUKOesAqY9xmeBAfHj5x58qPp72DyVOT6L3zmhxfNHRsBPZZVw
         DjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723875938; x=1724480738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2X4VWKinXEGDbq8ESQflLvHDAModiFDrwO/8XuMbq2s=;
        b=cqrKQYLreWTNPzwRgJFgR6abJPIEf9j+nJZkVjwsqIftKC1f/VvYHVIjRqSu9iDSOf
         OuJUlNp+KegcJBGvCF9uUvbPKysR2nMpQEaX0WfAEUYTvq2yb/opSevYMJW0hWlYqUJJ
         tqEdB+ANm6MFWCRsjOZVvJfTFZzVdV+NxLcZ4TUYq88CV+r3L9vnJtgHUGI8AG+kObDC
         8jkT+zYa9NmwtDJxhEClxrezZMvjsG8zSDf9wn6Yef9Bp0/+c60OGvfixlFS61G8MHNU
         jPs27fHf427BgGD7xPb3CZ9AyotjdgitISECL4HzhhshcNc8jFVTbe6PhIaR/a86uZTw
         kSsg==
X-Forwarded-Encrypted: i=1; AJvYcCWbVPrlSa76AlSqKCQkjdx4yBXYa7J5aMxb9xNQc9EelHgNDnBKizd3NllPssddt4oyU55QKEY4TwufjSBvDuO6M5G029zzWLzBm6n4zDM=
X-Gm-Message-State: AOJu0Yx74YTXsYldcCX7sJhH1/p1/9QBfiXF65KipyfhiJ7UXH+CpDs9
	943ZmPIZpFFdnch3pBvXkjIWKqAMrXwfd0FnaXRJAXK/OZpLVuoM
X-Google-Smtp-Source: AGHT+IH03FdwAIY4AWVv/BXRCCz7Wo0n+PGDGc1GL3fnHropqxkM8zstDmcU8MGBFc9GOZQKQEX2Iw==
X-Received: by 2002:a05:6a21:2d84:b0:1c6:a680:ef3d with SMTP id adf61e73a8af0-1c904fb55c8mr7273628637.28.1723875938269;
        Fri, 16 Aug 2024 23:25:38 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:fd84:292a:c6d0:8b67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac854f3bsm6768404a91.51.2024.08.16.23.25.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Aug 2024 23:25:37 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: 42.hyeyoo@gmail.com,
	cl@linux.com,
	hailong.liu@oppo.com,
	hch@infradead.org,
	iamjoonsoo.kim@lge.com,
	mhocko@suse.com,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	torvalds@linux-foundation.org,
	urezki@gmail.com,
	v-songbaohua@oppo.com,
	vbabka@suse.cz,
	virtualization@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v3 4/4] mm: prohibit NULL deference exposed for unsupported non-blockable __GFP_NOFAIL
Date: Sat, 17 Aug 2024 18:24:49 +1200
Message-Id: <20240817062449.21164-5-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240817062449.21164-1-21cnbao@gmail.com>
References: <20240817062449.21164-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

When users allocate memory with the __GFP_NOFAIL flag, they might
incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc.  This kind of
non-blockable __GFP_NOFAIL is not supported and is pointless.  If we
attempt and still fail to allocate memory for these users, we have two
choices:

    1. We could busy-loop and hope that some other direct reclamation or
    kswapd rescues the current process. However, this is unreliable
    and could ultimately lead to hard or soft lockups, which might not
    be well supported by some architectures.

    2. We could use BUG_ON to trigger a reliable system crash, avoiding
    exposing NULL dereference.

Neither option is ideal, but both are improvements over the existing code.
This patch selects the second option because, with the introduction of
scoped API and GFP_NOFAIL—capable of enforcing direct reclamation for
nofail users(which is in my plan), non-blockable nofail allocations will
no longer be possible.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>
Cc: "Eugenio Pérez" <eperezma@redhat.com>
Cc: Hailong.Liu <hailong.liu@oppo.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 mm/page_alloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d2c37f8f8d09..fb5850ecd3ae 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4399,11 +4399,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 */
 	if (gfp_mask & __GFP_NOFAIL) {
 		/*
-		 * All existing users of the __GFP_NOFAIL are blockable, so warn
-		 * of any new users that actually require GFP_NOWAIT
+		 * All existing users of the __GFP_NOFAIL are blockable
+		 * otherwise we introduce a busy loop with inside the page
+		 * allocator from non-sleepable contexts
 		 */
-		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
-			goto fail;
+		BUG_ON(!can_direct_reclaim);
 
 		/*
 		 * PF_MEMALLOC request from this context is rather bizarre
@@ -4434,7 +4434,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		cond_resched();
 		goto retry;
 	}
-fail:
+
 	warn_alloc(gfp_mask, ac->nodemask,
 			"page allocation failure: order:%u", order);
 got_pg:
-- 
2.39.3 (Apple Git-146)

