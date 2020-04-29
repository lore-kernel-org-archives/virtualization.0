From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Date: Wed, 29 Apr 2020 09:39:29 +0530
Message-ID: <20200429040929.GC5097@quicinc.com>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2004281556180.29217@sstabellini-ThinkPad-T480s>
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004281556180.29217@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, konrad.wilk@oracle.com, jasowang@redhat.com, jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

* Stefano Stabellini <sstabellini@kernel.org> [2020-04-28 16:04:34]:

> > > Is swiotlb commonly used for multiple devices that may be on different trust
> > > boundaries (and not behind a hardware iommu)?
> 
> The trust boundary is not a good way of describing the scenario and I
> think it leads to miscommunication.
> 
> A better way to describe the scenario would be that the device can only
> DMA to/from a small reserved-memory region advertised on device tree.
> 
> Do we have other instances of devices that can only DMA to/from very
> specific and non-configurable address ranges? If so, this series could
> follow their example.

AFAICT there is no such notion in current DMA API.

static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
                bool is_ram)
{
        return end <= min_not_zero(*dev->dma_mask, dev->bus_dma_limit);
}

Only the max address a device can access is defined and not a range that we seem
to need here. I think we need to set the bus_dma_limit to 0 for virtio devices
which will force the use of swiotlb_map API. We should also have a per-device
swiotlb pool defined, so that swiotlb can use the pool meant for the given
device.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
