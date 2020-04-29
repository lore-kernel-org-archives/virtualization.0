From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Date: Wed, 29 Apr 2020 09:05:39 +0530
Message-ID: <20200429033539.GB5097@quicinc.com>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428163448-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: konrad.wilk@oracle.com, jasowang@redhat.com, jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

* Michael S. Tsirkin <mst@redhat.com> [2020-04-28 16:41:04]:

> > Won't we still need some changes to virtio to make use of its own pool (to
> > bounce buffers)? Something similar to its own DMA ops proposed in this patch?
> 
> If you are doing this for all devices, you need to either find a way
> to do this without chaning DMA ops, or by doing some automatic change
> to all drivers.

Ok thanks for this input. I will see how we can obfuscate this in DMA APIs
itself.

Can you also comment on the virtio transport problem I cited? The hypervisor we
are dealing with does not support MMIO transport. It supports message queue
send/recv and also doorbell, which I think can be used if we can make some
change like this to virtio_mmio.c:

+static inline u32
+virtio_readl(struct virtio_mmio_device *vm_dev, u32 reg_offset)
+{
+        return vm_dev->mmio_ops->readl(vm_dev, reg_offset);
+}
+ 
+static inline void
+virtio_writel(struct virtio_mmio_device *vm_dev, u32 reg_offset, u32 data)
+{
+        vm_dev->mmio_ops->writel(vm_dev, reg_offset, data);
+}


        /* Check magic value */
-        magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
+        magic = vrito_readl(vm_dev, VIRTIO_MMIO_MAGIC_VALUE);

mmio_ops->readl on most platforms can default to readl itself, while on a
platform like us, it can boil down to message_queue send/recv. Would such a
change be acceptable?

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
