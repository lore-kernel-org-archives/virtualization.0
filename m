From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] drivers/vhost: remove depends on CONFIG_EXPERIMENTAL
Date: Fri, 22 Feb 2013 23:33:43 -0800
Message-ID: <20130223073343.GA5021__1636.271357029$1361644763$gmane$org@www.outflux.net>
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
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

The CONFIG_EXPERIMENTAL config item has not carried much meaning for a
while now and is almost always enabled by default. As agreed during the
Linux kernel summit, remove it from any "depends on" lines in Kconfigs.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Asias He <asias@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/Kconfig.blk |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/Kconfig.blk b/drivers/vhost/Kconfig.blk
index 831a121..eeffc8b 100644
--- a/drivers/vhost/Kconfig.blk
+++ b/drivers/vhost/Kconfig.blk
@@ -1,6 +1,6 @@
 config VHOST_BLK
-	tristate "Host kernel accelerator for virtio blk (EXPERIMENTAL)"
-	depends on BLOCK &&  EXPERIMENTAL && EVENTFD && m
+	tristate "Host kernel accelerator for virtio blk"
+	depends on BLOCK && EVENTFD && m
 	---help---
 	  This kernel module can be loaded in host kernel to accelerate
 	  guest block with virtio_blk. Not to be confused with virtio_blk
-- 
1.7.9.5


-- 
Kees Cook
Chrome OS Security
