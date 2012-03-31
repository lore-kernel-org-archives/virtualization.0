From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH RFC V6 0/11] Paravirtualized ticketlocks
Date: Sat, 31 Mar 2012 10:11:52 +0200
Message-ID: <20120331081152.GB15958__47631.7140776247$1333381149$gmane$org@gmail.com>
References: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
	<4F7616F5.4070000@zytor.com>
	<alpine.LFD.2.02.1203302333560.2542@ionos>
	<20120330221836.GN17822@one.firstfloor.org>
	<alpine.LFD.2.02.1203310044580.2542@ionos>
	<20120331000843.GO17822@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120331000843.GO17822@one.firstfloor.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: the arch/x86 maintainers <x86@kernel.org>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Xen Devel <xen-devel@lists.xensource.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Avi Kivity <avi@redhat.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, Attilio Rao <attilio.rao@citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Virtualization <virtualization@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org


* Andi Kleen <andi@firstfloor.org> wrote:

> > Care to back that up with numbers and proper trace evidence 
> > instead of handwaving?
> 
> E.g. my plumbers presentations on lock and mm scalability from 
> last year has some graphs that show this very clearly, plus 
> some additional data on the mutexes. This compares to the 
> glibc futex locks, which perform much better than the kernel 
> mutex locks on larger systems under higher contention

If you mean these draft slides:

  http://www.halobates.de/plumbers-fork-locks_v2.pdf

it has very little verifiable information in it. It just 
cryptically says lock hold time "microbenchmark", which might or 
might not be a valid measurement.

You could have been honest and straightforward in your first 
mail:

 "I ran workload X on machine Y, and got results Z."

Instead you are *hindering* the discussion:

> Given your tone I will not supply an URL. [...]

If you meant the above URL then it's not the proper numbers 
Thomas asked for, just some vague slides. If you meant something 
else then put up or shut up.

Thanks,

	Ingo
