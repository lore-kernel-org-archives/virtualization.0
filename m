From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 18/19] move _set_gate and its users to a common location
Date: Sat, 22 Dec 2007 03:07:00 +0100
Message-ID: <20071222020700.GA7966__1407.05389571867$1198289694$gmane$org@elte.hu>
References: <11975543592701-git-send-email-gcosta@redhat.com>
	<11975543641360-git-send-email-gcosta@redhat.com>
	<11975543691134-git-send-email-gcosta@redhat.com>
	<11975543742848-git-send-email-gcosta@redhat.com>
	<11975543792334-git-send-email-gcosta@redhat.com>
	<11975543843977-git-send-email-gcosta@redhat.com>
	<11975543892403-git-send-email-gcosta@redhat.com>
	<11975543942657-git-send-email-gcosta@redhat.com>
	<1197554399402-git-send-email-gcosta@redhat.com>
	<1197554404337-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1197554404337-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* Glauber de Oliveira Costa <gcosta@redhat.com> wrote:

> This patch moves _set_gate and its users to desc.h. We can now use 
> common code for x86_64 and i386.

a few days ago i started seeing weird crashes on 64-bit x86 in the 
random-kernel-bootup tests. Nothing truly reproducable to be bisectable, 
but quality of x86.git went down drastically. Double faults, triple 
faults, crashes all around the place, with every few dozen kernel 
bootups.

Today i found a config and a workload that triggered the crashes a bit 
more reliably. I still needed a 6 hours bisection marathon to pinpoint 
the patch - the one in this thread. A review of it with H. Peter Anvin 
pinpointed the breakage:

> +static inline void set_system_gate(unsigned int n, void *addr)
> +{
> +	BUG_ON((unsigned)n > 0xFF);
> +	_set_gate(n, GATE_TRAP, addr, 0x3, 0, __KERNEL_CS);
> +}

> -static inline void set_system_gate(int nr, void *func)
> -{
> -	BUG_ON((unsigned)nr > 0xFF);
> -	_set_gate(nr, GATE_INTERRUPT, (unsigned long) func, 3, 0);
> -}

you changed the type of system gates on 64-bit from GATE_INTERRUPT to 
GATE_TRAP. The effect of this is that these gates enter with interrupts 
enabled - instead of interrupts disabled. This, amongst others, affects 
the following key gate:

        set_system_gate(IA32_SYSCALL_VECTOR, ia32_syscall);

which relies on disabled interrupts to fix up its stack. If an interrupt 
comes in the wrong moment then we get a kernel stack corruption that is 
not survivable.

the reason for this bug was that you tried to do too many changes in a 
single patch. You did a cleanup, you did unification and you moved code 
around. It was totally non-obvious what you did and the resulting patch 
was not reviewable at all - even after the bisection poinpointed the 
patch, it took us almost 30 minutes to figure out where the bug was. If 
this unstructured, careless mess of patches continues then we are not 
going to be able to accept any more 64-bit paravirt patches into 
x86.git.

	Ingo
