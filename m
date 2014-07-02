From: Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 2/2 v2] hwrng: virtio: disable reading during probe
Date: Wed,  2 Jul 2014 13:00:20 +0000
Message-ID: <1404306020-24916-2-git-send-email-jason__16748.767582658$1404408103$gmane$org@lakedaemon.net>
References: <cover.1404296679.git.amit.shah@redhat.com>
	<1404306020-24916-1-git-send-email-jason@lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1404306020-24916-1-git-send-email-jason@lakedaemon.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Jason Cooper <jason@lakedaemon.net>, Herbert Xu <herbert@gondor.apana.org.au>
List-Id: virtualization@lists.linuxfoundation.org

The hwrng core asks for random data in the hwrng_register() call itself
from commit d9e7972619.  This doesn't play well with virtio -- the
DRIVER_OK bit is only set by virtio core on a successful probe, and
we're not yet out of our probe routine when this call is made.  This
causes the host to not acknowledge any requests we put in the virtqueue,
and the insmod or kernel boot process just waits for data to arrive from
the host, which never happens.

The previous commit makes the hwrng core check for the
HWRNG_NO_READ_AT_PROBE flag before reading from the device  If the flag
is set, the request for random data isn't made, and the stall when
loading the module doesn't happen.

[jac: reworked to use a flag instead of an init function.  Reused most
of Amit's commit message. ]

CC: Kees Cook <keescook@chromium.org>
CC: Jason Cooper <jason@lakedaemon.net>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: <stable@vger.kernel.org> # v3.15+
Signed-off-by: Amit Shah <amit.shah@redhat.com>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 drivers/char/hw_random/virtio-rng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index f3e71501de54..f83433bb1fae 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -115,6 +115,7 @@ static int probe_common(struct virtio_device *vdev)
 		.cleanup = virtio_cleanup,
 		.priv = (unsigned long)vi,
 		.name = vi->name,
+		.flags = HWRNG_NO_READ_AT_PROBE,
 	};
 	vdev->priv = vi;
 
-- 
2.0.0
