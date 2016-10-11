From: Juergen Gross <jgross@suse.com>
Subject: [PATCH] virtio: remove config.c
Date: Tue, 11 Oct 2016 11:02:14 +0200
Message-ID: <1476176534-15815-1-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Remove unused file config.c

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/virtio/config.c | 12 ------------
 1 file changed, 12 deletions(-)
 delete mode 100644 drivers/virtio/config.c

diff --git a/drivers/virtio/config.c b/drivers/virtio/config.c
deleted file mode 100644
index f70bcd2..0000000
--- a/drivers/virtio/config.c
+++ /dev/null
@@ -1,12 +0,0 @@
-/* Configuration space parsing helpers for virtio.
- *
- * The configuration is [type][len][... len bytes ...] fields.
- *
- * Copyright 2007 Rusty Russell, IBM Corporation.
- * GPL v2 or later.
- */
-#include <linux/err.h>
-#include <linux/virtio.h>
-#include <linux/virtio_config.h>
-#include <linux/bug.h>
-
-- 
2.6.6
