From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v2 6/8] tools/virtio: Extract virtqueue initialization in vq_reset
Date: Thu, 16 Apr 2020 09:56:41 +0200
Message-ID: <20200416075643.27330-7-eperezma@redhat.com>
References: <20200416075643.27330-1-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200416075643.27330-1-eperezma@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

So we can reset after that in the main loop.

Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
---
 tools/virtio/virtio_test.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index d9827b640c21..18d5347003eb 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -95,6 +95,19 @@ void vhost_vq_setup(struct vdev_info *dev, struct vq_i=
nfo *info)
 	assert(r >=3D 0);
 }
=20
+static void vq_reset(struct vq_info *info, int num, struct virtio_device=
 *vdev)
+{
+	if (info->vq)
+		vring_del_virtqueue(info->vq);
+
+	memset(info->ring, 0, vring_legacy_size(num, 4096));
+	vring_legacy_init(&info->vring, num, info->ring, 4096);
+	info->vq =3D __vring_new_virtqueue(info->idx, info->vring, vdev, true,
+					 false, vq_notify, vq_callback, "test");
+	assert(info->vq);
+	info->vq->priv =3D info;
+}
+
 static void vq_info_add(struct vdev_info *dev, int num)
 {
 	struct vq_info *info =3D &dev->vqs[dev->nvqs];
@@ -104,13 +117,7 @@ static void vq_info_add(struct vdev_info *dev, int n=
um)
 	info->call =3D eventfd(0, EFD_NONBLOCK);
 	r =3D posix_memalign(&info->ring, 4096, vring_legacy_size(num, 4096));
 	assert(r >=3D 0);
-	memset(info->ring, 0, vring_legacy_size(num, 4096));
-	vring_legacy_init(&info->vring, num, info->ring, 4096);
-	info->vq =3D
-		__vring_new_virtqueue(info->idx, info->vring, &dev->vdev, true,
-				      false, vq_notify, vq_callback, "test");
-	assert(info->vq);
-	info->vq->priv =3D info;
+	vq_reset(info, num, &dev->vdev);
 	vhost_vq_setup(dev, info);
 	dev->fds[info->idx].fd =3D info->call;
 	dev->fds[info->idx].events =3D POLLIN;
--=20
2.18.1
