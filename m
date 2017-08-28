From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [RFC] virtio-iommu version 0.4
Date: Mon, 28 Aug 2017 07:39:49 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190D941E3@SHSMSX101.ccr.corp.intel.com>
References: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
	<5be484ff-6a1a-6c9b-947c-f64ea23f58cc@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5be484ff-6a1a-6c9b-947c-f64ea23f58cc@arm.com>
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
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker@arm.com]
> Sent: Wednesday, August 23, 2017 6:01 PM
> 
> On 04/08/17 19:19, Jean-Philippe Brucker wrote:
> > Other extensions are in preparation. I won't detail them here because
> v0.4
> > already is a lot to digest, but in short, building on top of PROBE:
> >
> > * First, since the IOMMU is paravirtualized, the device can expose some
> >   properties of the physical topology to the guest, and let it allocate
> >   resources more efficiently. For example, when the virtio-iommu
> manages
> >   both physical and emulated endpoints, with different underlying
> IOMMUs,
> >   we now have a way to describe multiple page and block granularities,
> >   instead of forcing the guest to use the most restricted one for all
> >   endpoints. This will most likely be in v0.5.
> 
> In order to extend requests with PASIDs and (later) nested mode, I intend
> to rename "address_space" field to "domain", since it is a lot more
> precise about what the field is referring to and the current name would
> make these extensions confusing. Please find the rationale at [1].
> "ioasid_bits" will be "domain_bits" and "VIRTIO_IOMMU_F_IOASID_BITS"
> will
> be "VIRTIO_IOMMU_F_DOMAIN_BITS".
> 
> For those that had time to read this version, do you have other comments
> and suggestions about v0.4? Otherwise it is the only update I have for
> v0.5 (along with fine-grained address range and page size properties from
> the quoted text) and I will send it soon.
> 
> In particular, please tell me now if you see the need for other
> destructive changes like this one. They will be impossible to introduce
> once a driver or device is upstream.
> 
> Thanks,
> Jean
> 
> [1] https://www.spinics.net/lists/kvm/msg154573.html

Here comes some comments:

1.1 Motivation

You describe I/O page faults handling as future work. Seems you considered
only recoverable fault (since "aka. PCI PRI" being used). What about other
unrecoverable faults e.g. what to do if a virtual DMA request doesn't find 
a valid mapping? Even when there is no PRI support, we need some basic
form of fault reporting mechanism to indicate such errors to guest.

2.6.8.2 Property RESV_MEM

I'm not immediately clear when VIRTIO_IOMMU_PROBE_RESV_MEM_T_ABORT
should be explicitly reported. Is there any real example on bare metal IOMMU?
usually reserved memory is reported to CPU through other method (e.g. e820
on x86 platform). Of course MSI is a special case which is covered by BYPASS 
and MSI flag... If yes, maybe you can also include an example in implementation 
notes.

Another thing I want to ask your opinion, about whether there is value of
adding another subtype (MEM_T_IDENTITY), asking for identity mapping
in the address space. It's similar to Reserved Memory Region Reporting
(RMRR) structure defined in VT-d, to indicate BIOS allocated reserved
memory ranges which may be DMA target and has to be identity mapped
when DMA remapping is enabled. I'm not sure whether ARM has similar
capability and whether there might be a general usage beyond VT-d. For
now the only usage in my mind is to assign a device with RMRR associated
on VT-d (Intel GPU, or some USB controllers) where the RMRR info needs
propagated to the guest (since identity mapping also means reservation
of virtual address space).

2.6.8.2.3 Device Requirements: Property RESV_MEM

--citation start--
If an endpoint is attached to an address space, the device SHOULD leave 
any access targeting one of its VIRTIO_IOMMU_PROBE_RESV_MEM_T_BYPASS 
regions pass through untranslated. In other words, the device SHOULD 
handle such a region as if it was identity-mapped (virtual address equal to
physical address). If the endpoint is not attached to any address space, 
then the device MAY abort the transaction.
--citation end

I have a question for the last sentence. From definition of BYPASS, it's
orthogonal to whether there is an address space attached, then should
we still allow "May abort" behavior? 

Thanks
Kevin 
