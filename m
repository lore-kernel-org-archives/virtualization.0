From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] virtio_balloon: prevent pfn array overflow
Date: Thu, 6 Feb 2020 09:29:27 +0100
Message-ID: <7ccd0cff-b132-aa90-7117-5058df29810f@redhat.com>
References: <20200206074644.1177551-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200206074644.1177551-1-mst@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

On 06.02.20 08:47, Michael S. Tsirkin wrote:
> Make sure, at build time, that pfn array is big enough to hold a single
> page.  It happens to be true since the PAGE_SHIFT value at the moment is
> 20, which is 1M - exactly 256 4K balloon pages.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_balloon.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 8e400ece9273..2457c54b6185 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -158,6 +158,8 @@ static void set_page_pfns(struct virtio_balloon *vb,
>  {
>  	unsigned int i;
>  
> +	BUILD_BUG_ON(VIRTIO_BALLOON_PAGES_PER_PAGE > VIRTIO_BALLOON_ARRAY_PFNS_MAX);
> +
>  	/*
>  	 * Set balloon pfns pointing at this page.
>  	 * Note that the first pfn points at start of the page.
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
