From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 09/10] virtio_pci: update file descriptions and copyright
Date: Mon, 8 Dec 2014 17:16:55 +0200
Message-ID: <1418051779-27748-10-git-send-email-mst__30665.4740278193$1418051926$gmane$org@redhat.com>
References: <1418051779-27748-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1418051779-27748-1-git-send-email-mst@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

There's been a lot of changes since 2007.
List main authors, add Red Hat copyright.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci.h        | 5 ++++-
 drivers/virtio/virtio_pci.c        | 5 ++++-
 drivers/virtio/virtio_pci_legacy.c | 5 ++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci.h b/drivers/virtio/virtio_pci.h
index a3b1259..fba383c 100644
--- a/drivers/virtio/virtio_pci.h
+++ b/drivers/virtio/virtio_pci.h
@@ -1,15 +1,18 @@
 #ifndef _DRIVERS_VIRTIO_VIRTIO_PCI_H
 #define _DRIVERS_VIRTIO_VIRTIO_PCI_H
 /*
- * Virtio PCI driver
+ * Virtio PCI driver - APIs for common functionality for all device versions
  *
  * This module allows virtio devices to be used over a virtual PCI device.
  * This can be used with QEMU based VMMs like KVM or Xen.
  *
  * Copyright IBM Corp. 2007
+ * Copyright Red Hat, Inc. 2014
  *
  * Authors:
  *  Anthony Liguori  <aliguori@us.ibm.com>
+ *  Rusty Russell <rusty@rustcorp.com.au>
+ *  Michael S. Tsirkin <mst@redhat.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index d73ceec..5d6bc77 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -1,13 +1,16 @@
 /*
- * Virtio PCI driver
+ * Virtio PCI driver - common functionality for all device versions
  *
  * This module allows virtio devices to be used over a virtual PCI device.
  * This can be used with QEMU based VMMs like KVM or Xen.
  *
  * Copyright IBM Corp. 2007
+ * Copyright Red Hat, Inc. 2014
  *
  * Authors:
  *  Anthony Liguori  <aliguori@us.ibm.com>
+ *  Rusty Russell <rusty@rustcorp.com.au>
+ *  Michael S. Tsirkin <mst@redhat.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 9fdec9a..1ca4422 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -1,13 +1,16 @@
 /*
- * Virtio PCI driver
+ * Virtio PCI driver - legacy device support
  *
  * This module allows virtio devices to be used over a virtual PCI device.
  * This can be used with QEMU based VMMs like KVM or Xen.
  *
  * Copyright IBM Corp. 2007
+ * Copyright Red Hat, Inc. 2014
  *
  * Authors:
  *  Anthony Liguori  <aliguori@us.ibm.com>
+ *  Rusty Russell <rusty@rustcorp.com.au>
+ *  Michael S. Tsirkin <mst@redhat.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
-- 
MST
