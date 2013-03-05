From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC PATCH v1 01/33] mm: introduce common help functions to
	deal with reserved/managed pages
Date: Tue, 5 Mar 2013 20:47:22 +0100
Message-ID: <20130305194722.GA12225__43469.0152681016$1362513365$gmane$org@merkur.ravnborg.org>
References: <1362495317-32682-1-git-send-email-jiang.liu@huawei.com>
	<1362495317-32682-2-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1362495317-32682-2-git-send-email-jiang.liu@huawei.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, Aurelien Jacquiot <a-jacquiot@ti.com>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Tang Chen <tangchen@cn.fujitsu.com>, David Howells <dhowells@redhat.com>, Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>, Maciej Rutecki <maciej.rutecki@gmail.com>, Jonas Bonn <jonas@southpole.se>, Mark Salter <msalter@redhat.com>, Michel Lespinasse <walken@google.com>, Mikael Starvik <starvik@axis.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Ingo Molnar <mingo@redhat.com>, Geert
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 05, 2013 at 10:54:44PM +0800, Jiang Liu wrote:
> Code to deal with reserved/managed pages are duplicated by many
> architectures, so introduce common help functions to reduce duplicated
> code. These common help functions will also be used to concentrate code
> to modify totalram_pages and zone->managed_pages, which makes the code
> much more clear.
> 
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> ---
>  include/linux/mm.h |   37 +++++++++++++++++++++++++++++++++++++
>  mm/page_alloc.c    |   20 ++++++++++++++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7acc9dc..881461c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1295,6 +1295,43 @@ extern void free_area_init_node(int nid, unsigned long * zones_size,
>  		unsigned long zone_start_pfn, unsigned long *zholes_size);
>  extern void free_initmem(void);
>  
> +/* Help functions to deal with reserved/managed pages. */
> +extern unsigned long free_reserved_area(unsigned long start, unsigned long end,
> +					int poison, char *s);
> +
> +static inline void adjust_managed_page_count(struct page *page, long count)
> +{
> +	totalram_pages += count;
> +}

What is the purpose of the unused page argument?

> +
> +static inline void __free_reserved_page(struct page *page)
> +{
> +	ClearPageReserved(page);
> +	init_page_count(page);
> +	__free_page(page);
> +}
This method is useful for architectures which implment HIGHMEM,
like 32 bit x86 and 32 bit sparc.
This calls for a name without underscores.


> +
> +static inline void free_reserved_page(struct page *page)
> +{
> +	__free_reserved_page(page);
> +	adjust_managed_page_count(page, 1);
> +}
> +
> +static inline void mark_page_reserved(struct page *page)
> +{
> +	SetPageReserved(page);
> +	adjust_managed_page_count(page, -1);
> +}
> +
> +static inline void free_initmem_default(int poison)
> +{

Why request user to supply the poison argumet. If this is the default
implmentation then use the default poison value too (POISON_FREE_INITMEM)

> +	extern char __init_begin[], __init_end[];
> +
> +	free_reserved_area(PAGE_ALIGN((unsigned long)&__init_begin) ,
> +			   ((unsigned long)&__init_end) & PAGE_MASK,
> +			   poison, "unused kernel");
> +}


Maybe it is just me how is not used to this area of the kernel.
But a few comments that describe what the purpose is of each
function would have helped me.

	Sam
