From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v5 01/19] linux-headers/virtio_config: Update with
	VIRTIO_F_VERSION_1
Date: Tue,  2 Dec 2014 14:00:09 +0100
Message-ID: <1417525227-14051-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1417525227-14051-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417525227-14051-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Thomas Huth <thuth@linux.vnet.ibm.com>

Add the new VIRTIO_F_VERSION_1 definition to the virtio_config.h
linux header.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 linux-headers/linux/virtio_config.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-headers/linux/virtio_config.h b/linux-headers/linux/virtio_config.h
index 75dc20b..16aa289 100644
--- a/linux-headers/linux/virtio_config.h
+++ b/linux-headers/linux/virtio_config.h
@@ -54,4 +54,7 @@
 /* Can the device handle any descriptor layout? */
 #define VIRTIO_F_ANY_LAYOUT		27
 
+/* v1.0 compliant. */
+#define VIRTIO_F_VERSION_1		32
+
 #endif /* _LINUX_VIRTIO_CONFIG_H */
-- 
1.7.9.5
