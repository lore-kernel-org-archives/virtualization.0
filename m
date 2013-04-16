From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/2] remoteproc: fix kconfig dependencies for VIRTIO
Date: Tue, 16 Apr 2013 12:25:11 -0500
Message-ID: <1366133111-5412-1-git-send-email-s-anna__38312.5174128965$1366654604$gmane$org@ti.com>
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
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Suman Anna <s-anna@ti.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

remoteproc configuration selects VIRTIO, but VIRTIO is now
subordinate to VIRTUALIZATION. VIRTUALIZATION has to be
selected as well to honor the kconfig menu hierarchy and fix
the dependency warnings.

warning: (VIRTIO_PCI && VIRTIO_MMIO && REMOTEPROC && RPMSG) selects VIRTIO which has unmet direct dependencies (VIRTUALIZATION)
warning: (VIRTIO_PCI && VIRTIO_MMIO && REMOTEPROC && RPMSG) selects VIRTIO which has unmet direct dependencies (VIRTUALIZATION)

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index c6d77e2..e5f6183 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -5,6 +5,7 @@ config REMOTEPROC
 	tristate
 	depends on HAS_DMA
 	select FW_LOADER
+	select VIRTUALIZATION
 	select VIRTIO
 
 config OMAP_REMOTEPROC
-- 
1.8.2
