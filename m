From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v6v3 02/12] mm: migrate: support non-lru movable page
	migration
Date: Mon, 13 Jun 2016 15:08:19 +0530
Message-ID: <575E7F0B.8010201__11400.6043099382$1465832212$gmane$org@linux.vnet.ibm.com>
References: <1463754225-31311-1-git-send-email-minchan@kernel.org>
	<1463754225-31311-3-git-send-email-minchan@kernel.org>
	<20160530013926.GB8683@bbox> <20160531000117.GB18314@bbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160531000117.GB18314@bbox>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Rafael Aquini <aquini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, John Einar Reitan <john.reitan@foss.arm.com>, linux-mm@kvack.org, Gioh Kim <gi-oh.kim@profitbricks.com>, Mel Gorman <mgorman@suse.de>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On 05/31/2016 05:31 AM, Minchan Kim wrote:
> @@ -791,6 +921,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>  	int rc = -EAGAIN;
>  	int page_was_mapped = 0;
>  	struct anon_vma *anon_vma = NULL;
> +	bool is_lru = !__PageMovable(page);
>  
>  	if (!trylock_page(page)) {
>  		if (!force || mode == MIGRATE_ASYNC)
> @@ -871,6 +1002,11 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>  		goto out_unlock_both;
>  	}
>  
> +	if (unlikely(!is_lru)) {
> +		rc = move_to_new_page(newpage, page, mode);
> +		goto out_unlock_both;
> +	}
> +

Hello Minchan,

I might be missing something here but does this implementation support the
scenario where these non LRU pages owned by the driver mapped as PTE into
process page table ? Because the "goto out_unlock_both" statement above
skips all the PTE unmap, putting a migration PTE and removing the migration
PTE steps.

Regards
Anshuman
