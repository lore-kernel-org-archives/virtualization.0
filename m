Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C031898E5
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 22:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970687; cv=none; b=biCPrBHWCLIUYVnyJ6F+YqKIdcky1uu853KuUyt8LpeBooAsRUrl0xYMY/JViyS33e0KUbr9ZSfVjHCiu+lcv3P3U8wxIlSeaIg4WVgZKZUllqspiJE7x0mSW2oaC3PpHqvZcoKj1xjvANFo9kzTPH7hPPLYXIoCMcLxlTWh9HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970687; c=relaxed/simple;
	bh=hCsnmX1TO1Jl5SZuHp8i7ncm4eIJYVN/kFtrlWGwotM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ngax/XWnFGRbHX+qnXBWVqBm+G69b/RvvUcT2tKl13ThStrVVbYwCQ1Sk5spCtKCRl13ciW3ntj5H86hMliLq3mrl42nYsvDrgBcrZb7jy3CvAyVoBMFsj+cBgQiMuz7fekHijq8X3bnplwYcdnVFvV0MAItr+E1kEcd176Et9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AD5mgGQS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AD5mgGQS"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7142448aaf9so869960b3a.1
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 15:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724970686; x=1725575486; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vw046BlQwqp0kheY735NpnzKZV77Hf8iJa45ZBjddEo=;
        b=AD5mgGQS7butTGoGszqI4GMSjZu/paIq3UyjbusSmGcpr4aGVmpo8xt4kGhL0aelnR
         hphYMv1ljBP0otcusVRLPlKmNP9IWijEKW3vV2+MaM3lztu9L3BN61EzGuvLwtMBkC2s
         1FXjg3vDUD8K4R+2jaAuPBTKHLo76jMfVYAc+M/hb4ODy4blf7jacpw07m/1iMhAZJys
         /EEhLyO4pY887nyimOjUfARjs7WuV+QsCKJ/wSBkc61Cl2P8u+nZFNzULAWJb33xkI5o
         1yOhWcD3KxzaKQQVKuuNyK0su/2yP0x5mSyZBYxvdXsiXOyMdxAaFJrIfrFCt8WrjWwi
         Z8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724970686; x=1725575486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vw046BlQwqp0kheY735NpnzKZV77Hf8iJa45ZBjddEo=;
        b=gxc0/XgOwscQuFEeTNyj7tl2ShrpaGvDaXf/0DAuRurQM1Pd10g9qAeJjGmroncj6z
         ayVAwDSqXl60BQpkG7vGkV6lgtovBv1FO9CzMVc1/MYGdOo23YeOC7KNVD0WF2Exy0Oq
         tdW7JOzeKiGpLgjmREXknvESjqIDfsUxIwOtxLYibKi71LurmuR9Hy8ZvEjYCXEPs1xh
         d3+YUiApGCHThJLwkvGv4gFwsJNLTYhBEbdFzcKn/q3CZ15ZUkVwhowlcoiFN8bx5kEJ
         TOHKkrzro41oCX4MbDt9jliPbpZapisYIQ8gxU8nobcegrUqYfwhA976UaA5IUzOVxzJ
         K7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUIGS41EJFTr9JXwZNBBFWTOfgBZpYtl81Y6AYvpbz87/73xlRVV5qmRFB+VIr1gNqqnSUephyjdsc++v9LyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2RJe1EYkSv4ZVLQd59ohn6rPrAc07+S3bgiTJkqIxHXy9G7XP
	oRgKPM0YcfDP7FwPWCO1yqXd36RWdu4z5qy2LhPYIjHnYZ5Zy+7V
X-Google-Smtp-Source: AGHT+IFhau0GMb2+jI99unqrHoqo79ZPnsK5Fim1Ct1lLVzqOoXbfgd/rqPMQHsW9L0qYnI9rWHF1w==
X-Received: by 2002:aa7:8650:0:b0:70e:cf99:adc7 with SMTP id d2e1a72fcca58-715e0f74250mr5263419b3a.3.1724970685474;
        Thu, 29 Aug 2024 15:31:25 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:b087:5dce:99f9:294b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e569f1edsm1614198b3a.128.2024.08.29.15.31.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Aug 2024 15:31:25 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: 21cnbao@gmail.com,
	mhocko@suse.com,
	vbabka@suse.cz
Cc: 42.hyeyoo@gmail.com,
	akpm@linux-foundation.org,
	cl@linux.com,
	david@redhat.com,
	hailong.liu@oppo.com,
	hch@infradead.org,
	iamjoonsoo.kim@lge.com,
	laoar.shao@gmail.com,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	torvalds@linux-foundation.org,
	urezki@gmail.com,
	v-songbaohua@oppo.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
Date: Fri, 30 Aug 2024 10:31:14 +1200
Message-Id: <20240829223114.1102-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAGsJ_4wZiE08XDjNAPENwH=KQEzdm2FB_bMDi0b7PJx+e7ydrA@mail.gmail.com>
References: <CAGsJ_4wZiE08XDjNAPENwH=KQEzdm2FB_bMDi0b7PJx+e7ydrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> > > Patch 4/4: We will move the order > 1 check from the current fast path
> > > to the slow path and extend
> > >                  the check of gfp_direct_reclaim flag also in the slow path.
> >
> > OK, let's have that go in now as well.

Hi Michal and Vlastimil,
Could you please review the changes below before I send v4 for patch 4/4?

1. We should consolidate all warnings in one place. Currently, the order > 1 warning is
in the hotpath, while others are in less likely scenarios. Moving all warnings to the
slowpath will reduce the overhead for order > 1 and increase the visibility of other
warnings.

2. We currently have two warnings for order: one for order > 1 in the hotpath and another
for order > costly_order in the laziest path. I suggest standardizing on order > 1 since
it’s been in use for a long time.

3.I don't think we need to check for __GFP_NOWARN in this case. __GFP_NOWARN is
meant to suppress allocation failure reports, but here we're dealing with bug detection, not
allocation failures.
So I'd rather use WARN_ON_ONCE than WARN_ON_ONCE_GFP.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c81ee5662cc7..0d3dd679d0ab 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3033,12 +3033,6 @@ struct page *rmqueue(struct zone *preferred_zone,
 {
 	struct page *page;
 
-	/*
-	 * We most definitely don't want callers attempting to
-	 * allocate greater than order-1 page units with __GFP_NOFAIL.
-	 */
-	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
-
 	if (likely(pcp_allowed_order(order))) {
 		page = rmqueue_pcplist(preferred_zone, zone, order,
 				       migratetype, alloc_flags);
@@ -4174,6 +4168,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 						struct alloc_context *ac)
 {
 	bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
+	bool nofail = gfp_mask & __GFP_DIRECT_RECLAIM;
 	bool can_compact = gfp_compaction_allowed(gfp_mask);
 	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
 	struct page *page = NULL;
@@ -4187,6 +4182,25 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	unsigned int zonelist_iter_cookie;
 	int reserve_flags;
 
+	if (nofail) {
+		/*
+		 * We most definitely don't want callers attempting to
+		 * allocate greater than order-1 page units with __GFP_NOFAIL.
+		 */
+		WARN_ON_ONCE(order > 1);
+		/*
+		 * Also we don't support __GFP_NOFAIL without __GFP_DIRECT_RECLAIM,
+		 * otherwise, we may result in lockup.
+		 */
+		WARN_ON_ONCE(!can_direct_reclaim);
+		/*
+		 * PF_MEMALLOC request from this context is rather bizarre
+		 * because we cannot reclaim anything and only can loop waiting
+		 * for somebody to do a work for us.
+		 */
+		WARN_ON_ONCE(current->flags & PF_MEMALLOC);
+	}
+
 restart:
 	compaction_retries = 0;
 	no_progress_loops = 0;
@@ -4404,29 +4418,15 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * Make sure that __GFP_NOFAIL request doesn't leak out and make sure
 	 * we always retry
 	 */
-	if (gfp_mask & __GFP_NOFAIL) {
+	if (nofail) {
 		/*
-		 * All existing users of the __GFP_NOFAIL are blockable, so warn
-		 * of any new users that actually require GFP_NOWAIT
+		 * Lacking direct_reclaim we can't do anything to reclaim memory,
+		 * we disregard these unreasonable nofail requests and still
+		 * return NULL
 		 */
-		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
+		if (!can_direct_reclaim)
 			goto fail;
 
-		/*
-		 * PF_MEMALLOC request from this context is rather bizarre
-		 * because we cannot reclaim anything and only can loop waiting
-		 * for somebody to do a work for us
-		 */
-		WARN_ON_ONCE_GFP(current->flags & PF_MEMALLOC, gfp_mask);
-
-		/*
-		 * non failing costly orders are a hard requirement which we
-		 * are not prepared for much so let's warn about these users
-		 * so that we can identify them and convert them to something
-		 * else.
-		 */
-		WARN_ON_ONCE_GFP(costly_order, gfp_mask);
-
 		/*
 		 * Help non-failing allocations by giving some access to memory
 		 * reserves normally used for high priority non-blocking

> >
> > --
> > Michal Hocko
> > SUSE Labs

Thanks
Barry
