From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next] vhost_net: batch used ring update in rx
Date: Tue, 9 Jan 2018 17:44:53 +0200
Message-ID: <20180109170229-mutt-send-email-mst__26759.669246576$1515512591$gmane$org@kernel.org>
References: <1515493665-35306-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1515493665-35306-1-git-send-email-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, willemb@google.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 09, 2018 at 06:27:45PM +0800, Jason Wang wrote:
> This patch tries to batched used ring update during RX. This is pretty
> fit for the case when guest is much faster (e.g dpdk based
> backend). In this case, used ring is almost empty:
> 
> - we may get serious cache line misses/contending on both used ring
>   and used idx.
> - at most 1 packet could be dequeued at one time, batching in guest
>   does not make much effect.
> 
> Update used ring in a batch can help since guest won't access the used
> ring until used idx was advanced for several descriptors and since we
> advance used ring for every N packets, guest will only need to access
> used idx for every N packet since it can cache the used idx. To have a
> better interaction for both batch dequeuing and dpdk batching,
> VHOST_RX_BATCH was used as the maximum number of descriptors that
> could be batched.
> 
> Test were done between two machines with 2.40GHz Intel(R) Xeon(R) CPU
> E5-2630 connected back to back through ixgbe. Traffic were generated
> on one remote ixgbe through MoonGen and measure the RX pps through
> testpmd in guest when do xdp_redirect_map from local ixgbe to
> tap. RX pps were increased from 3.05 Mpps to 4.00 Mpps (about 31%
> improvement).
> 
> One possible concern for this is the implications for TCP (especially
> latency sensitive workload). Result[1] does not show obvious changes
> for most of the netperf test (RR, TX, and RX). And we do get some
> improvements for RX on some specific size.
> 
> Guest RX:
> 
> size/sessions/+thu%/+normalize%
>    64/     1/   +2%/   +2%
>    64/     2/   +2%/   -1%
>    64/     4/   +1%/   +1%
>    64/     8/    0%/    0%
>   256/     1/   +6%/   -3%
>   256/     2/   -3%/   +2%
>   256/     4/  +11%/  +11%
>   256/     8/    0%/    0%
>   512/     1/   +4%/    0%
>   512/     2/   +2%/   +2%
>   512/     4/    0%/   -1%
>   512/     8/   -8%/   -8%
>  1024/     1/   -7%/  -17%
>  1024/     2/   -8%/   -7%
>  1024/     4/   +1%/    0%
>  1024/     8/    0%/    0%
>  2048/     1/  +30%/  +14%
>  2048/     2/  +46%/  +40%
>  2048/     4/    0%/    0%
>  2048/     8/    0%/    0%
>  4096/     1/  +23%/  +22%
>  4096/     2/  +26%/  +23%
>  4096/     4/    0%/   +1%
>  4096/     8/    0%/    0%
> 16384/     1/   -2%/   -3%
> 16384/     2/   +1%/   -4%
> 16384/     4/   -1%/   -3%
> 16384/     8/    0%/   -1%
> 65535/     1/  +15%/   +7%
> 65535/     2/   +4%/   +7%
> 65535/     4/    0%/   +1%
> 65535/     8/    0%/    0%
> 
> TCP_RR:
> 
> size/sessions/+thu%/+normalize%
>     1/     1/    0%/   +1%
>     1/    25/   +2%/   +1%
>     1/    50/   +4%/   +1%
>    64/     1/    0%/   -4%
>    64/    25/   +2%/   +1%
>    64/    50/    0%/   -1%
>   256/     1/    0%/    0%
>   256/    25/    0%/    0%
>   256/    50/   +4%/   +2%
> 
> Guest TX:
> 
> size/sessions/+thu%/+normalize%
>    64/     1/   +4%/   -2%
>    64/     2/   -6%/   -5%
>    64/     4/   +3%/   +6%
>    64/     8/    0%/   +3%
>   256/     1/  +15%/  +16%
>   256/     2/  +11%/  +12%
>   256/     4/   +1%/    0%
>   256/     8/   +5%/   +5%
>   512/     1/   -1%/   -6%
>   512/     2/    0%/   -8%
>   512/     4/   -2%/   +4%
>   512/     8/   +6%/   +9%
>  1024/     1/   +3%/   +1%
>  1024/     2/   +3%/   +9%
>  1024/     4/    0%/   +7%
>  1024/     8/    0%/   +7%
>  2048/     1/   +8%/   +2%
>  2048/     2/   +3%/   -1%
>  2048/     4/   -1%/  +11%
>  2048/     8/   +3%/   +9%
>  4096/     1/   +8%/   +8%
>  4096/     2/    0%/   -7%
>  4096/     4/   +4%/   +4%
>  4096/     8/   +2%/   +5%
> 16384/     1/   -3%/   +1%
> 16384/     2/   -1%/  -12%
> 16384/     4/   -1%/   +5%
> 16384/     8/    0%/   +1%
> 65535/     1/    0%/   -3%
> 65535/     2/   +5%/  +16%
> 65535/     4/   +1%/   +2%
> 65535/     8/   +1%/   -1%
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I keep wondering whether we want control over this
from the guest (e.g. ethtool).

And I guess UDP_RR would be a better test.

But overall I agree it's a good default.

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  drivers/vhost/net.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index c7bdeb6..988af72 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -744,7 +744,7 @@ static void handle_rx(struct vhost_net *net)
>  	};
>  	size_t total_len = 0;
>  	int err, mergeable;
> -	s16 headcount;
> +	s16 headcount, nheads = 0;
>  	size_t vhost_hlen, sock_hlen;
>  	size_t vhost_len, sock_len;
>  	struct socket *sock;
> @@ -772,7 +772,7 @@ static void handle_rx(struct vhost_net *net)
>  	while ((sock_len = vhost_net_rx_peek_head_len(net, sock->sk))) {
>  		sock_len += sock_hlen;
>  		vhost_len = sock_len + vhost_hlen;
> -		headcount = get_rx_bufs(vq, vq->heads, vhost_len,
> +		headcount = get_rx_bufs(vq, vq->heads + nheads, vhost_len,
>  					&in, vq_log, &log,
>  					likely(mergeable) ? UIO_MAXIOV : 1);
>  		/* On error, stop handling until the next kick. */
> @@ -844,8 +844,12 @@ static void handle_rx(struct vhost_net *net)
>  			vhost_discard_vq_desc(vq, headcount);
>  			goto out;
>  		}
> -		vhost_add_used_and_signal_n(&net->dev, vq, vq->heads,
> -					    headcount);
> +		nheads += headcount;
> +		if (nheads > VHOST_RX_BATCH) {
> +			vhost_add_used_and_signal_n(&net->dev, vq, vq->heads,
> +						    nheads);
> +			nheads = 0;
> +		}
>  		if (unlikely(vq_log))
>  			vhost_log_write(vq, vq_log, log, vhost_len);
>  		total_len += vhost_len;
> @@ -856,6 +860,9 @@ static void handle_rx(struct vhost_net *net)
>  	}
>  	vhost_net_enable_vq(net, vq);
>  out:
> +	if (nheads)
> +		vhost_add_used_and_signal_n(&net->dev, vq, vq->heads,
> +					    nheads);
>  	mutex_unlock(&vq->mutex);
>  }
>  
> -- 
> 1.8.3.1
