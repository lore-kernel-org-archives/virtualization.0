From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH 5/6] vhost: Delete virtqueue batch_descs member
Date: Sun, 29 Mar 2020 13:33:58 +0200
Message-ID: <20200329113359.30960-6-eperezma@redhat.com>
References: <20200329113359.30960-1-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200329113359.30960-1-eperezma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Halil Pasic <pasic@linux.ibm.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

It can be deduced from "max_descs".

Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
---
 drivers/vhost/vhost.c | 11 +++++++++--
 drivers/vhost/vhost.h |  1 -
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index b5a51b1f2e79..5f84f29b6c47 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -372,6 +372,11 @@ static int vhost_worker(void *data)
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
@@ -394,7 +399,9 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *=
dev)
 	for (i =3D 0; i < dev->nvqs; ++i) {
 		vq =3D dev->vqs[i];
 		vq->max_descs =3D dev->iov_limit;
-		vq->batch_descs =3D dev->iov_limit - UIO_MAXIOV;
+		if (vhost_vq_num_batch_descs(vq) < 0) {
+			return -EINVAL;
+		}
 		vq->descs =3D kmalloc_array(vq->max_descs,
 					  sizeof(*vq->descs),
 					  GFP_KERNEL);
@@ -2333,7 +2340,7 @@ static int fetch_descs(struct vhost_virtqueue *vq)
 	if (vq->ndescs)
 		return 0;
=20
-	while (!ret && vq->ndescs <=3D vq->batch_descs)
+	while (!ret && vq->ndescs <=3D vhost_vq_num_batch_descs(vq))
 		ret =3D fetch_buf(vq);
=20
 	return vq->ndescs ? 0 : ret;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 661088ae6dc7..e648b9b997d4 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -102,7 +102,6 @@ struct vhost_virtqueue {
 	int ndescs;
 	int first_desc;
 	int max_descs;
-	int batch_descs;
=20
 	const struct vhost_umem_node *meta_iotlb[VHOST_NUM_ADDRS];
 	struct file *kick;
--=20
2.18.1
