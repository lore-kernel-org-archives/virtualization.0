From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH RFC V9 0/19] Paravirtualized ticket spinlocks
Date: Sat, 1 Jun 2013 22:46:15 +0200
Message-ID: <20130601204615.GQ6123@two.firstfloor.org>
References: <20130601082145.22955.33596.sendpatchset@codeblue>
	<20130601201442.GP6123@two.firstfloor.org>
	<51AA5950.6050603@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51AA5950.6050603@goop.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: x86@kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, hpa@zytor.com, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, kvm@vger.kernel.org, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, gregkh@suse.de, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org, stephan.diestelhorst@amd.com
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jun 01, 2013 at 01:28:00PM -0700, Jeremy Fitzhardinge wrote:
> On 06/01/2013 01:14 PM, Andi Kleen wrote:
> > FWIW I use the paravirt spinlock ops for adding lock elision
> > to the spinlocks.
> 
> Does lock elision still use the ticketlock algorithm/structure, or are
> they different?  If they're still basically ticketlocks, then it seems
> to me that they're complimentary - hle handles the fastpath, and pv the
> slowpath.

It uses the ticketlock algorithm/structure, but:

- it needs to know that the lock is free with an own operation
- it has an additional field for strong adaptation state
(but that field is independent of the low level lock implementation,
so can be used with any kind of lock)

So currently it inlines the ticket lock code into its own.

Doing pv on the slow path would be possible, but would need
some additional (minor) hooks I think.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
