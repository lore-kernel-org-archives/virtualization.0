From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v6 0/7] Add virtio-iommu driver
Date: Tue, 11 Dec 2018 19:07:41 +0000
Message-ID: <f9cb0ebe-4d9f-50f1-9f61-89d0e55ceddc__33025.6346417174$1544555172$gmane$org@arm.com>
References: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
	<20181211183101.GA31936@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181211183101.GA31936@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: mark.rutland@arm.com, virtio-dev@lists.oasis-open.org, tnowicki@caviumnetworks.com, devicetree@vger.kernel.org, marc.zyngier@arm.com, linux-pci@vger.kernel.org, mst@redhat.com, will.deacon@arm.com, robin.murphy@arm.com, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org, bhelgaas@google.com, kvmarm@lists.cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

On 11/12/2018 18:31, Christoph Hellwig wrote:
> On Tue, Dec 11, 2018 at 06:20:57PM +0000, Jean-Philippe Brucker wrote:
>> Implement the virtio-iommu driver, following specification v0.9 [1].
>>
>> Only minor changes since v5 [2]. I fixed issues reported by Michael and
>> added tags from Eric and Bharat. Thanks!
>>
>> You can find Linux driver and kvmtool device on v0.9 branches [3],
>> module and x86 support on virtio-iommu/devel. Also tested with Eric's
>> QEMU device [4].
> 
> Just curious, what is the use case for it?

The main use case is assigning a device to guest userspace, using VFIO
both in the host and in the guest (the most cited example being DPDK).
There are others, and I wrote a little more about them last week:
https://www.spinics.net/lists/linux-pci/msg78529.html

Thanks,
Jean
