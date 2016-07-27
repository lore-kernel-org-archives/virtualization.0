From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 repost 3/7] mm: add a function to get the max pfn
Date: Thu, 28 Jul 2016 01:08:05 +0300
Message-ID: <20160728010729-mutt-send-email-mst__29094.5824039683$1469657311$gmane$org@kernel.org>
References: <1469582616-5729-1-git-send-email-liang.z.li@intel.com>
	<1469582616-5729-4-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1469582616-5729-4-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Liang Li <liang.z.li@intel.com>
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, Mel Gorman <mgorman@techsingularity.net>, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 27, 2016 at 09:23:32AM +0800, Liang Li wrote:
> Expose the function to get the max pfn, so it can be used in the
> virtio-balloon device driver.
> 
> Signed-off-by: Liang Li <liang.z.li@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Amit Shah <amit.shah@redhat.com>
> ---
>  mm/page_alloc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8b3e134..7da61ad 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4517,6 +4517,12 @@ void show_free_areas(unsigned int filter)
>  	show_swap_cache_info();
>  }
>  
> +unsigned long get_max_pfn(void)
> +{
> +	return max_pfn;
> +}
> +EXPORT_SYMBOL(get_max_pfn);
> +


This needs a coment that this can change at any time.
So it's only good as a hint e.g. for sizing data structures.

>  static void zoneref_set_zone(struct zone *zone, struct zoneref *zoneref)
>  {
>  	zoneref->zone = zone;
> -- 
> 1.9.1
