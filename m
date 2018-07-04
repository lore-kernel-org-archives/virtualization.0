From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 0/5] Add virtio-iommu driver
Date: Wed, 4 Jul 2018 12:25:26 +0100
Message-ID: <98512e15-fd51-e4b2-1d9d-2c9cf9c863b8__9768.53131219304$1530703439$gmane$org@arm.com>
References: <20180621190655.56391-1-jean-philippe.brucker@arm.com>
	<20180626210132-mutt-send-email-mst@kernel.org>
	<2bcda195-d2c6-fbf0-322e-d91756fc3547@arm.com>
	<20180627224801-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180627224801-mutt-send-email-mst@kernel.org>
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, peter.maydell@linaro.org, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, Will Deacon <Will.Deacon@arm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jayachandran.nair@cavium.com" <jayachandran.nair@cavium.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "joro@8bytes.org" <joro@8bytes.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Robin Murphy <Robin.Murphy@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 27/06/18 20:59, Michael S. Tsirkin wrote:
>> Another reason to keep the MMIO transport option is that one
>> virtio-iommu can manage DMA from endpoints on multiple PCI domains at
>> the same time, as well as platform devices. Some VMMs might want that,
>> in which case the IOMMU would be a separate platform device.
> 
> Which buses are managed by the IOMMU is separate from the bus
> on which it's programming interface resides.

Sorry I didn't get this. We probably don't want to instantiate a PCI
root complex just for the IOMMU, so it needs to be in the same PCI
segment as managed endpoints. For example in my VM the AMD IOMMU is
presented as 00:02.0, between other devices on PCI bus 00.

In any case, I have a solution for virtio-pci that works with DT and
ACPI, and isn't excessively awful. I'll probably send it as part of the
next version.

Thanks,
Jean
