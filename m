From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 2/2] virtio: rng: introduce an init fn for hwrng core
Date: Wed,  2 Jul 2014 15:58:16 +0530
Message-ID: <5308626c48a1d16982bf6626a2a0b4cd5e4ade4d.1404296679.git.amit.shah@redhat.com>
References: <cover.1404296679.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1404296679.git.amit.shah@redhat.com>
In-Reply-To: <cover.1404296679.git.amit.shah@redhat.com>
References: <cover.1404296679.git.amit.shah@redhat.com>
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
Cc: jason@lakedaemon.net, keescook@chromium.org, stable@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>, Amit Shah <amit.shah@redhat.com>, herbert@gondor.apana.org.au
List-Id: virtualization@lists.linuxfoundation.org

The hwrng core asks for random data in the hwrng_register() call itself
from commit d9e7972619.  This doesn't play well with virtio -- the
DRIVER_OK bit is only set by virtio core on a successful probe, and
we're not yet out of our probe routine when this call is made.  This
causes the host to not acknowledge any requests we put in the virtqueue,
and the insmod or kernel boot process just waits for data to arrive from
the host, which never happens.

The previous commit makes the hwrng core check for on an init function
in the hwrng struct that's registered.  If such a fn exists, the request
for random data isn't made, and the stall when loading the module
doesn't happen.

CC: Kees Cook <keescook@chromium.org>
CC: Jason Cooper <jason@lakedaemon.net>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: <stable@vger.kernel.org> # For 3.15 only
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index f3e7150..c8471ef 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -93,6 +93,16 @@ static void virtio_cleanup(struct hwrng *rng)
 		wait_for_completion(&vi->have_data);
 }
 
+int virtio_init(struct hwrng *rng)
+{
+	/*
+	 * Empty function to ensure hwrandom core does not ask us for
+	 * randomness during hwrng_register phase.  This prevents us
+	 * from exiting to host without VIRTIO_CONFIG_S_DRIVER_OK set.
+	 */
+	return 0;
+}
+
 static int probe_common(struct virtio_device *vdev)
 {
 	int err, index;
@@ -111,6 +121,7 @@ static int probe_common(struct virtio_device *vdev)
 	init_completion(&vi->have_data);
 
 	vi->hwrng = (struct hwrng) {
+		.init = virtio_init,
 		.read = virtio_read,
 		.cleanup = virtio_cleanup,
 		.priv = (unsigned long)vi,
-- 
1.9.3
