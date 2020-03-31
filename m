From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v2 8/8] tools/virtio: Make --reset reset ring idx
Date: Tue, 31 Mar 2020 20:00:06 +0200
Message-ID: <20200331180006.25829-9-eperezma@redhat.com>
References: <20200331180006.25829-1-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200331180006.25829-1-eperezma@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, kvm list <kvm@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
---
 drivers/virtio/virtio_ring.c | 29 +++++++++++++++++++++++++++++
 tools/virtio/linux/virtio.h  |  2 ++
 tools/virtio/virtio_test.c   | 28 +++++++++++++++++++++++++++-
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 867c7ebd3f10..01b322ee2e04 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1810,6 +1810,35 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
=20
+#ifndef __KERNEL__
+
+/**
+ * virtqueue_reset_free_head - Reset to 0 the members of split ring.
+ * @vq: Virtqueue to reset.
+ *
+ * At this moment, is only meant for debug the ring index change, do not=
 use
+ * in production.
+ */
+void virtqueue_reset_free_head(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq =3D to_vvq(_vq);
+
+	// vq->last_used_idx =3D 0;
+	vq->num_added =3D 0;
+
+	vq->split.queue_size_in_bytes =3D 0;
+	vq->split.avail_flags_shadow =3D 0;
+	vq->split.avail_idx_shadow =3D 0;
+
+	memset(vq->split.desc_state, 0, vq->split.vring.num *
+			sizeof(struct vring_desc_state_split));
+
+	vq->free_head =3D 0;
+}
+EXPORT_SYMBOL_GPL(virtqueue_reset_free_head);
+
+#endif
+
 /**
  * virtqueue_kick_prepare - first half of split virtqueue_kick call.
  * @_vq: the struct virtqueue
diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
index b751350d4ce8..5d33eab6b814 100644
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -65,4 +65,6 @@ struct virtqueue *vring_new_virtqueue(unsigned int inde=
x,
 				      const char *name);
 void vring_del_virtqueue(struct virtqueue *vq);
=20
+void virtqueue_reset_free_head(struct virtqueue *vq);
+
 #endif
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 93d81cd64ba0..bf21ece30594 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -49,6 +49,7 @@ struct vdev_info {
=20
 static const struct vhost_vring_file no_backend =3D { .fd =3D -1 },
 				     backend =3D { .fd =3D 1 };
+static const struct vhost_vring_state null_state =3D {};
=20
 bool vq_notify(struct virtqueue *vq)
 {
@@ -218,10 +219,33 @@ static void run_test(struct vdev_info *dev, struct =
vq_info *vq,
 			}
=20
 			if (reset) {
+				struct vhost_vring_state s =3D { .index =3D 0 };
+				int i;
+				vq->vring.avail->idx =3D 0;
+				vq->vq->num_free =3D vq->vring.num;
+
+				// Put everything in free lists.
+				for (i =3D 0; i < vq->vring.num-1; i++)
+					vq->vring.desc[i].next =3D
+						cpu_to_virtio16(&dev->vdev,
+								i + 1);
+				vq->vring.desc[vq->vring.num-1].next =3D 0;
+				virtqueue_reset_free_head(vq->vq);
+
+				r =3D ioctl(dev->control, VHOST_GET_VRING_BASE,
+					  &s);
+				assert(!r);
+
+				s.num =3D 0;
+				r =3D ioctl(dev->control, VHOST_SET_VRING_BASE,
+					  &null_state);
+				assert(!r);
+
 				r =3D ioctl(dev->control, VHOST_TEST_SET_BACKEND,
 					  &backend);
 				assert(!r);
=20
+				started =3D completed;
                                 while (completed > next_reset)
 					next_reset +=3D completed;
 			}
@@ -243,7 +267,9 @@ static void run_test(struct vdev_info *dev, struct vq=
_info *vq,
 	test =3D 0;
 	r =3D ioctl(dev->control, VHOST_TEST_RUN, &test);
 	assert(r >=3D 0);
-	fprintf(stderr, "spurious wakeups: 0x%llx\n", spurious);
+	fprintf(stderr,
+		"spurious wakeups: 0x%llx started=3D0x%lx completed=3D0x%lx\n",
+		spurious, started, completed);
 }
=20
 const char optstring[] =3D "h";
--=20
2.18.1
