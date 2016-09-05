From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v9 18/19] drm/virtio: kconfig: Fixup white space.
Date: Mon,  5 Sep 2016 14:17:00 +0100
Message-ID: <1473081421-16555-19-git-send-email-peter.griffin__43924.0788030022$1473081679$gmane$org@linaro.org>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, vinod.koul@intel.com, patrice.chotard@st.com, dan.j.williams@intel.com, airlied@linux.ie, kraxel@redhat.com, ohad@wizery.com, bjorn.andersson@linaro.org
Cc: devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, peter.griffin@linaro.org, dmaengine@vger.kernel.org, lee.jones@linaro.org
List-Id: virtualization@lists.linuxfoundation.org

Use tabs instead of spaces.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/virtio/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfig
index 90357d9..2d83932 100644
--- a/drivers/gpu/drm/virtio/Kconfig
+++ b/drivers/gpu/drm/virtio/Kconfig
@@ -2,10 +2,10 @@ config DRM_VIRTIO_GPU
 	tristate "Virtio GPU driver"
 	depends on DRM
 	select VIRTIO
-        select DRM_KMS_HELPER
-        select DRM_TTM
+	select DRM_KMS_HELPER
+	select DRM_TTM
 	help
 	   This is the virtual GPU driver for virtio.  It can be used with
-           QEMU based VMMs (like KVM or Xen).
+	   QEMU based VMMs (like KVM or Xen).
 
 	   If unsure say M.
-- 
1.9.1
