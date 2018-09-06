From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 01/11] net: sock: introduce SOCK_XDP
Date: Thu, 6 Sep 2018 12:56:52 -0400
Message-ID: <20180906125615-mutt-send-email-mst__7095.08692748404$1536252936$gmane$org@kernel.org>
References: <20180906040526.22518-1-jasowang@redhat.com>
	<20180906040526.22518-2-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180906040526.22518-2-jasowang@redhat.com>
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

On Thu, Sep 06, 2018 at 12:05:16PM +0800, Jason Wang wrote:
> This patch introduces a new sock flag - SOCK_XDP. This will be used
> for notifying the upper layer that XDP program is attached on the
> lower socket, and requires for extra headroom.
> 
> TUN will be the first user.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

In fact vhost is the 1st user, right? So this can be
pushed out to become patch 10/11.

> ---
>  drivers/net/tun.c  | 19 +++++++++++++++++++
>  include/net/sock.h |  1 +
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index ebd07ad82431..2c548bd20393 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -869,6 +869,9 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>  		tun_napi_init(tun, tfile, napi);
>  	}
>  
> +	if (rtnl_dereference(tun->xdp_prog))
> +		sock_set_flag(&tfile->sk, SOCK_XDP);
> +
>  	tun_set_real_num_queues(tun);
>  
>  	/* device is allowed to go away first, so no need to hold extra
> @@ -1241,13 +1244,29 @@ static int tun_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  		       struct netlink_ext_ack *extack)
>  {
>  	struct tun_struct *tun = netdev_priv(dev);
> +	struct tun_file *tfile;
>  	struct bpf_prog *old_prog;
> +	int i;
>  
>  	old_prog = rtnl_dereference(tun->xdp_prog);
>  	rcu_assign_pointer(tun->xdp_prog, prog);
>  	if (old_prog)
>  		bpf_prog_put(old_prog);
>  
> +	for (i = 0; i < tun->numqueues; i++) {
> +		tfile = rtnl_dereference(tun->tfiles[i]);
> +		if (prog)
> +			sock_set_flag(&tfile->sk, SOCK_XDP);
> +		else
> +			sock_reset_flag(&tfile->sk, SOCK_XDP);
> +	}
> +	list_for_each_entry(tfile, &tun->disabled, next) {
> +		if (prog)
> +			sock_set_flag(&tfile->sk, SOCK_XDP);
> +		else
> +			sock_reset_flag(&tfile->sk, SOCK_XDP);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 433f45fc2d68..38cae35f6e16 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -800,6 +800,7 @@ enum sock_flags {
>  	SOCK_SELECT_ERR_QUEUE, /* Wake select on error queue */
>  	SOCK_RCU_FREE, /* wait rcu grace period in sk_destruct() */
>  	SOCK_TXTIME,
> +	SOCK_XDP, /* XDP is attached */
>  };
>  
>  #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
> -- 
> 2.17.1
