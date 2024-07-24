Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963D61CAA1
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811378; cv=none; b=i3I4qq9BKphPFjBm2OdYtuB3bR/esscoNMps1pomgcY/dvREARD6EZ6kxH9wE+OqNc+rl/P/vJxfJmrU0H43prVIa8DpY9bFRgtf+Nj2FeUN4/nvIbq0eJGU+896RI+t2OR4tEd+WD8QWToo+bY0e22rWGJoMKCNveuUw6xx4d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811378; c=relaxed/simple;
	bh=3A6rttzEOSKCfaRXBROwmuF7A6LHsNN6RX+On8CFTsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A5Q6Bx0j5R60izJirOUb4z4/wyiYnKRBXfBbYhqdoDAybJhJ/Rjb6jK1AK+8x/fXLY5TxLkHhq9TwNuxf7DnOUhUlVgxeczK4WAlDh7jLoLX2zmoYrkukMTtTJ0XP4ZOH7alH+01NJ3eyCMVeH9+bIp5LbwJ1Q6ifwSLOPjGFs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1BZ7DIS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1BZ7DIS"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd90c2fc68so14049955ad.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 01:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721811377; x=1722416177; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/Cn9Fke+io3lF3O4J0LET8eDbs2QZYmqd+T1evqSS4=;
        b=e1BZ7DISucSWyZ0FgO1wqR2vNhf9LvFea0BD56wUS/GtX5UPWABdZO2wh39+slvFMQ
         qIavXPsXx4ZDKck8hOk9ChC3M/dtpDrlpFt4hMcl7tzCnKbyZJW2/XGy1PeGUT0xeQ+7
         Io56tZzd8GPrS8xBlJFBHxCjiccB+g6taQuVnVgcldxnXEr82ZDlCDEQwLpMGXBJ2sGi
         LGZnUaLEe7DPk939R+jl+lq9vX5PSITDa76/e3J5lUCUBadwwn+C38q/EfvTxaZ+pIMB
         NeY1o62IxqGy51NaOJGDPen6gBqVc42TkeaHE3iFRl6fFNN9VgBI9jnbn5qnDiyvUU0f
         Rtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721811377; x=1722416177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/Cn9Fke+io3lF3O4J0LET8eDbs2QZYmqd+T1evqSS4=;
        b=g0HNIGQGYw2Hn4YvRNKdsRhQkRIfE7utDpsvMdpkhpsZJr9Qld1v46LbyOvXCuTK38
         DXrptkphooerdmPcHvAMXuPmUs/QcCVsgVzEGsA9gPJSpDFkuFAYCKXWGADgP8iXPRSF
         i4HqePWJLxzsJJvFE2f3LeXH3oijTElQ5BflxF0HFli4gVV2XAZoyPZGDhYbX3Hp3APd
         cXhieJBc1LSClmY2ZNy5yRRyXlp2aXQnX20BYRs7B56PRbvqSgdsoMDTtsN4joG1nPO4
         DM8qXWsp3+zApBauADIxvdXsQs1I9FTTFH2WqIWg9kGsFUbHLYEP/diTQYnxApUwJ84V
         /6Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUUHX5gDOpJX03YTXD0gn3F5kL3YO+O5A0QI3AbnQ9AOE8UyXTFOPi+GrnDVDLL35fz8rc70518Yg5h83+8WclnFON/aHUMkWoq5IY2ZMc=
X-Gm-Message-State: AOJu0Yyz6bRVZeRnD1RBx3tg0PvQllDtdT/Bzbdn5H22wOBgtwsh78SH
	P3YKTE34nIS38NQBZ4XcCQi0xYJZne41CYTGGxD1l1nRWJWf6Q44
X-Google-Smtp-Source: AGHT+IGIkVhFAMakU8DpVXwg17zUus/la2WxZ7dCaBvOhapjR8YXaE6IfX0kCgLDUKxL5Byi3m8WpQ==
X-Received: by 2002:a17:903:22cb:b0:1fb:8cab:ccc9 with SMTP id d9443c01a7336-1fdd558a23fmr18290925ad.45.1721811376865;
        Wed, 24 Jul 2024 01:56:16 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31855fsm89021895ad.156.2024.07.24.01.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 01:56:16 -0700 (PDT)
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
Subject: [PATCH 2/5] mm: Document __GFP_NOFAIL must be blockable
Date: Wed, 24 Jul 2024 20:55:41 +1200
Message-Id: <20240724085544.299090-3-21cnbao@gmail.com>
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

Non-blocking allocation with __GFP_NOFAIL is not supported and may
still result in NULL pointers (if we don't return NULL, we result
in busy-loop within non-sleepable contexts):

static inline struct page *
__alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
						struct alloc_context *ac)
{
	...
	/*
	 * Make sure that __GFP_NOFAIL request doesn't leak out and make sure
	 * we always retry
	 */
	if (gfp_mask & __GFP_NOFAIL) {
		/*
		 * All existing users of the __GFP_NOFAIL are blockable, so warn
		 * of any new users that actually require GFP_NOWAIT
		 */
		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
			goto fail;
		...
	}
	...
fail:
	warn_alloc(gfp_mask, ac->nodemask,
			"page allocation failure: order:%u", order);
got_pg:
	return page;
}

Highlight this in the documentation of __GFP_NOFAIL so that non-mm
subsystems can reject any illegal usage of __GFP_NOFAIL with
GFP_ATOMIC, GFP_NOWAIT, etc.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/gfp_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 313be4ad79fd..0dad2c7914be 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -246,6 +246,8 @@ enum {
  * cannot handle allocation failures. The allocation could block
  * indefinitely but will never return with failure. Testing for
  * failure is pointless.
+ * It _must_ be blockable and used together with __GFP_DIRECT_RECLAIM.
+ * It should _never_ be used in non-sleepable contexts.
  * New users should be evaluated carefully (and the flag should be
  * used only when there is no reasonable failure policy) but it is
  * definitely preferable to use the flag rather than opencode endless
-- 
2.34.1

