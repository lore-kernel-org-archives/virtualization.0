From: Bharat Bhushan <bharat.bhushan@nxp.com>
Subject: RE: [PATCH v5 0/7] Add virtio-iommu driver
Date: Tue, 27 Nov 2018 07:09:55 +0000
Message-ID: <VI1PR04MB4845EF310EAB55ACABB71E389AD00__2048.96597792885$1543302550$gmane$org@VI1PR04MB4845.eurprd04.prod.outlook.com>
References: <20181122193801.50510-1-jean-philippe.brucker@arm.com>
	<250a38a9-e6b1-35ae-9261-eb8aab123f43@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <250a38a9-e6b1-35ae-9261-eb8aab123f43@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Auger Eric <eric.auger@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "joro@8bytes.org" <joro@8bytes.org>, "mst@redhat.com" <mst@redhat.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
List-Id: virtualization@lists.linuxfoundation.org

Hi Jean,

> -----Original Message-----
> From: Auger Eric <eric.auger@redhat.com>
> Sent: Friday, November 23, 2018 1:59 PM
> To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>;
> iommu@lists.linux-foundation.org; linux-pci@vger.kernel.org;
> devicetree@vger.kernel.org; virtualization@lists.linux-foundation.org; virtio-
> dev@lists.oasis-open.org; joro@8bytes.org; mst@redhat.com
> Cc: jasowang@redhat.com; robh+dt@kernel.org; mark.rutland@arm.com;
> bhelgaas@google.com; frowand.list@gmail.com;
> kvmarm@lists.cs.columbia.edu; tnowicki@caviumnetworks.com;
> kevin.tian@intel.com; marc.zyngier@arm.com; robin.murphy@arm.com;
> will.deacon@arm.com; lorenzo.pieralisi@arm.com; Bharat Bhushan
> <bharat.bhushan@nxp.com>
> Subject: Re: [PATCH v5 0/7] Add virtio-iommu driver
> 
> Hi Jean,
> 
> On 11/22/18 8:37 PM, Jean-Philippe Brucker wrote:
> > Implement the virtio-iommu driver, following specification v0.9 [1].
> >
> > Since v4 [2] I fixed the issues reported by Eric, and added
> > Reviewed-by from Eric and Rob. Thanks!
> >
> > I changed the specification to fix one inconsistency discussed in v4.
> > That the device fills the probe buffer with zeroes is now a "SHOULD"
> > instead of a "MAY", since it's the only way for the driver to know if
> > the device wrote the status. Existing devices already do this. In
> > addition the device now needs to fill the three padding bytes at the
> > tail with zeroes.
> >
> > You can find Linux driver and kvmtool device on branches
> > virtio-iommu/v0.9 [3]. I also lightly tested with Eric's latest QEMU
> > device [4].
> >
> > [1] Virtio-iommu specification v0.9, sources, pdf and diff from v0.8
> >     git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.9
> >
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fjpbr
> ucker.net%2Fvirtio-iommu%2Fspec%2Fv0.9%2Fvirtio-iommu-
> v0.9.pdf&amp;data=02%7C01%7Cbharat.bhushan%40nxp.com%7C6e7180e7
> df8e41943d4108d6511db8ed%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C1%7C636785585424990803&amp;sdata=la0tSTLcOI5HkQ65a%2BCHKeI3H5iu
> qZ%2F8r6Q5YF8tfsU%3D&amp;reserved=0
> >
> >
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fjpbr
> > ucker.net%2Fvirtio-iommu%2Fspec%2Fdiffs%2Fvirtio-iommu-pdf-diff-v0.8-
> v
> >
> 0.9.pdf&amp;data=02%7C01%7Cbharat.bhushan%40nxp.com%7C6e7180e7d
> f8e4194
> >
> 3d4108d6511db8ed%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C6
> 3678558
> >
> 5424990803&amp;sdata=AEXEib4lihcpfE6O6wLf%2BMElPtA7ZLGYE2mj0288PZ
> k%3D&
> > amp;reserved=0
> >
> > [2] [PATCH v4 0/7] Add virtio-iommu driver
> >
> >
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis
> > ts.linuxfoundation.org%2Fpipermail%2Fiommu%2F2018-
> November%2F031074.ht
> >
> ml&amp;data=02%7C01%7Cbharat.bhushan%40nxp.com%7C6e7180e7df8e4
> 1943d410
> >
> 8d6511db8ed%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C636785
> 5854249
> >
> 90803&amp;sdata=mUUSBQ%2FjEeRGaisGBK20G9WmfXPwlERKDaeeRqHW4
> 08%3D&amp;r
> > eserved=0
> >
> > [3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.9
> >     git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9
> >
> > [4] [RFC v9 00/17] VIRTIO-IOMMU device
> >
> >
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fw
> ww
> > .mail-archive.com%2Fqemu-
> devel%40nongnu.org%2Fmsg575578.html&amp;data=
> >
> 02%7C01%7Cbharat.bhushan%40nxp.com%7C6e7180e7df8e41943d4108d651
> 1db8ed%
> >
> 7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C636785585424990803&
> amp;sd
> >
> ata=fo9WKE33Nm%2FdW2C2XcSVmv9itWjEyRN1irgEZgOWtZI%3D&amp;rese
> rved=0
> >
> > Jean-Philippe Brucker (7):
> >   dt-bindings: virtio-mmio: Add IOMMU description
> >   dt-bindings: virtio: Add virtio-pci-iommu node
> >   of: Allow the iommu-map property to omit untranslated devices
> >   PCI: OF: Initialize dev->fwnode appropriately
> >   iommu: Add virtio-iommu driver
> >   iommu/virtio: Add probe request
> >   iommu/virtio: Add event queue
> >
> >  .../devicetree/bindings/virtio/iommu.txt      |   66 +
> >  .../devicetree/bindings/virtio/mmio.txt       |   30 +
> >  MAINTAINERS                                   |    7 +
> >  drivers/iommu/Kconfig                         |   11 +
> >  drivers/iommu/Makefile                        |    1 +
> >  drivers/iommu/virtio-iommu.c                  | 1157 +++++++++++++++++
> >  drivers/of/base.c                             |   10 +-
> >  drivers/pci/of.c                              |    7 +
> >  include/uapi/linux/virtio_ids.h               |    1 +
> >  include/uapi/linux/virtio_iommu.h             |  161 +++
> >  10 files changed, 1448 insertions(+), 3 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/virtio/iommu.txt
> >  create mode 100644 drivers/iommu/virtio-iommu.c  create mode 100644
> > include/uapi/linux/virtio_iommu.h
> >
> for the whole series
> Tested-by: Eric Auger <eric.auger@redhat.com>

I have tested this series with virtio/vfio both
Tested-by: Bharat Bhushan <bharat.bhushan@nxp.com>


Thanks
-Bharat

> 
> Thanks
> 
> Eric
