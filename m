From: Amit Shah <amit.shah@redhat.com>
Subject: [RFC PATCH 2/3] virtio: rng: only accept delayed early randomness
	requests
Date: Mon, 14 Jul 2014 10:05:20 +0530
Message-ID: <d2e8c74866e002fe8c9ec62c00dc70a75328ecf9.1405277045.git.amit.shah@redhat.com>
References: <cover.1405277045.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1405277045.git.amit.shah@redhat.com>
In-Reply-To: <cover.1405277045.git.amit.shah@redhat.com>
References: <cover.1405277045.git.amit.shah@redhat.com>
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

hw_random core can ask for initial randomness after a slight delay after
probe() finishes, and we can contribute to system randomness at that
point.  Tell the hw_random core by setting the HWRNG_DELAY_READ_AT_INIT
flag.

CC: Kees Cook <keescook@chromium.org>
CC: Jason Cooper <jason@lakedaemon.net>
CC: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index d8ffebd..f53f1e8 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -123,6 +123,7 @@ static int probe_common(struct virtio_device *vdev)
 		.cleanup = virtio_cleanup,
 		.priv = (unsigned long)vi,
 		.name = vi->name,
+		.flags = HWRNG_DELAY_READ_AT_INIT,
 	};
 	vdev->priv = vi;
 
-- 
1.9.3
