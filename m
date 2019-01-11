From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v6 0/7] Add virtio-iommu driver
Date: Fri, 11 Jan 2019 13:00:30 +0000
Message-ID: <08283b53-2f87-05e7-e71c-8780b34d9018__27603.7183510654$1547693020$gmane$org@arm.com>
References: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
	<20181212103545.GV16835@8bytes.org>
	<9110873f-d344-b6b9-c722-9accfc329db2@arm.com>
	<20190111122846.GE5825@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190111122846.GE5825@8bytes.org>
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

On 11/01/2019 12:28, Joerg Roedel wrote:
> Hi Jean-Philippe,
> 
> On Thu, Dec 13, 2018 at 12:50:29PM +0000, Jean-Philippe Brucker wrote:
>> We already do deferred flush: UNMAP requests are added to the queue by
>> iommu_unmap(), and then flushed out by iotlb_sync(). So we switch to the
>> host only on iotlb_sync(), or when the request queue is full.
> 
> So the mappings can stay in place until iotlb_sync() returns? What
> happens when the guest sends a map-request for a region it sent and
> unmap request before, but did not call iotlb_sync inbetween?

At that point the unmap is still in the request queue, and the host will
handle it before getting to the map request. For correctness requests
are necessarily handled in-order by the host. So if the map and unmap
refer to the same domain and IOVA, the host will remove the old mapping
before creating the new one.

Thanks,
Jean
