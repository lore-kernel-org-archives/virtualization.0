From: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] x86 spinlock: Fix memory corruption on completing
	completions
Date: Fri, 06 Feb 2015 11:42:44 -0800
Message-ID: <1423251764.1057.1.camel__47764.4669743769$1423251966$gmane$org@stgolabs.net>
References: <1423234148-13886-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<CA+55aFwZOgiUe5Zm=o24d6SshvoLbF1bq_VT0hdijR1hfoyi4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CA+55aFwZOgiUe5Zm=o24d6SshvoLbF1bq_VT0hdijR1hfoyi4A@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, KVM list <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Anvin <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Andrey Ryabinin <a.ryabinin@samsung.com>, the arch/x86 maintainers <x86@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Sasha Levin <sasha.levin@oracle.com>, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization <virtualization@lists.linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Oleg Nesterov <oleg@redhat.co>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2015-02-06 at 08:25 -0800, Linus Torvalds wrote:
> On Fri, Feb 6, 2015 at 6:49 AM, Raghavendra K T
> <raghavendra.kt@linux.vnet.ibm.com> wrote:
> > Paravirt spinlock clears slowpath flag after doing unlock.
> [ fix edited out ]
> 
> So I'm not going to be applying this for 3.19, because it's much too
> late and the patch is too scary. Plus the bug probably effectively
> never shows up in real life (it is probably easy to trigger the
> speculative *read* but probably never the actual speculative write
> after dropping the lock last).
> 
> This will need a lot of testing by the paravirt people - both
> performance and correctness. So *maybe* for 3.20, but maybe for even
> later, and then marked for stable, of course.
> 
> Are there any good paravirt stress-tests that people could run for
> extended times?

locktorture inside a VM should give a proper pounding.
