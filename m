From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [kvm-devel] [Xen-devel] More virtio users
Date: Wed, 13 Jun 2007 00:07:35 +0200
Message-ID: <200706130007.36437.arnd@arndb.de>
References: <466BA965.6050208@qumranet.com>
	<20070610080602.GD3738@rhun.haifa.ibm.com>
	<466BB1AF.1000601@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <466BB1AF.1000601@qumranet.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel@lists.sourceforge.net
Cc: xen-devel <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sunday 10 June 2007, Avi Kivity wrote:
> > - PCI (or your favorite HW bus) passthrough, for your favorite oddbal=
l
> > =A0 device (e.g., crypto-accelerators).
> > =A0=20
> Won't all high-bandwidth traffic be through dma, bypassing virtio?

It can be done, but you'd also need a passthrough for the IOMMU
in that case, and you get a potential security hole: if a malicious
guest is smart enough to figure out IOMMU mappings from the device
to memory owned by the host.

	Arnd <><
