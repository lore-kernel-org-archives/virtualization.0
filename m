Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295082F2B
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 00:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722384185; cv=none; b=UshZEQe6RUElA02LylgaKFvHGYSrsBIzZJEnECIZBG0/nwR8JT66GYK7sNoAIh/WlOAvoEYdgB7dgZ8ASwsGkj/L80+vssFL80PtRrBId4r/eFgnH0xSc18CGhfrHQM9ygTS348WbPLjFJjhMEKxiH3UgjIpe7RicJHbQ8tAMMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722384185; c=relaxed/simple;
	bh=hSActZP29Z0cBjsw7fvwxbi5hgsoWsloHSSq6PMeFa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ssZysEb2+JMfz2t+HGLqij3PzRIzGeNwloKfdPUjT1oY8VeIkpm6BZa8O+y9jxLJ81ZF3pKnBnOprRs/Ff298e6GtD+pcNZZCCGWZpcGcQ5x4zOTABRgj1AgRlVtY0H5OE/fDia1QCwcInnxVYakD18yYAmHoe+/eg0YtDdVmA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEA6LMIF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEA6LMIF"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d1cbbeeaeso3707490b3a.0
        for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 17:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722384183; x=1722988983; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6IAlVIqmCTe+Zj/VuVI82him0OCvVTLcevbDuX4T7M=;
        b=JEA6LMIFK4maK0NDnodhgisWNhrGwOtH6PVYxiwmdnnT+5bIMwFT1KQlgSbBjaawlr
         mKStXEJo6/r3n/Pf7EWNA97XY5xmlvHfRNkbc53obPw7qpaE67XdIqF0XQ3y61Ru0J5P
         gdh3szcGzqgHQmTo36nG6wYM9D3PDWMpyrNWTRHsK5/GCxm3DcFXzhwKTST7gLo8JYB9
         uytn0cXoRuMwi0oIpZpWJYd443LYhy1aTDiUoZYZeckUJsWXShCBDH81pKaTqKOS2OkH
         lgUDdcgL9+SEl4gHgICrICYObQhxFyO5NkqM2+FYYCUniSzN9xOg72HSxqQPh2eCpGbp
         /T1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722384183; x=1722988983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6IAlVIqmCTe+Zj/VuVI82him0OCvVTLcevbDuX4T7M=;
        b=JJLKJlPyzAOQnGR8z0rQ2JYU46/iAVDN/BASsJQFDBnxdDwd5qQkJH7VrUbMKWLt/t
         osylGZ6Sn0x4HO2EtEC8h9hjEtP9DlJ4ns0dH9WGBbpoD2LJz1TwmuqOzrhc8KJaXEvy
         Hl/+UcccohFaTJApRhUH3Mjj44RA+iF8pXevq20Ks2mYGvCbLxh4+67+/pH6cmntCic5
         +ZCNlKKjL5QsHfl8/3L2eY34Xpx983A0joHfk0CEuAppAUOEn9uafecEINZIJ+ITeent
         UubYwaeutr6AAQt7z5EhVlPVp4uJnCLmz1gu06G4xOfzZBHTvsCH6uBEJvxczVfTSu8b
         AFLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOo6ZEUIlgdBXQZ7mD9Rm9htANJ/h/GsnUXccBFD3XgLpFQRO55o0CERa+j28TizHW4fROxDHuA2Q/LvpI7knlUqO7H3oSatSlVOFqN5Y=
X-Gm-Message-State: AOJu0YxTQqYfx0jE+f21HLPKQOEF37/jwbNlCgaKsnkRBYiay8ekbjlz
	XUB74SlnddhYCEVSz7H0JMT7DTAdF81M4Jc9a2xnzJ97w8ARzvPn
X-Google-Smtp-Source: AGHT+IEvqORC52ugeEnsqSAyqtbRxOFkMYqpRahUk759EpBN+ls4SEtKkToegphbJ9Hdp34S/VFYXw==
X-Received: by 2002:a05:6a00:9a6:b0:70a:f3de:3f2 with SMTP id d2e1a72fcca58-70ece9ec023mr12463396b3a.3.1722384183249;
        Tue, 30 Jul 2024 17:03:03 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e1a2asm8871689b3a.23.2024.07.30.17.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 17:03:02 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: 42.hyeyoo@gmail.com,
	cl@linux.com,
	hailong.liu@oppo.com,
	hch@infradead.org,
	iamjoonsoo.kim@lge.com,
	lstoakes@gmail.com,
	mhocko@suse.com,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	torvalds@linux-foundation.org,
	urezki@gmail.com,
	v-songbaohua@oppo.com,
	vbabka@suse.cz,
	virtualization@lists.linux.dev,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v2 3/4] mm: BUG_ON to avoid NULL deference while __GFP_NOFAIL fails
Date: Wed, 31 Jul 2024 12:01:54 +1200
Message-Id: <20240731000155.109583-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731000155.109583-1-21cnbao@gmail.com>
References: <20240731000155.109583-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

We have cases we still fail though callers might have __GFP_NOFAIL.
Since they don't check the return, we are exposed to the security
risks for NULL deference.

Though BUG_ON() is not encouraged by Linus, this is an unrecoverable
situation.

Christoph Hellwig:
The whole freaking point of __GFP_NOFAIL is that callers don't handle
allocation failures.  So in fact a straight BUG is the right thing
here.

Vlastimil Babka:
It's just not a recoverable situation (WARN_ON is for recoverable
situations). The caller cannot handle allocation failure and at the same
time asked for an impossible allocation. BUG_ON() is a guaranteed oops
with stracktrace etc. We don't need to hope for the later NULL pointer
dereference (which might if really unlucky happen from a different
context where it's no longer obvious what lead to the allocation failing).

Michal Hocko:
Linus tends to be against adding new BUG() calls unless the failure is
absolutely unrecoverable (e.g. corrupted data structures etc.). I am
not sure how he would look at simply incorrect memory allocator usage to
blow up the kernel. Now the argument could be made that those failures
could cause subtle memory corruptions or even be exploitable which might
be a sufficient reason to stop them early.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/slab.h | 4 +++-
 mm/page_alloc.c      | 4 +++-
 mm/util.c            | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index c9cb42203183..4a4d1fdc2afe 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -827,8 +827,10 @@ kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)
 {
 	size_t bytes;
 
-	if (unlikely(check_mul_overflow(n, size, &bytes)))
+	if (unlikely(check_mul_overflow(n, size, &bytes))) {
+		BUG_ON(flags & __GFP_NOFAIL);
 		return NULL;
+	}
 
 	return kvmalloc_node_noprof(bytes, flags, node);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c700d2598a26..cc179c3e68df 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4708,8 +4708,10 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
 	 * There are several places where we assume that the order value is sane
 	 * so bail out early if the request is out of bound.
 	 */
-	if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
+	if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp)) {
+		BUG_ON(gfp & __GFP_NOFAIL);
 		return NULL;
+	}
 
 	gfp &= gfp_allowed_mask;
 	/*
diff --git a/mm/util.c b/mm/util.c
index 0ff5898cc6de..bad3258523b6 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -667,6 +667,7 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
 
 	/* Don't even allow crazy sizes */
 	if (unlikely(size > INT_MAX)) {
+		BUG_ON(flags & __GFP_NOFAIL);
 		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
 		return NULL;
 	}
-- 
2.34.1

