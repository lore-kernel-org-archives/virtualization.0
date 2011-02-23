From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/6] Staging: hv: hv.c Removed all DPRINT and debug -
 using pr_err now
Date: Wed, 23 Feb 2011 11:15:33 -0800
Message-ID: <20110223191533.GB1030@kroah.com>
References: <1298417565-12356-1-git-send-email-hjanssen@microsoft.com>
 <1298417565-12356-2-git-send-email-hjanssen@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1298417565-12356-2-git-send-email-hjanssen@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: haiyangz@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 22, 2011 at 03:32:41PM -0800, Hank Janssen wrote:
> This group of patches removes all DPRINT from hv_vmbus.ko.
> It is divided in several patches due to size.
> 
> All DPRINT calls have been removed, and where needed have been
> replaced with pr_XX native calls. Many debug DPRINT calls have
> been removed outright.
> 
> The amount of clutter this driver prints has been
> significantly reduced.
> 
> Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> 
> ---
>  drivers/staging/hv/hv.c |   88 +++++++++++-----------------------------------
>  1 files changed, 21 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/staging/hv/hv.c b/drivers/staging/hv/hv.c
> index 2d492ad..e3ce26d 100644
> --- a/drivers/staging/hv/hv.c
> +++ b/drivers/staging/hv/hv.c
> @@ -80,20 +80,6 @@ static int query_hypervisor_info(void)
>  	op = HVCPUID_VENDOR_MAXFUNCTION;
>  	cpuid(op, &eax, &ebx, &ecx, &edx);
>  
> -	DPRINT_INFO(VMBUS, "Vendor ID: %c%c%c%c%c%c%c%c%c%c%c%c",
> -		    (ebx & 0xFF),
> -		    ((ebx >> 8) & 0xFF),
> -		    ((ebx >> 16) & 0xFF),
> -		    ((ebx >> 24) & 0xFF),
> -		    (ecx & 0xFF),
> -		    ((ecx >> 8) & 0xFF),
> -		    ((ecx >> 16) & 0xFF),
> -		    ((ecx >> 24) & 0xFF),
> -		    (edx & 0xFF),
> -		    ((edx >> 8) & 0xFF),
> -		    ((edx >> 16) & 0xFF),
> -		    ((edx >> 24) & 0xFF));
> -
>  	max_leaf = eax;
>  	eax = 0;
>  	ebx = 0;
> @@ -102,12 +88,6 @@ static int query_hypervisor_info(void)
>  	op = HVCPUID_INTERFACE;
>  	cpuid(op, &eax, &ebx, &ecx, &edx);
>  
> -	DPRINT_INFO(VMBUS, "Interface ID: %c%c%c%c",
> -		    (eax & 0xFF),
> -		    ((eax >> 8) & 0xFF),
> -		    ((eax >> 16) & 0xFF),
> -		    ((eax >> 24) & 0xFF));
> -
>  	if (max_leaf >= HVCPUID_VERSION) {
>  		eax = 0;
>  		ebx = 0;
> @@ -115,14 +95,17 @@ static int query_hypervisor_info(void)
>  		edx = 0;
>  		op = HVCPUID_VERSION;
>  		cpuid(op, &eax, &ebx, &ecx, &edx);
> -		DPRINT_INFO(VMBUS, "OS Build:%d-%d.%d-%d-%d.%d",\
> -			    eax,
> -			    ebx >> 16,
> -			    ebx & 0xFFFF,
> -			    ecx,
> -			    edx >> 24,
> -			    edx & 0xFFFFFF);
> +
> +		pr_info("%s: Hyper-V Host OS Build:%d-%d.%d-%d-%d.%d",
> +			VMBUS_MOD,
> +			eax,
> +			ebx >> 16,
> +			ebx & 0xFFFF,
> +			ecx,
> +			edx >> 24,
> +			edx & 0xFFFFFF);

Why did you keep this one?  Why is it needed?

>  	if (!query_hypervisor_presence()) {
> -		DPRINT_ERR(VMBUS, "No Windows hypervisor detected!!");
> +		pr_err("%s: %s No Hyper-V detected", VMBUS_MOD, __func__);

Why the __func__?  That should never be needed as it is trivial to see
what is happening, the user doesn't need to know the function name,
right?

Please remove them from all of these calls.

Oh, and you obviously didn't test these patches as your syslog would be
a mess if you did.  Which is NOT ok, and makes me grumpy:
	http://www.kroah.com/log/linux/maintainer-05.html

bah, I should just make a numbered list and just start saying: "This
patch fails point #4" or something like that, it would save me in
typing...

Please redo this entire series...

greg k-h
