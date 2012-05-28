From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 3/5] virtio: rng: don't wait on host when module is going away
Date: Mon, 28 May 2012 12:18:41 +0530
Message-ID: <0acbbc9dfb845f418ae73fafe960f21a8167d561.1338187342.git.amit.shah@redhat.com>
References: <cover.1338187342.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1338187342.git.amit.shah@redhat.com>
In-Reply-To: <cover.1338187342.git.amit.shah@redhat.com>
References: <cover.1338187342.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

No use waiting for input from host when the module is being removed.
We're going to remove the vq in the next step anyway, so just perform
any other steps for cleanup (currently none).

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index c8a9350..2dc9ce1 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -109,6 +109,7 @@ static int virtrng_probe(struct virtio_device *vdev)
 static void __devexit virtrng_remove(struct virtio_device *vdev)
 {
 	vdev->config->reset(vdev);
+	busy = false;
 	hwrng_unregister(&virtio_hwrng);
 	vdev->config->del_vqs(vdev);
 }
-- 
1.7.7.6
