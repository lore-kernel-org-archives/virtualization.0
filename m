From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/3] iommu/virtio: Enable x86 support
Date: Mon, 17 Feb 2020 13:22:44 +0000
Message-ID: <915044ae-6972-e0eb-43e8-d071af848fe3@arm.com>
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
 <20200214160413.1475396-4-jean-philippe@linaro.org>
 <311a1885-c619-3c8d-29dd-14fbfbf74898@arm.com>
 <20200216045006-mutt-send-email-mst@kernel.org>
 <20200217090107.GA1650092@myrica>
 <20200217080129-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20200217080129-mutt-send-email-mst@kernel.org>
Content-Language: en-GB
Sender: linux-pci-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, kevin.tian@intel.com, sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, bhelgaas@google.com, jasowang@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 17/02/2020 1:01 pm, Michael S. Tsirkin wrote:
> On Mon, Feb 17, 2020 at 10:01:07AM +0100, Jean-Philippe Brucker wrote:
>> On Sun, Feb 16, 2020 at 04:50:33AM -0500, Michael S. Tsirkin wrote:
>>> On Fri, Feb 14, 2020 at 04:57:11PM +0000, Robin Murphy wrote:
>>>> On 14/02/2020 4:04 pm, Jean-Philippe Brucker wrote:
>>>>> With the built-in topology description in place, x86 platforms can now
>>>>> use the virtio-iommu.
>>>>>
>>>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>>> ---
>>>>>    drivers/iommu/Kconfig | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>>>> index 068d4e0e3541..adcbda44d473 100644
>>>>> --- a/drivers/iommu/Kconfig
>>>>> +++ b/drivers/iommu/Kconfig
>>>>> @@ -508,8 +508,9 @@ config HYPERV_IOMMU
>>>>>    config VIRTIO_IOMMU
>>>>>    	bool "Virtio IOMMU driver"
>>>>>    	depends on VIRTIO=y
>>>>> -	depends on ARM64
>>>>> +	depends on (ARM64 || X86)
>>>>>    	select IOMMU_API
>>>>> +	select IOMMU_DMA
>>>>
>>>> Can that have an "if X86" for clarity? AIUI it's not necessary for
>>>> virtio-iommu itself (and really shouldn't be), but is merely to satisfy the
>>>> x86 arch code's expectation that IOMMU drivers bring their own DMA ops,
>>>> right?
>>>>
>>>> Robin.
>>>
>>> In fact does not this work on any platform now?
>>
>> There is ongoing work to use the generic IOMMU_DMA ops on X86. AMD IOMMU
>> has been converted recently [1] but VT-d still implements its own DMA ops
>> (conversion patches are on the list [2]). On Arm the arch Kconfig selects
>> IOMMU_DMA, and I assume we'll have the same on X86 once Tom's work is
>> complete. Until then I can add a "if X86" here for clarity.
>>
>> Thanks,
>> Jean
>>
>> [1] https://lore.kernel.org/linux-iommu/20190613223901.9523-1-murphyt7@tcd.ie/
>> [2] https://lore.kernel.org/linux-iommu/20191221150402.13868-1-murphyt7@tcd.ie/
> 
> What about others? E.g. PPC?

That was the point I was getting at - while iommu-dma should build just 
fine for the likes of PPC, s390, 32-bit Arm, etc., they have no 
architecture code to correctly wire up iommu_dma_ops to devices. Thus 
there's currently no point pulling it in and pretending it's anything 
more than a waste of space for architectures other than arm64 and x86. 
It's merely a historical artefact of the x86 DMA API implementation that 
when the IOMMU drivers were split out to form drivers/iommu they took 
some of their relevant arch code with them.

Robin.
