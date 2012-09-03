From: Kent Overstreet <koverstreet@google.com>
Subject: [PATCH] virtio-blk: Fix kconfig option
Date: Sun, 2 Sep 2012 21:41:33 -0700
Message-ID: <20120903044133.GA9980__8815.55354358188$1346779812$gmane$org@moria.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, mst@redhat.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CONFIG_VIRTIO isn't exposed, everything else is supposed to select it
instead.

Signed-off-by: Kent Overstreet <koverstreet@google.com>
---
 drivers/block/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index a796407..d4e1d12 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -521,7 +521,8 @@ config XEN_BLKDEV_BACKEND
 
 config VIRTIO_BLK
 	tristate "Virtio block driver (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && VIRTIO
+	select VIRTIO
+	depends on EXPERIMENTAL
 	---help---
 	  This is the virtual block driver for virtio.  It can be used with
           lguest or QEMU based VMMs (like KVM or Xen).  Say Y or M.
-- 
1.7.10.4
