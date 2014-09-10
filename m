From: Amos Kong <akong@redhat.com>
Subject: [PATCH 0/2] fix stuck in catting hwrng attributes
Date: Wed, 10 Sep 2014 17:07:05 +0800
Message-ID: <1410340027-15373-1-git-send-email-akong@redhat.com>
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
Cc: amit.shah@redhat.com, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

If we read hwrng by long-running dd process, it takes too much cpu time.
When we check hwrng attributes from sysfs by cat, it gets stuck.
The problem can only be reproduced with non-smp guest with slow backend.

This patchset changed hwrng core to always delay 10 jiffies, cat process
have chance to execute protected code, the problem is resolved.

Thanks.

Amos Kong (2):
  virtio-rng cleanup: move some code out of mutex protection
  virtio-rng: fix stuck in catting hwrng attributes

 drivers/char/hw_random/core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
1.9.3
