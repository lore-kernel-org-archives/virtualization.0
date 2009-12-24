From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-net: defer f->private_data until setup succeeds
Date: Thu, 24 Dec 2009 08:06:50 +0200
Message-ID: <20091224060650.GA26128__48989.849308464$1261635015$gmane$org@redhat.com>
References: <20091222190228.GB2095@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091222190228.GB2095@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 22, 2009 at 11:02:28AM -0800, Chris Wright wrote:
> Trivial change, just for readability.  The filp is not installed on
> failure, so the current code is not incorrect (also vhost_dev_init
> currently has no failure case).  This just treats setting f->private_data
> as something with global scope (sure, true only after fd_install).
> 
> Signed-off-by: Chris Wright <chrisw@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/net.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 22d5fef..0697ab2 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -326,7 +326,6 @@ static int vhost_net_open(struct inode *inode, struct file *f)
>  	int r;
>  	if (!n)
>  		return -ENOMEM;
> -	f->private_data = n;
>  	n->vqs[VHOST_NET_VQ_TX].handle_kick = handle_tx_kick;
>  	n->vqs[VHOST_NET_VQ_RX].handle_kick = handle_rx_kick;
>  	r = vhost_dev_init(&n->dev, n->vqs, VHOST_NET_VQ_MAX);
> @@ -338,6 +337,9 @@ static int vhost_net_open(struct inode *inode, struct file *f)
>  	vhost_poll_init(n->poll + VHOST_NET_VQ_TX, handle_tx_net, POLLOUT);
>  	vhost_poll_init(n->poll + VHOST_NET_VQ_RX, handle_rx_net, POLLIN);
>  	n->tx_poll_state = VHOST_NET_POLL_DISABLED;
> +
> +	f->private_data = n;
> +
>  	return 0;
>  }
>  
