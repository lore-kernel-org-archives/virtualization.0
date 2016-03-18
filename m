From: Venkatesh Srinivas via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: [net-next v2] virtio_net: replace netdev_alloc_skb_ip_align()
	with napi_alloc_skb()
Date: Fri, 18 Mar 2016 08:58:32 -0700
Message-ID: <CAHdzE--a0pMLZiavb621yRcdh+UcSQPwYV=wC9+smbNHBYaWOQ__39806.4617570073$1458316726$gmane$org@mail.gmail.com>
References: <98c94ca899603eb4212c44aa1a658825198ed49a.1458290241.git.pabeni@redhat.com>
Reply-To: Venkatesh Srinivas <venkateshs@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <98c94ca899603eb4212c44aa1a658825198ed49a.1458290241.git.pabeni@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Hannes Frederic Sowa <hannes@stressinduktion.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 18, 2016 at 8:42 AM, Paolo Abeni <pabeni@redhat.com> wrote:
> This gives small but noticeable rx performance improvement (2-3%)
> and will allow exploiting future napi improvement.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>
> --
>  v2: replace also netdev_alloc_skb_ip_align() invocation in
>         add_recvbuf_small(), suggested by Venkatesh Srinivas
> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index fb0eae4..100e039 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -260,7 +260,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>         p = page_address(page) + offset;
>
>         /* copy small packet so we can reuse these pages for small data */
> -       skb = netdev_alloc_skb_ip_align(vi->dev, GOOD_COPY_LEN);
> +       skb = napi_alloc_skb(&rq->napi, GOOD_COPY_LEN);
>         if (unlikely(!skb))
>                 return NULL;
>
> @@ -541,7 +541,7 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>         struct virtio_net_hdr_mrg_rxbuf *hdr;
>         int err;
>
> -       skb = __netdev_alloc_skb_ip_align(vi->dev, GOOD_PACKET_LEN, gfp);
> +       skb = __napi_alloc_skb(&rq->napi, GOOD_PACKET_LEN, gfp);
>         if (unlikely(!skb))
>                 return -ENOMEM;

Sorry, I should've mentioned more in my first reply --
add_recvbuf_small is called from try_fill_recv in both
NAPI and non-NAPI context (NAPI: via virtnet_receive from
virtnet_poll; non-NAPI: via scheduled work,
via virtnet_probe, and via virtnet_restore).

I don't believe you can use __napi_alloc_skb() for the non-NAPI paths,
it'd be a bit more work to plumb
the context as an argument if you think its worth doing here.

Looking forward to bulk skb allocation either way.

HTH,
-- vs;
