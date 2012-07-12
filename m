From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [Xen-devel] [PATCH] xen: populate correct number of pages when
	across mem boundary
Date: Thu, 12 Jul 2012 15:55:14 +0100
Message-ID: <4FFEE552.4070201__22171.7298882597$1342460708$gmane$org@citrix.com>
References: <4FF3E781.5040603@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4FF3E781.5040603@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "zhenzhong.duan" <zhenzhong.duan@oracle.com>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org, Feng Jin <joe.jin@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

On 04/07/12 07:49, zhenzhong.duan wrote:
> When populate pages across a mem boundary at bootup, the page count
> populated isn't correct. This is due to mem populated to non-mem
> region and ignored.
> 
> Pfn range is also wrongly aligned when mem boundary isn't page aligned.
> 
> Also need consider the rare case when xen_do_chunk fail(populate).
> 
> For a dom0 booted with dom_mem=3368952K(0xcd9ff000-4k) dmesg diff is:
>  [    0.000000] Freeing 9e-100 pfn range: 98 pages freed
>  [    0.000000] 1-1 mapping on 9e->100
>  [    0.000000] 1-1 mapping on cd9ff->100000
>  [    0.000000] Released 98 pages of unused memory
>  [    0.000000] Set 206435 page(s) to 1-1 mapping
> -[    0.000000] Populating cd9fe-cda00 pfn range: 1 pages added
> +[    0.000000] Populating cd9fe-cd9ff pfn range: 1 pages added
> +[    0.000000] Populating 100000-100061 pfn range: 97 pages added
>  [    0.000000] BIOS-provided physical RAM map:
>  [    0.000000] Xen: 0000000000000000 - 000000000009e000 (usable)
>  [    0.000000] Xen: 00000000000a0000 - 0000000000100000 (reserved)
>  [    0.000000] Xen: 0000000000100000 - 00000000cd9ff000 (usable)
>  [    0.000000] Xen: 00000000cd9ffc00 - 00000000cda53c00 (ACPI NVS)
> ...
>  [    0.000000] Xen: 0000000100000000 - 0000000100061000 (usable)
>  [    0.000000] Xen: 0000000100061000 - 000000012c000000 (unusable)
> ...
>  [    0.000000] MEMBLOCK configuration:
> ...
> -[    0.000000]  reserved[0x4]       [0x000000cd9ff000-0x000000cd9ffbff], 0xc00 bytes
> -[    0.000000]  reserved[0x5]       [0x00000100000000-0x00000100060fff], 0x61000 bytes
> 
> Related xen memory layout:
> (XEN) Xen-e820 RAM map:
> (XEN)  0000000000000000 - 000000000009ec00 (usable)
> (XEN)  00000000000f0000 - 0000000000100000 (reserved)
> (XEN)  0000000000100000 - 00000000cd9ffc00 (usable)
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> ---
>  arch/x86/xen/setup.c |   24 +++++++++++-------------
>  1 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
> index a4790bf..bd78773 100644
> --- a/arch/x86/xen/setup.c
> +++ b/arch/x86/xen/setup.c
> @@ -157,50 +157,48 @@ static unsigned long __init xen_populate_chunk(
>  	unsigned long dest_pfn;
>  
>  	for (i = 0, entry = list; i < map_size; i++, entry++) {
> -		unsigned long credits = credits_left;
>  		unsigned long s_pfn;
>  		unsigned long e_pfn;
>  		unsigned long pfns;
>  		long capacity;
>  
> -		if (credits <= 0)
> +		if (credits_left <= 0)
>  			break;
>  
>  		if (entry->type != E820_RAM)
>  			continue;
>  
> -		e_pfn = PFN_UP(entry->addr + entry->size);
> +		e_pfn = PFN_DOWN(entry->addr + entry->size);

Ok.

>  
>  		/* We only care about E820 after the xen_start_info->nr_pages */
>  		if (e_pfn <= max_pfn)
>  			continue;
>  
> -		s_pfn = PFN_DOWN(entry->addr);
> +		s_pfn = PFN_UP(entry->addr);

Ok.

>  		/* If the E820 falls within the nr_pages, we want to start
>  		 * at the nr_pages PFN.
>  		 * If that would mean going past the E820 entry, skip it
>  		 */
> +again:
>  		if (s_pfn <= max_pfn) {
>  			capacity = e_pfn - max_pfn;
>  			dest_pfn = max_pfn;
>  		} else {
> -			/* last_pfn MUST be within E820_RAM regions */
> -			if (*last_pfn && e_pfn >= *last_pfn)
> -				s_pfn = *last_pfn;
>  			capacity = e_pfn - s_pfn;
>  			dest_pfn = s_pfn;
>  		}
> -		/* If we had filled this E820_RAM entry, go to the next one. */
> -		if (capacity <= 0)
> -			continue;
>  
> -		if (credits > capacity)
> -			credits = capacity;
> +		if (credits_left < capacity)
> +			capacity = credits_left;
>  
> -		pfns = xen_do_chunk(dest_pfn, dest_pfn + credits, false);
> +		pfns = xen_do_chunk(dest_pfn, dest_pfn + capacity, false);
>  		done += pfns;
>  		credits_left -= pfns;
>  		*last_pfn = (dest_pfn + pfns);
> +		if (credits_left > 0 && *last_pfn < e_pfn) {
> +			s_pfn = *last_pfn;
> +			goto again;
> +		}

This looks like it will loop forever if xen_do_chunk() repeatedly fails
because Xen is out of pages.  I think if xen_do_chunk() cannot get a
page from Xen the repopulation process should stop -- aborting this
chunk and any others.  This will allow the guest to continue to boot
just with less memory than expected.

David
