From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH 2/3] Make virtio_pci license be GPL2+
Date: Wed,  2 Jan 2008 15:01:33 -0600
Message-ID: <11993076943581-git-send-email-aliguori@us.ibm.com>
References: <1199307694277-git-send-email-aliguori@us.ibm.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1199307694277-git-send-email-aliguori@us.ibm.com>
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
Cc: kvm-devel@lists.sourceforge.net, Anthony Liguori <aliguori@us.ibm.com>, Dor Laor <dor.laor@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch changes the virtio_pci license to be GPL2 or later.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 45ff193..f8df571 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -9,8 +9,8 @@
  * Authors:
  *  Anthony Liguori  <aliguori@us.ibm.com>
  *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  *
  */
 
diff --git a/include/linux/virtio_pci.h b/include/linux/virtio_pci.h
index 4b28409..82f22cd 100644
--- a/include/linux/virtio_pci.h
+++ b/include/linux/virtio_pci.h
@@ -9,8 +9,8 @@
  * Authors:
  *  Anthony Liguori  <aliguori@us.ibm.com>
  *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
  *
  */
