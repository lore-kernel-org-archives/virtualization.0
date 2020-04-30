From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
Date: Thu, 30 Apr 2020 16:41:56 +0530
Message-ID: <20200430111156.GI5097@quicinc.com>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
 <20200430101431.GD19932@willie-the-truck>
 <20200430103446.GH5097@quicinc.com>
 <20200430104149.GG19932@willie-the-truck>
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200430104149.GG19932@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com, jan.kiszka@siemens.com, stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

* Will Deacon <will@kernel.org> [2020-04-30 11:41:50]:

> On Thu, Apr 30, 2020 at 04:04:46PM +0530, Srivatsa Vaddagiri wrote:
> > If CONFIG_VIRTIO_MMIO_OPS is defined, then I expect this to be unconditionally
> > set to 'magic_qcom_ops' that uses hypervisor-supported interface for IO (for
> > example: message_queue_send() and message_queue_recevie() hypercalls).
> 
> Hmm, but then how would such a kernel work as a guest under all the
> spec-compliant hypervisors out there?

Ok I see your point and yes for better binary compatibility, the ops have to be
set based on runtime detection of hypervisor capabilities.

> > Ok. I guess the other option is to standardize on a new virtio transport (like
> > ivshmem2-virtio)?
> 
> I haven't looked at that, but I suppose it depends on what your hypervisor
> folks are willing to accomodate.

I believe ivshmem2_virtio requires hypervisor to support PCI device emulation
(for life-cycle management of VMs), which our hypervisor may not support. A
simple shared memory and doorbell or message-queue based transport will work for
us.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
