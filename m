From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_balloon: fix sparse warning
Date: Mon, 13 Jul 2020 11:29:01 +0800
Message-ID: <2c3b61df-c5c8-536a-01d4-c468e958f6d7@redhat.com>
References: <20200710104837.405966-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200710104837.405966-1-mst@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/10 下午6:48, Michael S. Tsirkin wrote:
> balloon uses virtio32_to_cpu instead of cpu_to_virtio32
> to convert a native endian number to virtio.
> No practical difference but makes sparse warn.
> Fix it up.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/virtio/virtio_balloon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index fc7301406540..5d4b891bf84f 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -596,7 +596,7 @@ static int send_cmd_id_start(struct virtio_balloon *vb)
>   	while (virtqueue_get_buf(vq, &unused))
>   		;
>   
> -	vb->cmd_id_active = virtio32_to_cpu(vb->vdev,
> +	vb->cmd_id_active = cpu_to_virtio32(vb->vdev,
>   					virtio_balloon_cmd_id_received(vb));
>   	sg_init_one(&sg, &vb->cmd_id_active, sizeof(vb->cmd_id_active));
>   	err = virtqueue_add_outbuf(vq, &sg, 1, &vb->cmd_id_active, GFP_KERNEL);


Acked-by: Jason Wang <jasowang@redhat.com>
