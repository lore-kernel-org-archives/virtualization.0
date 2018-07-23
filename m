From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: Re: [PATCH net-next v6 3/4] net: vhost: factor out busy polling logic
	to vhost_net_busy_poll()
Date: Mon, 23 Jul 2018 18:57:53 +0900
Message-ID: <c520c142-ef36-7918-7135-51258c17bd83@lab.ntt.co.jp>
References: <1532196242-2998-1-git-send-email-xiangxia.m.yue@gmail.com>
	<1532196242-2998-4-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1532196242-2998-4-git-send-email-xiangxia.m.yue@gmail.com>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 2018/07/22 3:04, xiangxia.m.yue@gmail.com wrote:
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> Factor out generic busy polling logic and will be
> used for in tx path in the next patch. And with the patch,
> qemu can set differently the busyloop_timeout for rx queue.
> 
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> ---
...
> +static void vhost_net_busy_poll_vq_check(struct vhost_net *net,
> +					 struct vhost_virtqueue *rvq,
> +					 struct vhost_virtqueue *tvq,
> +					 bool rx)
> +{
> +	struct socket *sock = rvq->private_data;
> +
> +	if (rx) {
> +		if (!vhost_vq_avail_empty(&net->dev, tvq)) {
> +			vhost_poll_queue(&tvq->poll);
> +		} else if (unlikely(vhost_enable_notify(&net->dev, tvq))) {
> +			vhost_disable_notify(&net->dev, tvq);
> +			vhost_poll_queue(&tvq->poll);
> +		}
> +	} else if ((sock && sk_has_rx_data(sock->sk)) &&
> +		    !vhost_vq_avail_empty(&net->dev, rvq)) {
> +		vhost_poll_queue(&rvq->poll);

Now we wait for vq_avail for rx as well, I think you cannot skip
vhost_enable_notify() on tx. Probably you might want to do:

} else if (sock && sk_has_rx_data(sock->sk)) {
	if (!vhost_vq_avail_empty(&net->dev, rvq)) {
		vhost_poll_queue(&rvq->poll);
	} else if (unlikely(vhost_enable_notify(&net->dev, rvq))) {
		vhost_disable_notify(&net->dev, rvq);
		vhost_poll_queue(&rvq->poll);
	}
}

Also it's better to care vhost_net_disable_vq()/vhost_net_enable_vq() on tx?

-- 
Toshiaki Makita
