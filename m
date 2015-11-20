From: Ming Lin <mlin@kernel.org>
Subject: [RFC PATCH 1/9] nvme-vhost: add initial commit
Date: Thu, 19 Nov 2015 16:21:00 -0800
Message-ID: <1447978868-17138-2-git-send-email-mlin@kernel.org>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1447978868-17138-1-git-send-email-mlin@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-nvme@lists.infradead.org
Cc: Ming Lin <ming.l@ssi.samsung.com>, Christoph Hellwig <hch@lst.de>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Ming Lin <ming.l@ssi.samsung.com>

Signed-off-by: Ming Lin <ming.l@ssi.samsung.com>
---
 drivers/nvme/target/Kconfig  | 11 +++++++++++
 drivers/nvme/target/Makefile |  2 ++
 drivers/nvme/target/vhost.c  | 16 ++++++++++++++++
 3 files changed, 29 insertions(+)
 create mode 100644 drivers/nvme/target/vhost.c

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 1bf92db..22760f5 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -12,3 +12,14 @@ config NVME_TARGET_LOOP
 	  to test NVMe host and target side features.
 
 	  If unsure, say N.
+
+config NVME_TARGET_VHOST
+	tristate "NVMe vhost support"
+	depends on BLK_DEV_NVME
+	select NVME_TARGET
+	select VHOST
+	select VHOST_RING
+	help
+	  This enabled the NVMe vhost support.
+
+	  If unsure, say N.
diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index 21e9134..1d8d523 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -1,6 +1,8 @@
 
 obj-$(CONFIG_NVME_TARGET)		+= nvmet.o
 obj-$(CONFIG_NVME_TARGET_LOOP)		+= nvme-loop.o
+obj-$(CONFIG_NVME_TARGET_VHOST)		+= nvme-vhost.o
 
 nvmet-y		+= core.o configfs.o admin-cmd.o io-cmd.o
 nvme-loop-y	+= loop.o
+nvme-vhost-y	+= vhost.o
diff --git a/drivers/nvme/target/vhost.c b/drivers/nvme/target/vhost.c
new file mode 100644
index 0000000..623af00
--- /dev/null
+++ b/drivers/nvme/target/vhost.c
@@ -0,0 +1,16 @@
+#include <linux/module.h>
+
+static int __init nvmet_vhost_init(void)
+{
+	return 0;
+}
+module_init(nvmet_vhost_init);
+
+static void nvmet_vhost_exit(void)
+{
+}
+module_exit(nvmet_vhost_exit);
+
+MODULE_AUTHOR("Ming Lin <ming.l@ssi.samsung.com>");
+MODULE_LICENSE("GPL v2");
+
-- 
1.9.1
