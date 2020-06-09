From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCH v2] mm/balloon_compaction: Fix trivial spelling
Date: Tue, 9 Jun 2020 22:02:31 +0530
Message-ID: <CAFqt6zYgS2tgapVQn93jpSnNWZna27wRSd+3ts_HoHm7pRmjZw@mail.gmail.com>
References: <20200609124610.3445662-16-kieran.bingham+renesas@ideasonboard.com>
 <20200609143412.3456484-1-kieran.bingham+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20200609143412.3456484-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>, David Hildenbrand <david@redhat.com>, linux-renesas-soc@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <trivial@kernel.org>, "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux-foundation.org>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 9, 2020 at 8:04 PM Kieran Bingham
<kieran.bingham+renesas@ideasonboard.com> wrote:
>
> The word 'descriptor' is misspelled throughout the tree.

I think, *throughout the tree* is not appropriate* here. This patch
has fixed it within the file. With that,

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

>
> Fix it up accordingly:
>     decriptors -> descriptors
>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/balloon_compaction.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index 26de020aae7b..907fefde2572 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -58,7 +58,7 @@ EXPORT_SYMBOL_GPL(balloon_page_list_enqueue);
>  /**
>   * balloon_page_list_dequeue() - removes pages from balloon's page list and
>   *                              returns a list of the pages.
> - * @b_dev_info: balloon device decriptor where we will grab a page from.
> + * @b_dev_info: balloon device descriptor where we will grab a page from.
>   * @pages: pointer to the list of pages that would be returned to the caller.
>   * @n_req_pages: number of requested pages.
>   *
> @@ -157,7 +157,7 @@ EXPORT_SYMBOL_GPL(balloon_page_enqueue);
>  /*
>   * balloon_page_dequeue - removes a page from balloon's page list and returns
>   *                       its address to allow the driver to release the page.
> - * @b_dev_info: balloon device decriptor where we will grab a page from.
> + * @b_dev_info: balloon device descriptor where we will grab a page from.
>   *
>   * Driver must call this function to properly dequeue a previously enqueued page
>   * before definitively releasing it back to the guest system.
> --
> 2.25.1
>
>
