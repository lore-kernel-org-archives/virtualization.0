From: Dor Laor <dor.laor@gmail.com>
Subject: [kvm-devel] [Virtio-for-kvm] [PATCH 13/13] [Mostly resend] virtio
 additions
Date: Fri, 21 Dec 2007 17:27:33 +0200
Message-ID: <476BDB65.1090006__49739.2859812409$1198250996$gmane$org@qumranet.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>Anthony Liguori <a>
List-Id: virtualization@lists.linuxfoundation.org

 From 9f5a551d7e2a00eb019b158f8f3130e8176ec27c Mon Sep 17 00:00:00 2001
From: Dor Laor <dor.laor@qumranet.com>
Date: Mon, 17 Dec 2007 01:40:15 +0200
Subject: [PATCH] Update all status fields on driver unload

Both VIRTIO_CONFIG_S_DRIVER and VIRTIO_CONFIG_S_DRIVER_OK should
be cleaned upon driver unload.

Signed-off-by: Dor Laor <dor.laor@qumranet.com>
---
 drivers/virtio/virtio.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 212f4e3..05d5f62 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -103,7 +103,8 @@ static int virtio_dev_remove(struct device *_d)
                          struct virtio_driver, driver);
 
     dev->config->set_status(dev, dev->config->get_status(dev)
-                & ~VIRTIO_CONFIG_S_DRIVER);
+                & ~(VIRTIO_CONFIG_S_DRIVER |
+                    VIRTIO_CONFIG_S_DRIVER_OK));
     drv->remove(dev);
     return 0;
 }
-- 
1.5.3.3
