From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [virtio-dev] Re: [PATCH v8 2/7] dt-bindings: virtio: Add
	virtio-pci-iommu node
Date: Fri, 31 May 2019 12:13:47 +0100
Message-ID: <c3cd5dba-123d-e808-98b1-731ac2d4b950__35594.2993819312$1559301302$gmane$org@arm.com>
References: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
	<20190530170929.19366-3-jean-philippe.brucker@arm.com>
	<20190530133523-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190530133523-mutt-send-email-mst@kernel.org>
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "joro@8bytes.org" <joro@8bytes.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "bhelgaas@google.com" <bhelgaas@google.com>, Robin Murphy <Robin.Murphy@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 30/05/2019 18:45, Michael S. Tsirkin wrote:
> On Thu, May 30, 2019 at 06:09:24PM +0100, Jean-Philippe Brucker wrote:
>> Some systems implement virtio-iommu as a PCI endpoint. The operating
>> system needs to discover the relationship between IOMMU and masters long
>> before the PCI endpoint gets probed. Add a PCI child node to describe the
>> virtio-iommu device.
>>
>> The virtio-pci-iommu is conceptually split between a PCI programming
>> interface and a translation component on the parent bus. The latter
>> doesn't have a node in the device tree. The virtio-pci-iommu node
>> describes both, by linking the PCI endpoint to "iommus" property of DMA
>> master nodes and to "iommu-map" properties of bus nodes.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> So this is just an example right?
> We are not defining any new properties or anything like that.

Yes it's just an example. The properties already exist but it's good to
describe how to put them together for this particular case, because
there isn't a precedent describing the topology for an IOMMU that
appears on the PCI bus.

> I think down the road for non dt platforms we want to put this
> info in the config space of the device. I do not think ACPI
> is the best option for this since not all systems have it.
> But that can wait.

There is the probe order problem - PCI needs this info before starting
to probe devices on the bus. Maybe we could store the info in a separate
memory region, that is referenced on the command-line and that the guest
can read early.

Thanks,
Jean
