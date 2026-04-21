Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988402BE621
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808933; cv=none; b=mGk4vXxmDiDFNre6vZiJFr7q12v4AleJe5ZL25PEXfkF37xFhvHOH8QyfteXSE0J3hrU9LBFGU2ym31vytnmk/eio1SKu4LxaDS3vOlwS7/CdIO+fFO607LSFKzq8XKP1EeLYhec8MvIlkgLSqwTc6SnAxPHNbScRJkvY56Tf/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808933; c=relaxed/simple;
	bh=ArOZv9uCSES6WoLoP2qfLy3zOOTQa3tVnsSTEE/uUjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PQH7YZhxS6F+3W2mwc8EUtyQfChaPS/b9i1BJ2sjozSkEcbKTnVrOoLYEJhUpCgXwQVBM+NgxdfLSl25bkKCEO3dkOh91zUwCQeqDVTWeObhFauwgzdhmA54y4qV9YoiUWEJFw8g/Sni3lHkOMXbWlVR1rAjcwlACCncNI2BPfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZkKWhXWb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZkKWhXWb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b5ITR8zgbYah+ZxSMqe409RlUP6fQP6IKxEaDIol6Sg=;
	b=ZkKWhXWb0Y3TzEDpEbSGliUNPYLOxxRqI+lql9xqqcxpZMWluk3iIiaaCidNTIOoKdKu7I
	ju0vm7mKjviRFbAfqn+UqbPTuvxjjufI30izfSnWY/H0P/MD3r0o9pFgSmDgbT3ZZmNpxg
	KTYiRHr8fiH4aB+XzjeksTvmfU32NHc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-ZuSwLoquO56OSy3s_xq2Bw-1; Tue, 21 Apr 2026 18:02:09 -0400
X-MC-Unique: ZuSwLoquO56OSy3s_xq2Bw-1
X-Mimecast-MFC-AGG-ID: ZuSwLoquO56OSy3s_xq2Bw_1776808928
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d121c4271so3415779f8f.3
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808928; x=1777413728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5ITR8zgbYah+ZxSMqe409RlUP6fQP6IKxEaDIol6Sg=;
        b=XmYX7QKFCAtfCTUDxASzbmuRWyFo00U2imJLhncTwsnFgyqLOCPxSsncC1h7bOtJFj
         iZhRZAmS7aooxHH5sg1yDuRm0zvqRmYBh4UJNkHUSjxH878eE6EHpSham66Un1jwEdGg
         uL/ycHsQmsaxrPHloxRPWhT2WPYKd6hshn85Z6Nk08/ptS1Lqc1sb8SAgfdQjtsQDajZ
         TCsLCRs5Lc0ZCqSB3/ZIuRixpn6RjGit9fcvG4GYU4CBcVv1nDNqMVX9tmerPtf0XMJ9
         NtA+AToSz3ZkuYAjs/wXAO7Uw8GS9csuEf1Ire04mtxd6WrP0Bkb+ZaGlN55uge6HtR4
         nn7g==
X-Forwarded-Encrypted: i=1; AFNElJ8gi9sZuWyHt2Hc3HvNLeqXC2R4ynkBjFPTTh2EvR5XBlcmC7/ipIp0cKmFk5usMOwOinKP2CbxkYsf6LcAWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxH2aRfrX5PU+G4KA8kWrudE2gFnVdPeOTJOuhRWSShTyu3HzW0
	nCBM/rS/+B/+/YCOoNGQC9FuuhINnQt5+8JM4E6EWzk/BtETBYlEaWZLr7cYKmfYczh90dDbyM5
	Fg4szvHTSxFZktzItZcMooVuHTgdQflIsjUQ5wrz+d7ggQfpoObyfTpR9MtEhGGKazEJJ
X-Gm-Gg: AeBDietnm44Y0WVM7y09QzhP/bO/KGV6mKWKTeicc8NTlukydiyqQ4RxMoh++eRNl67
	TM6bLgzRTnHSR8gTW5M5cHumNbOyFJCnuIzndfC0ZbmCm8zxmPFC5JZxvA1/aoRbskhRU9Ik48N
	Hyyl6ka1EDgLszma115a6fiw7ONWhV5LuLrRjizNyc9hpC/hEK9YbyIu6Sg46uovFaTzKg2nOPZ
	1dUEV4ucImaSewO5Yq1Q49184gmbICbKjXNDD4cuFxzWj9+EmG1mU4Gy2TeidQELHsU5vzjvLF9
	lQnmApONKMn3BZT+IMThENHlJR+sgCJAZmk4F1lNFw3FX7ji3tW9WKEUOi2usDHUEG/sgao8geT
	7oETpGue88IcorZcWWXrXdpi8qnt9MxukO70z6GMHzDw0GyJi4GUu1w==
X-Received: by 2002:a05:600c:1da1:b0:488:79a3:f04c with SMTP id 5b1f17b1804b1-488fb7863femr300220455e9.27.1776808928263;
        Tue, 21 Apr 2026 15:02:08 -0700 (PDT)
X-Received: by 2002:a05:600c:1da1:b0:488:79a3:f04c with SMTP id 5b1f17b1804b1-488fb7863femr300219935e9.27.1776808927735;
        Tue, 21 Apr 2026 15:02:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5549f582sm28914685e9.33.2026.04.21.15.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:02:06 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:02:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>
Subject: [PATCH RFC v3 16/19] mm: add put_page_zeroed and folio_put_zeroed
Message-ID: <d06416b80bb505e8ded9f96bd28f0a63678e4a97.1776808210.git.mst@redhat.com>
References: <cover.1776808209.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776808209.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iZdfLjWjOHTxYoPmsuntgK72g32YR_9c4nFP2YM956U_1776808928
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add put_page_zeroed() / folio_put_zeroed() for callers that hold
a reference to a page known to be zeroed.

If this drops the last reference, the page goes through
__folio_put_zeroed() which calls free_frozen_pages_zeroed() so
the zeroed hint is preserved.  If someone else still holds a
reference, the hint is simply lost -- this is best-effort.

This is useful for balloon drivers during deflation: the host
has already zeroed the pages, and the balloon is typically the
sole owner.  But if the page happens to be shared, silently
dropping the hint is safe and avoids the need for callers to
check the refcount.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/mm.h | 12 ++++++++++++
 mm/swap.c          | 18 ++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 821034dd33d1..878544830369 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1640,6 +1640,7 @@ static inline struct folio *virt_to_folio(const void *x)
 }
 
 void __folio_put(struct folio *folio);
+void __folio_put_zeroed(struct folio *folio);
 
 void split_page(struct page *page, unsigned int order);
 void folio_copy(struct folio *dst, struct folio *src);
@@ -1817,6 +1818,17 @@ static inline void folio_put(struct folio *folio)
 		__folio_put(folio);
 }
 
+static inline void folio_put_zeroed(struct folio *folio)
+{
+	if (folio_put_testzero(folio))
+		__folio_put_zeroed(folio);
+}
+
+static inline void put_page_zeroed(struct page *page)
+{
+	folio_put_zeroed(page_folio(page));
+}
+
 /**
  * folio_put_refs - Reduce the reference count on a folio.
  * @folio: The folio.
diff --git a/mm/swap.c b/mm/swap.c
index bb19ccbece46..5d05a463b46a 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -94,7 +94,7 @@ static void page_cache_release(struct folio *folio)
 		unlock_page_lruvec_irqrestore(lruvec, flags);
 }
 
-void __folio_put(struct folio *folio)
+static void ___folio_put(struct folio *folio, bool zeroed)
 {
 	if (unlikely(folio_is_zone_device(folio))) {
 		free_zone_device_folio(folio);
@@ -109,10 +109,24 @@ void __folio_put(struct folio *folio)
 	page_cache_release(folio);
 	folio_unqueue_deferred_split(folio);
 	mem_cgroup_uncharge(folio);
-	free_frozen_pages(&folio->page, folio_order(folio));
+	if (zeroed)
+		free_frozen_pages_zeroed(&folio->page, folio_order(folio));
+	else
+		free_frozen_pages(&folio->page, folio_order(folio));
+}
+
+void __folio_put(struct folio *folio)
+{
+	___folio_put(folio, false);
 }
 EXPORT_SYMBOL(__folio_put);
 
+void __folio_put_zeroed(struct folio *folio)
+{
+	___folio_put(folio, true);
+}
+EXPORT_SYMBOL(__folio_put_zeroed);
+
 typedef void (*move_fn_t)(struct lruvec *lruvec, struct folio *folio);
 
 static void lru_add(struct lruvec *lruvec, struct folio *folio)
-- 
MST

