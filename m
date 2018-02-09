From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] mm/page_poison: move PAGE_POISON to page_poison.c
Date: Fri, 9 Feb 2018 18:23:53 +0200
Message-ID: <20180209180755-mutt-send-email-mst__22831.2613828622$1518193340$gmane$org@kernel.org>
References: <1518163694-27155-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1518163694-27155-1-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 09, 2018 at 04:08:14PM +0800, Wei Wang wrote:
> The PAGE_POISON macro is used in page_poison.c only, so avoid exporting
> it. Also remove the "mm/debug-pagealloc.c" related comment, which is
> obsolete.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/poison.h | 7 -------
>  mm/page_poison.c       | 6 ++++++
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/poison.h b/include/linux/poison.h
> index 15927eb..348bf67 100644
> --- a/include/linux/poison.h
> +++ b/include/linux/poison.h
> @@ -30,13 +30,6 @@
>   */
>  #define TIMER_ENTRY_STATIC	((void *) 0x300 + POISON_POINTER_DELTA)
>  
> -/********** mm/debug-pagealloc.c **********/
> -#ifdef CONFIG_PAGE_POISONING_ZERO
> -#define PAGE_POISON 0x00
> -#else
> -#define PAGE_POISON 0xaa
> -#endif
> -
>  /********** mm/page_alloc.c ************/
>  
>  #define TAIL_MAPPING	((void *) 0x400 + POISON_POINTER_DELTA)


My question is, why are these macros kept in a single header.
Is it so it's easy to figure out source of a crash by
looking at the data and locating it in the file?
If so we should keep it in the header, but fix the comment.
If no there are more macros to move out, like flex array ones.

> diff --git a/mm/page_poison.c b/mm/page_poison.c
> index e83fd44..8aaf076 100644
> --- a/mm/page_poison.c
> +++ b/mm/page_poison.c
> @@ -7,6 +7,12 @@
>  #include <linux/poison.h>
>  #include <linux/ratelimit.h>
>  
> +#ifdef CONFIG_PAGE_POISONING_ZERO
> +#define PAGE_POISON 0x00
> +#else
> +#define PAGE_POISON 0xaa
> +#endif
> +
>  static bool want_page_poisoning __read_mostly;
>  
>  static int early_page_poison_param(char *buf)
> -- 
> 2.7.4
