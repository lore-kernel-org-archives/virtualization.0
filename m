From: Amos Kong <akong@redhat.com>
Subject: [PATCH v2 0/3] fix stuck in accessing hwrng attributes
Date: Tue, 16 Sep 2014 00:02:26 +0800
Message-ID: <1410796949-2221-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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

If we read hwrng by long-running dd process, it takes too much cpu
time and almost hold the mutex lock. When we check hwrng attributes
from sysfs by cat, it gets stuck in waiting the lock releaseing.
The problem can only be reproduced with non-smp guest with slow backend.

This patchset resolves the issue by changing rng_dev_read() to always
schedule 10 jiffies after release mutex lock, then cat process can
have chance to get the lock and execute protected code without stuck.

Thanks.

V2: update commitlog to describe PATCH 2, split second patch.

Amos Kong (3):
  virtio-rng cleanup: move some code out of mutex protection
  hw_random: fix stuck in catting hwrng attributes
  hw_random: increase schedule timeout in rng_dev_read()

 drivers/char/hw_random/core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
1.9.3
