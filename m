Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9DD2900
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 00:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722384192; cv=none; b=kogZDMXgEvZCtef+j3EG12KZRTEgl8PWD9mnnyH2JKPtf9d2sKANgHVZFzsh/jC02wkWlD4BTsy6eLfONGcXVCpX/kTcRX4ewZMWgGoCKWnzw/Um6QGnKbGzA0O8007caMWKQ+lH6EUlzzmsiTM2z/ifyj5PTWvvh6FI+G6SMeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722384192; c=relaxed/simple;
	bh=Pr913rUs4xQZowa10d0xMMbgxMr1br8B/CEYcLL81ME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AJbPNpWfvjmc/K2rIeD+Es0GdN5CqTk9rzYO2deo3b5yW5efHdsPPhrYoxvsP0YTLoh7I10WA7+I4MAXpT0Cojobyel2HHScRp+NUrH/ZQmZjKJrjRnQyWN1K9+b3E7xIuMN223aY6vEgiCzCjF3q0FTRlPy1ts/+WltdbnFZ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXQlZaZP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXQlZaZP"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d19c525b5so3483166b3a.2
        for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 17:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722384190; x=1722988990; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szHsw+puKDB/YFQfKyWB6EZ/UIu8BDwgxN6U76SGESg=;
        b=IXQlZaZPy6fa3PpPU0FrTv1UpuYkCtXXSNo9+7gQsPfSzHNq7j0kKrfIn1MWy3V6ej
         yzwDVFYCbWxTabFsb6fXhR/imjI6TF3x+fWHcD8zceriPCluoHNM580Awuru/LiLE4n+
         uG6WZyjDOaMKiKLyNuJamBNckA00DeYkoUCU0e4qdsIDdaZR0U+N/D7SmdcoVaAW6l8q
         DlbOov5DkjjknKr1zPuZQ+L5bfO7jl/t5N/QnBARt0qG/yf0mDqbGifBzUEF4tqBh6Lp
         kCATJLrjSJS2ZLtP3+XCQoUAMGkDfElfOjQmR40118Qf4LYk5kNq2pG1bjsZJpDkEKCv
         xV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722384190; x=1722988990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szHsw+puKDB/YFQfKyWB6EZ/UIu8BDwgxN6U76SGESg=;
        b=QY6mMNstq5ene2pokDHL3eyQzj+EDVTm1mLOWKGoxKDf6bMfsO2XvRu++rBtrfvrNj
         3cpCQkE3/SIOAD1QqJfFgiHddZkkIuR4JYeMvwYSMGM3sDDNPZtKdtSLv6UlBnp7HKH1
         1aEFzp6bLibH1vgFjaiETBWUKBM49nDLN2lPkCIqnjSRQ7x2PCWOA+N18rQBTgBfcx0h
         fJBsZFoQhHJxX551x+LNR0OYhdr884EVDHrJ6ybCFuujJtk78gzvVAtSJyVn/LTUO6cl
         b5h08tiYd5UC4Y36y6dVJRzlyYoc4aOcjUBcTZu3kDM+Fc4hIERqVb4Y64UvdRuWq0cb
         4/vw==
X-Forwarded-Encrypted: i=1; AJvYcCX28E5+q+ScoR99FBh47BjtYBEHUd96faDTtYKfupYyhWr1kH3xftc8vP96HUAKVXDNJ7QLGrXza8FsrE1sLjRRvMwrrtJfFxj3nq5PfiI=
X-Gm-Message-State: AOJu0YyCz/JfxKptL9didEirk7CzMh1yP+OeeMO6FYeLJ9So/LtamRY+
	h2eLsmsbQpPHP/pBnxFjMZwnBkYkW6OewzeWuyJThe0riQyJHZ2b
X-Google-Smtp-Source: AGHT+IEIBLKfBhFUnGg8PPWUhEwW7y7oUjaJuAC/v6G0XLI8qVOADllc/1BOv3bbYq9JOw3O+D6uHg==
X-Received: by 2002:a05:6a20:2588:b0:1c2:94ad:1c5d with SMTP id adf61e73a8af0-1c4a117dd82mr12540967637.2.1722384190096;
        Tue, 30 Jul 2024 17:03:10 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e1a2asm8871689b3a.23.2024.07.30.17.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 17:03:09 -0700 (PDT)
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
Subject: [PATCH v2 4/4] mm: prohibit NULL deference exposed for unsupported non-blockable  __GFP_NOFAIL
Date: Wed, 31 Jul 2024 12:01:55 +1200
Message-Id: <20240731000155.109583-5-21cnbao@gmail.com>
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

When users allocate memory with the __GFP_NOFAIL flag, they might
incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc. This kind
of non-blockable __GFP_NOFAIL is not supported and is pointless. If
we attempt and still fail to allocate memory for these users, we have
two choices:

    1. We could busy-loop and hope that some other direct reclamation or
    kswapd rescues the current process. However, this is unreliable
    and could ultimately lead to hard or soft lockups, which might not
    be well supported by some architectures.

    2. We could use BUG_ON to trigger a reliable system crash, avoiding
    exposing NULL dereference.

This patch chooses the second option because the first is unreliable. Even
if the process incorrectly using __GFP_NOFAIL is sometimes rescued, the
long latency might be unacceptable, especially considering that misusing
GFP_ATOMIC and __GFP_NOFAIL is likely to occur in atomic contexts with
strict timing requirements.

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
 mm/page_alloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cc179c3e68df..ed1bd8f595bd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4439,11 +4439,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
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
@@ -4474,7 +4474,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		cond_resched();
 		goto retry;
 	}
-fail:
+
 	warn_alloc(gfp_mask, ac->nodemask,
 			"page allocation failure: order:%u", order);
 got_pg:
-- 
2.34.1

