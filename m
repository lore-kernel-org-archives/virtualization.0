From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v3 3/8] tools/virtio: Add --batch=random option
Date: Sat, 18 Apr 2020 12:22:12 +0200
Message-ID: <20200418102217.32327-4-eperezma@redhat.com>
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

So we can test with non-deterministic batches in flight.

Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
---
 tools/virtio/virtio_test.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index c30de9088f3c..4a2b9d11f287 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -19,6 +19,8 @@
 #include <linux/virtio_ring.h>
 #include "../../drivers/vhost/test.h"
=20
+#define RANDOM_BATCH -1
+
 /* Unused */
 void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
=20
@@ -161,6 +163,7 @@ static void run_test(struct vdev_info *dev, struct vq=
_info *vq,
 	int r, test =3D 1;
 	unsigned len;
 	long long spurious =3D 0;
+	const bool random_batch =3D batch =3D=3D RANDOM_BATCH;
 	r =3D ioctl(dev->control, VHOST_TEST_RUN, &test);
 	assert(r >=3D 0);
 	for (;;) {
@@ -168,6 +171,9 @@ static void run_test(struct vdev_info *dev, struct vq=
_info *vq,
 		completed_before =3D completed;
 		started_before =3D started;
 		do {
+			if (random_batch)
+				batch =3D (random() % vq->vring.num) + 1;
+
 			while (started < bufs &&
 			       (started - completed) < batch) {
 				sg_init_one(&sl, dev->buf, dev->buf_size);
@@ -275,7 +281,7 @@ static void help(void)
 		" [--no-event-idx]"
 		" [--no-virtio-1]"
 		" [--delayed-interrupt]"
-		" [--batch=3DN]"
+		" [--batch=3Drandom/N]"
 		"\n");
 }
=20
@@ -312,9 +318,13 @@ int main(int argc, char **argv)
 			delayed =3D true;
 			break;
 		case 'b':
-			batch =3D strtol(optarg, NULL, 10);
-			assert(batch > 0);
-			assert(batch < (long)INT_MAX + 1);
+			if (0 =3D=3D strcmp(optarg, "random")) {
+				batch =3D RANDOM_BATCH;
+			} else {
+				batch =3D strtol(optarg, NULL, 10);
+				assert(batch > 0);
+				assert(batch < (long)INT_MAX + 1);
+			}
 			break;
 		default:
 			assert(0);
--=20
2.18.1
