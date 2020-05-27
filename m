From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [PATCH v3 2/5] vhost: (cosmetic) remove a superfluous variable initialisation
Date: Wed, 27 May 2020 20:05:38 +0200
Message-ID: <20200527180541.5570-3-guennadi.liakhovetski@linux.intel.com>
References: <20200527180541.5570-1-guennadi.liakhovetski@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200527180541.5570-1-guennadi.liakhovetski@linux.intel.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: linux-remoteproc@vger.kernel.org, virtualization@lists.linux-foundation.org, sound-open-firmware@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

Even the compiler is able to figure out that in this case the
initialisation is superfluous.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 2f4383bb..2b9ad8a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -895,7 +895,7 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
 
 #define vhost_put_user(vq, x, ptr)		\
 ({ \
-	int ret = -EFAULT; \
+	int ret; \
 	if (!vq->iotlb) { \
 		ret = __put_user(x, ptr); \
 	} else { \
-- 
1.9.3
