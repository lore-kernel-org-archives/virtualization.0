From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/2] hwrng: don't fetch rng from sources without init
Date: Wed,  2 Jul 2014 15:58:15 +0530
Message-ID: <c911b7944f2d05f5c6f5cf5dc37b8dbb99fd0b14.1404296679.git.amit.shah@redhat.com>
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

Commit d9e7972619334 "hwrng: add randomness to system from rng sources"
added a call to rng_get_data() from the hwrng_register() function.
However, some rng devices need initialization before data can be read
from them.

Also, the virtio-rng device does not behave properly when this call is
made in its probe() routine - the virtio core sets the DRIVER_OK status
bit only on a successful probe, which means the host ignores all
communication from the guest, and the guest insmod or boot process just
sits there doing nothing.

This commit makes the call to rng_get_data() depend on no init fn
pointer being registered by the device.  If an init function is
registered, this call isn't made.

CC: Kees Cook <keescook@chromium.org>
CC: Jason Cooper <jason@lakedaemon.net>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: <stable@vger.kernel.org> # For 3.15 only
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/hw_random/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 334601c..3f3941d 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -347,9 +347,11 @@ int hwrng_register(struct hwrng *rng)
 	INIT_LIST_HEAD(&rng->list);
 	list_add_tail(&rng->list, &rng_list);
 
-	bytes_read = rng_get_data(rng, bytes, sizeof(bytes), 1);
-	if (bytes_read > 0)
-		add_device_randomness(bytes, bytes_read);
+	if (!rng->init) {
+		bytes_read = rng_get_data(rng, bytes, sizeof(bytes), 1);
+		if (bytes_read > 0)
+			add_device_randomness(bytes, bytes_read);
+	}
 out_unlock:
 	mutex_unlock(&rng_mutex);
 out:
-- 
1.9.3
