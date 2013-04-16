From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/2] rpmsg: fix kconfig dependencies for VIRTIO
Date: Tue, 16 Apr 2013 12:25:26 -0500
Message-ID: <1366133126-5448-1-git-send-email-s-anna__33232.1211616092$1366654613$gmane$org@ti.com>
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

rpmsg configuration selects VIRTIO, but VIRTIO is now
subordinate to VIRTUALIZATION. RPMSG is currently selected
by OMAP_REMOTEPROC, and the dependency warning is not seen
with the fix in remoteproc config, but the kconfig menu
hierarchy dependency has to be honored nevertheless.

warning: (VIRTIO_PCI && VIRTIO_MMIO && REMOTEPROC && RPMSG) selects VIRTIO which has unmet direct dependencies (VIRTUALIZATION)
warning: (VIRTIO_PCI && VIRTIO_MMIO && REMOTEPROC && RPMSG) selects VIRTIO which has unmet direct dependencies (VIRTUALIZATION)

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/rpmsg/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index f6e0ea6..370645c 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -3,6 +3,7 @@ menu "Rpmsg drivers"
 # RPMSG always gets selected by whoever wants it
 config RPMSG
 	tristate
+	select VIRTUALIZATION
 	select VIRTIO
 
 endmenu
-- 
1.8.2
