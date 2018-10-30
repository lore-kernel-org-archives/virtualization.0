From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] vhost: Fix Spectre V1 vulnerability
Date: Tue, 30 Oct 2018 14:10:49 +0800
Message-ID: <20181030061049.7424-1-jasowang__47435.8971151107$1540879755$gmane$org@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com
Cc: Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Josh Poimboeuf <jpoimboe@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The idx in vhost_vring_ioctl() was controlled by userspace, hence a
potential exploitation of the Spectre variant 1 vulnerability.

Fixing this by sanitizing idx before using it to index d->vqs.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index f52008bb8df7..3a5f81a66d34 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -30,6 +30,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
 #include <linux/interval_tree_generic.h>
+#include <linux/nospec.h>
 
 #include "vhost.h"
 
@@ -1387,6 +1388,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 	if (idx >= d->nvqs)
 		return -ENOBUFS;
 
+	idx = array_index_nospec(idx, d->nvqs);
 	vq = d->vqs[idx];
 
 	mutex_lock(&vq->mutex);
-- 
2.17.1
