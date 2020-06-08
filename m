From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC v5 13/13] vhost: drop head based APIs
Date: Mon, 8 Jun 2020 11:57:48 +0800
Message-ID: <8e3f5b6f-a47b-73cd-e8e3-959d40f6c91c@redhat.com>
References: <20200607141057.704085-1-mst@redhat.com>
 <20200607141057.704085-14-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200607141057.704085-14-mst@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, eperezma@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/6/7 下午10:11, Michael S. Tsirkin wrote:
> Everyone's using buf APIs, no need for head based ones anymore.
>
> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> ---
>   drivers/vhost/vhost.c | 36 ++++++++----------------------------
>   drivers/vhost/vhost.h | 12 ------------
>   2 files changed, 8 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 72ee55c810c4..e6931b760b61 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2299,12 +2299,12 @@ static int fetch_buf(struct vhost_virtqueue *vq)
>   	return 1;
>   }
>   
> -/* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
> +/* Revert the effect of fetch_buf. Useful for error handling. */
> +static
>   void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
>   {
>   	vq->last_avail_idx -= n;
>   }
> -EXPORT_SYMBOL_GPL(vhost_discard_vq_desc);


The same question as previous version.

Do we need to rewind cached descriptor here?

Thanks
