From: Amos Kong <akong@redhat.com>
Subject: [PATCH v2 3/3] hw_random: increase schedule timeout in rng_dev_read()
Date: Tue, 16 Sep 2014 00:02:29 +0800
Message-ID: <1410796949-2221-4-git-send-email-akong__23432.9473031268$1410797073$gmane$org@redhat.com>
References: <1410796949-2221-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1410796949-2221-1-git-send-email-akong@redhat.com>
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
Cc: herbert@gondor.apana.org.au, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, m@bues.ch, mpm@selenic.com, amit.shah@redhat.com, mb@bu3sch.de
List-Id: virtualization@lists.linuxfoundation.org

This patch increases the schedule timeout to 10 jiffies, it's more
appropriate, then other takes can easy to hold the mutex lock.

Signed-off-by: Amos Kong <akong@redhat.com>
---
 drivers/char/hw_random/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 263a370..b5d1b6f 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -195,7 +195,7 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 
 		mutex_unlock(&rng_mutex);
 
-		schedule_timeout_interruptible(1);
+		schedule_timeout_interruptible(10);
 
 		if (signal_pending(current)) {
 			err = -ERESTARTSYS;
-- 
1.9.3
