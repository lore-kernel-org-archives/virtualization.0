From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [TOME] Re: [PATCH] Modpost section mismatch fix
Date: Tue, 5 Jul 2011 07:48:46 -0700 (PDT)
Message-ID: <20110705144846.GA13548__39346.3343535133$1309877403$gmane$org@dumpdata.com>
References: <20110703232508.GB4440@Xye>
	<1309769388.634.51.camel@zakaz.uk.xensource.com>
	<20110704221646.GB4490@Xye>
	<20110705141323.GG2972@dumpdata.com> <20110705142731.GA4463@Xye>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110705142731.GA4463@Xye>
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
Cc: xen-devel@lists.xensource.com, jeremy.fitzhardinge@citrix.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ian Campbell <ijc@hellion.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

> >>xen_register_gsi and hence, xen_register_pirq are called from
> >>init (with xen_setup_acpi_sci) and non-init (with
> >>acpi_register_gsi_xen); since xen_set_acpi_sci calls it with gsi ==
> >>acpi_sci_override_gsi and is marked __init, the best way would be to
> >>call xen_register_gsi and xen_register_pirq with a boolean argument like
> >>sci_override to obviate the need to use acpi_sci_override_gsi in
> >>register_pirq. I will send the patch with this change if it looks good.
> >
> >Hold on, let me rebase #stable/pci.cleanups and see if the issue
> >here disappears.
> Thanks, will wait until the rebase and test after that.

Hm, it actually looks like it wont do the trick. Why don't you send
a patch against 3.0-rc6 with the outlined mechanism mentioned above.
