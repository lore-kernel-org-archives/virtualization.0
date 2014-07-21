From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/3] virtio: rng: remove unused struct element
Date: Mon, 21 Jul 2014 15:00:59 +0530
Message-ID: <4895429ba7a3cca4622f2fcf28fbbd40d1aca401.1405934853.git.amit.shah@redhat.com>
References: <cover.1405934853.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1405934853.git.amit.shah@redhat.com>
In-Reply-To: <cover.1405934853.git.amit.shah@redhat.com>
References: <cover.1405934853.git.amit.shah@redhat.com>
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
Cc: jason@lakedaemon.net, keescook@chromium.org, Virtualization List <virtualization@lists.linux-foundation.org>, Amit Shah <amit.shah@redhat.com>, herbert@gondor.apana.org.au
List-Id: virtualization@lists.linuxfoundation.org

vdev is unused in struct virtrng_info, remove it.

CC: Amos Kong <akong@redhat.com>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index e9b15bc..d8ffebd 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -28,7 +28,6 @@
 static DEFINE_IDA(rng_index_ida);
 
 struct virtrng_info {
-	struct virtio_device *vdev;
 	struct hwrng hwrng;
 	struct virtqueue *vq;
 	unsigned int data_avail;
-- 
1.9.3
