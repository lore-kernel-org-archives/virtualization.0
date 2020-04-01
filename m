From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v4 3/7] vhost: batching fetches
Date: Wed,  1 Apr 2020 20:31:14 +0200
Message-ID: <20200401183118.8334-4-eperezma@redhat.com>
References: <20200401183118.8334-1-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200401183118.8334-1-eperezma@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kvm list <kvm@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>

With this patch applied, new and old code perform identically.

Lots of extra optimizations are now possible, e.g.
we can fetch multiple heads with copy_from/to_user now.
We can get rid of maintaining the log array.  Etc etc.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
---
 drivers/vhost/test.c  |  2 +-
 drivers/vhost/vhost.c | 47 ++++++++++++++++++++++++++++++++++++++-----
 drivers/vhost/vhost.h |  5 ++++-
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 9a3a09005e03..02806d6f84ef 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -119,7 +119,7 @@ static int vhost_test_open(struct inode *inode, struc=
t file *f)
 	dev =3D &n->dev;
 	vqs[VHOST_TEST_VQ] =3D &n->vqs[VHOST_TEST_VQ];
 	n->vqs[VHOST_TEST_VQ].handle_kick =3D handle_vq_kick;
-	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV,
+	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV + 64,
 		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, NULL);
=20
 	f->private_data =3D n;
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 6ca658c21e15..0395229486a9 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -299,6 +299,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 {
 	vq->num =3D 1;
 	vq->ndescs =3D 0;
+	vq->first_desc =3D 0;
 	vq->desc =3D NULL;
 	vq->avail =3D NULL;
 	vq->used =3D NULL;
@@ -367,6 +368,11 @@ static int vhost_worker(void *data)
 	return 0;
 }
=20
+static int vhost_vq_num_batch_descs(struct vhost_virtqueue *vq)
+{
+	return vq->max_descs - UIO_MAXIOV;
+}
+
 static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
 {
 	kfree(vq->descs);
@@ -389,6 +395,9 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *=
dev)
 	for (i =3D 0; i < dev->nvqs; ++i) {
 		vq =3D dev->vqs[i];
 		vq->max_descs =3D dev->iov_limit;
+		if (vhost_vq_num_batch_descs(vq) < 0) {
+			return -EINVAL;
+		}
 		vq->descs =3D kmalloc_array(vq->max_descs,
 					  sizeof(*vq->descs),
 					  GFP_KERNEL);
@@ -1570,6 +1579,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *arg
 		vq->last_avail_idx =3D s.num;
 		/* Forget the cached index value. */
 		vq->avail_idx =3D vq->last_avail_idx;
+		vq->ndescs =3D vq->first_desc =3D 0;
 		break;
 	case VHOST_GET_VRING_BASE:
 		s.index =3D idx;
@@ -2136,7 +2146,7 @@ static int fetch_indirect_descs(struct vhost_virtqu=
eue *vq,
 	return 0;
 }
=20
-static int fetch_descs(struct vhost_virtqueue *vq)
+static int fetch_buf(struct vhost_virtqueue *vq)
 {
 	unsigned int i, head, found =3D 0;
 	struct vhost_desc *last;
@@ -2149,7 +2159,11 @@ static int fetch_descs(struct vhost_virtqueue *vq)
 	/* Check it isn't doing very strange things with descriptor numbers. */
 	last_avail_idx =3D vq->last_avail_idx;
=20
-	if (vq->avail_idx =3D=3D vq->last_avail_idx) {
+	if (unlikely(vq->avail_idx =3D=3D vq->last_avail_idx)) {
+		/* If we already have work to do, don't bother re-checking. */
+		if (likely(vq->ndescs))
+			return vq->num;
+
 		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
 			vq_err(vq, "Failed to access avail idx at %p\n",
 				&vq->avail->idx);
@@ -2240,6 +2254,24 @@ static int fetch_descs(struct vhost_virtqueue *vq)
 	return 0;
 }
=20
+static int fetch_descs(struct vhost_virtqueue *vq)
+{
+	int ret =3D 0;
+
+	if (unlikely(vq->first_desc >=3D vq->ndescs)) {
+		vq->first_desc =3D 0;
+		vq->ndescs =3D 0;
+	}
+
+	if (vq->ndescs)
+		return 0;
+
+	while (!ret && vq->ndescs <=3D vhost_vq_num_batch_descs(vq))
+		ret =3D fetch_buf(vq);
+
+	return vq->ndescs ? 0 : ret;
+}
+
 /* This looks in the virtqueue and for the first available buffer, and c=
onverts
  * it to an iovec for convenient access.  Since descriptors consist of s=
ome
  * number of output then some number of input descriptors, it's actually=
 two
@@ -2265,7 +2297,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 	if (unlikely(log))
 		*log_num =3D 0;
=20
-	for (i =3D 0; i < vq->ndescs; ++i) {
+	for (i =3D vq->first_desc; i < vq->ndescs; ++i) {
 		unsigned iov_count =3D *in_num + *out_num;
 		struct vhost_desc *desc =3D &vq->descs[i];
 		int access;
@@ -2311,14 +2343,19 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 		}
=20
 		ret =3D desc->id;
+
+		if (!(desc->flags & VRING_DESC_F_NEXT))
+			break;
 	}
=20
-	vq->ndescs =3D 0;
+	vq->first_desc =3D i + 1;
=20
 	return ret;
=20
 err:
-	vhost_discard_vq_desc(vq, 1);
+	for (i =3D vq->first_desc; i < vq->ndescs; ++i)
+		if (!(vq->descs[i].flags & VRING_DESC_F_NEXT))
+			vhost_discard_vq_desc(vq, 1);
 	vq->ndescs =3D 0;
=20
 	return ret;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index e5f295e5ffcc..cc82918158d2 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -81,6 +81,7 @@ struct vhost_virtqueue {
=20
 	struct vhost_desc *descs;
 	int ndescs;
+	int first_desc;
 	int max_descs;
=20
 	struct file *kick;
@@ -229,7 +230,7 @@ void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
 			  struct vhost_iotlb_map *map);
=20
 #define vq_err(vq, fmt, ...) do {                                  \
-		pr_debug(pr_fmt(fmt), ##__VA_ARGS__);       \
+		pr_err(pr_fmt(fmt), ##__VA_ARGS__);       \
 		if ((vq)->error_ctx)                               \
 				eventfd_signal((vq)->error_ctx, 1);\
 	} while (0)
@@ -255,6 +256,8 @@ static inline void vhost_vq_set_backend(struct vhost_=
virtqueue *vq,
 					void *private_data)
 {
 	vq->private_data =3D private_data;
+	vq->ndescs =3D 0;
+	vq->first_desc =3D 0;
 }
=20
 /**
--=20
2.18.1
