From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC V6 0/11] Paravirtualized ticketlocks
Date: Sat, 31 Mar 2012 01:04:41 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1203310044580.2542@ionos>
References: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
	<4F7616F5.4070000@zytor.com>
	<alpine.LFD.2.02.1203302333560.2542@ionos>
	<20120330221836.GN17822@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120330221836.GN17822@one.firstfloor.org>
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
Cc: the arch/x86 maintainers <x86@kernel.org>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Xen Devel <xen-devel@lists.xensource.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Avi Kivity <avi@redhat.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, Attilio Rao <attilio.rao@citrix.com>, Ingo Molnar <mingo@elte.hu>, Virtualization <virtualization@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 31 Mar 2012, Andi Kleen wrote:

> > So if a guest exits due to an external event it's easy to inspect the
> > state of that guest and avoid to schedule away when it was interrupted
> > in a spinlock held section. That guest/host shared state needs to be
> 
> On a large system under high contention sleeping can perform surprisingly
> well. pthread mutexes have a tendency to beat kernel spinlocks there.
> So avoiding sleeping locks completely (that is what pv locks are
> essentially) is not necessarily that good.

Care to back that up with numbers and proper trace evidence instead of
handwaving?

I've stared at RT traces and throughput problems on _LARGE_ machines
long enough to know what I'm talking about and I can provide evidence
in a split second.

> Your proposal is probably only a good idea on low contention
> and relatively small systems.

Sigh, you have really no fcking clue what you are talking about.

On RT we observed scalabilty problems way before hardware was
available to expose them. So what's your point?

Put up or shut up, really!

    tglx
