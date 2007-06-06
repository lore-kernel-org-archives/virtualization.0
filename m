From: Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: [PATCH] paravirt: helper to disable all IO space
Date: Tue, 05 Jun 2007 18:38:09 -0700
Message-ID: <46661001.5090406@xensource.com>
References: <46660CB2.60409@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46660CB2.60409@xensource.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> In a virtual environment, device drivers such as legacy IDE will waste
> quite a lot of time probing for their devices which will never appear.
> This helper function allows a paravirt implementation to lay claim to
> the whole iomem and ioport space, thereby disabling all device drivers
> trying to claim IO resources.
>
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
>
> diff -r 83c67f9402b5 arch/i386/kernel/paravirt.c
> --- a/arch/i386/kernel/paravirt.c	Tue Jun 05 17:41:04 2007 -0700
> +++ b/arch/i386/kernel/paravirt.c	Tue Jun 05 18:17:29 2007 -0700
> @@ -227,6 +227,39 @@ static int __init print_banner(void)
>  	return 0;
>  }
>  core_initcall(print_banner);
> +
> +static struct resource reserve_ioports = {
> +	.start = 0,
> +	.end = IO_SPACE_LIMIT,
> +	.name = "paravirt-ioport",
> +	.flags = IORESOURCE_IO | IORESOURCE_BUSY,
> +};
> +
> +static struct resource reserve_iomem = {
> +	.start = 0,
> +	.end = -1,
> +	.name = "paravirt-iomem",
> +	.flags = IORESOURCE_MEM | IORESOURCE_BUSY,
> +};
> +
> +/*
> + * Reserve the whole legacy IO space to prevent any legacy drivers
> + * from wasting time probing for their hardware.  This is a fairly
> + * brute-force approach to disabling all non-virtual drivers.
> + * 
> + * Note that this must be called very early to have any effect.
> + */
> +int paravirt_disable_iospace(void)
> +{
> +	int ret = 0;
> +
> +	ret = request_resource(&ioport_resource, &reserve_ioports);
> +	if (ret == 0)
> +		ret = request_resource(&iomem_resource, &reserve_iomem);
> +
> +	return ret;
> +}
> +
>  
>  struct paravirt_ops paravirt_ops = {
>  	.name = "bare hardware",
> diff -r 83c67f9402b5 arch/i386/xen/setup.c
> --- a/arch/i386/xen/setup.c	Tue Jun 05 17:41:04 2007 -0700
> +++ b/arch/i386/xen/setup.c	Tue Jun 05 18:17:29 2007 -0700
>   

Oops.  This was supposed to be in the corresponding Xen patch.

    J
