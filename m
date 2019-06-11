From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH trivial] mm/balloon_compaction: Grammar s/the its/its/
Date: Tue, 11 Jun 2019 14:02:07 +0200
Message-ID: <7db7ee2f-3b21-282e-164f-60bf3a2cab92__10712.9805300914$1560254553$gmane$org@redhat.com>
References: <20190607113559.15115-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190607113559.15115-1-geert+renesas@glider.be>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Jiri Kosina <trivial@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 07.06.19 13:35, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  mm/balloon_compaction.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index ba739b76e6c52e55..17ac81d8d26bcb50 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -60,7 +60,7 @@ EXPORT_SYMBOL_GPL(balloon_page_enqueue);
>  
>  /*
>   * balloon_page_dequeue - removes a page from balloon's page list and returns
> - *			  the its address to allow the driver release the page.
> + *			  its address to allow the driver to release the page.
>   * @b_dev_info: balloon device decriptor where we will grab a page from.
>   *
>   * Driver must call it to properly de-allocate a previous enlisted balloon page
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
