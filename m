From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] virtio_ring: make structure defines packed
Date: Fri, 8 Feb 2008 14:01:21 +0100
Message-ID: <200802081401.21194.borntraeger__37504.2502106682$1202475849$gmane$org@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Anthony Liguori <aliguori@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Currently the virtio_ring structure are not declared packed, but they 
describe an hardware like interface. We should not allow compilers to make 
alignments and optimizations that can be different between the guest and 
host compiler.

I propose to declare all structures that are in shared memory as packed.

Does anybody see a problem with packed?

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/virtio_ring.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: kvm/include/linux/virtio_ring.h
===================================================================
--- kvm.orig/include/linux/virtio_ring.h
+++ kvm/include/linux/virtio_ring.h
@@ -35,14 +35,14 @@ struct vring_desc
 	__u16 flags;
 	/* We chain unused descriptors via this, too */
 	__u16 next;
-};
+} __attribute__ ((packed));
 
 struct vring_avail
 {
 	__u16 flags;
 	__u16 idx;
 	__u16 ring[];
-};
+} __attribute__ ((packed));
 
 /* u32 is used here for ids for padding reasons. */
 struct vring_used_elem
@@ -51,14 +51,15 @@ struct vring_used_elem
 	__u32 id;
 	/* Total length of the descriptor chain which was used (written to) */
 	__u32 len;
-};
+} __attribute__ ((packed));
 
 struct vring_used
 {
 	__u16 flags;
 	__u16 idx;
+	__u32 padding;
 	struct vring_used_elem ring[];
-};
+} __attribute__ ((packed));
 
 struct vring {
 	unsigned int num;
