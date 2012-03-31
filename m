From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH RFC V6 0/11] Paravirtualized ticketlocks
Date: Sat, 31 Mar 2012 02:08:43 +0200
Message-ID: <20120331000843.GO17822@one.firstfloor.org>
References: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
	<4F7616F5.4070000@zytor.com>
	<alpine.LFD.2.02.1203302333560.2542@ionos>
	<20120330221836.GN17822@one.firstfloor.org>
	<alpine.LFD.2.02.1203310044580.2542@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1203310044580.2542@ionos>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: the arch/x86 maintainers <x86@kernel.org>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Avi Kivity <avi@redhat.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, Attilio Rao <attilio.rao@citrix.com>, Ingo Molnar <mingo@elte.hu>, Virtualization <virtualization@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Xen Devel <xen-devel@lists.xensource.com>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Mar 31, 2012 at 01:04:41AM +0200, Thomas "Kubys" Gleixner wrote:
> On Sat, 31 Mar 2012, Andi Kleen wrote:
> 
> > > So if a guest exits due to an external event it's easy to inspect the
> > > state of that guest and avoid to schedule away when it was interrupted
> > > in a spinlock held section. That guest/host shared state needs to be
> > 
> > On a large system under high contention sleeping can perform surprisingly
> > well. pthread mutexes have a tendency to beat kernel spinlocks there.
> > So avoiding sleeping locks completely (that is what pv locks are
> > essentially) is not necessarily that good.
> 
> Care to back that up with numbers and proper trace evidence instead of
> handwaving?

E.g. my plumbers presentations on lock and mm scalability from last year has some 
graphs that show this very clearly, plus some additional data on the mutexes. 
This compares to the glibc futex locks, which perform much better than the kernel 
mutex locks on larger systems under higher contention

Given your tone I will not supply an URL. I'm sure you can find it if you
need it.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
