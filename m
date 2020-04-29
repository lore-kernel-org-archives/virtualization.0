From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Date: Wed, 29 Apr 2020 16:04:40 +0530
Message-ID: <20200429103438.GF5097@quicinc.com>
References: <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
 <20200429023842-mutt-send-email-mst@kernel.org>
 <20200429094410.GD5097@quicinc.com>
 <20200429055125-mutt-send-email-mst@kernel.org>
 <20200429100953.GE5097@quicinc.com>
 <20200429061621-mutt-send-email-mst@kernel.org>
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200429061621-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org, konrad.wilk@oracle.com, jan.kiszka@siemens.com, jasowang@redhat.com, christoffer.dall@arm.com, virtualization@lists.linux-foundation.org, alex.bennee@linaro.org, iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com, will@kernel.org, linux-kernel@vger.kernel.org, pratikp@codeaurora.org
List-Id: virtualization@lists.linuxfoundation.org

* Michael S. Tsirkin <mst@redhat.com> [2020-04-29 06:20:48]:

> On Wed, Apr 29, 2020 at 03:39:53PM +0530, Srivatsa Vaddagiri wrote:
> > That would still not work I think where swiotlb is used for pass-thr devices
> > (when private memory is fine) as well as virtio devices (when shared memory is
> > required).
> 
> So that is a separate question. When there are multiple untrusted
> devices, at the moment it looks like a single bounce buffer is used.
> 
> Which to me seems like a security problem, I think we should protect
> untrusted devices from each other.

I think as first step, let me see if we can make swiotlb driver accept a target
memory segment as its working area. That may suffice our needs I think.  A
subsequent step could be to make swiotlb driver recognize multiple pools.


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
