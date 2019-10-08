From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 0/5] iommu/amd: Convert the AMD iommu driver to the
	dma-iommu api
Date: Tue, 8 Oct 2019 11:08:13 +0200
Message-ID: <20191008090813.GB2514@8bytes.org>
References: <20190908165642.22253-1-murphyt7@tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190908165642.22253-1-murphyt7@tcd.ie>
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
Cc: Heiko Stuebner <heiko@sntech.de>, virtualization@lists.linux-foundation.org, linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Kukjin Kim <kgene@kernel.org>, Robin Murphy <robin.murphy@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Sep 08, 2019 at 09:56:36AM -0700, Tom Murphy wrote:
> Convert the AMD iommu driver to the dma-iommu api. Remove the iova
> handling and reserve region code from the AMD iommu driver.

Applied, thanks. Note that it will not show up in linux-next before
-rc3.
