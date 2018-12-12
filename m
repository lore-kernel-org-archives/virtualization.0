From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net V2 2/4] vhost_net: switch to use mutex_trylock() in
	vhost_net_busy_poll()
Date: Wed, 12 Dec 2018 09:20:57 -0500
Message-ID: <20181212091957-mutt-send-email-mst__23086.9016646922$1544624374$gmane$org@kernel.org>
References: <20181212100819.21295-1-jasowang@redhat.com>
	<20181212100819.21295-3-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181212100819.21295-3-jasowang@redhat.com>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 12, 2018 at 06:08:17PM +0800, Jason Wang wrote:
> We used to hold the mutex of paired virtqueue in
> vhost_net_busy_poll(). But this will results an inconsistent lock
> order which may cause deadlock if we try to bring back the protection
> of device IOTLB with vq mutex that requires to hold mutex of all
> virtqueues at the same time.
> 
> Fix this simply by switching to use mutex_trylock(), when fail just
> skip the busy polling. This can happen when device IOTLB is under
> updating which should be rare.
> 
> Fixes: commit 78139c94dc8c ("net: vhost: lock the vqs one by one")
> Cc: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

and I think we should try to put this fix in 4.20 too.


> ---
>  drivers/vhost/net.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index ab11b2bee273..ad7a6f475a44 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -513,7 +513,13 @@ static void vhost_net_busy_poll(struct vhost_net *net,
>  	struct socket *sock;
>  	struct vhost_virtqueue *vq = poll_rx ? tvq : rvq;
>  
> -	mutex_lock_nested(&vq->mutex, poll_rx ? VHOST_NET_VQ_TX: VHOST_NET_VQ_RX);
> +	/* Try to hold the vq mutex of the paired virtqueue. We can't
> +	 * use mutex_lock() here since we could not guarantee a
> +	 * consistenet lock ordering.
> +	 */
> +	if (!mutex_trylock(&vq->mutex))
> +		return;
> +
>  	vhost_disable_notify(&net->dev, vq);
>  	sock = rvq->private_data;
>  
> -- 
> 2.17.1
