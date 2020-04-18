From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v3 5/8] tools/virtio: Use __vring_new_virtqueue in virtio_test.c
Date: Sat, 18 Apr 2020 12:22:14 +0200
Message-ID: <20200418102217.32327-6-eperezma@redhat.com>
References: <20200418102217.32327-1-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200418102217.32327-1-eperezma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm list <kvm@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

As updated in ("2a2d1382fe9d virtio: Add improved queue allocation API")

Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
---
 tools/virtio/virtio_test.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 6bc3e172cc9b..0a247ba3b899 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -105,10 +105,9 @@ static void vq_info_add(struct vdev_info *dev, int n=
um)
 	assert(r >=3D 0);
 	memset(info->ring, 0, vring_size(num, 4096));
 	vring_init(&info->vring, num, info->ring, 4096);
-	info->vq =3D vring_new_virtqueue(info->idx,
-				       info->vring.num, 4096, &dev->vdev,
-				       true, false, info->ring,
-				       vq_notify, vq_callback, "test");
+	info->vq =3D
+		__vring_new_virtqueue(info->idx, info->vring, &dev->vdev, true,
+				      false, vq_notify, vq_callback, "test");
 	assert(info->vq);
 	info->vq->priv =3D info;
 	vhost_vq_setup(dev, info);
--=20
2.18.1
