From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: GET_RNG_SEED hypercall ABI? (Re: [PATCH v5 0/5] random,x86,kvm:
	Rework arch RNG seeds and get some from kvm)
Date: Thu, 28 Aug 2014 09:22:54 -0700
Message-ID: <CALCETrXDygWbKwPNux=qEbqVCCk28Lu7q+gJte=6ZwpCNsbd8w@mail.gmail.com>
References: <CALCETrV5U61C-gkikZtddd5RtZWFVRpkjVk69B+ymvy=xauLaQ@mail.gmail.com>
	<20140828141704.GI18167@minantech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140828141704.GI18167@minantech.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@kernel.org>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Theodore Ts'o <tytso@mit.edu>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Bandan Das <bsd@redhat.com>, Andrew Honig <ahonig@google.com>, Haiyang Zhang <haiyangz@microsoft.com>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Daniel Borkmann <dborkman@redhat.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Aug 28, 2014 7:17 AM, "Gleb Natapov" <gleb@kernel.org> wrote:
>
> On Tue, Aug 26, 2014 at 04:58:34PM -0700, Andy Lutomirski wrote:
> > hpa pointed out that the ABI that I chose (an MSR from the KVM range
> > and a KVM cpuid bit) is unnecessarily KVM-specific.  It would be nice
> > to allocate an MSR that everyone involved can agree on and, rather
> > than relying on a cpuid bit, just have the guest probe for the MSR.
> >
> CPUID part allows feature to be disabled for machine compatibility purpose
> during migration. Of course interface can explicitly state that one successful
> use of the MSR does not mean that next use will not result in a #GP, but that
> doesn't sound very elegant and is different from any other MSR out there.
>

Is there a non-cpuid interface between QEMU and KVM for this?

AFAICT, even turning off cpuid bits for things like async pf doesn't
actually disable the MSRs (which is arguably an attack surface issue).

--Andy

> --
>                         Gleb.
