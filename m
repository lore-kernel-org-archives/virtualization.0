From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_balloon: prevent pfn array overflow
Date: Fri, 7 Feb 2020 11:37:37 +0800
Message-ID: <461dc5d5-4635-7b44-49bf-49422295e873@redhat.com>
References: <20200206074644.1177551-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200206074644.1177551-1-mst@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/6 =E4=B8=8B=E5=8D=883:47, Michael S. Tsirkin wrote:
> Make sure, at build time, that pfn array is big enough to hold a single
> page.  It happens to be true since the PAGE_SHIFT value at the moment i=
s
> 20, which is 1M - exactly 256 4K balloon pages.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/virtio/virtio_balloon.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ba=
lloon.c
> index 8e400ece9273..2457c54b6185 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -158,6 +158,8 @@ static void set_page_pfns(struct virtio_balloon *vb=
,
>   {
>   	unsigned int i;
>  =20
> +	BUILD_BUG_ON(VIRTIO_BALLOON_PAGES_PER_PAGE > VIRTIO_BALLOON_ARRAY_PFN=
S_MAX);
> +
>   	/*
>   	 * Set balloon pfns pointing at this page.
>   	 * Note that the first pfn points at start of the page.


Acked-by: Jason Wang <jasowang@redhat.com>
