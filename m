Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3316933A03B
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051611; cv=none; b=k4aP8PR1f7NJ4bV+MOPuq2+XrVaWtLwR2QTqg3xTHY1xXNz3gBixVVhoMB/V8YHM/C0xEA21bgrlrCXQYuZnFgUZltMeo/QMKJiCLu5+qZKDebbmooJ/53vkVkI9uDWHvuZqg9svojDyKLe2U6IyR8AeA1qlClt6rUmT4MEXbwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051611; c=relaxed/simple;
	bh=I1RjduQwNLAJmKC+Ha7d0wSfsDgz8ai3C7Mi619iPgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CkvdIMrT7CbqW9Vnk2By9Za8gisSDJ/5OFMokcU+hHgIqAXNbPF9WSENAwWdpATFY6yHZfIuxkC1OqZSNPNPBjw8dV0G/Un7I1/J/53qkJT0LmwDaZMs0aPNsuIdNJMA2FCd8bj/+Q9UlgizD68gmn5FIgYkMqjbDY0TFq5fz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UfLuGWHV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UfLuGWHV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qyA8pCV8ZcD9NKgO0LjiJR2j4wGQSpAi/OG88VVUt3A=;
	b=UfLuGWHVVI4j3OAL4UlOjsi326icFXDrQ+ldKy8FudYW0csDT2nzCRNvH+GCFX6YY81Mxx
	E6YAkfjCtMsaFtlH+QbimJwjKj6BZ/WnrkSgcM8WZWHHMrXptlH/GL2G8/XIYIboddjEBQ
	61ItdreV5H5YLvML7QskmIq/bQVu3tE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-8hNS8DCQNwmR7vN0f32DBQ-1; Tue, 21 Oct 2025 09:00:07 -0400
X-MC-Unique: 8hNS8DCQNwmR7vN0f32DBQ-1
X-Mimecast-MFC-AGG-ID: 8hNS8DCQNwmR7vN0f32DBQ_1761051607
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471125c8bc1so61196225e9.3
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 06:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051606; x=1761656406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyA8pCV8ZcD9NKgO0LjiJR2j4wGQSpAi/OG88VVUt3A=;
        b=Ug0pveOsLeZ0AwBbqUuv4qzPNHgClj9fg7o/cD6/THkUABbH48iJw1fe3c4zYG0QXH
         7nPXcl9EUbynWexkWud00mPsY5zUV8VoF1zCgsgvt8w8oSpb3rR4r5bnKmCcHDXk2fB6
         FbZuqbbgLL5q9OxXOQg1cjo+c5ticsrpVvvZ24VCRYbZok7tZ7sc/yB++1NrbcOidUL5
         CSrBKzFQ/SqrGTKTYJiLZgyy/yOZLDSYOAyiCjt4X2vzCd5EZv8QWgWkJeHW13wPgSHW
         NLZYSmEODI3oFSnQM5eytWEJ9214PdiDcmPnuAgAewKCztFlFcTcSP2pnwnTBlxrcNEf
         zgKw==
X-Forwarded-Encrypted: i=1; AJvYcCXEit7Igw6DjhxxdSF3mBd5nRffoafy0vUQZKvfCQq9B++npyWGKAixIr/Wnj7saAB9RdFJdNnWIqkCMrPZbw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFck/LICUKqFcDud5xH8KsOS45xHWyEXdoAe4LcDz1DaRkEXVD
	/3ljrYoH1QFLUjpJcOYkIS2qNhPQOjIBesbyOF3uGnOTOdeCBgHaJGcJGLWMG0WYH6lK249Kx5g
	k9I9qkEMeMY4xCJxDUAiFRhu8vXtkxl/FLrIEFtKQY0JDIlQhhI6lD6JdWBrcm4LSoaEK
X-Gm-Gg: ASbGncvobWH3DdBxwp4XT6DeZA6TQDzMRlwZ6jkjcUwep3I9U3jH24+dSAayz82R1ef
	czvs/+enoZNHUAxddh5GP9OURsBYiASv1xAGwqmypjxoDf90iSK09rwRY7PtvUBNb5wpPEpEZGh
	VA/ORKcA0dcE+JCd5jskRGw2zi498qHMtYRopQPlSWVvC+N3LSYzGHuurCbOAm8hxtYtVfaC0lz
	pnrIRgYYNZn3ymz88lSL8/XIQ/FZkolm239Co/O8AYVINgRssD+bG7rFGEzKasPdgTH8hukoezn
	UiTjp+IcIevOts02LAabcfRkjDcRheK/5rjRi0/DX2/QZtJeb0NNcx/0jU/YAWddTMuUwQo3vB3
	ROSx+YygkQmHE8RByR9FL7zaIad7Jdk9E70it+2sn4s/fGVWm388IWGndZ987
X-Received: by 2002:a05:600c:64cf:b0:46e:3b81:c3f9 with SMTP id 5b1f17b1804b1-471178a80f7mr116647615e9.17.1761051606599;
        Tue, 21 Oct 2025 06:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbkCxQxFQj6JOplMg8GsGSdkTVrb2edAU/Gb4AKN0gQYX2xa+Zptcgj0djfMLZWDQvHioQbg==
X-Received: by 2002:a05:600c:64cf:b0:46e:3b81:c3f9 with SMTP id 5b1f17b1804b1-471178a80f7mr116647115e9.17.1761051606167;
        Tue, 21 Oct 2025 06:00:06 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-471144d17cdsm278222645e9.18.2025.10.21.06.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:00:05 -0700 (PDT)
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
Subject: [PATCH v1 15/23] mm/balloon_compaction: assert that the balloon_pages_lock is held
Date: Tue, 21 Oct 2025 14:59:20 +0200
Message-ID: <20251021125929.377194-16-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: OvaWVyruN0YZqUoOj0ss3fNCtJFPnxWtQWQrqAJqbe8_1761051607
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's add some sanity checks for holding the balloon_pages_lock when
we're effectively inflating/deflating a page.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/balloon_compaction.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 717bc43732d09..f6e0582bd7ffe 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -33,6 +33,7 @@ static inline struct balloon_dev_info *balloon_page_device(struct page *page)
 static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 				       struct page *page)
 {
+	lockdep_assert_held(&balloon_pages_lock);
 	__SetPageOffline(page);
 	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION)) {
 		SetPageMovableOps(page);
@@ -50,6 +51,7 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
  */
 static inline void balloon_page_finalize(struct page *page)
 {
+	lockdep_assert_held(&balloon_pages_lock);
 	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
 		set_page_private(page, 0);
 	/* PageOffline is sticky until the page is freed to the buddy. */
-- 
2.51.0

