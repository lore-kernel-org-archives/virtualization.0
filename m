From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] virtio_config: fix len calculation of config elements
Date: Thu, 29 May 2008 11:08:01 +0200
Message-ID: <200805291108.01604.borntraeger__38296.7643825852$1212052398$gmane$org@de.ibm.com>
References: <200805271105.00077.borntraeger@de.ibm.com>
	<200805291027.25369.borntraeger@de.ibm.com>
	<20080529083004.GQ25504@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080529083004.GQ25504@kernel.dk>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty,

This patch is a prereq for the virtio_blk blocksize patch, please apply it 
first.

Adding an u32 value to the virtio_blk_config unconvered a small bug the config 
space defintions:
v is a pointer, to we have to use sizeof(*v) instead of sizeof(v).

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/virtio_config.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: kvm/include/linux/virtio_config.h
===================================================================
--- kvm.orig/include/linux/virtio_config.h
+++ kvm/include/linux/virtio_config.h
@@ -99,7 +99,7 @@ static inline bool virtio_has_feature(co
  * The return value is -ENOENT if the feature doesn't exist.  Otherwise
  * the config value is copied into whatever is pointed to by v. */
 #define virtio_config_val(vdev, fbit, offset, v) \
-	virtio_config_buf((vdev), (fbit), (offset), (v), sizeof(v))
+	virtio_config_buf((vdev), (fbit), (offset), (v), sizeof(*v))
 
 static inline int virtio_config_buf(struct virtio_device *vdev,
 				    unsigned int fbit,
