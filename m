From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: Re: [RFC/PATCH 0/1] virtio_mmio: hypervisor specific interfaces for
 MMIO
Date: Thu, 30 Apr 2020 16:10:05 +0530
Message-ID: <20200430104004.GA3204@quicinc.com>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <20200430060653-mutt-send-email-mst@kernel.org>
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200430060653-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: konrad.wilk@oracle.com, jasowang@redhat.com, jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

* Michael S. Tsirkin <mst@redhat.com> [2020-04-30 06:07:56]:

> On Thu, Apr 30, 2020 at 03:32:55PM +0530, Srivatsa Vaddagiri wrote:
> > The Type-1 hypervisor we are dealing with does not allow for MMIO transport. 
> 
> How about PCI then?

Correct me if I am wrong, but basically virtio_pci uses the same low-level
primitive as readl/writel on a platform such as ARM64? So similar issues
there also.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
