From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] paravirt/locks: use new static key for
	controlling call of virt_spin_lock()
Date: Wed, 6 Sep 2017 18:04:15 +0200
Message-ID: <20170906160415.crt2ajuf6553bit7@hirez.programming.kicks-ass.net>
References: <20170906152928.8658-1-jgross@suse.com>
	<20170906152928.8658-2-jgross@suse.com>
	<a0cf01cf-922a-dbc7-949e-0f87bcdd1ad9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <a0cf01cf-922a-dbc7-949e-0f87bcdd1ad9@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <longman@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, xen-devel@lists.xenproject.org, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 06, 2017 at 11:49:49AM -0400, Waiman Long wrote:
> >  #define virt_spin_lock virt_spin_lock
> >  static inline bool virt_spin_lock(struct qspinlock *lock)
> >  {
> > +	if (!static_branch_likely(&virt_spin_lock_key))
> > +		return false;
> >  	if (!static_cpu_has(X86_FEATURE_HYPERVISOR))
> >  		return false;
> >  

Now native has two NOPs instead of one. Can't we merge these two static
branches?
