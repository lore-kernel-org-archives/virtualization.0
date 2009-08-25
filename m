From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 2/3] virtio-console: rename dvq to ovq
Date: Tue, 25 Aug 2009 11:47:23 +0530
Message-ID: <1251181044-3696-4-git-send-email-amit.shah__37131.28853492$1251181330$gmane$org@redhat.com>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<1251181044-3696-2-git-send-email-amit.shah@redhat.com>
	<1251181044-3696-3-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1251181044-3696-3-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

It isn't obvious what 'dvq' stands for. Since it's the output queue and
the corresponding input queue is called 'ivq', call this 'ovq'

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 hw/virtio-console.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio-console.c b/hw/virtio-console.c
index 663c8b9..92c953c 100644
--- a/hw/virtio-console.c
+++ b/hw/virtio-console.c
@@ -20,7 +20,7 @@
 typedef struct VirtIOConsole
 {
     VirtIODevice vdev;
-    VirtQueue *ivq, *dvq;
+    VirtQueue *ivq, *ovq;
     CharDriverState *chr;
 } VirtIOConsole;
 
@@ -135,7 +135,7 @@ VirtIODevice *virtio_console_init(DeviceState *dev)
     s->vdev.get_features = virtio_console_get_features;
 
     s->ivq = virtio_add_queue(&s->vdev, 128, virtio_console_handle_input);
-    s->dvq = virtio_add_queue(&s->vdev, 128, virtio_console_handle_output);
+    s->ovq = virtio_add_queue(&s->vdev, 128, virtio_console_handle_output);
 
     s->chr = qdev_init_chardev(dev);
     qemu_chr_add_handlers(s->chr, vcon_can_read, vcon_read, vcon_event, s);
-- 
1.6.2.5
