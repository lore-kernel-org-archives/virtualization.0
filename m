From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 5/6] pv-qspinlock: use cmpxchg_release in
	__pv_queued_spin_unlock
Date: Thu, 26 May 2016 18:57:12 +0200
Message-ID: <20160526165712.GT3205@twins.programming.kicks-ass.net>
References: <1464164289-6124-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1464164289-6124-6-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20160526164729.GL3206@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160526164729.GL3206@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: jeremy@goop.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, paulus@samba.org, benh@kernel.crashing.org, akataria@vmware.com, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 26, 2016 at 06:47:29PM +0200, Peter Zijlstra wrote:
> On Wed, May 25, 2016 at 04:18:08PM +0800, Pan Xinhui wrote:
> > cmpxchg_release is light-wight than cmpxchg, we can gain a better
> > performace then. On some arch like ppc, barrier impact the performace
> > too much.
> > 
> > Suggested-by:  Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> > ---
> >  kernel/locking/qspinlock_paravirt.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
> > index a5b1248..2bbffe4 100644
> > --- a/kernel/locking/qspinlock_paravirt.h
> > +++ b/kernel/locking/qspinlock_paravirt.h
> > @@ -614,7 +614,7 @@ __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
> >  	 * unhash. Otherwise it would be possible to have multiple @lock
> >  	 * entries, which would be BAD.
> >  	 */
> > -	locked = cmpxchg(&l->locked, _Q_LOCKED_VAL, 0);
> > +	locked = cmpxchg_release(&l->locked, _Q_LOCKED_VAL, 0);
> >  	if (likely(locked == _Q_LOCKED_VAL))
> >  		return;
> 
> This patch fails to explain _why_ it can be relaxed.
> 
> And seeing how this cmpxchg() can actually unlock the lock, I don't see
> how this can possibly be correct. Maybe cmpxchg_release(), but relaxed
> seems very wrong.

Clearly I need to stop working for the day, I cannea read. You're doing
release, not relaxed.

Still Changelog needs improvement.
