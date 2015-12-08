From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] vhost: vsock: select CONFIG_VHOST
Date: Tue, 08 Dec 2015 16:46:08 +0100
Message-ID: <36261336.7BBY96nNaM__25329.6364135624$1449589611$gmane$org@wuerfel>
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
To: netdev@vger.kernel.org
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Asias He <asias@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

When building the new vsock code without vhost, we get a build error:

drivers/built-in.o: In function `vhost_vsock_flush':
:(.text+0x24d29c): undefined reference to `vhost_poll_flush'

This adds an explicit 'select' like we have for the other vhost
drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/vhost/Kconfig.vsock | 2 ++
 1 file changed, 2 insertions(+)

The patch causing the problem is currently in net-next, so the fix should be
applied on top of that.

diff --git a/drivers/vhost/Kconfig.vsock b/drivers/vhost/Kconfig.vsock
index 3491865d3eb9..bfb9edc4b5d6 100644
--- a/drivers/vhost/Kconfig.vsock
+++ b/drivers/vhost/Kconfig.vsock
@@ -2,6 +2,8 @@ config VHOST_VSOCK
 	tristate "vhost virtio-vsock driver"
 	depends on VSOCKETS && EVENTFD
 	select VIRTIO_VSOCKETS_COMMON
+	select VHOST
+	select VHOST_RING
 	default n
 	---help---
 	Say M here to enable the vhost-vsock for virtio-vsock guests
-- 
2.1.0.rc2
