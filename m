From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next V2 11/11] vhost_net: batch submitting XDP
	buffers to underlayer sockets
Date: Thu, 13 Sep 2018 14:04:59 -0400
Message-ID: <20180913140332-mutt-send-email-mst__13495.0319923975$1536861780$gmane$org@kernel.org>
References: <20180912031709.14112-1-jasowang@redhat.com>
	<20180912031709.14112-12-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180912031709.14112-12-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 12, 2018 at 11:17:09AM +0800, Jason Wang wrote:
> +static void vhost_tx_batch(struct vhost_net *net,
> +			   struct vhost_net_virtqueue *nvq,
> +			   struct socket *sock,
> +			   struct msghdr *msghdr)
> +{
> +	struct tun_msg_ctl ctl = {
> +		.type = TUN_MSG_PTR,
> +		.num = nvq->batched_xdp,
> +		.ptr = nvq->xdp,
> +	};
> +	int err;
> +
> +	if (nvq->batched_xdp == 0)
> +		goto signal_used;
> +
> +	msghdr->msg_control = &ctl;
> +	err = sock->ops->sendmsg(sock, msghdr, 0);
> +	if (unlikely(err < 0)) {
> +		vq_err(&nvq->vq, "Fail to batch sending packets\n");
> +		return;
> +	}
> +
> +signal_used:
> +	vhost_net_signal_used(nvq);
> +	nvq->batched_xdp = 0;
> +}
> +

Given it's all tun-specific now, how about just exporting tap_sendmsg
and calling that? Will get rid of some indirection too.

-- 
MST
