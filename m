From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] mm/balloon_compaction: Fix trivial spelling
Date: Wed, 10 Jun 2020 12:00:23 +0300
Message-ID: <6b13243c-db22-ef33-8aed-9b385cc10b58@cogentembedded.com>
References: <20200609124610.3445662-16-kieran.bingham+renesas@ideasonboard.com>
 <20200609143412.3456484-1-kieran.bingham+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20200609143412.3456484-1-kieran.bingham+renesas@ideasonboard.com>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, David Hildenbrand <david@redhat.com>
Cc: linux-renesas-soc@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <trivial@kernel.org>, "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux-foundation.org>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hello!

On 09.06.2020 17:34, Kieran Bingham wrote:

> The word 'descriptor' is misspelled throughout the tree.
> 
> Fix it up accordingly:
>      decriptors -> descriptors

       decriptor -> descriptor really. ;-)

> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/balloon_compaction.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index 26de020aae7b..907fefde2572 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -58,7 +58,7 @@ EXPORT_SYMBOL_GPL(balloon_page_list_enqueue);
>   /**
>    * balloon_page_list_dequeue() - removes pages from balloon's page list and
>    *				 returns a list of the pages.
> - * @b_dev_info: balloon device decriptor where we will grab a page from.
> + * @b_dev_info: balloon device descriptor where we will grab a page from.
>    * @pages: pointer to the list of pages that would be returned to the caller.
>    * @n_req_pages: number of requested pages.
>    *
> @@ -157,7 +157,7 @@ EXPORT_SYMBOL_GPL(balloon_page_enqueue);
>   /*
>    * balloon_page_dequeue - removes a page from balloon's page list and returns
>    *			  its address to allow the driver to release the page.
> - * @b_dev_info: balloon device decriptor where we will grab a page from.
> + * @b_dev_info: balloon device descriptor where we will grab a page from.
>    *
>    * Driver must call this function to properly dequeue a previously enqueued page
>    * before definitively releasing it back to the guest system.

MBR, Sergei
