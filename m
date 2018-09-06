From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 07/11] tuntap: move XDP flushing out of
	tun_do_xdp()
Date: Thu, 6 Sep 2018 13:48:09 -0400
Message-ID: <20180906132209-mutt-send-email-mst__3515.47598043016$1536255969$gmane$org@kernel.org>
References: <20180906040526.22518-1-jasowang@redhat.com>
	<20180906040526.22518-8-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180906040526.22518-8-jasowang@redhat.com>
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

On Thu, Sep 06, 2018 at 12:05:22PM +0800, Jason Wang wrote:
> This will allow adding batch flushing on top.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/tun.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 21b125020b3b..ff1cbf3ebd50 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1646,7 +1646,6 @@ static u32 tun_do_xdp(struct tun_struct *tun,
>  	switch (act) {
>  	case XDP_REDIRECT:
>  		*err = xdp_do_redirect(tun->dev, xdp, xdp_prog);
> -		xdp_do_flush_map();
>  		if (*err)
>  			break;
>  		goto out;
> @@ -1735,6 +1734,9 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  		act = tun_do_xdp(tun, tfile, xdp_prog, &xdp, &err);
>  		if (err)
>  			goto err_xdp;
> +
> +		if (act == XDP_REDIRECT)
> +			xdp_do_flush_map();
>  		if (act != XDP_PASS)
>  			goto out;

At this point the switch statement which used to contain all XDP things
seems to be gone completely. Just rewrite with a bunch of if statements
and all xdp handling spread out to where it makes sense?

> -- 
> 2.17.1
