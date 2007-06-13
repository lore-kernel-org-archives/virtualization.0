From: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [kvm-devel] [Xen-devel] More virtio users
Date: Wed, 13 Jun 2007 08:28:04 +0300
Message-ID: <20070613052803.GA3635__12311.8314230398$1181712591$gmane$org@rhun.haifa.ibm.com>
References: <1EF1E44200D82B47BD5BA61171E8CE9D04269608@NT-IRVA-0750.brcm.ad.broadcom.com>
	<200706130154.27513.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200706130154.27513.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: kvm-devel@lists.sourceforge.net, xen-devel <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 13, 2007 at 01:54:26AM +0200, Arnd Bergmann wrote:
> On Wednesday 13 June 2007, Caitlin Bestler wrote:
> > 
> > > It can be done, but you'd also need a passthrough for the
> > > IOMMU in that case, and you get a potential security hole: if
> > > a malicious guest is smart enough to figure out IOMMU
> > > mappings from the device to memory owned by the host.
> > > 
> > If it is possible for a malicious guess to use the IOMMU
> > to access memory that was not assigned to it then either
> > the Hypervisor is not really a Hypervisor or the IOMMU
> > is not really an IOMMU.
> 
> Unfortunately, most IOMMU implementations are not really IOMMUs
> then, I guess ;-).

Nowdays when people say 'IOMMU', they really mean 'isolation-capable
IOMMU', i.e., one that provides more than a single address space. In
that sense, most IOMMU implementations really aren't (isolation
capable) IOMMUs.

> To be safe, every PCI device needs to have its own tagged DMA
> transfers, which essentially boils down to having each device behind
> a separate PCI host bridge, and that's not very likely to be done on
> PC style hardware.

IBM, Intel and AMD all have x86 IOMMUs that provide some degree of
isolation between different devices (per bus or per device function),
where different BDF's have different IO translation tabels.

> Admittedly, I haven't seen many IOMMU implementations, but the one
> I'm most familiar with (the one on the Cell Broadband Engine) can
> only assign a local device on the north bridge to one guest in a
> secure way, but an entire PCI or PCIe host is treated as a single
> device when seen from the IOMMU, so when one PCIe device has a
> mapping to guest A, guest B can use MMIO access to program another
> device on the same host to do DMA into the buffer provided by guest
> A.

That's not an isolation capable IOMMU then.

Cheers,
Muli
