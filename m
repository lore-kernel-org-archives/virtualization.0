From: Vincent Legoll <vincent.legoll@gmail.com>
Subject: [PATCH] virtio: make VIRTIO a menuconfig to ease disabling it all
Date: Sun,  7 Jan 2018 12:33:56 +0100
Message-ID: <20180107113356.2806-1-vincent.legoll__28366.466650232$1515324768$gmane$org@gmail.com>
References: <459e2097-f20a-18f8-17d9-2d9ed011211d@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <459e2097-f20a-18f8-17d9-2d9ed011211d@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Vincent Legoll <vincent.legoll@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

No need to get into the submenu to disable all VIRTIO-related
config entries.

This makes it easier to disable all VIRTIO config options
without entering the submenu. It will also enable one
to see that en/dis-abled state from the outside menu.

This is only intended to change menuconfig UI, not change
the config dependencies.

v2: Added "default y" to avoid breaking existing configs
v3: Fixed wrong indentation, added *-by from Randy

Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # works for me
---
 drivers/virtio/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index cff773f15b7e..35897649c24f 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -5,7 +5,11 @@ config VIRTIO
 	  bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RPMSG
 	  or CONFIG_S390_GUEST.
 
-menu "Virtio drivers"
+menuconfig VIRTIO_MENU
+	bool "Virtio drivers"
+	default y
+
+if VIRTIO_MENU
 
 config VIRTIO_PCI
 	tristate "PCI driver for virtio devices"
@@ -79,4 +83,4 @@ config VIRTIO_MMIO_CMDLINE_DEVICES
 
 	 If unsure, say 'N'.
 
-endmenu
+endif # VIRTIO_MENU
-- 
2.14.1
