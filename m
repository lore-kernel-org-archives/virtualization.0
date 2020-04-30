From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: Re: [RFC/PATCH 0/1] virtio_mmio: hypervisor specific interfaces for
 MMIO
Date: Thu, 30 Apr 2020 15:59:39 +0530
Message-ID: <20200430102939.GG5097@quicinc.com>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <20200430100821.GC19932@willie-the-truck>
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200430100821.GC19932@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com, jan.kiszka@siemens.com, stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

* Will Deacon <will@kernel.org> [2020-04-30 11:08:22]:

> > This patch is meant to seek comments. If its considered to be in right
> > direction, will work on making it more complete and send the next version!
> 
> What's stopping you from implementing the trapping support in the
> hypervisor? Unlike the other patches you sent out, where the guest memory
> is not accessible to the host, there doesn't seem to be any advantage to
> not having trapping support, or am I missing something here?

Hi Will,
	I have had this discussion with hypervisor folks. They seem to be
concerned about complexity of having a VM's fault be handled in another
untrusted VM. They are not keen to add MMIO support.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
