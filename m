From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Date: Wed, 29 Apr 2020 15:14:10 +0530
Message-ID: <20200429094410.GD5097@quicinc.com>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
 <20200429023842-mutt-send-email-mst@kernel.org>
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200429023842-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org, konrad.wilk@oracle.com, jan.kiszka@siemens.com, jasowang@redhat.com, christoffer.dall@arm.com, virtualization@lists.linux-foundation.org, alex.bennee@linaro.org, iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com, will@kernel.org, linux-kernel@vger.kernel.org, pratikp@codeaurora.org
List-Id: virtualization@lists.linuxfoundation.org

* Michael S. Tsirkin <mst@redhat.com> [2020-04-29 02:50:41]:

> So it seems that with modern Linux, all one needs
> to do on x86 is mark the device as untrusted.
> It's already possible to do this with ACPI and with OF - would that be
> sufficient for achieving what this patchset is trying to do?

In my case, its not sufficient to just mark virtio device untrusted and thus
activate the use of swiotlb. All of the secondary VM memory, including those
allocate by swiotlb driver, is private to it. An additional piece of memory is
available to secondary VM which is shared between VMs and which is where I need
swiotlb driver to do its work.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
