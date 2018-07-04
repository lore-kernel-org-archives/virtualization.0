From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: Re: [PATCH net-next v5 3/4] net: vhost: factor out busy polling logic
	to vhost_net_busy_poll()
Date: Wed, 4 Jul 2018 16:59:20 +0900
Message-ID: <808dea9b-6240-8055-acaa-a1b96389a673@lab.ntt.co.jp>
References: <1530678698-33427-1-git-send-email-xiangxia.m.yue@gmail.com>
	<1530678698-33427-4-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1530678698-33427-4-git-send-email-xiangxia.m.yue@gmail.com>
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
To: xiangxia.m.yue@gmail.com, jasowang@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Tonghao Zhang <zhangtonghao@didichuxing.com>, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 2018/07/04 13:31, xiangxia.m.yue@gmail.com wrote:
...
> +static void vhost_net_busy_poll(struct vhost_net *net,
> +				struct vhost_virtqueue *rvq,
> +				struct vhost_virtqueue *tvq,
> +				bool rx)
> +{
> +	unsigned long uninitialized_var(endtime);
> +	unsigned long busyloop_timeout;
> +	struct socket *sock;
> +	struct vhost_virtqueue *vq = rx ? tvq : rvq;
> +
> +	mutex_lock_nested(&vq->mutex, rx ? VHOST_NET_VQ_TX: VHOST_NET_VQ_RX);
> +
> +	vhost_disable_notify(&net->dev, vq);
> +	sock = rvq->private_data;
> +	busyloop_timeout = rx ? rvq->busyloop_timeout : tvq->busyloop_timeout;
> +
> +	preempt_disable();
> +	endtime = busy_clock() + busyloop_timeout;
> +	while (vhost_can_busy_poll(tvq->dev, endtime) &&
> +	       !(sock && sk_has_rx_data(sock->sk)) &&
> +	       vhost_vq_avail_empty(tvq->dev, tvq))
> +		cpu_relax();
> +	preempt_enable();
> +
> +	if ((rx && !vhost_vq_avail_empty(&net->dev, vq)) ||
> +	    (!rx && (sock && sk_has_rx_data(sock->sk)))) {
> +		vhost_poll_queue(&vq->poll);
> +	} else if (vhost_enable_notify(&net->dev, vq) && rx) {

Hmm... on tx here sock has no rx data, so you are waiting for sock
wakeup for rx and vhost_enable_notify() seems not needed. Do you want
this actually?

} else if (rx && vhost_enable_notify(&net->dev, vq)) {

> +		vhost_disable_notify(&net->dev, vq);
> +		vhost_poll_queue(&vq->poll);
> +	}

-- 
Toshiaki Makita
