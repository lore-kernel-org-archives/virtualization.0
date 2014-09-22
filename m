From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio: refactor to use drv_to_virtio
Date: Mon, 22 Sep 2014 11:03:31 +0300
Message-ID: <1411372905-12649-1-git-send-email-mst@redhat.com>
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
Cc: linux-s390@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Siva Yerramreddy <yshivakrishna@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Sudeep Dutt <sudeep.dutt@intel.com>, virtualization@lists.linux-foundation.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Use drv_to_virtio instead of open-coding it.
Fix whitespace damage introduced by
	virtio: unify config_changed handling

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Note: I'll probably smash this into the previous patch.

 drivers/virtio/virtio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 470b74f..3980687 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -241,8 +241,7 @@ EXPORT_SYMBOL_GPL(unregister_virtio_device);
 
 void virtio_config_changed(struct virtio_device *dev)
 {
-        struct virtio_driver *drv = container_of(dev->dev.driver,
-						 struct virtio_driver, driver);
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 
 	if (drv && drv->config_changed)
 		drv->config_changed(dev);
-- 
MST
