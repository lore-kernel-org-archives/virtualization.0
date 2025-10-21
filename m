Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E33342179
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058860; cv=none; b=DaVLMpeEMvYxOj1aS9sRCrPGKM2jO5y/4tc0YBkS2rPe6CZm06i/2WF5u2zI+gl94i+P+/X5E+acimuyhW9EKr1UGxhXXoOnaL3CR73emntLh/6kKIuTAgCBJPm6WMbRQj9qzghUHRjjn5bhGj97VGlVXY8uMQQxACpg+i+VDuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058860; c=relaxed/simple;
	bh=UwyM5R0KhWLgF6qfrYdIVk7mDfPJ06uK23mjZEGNIoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=BU7AazJSvq22rkz8pLoWvxIll28Yg/lzcPisaV9SifGOgUI8jJirf83Z7XJmQHRmY0Y+ltciwZMlwMPzw1HH1yM4QDIWYt01BJkbMmyLZHw+JIHNrlh1ToHKJ0hx7Gj66DFkb0U9R8tF5VkPQLxpCYRPGGx64WFApHH7WquQjwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7JB6/hI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7JB6/hI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761058858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IxeaoFY2Zid2XlBwuhP3Cbqf0hU6HwUeKjXEu5WpZgc=;
	b=V7JB6/hIdOZaKish/r4jEtA1qiCosg6Ans6+oToHefEw58S2Lwedfzl5Gee7UgsryAs4BC
	MmrhqxSuW8QgwFc73M5iVqA0X/I4KRiZJ2mzubO3ZOw1a6LtcydHXb/rfP72S9BPEKRYhO
	nPl763MAB6Uwc1dII0WmCzXLY5FKymY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-ZmHG0j7ONv6_HDjV79yKMQ-1; Tue, 21 Oct 2025 11:00:56 -0400
X-MC-Unique: ZmHG0j7ONv6_HDjV79yKMQ-1
X-Mimecast-MFC-AGG-ID: ZmHG0j7ONv6_HDjV79yKMQ_1761058855
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-471168953bdso41190235e9.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 08:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058855; x=1761663655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxeaoFY2Zid2XlBwuhP3Cbqf0hU6HwUeKjXEu5WpZgc=;
        b=s69A1SwtH+454kgjhttgcuKGlzDiYb88NHgOuonb0Hlu83gT6OvB/AJeEuM7pbkR7n
         r1bV57bepIU9S6sNqIGobmbKPGJzgtot7l4+v0kRpSQscASPaqyWghZU3ed+U2dPpK+P
         Fi5JCzRemDEnFk5ZQZbLTPRefCp0PiBzn+TVrvxJiXaS7jN/GhmhR4duU0smyU5JJTYm
         IHov4pd0pVCWutpo9gn+J5LMg0AAQAg1rNSDsuOxFwpGutuq8ESsaCgkR8HKGmzswiZ8
         Dg3I06LokK9QJ/F4PqQWYRVIPmOsfZpgih+baPd0mNO5EsYolDuXvuRWNKdrj5Ibu6VQ
         AqPg==
X-Forwarded-Encrypted: i=1; AJvYcCVq9HNpMIqxMOejW/VQJ1LjyyaZK/9zB8hNs1bFoQEp5YB9eyBnX1ahHLt/iqpMjDeyyx2hrXOGbzfrveCCkw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaVv9pspr40F+xYNy0WDC09PV997ShGSQEvf4FOZMV9g6GcmmT
	mWQN40/iR+IPeveUfezqkSW/Kp6snfodNYlj7eIkbkqkAgqhCwRdn4xprGzr5bi4ESeQC6g2nlw
	XL8Dd27zGNkMRlwcPmvpUsCFObjtLqKDd5Zrace2KMkyZFee6UdzBZ+nXq55bDpOCZLcM
X-Gm-Gg: ASbGncuQ+/KWGEdpjlyf2eQyjA4BnaaxELBoXs679tPETbeBMxqRvDSXUYUQkG5bFng
	YuKB7gp0UpL22G2RRvmM/g2zK9YQF5596pmxlAm9j6FaBeD5sOJC03F3+F2/BovbAa4Wk2C2kSM
	Mv9IMDHuJ3lBNXg7FEBGL3hGLDXwPZViyuccCX70j1k53auhGFTkGRItygBvayC6vWkULZMBnOp
	NFq9wbgn9VItJ4D+FqAh8bT4T5JE0Pk5fC8EeFCaCQHPr0nT6BRZAG4defm49uZjJb1YbAAQpF6
	HQCJJvfZWvCB7dWcf9guhWDsZf2xUD9LK/wVTSTVFWhG3zg5vht7ZCakl6okWUSz1HBkYpgaOp3
	9aBmxUdDgnH/rnTXvaiNfXiiXYGf4NquOlC7VaJ+IWIMrvsJJ6Qc04gPkUoTK
X-Received: by 2002:a05:600c:6d87:b0:46f:cdfe:cd39 with SMTP id 5b1f17b1804b1-475c3ee145emr177085e9.16.1761058855002;
        Tue, 21 Oct 2025 08:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTNQTiGz5xAhZ5fsddDZjV1qS7LKojQZq7D4oRaNBiv/doXb8XOAkbt7nBaFlt+DyqmCX9Sw==
X-Received: by 2002:a05:600c:6d87:b0:46f:cdfe:cd39 with SMTP id 5b1f17b1804b1-475c3ee145emr176645e9.16.1761058854422;
        Tue, 21 Oct 2025 08:00:54 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-471144c82b8sm285435185e9.15.2025.10.21.08.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:00:53 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
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
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 22/23] mm: rename CONFIG_MEMORY_BALLOON -> CONFIG_BALLOON
Date: Tue, 21 Oct 2025 17:00:39 +0200
Message-ID: <20251021150040.498160-6-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021150040.498160-1-david@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021150040.498160-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h0E2-vXb1l9R47Hwe1Als7gQmtklQTSfF-5O5XYqaLw_1761058855
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's make it consistent with the naming of the files but also with the
naming of CONFIG_BALLOON_MIGRATION.

While at it, add a "/* CONFIG_BALLOON */".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/pseries/Kconfig | 2 +-
 drivers/misc/Kconfig                   | 2 +-
 drivers/virtio/Kconfig                 | 2 +-
 include/linux/vm_event_item.h          | 4 ++--
 mm/Kconfig                             | 4 ++--
 mm/Makefile                            | 2 +-
 mm/vmstat.c                            | 4 ++--
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 3e042218d6cd8..f7052b131a4c5 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -120,7 +120,7 @@ config PPC_SMLPAR
 config CMM
 	tristate "Collaborative memory management"
 	depends on PPC_SMLPAR
-	select MEMORY_BALLOON
+	select BALLOON
 	default y
 	help
 	  Select this option, if you want to enable the kernel interface
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index b9c11f67315f0..47da8dfcffc2b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -411,7 +411,7 @@ config DS1682
 config VMWARE_BALLOON
 	tristate "VMware Balloon Driver"
 	depends on VMWARE_VMCI && X86 && HYPERVISOR_GUEST
-	select MEMORY_BALLOON
+	select BALLOON
 	help
 	  This is VMware physical memory management driver which acts
 	  like a "balloon" that can be inflated to reclaim physical pages
diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 6db5235a7693d..ce5bc0d9ea287 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -112,7 +112,7 @@ config VIRTIO_PMEM
 config VIRTIO_BALLOON
 	tristate "Virtio balloon driver"
 	depends on VIRTIO
-	select MEMORY_BALLOON
+	select BALLOON
 	select PAGE_REPORTING
 	help
 	 This driver supports increasing and decreasing the amount
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index fca34d3473b6b..22a139f82d75f 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -122,13 +122,13 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_SWPOUT,
 		THP_SWPOUT_FALLBACK,
 #endif
-#ifdef CONFIG_MEMORY_BALLOON
+#ifdef CONFIG_BALLOON
 		BALLOON_INFLATE,
 		BALLOON_DEFLATE,
 #ifdef CONFIG_BALLOON_MIGRATION
 		BALLOON_MIGRATE,
 #endif /* CONFIG_BALLOON_MIGRATION */
-#endif
+#endif /* CONFIG_BALLOON */
 #ifdef CONFIG_DEBUG_TLBFLUSH
 		NR_TLB_REMOTE_FLUSH,	/* cpu tried to flush others' tlbs */
 		NR_TLB_REMOTE_FLUSH_RECEIVED,/* cpu received ipi for flush */
diff --git a/mm/Kconfig b/mm/Kconfig
index c058a65080d1e..73e352bb82653 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -593,7 +593,7 @@ config SPLIT_PMD_PTLOCKS
 
 #
 # support for memory balloon
-config MEMORY_BALLOON
+config BALLOON
 	bool
 
 #
@@ -601,7 +601,7 @@ config MEMORY_BALLOON
 config BALLOON_MIGRATION
 	bool "Allow for balloon memory migration"
 	default y
-	depends on MIGRATION && MEMORY_BALLOON
+	depends on MIGRATION && BALLOON
 	help
 	  Allow for migration of pages inflated in a memory balloon such that
 	  they can be allocated from memory areas only available for movable
diff --git a/mm/Makefile b/mm/Makefile
index ab012157b5109..315aec23d78f5 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -121,7 +121,7 @@ obj-$(CONFIG_CMA)	+= cma.o
 obj-$(CONFIG_NUMA) += numa.o
 obj-$(CONFIG_NUMA_MEMBLKS) += numa_memblks.o
 obj-$(CONFIG_NUMA_EMU) += numa_emulation.o
-obj-$(CONFIG_MEMORY_BALLOON) += balloon.o
+obj-$(CONFIG_BALLOON) += balloon.o
 obj-$(CONFIG_PAGE_EXTENSION) += page_ext.o
 obj-$(CONFIG_PAGE_TABLE_CHECK) += page_table_check.o
 obj-$(CONFIG_CMA_DEBUGFS) += cma_debug.o
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8843a8c4914c4..542378df0bf75 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1431,13 +1431,13 @@ const char * const vmstat_text[] = {
 	[I(THP_SWPOUT)]				= "thp_swpout",
 	[I(THP_SWPOUT_FALLBACK)]		= "thp_swpout_fallback",
 #endif
-#ifdef CONFIG_MEMORY_BALLOON
+#ifdef CONFIG_BALLOON
 	[I(BALLOON_INFLATE)]			= "balloon_inflate",
 	[I(BALLOON_DEFLATE)]			= "balloon_deflate",
 #ifdef CONFIG_BALLOON_MIGRATION
 	[I(BALLOON_MIGRATE)]			= "balloon_migrate",
 #endif /* CONFIG_BALLOON_MIGRATION */
-#endif /* CONFIG_MEMORY_BALLOON */
+#endif /* CONFIG_BALLOON */
 #ifdef CONFIG_DEBUG_TLBFLUSH
 	[I(NR_TLB_REMOTE_FLUSH)]		= "nr_tlb_remote_flush",
 	[I(NR_TLB_REMOTE_FLUSH_RECEIVED)]	= "nr_tlb_remote_flush_received",
-- 
2.51.0

