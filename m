From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 0/5] iommu/amd: Convert the AMD iommu driver to the
	dma-iommu api
Date: Tue, 13 Aug 2019 06:07:11 -0700
Message-ID: <20190813130711.GA30468__14719.9994580419$1565701657$gmane$org@infradead.org>
References: <20190613223901.9523-1-murphyt7@tcd.ie>
	<20190624061945.GA4912@infradead.org>
	<20190810071952.GA25550@infradead.org>
	<CALQxJuvxBc3MH3_B_fZ3FvURHOM3F3dvvZ6x=GtALUAvyu7Qxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALQxJuvxBc3MH3_B_fZ3FvURHOM3F3dvvZ6x=GtALUAvyu7Qxw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tom Murphy <murphyt7@tcd.ie>
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, David Brown <david.brown@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>, linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Kukjin Kim <kgene@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 13, 2019 at 08:09:26PM +0800, Tom Murphy wrote:
> Hi Christoph,
> 
> I quit my job and am having a great time traveling South East Asia.

Enjoy!  I just returned from my vacation.

> I definitely don't want this work to go to waste and I hope to repost it
> later this week but I can't guarantee it.
> 
> Let me know if you need this urgently.

It isn't in any strict sense urgent.  I just have various DMA API plans
that I'd rather just implement in dma-direct and dma-iommu rather than
also in two additional commonly used iommu drivers.  So on the one had
the sooner the better, on the other hand no real urgency.
