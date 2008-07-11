From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] virtio_net: Set VIRTIO_NET_F_GUEST_CSUM feature
Date: Fri, 11 Jul 2008 01:22:22 -0400
Message-ID: <4876EE0E.1000400__7097.19889932803$1215754783$gmane$org@garzik.org>
References: <200807081710.42530.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200807081710.42530.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> From: Mark McLoughlin <markmc@redhat.com>
> 
> We can handle receiving partial csums, so set the
> appropriate feature bit.
> 
> Signed-off-by: Mark McLoughlin <markmc@redhat.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/net/virtio_net.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -550,7 +550,8 @@ static struct virtio_device_id id_table[
>  };
>  
>  static unsigned int features[] = {
> -	VIRTIO_NET_F_CSUM, VIRTIO_NET_F_GSO, VIRTIO_NET_F_MAC,
> +	VIRTIO_NET_F_CSUM, VIRTIO_NET_F_GUEST_CSUM,
> +	VIRTIO_NET_F_GSO, VIRTIO_NET_F_MAC,
>  	VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_UFO, VIRTIO_NET_F_HOST_TSO6,
>  	VIRTIO_NET_F_HOST_ECN, VIRTIO_F_NOTIFY_ON_EMPTY,
>  };
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in

applied
