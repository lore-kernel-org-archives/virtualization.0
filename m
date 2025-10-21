Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777A433B952
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051614; cv=none; b=UXMDflTg2P4fjudCytl4qEbfNGssUtCABRUE9QZcEllIu6BJMDQNLeJRGvmBy0lGFoQL78EfjAW90C69uSd2Y2lS5oliE4qgbNsV0zOnMNUTNxez7fpvK/f3wa6JX3P3OU+TYR9RwbpwvYZDXtWUMxHmWPW/bzNRJ4NNePeJxNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051614; c=relaxed/simple;
	bh=3g40vwKIgUFnbs436ZCx9Q+N4KveSscj8YcW5wyilic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=kPdST3IWotVNOdXZEaEwjW3cKInrsV1ULrj/vfhH3ffQYVVgXRk7yuR1Vj2cefP5NnfwtLYty377liXIfteCjaGrXzvoV+/ZjR+zTE/WvLywhECWMvzar6drEMmXFWIyrwjB9+JF+WeMz8QvPjvD2+O4gCQeSnvOdvKVky5/wok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XNH737iv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNH737iv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Pfle03AoZbMZzwKNT9cqn8RCz4Fl59OlkWq00/g7dM=;
	b=XNH737ivJLyY279nXf6078U0LCKbbnePWbY5JXKXJAb0iHQIVrxbCp/xgD2zUF6jvNzpQD
	OkDYtkf1lj5pJTNyMN0cTByIBDgAPWroAS2c3D6jiwUpPn+pI6SKGuAc8B7FNk+lzYj1aM
	MU13+um8JMKPnDpFrxJM2EvtgzTppAc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-WUuX9Q2UNHqssYzMFP6_hQ-1; Tue, 21 Oct 2025 09:00:10 -0400
X-MC-Unique: WUuX9Q2UNHqssYzMFP6_hQ-1
X-Mimecast-MFC-AGG-ID: WUuX9Q2UNHqssYzMFP6_hQ_1761051609
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47113dcc1e0so46435685e9.3
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 06:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051609; x=1761656409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Pfle03AoZbMZzwKNT9cqn8RCz4Fl59OlkWq00/g7dM=;
        b=JscAbsxfUfKXD9zC7EbVIDat8aOrJBZJUbiDx+nrGW/rIsFFQoabIhC3xIMaFpg3mr
         2TdSjYLZF80qkLPKgcYmRFUm0XmNCqY5afsOgoQP2rl13HpDHsDRXSRSA31Q42ugmpwd
         poR1yc1i9oJWQsNh1JS74fOh9sFgJPVF8kS6/PTnpFi6n9KDHNZQFvCtcEkXlZUUaNt1
         QvuOJaLu7N60fr6elvkYKJyuWlE6dDkwT8DBwGV3vLx1iCfB8HQ9h2bNSS42623WDh/p
         OonCQ41R6H040XFKnRbNMjx72BpaG19w2vHD4Wi+30oUDfEQHkvrn/5UnWgXyyTck29r
         VvTw==
X-Forwarded-Encrypted: i=1; AJvYcCVVgVTIXy06EuAAv86LdSAWnX17PVCucH3kUdX9NbD6G24GHdsbk8C68uvpqCfHfH3XwjD1ycVFc7YldEOJPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKqmWyLAxLBPzYWYtUaUwjajNrj4hBVJzx0I6btb0BtpHkRHvG
	yEX8jPmHncMdSPll6wzCjUk684moSqJuFqZ+CdB3M/ccvg1lZ0PFp3TYeFlJs0g9nuK6N0oFC8B
	uhFh17jegB2RXCz/LYkPY23v/n/DwUreXXDyFCbPviWBHXjNochZSSx9Gl4TX79SS264q
X-Gm-Gg: ASbGncvsRtziWam9bIHOmr1LmhLSvvvhl52MWBsJ+iuhPFAozEPi5jxbANmGHc6EbF9
	eStXMammkMGgZIxOk4y0X6QfknX7OpPTws+viufGuv+jrit8FGYYHYEuGYDu3Mdv5RS51FDuOCD
	sVZDXS2Qfq/SOSQtpyXepknKyk74MkgA0n+FVudqf42lK1v1NcWB/2Gqro2RwuIX98WJY56NCXv
	DYjShFCVuXYyf//0Ds3prMfwkNa3T/j7GpctRGXmRSBC1qkfWL1h9rM3T32hihHGy7Qa3DTJ7/U
	Xv7I65o6gdeu86qWXjIctiFT65m2l9VtOKk6jof7uVbe9CxtSMi7c0fioIxyVfQM9qG2ViH9bVR
	anEDXaanXSldE3uL0VjB/YKO8Gtc6U4TR1bkAr0yAXXWUEek3dOgwEZTBedx8
X-Received: by 2002:a05:600c:3544:b0:471:c72:c80b with SMTP id 5b1f17b1804b1-471178ad7b3mr117596025e9.18.1761051608640;
        Tue, 21 Oct 2025 06:00:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYkNMmF6KwTjIi+haTZNa/bZuoGNP9fBOncPRUCNa1fBr3A4oaQbG8grM5Ui4vLJ4xvDadAQ==
X-Received: by 2002:a05:600c:3544:b0:471:c72:c80b with SMTP id 5b1f17b1804b1-471178ad7b3mr117595585e9.18.1761051608200;
        Tue, 21 Oct 2025 06:00:08 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-471143663afsm278506055e9.0.2025.10.21.06.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:00:07 -0700 (PDT)
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
Subject: [PATCH v1 16/23] mm/balloon_compaction: mark remaining functions for having proper kerneldoc
Date: Tue, 21 Oct 2025 14:59:21 +0200
Message-ID: <20251021125929.377194-17-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: pFUr-QeZKF_l1Lm-h3GYPJk4wOC8P8Ii9EamDu_utDQ_1761051609
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Looks like all we are missing for proper kerneldoc is another "*".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/balloon_compaction.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index f6e0582bd7ffe..f41e4a179a431 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -22,7 +22,7 @@ static inline struct balloon_dev_info *balloon_page_device(struct page *page)
 	return (struct balloon_dev_info *)page_private(page);
 }
 
-/*
+/**
  * balloon_page_insert - insert a page into the balloon's page list and make
  *			 the page->private assignment accordingly.
  * @balloon : pointer to balloon device
@@ -42,7 +42,7 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 	list_add(&page->lru, &balloon->pages);
 }
 
-/*
+/**
  * balloon_page_finalize - prepare a balloon page that was removed from the
  *			   balloon list for release to the page allocator
  * @page: page to be released to the page allocator
@@ -140,7 +140,7 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 }
 EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
 
-/*
+/**
  * balloon_page_alloc - allocates a new page for insertion into the balloon
  *			page list.
  *
@@ -163,7 +163,7 @@ struct page *balloon_page_alloc(void)
 }
 EXPORT_SYMBOL_GPL(balloon_page_alloc);
 
-/*
+/**
  * balloon_page_enqueue - inserts a new page into the balloon page list.
  *
  * @b_dev_info: balloon device descriptor where we will insert a new page
@@ -186,7 +186,7 @@ void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
 }
 EXPORT_SYMBOL_GPL(balloon_page_enqueue);
 
-/*
+/**
  * balloon_page_dequeue - removes a page from balloon's page list and returns
  *			  its address to allow the driver to release the page.
  * @b_dev_info: balloon device descriptor where we will grab a page from.
-- 
2.51.0

