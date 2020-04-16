From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v2 3/8] vhost: Replace vq->private_data access by backend accesors
Date: Thu, 16 Apr 2020 09:56:38 +0200
Message-ID: <20200416075643.27330-4-eperezma@redhat.com>
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

This function still places backend directly in private_data, instead of
use the accesors created on ("cbfc8f21b49a vhost: Create accessors for
virtqueues private_data"). Using accesor.

Fixes: ("7ce8cc28ce48 tools/virtio: Add --reset=3Drandom")

Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
---
 drivers/vhost/test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 251ca723ac3f..789c096e454b 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -265,7 +265,7 @@ static int vhost_test_set_features(struct vhost_test =
*n, u64 features)
=20
 static long vhost_test_set_backend(struct vhost_test *n, unsigned index,=
 int fd)
 {
-	static void *private_data;
+	static void *backend;
=20
 	const bool enable =3D fd !=3D -1;
 	struct vhost_virtqueue *vq;
@@ -290,11 +290,11 @@ static long vhost_test_set_backend(struct vhost_tes=
t *n, unsigned index, int fd)
 	}
 	if (!enable) {
 		vhost_poll_stop(&vq->poll);
-		private_data =3D vq->private_data;
-		vq->private_data =3D NULL;
+		backend =3D vhost_vq_get_backend(vq);
+		vhost_vq_set_backend(vq, NULL);
 	} else {
 		r =3D vhost_vq_init_access(vq);
-		vq->private_data =3D private_data;
+		vhost_vq_set_backend(vq, backend);
 		if (r =3D=3D 0)
 			r =3D vhost_poll_start(&vq->poll, vq->kick);
 	}
--=20
2.18.1
