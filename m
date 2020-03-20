From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 3/8] iommu/vt-d: Remove IOVA handling code from
 non-dma_ops path
Date: Fri, 20 Mar 2020 15:06:24 +0800
Message-ID: <46bf21e2-bb3e-1c1e-8dae-2c5bd8c5274f@linux.intel.com>
References: <20191221150402.13868-1-murphyt7@tcd.ie>
 <20191221150402.13868-4-murphyt7@tcd.ie>
 <CALQxJuuue2MCF+xAAAcWCW=301HHZ9yWBmYV-K-ubCxO4s5eqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CALQxJuuue2MCF+xAAAcWCW=301HHZ9yWBmYV-K-ubCxO4s5eqQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org
Cc: baolu.lu@linux.intel.com, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.co>
List-Id: virtualization@lists.linuxfoundation.org

On 2020/3/20 14:30, Tom Murphy wrote:
> Could we merge patch 1-3 from this series? it just cleans up weird
> code and merging these patches will cover some of the work needed to
> move the intel iommu driver to the dma-iommu api in the future.

Can you please take a look at this patch series?

https://lkml.org/lkml/2020/3/13/1162

It probably makes this series easier.

Best regards,
baolu

> 
> On Sat, 21 Dec 2019 at 07:04, Tom Murphy<murphyt7@tcd.ie>  wrote:
>> Remove all IOVA handling code from the non-dma_ops path in the intel
>> iommu driver.
>>
>> There's no need for the non-dma_ops path to keep track of IOVAs. The
>> whole point of the non-dma_ops path is that it allows the IOVAs to be
>> handled separately. The IOVA handling code removed in this patch is
>> pointless.
>>
>> Signed-off-by: Tom Murphy<murphyt7@tcd.ie>
