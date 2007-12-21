From: Dor Laor <dor.laor@gmail.com>
Subject: [Virtio-for-kvm] [PATCH 5/7] userspace virtio
Date: Fri, 21 Dec 2007 16:44:20 +0200
Message-ID: <476BD144.7050702__36167.2153151177$1198248357$gmane$org@qumranet.com>
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
To: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rus>
List-Id: virtualization@lists.linuxfoundation.org

 From 35a03164c1b4d138e55898853212bded14cf4ec7 Mon Sep 17 00:00:00 2001
From: Dor Laor <dor.laor@qumranet.com>
Date: Mon, 17 Dec 2007 01:43:28 +0200
Subject: [PATCH] Check for device status on tx.

Allow tx only if VIRTIO_CONFIG_S_DRIVER_OK.
It can prevent an smp race of tx and driver unload.

Signed-off-by: Dor Laor <dor.laor@qumranet.com>
---
 qemu/hw/virtio-net.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/qemu/hw/virtio-net.c b/qemu/hw/virtio-net.c
index 3320dd8..f6f1f28 100644
--- a/qemu/hw/virtio-net.c
+++ b/qemu/hw/virtio-net.c
@@ -140,6 +140,9 @@ static void virtio_net_handle_tx(VirtIODevice *vdev, 
VirtQueue *vq)
     VirtIONet *n = to_virtio_net(vdev);
     VirtQueueElement elem;
 
+    if (!(n->vdev.status & VIRTIO_CONFIG_S_DRIVER_OK))
+        return;
+
     while (virtqueue_pop(vq, &elem)) {
     int i;
     size_t len = 0;
-- 
1.5.3.3
