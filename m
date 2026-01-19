Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819B31EA7CB;
	Mon, 19 Jan 2026 23:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863841; cv=none; b=sBXEn5dvx+fnEZG7foSAOqpLNgubUaRI8GUXciRS3839m1qzkbtruiFxo5zfueuiaOrOhzQY3Ozbk9KVTQzYF5dM4dWUYN2kvsfcGzOHdCrpC6nCDws7VdjPHSSTwq1GVZ/xsLp5nlxL+00aqREzxbZ/sBjVWf2tAReWBPjcU0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863841; c=relaxed/simple;
	bh=GT7gMb9052k09b7feSno+zVM6CU/qsSXOXmaT6CsVkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AE7nxVMSlHf1+dYSRZW41cxHl9IIcZImCWtG5D1dcZfd9QiFHE5RVw79FkWV0SH+6R19Lw+zeSmQRLpWrHkslYKtlIlWAEU8l2W6JnsXeBA3j2M0O65jwuZ//zyi0Ll63tMO0S21ZVB6tFXFRTdOMcHuxjBxiCjk/pc+r1WRFCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Egk6IAbZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Egk6IAbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2698C19424;
	Mon, 19 Jan 2026 23:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768863841;
	bh=GT7gMb9052k09b7feSno+zVM6CU/qsSXOXmaT6CsVkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Egk6IAbZ0Z786ez2iuplNWTllT0uMarzPHhKBT5TZiJqtlB1NAfHjfRnXfav89zqN
	 IZuNVh/TQyEZFMB+SEqEhvAMYHiWSlEI9hGbWlZPR9VmWQGCb1P8u2S3huLb1RrMZ7
	 /whZLTSUXsQLHaVJB19h/E3ALFef1pmo3tU0nkzaMJl5ylg6TCKtJ3taeyXF/E+rRr
	 EgSufQo1nUeXpE5NmIYyHnHWrNT6/m+uPxYmKIPTi4EfE9Bwv273iA5QREtx6vPPv4
	 pJz5ClAL2L58t1rUTTBRoXIRMqQLNxU3RWRN6GUE6OcRKdRxaeWgTahjwjICqaOMkY
	 YSdJgeMAuzWng==
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
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
Subject: [PATCH v3 20/24] mm: rename balloon_compaction.(c|h) to balloon.(c|h)
Date: Tue, 20 Jan 2026 00:01:28 +0100
Message-ID: <20260119230133.3551867-21-david@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119230133.3551867-1-david@kernel.org>
References: <20260119230133.3551867-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even without CONFIG_BALLOON_COMPACTION this infrastructure implements
basic list and page management for a memory balloon.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
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
index 0d044a58cbfe0..de8f89ca1149f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27536,9 +27536,9 @@ M:	David Hildenbrand <david@kernel.org>
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
index 7fd8b3d7e7637..7a3c4922685ab 100644
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
index 6ae00de78b61b..de8041c3285a1 100644
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
index 9175f8cc65658..1e31e0a528dc1 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -122,7 +122,7 @@ obj-$(CONFIG_CMA)	+= cma.o
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
index bed30c6c1a487..25e2a1e71eba9 100644
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
2.52.0

