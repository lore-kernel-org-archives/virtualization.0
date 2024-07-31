Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71347C8C7
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 00:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722384178; cv=none; b=RiVcAlQYXMz403zkoSCKzs25mF88E2VDsXFA+CofNmPgX/LkOR5YL52kDdPdmP/sP8H3t2nT+G40Znj09enjbo+CPWlnVxaz5nGW4E8mjHGwLwrA+pBbWVFtkXLW69ckQIzIO2xk/NQwCTNIsA4RVxd5qqeVFCcHtfkKL85/t3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722384178; c=relaxed/simple;
	bh=uF61aezyCAP7aZ5HWjBwz3qFpoAbRxzJCzgHQUcsUas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oR3+QjZvLTuGTYD7Jzmh+16ZAkznrHyWZyBAU7wJTcy87xh0l0kWVL1b0vG7CunlVlbbzNGBq2zxaZK52ZUwbmp09sl+XBP8HwM+l/uKf2kr25x9w16cUWcczBAdchtxUDIR4nZZ0rUBXBgEREx3SJsOZv4h4b5rgMdTwGwGzz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOUi+KFU; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOUi+KFU"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d18112b60so337062b3a.1
        for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 17:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722384177; x=1722988977; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4k7mUJ7l3kmAdsgh/A3CeQFcwrtcFTqm21Ngwsj726s=;
        b=FOUi+KFUpe4vwbYIqrrmLpdPo2XVu7Fzi6FZW7cED8xAGtoBIdepkJWYujvEqlRRln
         SQ+lHIHaINyhmjJHGy7JwfizfIh1QzTZXBoQ02f5AWd0CwVH4Yd+CfyjcblFG7NDmF8Q
         zhlMugVra5wFcKanPHyFIKbr7aIh9eP1McamU/6CuGSyi4auL0pj8/JJPCHQj2EThSqc
         TplOAh7Ug0tCK3BLe2TkAMaR27XJ156Km7n6kbFAV+fGzG9b6GAgI9LIE7QTCsdqtj8/
         pwekyacdiZfhYBUMChk6ViOuCpHLcBxJ3YpLEkeJz0gQEv5vjjVQFkEuMhSJJ3nv37S3
         jiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722384177; x=1722988977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4k7mUJ7l3kmAdsgh/A3CeQFcwrtcFTqm21Ngwsj726s=;
        b=ucY/zRwP9SKG3y4taFInzVCCoVJe8BK0BjyDyK3KxLe7dXMQgg/UYGf5oBPDJypHM7
         sDAwvO33Z4ZvPZ53r+78zLCEXHLZ/aOxz/xhQwOcZeBdSe+H7mlac6Th+Ga4kRMLij8h
         Izrhm++ETtgDPS6rxQ59znmPYPq/MpFm/iBjmOFHUYoe3X5tnwd2YdhKQT4WUHB4q0li
         jnoBEuOSaqcUtwDGTVOmruNHB2CLVISgNPvK7StjDJRJ7rKn89Nak2D0+dvu9nbw2+b9
         3JUYoQgjAd2jk3t2WuU/SggbaCvuQd+Vx6kODiGIJfQHtHMV3J3tBcfC2TI+ehCPfvuA
         hseQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl15eTzflpxtv3fd7HIuRetzHPYedIJKzqOCUcjAW1jVtoIGDQl5fU4W7ld9lwXpKz2lpTlnwdyoxnqIPDjzLb1FVJKphOGMtfjRe/9qw=
X-Gm-Message-State: AOJu0Yyzp3D8Ya0zwa9y2KGX2aPlcCfjfaI27x9euqfcuG4VKeSV4TBP
	KUSo+XXIxlbSQ81QepRJJ2MRD5sB4oAMo+xPEZPgJE4zfCCx8VHUvS+dOA==
X-Google-Smtp-Source: AGHT+IGub7/cT356oygu2KYD+sWoBYGAcDkpV7grhrgXGzsfW0LOrUdda5GHWr7u45BFlKT/uocwXg==
X-Received: by 2002:a05:6a00:949a:b0:706:aa39:d5c1 with SMTP id d2e1a72fcca58-70efe44f70bmr5615340b3a.8.1722384176485;
        Tue, 30 Jul 2024 17:02:56 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e1a2asm8871689b3a.23.2024.07.30.17.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 17:02:56 -0700 (PDT)
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
	virtualization@lists.linux.dev
Subject: [PATCH v2 2/4] mm: Document __GFP_NOFAIL must be blockable
Date: Wed, 31 Jul 2024 12:01:53 +1200
Message-Id: <20240731000155.109583-3-21cnbao@gmail.com>
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

Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/gfp_types.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 313be4ad79fd..4a1fa7706b0c 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -215,7 +215,8 @@ enum {
  * the caller still has to check for failures) while costly requests try to be
  * not disruptive and back off even without invoking the OOM killer.
  * The following three modifiers might be used to override some of these
- * implicit rules.
+ * implicit rules. Please note that all of them must be used along with
+ * %__GFP_DIRECT_RECLAIM flag.
  *
  * %__GFP_NORETRY: The VM implementation will try only very lightweight
  * memory direct reclaim to get some memory under memory pressure (thus
@@ -246,6 +247,8 @@ enum {
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

