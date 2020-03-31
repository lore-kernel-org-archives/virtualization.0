From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v3 1/8] vhost: Create accessors for virtqueues private_data
Date: Tue, 31 Mar 2020 21:27:57 +0200
Message-ID: <20200331192804.6019-2-eperezma@redhat.com>
References: <20200331192804.6019-1-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200331192804.6019-1-eperezma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kvm list <kvm@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
---
 drivers/vhost/net.c   | 28 +++++++++++++++-------------
 drivers/vhost/scsi.c  | 14 +++++++-------
 drivers/vhost/test.c  | 10 +++++-----
 drivers/vhost/vhost.h | 27 +++++++++++++++++++++++++++
 drivers/vhost/vsock.c | 14 +++++++-------
 5 files changed, 61 insertions(+), 32 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index e158159671fa..6ad1612f496e 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -424,7 +424,7 @@ static void vhost_net_disable_vq(struct vhost_net *n,
 	struct vhost_net_virtqueue *nvq =3D
 		container_of(vq, struct vhost_net_virtqueue, vq);
 	struct vhost_poll *poll =3D n->poll + (nvq - n->vqs);
-	if (!vq->private_data)
+	if (!vhost_vq_get_backend(vq))
 		return;
 	vhost_poll_stop(poll);
 }
@@ -437,7 +437,7 @@ static int vhost_net_enable_vq(struct vhost_net *n,
 	struct vhost_poll *poll =3D n->poll + (nvq - n->vqs);
 	struct socket *sock;
=20
-	sock =3D vq->private_data;
+	sock =3D vhost_vq_get_backend(vq);
 	if (!sock)
 		return 0;
=20
@@ -524,7 +524,7 @@ static void vhost_net_busy_poll(struct vhost_net *net=
,
 		return;
=20
 	vhost_disable_notify(&net->dev, vq);
-	sock =3D rvq->private_data;
+	sock =3D vhost_vq_get_backend(rvq);
=20
 	busyloop_timeout =3D poll_rx ? rvq->busyloop_timeout:
 				     tvq->busyloop_timeout;
@@ -570,8 +570,10 @@ static int vhost_net_tx_get_vq_desc(struct vhost_net=
 *net,
=20
 	if (r =3D=3D tvq->num && tvq->busyloop_timeout) {
 		/* Flush batched packets first */
-		if (!vhost_sock_zcopy(tvq->private_data))
-			vhost_tx_batch(net, tnvq, tvq->private_data, msghdr);
+		if (!vhost_sock_zcopy(vhost_vq_get_backend(tvq)))
+			vhost_tx_batch(net, tnvq,
+				       vhost_vq_get_backend(tvq),
+				       msghdr);
=20
 		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, false);
=20
@@ -685,7 +687,7 @@ static int vhost_net_build_xdp(struct vhost_net_virtq=
ueue *nvq,
 	struct vhost_virtqueue *vq =3D &nvq->vq;
 	struct vhost_net *net =3D container_of(vq->dev, struct vhost_net,
 					     dev);
-	struct socket *sock =3D vq->private_data;
+	struct socket *sock =3D vhost_vq_get_backend(vq);
 	struct page_frag *alloc_frag =3D &net->page_frag;
 	struct virtio_net_hdr *gso;
 	struct xdp_buff *xdp =3D &nvq->xdp[nvq->batched_xdp];
@@ -952,7 +954,7 @@ static void handle_tx(struct vhost_net *net)
 	struct socket *sock;
=20
 	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_TX);
-	sock =3D vq->private_data;
+	sock =3D vhost_vq_get_backend(vq);
 	if (!sock)
 		goto out;
=20
@@ -1121,7 +1123,7 @@ static void handle_rx(struct vhost_net *net)
 	int recv_pkts =3D 0;
=20
 	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
-	sock =3D vq->private_data;
+	sock =3D vhost_vq_get_backend(vq);
 	if (!sock)
 		goto out;
=20
@@ -1344,9 +1346,9 @@ static struct socket *vhost_net_stop_vq(struct vhos=
t_net *n,
 		container_of(vq, struct vhost_net_virtqueue, vq);
=20
 	mutex_lock(&vq->mutex);
-	sock =3D vq->private_data;
+	sock =3D vhost_vq_get_backend(vq);
 	vhost_net_disable_vq(n, vq);
-	vq->private_data =3D NULL;
+	vhost_vq_set_backend(vq, NULL);
 	vhost_net_buf_unproduce(nvq);
 	nvq->rx_ring =3D NULL;
 	mutex_unlock(&vq->mutex);
@@ -1528,7 +1530,7 @@ static long vhost_net_set_backend(struct vhost_net =
*n, unsigned index, int fd)
 	}
=20
 	/* start polling new socket */
-	oldsock =3D vq->private_data;
+	oldsock =3D vhost_vq_get_backend(vq);
 	if (sock !=3D oldsock) {
 		ubufs =3D vhost_net_ubuf_alloc(vq,
 					     sock && vhost_sock_zcopy(sock));
@@ -1538,7 +1540,7 @@ static long vhost_net_set_backend(struct vhost_net =
*n, unsigned index, int fd)
 		}
=20
 		vhost_net_disable_vq(n, vq);
-		vq->private_data =3D sock;
+		vhost_vq_set_backend(vq, sock);
 		vhost_net_buf_unproduce(nvq);
 		r =3D vhost_vq_init_access(vq);
 		if (r)
@@ -1575,7 +1577,7 @@ static long vhost_net_set_backend(struct vhost_net =
*n, unsigned index, int fd)
 	return 0;
=20
 err_used:
-	vq->private_data =3D oldsock;
+	vhost_vq_set_backend(vq, oldsock);
 	vhost_net_enable_vq(n, vq);
 	if (ubufs)
 		vhost_net_ubuf_put_wait_and_free(ubufs);
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 0b949a14bce3..4b5deeeabc3d 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -452,7 +452,7 @@ vhost_scsi_do_evt_work(struct vhost_scsi *vs, struct =
vhost_scsi_evt *evt)
 	unsigned out, in;
 	int head, ret;
=20
-	if (!vq->private_data) {
+	if (!vhost_vq_get_backend(vq)) {
 		vs->vs_events_missed =3D true;
 		return;
 	}
@@ -892,7 +892,7 @@ vhost_scsi_get_req(struct vhost_virtqueue *vq, struct=
 vhost_scsi_ctx *vc,
 	} else {
 		struct vhost_scsi_tpg **vs_tpg, *tpg;
=20
-		vs_tpg =3D vq->private_data;	/* validated at handler entry */
+		vs_tpg =3D vhost_vq_get_backend(vq);	/* validated at handler entry */
=20
 		tpg =3D READ_ONCE(vs_tpg[*vc->target]);
 		if (unlikely(!tpg)) {
@@ -929,7 +929,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vh=
ost_virtqueue *vq)
 	 * We can handle the vq only after the endpoint is setup by calling the
 	 * VHOST_SCSI_SET_ENDPOINT ioctl.
 	 */
-	vs_tpg =3D vq->private_data;
+	vs_tpg =3D vhost_vq_get_backend(vq);
 	if (!vs_tpg)
 		goto out;
=20
@@ -1184,7 +1184,7 @@ vhost_scsi_ctl_handle_vq(struct vhost_scsi *vs, str=
uct vhost_virtqueue *vq)
 	 * We can handle the vq only after the endpoint is setup by calling the
 	 * VHOST_SCSI_SET_ENDPOINT ioctl.
 	 */
-	if (!vq->private_data)
+	if (!vhost_vq_get_backend(vq))
 		goto out;
=20
 	memset(&vc, 0, sizeof(vc));
@@ -1322,7 +1322,7 @@ static void vhost_scsi_evt_handle_kick(struct vhost=
_work *work)
 	struct vhost_scsi *vs =3D container_of(vq->dev, struct vhost_scsi, dev)=
;
=20
 	mutex_lock(&vq->mutex);
-	if (!vq->private_data)
+	if (!vhost_vq_get_backend(vq))
 		goto out;
=20
 	if (vs->vs_events_missed)
@@ -1460,7 +1460,7 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 		for (i =3D 0; i < VHOST_SCSI_MAX_VQ; i++) {
 			vq =3D &vs->vqs[i].vq;
 			mutex_lock(&vq->mutex);
-			vq->private_data =3D vs_tpg;
+			vhost_vq_set_backend(vq, vs_tpg);
 			vhost_vq_init_access(vq);
 			mutex_unlock(&vq->mutex);
 		}
@@ -1547,7 +1547,7 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
 		for (i =3D 0; i < VHOST_SCSI_MAX_VQ; i++) {
 			vq =3D &vs->vqs[i].vq;
 			mutex_lock(&vq->mutex);
-			vq->private_data =3D NULL;
+			vhost_vq_set_backend(vq, NULL);
 			mutex_unlock(&vq->mutex);
 		}
 	}
diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index e37c92d4d7ad..394e2e5c772d 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -49,7 +49,7 @@ static void handle_vq(struct vhost_test *n)
 	void *private;
=20
 	mutex_lock(&vq->mutex);
-	private =3D vq->private_data;
+	private =3D vhost_vq_get_backend(vq);
 	if (!private) {
 		mutex_unlock(&vq->mutex);
 		return;
@@ -133,8 +133,8 @@ static void *vhost_test_stop_vq(struct vhost_test *n,
 	void *private;
=20
 	mutex_lock(&vq->mutex);
-	private =3D vq->private_data;
-	vq->private_data =3D NULL;
+	private =3D vhost_vq_get_backend(vq);
+	vhost_vq_set_backend(vq, NULL);
 	mutex_unlock(&vq->mutex);
 	return private;
 }
@@ -198,8 +198,8 @@ static long vhost_test_run(struct vhost_test *n, int =
test)
 		priv =3D test ? n : NULL;
=20
 		/* start polling new socket */
-		oldpriv =3D vq->private_data;
-		vq->private_data =3D priv;
+		oldpriv =3D vhost_vq_get_backend(vq);
+		vhost_vq_set_backend(vq, priv);
=20
 		r =3D vhost_vq_init_access(&n->vqs[index]);
=20
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index a123fd70847e..b77203e0cae2 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -244,6 +244,33 @@ enum {
 			 (1ULL << VIRTIO_F_VERSION_1)
 };
=20
+/**
+ * vhost_vq_set_backend - Set backend.
+ *
+ * @vq            Virtqueue.
+ * @private_data  The private data.
+ *
+ * Context: Need to call with vq->mutex acquired.
+ */
+static inline void vhost_vq_set_backend(struct vhost_virtqueue *vq,
+					void *private_data)
+{
+	vq->private_data =3D private_data;
+}
+
+/**
+ * vhost_vq_get_backend - Get backend.
+ *
+ * @vq            Virtqueue.
+ *
+ * Context: Need to call with vq->mutex acquired.
+ * Return: Private data previously set with vhost_vq_set_backend.
+ */
+static inline void *vhost_vq_get_backend(struct vhost_virtqueue *vq)
+{
+	return vq->private_data;
+}
+
 static inline bool vhost_has_feature(struct vhost_virtqueue *vq, int bit=
)
 {
 	return vq->acked_features & (1ULL << bit);
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index c2d7d57e98cf..6c1fbfd621a2 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -91,7 +91,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
=20
 	mutex_lock(&vq->mutex);
=20
-	if (!vq->private_data)
+	if (!vhost_vq_get_backend(vq))
 		goto out;
=20
 	/* Avoid further vmexits, we're already processing the virtqueue */
@@ -440,7 +440,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_w=
ork *work)
=20
 	mutex_lock(&vq->mutex);
=20
-	if (!vq->private_data)
+	if (!vhost_vq_get_backend(vq))
 		goto out;
=20
 	vhost_disable_notify(&vsock->dev, vq);
@@ -533,8 +533,8 @@ static int vhost_vsock_start(struct vhost_vsock *vsoc=
k)
 			goto err_vq;
 		}
=20
-		if (!vq->private_data) {
-			vq->private_data =3D vsock;
+		if (!vhost_vq_get_backend(vq)) {
+			vhost_vq_set_backend(vq, vsock);
 			ret =3D vhost_vq_init_access(vq);
 			if (ret)
 				goto err_vq;
@@ -547,14 +547,14 @@ static int vhost_vsock_start(struct vhost_vsock *vs=
ock)
 	return 0;
=20
 err_vq:
-	vq->private_data =3D NULL;
+	vhost_vq_set_backend(vq, NULL);
 	mutex_unlock(&vq->mutex);
=20
 	for (i =3D 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq =3D &vsock->vqs[i];
=20
 		mutex_lock(&vq->mutex);
-		vq->private_data =3D NULL;
+		vhost_vq_set_backend(vq, NULL);
 		mutex_unlock(&vq->mutex);
 	}
 err:
@@ -577,7 +577,7 @@ static int vhost_vsock_stop(struct vhost_vsock *vsock=
)
 		struct vhost_virtqueue *vq =3D &vsock->vqs[i];
=20
 		mutex_lock(&vq->mutex);
-		vq->private_data =3D NULL;
+		vhost_vq_set_backend(vq, NULL);
 		mutex_unlock(&vq->mutex);
 	}
=20
--=20
2.18.1
