From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: A clocksource driver for HyperV
Date: Mon, 05 Apr 2010 14:36:59 -0700
Message-ID: <4BBA57FB.2000406@goop.org>
References: <4BB9F408020000300008287C@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4BB9F408020000300008287C@sinclair.provo.novell.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ky Srinivasan <ksrinivasan@novell.com>
Cc: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On 04/05/2010 01:30 PM, Ky Srinivasan wrote:
> +static cycle_t read_hv_clock(struct clocksource *arg)
> +{
> +	cycle_t current_tick;
> +	/*
> +	 * Read the partition counter to get the current tick count. This count
> +	 * is set to 0 when the partition is created and is incremented in
> +	 * 100 nanosecond units.
> +	 */
> +	rdmsrl(HV_X64_MSR_TIME_REF_COUNT, current_tick);
> +	return current_tick;
> +}
> +
> +static struct clocksource clocksource_hyperv = {
> +	.name           = "hyperv_clocksource",
>    

Seems like a redundantly long name; any use of this string is going to 
be in a context where it is obviously a clocksource.  How about just 
"hyperv"?

> +	.rating         = 400, /* use this when running on Hyperv*/
> +	.read           = read_hv_clock,
> +	.mask           = CLOCKSOURCE_MASK(64),
> +	.shift          = HV_CLOCK_SHIFT,
> +};
> +
> +static struct dmi_system_id __initconst
> +hv_timesource_dmi_table[] __maybe_unused  = {
> +	{
> +		.ident = "Hyper-V",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Virtual Machine"),
> +			DMI_MATCH(DMI_BOARD_NAME, "Virtual Machine"),
> +		},
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(dmi, hv_timesource_dmi_table);
>    

So you use the DMI signatures to determine whether the module is needed, 
but cpuid to work out if the feature is present?

> +
> +static struct pci_device_id __initconst
> +hv_timesource_pci_table[] __maybe_unused = {
> +	{ PCI_DEVICE(0x1414, 0x5353) }, /* VGA compatible controller */
> +	{ 0 }
> +};
> +MODULE_DEVICE_TABLE(pci, hv_timesource_pci_table);
>    

And/or PCI?

Seems a bit... ad-hoc?  Is this the official way to determine the 
presence of Hyper-V?

> +
> +
> +static int __init hv_detect_hyperv(void)
>    

This looks generally useful.  Should it be hidden away in the 
clocksource driver, or in some common hyper-v code?  Do other hyper-v 
drivers have versions of this?

> +{
> +	u32 eax, ebx, ecx, edx;
> +	static char hyp_signature[20];
>    
20?  static?

> +
> +	cpuid(1,&eax,&ebx,&ecx,&edx);
> +	if (!(ecx&  HV_HYPERVISOR_PRESENT_BIT)) {
> +		printk(KERN_WARNING
> +			"Not on a Hypervisor\n");
>    
This just looks like noise, especially since it doesn't identify what is 
generating the message.  And if you compile this code in as =y 
(non-modular) then it will complain every boot.

> +		return 1;
> +	}
> +	cpuid(HV_CPUID_SIGNATURE,&eax,&ebx,&ecx,&edx);
> +	*(u32 *)(hyp_signature + 0) = ebx;
> +	*(u32 *)(hyp_signature + 4) = ecx;
> +	*(u32 *)(hyp_signature + 8) = edx;
> +	hyp_signature[12] = 0;
> +
> +	if ((eax<  HV_CPUID_MIN) || (strcmp("Microsoft Hv", hyp_signature))) {
>    

memcmp, surely?

> +		printk(KERN_WARNING
> +			"Not on HyperV; signature %s, eax %x\n",
> +			hyp_signature, eax);
> +		return 1;
> +	}
> +	/*
> +	 * Extract the features, recommendations etc.
> +	 */
> +	cpuid(HV_CPUID_FEATURES,&eax,&ebx,&ecx,&edx);
> +	if (!(eax&  0x10)) {
> +		printk(KERN_WARNING "HyperV Time Ref Counter not available!\n");
> +		return 1;
> +	}
> +
> +	cpuid(HV_CPUID_RECOMMENDATIONS,&eax,&ebx,&ecx,&edx);
> +	printk(KERN_INFO "HyperV recommendations: %x\n", eax);
> +	printk(KERN_INFO "HyperV spin count: %x\n", ebx);
> +	return 0;
> +}
> +
> +
> +static int __init init_hv_clocksource(void)
> +{
> +	if (hv_detect_hyperv())
> +		return -ENODEV;
> +	/*
> +	 * The time ref counter in HyperV is in 100ns units.
> +	 * The definition of mult is:
> +	 * mult/2^shift = ns/cyc = 100
> +	 * mult = (100<<  shift)
> +	 */
> +	clocksource_hyperv.mult = (100<<  HV_CLOCK_SHIFT);
>    

Why not initialize this in the structure?  It's just 100<<22 isn't it?

> +	printk(KERN_INFO "Registering HyperV clock source\n");
> +	return clocksource_register(&clocksource_hyperv);
> +}
> +
> +module_init(init_hv_clocksource);
> +MODULE_DESCRIPTION("HyperV based clocksource");
> +MODULE_AUTHOR("K. Y. Srinivasan<ksrinivasan@novell.com>");
> +MODULE_LICENSE("GPL");
> Index: linux/drivers/staging/hv/Makefile
> ===================================================================
> --- linux.orig/drivers/staging/hv/Makefile	2010-04-05 13:02:06.000000000 -0600
> +++ linux/drivers/staging/hv/Makefile	2010-04-05 13:02:13.000000000 -0600
> @@ -1,4 +1,4 @@
> -obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
> +obj-$(CONFIG_HYPERV)		+= hv_vmbus.o hv_timesource.o
>   obj-$(CONFIG_HYPERV_STORAGE)	+= hv_storvsc.o
>   obj-$(CONFIG_HYPERV_BLOCK)	+= hv_blkvsc.o
>   obj-$(CONFIG_HYPERV_NET)	+= hv_netvsc.o
>    
