From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v5 0/7] Add virtio-iommu driver
Date: Tue, 27 Nov 2018 19:02:53 +0100
Message-ID: <d3e38d89-46f8-7f82-98cc-5a3b94be26b8__260.190715971653$1543341666$gmane$org@redhat.com>
References: <20181122193801.50510-1-jean-philippe.brucker@arm.com>
	<20181127114402-mutt-send-email-mst@kernel.org>
	<6c061729-c404-ac25-f86f-7fe222bf5bc7@redhat.com>
	<20181127121036-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181127121036-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: mark.rutland@arm.com, virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com, tnowicki@caviumnetworks.com, devicetree@vger.kernel.org, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linux-pci@vger.kernel.org, joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com, virtualization@lists.linux-foundation.org, marc.zyngier@arm.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org, kvmarm@lists.cs.columbia.edu, bhelgaas@google.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael,

On 11/27/18 6:16 PM, Michael S. Tsirkin wrote:
> On Tue, Nov 27, 2018 at 06:09:25PM +0100, Auger Eric wrote:
>> Hi Michael,
>>
>> On 11/27/18 5:53 PM, Michael S. Tsirkin wrote:
>>> On Thu, Nov 22, 2018 at 07:37:54PM +0000, Jean-Philippe Brucker wrote:
>>>> Implement the virtio-iommu driver, following specification v0.9 [1].
>>>>
>>>> Since v4 [2] I fixed the issues reported by Eric, and added Reviewed-by
>>>> from Eric and Rob. Thanks!
>>>>
>>>> I changed the specification to fix one inconsistency discussed in v4.
>>>> That the device fills the probe buffer with zeroes is now a "SHOULD"
>>>> instead of a "MAY", since it's the only way for the driver to know if
>>>> the device wrote the status. Existing devices already do this. In
>>>> addition the device now needs to fill the three padding bytes at the
>>>> tail with zeroes.
>>>>
>>>> You can find Linux driver and kvmtool device on branches
>>>> virtio-iommu/v0.9 [3]. I also lightly tested with Eric's latest QEMU
>>>> device [4].
>>>
>>> I tried to get this to work on my x86 box but without
>>> success. Any hints? Does this have to do with the IORT table?
>>> I think we really should just reserve our own table ID
>>> and avoid the pain of trying to add things to the IORT spec.
>>> I'm reluctant to merge lots of code that I can't easily test.
>>> Again, if we found a way to push more configuration into
>>> virtio config space the problem space would be smaller.
>>
>> You can at least test it with QEMU ARM virt in TCG mode.
> 
> It's slow enough that I generally just focus on KVM.
fair enough
> 
>> Then I have
>> worked on the IORT integration in PC/Q35 but this is not yet functional.
>> I need to debug what's wrong on guest ACPI probing. I plan to work on
>> this this week.
>>
>> Thanks
>>
>> Eric
> 
> Sounds good. Did you need to make changes to IORT?  I don't remember. If
> yes it would be very easy to just have a virtio specific ACPI table -
> I am assuming ARM guys will be just as hostile to virt changes
> to IORT as they were to minor changes to ARM vIOMMU.

Well the only difference is that on ARM we have 3 nodes in the IORT: the
root complex node -> the VIRTIO-IOMMU node -> the ITS node. The ITS is
the ARM MSI controller which does MSI translation. So the ARM IORT
describes the chained ID mappings from the end point RID through the
StreamID SMMU input to the device ID MSI controller input. On Intel we
don't have the last node.

But again my integration is not yet functional and I don't know yet if I
have captured the whole picture.

Thanks

Eric
> 
> 
>>>
>>>> [1] Virtio-iommu specification v0.9, sources, pdf and diff from v0.8
>>>>     git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.9
>>>>     http://jpbrucker.net/virtio-iommu/spec/v0.9/virtio-iommu-v0.9.pdf
>>>>     http://jpbrucker.net/virtio-iommu/spec/diffs/virtio-iommu-pdf-diff-v0.8-v0.9.pdf
>>>>
>>>> [2] [PATCH v4 0/7] Add virtio-iommu driver
>>>>     https://lists.linuxfoundation.org/pipermail/iommu/2018-November/031074.html
>>>>
>>>> [3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.9
>>>>     git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9
>>>>
>>>> [4] [RFC v9 00/17] VIRTIO-IOMMU device
>>>>     https://www.mail-archive.com/qemu-devel@nongnu.org/msg575578.html
>>>>
>>>> Jean-Philippe Brucker (7):
>>>>   dt-bindings: virtio-mmio: Add IOMMU description
>>>>   dt-bindings: virtio: Add virtio-pci-iommu node
>>>>   of: Allow the iommu-map property to omit untranslated devices
>>>>   PCI: OF: Initialize dev->fwnode appropriately
>>>>   iommu: Add virtio-iommu driver
>>>>   iommu/virtio: Add probe request
>>>>   iommu/virtio: Add event queue
>>>>
>>>>  .../devicetree/bindings/virtio/iommu.txt      |   66 +
>>>>  .../devicetree/bindings/virtio/mmio.txt       |   30 +
>>>>  MAINTAINERS                                   |    7 +
>>>>  drivers/iommu/Kconfig                         |   11 +
>>>>  drivers/iommu/Makefile                        |    1 +
>>>>  drivers/iommu/virtio-iommu.c                  | 1157 +++++++++++++++++
>>>>  drivers/of/base.c                             |   10 +-
>>>>  drivers/pci/of.c                              |    7 +
>>>>  include/uapi/linux/virtio_ids.h               |    1 +
>>>>  include/uapi/linux/virtio_iommu.h             |  161 +++
>>>>  10 files changed, 1448 insertions(+), 3 deletions(-)
>>>>  create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
>>>>  create mode 100644 drivers/iommu/virtio-iommu.c
>>>>  create mode 100644 include/uapi/linux/virtio_iommu.h
>>>>
>>>> -- 
>>>> 2.19.1
