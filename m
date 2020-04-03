From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH 8/8] tools/virtio: Use tools/include/list.h instead of stubs
Date: Fri,  3 Apr 2020 18:51:19 +0200
Message-ID: <20200403165119.5030-9-eperezma@redhat.com>
References: <20200403165119.5030-1-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200403165119.5030-1-eperezma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm list <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

It should not make any significant difference but reduce stub code.

Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
---
 tools/virtio/linux/kernel.h | 7 +------
 tools/virtio/linux/virtio.h | 5 ++---
 tools/virtio/virtio_test.c  | 1 +
 tools/virtio/vringh_test.c  | 2 ++
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 6683b4a70b05..caab980211a6 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -11,6 +11,7 @@
=20
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/list.h>
 #include <linux/printk.h>
 #include <linux/bug.h>
 #include <errno.h>
@@ -135,10 +136,4 @@ static inline void free_page(unsigned long addr)
 	(void) (&_min1 =3D=3D &_min2);		\
 	_min1 < _min2 ? _min1 : _min2; })
=20
-/* TODO: empty stubs for now. Broken but enough for virtio_ring.c */
-#define list_add_tail(a, b) do {} while (0)
-#define list_del(a) do {} while (0)
-#define list_for_each_entry(a, b, c) while (0)
-/* end of stubs */
-
 #endif /* KERNEL_H */
diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
index b751350d4ce8..5d90254ddae4 100644
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -11,12 +11,11 @@ struct device {
 struct virtio_device {
 	struct device dev;
 	u64 features;
+	struct list_head vqs;
 };
=20
 struct virtqueue {
-	/* TODO: commented as list macros are empty stubs for now.
-	 * Broken but enough for virtio_ring.c
-	 * struct list_head list; */
+	struct list_head list;
 	void (*callback)(struct virtqueue *vq);
 	const char *name;
 	struct virtio_device *vdev;
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 82902fc3ba2a..cb3f29c09aff 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -129,6 +129,7 @@ static void vdev_info_init(struct vdev_info* dev, uns=
igned long long features)
 	int r;
 	memset(dev, 0, sizeof *dev);
 	dev->vdev.features =3D features;
+	INIT_LIST_HEAD(&dev->vdev.vqs);
 	dev->buf_size =3D 1024;
 	dev->buf =3D malloc(dev->buf_size);
 	assert(dev->buf);
diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 293653463303..fa87b58bd5fa 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -307,6 +307,7 @@ static int parallel_test(u64 features,
 		close(to_host[0]);
=20
 		gvdev.vdev.features =3D features;
+		INIT_LIST_HEAD(&gvdev.vdev.vqs);
 		gvdev.to_host_fd =3D to_host[1];
 		gvdev.notifies =3D 0;
=20
@@ -453,6 +454,7 @@ int main(int argc, char *argv[])
=20
 	getrange =3D getrange_iov;
 	vdev.features =3D 0;
+	INIT_LIST_HEAD(&vdev.vqs);
=20
 	while (argv[1]) {
 		if (strcmp(argv[1], "--indirect") =3D=3D 0)
--=20
2.18.1
