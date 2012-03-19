From: Steve Glass <stevie.glass@gmail.com>
Subject: vhost question
Date: Mon, 19 Mar 2012 13:11:41 +1000
Message-ID: <4F66A3ED.8080802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I'm using virtio to implement a mac80211 device in the guest. On the
host side I plan to use a simple network simulation to control
delivery of frames between guests. Right now I've used the vhost
approach on the host side and can pass buffers from guest to host and
back using virtio.

My immediate problem is how to have the host-side tx kick handler get
the host-side rx kick handler to run in order to deliver a frame? In
the tx kick handler I copy the frame into a queue for the receiving
guest. In the rx_handler I take queued frames and copy them into the
rx buffers and wake the guest. The problem is that if no frames are
ready for delivery when the guest rx kick handler runs then it has to
exit and somehow I have to arrange that it runs again (in the
receiver's process context) when there are frames to deliver.

How can I get my host-side tx kick handler to wake the host-side rx
kick handler to deliver frames to the guest?

Steve

static void
handle_rx(struct vhost_work *work)
{
int n;
unsigned out, in;
struct transmission *t;
u16 frames = 0;
struct vhost_poll *p = container_of(work, struct vhost_poll, work);
struct vhost_virtqueue *vq = container_of(p, struct vhost_virtqueue,
poll);
struct vhost_node *node = container_of(vq, struct vhost_node,
vqs[WLAN_VQ_RX]);
struct vhost_dev *dev = &node->vdev;

mutex_lock(&vq->mutex);
vhost_disable_notify(dev, vq);
while (!queue_empty(&node->rxq)) {
n = vhost_get_vq_desc(dev, vq, vq->iov, ARRAY_SIZE(vq->iov), &out,
&in, NULL, NULL);
if (0 < n || n == vq->num)
break;
if ((t = queue_pop(&node->rxq))) {
BUG_ON(copy_to_user(vq->iov[0].iov_base, t->buf, t->buf_sz));
vq->iov[0].iov_len = t->buf_sz;
// ToDo: copy_to_user the rx_status
vhost_add_used(vq, n, out);
transmission_free(t);
++frames;
}
}
if (frames)
vhost_signal(dev, vq);
vhost_enable_notify(dev, vq);
mutex_unlock(&vq->mutex);
}

static void
handle_tx(struct vhost_work *work)
{
int n;
unsigned out, in;
struct transmission *t;
struct vhost_poll *p = container_of(work, struct vhost_poll, work);
struct vhost_virtqueue *vq = container_of(p, struct vhost_virtqueue,
poll);
struct vhost_node *w = container_of(vq, struct vhost_node,
vqs[WLAN_VQ_TX]);
struct vhost_dev *dev = &w->vdev;

mutex_lock(&vq->mutex);
do {
vhost_disable_notify(dev, vq);
n = vhost_get_vq_desc(dev, vq, vq->iov, ARRAY_SIZE(vq->iov), &out,
&in, NULL, NULL);
while (n >= 0 && n != vq->num) {
struct vhost_node *receiver = net_get_receiver(w);
if(receiver) {
if((t = transmission_alloc())) {
BUG_ON(copy_from_user(t->buf, vq->iov[1].iov_base, vq->iov[1].iov_len));
t->buf_sz = vq->iov[1].iov_len;
queue_push(&receiver->rxq, t);
// ToDo: kick receiver's handle_rx
// ToDo: populate TX status
} else {
pr_warn("%s: out of memory - packet dropped!", __func__);
// ToDo: populate TX status
}
} else {
pr_debug("%s: no receivers in range!", __func__);
// ToDo: populate TX status
}
vhost_add_used(vq, n, out);
n = vhost_get_vq_desc(dev, vq, vq->iov, ARRAY_SIZE(vq->iov), &out,
&in, NULL, NULL);
}
vhost_signal(dev, vq);
} while (vhost_enable_notify(dev, vq));
mutex_unlock(&vq->mutex);
}


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9mo9cACgkQW7aAm65EWy4tagCgvsGxQM7Hhgjqc8/OAN5EsRrg
xW0An1jqNVvTICA5yhhj+6S9LtdkyHJi
=XGVm
-----END PGP SIGNATURE-----
