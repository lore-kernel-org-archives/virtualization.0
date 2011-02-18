From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Subject: Re: [PATCH 13/14] x86/ticketlock: add slowpath logic
Date: Fri, 18 Feb 2011 22:33:46 +0530
Message-ID: <20110218170346.GA30264__7872.15845562077$1298058110$gmane$org@linux.vnet.ibm.com>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<97ed99ae9160bdb6477284b333bd6708fb7a19cb.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<20110117152222.GA19233@linux.vnet.ibm.com>
	<20110119162348.GA29900@linux.vnet.ibm.com>
	<4D3DF5A5.7070301@goop.org>
Reply-To: vatsa@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4D3DF5A5.7070301@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <peterz@infradead.org>, vsrivatsa@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Eric Dumazet <dada1@cosmosbay.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, suzuki@in.ibm.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, =?iso-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> On Mon, Jan 24, 2011 at 01:56:53PM -0800, Jeremy Fitzhardinge wrote:

For some reason, I seem to be missing emails from your id/domain and hence had
missed this completely!

> >   * bits.  However, we need to be careful about this because someone
> >   * may just be entering as we leave, and enter the slowpath.
> >   */
> > -void __ticket_unlock_release_slowpath(struct arch_spinlock *lock)
> > +void __ticket_unlock_slowpath(struct arch_spinlock *lock)
> >  {
> >  	struct arch_spinlock old, new;
> >  
> >  	BUILD_BUG_ON(((__ticket_t)NR_CPUS) != NR_CPUS);
> >  
> >  	old = ACCESS_ONCE(*lock);
> > -
> >  	new = old;
> > -	new.tickets.head += TICKET_LOCK_INC;
> >  
> >  	/* Clear the slowpath flag */
> >  	new.tickets.tail &= ~TICKET_SLOWPATH_FLAG;
> > +	if (new.tickets.head == new.tickets.tail)
> > +		cmpxchg(&lock->head_tail, old.head_tail, new.head_tail);
> >  
> > -	/*
> > -	 * If there's currently people waiting or someone snuck in
> > -	 * since we read the lock above, then do a normal unlock and
> > -	 * kick.  If we managed to unlock with no queued waiters, then
> > -	 * we can clear the slowpath flag.
> > -	 */
> > -	if (new.tickets.head != new.tickets.tail ||
> > -	    cmpxchg(&lock->head_tail,
> > -		    old.head_tail, new.head_tail) != old.head_tail) {
> > -		/* still people waiting */
> > -		__ticket_unlock_release(lock);
> > -	}
> > -
> > +	/* Wake up an appropriate waiter */
> >  	__ticket_unlock_kick(lock, new.tickets.head);
> 
> Does the __ticket_unlock_kick need to be unconditional?

I recall having tried optimizing it to be conditional, something along these
lines:

	if (new.ticket.head == new.tickets.tail) {
		cmpxchg();	
	} else {
		__ticket_unlock_kick(lock, new.tickets.head);
	}

but it didn't work for some reason. I left the call unconditional as was the
case previously based on that experiment.

- vatsa
