Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39571DC988
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051609; cv=none; b=BOUWIyFSHvfOVDJ6CqoTl24Uop2wea5oh0LNwEc7Y9kYiYmfNqJsMED2vNFgUyUtlCSEMcC1cNXxALjuk56jFnW2o0pWTtIF88tjOpFvK1T2mEsjvbNKHuF6etyzi6E9aJC/+RJ0HQ/2WLSM/gqqOOPopZDFSaTO2ZSw4ObOKw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051609; c=relaxed/simple;
	bh=p9NQaEnTQkjOvytztuGwrp0tPWZa+D35cuLh/W8irHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=eC+bQAd3ZbPYQLjjJx+Emanya+D4ywlS3uzwus86vINvmZ3t3cbqIDJz6pzrmrVgeB2+5TmctN5Pa11GpdeCpT0wRtmZQsfRtH1xc1ZDpCL08pev/akHBo170mVqIHqMhconnAFSDNmizCburEGsuRX2KJbiI6r6vU8zxuFmYO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9CAr8G3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9CAr8G3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dmjAOzzOKe+PWzSzDnov13uhbtuxj7aSoteYm9r0kM=;
	b=I9CAr8G3UDFzSgzs6fmShnRR3L10de0kyl+0kF61Ga33kQdN7fSfALxStTmfEx9TQfsyE1
	kNPNbkayHDv3OMBhmp6giNVf3fIuM69kwICJielFOIcfcojCfm4B4jewxjLt+J1cwMhX4C
	ApLNpKMNuWbypVYx2Wm+NCJEAcl30As=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-PniD1NuMODq3Rl2KWfh4sw-1; Tue, 21 Oct 2025 09:00:01 -0400
X-MC-Unique: PniD1NuMODq3Rl2KWfh4sw-1
X-Mimecast-MFC-AGG-ID: PniD1NuMODq3Rl2KWfh4sw_1761051600
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-427013eb71dso6016002f8f.2
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 06:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051600; x=1761656400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dmjAOzzOKe+PWzSzDnov13uhbtuxj7aSoteYm9r0kM=;
        b=OTcNXONoPYsMslUqjuOFsa3CxTjtTH1l6lLKHXreJw6yt5WH34fn51eZVMKyMdhVPO
         gBFXhem9uTKSlcLFHws9T8UPSVH0eqcka1tFm+2UnJtKxA9uCTeVZSm84yFvUk6vFMY+
         lzBWboUSC1DgH0nmZWV6EVXPa5B75tRWr/FxrN8El8z4y3t5wJ5kM6lbALVauZbm4Z7F
         Ks/8TAWPKGC3TJ9GfJgxq2umH7WeOrDW7IHgZ5C2SNGvxCen9uZJ80wx3YrEqR0aJyT7
         Cc+n0ZbbfLDVW9izDTnPlEoTutr+vVFnCdeMcPiFRTxL/mU7JoZmPLCs+FGnacmzTDz7
         P+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWL9NFLZei/Sf2Q1zbHyS9OwS9Z/cEgc/bX1rshyqRaDH4aP1RTI8x7HrZJD/DFEQDpCtbRmAmn3miCz70fCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwD/C1CDFPTEQknQxO+GECKsyiK5BdBG2h27ZgeOOOfRu6V655Q
	OXPRs3XNdVZ9OY4TtEKNTMTPpTseUKMCgBSJha4/mumDfCDetikAYLjhdTQz0LO1YZChgCEDLsZ
	jx2W1cQhr01v+H0vyGL41b/+VXjjM7YbGS4lC4WwJKvstbdw8e+RC2JW8p0vX67JOFh1k
X-Gm-Gg: ASbGncuJGy/Nya9Q3XyLClSoPxkQENFQM1Em1QKhXdAcA6opGK4yHNst+x4oTZXoGf7
	xsmTuyN7XCYhAhCr6hq/PI2eBtSr8sAffn0M+bluTO/INbcMGcxN6Trz8NVRZs49z/9eBFOTaY5
	Kws9ZGlypdncTZyhxFAT+VLvgxlP79VZftCyz5LJDs0Y/b9FJe8hvv1PK1Z0qVRq4OyVlV/lFnY
	cjM7Q5SLuVkbm5BLqLI/FLtQIwFfLAhI1oEjzJPhBcbscdD4qyurGyHPTkqeTsVZSHb3QHxMuZL
	5+rFXhO7PzWa6I2RUbwZ9lBUIkeBdZxkVR17uxg72OtIwQE+8t4j6CWkcwT35ICjX4MkGcijYBZ
	/HzkZI4Sg/snuSJ0mwssxJ8jBfVnHW6RS3+CJufSVEwnBfr1D63RAVlWatsxr
X-Received: by 2002:a05:6000:2503:b0:425:825d:2c64 with SMTP id ffacd0b85a97d-42704d6c822mr11791976f8f.17.1761051599791;
        Tue, 21 Oct 2025 05:59:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfxO1MIMIHuEAyS8Hvj/zoSDSKI4v296mvX+6V2esc8bVwH2VAjXdgu+NOffYas4k+6n6n6g==
X-Received: by 2002:a05:6000:2503:b0:425:825d:2c64 with SMTP id ffacd0b85a97d-42704d6c822mr11791940f8f.17.1761051599346;
        Tue, 21 Oct 2025 05:59:59 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00cdf6csm20134215f8f.43.2025.10.21.05.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:59:58 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v1 12/23] mm/balloon_compaction: remove balloon_page_push/pop()
Date: Tue, 21 Oct 2025 14:59:17 +0200
Message-ID: <20251021125929.377194-13-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021125929.377194-1-david@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mbRx8VaFbV9def6OTh2_ATZVKKGmD8i_sBo9Zir9oOQ_1761051600
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's remove these helpers as they are unused now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 30 ------------------------------
 mm/balloon_compaction.c            |  5 ++---
 2 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 1452ea0635245..e5451cf1f6589 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -126,34 +126,4 @@ static inline void balloon_page_finalize(struct page *page)
 		set_page_private(page, 0);
 	/* PageOffline is sticky until the page is freed to the buddy. */
 }
-
-/*
- * balloon_page_push - insert a page into a page list.
- * @head : pointer to list
- * @page : page to be added
- *
- * Caller must ensure the page is private and protect the list.
- */
-static inline void balloon_page_push(struct list_head *pages, struct page *page)
-{
-	list_add(&page->lru, pages);
-}
-
-/*
- * balloon_page_pop - remove a page from a page list.
- * @head : pointer to list
- * @page : page to be added
- *
- * Caller must ensure the page is private and protect the list.
- */
-static inline struct page *balloon_page_pop(struct list_head *pages)
-{
-	struct page *page = list_first_entry_or_null(pages, struct page, lru);
-
-	if (!page)
-		return NULL;
-
-	list_del(&page->lru);
-	return page;
-}
 #endif /* _LINUX_BALLOON_COMPACTION_H */
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index c44e0b62203cc..90b2d61a593b7 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -128,9 +128,8 @@ EXPORT_SYMBOL_GPL(balloon_page_alloc);
  * Drivers must call this function to properly enqueue a new allocated balloon
  * page before definitively removing the page from the guest system.
  *
- * Drivers must not call balloon_page_enqueue on pages that have been pushed to
- * a list with balloon_page_push before removing them with balloon_page_pop. To
- * enqueue a list of pages, use balloon_page_list_enqueue instead.
+ * Drivers must not enqueue pages while page->lru is still in
+ * use, and must not use page->lru until a page was unqueued again.
  */
 void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
 			  struct page *page)
-- 
2.51.0

