From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
Date: Thu, 30 Apr 2020 15:34:24 -0400
Message-ID: <20200430152808-mutt-send-email-mst@kernel.org>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
 <20200430101431.GD19932@willie-the-truck>
 <20200430103446.GH5097@quicinc.com>
 <20200430104149.GG19932@willie-the-truck>
 <20200430111156.GI5097@quicinc.com>
 <7bf8bffe-267b-6c66-86c9-40017d3ca4c2@siemens.com>
 <20200430133321.GC3204@quicinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200430133321.GC3204@quicinc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Will Deacon <will@kernel.org>, konrad.wilk@oracle.com, jasowang@redhat.com, stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 30, 2020 at 07:03:21PM +0530, Srivatsa Vaddagiri wrote:
> * Jan Kiszka <jan.kiszka@siemens.com> [2020-04-30 14:59:50]:
> 
> > >I believe ivshmem2_virtio requires hypervisor to support PCI device emulation
> > >(for life-cycle management of VMs), which our hypervisor may not support.

PCI is mostly just 2 registers. One sets the affected device, one the data to read/write.

> A
> > >simple shared memory and doorbell or message-queue based transport will work for
> > >us.
> > 
> > As written in our private conversation, a mapping of the ivshmem2 device
> > discovery to platform mechanism (device tree etc.) and maybe even the
> > register access for doorbell and life-cycle management to something
> > hypercall-like would be imaginable. What would count more from virtio
> > perspective is a common mapping on a shared memory transport.
> 
> Yes that sounds simpler for us.
> 
> > That said, I also warned about all the features that PCI already defined
> > (such as message-based interrupts) which you may have to add when going a
> > different way for the shared memory device.
> 
> Is it really required to present this shared memory as belonging to a PCI
> device?

But then you will go on and add MSI, and NUMA, and security, and and and ...

> I would expect the device-tree to indicate the presence of this shared
> memory region, which we should be able to present to ivshmem2 as shared memory
> region to use (along with some handles for doorbell or message queue use).
> 
> I understand the usefulness of modeling the shared memory as part of device so
> that hypervisor can send events related to peers going down or coming up. In our
> case, there will be other means to discover those events and avoiding this
> requirement on hypervisor (to emulate PCI) will simplify the solution for us.
> 
> Any idea when we can expect virtio over ivshmem2 to become available?!

Check out the virtio spec. Right at the beginning it states:

	These devices are
	found in virtual environments, yet by design they look like physical devices to the guest within
	the virtual machine - and this document treats them as such. This similarity allows the guest to
	use standard drivers and discovery mechanisms


> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
