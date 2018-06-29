From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH vhost] vhost_net: Fix too many vring kick on busypoll
Date: Fri, 29 Jun 2018 19:38:21 +0300
Message-ID: <20180629193448-mutt-send-email-mst@kernel.org>
References: <1530259790-2414-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1530259790-2414-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 29, 2018 at 05:09:50PM +0900, Toshiaki Makita wrote:
> Under heavy load vhost busypoll may run without suppressing
> notification. For example tx zerocopy callback can push tx work while
> handle_tx() is running, then busyloop exits due to vhost_has_work()
> condition and enables notification but immediately reenters handle_tx()
> because the pushed work was tx. In this case handle_tx() tries to
> disable notification again, but when using event_idx it by design
> cannot. Then busyloop will run without suppressing notification.
> Another example is the case where handle_tx() tries to enable
> notification but avail idx is advanced so disables it again. This case
> also lead to the same situation with event_idx.
> 
> The problem is that once we enter this situation busyloop does not work
> under heavy load for considerable amount of time, because notification
> is likely to happen during busyloop and handle_tx() immediately enables
> notification after notification happens. Specifically busyloop detects
> notification by vhost_has_work() and then handle_tx() calls
> vhost_enable_notify().

I'd like to understand the problem a bit better.
Why does this happen?
Doesn't this only happen if ring is empty?

> Because the detected work was the tx work, it
> enters handle_tx(), and enters busyloop without suppression again.
> This is likely to be repeated, so with event_idx we are almost not able
> to suppress notification in this case.
> 
> To fix this, poll the work instead of enabling notification when
> busypoll is interrupted by something. IMHO signal_pending() and
> vhost_has_work() are kind of interruptions rather than signals to
> completely cancel the busypoll, so let's run busypoll after the
> necessary work is done. In order to avoid too long busyloop due to
> interruption, save the endtime in vq field and use it when reentering
> the work function.
> 
> I observed this problem makes tx performance poor but does not rx. I
> guess it is because rx notification from socket is not that heavy so
> did not impact the performance even when we failed to mask the
> notification. Anyway for consistency I fixed rx routine as well as tx.
> 
> Performance numbers:
> 
> - Bulk transfer from guest to external physical server.
>     [Guest]->vhost_net->tap--(XDP_REDIRECT)-->i40e --(wire)--> [Server]
> - Set 10us busypoll.
> - Guest disables checksum and TSO because of host XDP.
> - Measured single flow Mbps by netperf, and kicks by perf kvm stat
>   (EPT_MISCONFIG event).
> 
>                             Before              After
>                           Mbps  kicks/s      Mbps  kicks/s
> UDP_STREAM 1472byte              247758                 27
>                 Send   3645.37            6958.10
>                 Recv   3588.56            6958.10
>               1byte                9865                 37
>                 Send      4.34               5.43
>                 Recv      4.17               5.26
> TCP_STREAM             8801.03    45794   9592.77     2884
> 
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

Is this with busy poll enabled?
Are there CPU utilization #s?

> ---
>  drivers/vhost/net.c   | 94 +++++++++++++++++++++++++++++++++++----------------
>  drivers/vhost/vhost.c |  1 +
>  drivers/vhost/vhost.h |  1 +
>  3 files changed, 66 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index eeaf6739215f..0e85f628b965 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -391,13 +391,14 @@ static inline unsigned long busy_clock(void)
>  	return local_clock() >> 10;
>  }
>  
> -static bool vhost_can_busy_poll(struct vhost_dev *dev,
> -				unsigned long endtime)
> +static bool vhost_can_busy_poll(unsigned long endtime)
>  {
> -	return likely(!need_resched()) &&
> -	       likely(!time_after(busy_clock(), endtime)) &&
> -	       likely(!signal_pending(current)) &&
> -	       !vhost_has_work(dev);
> +	return likely(!need_resched() && !time_after(busy_clock(), endtime));
> +}
> +
> +static bool vhost_busy_poll_interrupted(struct vhost_dev *dev)
> +{
> +	return unlikely(signal_pending(current)) || vhost_has_work(dev);
>  }
>  
>  static void vhost_net_disable_vq(struct vhost_net *n,
> @@ -437,10 +438,21 @@ static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
>  
>  	if (r == vq->num && vq->busyloop_timeout) {
>  		preempt_disable();
> -		endtime = busy_clock() + vq->busyloop_timeout;
> -		while (vhost_can_busy_poll(vq->dev, endtime) &&
> -		       vhost_vq_avail_empty(vq->dev, vq))
> +		if (vq->busyloop_endtime) {
> +			endtime = vq->busyloop_endtime;
> +			vq->busyloop_endtime = 0;
> +		} else {
> +			endtime = busy_clock() + vq->busyloop_timeout;
> +		}
> +		while (vhost_can_busy_poll(endtime)) {
> +			if (vhost_busy_poll_interrupted(vq->dev)) {
> +				vq->busyloop_endtime = endtime;
> +				break;
> +			}
> +			if (!vhost_vq_avail_empty(vq->dev, vq))
> +				break;
>  			cpu_relax();
> +		}
>  		preempt_enable();
>  		r = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
>  				      out_num, in_num, NULL, NULL);
> @@ -509,12 +521,16 @@ static void handle_tx(struct vhost_net *net)
>  			break;
>  		/* Nothing new?  Wait for eventfd to tell us they refilled. */
>  		if (head == vq->num) {
> -			if (unlikely(vhost_enable_notify(&net->dev, vq))) {
> +			if (unlikely(vq->busyloop_endtime)) {
> +				/* Busy poll is interrupted. */
> +				vhost_poll_queue(&vq->poll);
> +			} else if (unlikely(vhost_enable_notify(&net->dev, vq))) {
>  				vhost_disable_notify(&net->dev, vq);
>  				continue;
>  			}
>  			break;
>  		}
> +		vq->busyloop_endtime = 0;
>  		if (in) {
>  			vq_err(vq, "Unexpected descriptor format for TX: "
>  			       "out %d, int %d\n", out, in);
> @@ -642,39 +658,51 @@ static void vhost_rx_signal_used(struct vhost_net_virtqueue *nvq)
>  
>  static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk)
>  {
> -	struct vhost_net_virtqueue *rvq = &net->vqs[VHOST_NET_VQ_RX];
> -	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_TX];
> -	struct vhost_virtqueue *vq = &nvq->vq;
> +	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
> +	struct vhost_net_virtqueue *tnvq = &net->vqs[VHOST_NET_VQ_TX];
> +	struct vhost_virtqueue *rvq = &rnvq->vq;
> +	struct vhost_virtqueue *tvq = &tnvq->vq;
>  	unsigned long uninitialized_var(endtime);
> -	int len = peek_head_len(rvq, sk);
> +	int len = peek_head_len(rnvq, sk);
>  
> -	if (!len && vq->busyloop_timeout) {
> +	if (!len && tvq->busyloop_timeout) {
>  		/* Flush batched heads first */
> -		vhost_rx_signal_used(rvq);
> +		vhost_rx_signal_used(rnvq);
>  		/* Both tx vq and rx socket were polled here */
> -		mutex_lock_nested(&vq->mutex, 1);
> -		vhost_disable_notify(&net->dev, vq);
> +		mutex_lock_nested(&tvq->mutex, 1);
> +		vhost_disable_notify(&net->dev, tvq);
>  
>  		preempt_disable();
> -		endtime = busy_clock() + vq->busyloop_timeout;
> +		if (rvq->busyloop_endtime) {
> +			endtime = rvq->busyloop_endtime;
> +			rvq->busyloop_endtime = 0;
> +		} else {
> +			endtime = busy_clock() + tvq->busyloop_timeout;
> +		}
>  
> -		while (vhost_can_busy_poll(&net->dev, endtime) &&
> -		       !sk_has_rx_data(sk) &&
> -		       vhost_vq_avail_empty(&net->dev, vq))
> +		while (vhost_can_busy_poll(endtime)) {
> +			if (vhost_busy_poll_interrupted(&net->dev)) {
> +				rvq->busyloop_endtime = endtime;
> +				break;
> +			}
> +			if (sk_has_rx_data(sk) ||
> +			    !vhost_vq_avail_empty(&net->dev, tvq))
> +				break;
>  			cpu_relax();
> +		}
>  
>  		preempt_enable();
>  
> -		if (!vhost_vq_avail_empty(&net->dev, vq))
> -			vhost_poll_queue(&vq->poll);
> -		else if (unlikely(vhost_enable_notify(&net->dev, vq))) {
> -			vhost_disable_notify(&net->dev, vq);
> -			vhost_poll_queue(&vq->poll);
> +		if (!vhost_vq_avail_empty(&net->dev, tvq)) {
> +			vhost_poll_queue(&tvq->poll);
> +		} else if (unlikely(vhost_enable_notify(&net->dev, tvq))) {
> +			vhost_disable_notify(&net->dev, tvq);
> +			vhost_poll_queue(&tvq->poll);
>  		}
>  
> -		mutex_unlock(&vq->mutex);
> +		mutex_unlock(&tvq->mutex);
>  
> -		len = peek_head_len(rvq, sk);
> +		len = peek_head_len(rnvq, sk);
>  	}
>  
>  	return len;
> @@ -804,6 +832,7 @@ static void handle_rx(struct vhost_net *net)
>  	mergeable = vhost_has_feature(vq, VIRTIO_NET_F_MRG_RXBUF);
>  
>  	while ((sock_len = vhost_net_rx_peek_head_len(net, sock->sk))) {
> +		vq->busyloop_endtime = 0;
>  		sock_len += sock_hlen;
>  		vhost_len = sock_len + vhost_hlen;
>  		headcount = get_rx_bufs(vq, vq->heads + nvq->done_idx,
> @@ -889,7 +918,12 @@ static void handle_rx(struct vhost_net *net)
>  			goto out;
>  		}
>  	}
> -	vhost_net_enable_vq(net, vq);
> +	if (unlikely(vq->busyloop_endtime)) {
> +		/* Busy poll is interrupted. */
> +		vhost_poll_queue(&vq->poll);
> +	} else {
> +		vhost_net_enable_vq(net, vq);
> +	}
>  out:
>  	vhost_rx_signal_used(nvq);
>  	mutex_unlock(&vq->mutex);
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 9beefa6ed1ce..fe83578fe336 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -323,6 +323,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
>  	vhost_reset_is_le(vq);
>  	vhost_disable_cross_endian(vq);
>  	vq->busyloop_timeout = 0;
> +	vq->busyloop_endtime = 0;
>  	vq->umem = NULL;
>  	vq->iotlb = NULL;
>  	__vhost_vq_meta_reset(vq);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 6c844b90a168..7e9cf80ccae9 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -144,6 +144,7 @@ struct vhost_virtqueue {
>  	bool user_be;
>  #endif
>  	u32 busyloop_timeout;
> +	unsigned long busyloop_endtime;
>  };
>  
>  struct vhost_msg_node {
> -- 
> 2.14.2
> 
