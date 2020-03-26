From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 0/3] iommu/virtio: Misc fixes
Date: Thu, 26 Mar 2020 10:35:55 +0100
Message-ID: <20200326093558.2641019-1-jean-philippe@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, mst@redhat.com, joro@8bytes.org, virtualization@lists.linux-foundation.org, eric.auger@redhat.com, bbhushan2@marvell.com
List-Id: virtualization@lists.linuxfoundation.org

A collection of fixes for the virtio-iommu driver. It might be too late
for v5.6 since they need more review. Patch 2 is new, the others were
posted separately. 

Jean-Philippe Brucker (3):
  iommu/virtio: Fix sparse warning
  iommu/virtio: Fix freeing of incomplete domains
  iommu/virtio: Reject IOMMU page granule larger than PAGE_SIZE

 include/uapi/linux/virtio_iommu.h | 12 ++++++------
 drivers/iommu/virtio-iommu.c      | 30 +++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 15 deletions(-)

-- 
2.25.1
