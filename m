From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] Re: [PATCH] Modpost section mismatch fix
Date: Thu, 7 Jul 2011 12:24:54 -0400
Message-ID: <20110707162454.GA8164__48167.2031376094$1310056114$gmane$org@dumpdata.com>
References: <20110703232508.GB4440@Xye>
	<1309769388.634.51.camel@zakaz.uk.xensource.com>
	<20110704221646.GB4490@Xye> <20110705141323.GG2972@dumpdata.com>
	<20110705142731.GA4463@Xye> <20110705144846.GA13548@dumpdata.com>
	<20110705213243.GA3647@dumpdata.com> <20110707154648.GA4394@Xye>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110707154648.GA4394@Xye>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra D Prabhu <rprabhu@wnohang.net>
Cc: linux-kernel@vger.kernel.org, Ian Campbell <ijc@hellion.org.uk>, xen-devel@lists.xensource.com, jeremy.fitzhardinge@citrix.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> Tested it. Works now.

Ok, Stuck Tested-by on the patch. Hopefully Linus hasn't pulled it yet.

> Reviewed-by: Raghavendra Prabhu <rprabhu@wnohang.net>
> 
> Also,
> The condition for acpi_gsi_to_irq can be removed since it always returns zero.

The function might in the future return something that is non-zero
and we should guard for it. Also you make 'irq' be unsigned which is not
good as the IRQ 0 is a valid value - and with making it unsigned if it is
set to -1 (the -1 is the invalid IRQ value) the check for 'irq != gsi'
will be true and and we will pass in -1 casted to unsigned. That is a
large value and not the right thing we want to pass to xen_register_gsi.


> ============================================
>  diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
>  index f567965..3faa55b 100644
>  --- a/arch/x86/pci/xen.c
>  +++ b/arch/x86/pci/xen.c
>  @@ -405,7 +405,7 @@ static __init void xen_setup_acpi_sci(void)
>          int rc;
>          int trigger, polarity;
>          int gsi = acpi_sci_override_gsi;
>  -       int irq = -1;
>  +       unsigned int irq = 0u;
>          int gsi_override = -1;
> 
>          if (!gsi)
>  @@ -435,11 +435,10 @@ static __init void xen_setup_acpi_sci(void)
>           * setup as we had setup IRQ 20 for it).
>           */
>          /* Check whether the GSI != IRQ */
>  -       if (acpi_gsi_to_irq(gsi, &irq) == 0) {
>  -               if (irq >= 0 && irq != gsi)
>  -                       /* Bugger, we MUST have that IRQ. */
>  -                       gsi_override = irq;
>  -       }
>  +       acpi_gsi_to_irq(gsi, &irq);
>  +       if (irq != gsi)
>  +               /* Bugger, we MUST have that IRQ. */
>  +               gsi_override = irq;
> 
>          gsi = xen_register_gsi(gsi, gsi_override, trigger, polarity);
>          printk(KERN_INFO "xen: acpi sci %d\n", gsi);
> 
> 
> --------------------------
> Raghavendra Prabhu
> GPG Id : 0xD72BE977
> Fingerprint: B93F EBCB 8E05 7039 CD3C A4B8 A616 DCA1 D72B E977
> www: wnohang.net



> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com
> http://lists.xensource.com/xen-devel
