From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 vhost next 05/10] vhost: Fix documentation
Date: Tue, 21 Jul 2020 13:35:03 +0800
Message-ID: <7c323cac-fa03-bc46-1c41-ee7d37f350cf@redhat.com>
References: <20200720071416.32112-1-eli@mellanox.com>
 <20200720071416.32112-6-eli@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200720071416.32112-6-eli@mellanox.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eli Cohen <eli@mellanox.com>, mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/20 下午3:14, Eli Cohen wrote:
> Fix documentation to match actual function prototypes.
>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Eli Cohen <eli@mellanox.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vhost/iotlb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
> index 1f0ca6e44410..0d4213a54a88 100644
> --- a/drivers/vhost/iotlb.c
> +++ b/drivers/vhost/iotlb.c
> @@ -149,7 +149,7 @@ EXPORT_SYMBOL_GPL(vhost_iotlb_free);
>    * vhost_iotlb_itree_first - return the first overlapped range
>    * @iotlb: the IOTLB
>    * @start: start of IOVA range
> - * @end: end of IOVA range
> + * @last: last byte in IOVA range
>    */
>   struct vhost_iotlb_map *
>   vhost_iotlb_itree_first(struct vhost_iotlb *iotlb, u64 start, u64 last)
> @@ -162,7 +162,7 @@ EXPORT_SYMBOL_GPL(vhost_iotlb_itree_first);
>    * vhost_iotlb_itree_first - return the next overlapped range
>    * @iotlb: the IOTLB
>    * @start: start of IOVA range
> - * @end: end of IOVA range
> + * @last: last byte IOVA range
>    */
>   struct vhost_iotlb_map *
>   vhost_iotlb_itree_next(struct vhost_iotlb_map *map, u64 start, u64 last)
