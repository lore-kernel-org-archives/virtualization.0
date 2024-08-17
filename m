Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60454BA2D
	for <virtualization@lists.linux.dev>; Sat, 17 Aug 2024 06:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723875906; cv=none; b=NCmJcUhWQQoez8Kv+g/JGAR7MscSrQ6IkT1BU9sgUlgX4Ugxb+hAtss6H3s0ok9jztS4Pj2OQMuW/0FgVmQayLBhBR51D4MFKSo47BnoY4VsuhNnTogRfmB3FleRT0KWnj+KitWuYj1Iftb05/5pd0xhRxC8yYVFepO+eIVbW+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723875906; c=relaxed/simple;
	bh=wCp7sXRpRS+h1MksC/hNeEh9slfTD1gVuvqlKJNWTkE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uB4zFiftn2yWEomx8UB4p5wcYKXCaVaG+w7d3wiWElnv03mR66s/SbwDe/1yPHgNDQycfsNYBfdxbvM9D+R44GdRWgZWAt076xg4bEVi/Os0FZ7TzvR7QHlKWqds5V7qa2IirPWTIaYRqiGiuEkye9O/YH8LiVjA/mXbejMcRr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVzeuVQR; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVzeuVQR"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d41b082aecso8038a91.0
        for <virtualization@lists.linux.dev>; Fri, 16 Aug 2024 23:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723875904; x=1724480704; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fghbe/uTAWmKHUS8am3aPE9oJQfSOdjuZEbStAX9aZE=;
        b=XVzeuVQR+IJ/kLGu08bqqLQEP4D5HxY3/hx+aEl8/PH/fyFZLZGN+L2EO5VZgbVBo4
         f7vAmh0asX9HHUqEH2wHMlERN1VChz9um+WVFwobogie3YGEm5zuFher4PeHVUbHs2WC
         MyCS2ilOUjY77n80edgjSKIufuvm9WNDmF/AYBG9F3qxyFoRfLwIe2ssHUNbNA+Th9Z5
         1qK8U7c6xqz1LUmXGXJOTWGwPHi9SWR8d4ZumL77l8SaA4t74rIRRbmH8dmf2vDiGL57
         STGA167zU4TwtrQPRWxEKzxrxA5dehdGXtgj70/+RqdhXQ6QRDU6+JJEBfnoLwqy05Fy
         OQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723875904; x=1724480704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fghbe/uTAWmKHUS8am3aPE9oJQfSOdjuZEbStAX9aZE=;
        b=V7nwdPqByJRi704CRnB7lVY1G1zlZ1BVFwEaKP6Qo8OA4AmM42ZNfhl/D3vCsFEYea
         C796f6U+/3Iyz5uhcJLWrRk+PRL6IET8pe9BCZX10Vsaf0oN6IbHZ3CsJLk2TDT1zE79
         BFyfCFOXx9quaK+KR+J9YLZ4DH1XeyHziJfirTaMKqtVTuRVXnlF5toiCzAnMzF6wfRy
         mTD6/wBuS/KSHGUs2ejXlj7yLoycvxenzhvssDAC1tOAjFrTVZCIIW7U30Y0I61xKgXI
         pHJUN3FiDOwS5Ajm84EWdF9zupseRzX4FUs49JZYStGsuBs69ZnvvV8oVDk4pa4dtMHR
         u9aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsmCkP6x8Ya/vxAJfDwe78u679Dw0V3LIzn2viqKw4qTF4WWiOLK4PrsgDCW7fBynFX2bxmeXRlqUdKPm9895NYnSSPT3URzX9N2lTLqw=
X-Gm-Message-State: AOJu0YyKiRq1YyjSxBtGpn5Ze9iIA+/PHZiBozSl+vsrRUb6AhgLtbV3
	1RMzftxFe8D2O3kUR6AT0e/cgOfETas/8V7DNZjOqToGVI+zyERVS8ggz9JO
X-Google-Smtp-Source: AGHT+IGsKQP7phlZrMQES1TfZT80/j8UfqPE65YWyVkI9qgq9GoOjg8IBWskUSJYiyrWCebaEF1qxw==
X-Received: by 2002:a17:90b:3597:b0:2d3:d79f:e8b7 with SMTP id 98e67ed59e1d1-2d3e4537f86mr7473378a91.5.1723875904457;
        Fri, 16 Aug 2024 23:25:04 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:fd84:292a:c6d0:8b67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac854f3bsm6768404a91.51.2024.08.16.23.24.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Aug 2024 23:25:04 -0700 (PDT)
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
	virtualization@lists.linux.dev
Subject: [PATCH v3 0/4] mm: clarify nofail memory allocation
Date: Sat, 17 Aug 2024 18:24:45 +1200
Message-Id: <20240817062449.21164-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

-v3:
 * collect reviewed-by, acked-by etc. Michal, Christoph, Vlastimil, Davidlohr,
   thanks!
 * use Jason's patch[1] to fix vdpa and refine his changelog.
 * refine changelogs
[1] https://lore.kernel.org/all/20240808054320.10017-1-jasowang@redhat.com/

-v2:
 https://lore.kernel.org/linux-mm/20240731000155.109583-1-21cnbao@gmail.com/

 * adjust vpda fix according to Jason and Michal's feedback, I would
   expect Jason to test it, thanks!
 * split BUG_ON of unavoidable failure and the case GFP_ATOMIC |
   __GFP_NOFAIL into two patches according to Vlastimil and Michal.
 * collect Michal's acked-by for patch 2 - the doc;
 * remove the new GFP_NOFAIL from this series, that one would be a
   separate enhancement patchset later on.

-v1:
 https://lore.kernel.org/linux-mm/20240724085544.299090-1-21cnbao@gmail.com/

__GFP_NOFAIL carries the semantics of never failing, so its callers
do not check the return value:
  %__GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
  cannot handle allocation failures. The allocation could block
  indefinitely but will never return with failure. Testing for
  failure is pointless.

However, __GFP_NOFAIL can sometimes fail if it exceeds size limits
or is used with GFP_ATOMIC/GFP_NOWAIT in a non-sleepable context.
This can expose security vulnerabilities due to potential NULL
dereferences.

Since __GFP_NOFAIL does not support non-blocking allocation, we introduce
GFP_NOFAIL with inclusive blocking semantics and encourage using GFP_NOFAIL
as a replacement for __GFP_NOFAIL in non-mm.

If we must still fail a nofail allocation, we should trigger a BUG rather
than exposing NULL dereferences to callers who do not check the return
value.

* The discussion started from this topic:
 [PATCH RFC] mm: warn potential return NULL for kmalloc_array and
             kvmalloc_array with __GFP_NOFAIL

 https://lore.kernel.org/linux-mm/20240717230025.77361-1-21cnbao@gmail.com/

Thank you to Michal, Christoph, Vlastimil, and Hailong for all the
comments.

Barry Song (3):
  mm: document __GFP_NOFAIL must be blockable
  mm: BUG_ON to avoid NULL deference while __GFP_NOFAIL fails
  mm: prohibit NULL deference exposed for unsupported non-blockable
    __GFP_NOFAIL

Jason Wang (1):
  vduse: avoid using __GFP_NOFAIL

 drivers/vdpa/vdpa_user/iova_domain.c | 19 +++++++++++--------
 drivers/vdpa/vdpa_user/iova_domain.h |  1 +
 include/linux/gfp_types.h            |  5 ++++-
 include/linux/slab.h                 |  4 +++-
 mm/page_alloc.c                      | 14 ++++++++------
 mm/util.c                            |  1 +
 6 files changed, 28 insertions(+), 16 deletions(-)

-- 
2.39.3 (Apple Git-146)

