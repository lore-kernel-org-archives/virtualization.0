From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: A clocksource driver for HyperV
Date: Wed, 07 Apr 2010 12:40:03 -0700
Message-ID: <4BBCDF93.9010305@goop.org>
References: <4BBC67980200003000082A15@sinclair.provo.novell.com>
	<4BBC789A0200003000082A41@sinclair.provo.novell.com>
	<4BBC789A0200003000082A41@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4BBC789A0200003000082A41@sinclair.provo.novell.com>
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
Cc: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org, haiyangz@microsoft.com, gregkh@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On 04/07/2010 11:20 AM, Ky Srinivasan wrote:
> Jeremy, thank you for your comments. I am attaching the next version of this patch that addresses the comments I have gotten thus far.
>    

It looks like you overlooked a couple of comments.

> +}
> +
> +static struct clocksource hyperv_cs = {
> +	.name           = "hyperv_clocksource",
> +	.rating         = 400, /* use this when running on Hyperv*/
> +	.read           = read_hv_clock,
>    
Did you not want to call it "hyperv" for some reason?

> +static int __init hv_detect_hyperv(void)
> +{
> +	u32 eax, ebx, ecx, edx;
> +	char hyp_signature[20];
>    
Why 20?  You're only putting 12 bytes into it.

> +
> +	cpuid(1,&eax,&ebx,&ecx,&edx);
> +
> +	if (!(ecx&  HV_HYPERVISOR_PRESENT_BIT))
> +		return 1;
> +
> +	cpuid(HV_CPUID_SIGNATURE,&eax,&ebx,&ecx,&edx);
> +	*(u32 *)(hyp_signature + 0) = ebx;
> +	*(u32 *)(hyp_signature + 4) = ecx;
> +	*(u32 *)(hyp_signature + 8) = edx;
> +
> +	if ((eax<  HV_CPUID_MIN) ||
> +	    (memcmp("Microsoft Hv", hyp_signature, 12))) {
> +		printk(KERN_WARNING
> +			"Not on HyperV; signature %s, eax %x\n",
> +			hyp_signature, eax);
>    

The message is pointless.  There's nothing to error or warn about 
booting under some other
hypervisor.

Thanks,
     J
