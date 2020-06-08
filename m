From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] vhost/test: fix up after API change
Date: Mon, 8 Jun 2020 08:42:56 -0400
Message-ID: <20200608124254.727184-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Pass a flag to request kernel thread use.

Fixes: 01fcb1cbc88e ("vhost: allow device that does not depend on vhost worker")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index f55cb584b84a..12304eb8da15 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -122,7 +122,7 @@ static int vhost_test_open(struct inode *inode, struct file *f)
 	vqs[VHOST_TEST_VQ] = &n->vqs[VHOST_TEST_VQ];
 	n->vqs[VHOST_TEST_VQ].handle_kick = handle_vq_kick;
 	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV + 64,
-		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, NULL);
+		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, true, NULL);
 
 	f->private_data = n;
 
-- 
MST
