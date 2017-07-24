From: Andrew Jones <drjones@redhat.com>
Subject: [PATCH] virtio-net: fix module unloading
Date: Mon, 24 Jul 2017 15:38:32 +0200
Message-ID: <20170724133832.27364-1-drjones@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Unregister the driver before removing multi-instance hotplug
callbacks. This order avoids the warning issued from
__cpuhp_remove_state_cpuslocked when the number of remaining
instances isn't yet zero.

Fixes: 8017c279196a ("net/virtio-net: Convert to hotplug state machine")
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 99a26a9efec1..f41ab0ea942a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2743,9 +2743,9 @@ module_init(virtio_net_driver_init);
 
 static __exit void virtio_net_driver_exit(void)
 {
+	unregister_virtio_driver(&virtio_net_driver);
 	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
 	cpuhp_remove_multi_state(virtionet_online);
-	unregister_virtio_driver(&virtio_net_driver);
 }
 module_exit(virtio_net_driver_exit);
 
-- 
2.13.3
