From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] MAINTAINERS: add tools/virtio/ under virtio
Date: Mon, 08 Jul 2013 11:32:25 +0930
Message-ID: <87ip0lerm6.fsf@rustcorp.com.au>
References: <20130707143238.GA3059@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130707143238.GA3059@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> This should help make sure patches go to the correct list.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Indeed.  Thanks.

Applied,
Rusty.

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ad7e322..66172fc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8800,6 +8800,7 @@ M:	"Michael S. Tsirkin" <mst@redhat.com>
>  L:	virtualization@lists.linux-foundation.org
>  S:	Maintained
>  F:	drivers/virtio/
> +F:	tools/virtio/
>  F:	drivers/net/virtio_net.c
>  F:	drivers/block/virtio_blk.c
>  F:	include/linux/virtio_*.h
> -- 
> MST
