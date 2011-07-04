From: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: [PATCH] Modpost section mismatch fix
Date: Mon, 04 Jul 2011 09:49:48 +0100
Message-ID: <1309769388.634.51.camel__42287.2087955058$1309769466$gmane$org@zakaz.uk.xensource.com>
References: <20110703232508.GB4440@Xye>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110703232508.GB4440@Xye>
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
Cc: xen-devel@lists.xensource.com, jeremy.fitzhardinge@citrix.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2011-07-04 at 04:55 +0530, Raghavendra D Prabhu wrote:
> [Sorry if duplicate, one earlier was corrupt]
> 
> Hi,
>      I got section mismatches reported by modpost in latest build. It got
>      reported for xen_register_pirq and xen_unplug_emulated_devices
>      functions.


>  xen_register_pirq makes reference to
>      acpi_sci_override_gsi in init.data section; marking
>      xen_register_pirq with __init is not feasible since calls are made
>      to it from acpi_register_gsi in non-init contexts. So marking it
>      __refdata based on assumption that when acpi_sci_override_gsi is
>      referenced, it is in  early stages where it is alive.

I don't think this assumption holds, since xen_register_pirq can be
called at any time and basically unconditionally references
acpi_sci_override_gsi.

If we don't want to remove the __init from acpi_sci_override_gsi then
perhaps xen_setup_acpi_sci needs to stash it somewhere?

Or maybe xen_register_pirq could take an "int force_irq" which, if not
-1, would force a particular IRQ. The callsite in xen_setup_acpi_sci
(actually via xen_register_gsi so the param would need to be propagated
there) would be the only actual user?

The xen_unplug_emulated_devices change looks correct to me since
xen_unplug_emulated_devices is called from xen_arch_hvm_post_suspend.

Ian.

> 
> 
> --------------------------
> Raghavendra Prabhu
> GPG Id : 0xD72BE977
> Fingerprint: B93F EBCB 8E05 7039 CD3C A4B8 A616 DCA1 D72B E977
> www: wnohang.net
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/virtualization

-- 
Ian Campbell
Current Noise: Crowbar - Remember Tomorrow (A Tribute To Iron Maiden)

SANTA CLAUS comes down a FIRE ESCAPE wearing bright blue LEG WARMERS
... He scrubs the POPE with a mild soap or detergent for 15 minutes,
starring JANE FONDA!!
