From: Amos Kong <akong@redhat.com>
Subject: [PATCH v2 4/6] hw_random: fix unregister race.
Date: Thu, 18 Sep 2014 20:37:45 +0800
Message-ID: <1411043867-21109-5-git-send-email-akong@redhat.com>
References: <1411043867-21109-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1411043867-21109-1-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: herbert@gondor.apana.org.au, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, m@bues.ch, mpm@selenic.com, amit.shah@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Rusty Russell <rusty@rustcorp.com.au>

The previous patch added one potential problem: we can still be
reading from a hwrng when it's unregistered.  Add a wait for zero
in the hwrng_unregister path.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/char/hw_random/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index ee9e504..9f6f5bb 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -60,6 +60,7 @@ static DEFINE_MUTEX(rng_mutex);
 static DEFINE_MUTEX(reading_mutex);
 static int data_avail;
 static u8 *rng_buffer, *rng_fillbuf;
+static DECLARE_WAIT_QUEUE_HEAD(rng_done);
 static unsigned short current_quality;
 static unsigned short default_quality; /* = 0; default to "off" */
 
@@ -98,6 +99,7 @@ static inline void cleanup_rng(struct kref *kref)
 
 	if (rng->cleanup)
 		rng->cleanup(rng);
+	wake_up_all(&rng_done);
 }
 
 static void set_current_rng(struct hwrng *rng)
-- 
1.9.3
