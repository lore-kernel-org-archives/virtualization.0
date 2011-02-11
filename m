From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/3]: Staging: hv: Use native page allocation/free
 functions
Date: Fri, 11 Feb 2011 10:29:49 -0800
Message-ID: <20110211182949.GA10751@suse.de>
References: <1297447140-21777-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1297447140-21777-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 11, 2011 at 09:59:00AM -0800, K. Y. Srinivasan wrote:
> --- a/drivers/staging/hv/hv.c
> +++ b/drivers/staging/hv/hv.c
> @@ -230,7 +230,12 @@ int hv_init(void)
>  	* Allocate the hypercall page memory
>  	* virtaddr = osd_page_alloc(1);
>  	*/
> -	virtaddr = osd_virtual_alloc_exec(PAGE_SIZE);
> +#ifdef __x86_64__
> +	virtaddr = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL_EXEC);
> +#else
> +	virtaddr =  __vmalloc(PAGE_SIZE, GFP_KERNEL,
> +			__pgprot(__PAGE_KERNEL & (~_PAGE_NX)));
> +#endif

I'm not saying this patch is wrong at all, but I still don't understand
why this is different depending on the architecture of the machine.  Why
is this necessary, it should be ok to do the same type of allocation no
matter what the processor is, right?

thanks,

greg k-h
