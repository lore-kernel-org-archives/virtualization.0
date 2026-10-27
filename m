Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069817;
	b=a/8BSP3YifjtTk9kY7UtRO4Cc8MX1sHWTtUeELhrBhG+fNx+Vz7R8NWqUhkkHk4IdOg5
	 SR4NxllK0rfT47ed4VA1rcZeG6VRI6TqP0oGO46N7CbSfw15Yr1Q3T4pKdlJpc6eAFI5l
	 oYExX1mXhpbyaZhD8BR/s3M97JPtXbHpT1XdAKZQqgkfg5P69U0g5HmkExmaBIuketi3N
	 TMLmLfC9M/Qrfpl03gpcViUo9pSv6orMZr4ZIe8Y8xMk0AxBOktVyfI1W994JLCMP4DUP
	 KyGc/wzTayuHQlMCOaCX/sygLQTAG1On+UqTVASHtSqmMi9zyOnMo9UPEnhWMRE9NLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=eHj0mfeE/EOyly5xUtGq8rmazujhmFPCCIldDauievA=;
	b=jPKC3BWNljdLts7t0NgGtsSDb51osJuDSPlEyzOuG/y/8s7lk9g9Dqn19Rtk+LXrFy2F
	 0AdEYK8lliIoiJWxmFXfLlFoGgR+hE5CFovsPeSWYpyuidBfeBe2ux43tj/vAE6cCGpbS
	 I6ngXc7iQNUvE7Svrp0XN1BBMcLv9lHmgB8CvXS40a5HTGqn5pQIipziM91k1uqr1UY2t
	 UkO9xWm8Oo8n5KzQGF3LnWE4/C+kXIfdVuR+hFh4PiE21eEeKDflG5IIf/mSeJfjLlW2x
	 JUszlVVPDlc3zeAGUkyPoaqHDB0jDhwvUqamqHwGWXHDUIXfU94xE4MfD5u0xwkLmLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Mg99Dt5f;
	arc=none smtp.remote-ip=209.85.210.69
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A1460A2622
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 02:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95A1460A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Mg99Dt5f
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-82169fb66c3so10091138a34.2
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 19:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793069815; x=1793674615; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eHj0mfeE/EOyly5xUtGq8rmazujhmFPCCIldDauievA=;
        b=Mg99Dt5f9PgDvqYVlgl8c31O4XCFobdYbasHqz0vZ3Z453x9Cu169KTim5QoUJPPSC
         nHfx1AtlJOhIClWjlPgsVjdALfH7GPjupyf6Dp3xMVeqG3u8HlgE+66kQHi2DfbnMPh2
         Gv4u15U6peFjC/w2cXo9kB4I+rlAdkeZUe97LhmkshSmxpARHBd83p6mE1tZT79ycGYA
         uuKuPjGd7fec+cQseJBj432K+9GFw8+435ZvWoC15gPKlbnO64Y3qUSkZWde7xdK9wJq
         FMudJb9QYquu3XuqEZSrHmBTno0Du+2CCA0j281eSrZgoDvB+zfbidSwTdECfgs3cQIt
         uB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793069815; x=1793674615;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eHj0mfeE/EOyly5xUtGq8rmazujhmFPCCIldDauievA=;
        b=0JIBkY1T/Y+Z/U2Tb7WGqJtiL13SZkADwzXQWoXfRlvfqs/6d3WZ83So+ltWCrsgq5
         TVUeB1Jn/9waS8BSdaSjC8qfVDWa2M8sbKf3B/fPExi4mIiEOEpx/+0UM+burGnF6sGW
         mZH0gaMr7j+GxHEVXoKvJ6KHx7clMwZV7Mo0M06YkqXzjm5XM7w2X8TS/ZCRaoeVokHd
         29VemYnNhW1jjbkZdDvq1nPgaIAPCsxWeWvdNwSxqKVtVkMkmCzQ/dYxp2lbIiV2oJwv
         MJt1y8xp+cjYMVlO+iMp3Axu89xncomxqh7W/nIVqkpiHuhV2Pq9x3N1HlFTygvSsm7N
         xAbg==
X-Gm-Message-State: AFq9FYJCpv1wtTMqF7rWwZ0mK2J6wIILb6/jITjQ331GbG5p+XOLqZSj
	9ZihOxl6tXAbfPoVsaYBPR7I/yCRJZXvFyuxlbA2Z/SlXRlFRhkavQJORwZaJkUN4dILCMIBQo6
	JzAB7yD5QOF5mP1s0fZdoxWAJs2/KtDc/mQ==
X-Received: from ioda11-n2.prod.google.com ([2002:a05:6602:204b:20b0:9c4:dfbe:8634])
 (user=kevinloughlin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:603:b0:70d:8086:e452 with SMTP id 006d021491bc7-70d8086eebemr3032864eaf.25.1793069815271;
 Mon, 26 Oct 2026 19:56:55 -0700 (PDT)
Date: Tue, 27 Oct 2026 02:56:12 +0000
In-Reply-To: <20261027025616.1632690-1-kevinloughlin@google.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261027025616.1632690-1-kevinloughlin@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027025616.1632690-10-kevinloughlin@google.com>
Subject: [PATCH 09/13] mm/page_reporting: account for unaccepted memory
From: Kevin Loughlin <kevinloughlin@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>, Jason Wang <jasowangio@gmail.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Alexander Duyck <alexanderduyck@fb.com>
Cc: virtualization@lists.linux.dev, linux-coco@lists.linux.dev, 
	linux-efi@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sidharth Telang <sidtelang@google.com>, Punit Salian <psalian@google.com>, 
	Peter Gonda <pgonda@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Jacky Li <jackyli@google.com>, Steve Rutherford <srutherford@google.com>, 
	David Skidmore <davidskidmore@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

When lazy unaccepted memory is active, pages on zone->unaccepted_pages
are counted in NR_FREE_PAGES (MIGRATE_MOVABLE) as well as NR_UNACCEPTED.
Without accounting for NR_UNACCEPTED in free page reporting watermarks,
page_reporting_process_zone() and __isolate_free_page() treat
unaccepted pages as already-accepted free buddy pages and can over-drain
accepted free lists.

Account for zone_page_state(zone, NR_UNACCEPTED) in
__isolate_free_page(), page_reporting_cycle(), and
page_reporting_process_zone() (using promo_wmark_pages(zone) for free
page reporting watermarks and skipping non-mergeable migratetypes when
has_unaccepted_memory() is active), and enforce
unaccepted_memory_order() as the minimum page_reporting_order.

Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 mm/page_alloc.c     |  3 +++
 mm/page_reporting.c | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c10b77304633..541b2eaf34a4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3183,6 +3183,9 @@ int __isolate_free_page(struct page *page, unsigned int order)
 		 * exists.
 		 */
 		watermark = zone->_watermark[WMARK_MIN] + (1UL << order);
+#ifdef CONFIG_UNACCEPTED_MEMORY
+		watermark += zone_page_state(zone, NR_UNACCEPTED);
+#endif
 		if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
 			return 0;
 	}
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index de587be17801..adacdb015b55 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -17,11 +17,14 @@ unsigned int page_reporting_order = PAGE_REPORTING_ORDER_UNSPECIFIED;
 
 static int page_order_update_notify(const char *val, const struct kernel_param *kp)
 {
+	unsigned int min_order = has_unaccepted_memory() ?
+				 unaccepted_memory_order() : 0;
+
 	/*
 	 * If param is set beyond this limit, order is set to default
 	 * pageblock_order value
 	 */
-	return  param_set_uint_minmax(val, kp, 0, MAX_PAGE_ORDER);
+	return param_set_uint_minmax(val, kp, min_order, MAX_PAGE_ORDER);
 }
 
 static const struct kernel_param_ops page_reporting_param_ops = {
@@ -206,6 +209,21 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 
 		/* Attempt to pull page from list and place in scatterlist */
 		if (*offset) {
+#ifdef CONFIG_UNACCEPTED_MEMORY
+			if (has_unaccepted_memory() ||
+			    !list_empty(&zone->unaccepted_pages)) {
+				unsigned long watermark;
+
+				watermark = promo_wmark_pages(zone) +
+					    zone_page_state(zone, NR_UNACCEPTED) +
+					    (1UL << order);
+				if (!zone_watermark_ok(zone, 0, watermark, 0,
+						       ALLOC_CMA)) {
+					next = page;
+					break;
+				}
+			}
+#endif
 			if (!__isolate_free_page(page, order)) {
 				next = page;
 				break;
@@ -275,6 +293,12 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 	/* Generate minimum watermark to be able to guarantee progress */
 	watermark = low_wmark_pages(zone) +
 		    (prdev->capacity << page_reporting_order);
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	if (has_unaccepted_memory() || !list_empty(&zone->unaccepted_pages))
+		watermark = promo_wmark_pages(zone) +
+			    zone_page_state(zone, NR_UNACCEPTED) +
+			    (prdev->capacity << page_reporting_order);
+#endif
 
 	/*
 	 * Cancel request if insufficient free memory or if we failed
@@ -289,6 +313,11 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 			/* We do not pull pages from the isolate free list */
 			if (is_migrate_isolate(mt))
 				continue;
+#ifdef CONFIG_UNACCEPTED_MEMORY
+			if (has_unaccepted_memory() &&
+			    !migratetype_is_mergeable(mt))
+				continue;
+#endif
 
 			err = page_reporting_cycle(prdev, zone, order, mt,
 						   sgl, &offset);
@@ -384,6 +413,9 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 		else
 			page_reporting_order = pageblock_order;
 	}
+	if (has_unaccepted_memory() &&
+	    page_reporting_order < unaccepted_memory_order())
+		page_reporting_order = unaccepted_memory_order();
 
 	if (!prdev->capacity || prdev->capacity > PAGE_REPORTING_CAPACITY)
 		prdev->capacity = PAGE_REPORTING_CAPACITY;
-- 
2.56.0.307.g5fe7bd680c-goog

