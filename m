From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] vhost: access check thinko fixes
Date: Thu, 24 Dec 2009 08:00:58 +0200
Message-ID: <20091224060058.GA26101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, rusty@rustcorp.com.au, Al Viro <viro@zeniv.linux.org.uk>, kvm@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

This fixes two issues with recent access checking patch:
1.  if (&d->vqs[i].private_data) -> if (d->vqs[i].private_data)
2.  we can't forbid log base changes while ring is running,
    because host needs to resize log in rare cases
    (e.g. when memory is added with a baloon)
    and in that case it needs to increase log size with realloc,
    which might move the log address.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Rusty, this needs to be applied on top of the access_ok patch.
If you want me to rool it in with that one and esend, let me
know please.
Thanks!

 drivers/vhost/vhost.c |   39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 2b65d9b..c8c25db 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -230,7 +230,7 @@ static int log_access_ok(void __user *log_base, u64 addr, unsigned long sz)
 }
 
 /* Caller should have vq mutex and device mutex. */
-static int vq_memory_access_ok(struct vhost_virtqueue *vq, struct vhost_memory *mem,
+static int vq_memory_access_ok(void __user *log_base, struct vhost_memory *mem,
 			       int log_all)
 {
 	int i;
@@ -242,7 +242,7 @@ static int vq_memory_access_ok(struct vhost_virtqueue *vq, struct vhost_memory *
 		else if (!access_ok(VERIFY_WRITE, (void __user *)a,
 				    m->memory_size))
 			return 0;
-		else if (log_all && !log_access_ok(vq->log_base,
+		else if (log_all && !log_access_ok(log_base,
 						   m->guest_phys_addr,
 						   m->memory_size))
 			return 0;
@@ -259,9 +259,10 @@ static int memory_access_ok(struct vhost_dev *d, struct vhost_memory *mem,
 	for (i = 0; i < d->nvqs; ++i) {
 		int ok;
 		mutex_lock(&d->vqs[i].mutex);
-		/* If ring is not running, will check when it's enabled. */
-		if (&d->vqs[i].private_data)
-			ok = vq_memory_access_ok(&d->vqs[i], mem, log_all);
+		/* If ring is inactive, will check when it's enabled. */
+		if (d->vqs[i].private_data)
+			ok = vq_memory_access_ok(d->vqs[i].log_base, mem,
+						 log_all);
 		else
 			ok = 1;
 		mutex_unlock(&d->vqs[i].mutex);
@@ -290,18 +291,25 @@ int vhost_log_access_ok(struct vhost_dev *dev)
 	return memory_access_ok(dev, dev->memory, 1);
 }
 
-/* Can we start vq? */
+/* Verify access for write logging. */
 /* Caller should have vq mutex and device mutex */
-int vhost_vq_access_ok(struct vhost_virtqueue *vq)
+static int vq_log_access_ok(struct vhost_virtqueue *vq, void __user *log_base)
 {
-	return vq_access_ok(vq->num, vq->desc, vq->avail, vq->used) &&
-		vq_memory_access_ok(vq, vq->dev->memory,
+	return vq_memory_access_ok(log_base, vq->dev->memory,
 			    vhost_has_feature(vq->dev, VHOST_F_LOG_ALL)) &&
-		(!vq->log_used || log_access_ok(vq->log_base, vq->log_addr,
+		(!vq->log_used || log_access_ok(log_base, vq->log_addr,
 					sizeof *vq->used +
 					vq->num * sizeof *vq->used->ring));
 }
 
+/* Can we start vq? */
+/* Caller should have vq mutex and device mutex */
+int vhost_vq_access_ok(struct vhost_virtqueue *vq)
+{
+	return vq_access_ok(vq->num, vq->desc, vq->avail, vq->used) &&
+		vq_log_access_ok(vq, vq->log_base);
+}
+
 static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
 {
 	struct vhost_memory mem, *newmem, *oldmem;
@@ -564,15 +572,14 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, unsigned long arg)
 		}
 		for (i = 0; i < d->nvqs; ++i) {
 			struct vhost_virtqueue *vq;
+			void __user *base = (void __user *)(unsigned long)p;
 			vq = d->vqs + i;
 			mutex_lock(&vq->mutex);
-			/* Moving log base with an active backend?
-			 * You don't want to do that. */
-			if (vq->private_data && (vq->log_used ||
-			     vhost_has_feature(d, VHOST_F_LOG_ALL)))
-				r = -EBUSY;
+			/* If ring is inactive, will check when it's enabled. */
+			if (vq->private_data && !vq_log_access_ok(vq, base))
+				r = -EFAULT;
 			else
-				vq->log_base = (void __user *)(unsigned long)p;
+				vq->log_base = base;
 			mutex_unlock(&vq->mutex);
 		}
 		break;
-- 
1.6.6.rc1.43.gf55cc
