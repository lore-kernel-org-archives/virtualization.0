From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v3 1/2] hwrng: fetch randomness only after device init
Date: Thu, 10 Jul 2014 15:42:34 +0530
Message-ID: <8cf671af94c4747765ebec91a2a4f034a65aef2e.1404987133.git.amit.shah@redhat.com>
References: <cover.1404987133.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1404987133.git.amit.shah@redhat.com>
In-Reply-To: <cover.1404987133.git.amit.shah@redhat.com>
References: <cover.1404987133.git.amit.shah@redhat.com>
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

This commit makes the call to rng_get_data() depend on no init fn
pointer being registered by the device.  If an init function is
registered, this call is made after device init.

CC: Kees Cook <keescook@chromium.org>
CC: Jason Cooper <jason@lakedaemon.net>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: <stable@vger.kernel.org> # For v3.15+
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/hw_random/core.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 334601c..2a451b1 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -55,16 +55,35 @@ static DEFINE_MUTEX(rng_mutex);
 static int data_avail;
 static u8 *rng_buffer;
 
+static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
+			       int wait);
+
 static size_t rng_buffer_size(void)
 {
 	return SMP_CACHE_BYTES < 32 ? 32 : SMP_CACHE_BYTES;
 }
 
+static void add_early_randomness(struct hwrng *rng)
+{
+	unsigned char bytes[16];
+	int bytes_read;
+
+	bytes_read = rng_get_data(rng, bytes, sizeof(bytes), 1);
+	if (bytes_read > 0)
+		add_device_randomness(bytes, bytes_read);
+}
+
 static inline int hwrng_init(struct hwrng *rng)
 {
-	if (!rng->init)
-		return 0;
-	return rng->init(rng);
+	if (rng->init) {
+		int ret;
+
+		ret =  rng->init(rng);
+		if (ret)
+			return ret;
+	}
+	add_early_randomness(rng);
+	return 0;
 }
 
 static inline void hwrng_cleanup(struct hwrng *rng)
@@ -304,8 +323,6 @@ int hwrng_register(struct hwrng *rng)
 {
 	int err = -EINVAL;
 	struct hwrng *old_rng, *tmp;
-	unsigned char bytes[16];
-	int bytes_read;
 
 	if (rng->name == NULL ||
 	    (rng->data_read == NULL && rng->read == NULL))
@@ -347,9 +364,17 @@ int hwrng_register(struct hwrng *rng)
 	INIT_LIST_HEAD(&rng->list);
 	list_add_tail(&rng->list, &rng_list);
 
-	bytes_read = rng_get_data(rng, bytes, sizeof(bytes), 1);
-	if (bytes_read > 0)
-		add_device_randomness(bytes, bytes_read);
+	if (old_rng && !rng->init) {
+		/*
+		 * Use a new device's input to add some randomness to
+		 * the system.  If this rng device isn't going to be
+		 * used right away, its init function hasn't been
+		 * called yet; so only use the randomness from devices
+		 * that don't need an init callback.
+		 */
+		add_early_randomness(rng);
+	}
+
 out_unlock:
 	mutex_unlock(&rng_mutex);
 out:
-- 
1.9.3
