From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_ring: sparse warning fixup
Date: Mon, 13 Jul 2020 11:34:54 +0800
Message-ID: <64117f46-6cad-afd0-7753-1636d6474731@redhat.com>
References: <20200710104900.406084-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200710104900.406084-1-mst@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/10 下午6:49, Michael S. Tsirkin wrote:
> virtio_store_mb was built with split ring in mind so it accepts
> __virtio16 arguments. Packed ring uses __le16 values, so sparse
> complains.  It's just a store with some barriers so let's convert it to
> a macro, we don't loose too much type safety by doing that.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   include/linux/virtio_ring.h | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index 3dc70adfe5f5..b485b13fa50b 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -46,16 +46,15 @@ static inline void virtio_wmb(bool weak_barriers)
>   		dma_wmb();
>   }
>   
> -static inline void virtio_store_mb(bool weak_barriers,
> -				   __virtio16 *p, __virtio16 v)
> -{
> -	if (weak_barriers) {
> -		virt_store_mb(*p, v);
> -	} else {
> -		WRITE_ONCE(*p, v);
> -		mb();
> -	}
> -}
> +#define virtio_store_mb(weak_barriers, p, v) \
> +do { \
> +	if (weak_barriers) { \
> +		virt_store_mb(*p, v); \
> +	} else { \
> +		WRITE_ONCE(*p, v); \
> +		mb(); \
> +	} \
> +} while (0) \
>   
>   struct virtio_device;
>   struct virtqueue;


Acked-by: Jason Wang <jasowang@redhat.com>
