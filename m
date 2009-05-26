From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [patch 1/2] virtio: fix id_matching for virtio drivers
Date: Tue, 26 May 2009 15:46:09 +0200
Message-ID: <20090526135140.796154000__35206.5535299063$1243345960$gmane$org@de.ibm.com>
References: <20090526134608.545964000@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=virtio_id_fix.patch
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

This bug never appeared, since all current virtio drivers use
VIRTIO_DEV_ANY_ID for the vendor field. If a real vendor would be used,
the check in virtio_id_match is wrong - it returns 0 if
id->vendor == dev->id.vendor.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/virtio/virtio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-next/drivers/virtio/virtio.c
===================================================================
--- linux-next.orig/drivers/virtio/virtio.c
+++ linux-next/drivers/virtio/virtio.c
@@ -61,7 +61,7 @@ static inline int virtio_id_match(const 
 	if (id->device != dev->id.device)
 		return 0;
 
-	return id->vendor == VIRTIO_DEV_ANY_ID || id->vendor != dev->id.vendor;
+	return id->vendor == VIRTIO_DEV_ANY_ID || id->vendor == dev->id.vendor;
 }
 
 /* This looks through all the IDs a driver claims to support.  If any of them
