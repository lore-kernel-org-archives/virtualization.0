From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Date: Wed, 29 Apr 2020 10:22:32 +0800
Message-ID: <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200428163448-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc: baolu.lu@linux.intel.com, tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org, konrad.wilk@oracle.com, jan.kiszka@siemens.com, jasowang@redhat.com, christoffer.dall@arm.com, virtualization@lists.linux-foundation.org, alex.bennee@linaro.org, iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com, will@kernel.org, linux-kernel@vger.kernel.org, pratikp@codeaurora.org
List-Id: virtualization@lists.linuxfoundation.org

On 2020/4/29 4:41, Michael S. Tsirkin wrote:
> On Tue, Apr 28, 2020 at 11:19:52PM +0530, Srivatsa Vaddagiri wrote:
>> * Michael S. Tsirkin<mst@redhat.com>  [2020-04-28 12:17:57]:
>>
>>> Okay, but how is all this virtio specific?  For example, why not allow
>>> separate swiotlbs for any type of device?
>>> For example, this might make sense if a given device is from a
>>> different, less trusted vendor.
>> Is swiotlb commonly used for multiple devices that may be on different trust
>> boundaries (and not behind a hardware iommu)?
> Even a hardware iommu does not imply a 100% security from malicious
> hardware. First lots of people use iommu=pt for performance reasons.
> Second even without pt, unmaps are often batched, and sub-page buffers
> might be used for DMA, so we are not 100% protected at all times.
> 

For untrusted devices, IOMMU is forced on even iommu=pt is used; and
iotlb flush is in strict mode (no batched flushes); ATS is also not
allowed. Swiotlb is used to protect sub-page buffers since IOMMU can
only apply page granularity protection. Swiotlb is now used for devices
from different trust zone.

Best regards,
baolu
