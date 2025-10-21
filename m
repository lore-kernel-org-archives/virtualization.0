Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEFE35503E
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051604; cv=none; b=oXo+rCOzFgj78xOeqKmaJp57x/RYCD8MlRGfMv76QvvexluK4B/vOH7sP91LlADyOlc9fuM3PHup76yMDrQOAR37U2F35dcVKntvHueiKgoour7TclXBf4vF7EzqqL5s2SvCAy/wUCZJS7SXNLXT9AYOH6STsFkfYLNV4yhG1v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051604; c=relaxed/simple;
	bh=kfpHhOMhCTafFElzJiRv8QNBxHxjmeSCOSw1fMkjaaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Bs15LhVB08Wa1QHZiwKJ+6TqLt4u1BvGGo0wnFKvqwqGqvSDBefEsXu4zeinvCjqkKiHSvpkB3WPdCn9R4LMtg9MYgL02MHQzrGJYYXLhlabYR4dACSW2YrVkEFHWsPOa803pULSQeVaVbj/Dq3eAllMi2G4UeOOULRD9++iXsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JlB0TUE5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlB0TUE5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sGRFD+OUXBdzIHwpdd8L6KTTXumWjBTMpIxo57Gp8oE=;
	b=JlB0TUE5d89afzbi2aLkKHpeW2Xk9kD3oFKfInd15bkyyU1YhP+31ORjBmmSawCJ/LZspq
	E7haArKCu598FNlHuc5HI2r5zL2fepeH+KX4DJKNxiL8D9oASkB3C4V3zZUc14eJLdRu2H
	50r5FjDqoGCvzFv/7c4VRQEg5rfEK/4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-2H90RvM_Mga3E0BE5OadEg-1; Tue, 21 Oct 2025 08:59:58 -0400
X-MC-Unique: 2H90RvM_Mga3E0BE5OadEg-1
X-Mimecast-MFC-AGG-ID: 2H90RvM_Mga3E0BE5OadEg_1761051597
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee888281c3so9987240f8f.3
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 05:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051597; x=1761656397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGRFD+OUXBdzIHwpdd8L6KTTXumWjBTMpIxo57Gp8oE=;
        b=wGySEESBo8jvUhp2NwEq/x1kKGatsOpuOjAkz5I0nieM5drK5pAyqPUZgyhWxFmi9b
         PUctI6iGismxeB/giUQ0TaF+KfdEV8L5NTt/TJ3HOIX9UP+boEw0H2DWNeaDwq1k8XXo
         6fXFnd4nhKSSnh7UdPdDh6ewBLMhMPWVE1d9U363wh1OrOuBbPc5a3oEg0LjWhf6qO3t
         xhdUz+iYaLS1nAbsA/u2nAQoK5jSqQbHJ8w042z1vGH0QfeLWOACcyrLKCc0PbNvoYG+
         q6WkDiQK9u+ZPvV9Q4MIBbkMWhV5I+eZUXrHMkba8tLuZxdc+PpDGqmRSKy9qL1Fs+fG
         10ow==
X-Forwarded-Encrypted: i=1; AJvYcCV1KW1+EgT6PpTXoeROUpiP0C8zN6DKMKTdFSw+9t4hQkiHfV27B2eC2LE2GVTBitolAoMpHxWnL8N0UkUTDw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/Ncm82EXClJ7lcMMTHC0ZnzH76kkP4bdaDndSYXdzkeJzpyK8
	PNfN8+33UsqeWuz9+sHrJ8N9WuyoFyFs6fSGRs1hRifQvVDpo5Vko3oRzE36+690VB70MEBz5RD
	26pQAwviYfZkWdqi5jbrp8LAG9+yrVvjFkfeqlbV9LdlyRaSjcyHRZtR2+Nyc6OHSoDZX
X-Gm-Gg: ASbGncurizD096cSsumRUa6RLcwRFUCOsHqy3lEQ5dILmWYEzO04/q3KIefPL56a2Ry
	Bo39XdX8rjDvOsJvsCaFIYcfTFlQBjOeQy3ujrSfIFc84jOJ3aToN2TgmwmxZfkjxQvPRu43iuN
	1SoL+WhHtTBfRjUGwJsbdpdtRFG2EFWroW4KbGyJ975uKBzZG6DCEQF4o2zMsS2F/C9ckuF6tUU
	zhv0zXBKFnWSoFEDHviPEtJ6r+mJfAhKJMgOqns1EMZDK/z7eu4QhIMGWS6QvGOAQjLqnA3IJAn
	j39p4K2CIfi6p/OVKgLFqQsJ9ndn39n0hO923mPcrC6FxbUOcFS3B5oQtbm/PydL29pvo7Jk02k
	OoF02rFI9TX3rcRJ5Gr4+TVO29Zejck6fyUcqZ4RnTvEtyETwc0lgGhyWpAA+
X-Received: by 2002:a05:6000:2284:b0:400:7e60:7ee0 with SMTP id ffacd0b85a97d-42704c8848cmr11160766f8f.0.1761051597340;
        Tue, 21 Oct 2025 05:59:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1yccRPZwAQwYfj1DMBRFBsRJJ5k0BROkzwajkMvCNAUgq3lYo09LUN84ZfbVlOv9dAfW2Ig==
X-Received: by 2002:a05:6000:2284:b0:400:7e60:7ee0 with SMTP id ffacd0b85a97d-42704c8848cmr11160739f8f.0.1761051596931;
        Tue, 21 Oct 2025 05:59:56 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00b9f9dsm20357223f8f.39.2025.10.21.05.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:59:56 -0700 (PDT)
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
Subject: [PATCH v1 11/23] drivers/virtio/virtio_balloon: stop using balloon_page_push/pop()
Date: Tue, 21 Oct 2025 14:59:16 +0200
Message-ID: <20251021125929.377194-12-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: WH8tFNztJWofDJ_CA_AzcxQLBOIUPzwsYyEshcOb82o_1761051597
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's stop using these function so we can remove them. They look like
belonging to the balloon API for managing the device balloon list when
really they are just simple helpers only used by virtio-balloon.

Let's just inline them and switch to a proper
list_for_each_entry_safe().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index f7d6a4a6e54f5..4b22de6a5f845 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -242,8 +242,8 @@ static void set_page_pfns(struct virtio_balloon *vb,
 static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 {
 	unsigned int num_allocated_pages;
+	struct page *page, *next;
 	unsigned int num_pfns;
-	struct page *page;
 	LIST_HEAD(pages);
 
 	/* We can only do one array worth at a time. */
@@ -262,14 +262,15 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 			break;
 		}
 
-		balloon_page_push(&pages, page);
+		list_add(&page->lru, &pages);
 	}
 
 	mutex_lock(&vb->balloon_lock);
 
 	vb->num_pfns = 0;
 
-	while ((page = balloon_page_pop(&pages))) {
+	list_for_each_entry_safe(page, next, &pages, lru) {
+		list_del(&page->lru);
 		balloon_page_enqueue(&vb->vb_dev_info, page);
 
 		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
@@ -474,15 +475,19 @@ static inline s64 towards_target(struct virtio_balloon *vb)
 static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
 					     unsigned long num_to_return)
 {
-	struct page *page;
-	unsigned long num_returned;
+	unsigned long num_returned = 0;
+	struct page *page, *next;
+
+	if (unlikely(!num_to_return))
+		return 0;
 
 	spin_lock_irq(&vb->free_page_list_lock);
-	for (num_returned = 0; num_returned < num_to_return; num_returned++) {
-		page = balloon_page_pop(&vb->free_page_list);
-		if (!page)
-			break;
+
+	list_for_each_entry_safe(page, next, &vb->free_page_list, lru) {
+		list_del(&page->lru);
 		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
+		if (++num_returned == num_to_return)
+			break;
 	}
 	vb->num_free_page_blocks -= num_returned;
 	spin_unlock_irq(&vb->free_page_list_lock);
@@ -717,7 +722,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
 		}
 		virtqueue_kick(vq);
 		spin_lock_irq(&vb->free_page_list_lock);
-		balloon_page_push(&vb->free_page_list, page);
+		list_add(&page->lru, &vb->free_page_list);
 		vb->num_free_page_blocks++;
 		spin_unlock_irq(&vb->free_page_list_lock);
 	} else {
-- 
2.51.0

