From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_balloon: clear modern features under legacy
Date: Mon, 13 Jul 2020 11:36:51 +0800
Message-ID: <c0863b67-bd97-63a8-ff11-4f1b0fb655a3@redhat.com>
References: <20200710113046.421366-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20200710113046.421366-1-mst@redhat.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, David Hildenbrand <david@redhat.com>, virtualization@lists.linux-foundation.org, Alexander Duyck <alexander.duyck@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/10 下午7:31, Michael S. Tsirkin wrote:
> Page reporting features were never supported by legacy hypervisors.
> Supporting them poses a problem: should we use native endian-ness (like
> current code assumes)? Or little endian-ness like the virtio spec says?
> Rather than try to figure out, and since results of
> incorrect endian-ness are dire, let's just block this configuration.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/virtio/virtio_balloon.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 5d4b891bf84f..b9bc03345157 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -1107,6 +1107,15 @@ static int virtballoon_restore(struct virtio_device *vdev)
>   
>   static int virtballoon_validate(struct virtio_device *vdev)
>   {
> +	/*
> +	 * Legacy devices never specified how modern features should behave.
> +	 * E.g. which endian-ness to use? Better not to assume anything.
> +	 */
> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
> +		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
> +		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
> +	}
>   	/*
>   	 * Inform the hypervisor that our pages are poisoned or
>   	 * initialized. If we cannot do that then we should disable


Acked-by: Jason Wang <jasowang@redhat.com>
