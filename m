From: "Caitlin Bestler" <caitlinb@broadcom.com>
Subject: RE: [kvm-devel] [Xen-devel] More virtio users
Date: Thu, 14 Jun 2007 12:41:43 -0700
Message-ID: <1EF1E44200D82B47BD5BA61171E8CE9D04269D6E__29142.1282141984$1181850232$gmane$org@NT-IRVA-0750.brcm.ad.broadcom.com>
References: <200706130154.27513.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
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

xen-devel-bounces@lists.xensource.com wrote:
> On Wednesday 13 June 2007, Caitlin Bestler wrote:
>> 
>>> It can be done, but you'd also need a passthrough for the IOMMU in
>>> that case, and you get a potential security hole: if a malicious
>>> guest is smart enough to figure out IOMMU mappings from the device
>>> to memory owned by the host. 
>>> 
>> If it is possible for a malicious guess to use the IOMMU to access
>> memory that was not assigned to it then either the Hypervisor is not
>> really a Hypervisor or the IOMMU is not really an IOMMU.
> 
> Unfortunately, most IOMMU implementations are not really
> IOMMUs then, I guess ;-). To be safe, every PCI device needs
> to have its own tagged DMA transfers, which essentially boils
> down to having each device behind a separate PCI host bridge,
> and that's not very likely to be done on PC style hardware.
> 
> Admittedly, I haven't seen many IOMMU implementations, but
> the one I'm most familiar with (the one on the Cell Broadband
> Engine) can only assign a local device on the north bridge to
> one guest in a secure way, but an entire PCI or PCIe host is
> treated as a single device when seen from the IOMMU, so when
> one PCIe device has a mapping to guest A, guest B can use
> MMIO access to program another device on the same host to do
> DMA into the buffer provided by guest A.
> 
Why not simply adopt the policy that if the IOMMU does not meet
the security requirements of the Hypervisor then it is not an
IOMMU as far as the Hypervisor is concerned?

More specificially, the Hypervisor should enable direct access
by a Guest to a device *only* if an IOMMU functionality exists
to allow the Hypervisor to create a virtual IO memory map that
controls *precisiley* which pages the device is allowed to
access for that guest.

If such functionality is not available then the Guest MUST NOT
access the device directly, and a frontend/backend solution 
must be used instead.

Basically, there are no security problems using an IOMMU, because
if there is a security problem it is not an IOMMU.
