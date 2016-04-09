From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] drivers/virtio/virtio_ring.c: Deinline virtqueue_add,
	save 1016 bytes
Date: Sat, 9 Apr 2016 23:14:37 +0300
Message-ID: <20160409231155-mutt-send-email-mst@redhat.com>
References: <1460141926-13069-1-git-send-email-dvlasenk@redhat.com>
	<1460141926-13069-3-git-send-email-dvlasenk@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1460141926-13069-3-git-send-email-dvlasenk@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Denys Vlasenko <dvlasenk@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 08, 2016 at 08:58:44PM +0200, Denys Vlasenko wrote:
> This function compiles to 839 bytes of machine code.
> In C, it is ~150 lines long.
> 
> This function has 3 callsites.
> 
> Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: virtualization@lists.linux-foundation.org
> CC: linux-kernel@vger.kernel.org

This function is one of the most performance critical ones in the driver, a
bunch of tuning went into it, making this inline intentionally.  I'd
have to see some numbers showing making it non-inline is a worth-while
tradeoff.

> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index e12e385..77a4771 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -126,7 +126,7 @@ static struct vring_desc *alloc_indirect(struct virtqueue *_vq,
>  	return desc;
>  }
>  
> -static inline int virtqueue_add(struct virtqueue *_vq,
> +static int virtqueue_add(struct virtqueue *_vq,
>  				struct scatterlist *sgs[],
>  				unsigned int total_sg,
>  				unsigned int out_sgs,
> -- 
> 2.1.0
