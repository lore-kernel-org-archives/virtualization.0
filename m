From: Amos Kong <akong@redhat.com>
Subject: [3.16 stable PATCH 1/2] virtio-rng: fix stuck of hot-unplugging busy
	device
Date: Sat, 11 Oct 2014 06:51:48 +0800
Message-ID: <1412981509-30025-2-git-send-email-akong@redhat.com>
References: <1412981509-30025-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412981509-30025-1-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: stable@vger.kernel.org
Cc: amit.shah@redhat.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

When we try to hot-remove a busy virtio-rng device from QEMU monitor,
the device can't be hot-removed. Because virtio-rng driver hangs at
wait_for_completion_killable().

This patch exits the waiting by completing have_data completion before
unregistering, resets data_avail to avoid the hwrng core use wrong
buffer bytes.

Signed-off-by: Amos Kong <akong@redhat.com>
Reviewed-by: Amit Shah <amit.shah@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
(cherry picked from commit 3856e548372513665670ca5db60d9a74b970fe0d)
Signed-off-by: Amos Kong <akong@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index f1aa13b..b50252c 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -137,6 +137,8 @@ static void remove_common(struct virtio_device *vdev)
 {
 	struct virtrng_info *vi = vdev->priv;
 
+	vi->data_avail = 0;
+	complete(&vi->have_data);
 	vdev->config->reset(vdev);
 	vi->busy = false;
 	if (vi->hwrng_register_done)
-- 
1.9.3
