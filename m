From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 15/17] mm: Fix trivial spelling
Date: Tue, 9 Jun 2020 16:03:59 +0200
Message-ID: <9a0220f5-d5b0-be62-3d5d-4ec5680ad822@redhat.com>
References: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
 <20200609124610.3445662-16-kieran.bingham+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20200609124610.3445662-16-kieran.bingham+renesas@ideasonboard.com>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <trivial@kernel.org>, "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux-foundation.org>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 09.06.20 14:46, Kieran Bingham wrote:
> The word 'descriptor' is misspelled throughout the tree.
> 

"mm/balloon_compaction:" is a better subject prefix

Reviewed-by: David Hildenbrand <david@redhat.com>

> Fix it up accordingly:
>     decriptors -> descriptors
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  virtio-mem-v3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index 26de020aae7b..907fefde2572 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -58,7 +58,7 @@ EXPORT_SYMBOL_GPL(balloon_page_list_enqueue);
>  /**
>   * balloon_page_list_dequeue() - removes pages from balloon's page list and
>   *				 returns a list of the pages.
> - * @b_dev_info: balloon device decriptor where we will grab a page from.
> + * @b_dev_info: balloon device descriptor where we will grab a page from.
>   * @pages: pointer to the list of pages that would be returned to the caller.
>   * @n_req_pages: number of requested pages.
>   *
> @@ -157,7 +157,7 @@ EXPORT_SYMBOL_GPL(balloon_page_enqueue);
>  /*
>   * balloon_page_dequeue - removes a page from balloon's page list and returns
>   *			  its address to allow the driver to release the page.
> - * @b_dev_info: balloon device decriptor where we will grab a page from.
> + * @b_dev_info: balloon device descriptor where we will grab a page from.
>   *
>   * Driver must call this function to properly dequeue a previously enqueued page
>   * before definitively releasing it back to the guest system.
> 


-- 
Thanks,

David / dhildenb
