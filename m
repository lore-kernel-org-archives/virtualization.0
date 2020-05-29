From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/8] Convert the intel iommu driver to the dma-iommu api
Date: Fri, 29 May 2020 23:11:49 +0200
Message-ID: <ef2150d5-7b6a-df25-c10d-e43316fe7812@samsung.com>
References: <20191221150402.13868-1-murphyt7@tcd.ie>
        <465815ae-9292-f37a-59b9-03949cb68460@deltatee.com>
        <20200529124523.GA11817@infradead.org>
        <CGME20200529190523eucas1p2c086133e707257c0cdc002f502d4f51d@eucas1p2.samsung.com>
        <33137cfb-603c-86e8-1091-f36117ecfaf3@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <33137cfb-603c-86e8-1091-f36117ecfaf3-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>, Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Tom Murphy <murphyt7-/Zw1syy4LHg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Julien Grall <julien.grall-5wv7dgnIgG8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <maz-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex
List-Id: virtualization@lists.linuxfoundation.org

Hi Logan,

On 29.05.2020 21:05, Logan Gunthorpe wrote:
> On 2020-05-29 6:45 a.m., Christoph Hellwig wrote:
>> On Thu, May 28, 2020 at 06:00:44PM -0600, Logan Gunthorpe wrote:
>>>> This issue is most likely in the i915 driver and is most likely caused by the driver not respecting the return value of the dma_map_ops::map_sg function. You can see the driver ignoring the return value here:
>>>> https://protect2.fireeye.com/url?k=ca25a34b-97f7b813-ca242804-0cc47a31c8b4-0ecdffc9f56851e1&q=1&u=https%3A%2F%2Fgithub.com%2Ftorvalds%2Flinux%2Fblob%2F7e0165b2f1a912a06e381e91f0f4e495f4ac3736%2Fdrivers%2Fgpu%2Fdrm%2Fi915%2Fgem%2Fi915_gem_dmabuf.c%23L51
>>>>
>>>> Previously this didn’t cause issues because the intel map_sg always returned the same number of elements as the input scatter gather list but with the change to this dma-iommu api this is no longer the case. I wasn’t able to track the bug down to a specific line of code unfortunately.
>> Mark did a big audit into the map_sg API abuse and initially had
>> some i915 patches, but then gave up on them with this comment:
>>
>> "The biggest TODO is DRM/i915 driver and I don't feel brave enough to fix
>>   it fully. The driver creatively uses sg_table->orig_nents to store the
>>   size of the allocate scatterlist and ignores the number of the entries
>>   returned by dma_map_sg function. In this patchset I only fixed the
>>   sg_table objects exported by dmabuf related functions. I hope that I
>>   didn't break anything there."
>>
>> it would be really nice if the i915 maintainers could help with sorting
>> that API abuse out.
>>
> I agree completely that the API abuse should be sorted out, but I think
> that's much larger than just the i915 driver. Pretty much every dma-buf
> map_dma_buf implementation I looked at ignores the returned nents of
> sg_attrs. This sucks, but I don't think it's the bug Tom ran into. See:
>
> amdgpu_dma_buf_map
> armada_gem_prime_map_dma_buf
> drm_gem_map_dma_buf
> i915_gem_map_dma_buf
> tegra_gem_prime_map_dma_buf
>
> So this should probably be addressed by the whole GPU community.

Patches are pending:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org/T/

> However, as Robin pointed out, there are other ugly tricks like stopping
> iterating through the SGL when sg_dma_len() is zero. For example, the
> AMD driver appears to use drm_prime_sg_to_page_addr_arrays() which does
> this trick and thus likely isn't buggy (otherwise, I'd expect someone to
> have complained by now seeing AMD has already switched to IOMMU-DMA.

I'm not sure that this is a trick. Stopping at zero sg_dma_len() was 
somewhere documented.

> As I tried to point out in my previous email, i915 does not do this
> trick. In fact, it completely ignores sg_dma_len() and is thus
> completely broken. See i915_scatterlist.h and the __sgt_iter() function.
> So it doesn't sound to me like Mark's fix would address the issue at
> all. Per my previous email, I'd guess that it can be fixed simply by
> adjusting the __sgt_iter() function to do something more sensible.
> (Better yet, if possible, ditch __sgt_iter() and use the common DRM
> function that AMD uses).
>
> This would at least allow us to make progress with Tom's IOMMU-DMA patch
> set and once that gets in, it will be harder for other drivers to make
> the same mistake.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
