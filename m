From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-mem: silence a static checker warning
Date: Wed, 10 Jun 2020 05:39:19 -0400
Message-ID: <20200610053912-mutt-send-email-mst@kernel.org>
References: <20200610085911.GC5439@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200610085911.GC5439@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 10, 2020 at 11:59:11AM +0300, Dan Carpenter wrote:
> Smatch complains that "rc" can be uninitialized if we hit the "break;"
> statement on the first iteration through the loop.  I suspect that this
> can't happen in real life, but returning a zero literal is cleaner and
> silence the static checker warning.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/virtio/virtio_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index f658fe9149beb..893ef18060a02 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -1192,7 +1192,7 @@ static int virtio_mem_mb_plug_any_sb(struct virtio_mem *vm, unsigned long mb_id,
>  						VIRTIO_MEM_MB_STATE_OFFLINE);
>  	}
>  
> -	return rc;
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.26.2
