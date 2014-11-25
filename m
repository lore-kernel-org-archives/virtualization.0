From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v4 04/42] virtio: disable virtio 1.0 in transports
Date: Tue, 25 Nov 2014 18:41:35 +0200
Message-ID: <1416933600-21398-5-git-send-email-mst@redhat.com>
References: <1416933600-21398-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1416933600-21398-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, lguest@lists.ozlabs.org, Pawel Moll <pawel.moll@arm.com>, rusty@au1.ibm.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Sudeep Dutt <sudeep.dutt@intel.com>, virtualization@lists.linux-foundation.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Siva Yerramreddy <yshivakrishna@gmail.com>, linux390@de.ibm.com, pbonzini@redhat.com, David Miller <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

disable virtio 1.0 in transports that don't
support it yet.
We will gradually re-enable as support is added.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/lguest/lguest_device.c     | 3 ++-
 drivers/misc/mic/card/mic_virtio.c | 2 ++
 drivers/s390/kvm/virtio_ccw.c      | 3 ++-
 drivers/virtio/virtio_mmio.c       | 2 ++
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/lguest/lguest_device.c b/drivers/lguest/lguest_device.c
index 4d29bcd..4deaf88 100644
--- a/drivers/lguest/lguest_device.c
+++ b/drivers/lguest/lguest_device.c
@@ -106,7 +106,8 @@ static u64 lg_get_features(struct virtio_device *vdev)
 		if (in_features[i / 8] & (1 << (i % 8)))
 			features |= (1ULL << i);
 
-	return features;
+	/* lguest is not in virtio 1.0 */
+	return features & ~BIT_ULL(VIRTIO_F_VERSION_1);
 }
 
 /*
diff --git a/drivers/misc/mic/card/mic_virtio.c b/drivers/misc/mic/card/mic_virtio.c
index 6d94f04..edc77f1 100644
--- a/drivers/misc/mic/card/mic_virtio.c
+++ b/drivers/misc/mic/card/mic_virtio.c
@@ -82,6 +82,8 @@ static u64 mic_get_features(struct virtio_device *vdev)
 		if (ioread8(&in_features[i / 8]) & (BIT_ULL(i % 8)))
 			features |= BIT_ULL(i);
 
+	/* MIC is not in virtio 1.0, disable it for now. */
+	features &= ~BIT_ULL(VIRTIO_F_VERSION_1);
 	return features;
 }
 
diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index abba04d..08536f0 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -704,7 +704,8 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
 out_free:
 	kfree(features);
 	kfree(ccw);
-	return rc;
+	/* TODO: enable virtio 1.0 */
+	return rc & ~BIT_ULL(VIRTIO_F_VERSION_1);;
 }
 
 static void virtio_ccw_finalize_features(struct virtio_device *vdev)
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index fd01c6d..e1d38a9 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -151,6 +151,8 @@ static u64 vm_get_features(struct virtio_device *vdev)
 	features = readl(vm_dev->base + VIRTIO_MMIO_HOST_FEATURES);
 	writel(1, vm_dev->base + VIRTIO_MMIO_HOST_FEATURES_SEL);
 	features |= ((u64)readl(vm_dev->base + VIRTIO_MMIO_HOST_FEATURES) << 32);
+	/* TODO: enable virtio 1.0 support */
+	features &= ~BIT_ULL(VIRTIO_F_VERSION_1);
 	return features;
 }
 
-- 
MST
