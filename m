From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2, part1 01/29] mm: introduce common help functions to
	deal with reserved/managed pages
Date: Sun, 10 Mar 2013 10:20:42 +0100
Message-ID: <CAMuHMdXLEkKVfhPu-MfBE37SuHDoVtrEG92PZq2-nD3xw6GNQw__1046.99334265224$1362907295$gmane$org@mail.gmail.com>
References: <1362896833-21104-1-git-send-email-jiang.liu@huawei.com>
	<1362896833-21104-2-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1362896833-21104-2-git-send-email-jiang.liu@huawei.com>
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
Cc: xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, Aurelien Jacquiot <a-jacquiot@ti.com>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-snps-arc@vger.kernel.org, Tang Chen <tangchen@cn.fujitsu.com>, David Howells <dhowells@redhat.com>, Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Sam Ravnborg <sam@ravnborg.org>, Lennox Wu <lennox.wu@gmail.com>, Maciej Rutecki <maciej.rutecki@gmail.com>, Jonas Bonn <jonas@southpole.se>, Mark Salter <msalter@redhat.com>, Michel Lespinasse <walken@google.com>, Mikael Starvik <starvik@axis.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Mar 10, 2013 at 7:26 AM, Jiang Liu <liuj97@gmail.com> wrote:
> Code to deal with reserved/managed pages are duplicated by many
> architectures, so introduce common help functions to reduce duplicated
> code. These common help functions will also be used to concentrate code
> to modify totalram_pages and zone->managed_pages, which makes the code
> much more clear.
>
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>

I have a few minor comments (see below), but apart from that:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> ---
>  include/linux/mm.h |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/page_alloc.c    |   20 ++++++++++++++++++++
>  2 files changed, 68 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7acc9dc..d75c14b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1295,6 +1295,54 @@ extern void free_area_init_node(int nid, unsigned long * zones_size,
>                 unsigned long zone_start_pfn, unsigned long *zholes_size);
>  extern void free_initmem(void);
>
> +/*
> + * Free reserved pages within range [PAGE_ALIGN(start), end & PAGE_MASK)
> + * into the buddy system. The freed pages will be poisoned with pattern
> + * "poison" if it's non-zero.

What if you want to poison with zero?
As poison is a full int, but memset only uses the least-significant
byte, you can
change it to poison if it's positive (i.e. >= 0)?

> +/*
> + * Default method to free all the __init memory into the buddy system.
> + * The freed pages will be poisoned with pattern "poison" if it is
> + * non-zero. Return pages freed into the buddy system.
> + */
> +static inline unsigned long free_initmem_default(int poison)
> +{
> +       extern char __init_begin[], __init_end[];
> +
> +       return free_reserved_area(PAGE_ALIGN((unsigned long)&__init_begin) ,
> +                                 ((unsigned long)&__init_end) & PAGE_MASK,

The "PAGE_ALIGN(...)" and "& PAGE_MASK" are superfluous, as
free_reserved_area() already does that.

> +                                 poison, "unused kernel");
> +}
> +

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8fcced7..0fadb09 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5113,6 +5113,26 @@ early_param("movablecore", cmdline_parse_movablecore);
>
>  #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
>
> +unsigned long free_reserved_area(unsigned long start, unsigned long end,
> +                                int poison, char *s)
> +{

> +       if (pages && s)
> +               pr_info("Freeing %s memory: %ldK (%lx - %lx)\n",

"%luKiB (0x%lx - 0x%lx)"?

> +                       s, pages << (PAGE_SHIFT - 10), start, end);
> +
> +       return pages;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
