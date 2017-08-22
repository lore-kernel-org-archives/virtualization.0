From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: [PATCH] net/virtio-net: reverse unregistering on exit
Date: Tue, 22 Aug 2017 16:59:52 +0200
Message-ID: <1503413992-29558-2-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1503413992-29558-1-git-send-email-pmorel@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1503413992-29558-1-git-send-email-pmorel@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

unregister_virtio_driver should be done before the unregistering of
the hotplug state machine callbacks, otherwise the state machine still
holds some instance states at that time.

Let's first unregister the virtio_net_driver first and then the hotplug
state machine callbacks.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 143d8a9..c042ffd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2734,9 +2734,9 @@ module_init(virtio_net_driver_init);
 
 static __exit void virtio_net_driver_exit(void)
 {
+	unregister_virtio_driver(&virtio_net_driver);
 	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
 	cpuhp_remove_multi_state(virtionet_online);
-	unregister_virtio_driver(&virtio_net_driver);
 }
 module_exit(virtio_net_driver_exit);
 
-- 
2.7.4
