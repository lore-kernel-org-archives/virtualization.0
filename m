From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/6] tools/virtio: fix vringh test
Date: Mon, 15 Dec 2014 00:04:23 +0200
Message-ID: <1418594542-22623-3-git-send-email-mst@redhat.com>
References: <1418594542-22623-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1418594542-22623-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Include missing virtio_config.h

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/vringh_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 9d4b1bc..13e0a76 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -7,6 +7,7 @@
 #include <linux/virtio.h>
 #include <linux/vringh.h>
 #include <linux/virtio_ring.h>
+#include <linux/virtio_config.h>
 #include <linux/uaccess.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-- 
MST
