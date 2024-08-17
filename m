Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23C8BA2D
	for <virtualization@lists.linux.dev>; Sat, 17 Aug 2024 06:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723875923; cv=none; b=Nmy0D4bdlgg4p4SpTgaPphZLxRcCSddJB1WEDncqsNi3kj7d2onvfOonNXwzrMuVhuetxdd/MmQgOX9WVLC7192ibDMbycbG3OeybMYew1MNmTKiCmRemxc3qChdSONxSfR3jxhAEWzKmii90Wln4LZDDdLgdf4vY17m9v0Wuv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723875923; c=relaxed/simple;
	bh=8L27HnBzfiEVHDzAqMby3FQrghIUaiDU/S/NbxEVrD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4+uhD1oyMLG3UCBoP0nFe8in0SvhOcKd1+UgjbeYpZS8c500Nbua1M6LWJhf7j0GxNhE7nY+jf4K/bnooPVJ0RfKjiauLqy9oYKy9io9aNnlDtCY0XAws/imzOHTwLVnhq0F8n2zfm+KG+x9n9YOYddlr3uKSSz8XyQ4+2KvJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYsCUfn0; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYsCUfn0"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7a10b293432so1847925a12.0
        for <virtualization@lists.linux.dev>; Fri, 16 Aug 2024 23:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723875921; x=1724480721; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=friTy/DcHRUPotFFxFEVr/8PnCHtLs9nrIthUQvrKhU=;
        b=jYsCUfn0aiJPuzueJCHffoHSgUBYcm91jQ83hFkzD8xBU8r3vh4+lqhvr+e4rrouug
         dj6A8ZdLPShZKzU80Z3TYVmv33Pnxjysivd0ynZDDirsDs/sXnuxq8oqYB661S6pjEM8
         Wm52UcmyHHM56eN4cQvWXs54bWFyAWojiudl4aSrL75VQkfvYyWAwyscqPXQoiY8vAkq
         t4V6TH1c8wgP8w9mdg40U0dJkgFlo0uaHOpHaCbCdg1zYjhTEFKBYryq84FBKgCaFt8e
         pMB9llfM9lq3rGLIWuxWX6uoDBP5t+wI+Yv7hqZJ/FU05p5rSpvgaHWNi9jcj0w7W6Ey
         GwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723875921; x=1724480721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=friTy/DcHRUPotFFxFEVr/8PnCHtLs9nrIthUQvrKhU=;
        b=mdq3VaRf2q9fM9sIwnK8mP6eJb+lVxrjJbnVsax1ny+7QDXRnc9LrGBXfkCqsz8G7j
         3H+GEhsXqlSgySPpKKJaTXsZfaCxMtkJzPwzpPKNN2itbro2s13171WjWUxt25FHrInH
         nuihI5/UpmDspgYTtFQrWwxmaWYkaXjzzw9lLjjDXAQTgqc4KgAjsCmqNKR9fFD3/T0r
         PTJXyTFD/qZit42ErTxw1qfK+gbqmcdEqtvgCeYUdl7MedUkFTEhHudtNH2QZxfIu4Rm
         mHLfAWM+Sk61dKA/WuB/V7Mx/twliT5VGMqHEsOQpjTEwWo7+Z1hva773kB6bFCNh5ET
         jZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmvnc3JlQzMN8g0iEuIJzWeH9d604In1QIVd0pniGjcBAKzh8WfZCL+ZKQc4hm27G+xvYVIo7OdSo8Z9ddPsMPIH4aSZs0eZvrIx+IpHs=
X-Gm-Message-State: AOJu0YyWFBJ4ERu9GYknpi8P41OCCgtbtoMJDh+yeU04NGJKCImW2vJz
	Sc+GpCdharZgSzqtztbuyOzMlOVXj6Dk0uuqDg3opT7xj08Hhuxi
X-Google-Smtp-Source: AGHT+IGbImbwpzZFycRBvwd+gSXhiD/E6qOTGdZAld/gNp5VVNETMnD4+Zd4mdJ5MJXaEJz/V+vFEQ==
X-Received: by 2002:a17:90a:c915:b0:2c9:7e9c:9637 with SMTP id 98e67ed59e1d1-2d40556d433mr2122285a91.13.1723875920984;
        Fri, 16 Aug 2024 23:25:20 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:fd84:292a:c6d0:8b67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac854f3bsm6768404a91.51.2024.08.16.23.25.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Aug 2024 23:25:20 -0700 (PDT)
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
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v3 2/4] mm: document __GFP_NOFAIL must be blockable
Date: Sat, 17 Aug 2024 18:24:47 +1200
Message-Id: <20240817062449.21164-3-21cnbao@gmail.com>
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

Non-blocking allocation with __GFP_NOFAIL is not supported and may still
result in NULL pointers (if we don't return NULL, we result in busy-loop
within non-sleepable contexts):

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
subsystems can reject any illegal usage of __GFP_NOFAIL with GFP_ATOMIC,
GFP_NOWAIT, etc.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Cc: Christoph Lameter <cl@linux.com>
Cc: David Rientjes <rientjes@google.com>
Cc: "Eugenio Pérez" <eperezma@redhat.com>
Cc: Hailong.Liu <hailong.liu@oppo.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
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
2.39.3 (Apple Git-146)

