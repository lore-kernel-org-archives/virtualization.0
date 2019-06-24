From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 0/5] iommu/amd: Convert the AMD iommu driver to the
	dma-iommu api
Date: Sun, 23 Jun 2019 23:19:45 -0700
Message-ID: <20190624061945.GA4912__12670.375818719$1561357207$gmane$org@infradead.org>
References: <20190613223901.9523-1-murphyt7@tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190613223901.9523-1-murphyt7@tcd.ie>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, David Brown <david.brown@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Andy Gross <agross@kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

Tom,

next time please cc Jerg as the AMD IOMMU maintainer.

Joerg, any chance you could review this?  Toms patches to convert the
AMD and Intel IOMMU drivers to the dma-iommu code are going to make my
life in DMA land significantly easier, so I have a vested interest
in this series moving forward :)
