Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C80A1B5304
	for <virtualization@lists.linux.dev>; Fri, 30 Aug 2024 20:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049770; cv=none; b=gpP+lPWkh3WcJPpTUJ/w8QBJg1nCgVcRgUeg+ErdzeaaCwTDpNCzy73WOff0HjFNojfeUgGO7GhIiRxT/J+PMC0q/W/DxsKLkY3ZzaimrkCECygKmLjk1dDaezUTpjrfJYH4zJlV0aYgWwNod2rEAQPSNx4GJPaCF8e1xRcyGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049770; c=relaxed/simple;
	bh=ziHCpVttYcCqBaGQkpBQl2pLlOoI1OeLyGc8qMvk2VU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJfoLrlNYQRH3fjpLenl+c2uTdvZFiq6NVaap/teZL12+p6Y0u1onsCwt8EeGWWbFOrv+DiA7PiRq80yOm3RxIUuTPGmQaI7wJfCpiXoxjHTstbYie7VdnApEQ4sL9gb4RBGLLldgf8NQ6WSJ76wwfSvvuJHwyltUTrBy0AZ+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPau81ui; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPau81ui"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7142e4dddbfso1858101b3a.0
        for <virtualization@lists.linux.dev>; Fri, 30 Aug 2024 13:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725049769; x=1725654569; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uA9yJDuldkXpjNOiGrNCM2z32l5zmJbbH03h4Qi+gc=;
        b=NPau81uiSra1PUQEFCXpzCKgmZxSF/kZ0p/RWIpZnh7OvP1CLX2/3C4XXCs05zgBAG
         MsVl0H2VvNZ+3/FWBo3i3LXf8aHyNaiwUE4jLUJ8JbJ20b9y2UOkkOtzuLkTxOt9vVC7
         XHARH1Nekpe35qWXtAvCDRf5opzLPdCXvVKF/NS0pJcTVOldSxQoOCsxkDK5kKg3QQg3
         bn8h0iNJ6Bn838OfPmalhwRTfSd6+5YmCV2uYpU2g5NqW7DhaBV3neFIIcDRt4WYvA/1
         72rTbbIluvzel0E7nOqWYSMKvyHxv0Yyg8prT0NBDH+Z0Gvr+lbnHIZnOVlaMpMkHVw3
         j8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725049769; x=1725654569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uA9yJDuldkXpjNOiGrNCM2z32l5zmJbbH03h4Qi+gc=;
        b=YNP7v61DfTHvSCR+9dJSvpUEqMz7hvjKZ5eQL2Y6J2TPi/O9IhM4t3GIoavTdV9dKP
         iRjLVNkEd2hgoiazFbr7lcg1jMcUPc2g3sWc3Z1ME2GAIy+HoZfkejjIfsHV7q1EEiKc
         B/Ckp089Pc+SAbi8/IUgpLIFrVxgLbr4W2sfuWUI0+W5pKzaYn0RB76aJpJ9eKigPrvO
         L+vjuTxEQ5CPT2tZN9lnespROFMCb9j+FBYlNabDlieERDR66VrRbUg02QJF/dbr+1Y/
         rU8Ie+aBl+HOYjGLxorsUp/UbTIMwFKzJ2x1ZthoLim+LkHkiBAHyTVlKscUDt5BndrI
         sX2A==
X-Forwarded-Encrypted: i=1; AJvYcCUA2SeY44DdD7jlS/usTPRcCrupkqGPMs2W/BEC9PHomwGmd+30vtstPl7RgQPrsgvA22QVtoYp1jsl5FN9VA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yznc4B2rNf/85gz0qngB3VPlftQCbZkrtB5E94gjrd5hGnGTNpv
	QPvhn5Cyn/ZAv8vIZt+wbrM2UJCtgn3OrtZkj6KkyI/ox/l5CYIt
X-Google-Smtp-Source: AGHT+IG17vPMYD1S7Pz+MktNA899UqxDhkOHrGHPipZtAaxRI2/2JbLZJqwpWlQmoqhwmciVH6EbqA==
X-Received: by 2002:a05:6a20:d706:b0:1c2:8bcc:bb09 with SMTP id adf61e73a8af0-1cce0feda6amr7038084637.8.1725049768642;
        Fri, 30 Aug 2024 13:29:28 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d74eesm3257035b3a.147.2024.08.30.13.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 13:29:28 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: david@redhat.com,
	42.hyeyoo@gmail.com,
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
	laoar.shao@gmail.com,
	Christoph Hellwig <hch@lst.de>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v4 2/3] mm: document __GFP_NOFAIL must be blockable
Date: Sat, 31 Aug 2024 08:28:22 +1200
Message-Id: <20240830202823.21478-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830202823.21478-1-21cnbao@gmail.com>
References: <20240830202823.21478-1-21cnbao@gmail.com>
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
2.34.1

