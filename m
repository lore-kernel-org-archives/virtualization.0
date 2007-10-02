From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [patch 32/43] lguest: Virtio interface
Date: Tue, 2 Oct 2007 11:03:06 +0200
Message-ID: <200710021103.06918.borntraeger@de.ibm.com>
References: <20070926063618.956228976@rustcorp.com.au>
	<20070926063650.895058914@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070926063650.895058914@rustcorp.com.au>
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
Cc: lguest@ozlabs.org, Dor Laor <dor.laor@qumranet.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: virtualization@lists.linuxfoundation.org

Am Mittwoch, 26. September 2007 schrieb rusty@rustcorp.com.au:
>  include/linux/virtio_config.h   |  111 +++++++++++++++++++++++++

I get the following warnings on s390:
/space/linux-2.6/drivers/block/virtio_blk.c: In function 'virtblk_probe':
/space/linux-2.6/drivers/block/virtio_blk.c:240: warning: passing argument 1 
of '__swab16s' from incompatible pointer type
/space/linux-2.6/drivers/block/virtio_blk.c:240: warning: passing argument 1 
of '__swab32s' from incompatible pointer type
/space/linux-2.6/drivers/block/virtio_blk.c:254: warning: passing argument 1 
of '__swab16s' from incompatible pointer type
/space/linux-2.6/drivers/block/virtio_blk.c:254: warning: passing argument 1 
of '__swab64s' from incompatible pointer type
/space/linux-2.6/drivers/block/virtio_blk.c:262: warning: passing argument 1 
of '__swab16s' from incompatible pointer type
/space/linux-2.6/drivers/block/virtio_blk.c:262: warning: passing argument 1 
of '__swab64s' from incompatible pointer type

So what about:

---
 include/linux/virtio_config.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/include/linux/virtio_config.h
===================================================================
--- linux-2.6.orig/include/linux/virtio_config.h
+++ linux-2.6/include/linux/virtio_config.h
@@ -85,9 +85,9 @@ struct virtio_config_ops
 		     && sizeof(*(v)) != 4 && sizeof(*(v)) != 8);	\
 	if (!_err) {							\
 		switch (sizeof(*(v))) {					\
-		case 2: le16_to_cpus(v); break;				\
-		case 4: le32_to_cpus(v); break;				\
-		case 8: le64_to_cpus(v); break;				\
+		case 2: le16_to_cpus((__u16 *) v); break;		\
+		case 4: le32_to_cpus((__u32 *) v); break;		\
+		case 8: le64_to_cpus((__u64 *) v); break;		\
 		}							\
 	}								\
 	_err;								\
