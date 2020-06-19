From: Weilong Chen <chenweilong@huawei.com>
Subject: [PATCH] virtio-mem: Fix build error due to improper use 'select'
Date: Fri, 19 Jun 2020 16:03:33 +0800
Message-ID: <20200619080333.194753-1-chenweilong@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, lizefan@huawei.com
Cc: linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

As noted in:
https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt
"select should be used with care. select will force a symbol to a
value without visiting the dependencies."
Config VIRTIO_MEM should not select CONTIG_ALLOC directly.
Otherwise it will cause an error:
https://bugzilla.kernel.org/show_bug.cgi?id=208245

Signed-off-by: Weilong Chen <chenweilong@huawei.com>
---
 drivers/virtio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 5809e5f5b157..5c92e4a50882 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -85,7 +85,7 @@ config VIRTIO_MEM
 	depends on VIRTIO
 	depends on MEMORY_HOTPLUG_SPARSE
 	depends on MEMORY_HOTREMOVE
-	select CONTIG_ALLOC
+	depends on CONTIG_ALLOC
 	help
 	 This driver provides access to virtio-mem paravirtualized memory
 	 devices, allowing to hotplug and hotunplug memory.
-- 
2.17.1
