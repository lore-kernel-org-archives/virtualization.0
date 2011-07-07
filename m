From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] Re: [PATCH] Modpost section mismatch fix
Date: Thu, 7 Jul 2011 16:09:49 -0400
Message-ID: <20110707200949.GA25216__12499.5162165307$1310069606$gmane$org@dumpdata.com>
References: <20110703232508.GB4440@Xye>
	<1309769388.634.51.camel@zakaz.uk.xensource.com>
	<20110704221646.GB4490@Xye> <20110705141323.GG2972@dumpdata.com>
	<20110705142731.GA4463@Xye> <20110705144846.GA13548@dumpdata.com>
	<20110705213243.GA3647@dumpdata.com> <20110707154648.GA4394@Xye>
	<20110707162454.GA8164@dumpdata.com> <20110707194851.GB4394@Xye>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110707194851.GB4394@Xye>
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

On Fri, Jul 08, 2011 at 01:18:51AM +0530, Raghavendra D Prabhu wrote:
> * On Thu, Jul 07, 2011 at 12:24:54PM -0400, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
> >>Tested it. Works now.
> >
> >Ok, Stuck Tested-by on the patch. Hopefully Linus hasn't pulled it yet.
> Ok.
> >
> >>Reviewed-by: Raghavendra Prabhu <rprabhu@wnohang.net>
> 
> >>Also,
> >>The condition for acpi_gsi_to_irq can be removed since it always returns zero.
> >
> >The function might in the future return something that is non-zero
> >and we should guard for it. Also you make 'irq' be unsigned which is not
> >good as the IRQ 0 is a valid value - and with making it unsigned if it is
> >set to -1 (the -1 is the invalid IRQ value) the check for 'irq != gsi'
> >will be true and and we will pass in -1 casted to unsigned. That is a
> >large value and not the right thing we want to pass to xen_register_gsi.
> 
> My rationale for the unsigned part was that acpi_gsi_to_irq always
> assigns a positive value (>= 0) to the irq passed (as unsigned
> argument). But even otherwise that shouldn't make much of difference I guess.
> 
> Also,
> I had sent another change (oneline) for the file
> arch/x86/xen/platform-pci-unplug.c for check_platform_magic, looks like that has not gone into
> the pull request for Linus.

Oh, I didn't see it. Did you CC me on it? Can you bounce it to me please?
