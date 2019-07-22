From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] MAINTAINERS: Update my email address
Date: Mon, 22 Jul 2019 14:44:40 +0100
Message-ID: <20190722134438.31003-1-jean-philippe__30257.9460827232$1563995365$gmane$org@linaro.org>
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
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org
Cc: virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com, mst@redhat.com, linux-pci@vger.kernel.org, joro@8bytes.org, maz@kernel.org, will@kernel.org, kvmarm@lists.cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

Update MAINTAINERS and .mailmap with my @linaro.org address, since I
don't have access to my @arm.com address anymore.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 0fef932de3db..8ce554b9c9f1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -98,6 +98,7 @@ Jason Gunthorpe <jgg@ziepe.ca> <jgunthorpe@obsidianresearch.com>
 Javi Merino <javi.merino@kernel.org> <javi.merino@arm.com>
 <javier@osg.samsung.com> <javier.martinez@collabora.co.uk>
 Jean Tourrilhes <jt@hpl.hp.com>
+<jean-philippe@linaro.org> <jean-philippe.brucker@arm.com>
 Jeff Garzik <jgarzik@pretzel.yyz.us>
 Jeff Layton <jlayton@kernel.org> <jlayton@redhat.com>
 Jeff Layton <jlayton@kernel.org> <jlayton@poochiereds.net>
diff --git a/MAINTAINERS b/MAINTAINERS
index 783569e3c4b4..bded78c84701 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17123,7 +17123,7 @@ F:	drivers/virtio/virtio_input.c
 F:	include/uapi/linux/virtio_input.h
 
 VIRTIO IOMMU DRIVER
-M:	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
+M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
 L:	virtualization@lists.linux-foundation.org
 S:	Maintained
 F:	drivers/iommu/virtio-iommu.c
-- 
2.22.0
