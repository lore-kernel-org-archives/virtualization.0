Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A171D33C503
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051621; cv=none; b=rHen+DRtIvPYZlWvvkAky66iRY3++Kq6mNqp1zL2F23xXLvsDRDYj8H8a12zEX8dCP8O1epHDrR0FXR3qqUHH2AipBfiO6DX7m/9ro5+QwiSgLfm0L4UA6y8ri4bQ/lr/J9eJgDsOZJg1ATsyWpg6w3fW/WdLIXudyqK4XJxiwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051621; c=relaxed/simple;
	bh=+Psx8bKEdpkhNgbqNOO4RXL6S6LqLj+1jmmuZEFx8qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KXIDKSPESDt/Gq+2qQQ+mybQFWWVR43i+4w6faObuqvBu415hTVmOyPMUqAAwhKr8XmMMUcVR7Hn04OT9XI44jhodNWnt9kSPJJpy53Im0Y+s+N+8O7AgsNM0wFkOYOhScsSVkyvwr1FROwKLv/KXCxuTmEVQtWdN/T41tD0bFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHLneQ0F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHLneQ0F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O+OTVNr68Ud6e3V7gLc8dmSyyby2S+Q4hsUbFdDpNzM=;
	b=DHLneQ0FofCvURi6Oe1IAr3/K8Syj/Cm9IPfXNINEyd5aaa4LJpVQ2Vyu95ls3Zgaa3IoD
	af6bfLwIH9wJlkmcxwIViCjCuPoch4NBpW5+KTywe/09u2efRShmpW59nRGfVwaz6pRonj
	I9EyPCYETfUWSViao4niUKawCkiRD3w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-OtBOzfCsNLGEjWf_sMnydg-1; Tue, 21 Oct 2025 09:00:16 -0400
X-MC-Unique: OtBOzfCsNLGEjWf_sMnydg-1
X-Mimecast-MFC-AGG-ID: OtBOzfCsNLGEjWf_sMnydg_1761051615
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-63c41bc2d58so4468870a12.2
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 06:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051615; x=1761656415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+OTVNr68Ud6e3V7gLc8dmSyyby2S+Q4hsUbFdDpNzM=;
        b=EXXKoR8Q0xlgTKFI61FA0CBVD7Tqm1oNCZycfH3jcG7rNjElQa4cnWwZgnjZku2Qoc
         qhzVyMfzk3Q01F0ToAfquvks1gw50pUTu7MtcgPQf8taxQ/kwOpGZpF193yM+1bgm3hv
         TUUaFrSd+jhrot3hxSAzK3Ila7WhmJS8JiC9R/o8WUcRFdqsn1/oXROoSEYuDQrZYEaE
         uOOsQgtPBKIlgWMTT9C5LJqmo6CYMqLQMhxZinYFGtOM62wZjSc/ICjtF1A8QjKoHJ7/
         bpeitWJZEd59AN4iQjgNEzHt7/VY2WzmlKaJvim3ZZ0eNKJWcABF2ELvdvviD8jB1IaW
         IbjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWnb/hOx2GB9A2AUN/LFRFo0X6vovZ4SyEeN0S3OlPEiKDPrDrUSxFRTEk7ZhzhPX1LtSPHPVEvc/Mx9/rcg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8ELZVIBA6oHGVjspx/x+KMaKKqJZ9pdsdA/5sFmFZeZI91LBl
	WQI61NWGNwBp+lM9yRlaBoIux2CbElMtV+T41BH1euM6LsZpok94Kh2clszXhgPEeSknwz5DyHS
	iIxbZ3jBkOLihsNOwujdFkyOC1of2mY6nqXaeevuZZ85p3MyOQ1tOkm8FASdKZ1hKq7ZC
X-Gm-Gg: ASbGncvqEOw/W2yPERpcdQweubLvx+oWjTJ3L62ZaMPG/cpSMt7meK03b13fTSVeqk3
	aNeN9QGi+6gh97e8L27axGLg0X/L2Up3+2GLUDXYNLC5xQSnA1xwfrL83MugStlNldfDc/unKjw
	6Cl5GtI2cpY489HlhLk6fU8CtDpX2mO2p1pWSIUOy+zvvCiJYBe7FZFbYTXwL6jYNzcLZi3gShr
	EJ20w1GpBmXU6KgBE9pJ6zMAayYWOPIZ0OlLQ9cBnIZ9VixJ5gU3qOny/FRGPKC2vfEqSLC3/t9
	b0GMoRKDz1iEPQiZ6O+Rd2rNK0MlU0+60djTMU+6Ht/twsZnV9ff5K55V9lnb0ve87xaH2m6oic
	YzyljhMCkdSKF6tSEyUn4ybnAUTC38bVMAFdM1JH2RCRPmCpXg80T29zYtd4o
X-Received: by 2002:a05:600c:3b8d:b0:46d:27b7:e7e5 with SMTP id 5b1f17b1804b1-47117917572mr150179195e9.32.1761051604331;
        Tue, 21 Oct 2025 06:00:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZFp/NfFGh9nzvdan/GtiYx6zHPVXBd5PXGxqlBj7uT7XLqj1hdDZYgamMo86fNe5GicJaNA==
X-Received: by 2002:a05:600c:3b8d:b0:46d:27b7:e7e5 with SMTP id 5b1f17b1804b1-47117917572mr150178725e9.32.1761051603807;
        Tue, 21 Oct 2025 06:00:03 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47114423862sm283718595e9.1.2025.10.21.06.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:00:03 -0700 (PDT)
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
Subject: [PATCH v1 14/23] mm/balloon_compaction: move internal helpers to memory_compaction.c
Date: Tue, 21 Oct 2025 14:59:19 +0200
Message-ID: <20251021125929.377194-15-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: hd5iB0h-NHHYFLT4LLFg-fO3e75iJryRn-C4QzjF1Lc_1761051615
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's move the helpers that are not required by drivers anymore.

While at it, drop the doc of balloon_page_device() as it is trivial.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 44 ------------------------------
 mm/balloon_compaction.c            | 38 ++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 44 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index d1d4739398978..eec8994056a44 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -75,48 +75,4 @@ static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 	balloon->migratepage = NULL;
 	balloon->adjust_managed_page_count = false;
 }
-
-#ifdef CONFIG_BALLOON_COMPACTION
-/*
- * balloon_page_device - get the b_dev_info descriptor for the balloon device
- *			 that enqueues the given page.
- */
-static inline struct balloon_dev_info *balloon_page_device(struct page *page)
-{
-	return (struct balloon_dev_info *)page_private(page);
-}
-#endif /* CONFIG_BALLOON_COMPACTION */
-
-/*
- * balloon_page_insert - insert a page into the balloon's page list and make
- *			 the page->private assignment accordingly.
- * @balloon : pointer to balloon device
- * @page    : page to be assigned as a 'balloon page'
- *
- * Caller must ensure the balloon_pages_lock is held.
- */
-static inline void balloon_page_insert(struct balloon_dev_info *balloon,
-				       struct page *page)
-{
-	__SetPageOffline(page);
-	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION)) {
-		SetPageMovableOps(page);
-		set_page_private(page, (unsigned long)balloon);
-	}
-	list_add(&page->lru, &balloon->pages);
-}
-
-/*
- * balloon_page_finalize - prepare a balloon page that was removed from the
- *			   balloon list for release to the page allocator
- * @page: page to be released to the page allocator
- *
- * Caller must ensure the balloon_pages_lock is held.
- */
-static inline void balloon_page_finalize(struct page *page)
-{
-	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
-		set_page_private(page, 0);
-	/* PageOffline is sticky until the page is freed to the buddy. */
-}
 #endif /* _LINUX_BALLOON_COMPACTION_H */
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 709c57c00b481..717bc43732d09 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -17,6 +17,44 @@
  */
 static DEFINE_SPINLOCK(balloon_pages_lock);
 
+static inline struct balloon_dev_info *balloon_page_device(struct page *page)
+{
+	return (struct balloon_dev_info *)page_private(page);
+}
+
+/*
+ * balloon_page_insert - insert a page into the balloon's page list and make
+ *			 the page->private assignment accordingly.
+ * @balloon : pointer to balloon device
+ * @page    : page to be assigned as a 'balloon page'
+ *
+ * Caller must ensure the balloon_pages_lock is held.
+ */
+static inline void balloon_page_insert(struct balloon_dev_info *balloon,
+				       struct page *page)
+{
+	__SetPageOffline(page);
+	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION)) {
+		SetPageMovableOps(page);
+		set_page_private(page, (unsigned long)balloon);
+	}
+	list_add(&page->lru, &balloon->pages);
+}
+
+/*
+ * balloon_page_finalize - prepare a balloon page that was removed from the
+ *			   balloon list for release to the page allocator
+ * @page: page to be released to the page allocator
+ *
+ * Caller must ensure the balloon_pages_lock is held.
+ */
+static inline void balloon_page_finalize(struct page *page)
+{
+	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
+		set_page_private(page, 0);
+	/* PageOffline is sticky until the page is freed to the buddy. */
+}
+
 static void balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
 				     struct page *page)
 {
-- 
2.51.0

