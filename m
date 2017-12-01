From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/3] tun: free skb in early errors
Date: Fri, 1 Dec 2017 16:48:17 +0200
Message-ID: <20171201164812-mutt-send-email-mst__38581.2532892034$1512139721$gmane$org@kernel.org>
References: <1512123038-15773-1-git-send-email-wexu@redhat.com>
	<1512123038-15773-3-git-send-email-wexu@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1512123038-15773-3-git-send-email-wexu@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: wexu@redhat.com
Cc: mjrosato@linux.vnet.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 01, 2017 at 05:10:37AM -0500, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
> 
> tun_recvmsg() supports accepting skb by msg_control after
> commit ac77cfd4258f ("tun: support receiving skb through msg_control"),
> the skb if presented should be freed no matter how far it can go
> along, otherwise it would be leaked.
> 
> This patch fixes several missed cases.
> 
> Signed-off-by: Wei Xu <wexu@redhat.com>
> Reported-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/tun.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 9574900..4f4a842 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1952,8 +1952,11 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
>  
>  	tun_debug(KERN_INFO, tun, "tun_do_read\n");
>  
> -	if (!iov_iter_count(to))
> +	if (!iov_iter_count(to)) {
> +		if (skb)
> +			kfree_skb(skb);
>  		return 0;
> +	}
>  
>  	if (!skb) {
>  		/* Read frames from ring */
> @@ -2069,22 +2072,24 @@ static int tun_recvmsg(struct socket *sock, struct msghdr *m, size_t total_len,
>  {
>  	struct tun_file *tfile = container_of(sock, struct tun_file, socket);
>  	struct tun_struct *tun = tun_get(tfile);
> +	struct sk_buff *skb = m->msg_control;
>  	int ret;
>  
> -	if (!tun)
> -		return -EBADFD;
> +	if (!tun) {
> +		ret = -EBADFD;
> +		goto out_free_skb;
> +	}
>  
>  	if (flags & ~(MSG_DONTWAIT|MSG_TRUNC|MSG_ERRQUEUE)) {
>  		ret = -EINVAL;
> -		goto out;
> +		goto out_put_tun;
>  	}
>  	if (flags & MSG_ERRQUEUE) {
>  		ret = sock_recv_errqueue(sock->sk, m, total_len,
>  					 SOL_PACKET, TUN_TX_TIMESTAMP);
>  		goto out;
>  	}
> -	ret = tun_do_read(tun, tfile, &m->msg_iter, flags & MSG_DONTWAIT,
> -			  m->msg_control);
> +	ret = tun_do_read(tun, tfile, &m->msg_iter, flags & MSG_DONTWAIT, skb);
>  	if (ret > (ssize_t)total_len) {
>  		m->msg_flags |= MSG_TRUNC;
>  		ret = flags & MSG_TRUNC ? ret : total_len;
> @@ -2092,6 +2097,13 @@ static int tun_recvmsg(struct socket *sock, struct msghdr *m, size_t total_len,
>  out:
>  	tun_put(tun);
>  	return ret;
> +
> +out_put_tun:
> +	tun_put(tun);
> +out_free_skb:
> +	if (skb)
> +		kfree_skb(skb);
> +	return ret;
>  }
>  
>  static int tun_peek_len(struct socket *sock)
> -- 
> 1.8.3.1
