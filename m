From: Yu Zhao <yu.zhao@intel.com>
Subject: Re: [PATCH 7/16 v6] PCI: cleanup pcibios_allocate_resources()
Date: Thu, 23 Oct 2008 14:50:57 +0800
Message-ID: <20081023065057.GA4340__37374.3876269602$1224748225$gmane$org@yzhao12-linux.sh.intel.com>
References: <20081022083809.GA3757@yzhao12-linux.sh.intel.com>
	<20081022084241.GG3773@yzhao12-linux.sh.intel.com>
	<86802c440810230010redfbbe7oaf94bf2077ccdcdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <86802c440810230010redfbbe7oaf94bf2077ccdcdf@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 23, 2008 at 03:10:26PM +0800, Yinghai Lu wrote:
> On Wed, Oct 22, 2008 at 1:42 AM, Yu Zhao <yu.zhao@intel.com> wrote:
> > diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
> > index 844df0c..8729bde 100644
> > --- a/arch/x86/pci/i386.c
> > +++ b/arch/x86/pci/i386.c
> > @@ -147,7 +147,7 @@ static void __init pcibios_allocate_bus_resources(struct list_head *bus_list)
> >  static void __init pcibios_allocate_resources(int pass)
> >  {
> >        struct pci_dev *dev = NULL;
> > -       int idx, disabled;
> > +       int idx, enabled;
> >        u16 command;
> >        struct resource *r, *pr;
> >
> > @@ -160,22 +160,22 @@ static void __init pcibios_allocate_resources(int pass)
> >                        if (!r->start)          /* Address not assigned at all */
> >                                continue;
> >                        if (r->flags & IORESOURCE_IO)
> > -                               disabled = !(command & PCI_COMMAND_IO);
> > +                               enabled = command & PCI_COMMAND_IO;
> >                        else
> > -                               disabled = !(command & PCI_COMMAND_MEMORY);
> > -                       if (pass == disabled) {
> > -                               dev_dbg(&dev->dev, "resource %#08llx-%#08llx (f=%lx, d=%d, p=%d)\n",
> > +                               enabled = command & PCI_COMMAND_MEMORY;
> > +                       if (pass == enabled)
> > +                               continue;
> 
> it seems you change the flow here for MMIO
> because PCI_COMMAND_MEMORY is 2.
> 
> YH

Nice finding! Will change it back to 'disable' next version.

Thanks,
Yu
