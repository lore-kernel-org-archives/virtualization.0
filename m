From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [patch 2/2] virtio: enhance id_matching for virtio drivers
Date: Tue, 26 May 2009 15:46:10 +0200
Message-ID: <20090526135141.256078000__3674.13622229851$1243345986$gmane$org@de.ibm.com>
References: <20090526134608.545964000@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=virtio_id_enhance.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

This patch allows a virtio driver to use VIRTIO_DEV_ANY_ID for the 
device id. This will be used by a test module that can be bound to
any virtio device.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/virtio/virtio.c  |    2 +-
 scripts/mod/file2alias.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-next/drivers/virtio/virtio.c
===================================================================
--- linux-next.orig/drivers/virtio/virtio.c
+++ linux-next/drivers/virtio/virtio.c
@@ -58,7 +58,7 @@ static struct device_attribute virtio_de
 static inline int virtio_id_match(const struct virtio_device *dev,
 				  const struct virtio_device_id *id)
 {
-	if (id->device != dev->id.device)
+	if (id->device != dev->id.device && id->device != VIRTIO_DEV_ANY_ID)
 		return 0;
 
 	return id->vendor == VIRTIO_DEV_ANY_ID || id->vendor == dev->id.vendor;
Index: linux-next/scripts/mod/file2alias.c
===================================================================
--- linux-next.orig/scripts/mod/file2alias.c
+++ linux-next/scripts/mod/file2alias.c
@@ -641,7 +641,7 @@ static int do_virtio_entry(const char *f
 	id->vendor = TO_NATIVE(id->vendor);
 
 	strcpy(alias, "virtio:");
-	ADD(alias, "d", 1, id->device);
+	ADD(alias, "d", id->device != VIRTIO_DEV_ANY_ID, id->device);
 	ADD(alias, "v", id->vendor != VIRTIO_DEV_ANY_ID, id->vendor);
 
 	add_wildcard(alias);
