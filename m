From: Takuma Umeya <tumeya@redhat.com>
Subject: [PATCH] virtio: decrement dev_index when device is unregistered
Date: Tue, 5 Apr 2011 00:49:26 -0400 (EDT)
Message-ID: <66015840.659833.1301978966706.JavaMail.root__17926.1627178223$1301979110$gmane$org@zmail07.collab.prod.int.phx2.redhat.com>
References: <1457566934.641329.1301903526622.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1457566934.641329.1301903526622.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Stephen Hemminger <shemminger@vyatta.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

When virtio device is removed, dev_index does not get decremented. 
The next device hotplug event results in consuming the next pci to 
the one that is suppose to be available. 

Signed-off-by: Takuma Umeya <tumeya@redhat.com>

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index efb35aa..67fe71d 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -216,6 +216,7 @@ EXPORT_SYMBOL_GPL(register_virtio_device);
 void unregister_virtio_device(struct virtio_device *dev)
 {
        device_unregister(&dev->dev);
+       dev_index--;
 }
 EXPORT_SYMBOL_GPL(unregister_virtio_device);
 

-- 
Umeya, Takuma
Technical Account Manager
Red Hat GSS APAC
+81.3.5798.8584 (direct)
tumeya@redhat.com
