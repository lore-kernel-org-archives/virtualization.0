Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B5BBA2D
	for <virtualization@lists.linux.dev>; Sat, 17 Aug 2024 06:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723875931; cv=none; b=F33h3wmNvTWdULMWJG6VAKh9oDE5AE1BhXNLAVpH/Y4qwsMk7KI/1jo1tw+868ZatDsvilVvslZDIyY+66c9I8eI1f298RT1sWeAiso51JmK20s1W8P1XFOkxbHO+q8XNKXWMnp3elYEGeyg5J47PB0B9HUM/r1nk7JwolMp12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723875931; c=relaxed/simple;
	bh=LsTLQAiHmLY0zt4h7mj2CNdEO73P0Tsxp/pf6dLKyEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cR4NIDHBa4GK5y/l9uT8C9OfeIBeRY42ZD0GqEpna6nsWj2OmpTSbpQCQC9kYbz4REU0MTgumgEt3u40uaKm/I+EomHHpgGDkzC1b7QmJhMGkOMPVE8+6bjFoNmU9dliJeMUj8znGvbhrSSEmumW+N4oW/bBajEyAPMmwLq2fBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxKTCnBH; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxKTCnBH"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7c3d8f260easo1814507a12.1
        for <virtualization@lists.linux.dev>; Fri, 16 Aug 2024 23:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723875929; x=1724480729; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+kupNqvjc4VbaeRrHIrzKXfEz1ha5uSEm43pSCHOkE=;
        b=BxKTCnBH4Mvcesr7xbxSqYziGqd9F2fZ2w5dfvVkyqO2LFXthZBHGGF089NkjFWhYq
         rkigms1jarmsSTB2Epzyx5Okj9e07A0CBurLg7+8VMAeJMu3c2cypBX+VDSo/mZN3uIw
         EHqK0MNAsS8O1E6PJHqBZwdpbxd90ef/KRPLLWuFWfSZFzgkgmVvhIXwGg+uGiUW68QB
         B7I4GttoRFl9MzvyABnd5e2cbf0KqpvwMGKvxBRx4+hDq47UWrJPF5UfEGvVPaStofu2
         9015nvxhMTchEgEeJ7yDC56j8ycWeBC/MhaA11R0mKbBgYyyYc+1r5gNelzStxcRyV/T
         LRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723875929; x=1724480729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+kupNqvjc4VbaeRrHIrzKXfEz1ha5uSEm43pSCHOkE=;
        b=hwx5Hk2oeWRT1cCvfPU5avP1CHAfUuPfify3TUtF0rTZSTJzjMZE5F4t5PV2/dT2OO
         LNLTkp5C+65HMf95E5zkhnOt+LhC3ZR8J/3djzFn6XCWywcjMJXBVHd984/GwaXCtDya
         qoQmmFmpSaNnCdkVPhZNXGHDW0UsrJVcgifibd+hO/drilqQCIzzin0+pslqkudu7RpO
         mfsgCr0P1knXx79nDxjVYij5edG9vd+0Xzma5fLAo6W21Y1EUDt35wji/NsK4t1D2KNU
         51RDgY30T6aPXArCP1ffWx58FuA5RKlr9CyA++yYflczZ9rGbNYwgpSLsLUNQzsOUcog
         ifZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoYFzwpfJuTDdQL7I9Jzz+jRB8r/UKji0+8wsMxHet+NTO0S3qCfVpypyA7eRZI7QH8GYlziJMFmjXfJXhZXaTj/TksoiDcKgKFVEhOlY=
X-Gm-Message-State: AOJu0YygMRdf1UQEeL1Ull8bPnorQ3P7IlXL28Xf1Jj89lGVmLvfe1ZO
	t5sTFsjZxHyeypUY/f4b5J3ss/Q8T7xzKfZjQV+nb9cMb6+K1crB
X-Google-Smtp-Source: AGHT+IHe4enXKrYqepTLb9GIUtBMG+QjR/xJ8dLQmWYjir/99r3pZcvKGo1qg+vP8DI56Lbbx94MwA==
X-Received: by 2002:a05:6a20:9c8a:b0:1c3:ff33:277e with SMTP id adf61e73a8af0-1c904fc2c46mr6039325637.32.1723875929471;
        Fri, 16 Aug 2024 23:25:29 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:fd84:292a:c6d0:8b67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac854f3bsm6768404a91.51.2024.08.16.23.25.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Aug 2024 23:25:29 -0700 (PDT)
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
	Christoph Hellwig <hch@lst.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v3 3/4] mm: BUG_ON to avoid NULL deference while __GFP_NOFAIL fails
Date: Sat, 17 Aug 2024 18:24:48 +1200
Message-Id: <20240817062449.21164-4-21cnbao@gmail.com>
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

We have cases we still fail though callers might have __GFP_NOFAIL.  Since
they don't check the return, we are exposed to the security risks for NULL
deference.

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

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
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
index 60742d057b05..d2c37f8f8d09 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4668,8 +4668,10 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
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
index ac01925a4179..678c647b778f 100644
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
2.39.3 (Apple Git-146)

