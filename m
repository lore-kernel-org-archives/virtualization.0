From: Amos Kong <akong@redhat.com>
Subject: [PATCH v2 2/3] hw_random: fix stuck in catting hwrng attributes
Date: Tue, 16 Sep 2014 00:02:28 +0800
Message-ID: <1410796949-2221-3-git-send-email-akong@redhat.com>
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

I started a QEMU (non-smp) guest with one virtio-rng device, and read
random data from /dev/hwrng by dd:

 # dd if=/dev/hwrng of=/dev/null &

In the same time, if I check hwrng attributes from sysfs by cat:

 # cat /sys/class/misc/hw_random/rng_*

The cat process always gets stuck with slow backend (5 k/s), if we
use a quick backend (1.2 M/s), the cat process will cost 1 to 2
minutes. The stuck doesn't exist for smp guest.

Reading syscall enters kernel and call rng_dev_read(), it's user
context. We used need_resched() to check if other tasks need to
be run, but it almost always return false, and re-hold the mutex
lock. The attributes accessing process always fails to hold the
lock, so the cat gets stuck.

User context doesn't allow other user contexts run on that CPU,
unless the kernel code sleeps for some reason. This is why the
need_reshed() always return false here.

This patch removed need_resched() and always schedule other tasks
then other tasks can have chance to hold the lock and execute
protected code.

Signed-off-by: Amos Kong <akong@redhat.com>
---
 drivers/char/hw_random/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index c591d7e..263a370 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -195,8 +195,7 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 
 		mutex_unlock(&rng_mutex);
 
-		if (need_resched())
-			schedule_timeout_interruptible(1);
+		schedule_timeout_interruptible(1);
 
 		if (signal_pending(current)) {
 			err = -ERESTARTSYS;
-- 
1.9.3
