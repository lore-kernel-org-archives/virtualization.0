From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: lguest virtio_descriptor structure on 64bit
Date: Fri, 17 Aug 2007 10:22:18 +0200
Message-ID: <200708171022.18799.borntraeger@de.ibm.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hello Rusty,

while playing with your virtio descriptor code, I realized that the desc_pages 
data structure is not 64 bit safe. struct lguest_desc desc[NUM_DESCS] can be 
smaller than a page, as struct lguest_desc is 24 bytes on 64bit systems. Lets 
add a char padding to make the next page really page aligned.

Btw. the new_io_desc.patch does not apply on current git. What base should I 
use?



--- lguest_virtio.c.old	2007-08-17 10:15:05.000000000 +0200
+++ lguest_virtio.c	2007-08-17 10:16:00.000000000 +0200
@@ -31,15 +31,16 @@
 
 struct desc_pages
 {
 	/* Page of descriptors. */
 	struct lguest_desc desc[NUM_DESCS];
+	char pad0[PAGE_SIZE - NUM_DESCS * sizeof(struct lguest_desc)];
 
 	/* Next page: how we tell other side what buffers are available. */
 	unsigned int avail_idx;
 	unsigned int available[NUM_DESCS];
-	char pad[PAGE_SIZE - (NUM_DESCS+1) * sizeof(unsigned int)];
+	char pad1[PAGE_SIZE - (NUM_DESCS+1) * sizeof(unsigned int)];
 
 	/* Third page: how other side tells us what's used. */
 	unsigned int used_idx;
 	struct lguest_used used[NUM_DESCS];
 };

cheers

Christian
