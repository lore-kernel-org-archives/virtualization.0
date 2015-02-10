From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [PATCH] x86 spinlock: Fix memory corruption on completing
	completions
Date: Tue, 10 Feb 2015 14:20:24 +0100
Message-ID: <CAK1hOcOC980BL7jT_PudPNMx1Vc2t-Li68K5hBnuFKaAZi2PfQ@mail.gmail.com>
References: <1423234148-13886-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<54D7D19B.1000103@goop.org> <54D87F1E.9060307@linux.vnet.ibm.com>
	<20150209120227.GT21418@twins.programming.kicks-ass.net>
	<CA+55aFympdPOotzEgdhQULidN+nxb-VUdfym+qU9LOsHScvpzw@mail.gmail.com>
	<54D9CFC7.5020007@linux.vnet.ibm.com>
	<CAK1hOcNZ+hfjt=CmtZumPoFQRdQbf9SSEF0cOWv9-9ku0K7bcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAK1hOcNZ+hfjt=CmtZumPoFQRdQbf9SSEF0cOWv9-9ku0K7bcg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, KVM list <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, virtualization <virtualization@lists.linux-foundation.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Anvin <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Andrey Ryabinin <a.ryabinin@samsung.com>, the arch/x86 maintainers <x86@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Sasha Levin <sasha.levin@oracle.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andi Kleen <ak@linux.intel.com>, xen-devel <xen-devel@lists.xenproject.org>, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Waiman Long <waiman.long@hp.com>, Oleg Nesterov <oleg@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 10, 2015 at 2:18 PM, Denys Vlasenko
<vda.linux@googlemail.com> wrote:
>         while (1) {
>             if (READ_ONCE(lock->tickets.head) != TICKET_TAIL(val))
>                 cpu_relax();
>         }

Doh.... should be

         while (READ_ONCE(lock->tickets.head) != TICKET_TAIL(val)
             cpu_relax();
