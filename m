From: Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: vhost changes (batched) in linux-next after 12/13 trigger
 random crashes in KVM guests after reboot
Date: Fri, 14 Feb 2020 13:26:10 +0100
Message-ID: <8e226821a8878f53585d967b8af547526d84c73e.camel@redhat.com>
References: <20200107042401-mutt-send-email-mst@kernel.org>
         <CAJaqyWfngzP4d01B6+Sqt8FXN6jX7kGegjx8ie4no_1Er3igQA@mail.gmail.com>
         <43a5dbaa-9129-e220-8483-45c60a82c945@de.ibm.com>
         <e299afca8e22044916abbf9fbbd0bff6b0ee9e13.camel@redhat.com>
         <4c3f70b7-723a-8b0f-ac49-babef1bcc180@de.ibm.com>
         <50a79c3491ac483583c97df2fac29e2c3248fdea.camel@redhat.com>
         <8fbbfb49-99d1-7fee-e713-d6d5790fe866@de.ibm.com>
         <2364d0728c3bb4bcc0c13b591f774109a9274a30.camel@redhat.com>
         <bb9fb726-306c-5330-05aa-a86bd1b18097@de.ibm.com>
         <468983fad50a5e74a739f71487f0ea11e8d4dfd1.camel@redhat.com>
         <2dc1df65-1431-3917-40e5-c2b12096e2a7@de.ibm.com>
         <bd9c9b4d99abd20d5420583af5a4954ea1cf4618.camel@redhat.com>
         <e11ba53c-a5fa-0518-2e06-9296897ed529@de.ibm.com>
         <CAJaqyWfJFArAdpOwehTn5ci-frqai+pazGgcn2VvQSebqGRVtg@mail.gmail.com>
         <80520391-d90d-e10d-a107-7a18f2810900@de.ibm.com>
         <dabe59fe-e068-5935-f49e-bc1da3d8471a@de.ibm.com>
         <35dca16b9a85eb203f35d3e55dcaa9d0dae5a922.camel@redhat.com>
         <3144806d-436e-86a1-2e29-74f7027f7f0b@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3144806d-436e-86a1-2e29-74f7027f7f0b@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2020-02-14 at 13:22 +0100, Christian Borntraeger wrote:
> 
> On 14.02.20 13:17, Eugenio Pérez wrote:
> > Can you try the inlined patch over 52c36ce7f334 ("vhost: use batched version by default")? My intention is to check
> > if
> > "strange VHOST_SET_VRING_BASE" line appears. In previous tests, it appears very fast, but maybe it takes some time
> > for
> > it to appear, or it does not appear anymore.
> 
>   LD [M]  drivers/vhost/vhost_vsock.o
>   CC [M]  drivers/vhost/vhost.o
> In file included from ./include/linux/printk.h:331,
>                  from ./include/linux/kernel.h:15,
>                  from ./include/linux/list.h:9,
>                  from ./include/linux/wait.h:7,
>                  from ./include/linux/eventfd.h:13,
>                  from drivers/vhost/vhost.c:13:
> drivers/vhost/vhost.c: In function ‘fetch_descs’:
> drivers/vhost/vhost.c:2330:56: error: ‘struct vhost_virtqueue’ has no member named ‘first_desc’
>  2330 |   vq, vq->last_avail_idx, vq->avail_idx, vq->ndescs, vq->first_desc);
>       |                                                        ^~
> ./include/linux/dynamic_debug.h:125:15: note: in definition of macro ‘__dynamic_func_call’
>   125 |   func(&id, ##__VA_ARGS__);  \
>       |               ^~~~~~~~~~~
> ./include/linux/dynamic_debug.h:153:2: note: in expansion of macro ‘_dynamic_func_call’
>   153 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
>       |  ^~~~~~~~~~~~~~~~~~
> ./include/linux/printk.h:335:2: note: in expansion of macro ‘dynamic_pr_debug’
>   335 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~~~~~
> drivers/vhost/vhost.c:2328:2: note: in expansion of macro ‘pr_debug’
>  2328 |  pr_debug(
>       |  ^~~~~~~~
> make[2]: *** [scripts/Makefile.build:266: drivers/vhost/vhost.o] Error 1
> make[1]: *** [scripts/Makefile.build:503: drivers/vhost] Error 2
> 

Sorry about that. Here is the right patch.

From 5d7b5304c163910936382d46561fc43eb770aad2 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Date: Fri, 14 Feb 2020 08:02:26 +0100
Subject: [PATCH] vhost: disable all features and trace last_avail_idx and
 ioctl calls

---
 drivers/vhost/net.c   | 20 +++++++++++++++++---
 drivers/vhost/vhost.c | 25 +++++++++++++++++++++++--
 drivers/vhost/vhost.h | 10 +++++-----
 3 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index e158159671fa..e4d5f843f9c0 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1505,10 +1505,13 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 
 	mutex_lock(&n->dev.mutex);
 	r = vhost_dev_check_owner(&n->dev);
-	if (r)
+	if (r) {
+		pr_debug("vhost_dev_check_owner index=%u fd=%d rc r=%d", index, fd, r);
 		goto err;
+	}
 
 	if (index >= VHOST_NET_VQ_MAX) {
+		pr_debug("vhost_dev_check_owner index=%u fd=%d MAX=%d", index, fd, VHOST_NET_VQ_MAX);
 		r = -ENOBUFS;
 		goto err;
 	}
@@ -1518,22 +1521,26 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 
 	/* Verify that ring has been setup correctly. */
 	if (!vhost_vq_access_ok(vq)) {
+		pr_debug("vhost_net_set_backend index=%u fd=%d !vhost_vq_access_ok", index, fd);
 		r = -EFAULT;
 		goto err_vq;
 	}
 	sock = get_socket(fd);
 	if (IS_ERR(sock)) {
 		r = PTR_ERR(sock);
+		pr_debug("vhost_net_set_backend index=%u fd=%d get_socket err r=%d", index, fd, r);
 		goto err_vq;
 	}
 
 	/* start polling new socket */
 	oldsock = vq->private_data;
 	if (sock != oldsock) {
+		pr_debug("sock=%p != oldsock=%p index=%u fd=%d vq=%p", sock, oldsock, index, fd, vq);
 		ubufs = vhost_net_ubuf_alloc(vq,
 					     sock && vhost_sock_zcopy(sock));
 		if (IS_ERR(ubufs)) {
 			r = PTR_ERR(ubufs);
+			pr_debug("ubufs index=%u fd=%d err r=%d vq=%p", index, fd, r, vq);
 			goto err_ubufs;
 		}
 
@@ -1541,11 +1548,15 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 		vq->private_data = sock;
 		vhost_net_buf_unproduce(nvq);
 		r = vhost_vq_init_access(vq);
-		if (r)
+		if (r) {
+			pr_debug("init_access index=%u fd=%d r=%d vq=%p", index, fd, r, vq);
 			goto err_used;
+		}
 		r = vhost_net_enable_vq(n, vq);
-		if (r)
+		if (r) {
+			pr_debug("enable_vq index=%u fd=%d r=%d vq=%p", index, fd, r, vq);
 			goto err_used;
+		}
 		if (index == VHOST_NET_VQ_RX)
 			nvq->rx_ring = get_tap_ptr_ring(fd);
 
@@ -1559,6 +1570,8 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 
 	mutex_unlock(&vq->mutex);
 
+	pr_debug("sock=%p", sock);
+
 	if (oldubufs) {
 		vhost_net_ubuf_put_wait_and_free(oldubufs);
 		mutex_lock(&vq->mutex);
@@ -1710,6 +1723,7 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 
 	switch (ioctl) {
 	case VHOST_NET_SET_BACKEND:
+		pr_debug("VHOST_NET_SET_BACKEND");
 		if (copy_from_user(&backend, argp, sizeof backend))
 			return -EFAULT;
 		return vhost_net_set_backend(n, backend.index, backend.fd);
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 56c5253056ee..2e72bbeffac7 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1640,15 +1640,30 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 			r = -EINVAL;
 			break;
 		}
+
+		if (vq->last_avail_idx || vq->avail_idx) {
+			pr_debug(
+				"strange VHOST_SET_VRING_BASE [vq=%p][s.index=%u][s.num=%u]",
+				vq, s.index, s.num);
+			dump_stack();
+			r = 0;
+			break;
+		}
 		vq->last_avail_idx = s.num;
 		/* Forget the cached index value. */
 		vq->avail_idx = vq->last_avail_idx;
+		pr_debug(
+			"VHOST_SET_VRING_BASE [vq=%p][vq->last_avail_idx=%u][vq->avail_idx=%u][s.index=%u][s.num=%u]",
+			vq, vq->last_avail_idx, vq->avail_idx, s.index, s.num);
 		break;
 	case VHOST_GET_VRING_BASE:
 		s.index = idx;
 		s.num = vq->last_avail_idx;
 		if (copy_to_user(argp, &s, sizeof s))
 			r = -EFAULT;
+		pr_debug(
+			"VHOST_GET_VRING_BASE [vq=%p][vq->last_avail_idx=%u][vq->avail_idx=%u][s.index=%u][s.num=%u]",
+			vq, vq->last_avail_idx, vq->avail_idx, s.index, s.num);
 		break;
 	case VHOST_SET_VRING_KICK:
 		if (copy_from_user(&f, argp, sizeof f)) {
@@ -2233,8 +2248,8 @@ static int fetch_descs(struct vhost_virtqueue *vq)
 		vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
 
 		if (unlikely((u16)(vq->avail_idx - last_avail_idx) > vq->num)) {
-			vq_err(vq, "Guest moved used index from %u to %u",
-				last_avail_idx, vq->avail_idx);
+			vq_err(vq, "Guest moved vq %p used index from %u to %u",
+				vq, last_avail_idx, vq->avail_idx);
 			return -EFAULT;
 		}
 
@@ -2310,6 +2325,9 @@ static int fetch_descs(struct vhost_virtqueue *vq)
 	BUG_ON(!(vq->used_flags & VRING_USED_F_NO_NOTIFY));
 
 	/* On success, increment avail index. */
+	pr_debug(
+		"[vq=%p][vq->last_avail_idx=%u][vq->avail_idx=%u][vq->ndescs=%d]",
+		vq, vq->last_avail_idx, vq->avail_idx, vq->ndescs);
 	vq->last_avail_idx++;
 
 	return 0;
@@ -2403,6 +2421,9 @@ EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
 /* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
 void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
 {
+	pr_debug(
+		"DISCARD [vq=%p][vq->last_avail_idx=%u][vq->avail_idx=%u][n=%d]",
+		vq, vq->last_avail_idx, vq->avail_idx, n);
 	vq->last_avail_idx -= n;
 }
 EXPORT_SYMBOL_GPL(vhost_discard_vq_desc);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index a0bcf8bffa43..2ce2d3a97c31 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -248,11 +248,11 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled);
 	} while (0)
 
 enum {
-	VHOST_FEATURES = (1ULL << VIRTIO_F_NOTIFY_ON_EMPTY) |
-			 (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
-			 (1ULL << VIRTIO_RING_F_EVENT_IDX) |
-			 (1ULL << VHOST_F_LOG_ALL) |
-			 (1ULL << VIRTIO_F_ANY_LAYOUT) |
+	VHOST_FEATURES = /* (1ULL << VIRTIO_F_NOTIFY_ON_EMPTY) | */
+			 /* (1ULL << VIRTIO_RING_F_INDIRECT_DESC) | */
+			 /* (1ULL << VIRTIO_RING_F_EVENT_IDX) | */
+			 /* (1ULL << VHOST_F_LOG_ALL) | */
+			 /* (1ULL << VIRTIO_F_ANY_LAYOUT) | */
 			 (1ULL << VIRTIO_F_VERSION_1)
 };
 
-- 
2.18.1
