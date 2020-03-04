From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 00/14] iommu: Move iommu_fwspec out of 'struct device'
Date: Wed, 4 Mar 2020 14:27:53 +0100
Message-ID: <20200304132753.GA4177@8bytes.org>
References: <20200228150820.15340-1-joro@8bytes.org>
 <20200303191624.GC27329@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200303191624.GC27329@willie-the-truck>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, virtualization@lists.linux-foundation.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Robin Murphy <robin.murphy@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Will,

On Tue, Mar 03, 2020 at 07:16:25PM +0000, Will Deacon wrote:
> I haven't had a chance to review this properly yet, but I did take it
> for a spin on my Seattle board with MMU-400 (arm-smmu) and it seems to
> work the same as before, so:
> 
> Tested-by: Will Deacon <will@kernel.org> # arm-smmu
> 
> I'll try to review the patches soon.

Thanks for testing it! I will send out a new version probably beginning
of next week (I am travelling this week) to fix the kbuild issue and
anything you might find.

Thanks,

	Joerg
