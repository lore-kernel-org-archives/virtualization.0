Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2A2339B4B
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051609; cv=none; b=grgfAVNdmprndrhvam7l7Nfha4KjiylVCQWk7yDpzGX5TiACXl53kIwSxlEzwpTMRMWy56Ik8ignrNjd4rX9tiEUDDXrpDzstDGmJ4L8hbHvXxUPmjtaNngvGrsDuxKdG4fw+H5DDeCuHZ/vLckCVpzvEjgGp7AP3l+daO64Hew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051609; c=relaxed/simple;
	bh=3cTNUMp4o+oVBONpNTtzXmzjCS7SNewteQ5np8WUWzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=fKqVgLewLY4YrHvCwm2V+/aKW+DwUMqwmgzzTVRBS3OKGpM+RSbOX9m0qkwK4791SOGynPgULpFePngtMcpLZQWTmIfTpwhsUi34NamlRANqnsXmR/FrU1rcuKUQDTqxS/fjYvajpfyNP4uYHCntNQvRPQNh48+GlF4FPUkrv7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+vKfB54; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+vKfB54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mx8PDzlnYvvbZ0yUyMmWAvQGgV0mnv7F+nCFHBKHb98=;
	b=c+vKfB54Z+RU0fDHFaGZeTkX44yJlW4QF3qiWnihap13Lx2MhAHFJSZjLVmaWN7OkPHu8P
	PdBTPZCXNE3njv0qh3L9ugXWAZ4Cn67sElwIXpMfqxOlpoUSyj3+mPZiNMpLe8khO4fJ2/
	hceIcdMlJmkLOdadrDg2ct3ns3mwFnU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-eA7JYWioOFCGRv7X2Kec3Q-1; Tue, 21 Oct 2025 09:00:03 -0400
X-MC-Unique: eA7JYWioOFCGRv7X2Kec3Q-1
X-Mimecast-MFC-AGG-ID: eA7JYWioOFCGRv7X2Kec3Q_1761051602
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-427060bc12dso5744541f8f.0
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 06:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051602; x=1761656402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mx8PDzlnYvvbZ0yUyMmWAvQGgV0mnv7F+nCFHBKHb98=;
        b=aNhltarokeeTSwpBlKqpUDMfCTOXlJW1b8TvqB9cR0TvopaW8rH/yXYikXdT3xTjCJ
         1aFgAbdR9Er1q1tOGmQZCtkuykUX0u69kooDU83xh4n2HOMSRCp62uHSHVBecaP8XvcI
         BSdrokh5SuW+Ugvxn0N9hqA9VFZPYb9KDONZZdRiIaYh2ywzQf4+sF6JpC4iC445TPp2
         bHGBs1r/6gLXMa6DPuBievgelk9zj5Ujiro590O4f2ck1ok8EyQhAYE11gEDjP79pgvv
         XJBvjY0H2VD9anZvUtarZCdY45oYDgLG6IArWCDuhJMZRN5d+MXu5rfgWilqmrXdLC+e
         2Jsw==
X-Forwarded-Encrypted: i=1; AJvYcCVjk5gWSGmoDDCWt7iW96snTMAX3tuFUnHHurxsm/mBkssgmEKiWLLk+9HsXoOzfVp2bz97eIQ6q+kd+PrBrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2z5yqboizzj2aO6uvpIFZMaFiS/Clm1OKh71bkPd96JlBndvm
	RahBdSYuSdzyAPt0xO1jHmZQDzF4drqoqAsylanf5pJEqgRxG9/Etac8yggfbGiNbY7g/ZfrcG5
	ORljmPURhbwgLOhEUDYbZDe+3uMVSLyKenyhshyAt9UHPYT7YiAn000rnpXEuv4xOFOKy
X-Gm-Gg: ASbGncte20tR6P1CkiBEbAgW5lclVOXaIIAf2UcJSLQ3CRWYydTWclb7KgyRXOzVD92
	iFARUg9mqghPtzp7QxccAJM8KIwXSLzrbs8r9ZsK92UjhtSY3f1TjQQMCiXOxaWBJ9isbFrbHZa
	E0FcTHKnJA2XJ33WJpNPPa2r70NGO8LXyQ4ufZvV/MwZB2L6ekvMT+kHnCwRNLo6GUfOC77VKdl
	b+OSD4VX7wCIJlgg8YuqyqyTmVbJaalWGxxCgPWl9JTumhCJ2zQFrV7/FMpz1AsgATA4G+wg5+y
	phg1EQ+7KlGUu/Xx/SOx15gTaDZGXrbi1DVccNGgOqqNbVcODwehcaeBZkpp0goyZjguZ4egoSa
	ke7xv2RoVItByixfg6cnKoVguzhqzqCS1yRsQz9azNAG5sZQ5KRyJfYUg0TCm
X-Received: by 2002:a05:6000:2010:b0:426:ff7c:86e4 with SMTP id ffacd0b85a97d-42704d8df97mr11013360f8f.19.1761051601973;
        Tue, 21 Oct 2025 06:00:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQe2AF3cxcaLPsgMe+jA1+DvC9OUXEqv94FS7Gua6OqWlPAIEXZjpDAmImXhD8jvhjJ6PszQ==
X-Received: by 2002:a05:6000:2010:b0:426:ff7c:86e4 with SMTP id ffacd0b85a97d-42704d8df97mr11013339f8f.19.1761051601543;
        Tue, 21 Oct 2025 06:00:01 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00b985esm20896549f8f.34.2025.10.21.06.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:00:01 -0700 (PDT)
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
Subject: [PATCH v1 13/23] mm/balloon_compaction: fold balloon_mapping_gfp_mask() into balloon_page_alloc()
Date: Tue, 21 Oct 2025 14:59:18 +0200
Message-ID: <20251021125929.377194-14-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: zipyt3C2AmnumMLx5vOzbkcWAo9QXYjNph3YMspbFI8_1761051602
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's just remove balloon_mapping_gfp_mask().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h |  7 -------
 mm/balloon_compaction.c            | 12 ++++++++----
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index e5451cf1f6589..d1d4739398978 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -106,13 +106,6 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 	list_add(&page->lru, &balloon->pages);
 }
 
-static inline gfp_t balloon_mapping_gfp_mask(void)
-{
-	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
-		return GFP_HIGHUSER_MOVABLE;
-	return GFP_HIGHUSER;
-}
-
 /*
  * balloon_page_finalize - prepare a balloon page that was removed from the
  *			   balloon list for release to the page allocator
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 90b2d61a593b7..709c57c00b481 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -112,10 +112,14 @@ EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
  */
 struct page *balloon_page_alloc(void)
 {
-	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
-				       __GFP_NOMEMALLOC | __GFP_NORETRY |
-				       __GFP_NOWARN);
-	return page;
+	gfp_t gfp_flags = __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
+
+	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
+		gfp_flags |= GFP_HIGHUSER_MOVABLE;
+	else
+		gfp_flags |= GFP_HIGHUSER;
+
+	return alloc_page(gfp_flags);
 }
 EXPORT_SYMBOL_GPL(balloon_page_alloc);
 
-- 
2.51.0

