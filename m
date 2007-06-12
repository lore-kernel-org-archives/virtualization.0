From: "Caitlin Bestler" <caitlinb@broadcom.com>
Subject: RE: [kvm-devel] [Xen-devel] More virtio users
Date: Tue, 12 Jun 2007 16:40:05 -0700
Message-ID: <1EF1E44200D82B47BD5BA61171E8CE9D04269608__23499.1761776202$1181691730$gmane$org@NT-IRVA-0750.brcm.ad.broadcom.com>
References: <200706130007.36437.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <200706130007.36437.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>, kvm-devel@lists.sourceforge.net
Cc: xen-devel <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

virtualization-bounces@lists.linux-foundation.org wrote:
> On Sunday 10 June 2007, Avi Kivity wrote:
>>> - PCI (or your favorite HW bus) passthrough, for your favorite
>>> oddball =A0 device (e.g., crypto-accelerators).
>>>=20
>> Won't all high-bandwidth traffic be through dma, bypassing virtio?
>=20
> It can be done, but you'd also need a passthrough for the
> IOMMU in that case, and you get a potential security hole: if
> a malicious guest is smart enough to figure out IOMMU
> mappings from the device to memory owned by the host.
>=20

If it is possible for a malicious guess to use the IOMMU
to access memory that was not assigned to it then either
the Hypervisor is not really a Hypervisor or the IOMMU
is not really an IOMMU.

The only real difference between enabling DMA and providing
IO buffers are the durations. The security implications are
identical.
