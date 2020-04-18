From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v3 1/8] vhost: Not cleaning batched descs in VHOST_SET_VRING_BASE ioctl
Date: Sat, 18 Apr 2020 12:22:10 +0200
Message-ID: <20200418102217.32327-2-eperezma@redhat.com>
References: <20200418102217.32327-1-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200418102217.32327-1-eperezma@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm list <kvm@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

They are cleaned in vhost_vq_set_backend, which can be called with an
active backend. To set and remove backends already clean batched
descriptors, so to do it here is completely redundant.

Fixes: ("e7539c20a4a6 vhost: batching fetches")

Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
---
 drivers/vhost/vhost.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 0395229486a9..882d0df57e24 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1579,7 +1579,6 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *arg
 		vq->last_avail_idx =3D s.num;
 		/* Forget the cached index value. */
 		vq->avail_idx =3D vq->last_avail_idx;
-		vq->ndescs =3D vq->first_desc =3D 0;
 		break;
 	case VHOST_GET_VRING_BASE:
 		s.index =3D idx;
--=20
2.18.1
