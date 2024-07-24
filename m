Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385301CAA1
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811386; cv=none; b=TFHoQLNoKIvxOk4PORj+T/vQM65x5J9ofrKmSopRIVJESRVu499kU3MqOPALk0wfSNOsW5eeETj9H3ZyvZpxEW6icsv1C/s2838Zlm7dq3XpmIg0yJS6hxa/CuSlX1fD2gOfibrJw9uoI9ERjpSaLMi8v4ESNEjQ/gavaHwsCu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811386; c=relaxed/simple;
	bh=8EzY0XIjPIJiaUZPEFMcQmTk9SvXSfAFxTU+rYNJJZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qLk1nxPqT8OTVf3LHl8u1MYCKyqVZTZZs4KEOThiQzhHnQjRa7D3yJjnM+ksTIkNuJtnUuR3MfvtMYXT40duRcO7ohM7bJ7t6EcTLA84mFGbVXQay1RxGuCCJti/3buzp0TaIrdfJkqR+rz83KGIZOvLdny/V/EzNYj8Ae+sZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAwzvfLd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAwzvfLd"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fbc3a9d23bso10127265ad.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 01:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721811384; x=1722416184; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rO/KuhiD7cRV7bVSkZENzez3YzOBiZzdZbe0gpcAATM=;
        b=cAwzvfLdO/pLXkd9iUMYJWMSxz9T3aQKgmhSVTGwPfNCW1813oRQQZDgCE98MtutCW
         2ldEkmuSW19dcgbjn7ly+sLCJi7EsJ5DzvIMUMQqbLZSS4FV69coxDmVGqm4kibOS0EB
         qOS5UvW0H2RH+77m1JyPy3zAkqySlHfa/2691qYRxJAj+rqwnqBccC6LolzZdm26k5NP
         21GA6GGnwxEHBQDfUDus7DJ1q7X8ypHDrvfcMaLJvpOrgzGakfOmJ8zfQ5BWXkyqn8dr
         7KoojEVi/LD2QwkR1ayAGY3RAc3xi5fs6U94y+dbjra9TD5hyGN5FjGd+afYkwbUpgsr
         ATrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721811384; x=1722416184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rO/KuhiD7cRV7bVSkZENzez3YzOBiZzdZbe0gpcAATM=;
        b=of46as5YoJC3Np1h4dIMcvsA0XmN5/DfP9+d3mEDuDjQkj+zYr76zJjQwB8F0fxHAd
         a1S9a0NPXobw4UnaP0/Pqy+0YHDGgFFly0d4A+8ZR9/XaN0yUxC0kXziO8LL4Y0KJIRh
         N6dloCWgrz2hltKJTgiWTgyk0tIF5O4sqOCc1/XaVJIcvAsGmar/1RCPYYmEk1yS/1AN
         hlJxslph1eeFTOXI6QRAk4zIPBYWZSzmk+hidlXgmc0gdUcT4itP6S2C/oWL4ggehnwM
         3ofCoIHrK8H0TNuMddJuXRDMw8ShhhpsSC7SmTJ1qJM3RlORbXJOQfUFdhEZlSKB3sZQ
         ycxg==
X-Forwarded-Encrypted: i=1; AJvYcCU9r3NZu4XwPgYLkyZOZgwST9T6my7aGLvw1Ir8q3l11oUHB6XzYRRcaLCic5qhA9yty7cE1DIcjaKBn9V1acTiOaH+ebOnC3vDTVr5Ul4=
X-Gm-Message-State: AOJu0YxNLHSJN9HHjWlYbdJbyxbOD9Z6mtUFV5a5Py40BfIhAdlM8r4k
	iSpll0zKJc3lyOYR+MGJzNX5KNxyTXGBl31y3nxpAoQf1c0wA3dI
X-Google-Smtp-Source: AGHT+IF4eJwkNl0CHrSQ4qGU2G1saE6asgKggB5lhcZDmy80CJ5db6LeREGY4Lm0vPdAOVXiTNqh6A==
X-Received: by 2002:a17:902:d50b:b0:1fd:d22e:a1bd with SMTP id d9443c01a7336-1fdd54f520bmr13416725ad.13.1721811383522;
        Wed, 24 Jul 2024 01:56:23 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31855fsm89021895ad.156.2024.07.24.01.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 01:56:23 -0700 (PDT)
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
	torvalds@linux-foundation.org,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 3/5] mm: BUG_ON to avoid NULL deference while __GFP_NOFAIL fails
Date: Wed, 24 Jul 2024 20:55:42 +1200
Message-Id: <20240724085544.299090-4-21cnbao@gmail.com>
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
 include/linux/slab.h |  4 +++-
 mm/page_alloc.c      | 10 +++++-----
 mm/util.c            |  1 +
 3 files changed, 9 insertions(+), 6 deletions(-)

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
index 45d2f41b4783..4d6af00fccd4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4435,11 +4435,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
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
@@ -4470,7 +4470,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		cond_resched();
 		goto retry;
 	}
-fail:
+
 	warn_alloc(gfp_mask, ac->nodemask,
 			"page allocation failure: order:%u", order);
 got_pg:
diff --git a/mm/util.c b/mm/util.c
index 0ff5898cc6de..a1be50c243f1 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -668,6 +668,7 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
 	/* Don't even allow crazy sizes */
 	if (unlikely(size > INT_MAX)) {
 		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
+		BUG_ON(flags & __GFP_NOFAIL);
 		return NULL;
 	}
 
-- 
2.34.1

