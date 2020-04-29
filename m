From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Date: Wed, 29 Apr 2020 15:01:14 +0800
Message-ID: <80a3a471-0a2c-3ab3-529c-1b8b624679f8@linux.intel.com>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
 <20200429023842-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200429023842-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: baolu.lu@linux.intel.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>, tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org, konrad.wilk@oracle.com, jan.kiszka@siemens.com, jasowang@redhat.com, christoffer.dall@arm.com, virtualization@lists.linux-foundation.org, alex.bennee@linaro.org, iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com, will@kernel.org, linux-kernel@vger.kernel.org, pratikp@codeaurora.org
List-Id: virtualization@lists.linuxfoundation.org

On 2020/4/29 14:50, Michael S. Tsirkin wrote:
> On Wed, Apr 29, 2020 at 01:42:13PM +0800, Lu Baolu wrote:
>> On 2020/4/29 12:57, Michael S. Tsirkin wrote:
>>> On Wed, Apr 29, 2020 at 10:22:32AM +0800, Lu Baolu wrote:
>>>> On 2020/4/29 4:41, Michael S. Tsirkin wrote:
>>>>> On Tue, Apr 28, 2020 at 11:19:52PM +0530, Srivatsa Vaddagiri wrote:
>>>>>> * Michael S. Tsirkin<mst@redhat.com>   [2020-04-28 12:17:57]:
>>>>>>
>>>>>>> Okay, but how is all this virtio specific?  For example, why not allow
>>>>>>> separate swiotlbs for any type of device?
>>>>>>> For example, this might make sense if a given device is from a
>>>>>>> different, less trusted vendor.
>>>>>> Is swiotlb commonly used for multiple devices that may be on different trust
>>>>>> boundaries (and not behind a hardware iommu)?
>>>>> Even a hardware iommu does not imply a 100% security from malicious
>>>>> hardware. First lots of people use iommu=pt for performance reasons.
>>>>> Second even without pt, unmaps are often batched, and sub-page buffers
>>>>> might be used for DMA, so we are not 100% protected at all times.
>>>>>
>>>> For untrusted devices, IOMMU is forced on even iommu=pt is used;
>>> I think you are talking about untrusted*drivers*  like with VFIO.
>> No. I am talking about untrusted devices like thunderbolt peripherals.
>> We always trust drivers hosted in kernel and the DMA APIs are designed
>> for them, right?
>>
>> Please refer to this series.
>>
>> https://lkml.org/lkml/2019/9/6/39
>>
>> Best regards,
>> baolu
> Oh, thanks for that! I didn't realize Linux is doing this.
> 
> So it seems that with modern Linux, all one needs
> to do on x86 is mark the device as untrusted.
> It's already possible to do this with ACPI and with OF - would that be
> sufficient for achieving what this patchset is trying to do?

Yes.

> 
> Adding more ways to mark a device as untrusted, and adding
> support for more platforms to use bounce buffers
> sounds like a reasonable thing to do.
> 

Agreed.

Best regards,
baolu
