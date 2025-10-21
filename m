Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D3C341AD3
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058855; cv=none; b=ImxA8j5nzyOoU5mslG2c3kVxowIHlnaLS8Af0N+ePKLRE0BvJAYPaU3lAGGPByRN+qiMgjpCUVZx/nzSamZbLyRPlVWVK0lc8wjZuloRKBtBrJ5FbLIBMsyO46cITuaLJspCi0nh+tfIPShlA8OKkHlKPA84oxsNiIvk7tAmz6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058855; c=relaxed/simple;
	bh=ptuaLzDjZgkWF1wvDAN8KY/453EoHUcLMwhjUdNpArU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=k0ePBB72p64PMB+OObxTY/go93vMyVvsv7Iq9CqCGV0RvOAlzE56LF5LfuPnPEN8KzNRU7BCWPJKEqNdUraMEonOW3oURbAeWkVPEHuH8mcPF1tz3cJPlLnT5TfSfxvJ1hhOXx66BeHbxBv0+5ZoMSbpMrGpeOOdU7qbr7L7bA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d4bl53Xx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4bl53Xx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761058852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WXJD5DBTOSdH4OFa5cGG6Bl5vxCoyITjfVMpwdlj+A=;
	b=d4bl53Xxjk6Wg0CLOqNB2uiJwGlSAmerfsOId6xaTrbwKL6ciLozBfz+cSAzT7t6ZHHZmm
	SH61Tm3ySokLUuGX+DWM6wJS1QlqQKoWS1zjVJQ7BUsPMKL1SYWV5mbltMllYKKIXZQt83
	EMMsDFKALhEWwRDV9qL8rarNnPQNe3Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-rvRFVgiaMuOyxioWSYj9CQ-1; Tue, 21 Oct 2025 11:00:49 -0400
X-MC-Unique: rvRFVgiaMuOyxioWSYj9CQ-1
X-Mimecast-MFC-AGG-ID: rvRFVgiaMuOyxioWSYj9CQ_1761058848
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47106a388cfso25931045e9.0
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 08:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058848; x=1761663648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WXJD5DBTOSdH4OFa5cGG6Bl5vxCoyITjfVMpwdlj+A=;
        b=Px8leS5CcGjO57vebQY14Os+1b+KpQcPnbVjQ5B2wUp/+ZBx+MXVPozmZUA7Ez7OJD
         Zjc/8PPprgNONuqlpvNxXkKeLy+MynD8bJ5skC9mjWWYz2EVBrDgGWZRFOlZKm9iC8Kc
         OKWKTa07R0XA2zJZXEh3yLePNnhWUKugU36Qtu65qRvV9Oa2oD0xGWE/l0KKkN20sMVV
         XfWNhdp72tZRO/E1Ebn/w9ir6awt9eW6NTP48WCvGlsiT4jFisaLMygs5rIQeK40+LiL
         SnK+GLRxPXUM8RbOcRyuC/rwwHjp7AXEijyK11zqd5GoPYacJr1y0od0CgNJrnasulzx
         EWKw==
X-Forwarded-Encrypted: i=1; AJvYcCVbQGbeqR23/JL6c1UXkWxHxnxC/gcAfiQXM+w+QOOzleSuI5poyEgbxSgCM4ULpYoXnFOXTT5fYeKe8rcJig==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJQrp1nSpoS5e10IU821Bg6sXNSPHiqEGDb8fONh2J9n+xX7MF
	6q/WorywaAUE1LNvuMijyDxNq0+ahg58V826pn1249G5Nsq5dBE3vuEWvsszVQJ2/A3cJyG9GnC
	yKiap7Lh303KRq4/f4yV7QGIY79zHE3bFBsk6tRYDQc6pwO7cUs0D3ASOqV5wwdeh3xHHE8lqBk
	GG
X-Gm-Gg: ASbGncubMvdhuWOoriG7L5xEXlloylgHJLYQzxLzBqV8hj4oIqc3V0ByN3IMtPkJFRa
	dWYE6b0gNxKi6aJprvA6ixE9C8YEbxrcCD3xOeSSgnrKjbT4vi+NX5TzzZuzmGUlLhQkZTjGoPs
	YM/u5nRp/QR4IygG4FPpeTCWyHIcQ4LykJXM4OofKWohN5Zbe6YlwQDZ6JIwWKhhtEE4drdxt5K
	2imAaQke90Vwhfpnf5vt+rVYBVs0U9yu/5fnGAMsvru6J+UsVSUYBWyUSX3rRdHVQpUcUK+R+3M
	MZZtPqq3c4eYnuT8HhtknOugsEzqXde8f+S9IalI35gm0qHNTvm9QmS/cxOWoWcHxG6AtsQQRRR
	m/eOuL+OjNERsHK/hqJAuPYsQHcKHr8KzpJsAOtB0Mf1dWGPB7cB6Q+rg70SK
X-Received: by 2002:a05:600c:4e89:b0:46f:b42e:e392 with SMTP id 5b1f17b1804b1-47117931c1dmr117960755e9.39.1761058848115;
        Tue, 21 Oct 2025 08:00:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDebz8te/SdK4RMl9FXThAzS3UlvHbYsiUZ1AXYYoG1U9LkInArDMPFE9fh7553nINZVhlvg==
X-Received: by 2002:a05:600c:4e89:b0:46f:b42e:e392 with SMTP id 5b1f17b1804b1-47117931c1dmr117959965e9.39.1761058847485;
        Tue, 21 Oct 2025 08:00:47 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-471144b5c91sm283508025e9.11.2025.10.21.08.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:00:47 -0700 (PDT)
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
Subject: [PATCH v1 19/23] mm: rename balloon_compaction.(c|h) to balloon.(c|h)
Date: Tue, 21 Oct 2025 17:00:36 +0200
Message-ID: <20251021150040.498160-3-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: GxoUspPMqsG-nfcNjkeQ79SwHEpbK3Q8obV9DDLiNVo_1761058848
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Even without CONFIG_BALLOON_COMPACTION this infrastructure implements
basic list and page management for a memory balloon.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/core-api/mm-api.rst                 |  2 +-
 MAINTAINERS                                       |  4 ++--
 arch/powerpc/platforms/pseries/cmm.c              |  2 +-
 drivers/misc/vmw_balloon.c                        |  2 +-
 drivers/virtio/virtio_balloon.c                   |  2 +-
 include/linux/{balloon_compaction.h => balloon.h} | 11 +++++------
 mm/Makefile                                       |  2 +-
 mm/{balloon_compaction.c => balloon.c}            |  7 +++----
 8 files changed, 15 insertions(+), 17 deletions(-)
 rename include/linux/{balloon_compaction.h => balloon.h} (92%)
 rename mm/{balloon_compaction.c => balloon.c} (98%)

diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
index 68193a4cfcf52..aabdd3cba58e8 100644
--- a/Documentation/core-api/mm-api.rst
+++ b/Documentation/core-api/mm-api.rst
@@ -130,5 +130,5 @@ More Memory Management Functions
 .. kernel-doc:: mm/vmscan.c
 .. kernel-doc:: mm/memory_hotplug.c
 .. kernel-doc:: mm/mmu_notifier.c
-.. kernel-doc:: mm/balloon_compaction.c
+.. kernel-doc:: mm/balloon.c
 .. kernel-doc:: mm/huge_memory.c
diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968e..878e53d0f65ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27062,9 +27062,9 @@ M:	David Hildenbrand <david@redhat.com>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/virtio/virtio_balloon.c
-F:	include/linux/balloon_compaction.h
+F:	include/linux/balloon.h
 F:	include/uapi/linux/virtio_balloon.h
-F:	mm/balloon_compaction.c
+F:	mm/balloon.c
 
 VIRTIO BLOCK AND SCSI DRIVERS
 M:	"Michael S. Tsirkin" <mst@redhat.com>
diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 9ed71683ae402..c5aee15e192ea 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -19,7 +19,7 @@
 #include <linux/stringify.h>
 #include <linux/swap.h>
 #include <linux/device.h>
-#include <linux/balloon_compaction.h>
+#include <linux/balloon.h>
 #include <asm/firmware.h>
 #include <asm/hvcall.h>
 #include <asm/mmu.h>
diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 53e9335b6718c..7fd3f709108c2 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -29,7 +29,7 @@
 #include <linux/rwsem.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/balloon_compaction.h>
+#include <linux/balloon.h>
 #include <linux/vmw_vmci_defs.h>
 #include <linux/vmw_vmci_api.h>
 #include <asm/hypervisor.h>
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 4b22de6a5f845..5434a7739d588 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -13,7 +13,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/balloon_compaction.h>
+#include <linux/balloon.h>
 #include <linux/oom.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon.h
similarity index 92%
rename from include/linux/balloon_compaction.h
rename to include/linux/balloon.h
index 7757e0e314fdb..82585542300d6 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon.h
@@ -1,8 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * include/linux/balloon_compaction.h
- *
- * Common interface definitions for making balloon pages movable by compaction.
+ * Common interface for implementing a memory balloon, including support
+ * for migration of pages inflated in a memory balloon.
  *
  * Balloon page migration makes use of the general "movable_ops page migration"
  * feature.
@@ -35,8 +34,8 @@
  *
  * Copyright (C) 2012, Red Hat, Inc.  Rafael Aquini <aquini@redhat.com>
  */
-#ifndef _LINUX_BALLOON_COMPACTION_H
-#define _LINUX_BALLOON_COMPACTION_H
+#ifndef _LINUX_BALLOON_H
+#define _LINUX_BALLOON_H
 #include <linux/pagemap.h>
 #include <linux/page-flags.h>
 #include <linux/migrate.h>
@@ -75,4 +74,4 @@ static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 	balloon->migratepage = NULL;
 	balloon->adjust_managed_page_count = false;
 }
-#endif /* _LINUX_BALLOON_COMPACTION_H */
+#endif /* _LINUX_BALLOON_H */
diff --git a/mm/Makefile b/mm/Makefile
index 21abb33535501..ab012157b5109 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -121,7 +121,7 @@ obj-$(CONFIG_CMA)	+= cma.o
 obj-$(CONFIG_NUMA) += numa.o
 obj-$(CONFIG_NUMA_MEMBLKS) += numa_memblks.o
 obj-$(CONFIG_NUMA_EMU) += numa_emulation.o
-obj-$(CONFIG_MEMORY_BALLOON) += balloon_compaction.o
+obj-$(CONFIG_MEMORY_BALLOON) += balloon.o
 obj-$(CONFIG_PAGE_EXTENSION) += page_ext.o
 obj-$(CONFIG_PAGE_TABLE_CHECK) += page_table_check.o
 obj-$(CONFIG_CMA_DEBUGFS) += cma_debug.o
diff --git a/mm/balloon_compaction.c b/mm/balloon.c
similarity index 98%
rename from mm/balloon_compaction.c
rename to mm/balloon.c
index f41e4a179a431..5734dae81e318 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon.c
@@ -1,15 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * mm/balloon_compaction.c
- *
- * Common interface for making balloon pages movable by compaction.
+ * Common interface for implementing a memory balloon, including support
+ * for migration of pages inflated in a memory balloon.
  *
  * Copyright (C) 2012, Red Hat, Inc.  Rafael Aquini <aquini@redhat.com>
  */
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/export.h>
-#include <linux/balloon_compaction.h>
+#include <linux/balloon.h>
 
 /*
  * Lock protecting the balloon_dev_info of all devices. We don't really
-- 
2.51.0

