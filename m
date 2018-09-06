From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 09/11] tuntap: accept an array of XDP buffs
	through sendmsg()
Date: Thu, 6 Sep 2018 13:51:03 -0400
Message-ID: <20180906134834-mutt-send-email-mst@kernel.org>
References: <20180906040526.22518-1-jasowang@redhat.com>
	<20180906040526.22518-10-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180906040526.22518-10-jasowang@redhat.com>
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

On Thu, Sep 06, 2018 at 12:05:24PM +0800, Jason Wang wrote:
> This patch implement TUN_MSG_PTR msg_control type. This type allows
> the caller to pass an array of XDP buffs to tuntap through ptr field
> of the tun_msg_control. If an XDP program is attached, tuntap can run
> XDP program directly. If not, tuntap will build skb and do a fast
> receiving since part of the work has been done by vhost_net.
> 
> This will avoid lots of indirect calls thus improves the icache
> utilization and allows to do XDP batched flushing when doing XDP
> redirection.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Is most of the benefit in batched flushing or skipping
indirect calls? Because if it's flushing we can gain
most of it easily by adding an analog of xmit_more.

> ---
>  drivers/net/tun.c | 103 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 100 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index c839a4bdcbd9..069db2e5dd08 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2424,22 +2424,119 @@ static void tun_sock_write_space(struct sock *sk)
>  	kill_fasync(&tfile->fasync, SIGIO, POLL_OUT);
>  }
>  
> +static int tun_xdp_one(struct tun_struct *tun,
> +		       struct tun_file *tfile,
> +		       struct xdp_buff *xdp, int *flush)
> +{
> +	struct virtio_net_hdr *gso = xdp->data_hard_start + sizeof(int);
> +	struct tun_pcpu_stats *stats;
> +	struct bpf_prog *xdp_prog;
> +	struct sk_buff *skb = NULL;
> +	u32 rxhash = 0, act;
> +	int buflen = *(int *)xdp->data_hard_start;
> +	int err = 0;
> +	bool skb_xdp = false;
> +
> +	xdp_prog = rcu_dereference(tun->xdp_prog);
> +	if (xdp_prog) {
> +		if (gso->gso_type) {
> +			skb_xdp = true;
> +			goto build;
> +		}
> +		xdp_set_data_meta_invalid(xdp);
> +		xdp->rxq = &tfile->xdp_rxq;
> +		act = tun_do_xdp(tun, tfile, xdp_prog, xdp, &err);
> +		if (err)
> +			goto out;
> +		if (act == XDP_REDIRECT)
> +			*flush = true;
> +		if (act != XDP_PASS)
> +			goto out;
> +	}
> +
> +build:
> +	skb = build_skb(xdp->data_hard_start, buflen);
> +	if (!skb) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> +	skb_put(skb, xdp->data_end - xdp->data);
> +
> +	if (virtio_net_hdr_to_skb(skb, gso, tun_is_little_endian(tun))) {
> +		this_cpu_inc(tun->pcpu_stats->rx_frame_errors);
> +		kfree_skb(skb);
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	skb->protocol = eth_type_trans(skb, tun->dev);
> +	skb_reset_network_header(skb);
> +	skb_probe_transport_header(skb, 0);
> +
> +	if (skb_xdp) {
> +		err = do_xdp_generic(xdp_prog, skb);
> +		if (err != XDP_PASS)
> +			goto out;
> +	}
> +
> +	if (!rcu_dereference(tun->steering_prog))
> +		rxhash = __skb_get_hash_symmetric(skb);
> +
> +	netif_receive_skb(skb);
> +
> +	stats = get_cpu_ptr(tun->pcpu_stats);
> +	u64_stats_update_begin(&stats->syncp);
> +	stats->rx_packets++;
> +	stats->rx_bytes += skb->len;
> +	u64_stats_update_end(&stats->syncp);
> +	put_cpu_ptr(stats);
> +
> +	if (rxhash)
> +		tun_flow_update(tun, rxhash, tfile);
> +
> +out:
> +	return err;
> +}
> +
>  static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
>  {
> -	int ret;
> +	int ret, i;
>  	struct tun_file *tfile = container_of(sock, struct tun_file, socket);
>  	struct tun_struct *tun = tun_get(tfile);
>  	struct tun_msg_ctl *ctl = m->msg_control;
> +	struct xdp_buff *xdp;
>  
>  	if (!tun)
>  		return -EBADFD;
>  
> -	if (ctl && ctl->type != TUN_MSG_UBUF)
> -		return -EINVAL;
> +	if (ctl && ((ctl->type & 0xF) == TUN_MSG_PTR)) {
> +		int n = ctl->type >> 16;
> +		int flush = 0;
> +
> +		local_bh_disable();
> +		rcu_read_lock();
> +
> +		for (i = 0; i < n; i++) {
> +			xdp = &((struct xdp_buff *)ctl->ptr)[i];
> +			tun_xdp_one(tun, tfile, xdp, &flush);
> +		}
> +
> +		if (flush)
> +			xdp_do_flush_map();
> +
> +		rcu_read_unlock();
> +		local_bh_enable();
> +
> +		ret = total_len;
> +		goto out;
> +	}
>  
>  	ret = tun_get_user(tun, tfile, ctl ? ctl->ptr : NULL, &m->msg_iter,
>  			   m->msg_flags & MSG_DONTWAIT,
>  			   m->msg_flags & MSG_MORE);
> +out:
>  	tun_put(tun);
>  	return ret;
>  }
> -- 
> 2.17.1
