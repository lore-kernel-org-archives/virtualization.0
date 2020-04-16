From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v2 4/8] vhost: Fix bad order in vhost_test_set_backend at enable
Date: Thu, 16 Apr 2020 09:56:39 +0200
Message-ID: <20200416075643.27330-5-eperezma@redhat.com>
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

The reset was not done properly: A init call was given with no active
backend. This solves that.

Fixes: ("7c48601a3d4d tools/virtio: Add --reset=3Drandom")

Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
---
 drivers/vhost/test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 789c096e454b..6aed0cab8b17 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -293,8 +293,8 @@ static long vhost_test_set_backend(struct vhost_test =
*n, unsigned index, int fd)
 		backend =3D vhost_vq_get_backend(vq);
 		vhost_vq_set_backend(vq, NULL);
 	} else {
-		r =3D vhost_vq_init_access(vq);
 		vhost_vq_set_backend(vq, backend);
+		r =3D vhost_vq_init_access(vq);
 		if (r =3D=3D 0)
 			r =3D vhost_poll_start(&vq->poll, vq->kick);
 	}
--=20
2.18.1
