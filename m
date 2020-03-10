From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1] MAINTAINERS: Add myself as virtio-balloon
 co-maintainer
Date: Tue, 10 Mar 2020 08:19:31 -0400
Message-ID: <20200310081850-mutt-send-email-mst@kernel.org>
References: <20200310115411.12760-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200310115411.12760-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Luiz Capitulino <lcapitulino@redhat.com>, Jason Wang <jasowang@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 10, 2020 at 12:54:11PM +0100, David Hildenbrand wrote:
> As suggested by Michael, let's add me as co-maintainer of virtio-balloon.
> While at it, also add "include/linux/balloon_compaction.h" to the file
> list.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Yea I don't think Jason actually has time to look at balloon patches.
Thanks for helping out!
I'll queue this.

> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c555f4be8c4e..da9f53a05d0e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17800,6 +17800,15 @@ F:	drivers/block/virtio_blk.c
>  F:	include/linux/virtio*.h
>  F:	include/uapi/linux/virtio_*.h
>  F:	drivers/crypto/virtio/
> +
> +VIRTIO BALLOON
> +M:	"Michael S. Tsirkin" <mst@redhat.com>
> +M:	David Hildenbrand <david@redhat.com>
> +L:	virtualization@lists.linux-foundation.org
> +S:	Maintained
> +F:	drivers/virtio/virtio_balloon.c
> +F:	include/uapi/linux/virtio_balloon.h
> +F:	include/linux/balloon_compaction.h
>  F:	mm/balloon_compaction.c
>  
>  VIRTIO BLOCK AND SCSI DRIVERS
> -- 
> 2.24.1
