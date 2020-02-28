From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 03/14] iommu/tegra-gart: Remove direct access of
 dev->iommu_fwspec
Date: Fri, 28 Feb 2020 16:08:09 +0100
Message-ID: <20200228150820.15340-4-joro@8bytes.org>
References: <20200228150820.15340-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200228150820.15340-1-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: iommu@lists.linux-foundation.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org, Andy Gross <agross@kernel.org>, Joerg Roedel <jroedel@suse.de>, Hanjun Guo <guohanjun@huawei.com>, Matthias Brugger <matthias.bgg@gmail.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Sean Paul <sean@poorly.run>, Robin Murphy <robin.murphy@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

Use the accessor functions instead of directly dereferencing
dev->iommu_fwspec.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/tegra-gart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 3fb7ba72507d..db6559e8336f 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -247,7 +247,7 @@ static int gart_iommu_add_device(struct device *dev)
 {
 	struct iommu_group *group;
 
-	if (!dev->iommu_fwspec)
+	if (!dev_iommu_fwspec_get(dev))
 		return -ENODEV;
 
 	group = iommu_group_get_for_dev(dev);
-- 
2.17.1
