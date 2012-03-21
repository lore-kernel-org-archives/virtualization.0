From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC V6 2/11] x86/ticketlock: don't inline _spin_unlock
	when using paravirt spinlocks
Date: Wed, 21 Mar 2012 10:13:04 -0700
Message-ID: <CA+55aFzJn_U=2-kxGX15v6zLaCV+Jgtxjop2PudizzsqSn+nLg@mail.gmail.com>
References: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
	<20120321102107.473.89777.sendpatchset@codeblue.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120321102107.473.89777.sendpatchset@codeblue.in.ibm.com>
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
Cc: KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Virtualization <virtualization@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Avi Kivity <avi@redhat.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, Attilio Rao <attilio.rao@citrix.com>, Ingo Molnar <mingo@elte.hu>, Xen Devel <xen-devel@lists.xensource.com>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 21, 2012 at 3:21 AM, Raghavendra K T
<raghavendra.kt@linux.vnet.ibm.com> wrote:
> From: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
>
> The code size expands somewhat, and its probably better to just call
> a function rather than inline it.
>
> Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> ---
> =A0arch/x86/Kconfig =A0 =A0 | =A0 =A03 +++
> =A0kernel/Kconfig.locks | =A0 =A02 +-
> =A02 files changed, 4 insertions(+), 1 deletions(-)
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5bed94e..10c28ec 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -623,6 +623,9 @@ config PARAVIRT_SPINLOCKS
>
> =A0 =A0 =A0 =A0 =A0If you are unsure how to answer this question, answer =
N.
>
> +config ARCH_NOINLINE_SPIN_UNLOCK
> + =A0 =A0 =A0 def_bool PARAVIRT_SPINLOCKS
> +
> =A0config PARAVIRT_CLOCK
> =A0 =A0 =A0 =A0bool
>
> diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
> index 5068e2a..584637b 100644
> --- a/kernel/Kconfig.locks
> +++ b/kernel/Kconfig.locks
> @@ -125,7 +125,7 @@ config INLINE_SPIN_LOCK_IRQSAVE
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARCH_INLINE_SPIN_LOCK_IRQSAVE
>
> =A0config INLINE_SPIN_UNLOCK
> - =A0 =A0 =A0 def_bool !DEBUG_SPINLOCK && (!PREEMPT || ARCH_INLINE_SPIN_U=
NLOCK)
> + =A0 =A0 =A0 def_bool !DEBUG_SPINLOCK && (!PREEMPT || ARCH_INLINE_SPIN_U=
NLOCK) && !ARCH_NOINLINE_SPIN_UNLOCK
>
> =A0config INLINE_SPIN_UNLOCK_BH
> =A0 =A0 =A0 =A0def_bool !DEBUG_SPINLOCK && ARCH_INLINE_SPIN_UNLOCK_BH

Ugh. This is getting really ugly.

Can we just fix it by
 - getting rid of INLINE_SPIN_UNLOCK entirely

 - replacing it with UNINLINE_SPIN_UNLOCK instead with the reverse
meaning, and no "def_bool" at all, just a simple

        config UNINLINE_SPIN_UNLOCK
                bool

 - make the various people who want to uninline the spinlocks (like
spinlock debugging, paravirt etc) all just do

        select UNINLINE_SPIN_UNLOCK

because quite frankly, the whole spinunlock inlining logic is
*already* unreadable, and you just made it worse.

                      Linus
