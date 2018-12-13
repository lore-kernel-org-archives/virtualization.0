From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v6 0/7] Add virtio-iommu driver
Date: Thu, 13 Dec 2018 12:50:29 +0000
Message-ID: <9110873f-d344-b6b9-c722-9accfc329db2__22006.6243819476$1544705347$gmane$org@arm.com>
References: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
	<20181212103545.GV16835@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181212103545.GV16835@8bytes.org>
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
To: Joerg Roedel <joro@8bytes.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "mst@redhat.com" <mst@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Joerg,

On 12/12/2018 10:35, Joerg Roedel wrote:
> Hi,
> =

> to make progress on this, we should first agree on the protocol used
> between guest and host. I have a few points to discuss on the protocol
> first.
> =

> On Tue, Dec 11, 2018 at 06:20:57PM +0000, Jean-Philippe Brucker wrote:
>> [1] Virtio-iommu specification v0.9, sources and pdf
>>=A0=A0=A0=A0 git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.9
>>=A0=A0=A0=A0 http://jpbrucker.net/virtio-iommu/spec/v0.9/virtio-iommu-v0.=
9.pdf
> =

> Looking at this I wonder why it doesn't make the IOTLB visible to the
> guest. the UNMAP requests seem to require that the TLB is already
> flushed to make the unmap visible.
> =

> I think that will cost significant performance for both, vfio and
> dma-iommu use-cases which both do (vfio at least to some degree),
> deferred flushing.

We already do deferred flush: UNMAP requests are added to the queue by
iommu_unmap(), and then flushed out by iotlb_sync(). So we switch to the
host only on iotlb_sync(), or when the request queue is full.

> I also wonder whether the protocol should implement a
> protocol version handshake and iommu-feature set queries.

With the virtio transport there is a handshake when the device (IOMMU)
is initialized, through feature bits and global config fields. Feature
bits are made of both transport-specific features, including the version
number, and device-specific features defined in section 2.3 of the above
document (the transport is described in the virtio 1.0 specification).
The device presents features that it supports in a register, and the
driver masks out the feature bits that it doesn't support. Then the
driver sets the global status to FEATURES_OK and initialization continues.

In addition virtio-iommu has per-endpoint features through the PROBE
request, since the vIOMMU may manage hardware (VFIO) and software
(virtio) endpoints at the same time, which don't have the same DMA
capabilities (different IOVA ranges, page granularity, reserved ranges,
pgtable sharing, etc). At the moment this is a one-way probe, not a
handshake. The device simply fills the properties of each endpoint, but
the driver doesn't have to ack them. Initially there was a way to
negotiate each PROBE property but it was deemed unnecessary during
review. By leaving a few spare bits in the property headers I made sure
it can be added back with a feature bit if we ever need it.

>> [3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.9.1
>>=A0=A0=A0=A0 git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9
> =

> Unfortunatly gitweb seems to be broken on linux-arm.org. What is missing
> in this patch-set to make this work on x86?

You should be able to access it here:
http://www.linux-arm.org/git?p=3Dlinux-jpb.git;a=3Dshortlog;h=3Drefs/heads/=
virtio-iommu/devel

That branch contains missing bits for x86 support:

* ACPI support. We have the code but it's waiting for an IORT spec
update, to reserve the IORT node ID. I expect it to take a while, given
that I'm alone requesting a change for something that's not upstream or
in hardware.

* DMA ops for x86 (see "HACK" commit). I'd like to use dma-iommu but I'm
not sure how to implement the glue that sets dma_ops properly.

Thanks,
Jean
