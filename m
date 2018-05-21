From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [RFC PATCH net-next 03/12] vhost_net: introduce
	vhost_has_more_pkts()
Date: Mon, 21 May 2018 09:39:08 -0700
Message-ID: <20180521093908.00006747__14779.3512828232$1526920666$gmane$org@intel.com>
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
	<1526893473-20128-4-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1526893473-20128-4-git-send-email-jasowang@redhat.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 21 May 2018 17:04:24 +0800 Jason wrote:
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index de544ee..4ebac76 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -485,6 +485,13 @@ static bool vhost_exceeds_weight(int pkts, int total_len)
>  	       unlikely(pkts >= VHOST_NET_PKT_WEIGHT);
>  }
>  
> +static bool vhost_has_more_pkts(struct vhost_net *net,
> +				struct vhost_virtqueue *vq)
> +{
> +	return !vhost_vq_avail_empty(&net->dev, vq) &&
> +	       likely(!vhost_exceeds_maxpend(net));

This really seems like mis-use of likely/unlikely, in the middle of a
sequence of operations that will always be run when this function is
called.  I think you should remove the likely from this helper,
especially, and control the branch from the branch point.


> +}
> +
>  /* Expects to be always run from workqueue - which acts as
>   * read-size critical section for our kind of RCU. */
>  static void handle_tx(struct vhost_net *net)
> @@ -578,8 +585,7 @@ static void handle_tx(struct vhost_net *net)
>  		}
>  		total_len += len;
>  		if (total_len < VHOST_NET_WEIGHT &&
> -		    !vhost_vq_avail_empty(&net->dev, vq) &&
> -		    likely(!vhost_exceeds_maxpend(net))) {
> +		    vhost_has_more_pkts(net, vq)) {

Yes, I know it came from here, but likely/unlikely are for branch
control, so they should encapsulate everything inside the if, unless
I'm mistaken.

>  			msg.msg_flags |= MSG_MORE;
>  		} else {
>  			msg.msg_flags &= ~MSG_MORE;
> @@ -605,7 +611,7 @@ static void handle_tx(struct vhost_net *net)
>  		else
>  			vhost_zerocopy_signal_used(net, vq);
>  		vhost_net_tx_packet(net);
> -		if (unlikely(vhost_exceeds_weight(++sent_pkts, total_len))) {
> +		if (vhost_exceeds_weight(++sent_pkts, total_len)) {

You should have kept the unlikely here, and not had it inside the
helper (as per the previous patch.  Also, why wasn't this change part
of the previous patch?

>  			vhost_poll_queue(&vq->poll);
>  			break;
>  		}
