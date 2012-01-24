From: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [Xen-devel] [PATCH] include/checkpatch: Prefer __scanf to
	__attribute__((format(scanf, ...)
Date: Mon, 23 Jan 2012 21:47:17 -0400
Message-ID: <20120124014717.GA24204@andromeda.dapyr.net>
References: <2cf7ddd75001233e79e928c4dcfae6768af5790c.1327103792.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <2cf7ddd75001233e79e928c4dcfae6768af5790c.1327103792.git.joe@perches.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Andy Whitcroft <apw@canonical.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 20, 2012 at 04:01:12PM -0800, Joe Perches wrote:
> It's equivalent to __printf, so prefer __scanf.

So ... looking at this patch it just seems to macro-fy the
__printf and __scanf attributes. Is this required to make
cleanpatch.pl work easier?

And there is also some checkpatch.pl features. Should that part
be in a seperate patch?

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  include/linux/compiler-gcc.h |    3 ++-
>  include/linux/kernel.h       |    8 ++++----
>  include/xen/xenbus.h         |    4 ++--
>  scripts/checkpatch.pl        |    6 ++++++
>  4 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 3fd17c2..e5834aa 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -87,7 +87,8 @@
>   */
>  #define __pure				__attribute__((pure))
>  #define __aligned(x)			__attribute__((aligned(x)))
> -#define __printf(a,b)			__attribute__((format(printf,a,b)))
> +#define __printf(a, b)			__attribute__((format(printf, a, b)))
> +#define __scanf(a, b)			__attribute__((format(scanf, a, b)))
>  #define  noinline			__attribute__((noinline))
>  #define __attribute_const__		__attribute__((__const__))
>  #define __maybe_unused			__attribute__((unused))
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index e834342..30f21ec 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -315,10 +315,10 @@ extern __printf(2, 3)
>  char *kasprintf(gfp_t gfp, const char *fmt, ...);
>  extern char *kvasprintf(gfp_t gfp, const char *fmt, va_list args);
>  
> -extern int sscanf(const char *, const char *, ...)
> -	__attribute__ ((format (scanf, 2, 3)));
> -extern int vsscanf(const char *, const char *, va_list)
> -	__attribute__ ((format (scanf, 2, 0)));
> +extern __scanf(2, 3)
> +int sscanf(const char *, const char *, ...);
> +extern __scanf(2, 0)
> +int vsscanf(const char *, const char *, va_list);
>  
>  extern int get_option(char **str, int *pint);
>  extern char *get_options(const char *str, int nints, int *ints);
> diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
> index e8c599b..0a7515c 100644
> --- a/include/xen/xenbus.h
> +++ b/include/xen/xenbus.h
> @@ -139,9 +139,9 @@ int xenbus_transaction_start(struct xenbus_transaction *t);
>  int xenbus_transaction_end(struct xenbus_transaction t, int abort);
>  
>  /* Single read and scanf: returns -errno or num scanned if > 0. */
> +__scanf(4, 5)
>  int xenbus_scanf(struct xenbus_transaction t,
> -		 const char *dir, const char *node, const char *fmt, ...)
> -	__attribute__((format(scanf, 4, 5)));
> +		 const char *dir, const char *node, const char *fmt, ...);
>  
>  /* Single printf and write: returns -errno or 0. */
>  __printf(4, 5)
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index e3bfcbe..2b52aeb 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3117,6 +3117,12 @@ sub process {
>  			     "__printf(string-index, first-to-check) is preferred over __attribute__((format(printf, string-index, first-to-check)))\n" . $herecurr);
>  		}
>  
> +# Check for __attribute__ format(scanf, prefer __scanf
> +		if ($line =~ /\b__attribute__\s*\(\s*\(\s*format\s*\(\s*scanf\b/) {
> +			WARN("PREFER_SCANF",
> +			     "__scanf(string-index, first-to-check) is preferred over __attribute__((format(scanf, string-index, first-to-check)))\n" . $herecurr);
> +		}
> +
>  # check for sizeof(&)
>  		if ($line =~ /\bsizeof\s*\(\s*\&/) {
>  			WARN("SIZEOF_ADDRESS",
> -- 
> 1.7.8.111.gad25c.dirty
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com
> http://lists.xensource.com/xen-devel
