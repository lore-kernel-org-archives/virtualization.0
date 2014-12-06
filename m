From: Amos Kong <akong@redhat.com>
Subject: [PATCH v5 2/6] hw_random: move some code out mutex_lock for avoiding
	underlying deadlock
Date: Sat,  6 Dec 2014 12:16:38 +0800
Message-ID: <1417839402-13490-3-git-send-email-akong@redhat.com>
References: <1417839402-13490-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417839402-13490-1-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, rusty@rustcorp.com.au
Cc: herbert@gondor.apana.org.au, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, m@bues.ch, mpm@selenic.com, amit.shah@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

In next patch, we use reference counting for each struct hwrng,
changing reference count also needs to take mutex_lock. Before
releasing the lock, if we try to stop a kthread that waits to
take the lock to reduce the referencing count, deadlock will
occur.

Signed-off-by: Amos Kong <akong@redhat.com>
---
 drivers/char/hw_random/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index b1b6042..a0905c8 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -474,12 +474,12 @@ void hwrng_unregister(struct hwrng *rng)
 		}
 	}
 	if (list_empty(&rng_list)) {
+		mutex_unlock(&rng_mutex);
 		unregister_miscdev();
 		if (hwrng_fill)
 			kthread_stop(hwrng_fill);
-	}
-
-	mutex_unlock(&rng_mutex);
+	} else
+		mutex_unlock(&rng_mutex);
 }
 EXPORT_SYMBOL_GPL(hwrng_unregister);
 
-- 
1.9.3
