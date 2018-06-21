From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] net: vhost: improve performance when enable busyloop
Date: Thu, 21 Jun 2018 13:59:07 +0800
Message-ID: <a2302593-d8c2-8abb-9b57-671ccdbc4889@redhat.com>
References: <1529501332-118823-1-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------EB6CC894810ADED97061FC60"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1529501332-118823-1-git-send-email-xiangxia.m.yue@gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Cc: netdev@vger.kernel.org, Tonghao Zhang <zhangtonghao@didichuxing.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------EB6CC894810ADED97061FC60
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2018年06月20日 21:28, Tonghao Zhang wrote:
> This patch improves the guest receive performance from
> host. On the handle_tx side, we poll the sock receive
> queue at the same time. handle_rx do that in the same way.
>
> we set the poll-us=100 us and use the iperf3 to test
> its throughput. The iperf3 command is shown as below.
>
> iperf3 -s -D
> iperf3 -c 192.168.1.100 -i 1 -P 10 -t 10 -M 1400 --bandwidth 100000M
>
> * With the patch:    21.1 Gbits/sec
> * Without the patch: 12.7 Gbits/sec

Thanks a lot for the patch. But looks like it needs some work to avoid 
e.g deadlock.

E.g in vhost_process_iotlb_msg() we call vhost_dev_lock_vqs() which did:

     for (i = 0; i < d->nvqs; ++i)
         mutex_lock_nested(&d->vqs[i]->mutex, i);

I believe we need to change the code to lock the vq one by one like the 
attached (only compile test).

> Signed-off-by: Tonghao Zhang <zhangtonghao@didichuxing.com>
> ---
>   drivers/vhost/net.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index e7cf7d2..9364ede 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -429,22 +429,43 @@ static int vhost_net_enable_vq(struct vhost_net *n,
>   	return vhost_poll_start(poll, sock->file);
>   }
>   
> +static int sk_has_rx_data(struct sock *sk);
> +

How about move sk_has_rx_data() here.

>   static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
>   				    struct vhost_virtqueue *vq,
>   				    struct iovec iov[], unsigned int iov_size,
>   				    unsigned int *out_num, unsigned int *in_num)
>   {
>   	unsigned long uninitialized_var(endtime);
> +	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_RX];
> +	struct vhost_virtqueue *rvq = &nvq->vq;
> +	struct socket *sock = rvq->private_data;
> +
>   	int r = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
>   				  out_num, in_num, NULL, NULL);
>   
>   	if (r == vq->num && vq->busyloop_timeout) {
> +		mutex_lock_nested(&rvq->mutex, 1);
> +
> +		vhost_disable_notify(&net->dev, rvq);
> +
>   		preempt_disable();
>   		endtime = busy_clock() + vq->busyloop_timeout;
>   		while (vhost_can_busy_poll(vq->dev, endtime) &&
> +		       !(sock && sk_has_rx_data(sock->sk)) &&
>   		       vhost_vq_avail_empty(vq->dev, vq))
>   			cpu_relax();
>   		preempt_enable();
> +
> +		if (sock && sk_has_rx_data(sock->sk))
> +			vhost_poll_queue(&rvq->poll);
> +		else if (unlikely(vhost_enable_notify(&net->dev, rvq))) {
> +			vhost_disable_notify(&net->dev, rvq);
> +			vhost_poll_queue(&rvq->poll);
> +		}
> +
> +		mutex_unlock(&rvq->mutex);

Some kinds of code duplication, can we try to unify them?

Btw, net-next is closed, so you need resubmit after it was open and use 
a "net-next" as the prefix of the patch.

Thanks

> +
>   		r = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
>   				      out_num, in_num, NULL, NULL);
>   	}


--------------EB6CC894810ADED97061FC60
Content-Type: text/x-patch;
 name="0001-vhost-lock-vqs-one-by-one.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-vhost-lock-vqs-one-by-one.patch"

From 383fe9d98420d92a632dc554969b4b1716017ba2 Mon Sep 17 00:00:00 2001
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Jun 2018 13:58:31 +0800
Subject: [PATCH] vhost: lock vqs one by one

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index e5bc4bb..937252d 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -294,8 +294,11 @@ static void vhost_vq_meta_reset(struct vhost_dev *d)
 {
 	int i;
 
-	for (i = 0; i < d->nvqs; ++i)
+	for (i = 0; i < d->nvqs; ++i) {
+		mutex_lock(&d->vqs[i]->mutex);
 		__vhost_vq_meta_reset(d->vqs[i]);
+		mutex_unlock(&d->vqs[i]->mutex);
+	}
 }
 
 static void vhost_vq_reset(struct vhost_dev *dev,
@@ -855,20 +858,6 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
 #define vhost_get_used(vq, x, ptr) \
 	vhost_get_user(vq, x, ptr, VHOST_ADDR_USED)
 
-static void vhost_dev_lock_vqs(struct vhost_dev *d)
-{
-	int i = 0;
-	for (i = 0; i < d->nvqs; ++i)
-		mutex_lock_nested(&d->vqs[i]->mutex, i);
-}
-
-static void vhost_dev_unlock_vqs(struct vhost_dev *d)
-{
-	int i = 0;
-	for (i = 0; i < d->nvqs; ++i)
-		mutex_unlock(&d->vqs[i]->mutex);
-}
-
 static int vhost_new_umem_range(struct vhost_umem *umem,
 				u64 start, u64 size, u64 end,
 				u64 userspace_addr, int perm)
@@ -918,7 +907,9 @@ static void vhost_iotlb_notify_vq(struct vhost_dev *d,
 		if (msg->iova <= vq_msg->iova &&
 		    msg->iova + msg->size - 1 > vq_msg->iova &&
 		    vq_msg->type == VHOST_IOTLB_MISS) {
+			mutex_lock(&node->vq->mutex);
 			vhost_poll_queue(&node->vq->poll);
+			mutex_unlock(&node->vq->mutex);
 			list_del(&node->node);
 			kfree(node);
 		}
@@ -950,7 +941,6 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
 	int ret = 0;
 
 	mutex_lock(&dev->mutex);
-	vhost_dev_lock_vqs(dev);
 	switch (msg->type) {
 	case VHOST_IOTLB_UPDATE:
 		if (!dev->iotlb) {
@@ -984,7 +974,6 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
 		break;
 	}
 
-	vhost_dev_unlock_vqs(dev);
 	mutex_unlock(&dev->mutex);
 
 	return ret;
-- 
2.7.4


--------------EB6CC894810ADED97061FC60
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--------------EB6CC894810ADED97061FC60--
