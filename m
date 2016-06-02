From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v5 5/6] pv-qspinlock: use cmpxchg_release in
	__pv_queued_spin_unlock
Date: Thu,  2 Jun 2016 17:26:29 +0800
Message-ID: <1464859590-5292-7-git-send-email-xinhui.pan__5505.57106403193$1464859726$gmane$org@linux.vnet.ibm.com>
References: <1464859590-5292-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1464859590-5292-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org
Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, peterz@infradead.org, benh@kernel.crashing.org, waiman.long@hpe.com, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, paulmck@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

cmpxchg_release is light-wight than cmpxchg, On some arch like ppc,
barrier impact the performace too much.

Suggested-by:  Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 kernel/locking/qspinlock_paravirt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index a5b1248..2bbffe4 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -614,7 +614,7 @@ __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
 	 * unhash. Otherwise it would be possible to have multiple @lock
 	 * entries, which would be BAD.
 	 */
-	locked = cmpxchg(&l->locked, _Q_LOCKED_VAL, 0);
+	locked = cmpxchg_release(&l->locked, _Q_LOCKED_VAL, 0);
 	if (likely(locked == _Q_LOCKED_VAL))
 		return;
 
-- 
2.4.11
