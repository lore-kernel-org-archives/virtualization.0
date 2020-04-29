From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] vhost: fix default for vhost_iotlb
Date: Wed, 29 Apr 2020 16:23:04 +0200
Message-ID: <20200429142317.1847441-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

During randconfig build testing, I ran into a configuration that has
CONFIG_VHOST=m, CONFIG_VHOST_IOTLB=m and CONFIG_VHOST_RING=y, which
makes the iotlb implementation left out from vhost_ring, and in turn
leads to a link failure of the vdpa_sim module:

ERROR: modpost: "vringh_set_iotlb" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
ERROR: modpost: "vringh_init_iotlb" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
ERROR: modpost: "vringh_iov_push_iotlb" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
ERROR: modpost: "vringh_iov_pull_iotlb" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
ERROR: modpost: "vringh_complete_iotlb" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
ERROR: modpost: "vringh_getdesc_iotlb" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!

Work around it by setting the default for VHOST_IOTLB to avoid this
configuration.

Fixes: e6faeaa12841 ("vhost: drop vring dependency on iotlb")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I fixed this a while ago locally but never got around to sending the
fix. If the problem has been addressed differently in the meantime,
please ignore this one.
---
 drivers/vhost/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index 2c75d164b827..ee5f85761024 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config VHOST_IOTLB
 	tristate
+	default y if VHOST=m && VHOST_RING=y
 	help
 	  Generic IOTLB implementation for vhost and vringh.
 	  This option is selected by any driver which needs to support
-- 
2.26.0
