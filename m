From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v8, part3 12/14] mm: correctly update zone->mamaged_pages
Date: Mon, 27 May 2013 17:57:07 +0400
Message-ID: <51A36633.2030905__13972.7349197075$1369958582$gmane$org@cogentembedded.com>
References: <1369575522-26405-1-git-send-email-jiang.liu@huawei.com>
	<1369575522-26405-13-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1369575522-26405-13-git-send-email-jiang.liu@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jiang Liu <liuj97@gmail.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "Michael S. Tsirkin" <mst@redhat.com>, Tang Chen <tangchen@cn.fujitsu.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-mm@kvack.org, Michal Hocko <mhocko@suse.cz>, linux-arch@vger.kernel.org, xen-devel@lists.xensource.com, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Mark Salter <msalter@redhat.com>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Chris Metcalf <cmetcalf@tilera.com>, Jianguo Wu <wujianguo@huawei.com>, virtualization@lists.linux-foundation.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 26-05-2013 17:38, Jiang Liu wrote:

    Typo in the subject: s/mamaged_pages/managed_pages/.

> Enhance adjust_managed_page_count() to adjust totalhigh_pages for
> highmem pages. And change code which directly adjusts totalram_pages
> to use adjust_managed_page_count() because it adjusts totalram_pages,
> totalhigh_pages and zone->managed_pages altogether in a safe way.

> Remove inc_totalhigh_pages() and dec_totalhigh_pages() from xen/balloon
> driver bacause adjust_managed_page_count() has already adjusted
> totalhigh_pages.

> This patch also fixes two bugs:
> 1) enhances virtio_balloon driver to adjust totalhigh_pages when
>     reserve/unreserve pages.
> 2) enhance memory_hotplug.c to adjust totalhigh_pages when hot-removing
>     memory.

> We still need to deal with modifications of totalram_pages in file
> arch/powerpc/platforms/pseries/cmm.c, but need help from PPC experts.

> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Jeremy Fitzhardinge <jeremy@goop.org>
> Cc: Wen Congyang <wency@cn.fujitsu.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Tang Chen <tangchen@cn.fujitsu.com>
> Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: xen-devel@lists.xensource.com
> Cc: linux-mm@kvack.org
> ---
>   drivers/virtio/virtio_balloon.c |  8 +++++---
>   drivers/xen/balloon.c           | 23 +++++------------------
>   mm/hugetlb.c                    |  2 +-
>   mm/memory_hotplug.c             | 16 +++-------------
>   mm/page_alloc.c                 | 10 +++++-----
>   5 files changed, 19 insertions(+), 40 deletions(-)

> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index bd3ae32..6649968 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
[...]
> @@ -160,11 +160,13 @@ static void fill_balloon(struct virtio_balloon *vb, size_t num)
>   static void release_pages_by_pfn(const u32 pfns[], unsigned int num)
>   {
>   	unsigned int i;
> +	struct page *page;

    Why not declare it right in the *for* loop? You could use intializer 
then...

>
>   	/* Find pfns pointing at start of each page, get pages and free them. */
>   	for (i = 0; i < num; i += VIRTIO_BALLOON_PAGES_PER_PAGE) {
> -		balloon_page_free(balloon_pfn_to_page(pfns[i]));
> -		totalram_pages++;
> +		page = balloon_pfn_to_page(pfns[i]);
> +		balloon_page_free(page);
> +		adjust_managed_page_count(page, 1);
>   	}
>   }
>
[...]

WBR, Sergei
