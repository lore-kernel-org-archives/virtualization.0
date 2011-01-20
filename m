From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 2/3] kvm hypervisor : Add hypercalls to support
	pv-ticketlock
Date: Thu, 20 Jan 2011 09:56:27 -0800
Message-ID: <4D38774B.6070704__26824.4915911511$1295546269$gmane$org@goop.org>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<20110119164432.GA30669@linux.vnet.ibm.com>
	<20110119171239.GB726@linux.vnet.ibm.com>
	<1295457672.28776.144.camel@laptop> <4D373340.60608@goop.org>
	<20110120115958.GB11177@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110120115958.GB11177@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: vatsa@linux.vnet.ibm.com
Cc: Xen-devel <xen-devel@lists.xensource.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Eric Dumazet <dada1@cosmosbay.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, suzuki@in.ibm.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, =?ISO-8859-1?Q?Am=E9rico_Wang?= <xiyou.wangcong@gmail.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 01/20/2011 03:59 AM, Srivatsa Vaddagiri wrote:
>> At least in the Xen code, a current owner isn't very useful, because we
>> need the current owner to kick the *next* owner to life at release time,
>> which we can't do without some structure recording which ticket belongs
>> to which cpu.
> If we had a yield-to [1] sort of interface _and_ information on which vcpu
> owns a lock, then lock-spinners can yield-to the owning vcpu, while the
> unlocking vcpu can yield-to the next-vcpu-in-waiting.

Perhaps, but the core problem is how to find "next-vcpu-in-waiting"
efficiently.  Once you have that info, there's a number of things you
can usefully do with it.

>  The key here is not to
> sleep when waiting for locks (as implemented by current patch-series, which can 
> put other VMs at an advantage by giving them more time than they are entitled 
> to)

Why?  If a VCPU can't make progress because its waiting for some
resource, then why not schedule something else instead?  Presumably when
the VCPU does become runnable, the scheduler will credit its previous
blocked state and let it run in preference to something else.

>  and also to ensure that lock-owner as well as the next-in-line lock-owner 
> are not unduly made to wait for cpu. 
>
> Is there a way we can dynamically expand the size of lock only upon contention
> to include additional information like owning vcpu? Have the lock point to a
> per-cpu area upon contention where additional details can be stored perhaps?

As soon as you add a pointer to the lock, you're increasing its size. 
If we had a pointer in there already, then all of this would be moot.

If auxiliary per-lock is uncommon, then using a hash keyed on lock
address would be one way to do it.

    J
