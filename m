From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 2/5] iommu: arm: Use iommu_put_resv_regions_simple()
Date: Tue, 17 Dec 2019 10:59:07 +0000
Message-ID: <20191217105907.GA32012__337.387462944605$1576580366$gmane$org@willie-the-truck>
References: <20191209145007.2433144-1-thierry.reding@gmail.com>
 <20191209145007.2433144-3-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191209145007.2433144-3-thierry.reding@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 09, 2019 at 03:50:04PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Use the new standard function instead of open-coding it.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 11 +----------
>  drivers/iommu/arm-smmu.c    | 11 +----------
>  2 files changed, 2 insertions(+), 20 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
