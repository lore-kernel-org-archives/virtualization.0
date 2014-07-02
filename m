From: Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 1/2 v2] hwrng: Allow drivers to disable reading during probe
Date: Wed,  2 Jul 2014 13:00:19 +0000
Message-ID: <1404306020-24916-1-git-send-email-jason__11089.9136554965$1404408093$gmane$org@lakedaemon.net>
References: <cover.1404296679.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1404296679.git.amit.shah@redhat.com>
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

Commit d9e7972619334 "hwrng: add randomness to system from rng sources"
added a call to rng_get_data() from the hwrng_register() function.
However, some rng devices need initialization before data can be read
from them.

Also, the virtio-rng device does not behave properly when this call is
made in its probe() routine - the virtio core sets the DRIVER_OK status
bit only on a successful probe, which means the host ignores all
communication from the guest, and the guest insmod or boot process just
sits there doing nothing.

[ jac: Modify the API to allow drivers to disable reading at probe, new
patch, copied Amit's commit message. ]

CC: Kees Cook <keescook@chromium.org>
CC: Jason Cooper <jason@lakedaemon.net>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: <stable@vger.kernel.org> # v3.15+
Signed-off-by: Amit Shah <amit.shah@redhat.com>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 drivers/char/hw_random/core.c | 8 +++++---
 include/linux/hw_random.h     | 4 ++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 334601cc81cf..b7b6c48ca682 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -347,9 +347,11 @@ int hwrng_register(struct hwrng *rng)
 	INIT_LIST_HEAD(&rng->list);
 	list_add_tail(&rng->list, &rng_list);
 
-	bytes_read = rng_get_data(rng, bytes, sizeof(bytes), 1);
-	if (bytes_read > 0)
-		add_device_randomness(bytes, bytes_read);
+	if (!(rng->flags & HWRNG_NO_READ_AT_PROBE)) {
+		bytes_read = rng_get_data(rng, bytes, sizeof(bytes), 1);
+		if (bytes_read > 0)
+			add_device_randomness(bytes, bytes_read);
+	}
 out_unlock:
 	mutex_unlock(&rng_mutex);
 out:
diff --git a/include/linux/hw_random.h b/include/linux/hw_random.h
index b4b0eef5fddf..5e358c7f3aae 100644
--- a/include/linux/hw_random.h
+++ b/include/linux/hw_random.h
@@ -15,6 +15,8 @@
 #include <linux/types.h>
 #include <linux/list.h>
 
+#define HWRNG_NO_READ_AT_PROBE	BIT(0)
+
 /**
  * struct hwrng - Hardware Random Number Generator driver
  * @name:		Unique RNG name.
@@ -28,6 +30,7 @@
  *			Must not be NULL.    *OBSOLETE*
  * @read:		New API. drivers can fill up to max bytes of data
  *			into the buffer. The buffer is aligned for any type.
+ * @flags:              per-device properties
  * @priv:		Private data, for use by the RNG driver.
  */
 struct hwrng {
@@ -37,6 +40,7 @@ struct hwrng {
 	int (*data_present)(struct hwrng *rng, int wait);
 	int (*data_read)(struct hwrng *rng, u32 *data);
 	int (*read)(struct hwrng *rng, void *data, size_t max, bool wait);
+	unsigned long flags;
 	unsigned long priv;
 
 	/* internal. */
-- 
2.0.0
