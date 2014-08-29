From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: GET_RNG_SEED hypercall ABI? (Re: [PATCH v5 0/5] random,x86,kvm:
	Rework arch RNG seeds and get some from kvm)
Date: Fri, 29 Aug 2014 08:36:47 +0200
Message-ID: <54001F7F.5030206@redhat.com>
References: <CALCETrV5U61C-gkikZtddd5RtZWFVRpkjVk69B+ymvy=xauLaQ@mail.gmail.com>
	<20140828141704.GI18167@minantech.com>
	<CALCETrXDygWbKwPNux=qEbqVCCk28Lu7q+gJte=6ZwpCNsbd8w@mail.gmail.com>
	<53FF8722.6080302@redhat.com>
	<CALCETrVW3ZQ7C6F4tab+UrUy=bX4UepPPrhVNrDtLx=ckz2EpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrVW3ZQ7C6F4tab+UrUy=bX4UepPPrhVNrDtLx=ckz2EpA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: X86 ML <x86@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Gleb Natapov <gleb@kernel.org>, Andrew Honig <ahonig@google.com>, Haiyang Zhang <haiyangz@microsoft.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Daniel Borkmann <dborkman@redhat.com>, Bandan Das <bsd@redhat.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Alok Kataria <akataria@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 29/08/2014 02:13, Andy Lutomirski ha scritto:
> Hmm.  Then, assuming that someone manages to allocate a
> cross-hypervisor MSR number for this, what am I supposed to do in the
> KVM code?  Just make it available unconditionally?  I don't see why
> that wouldn't work reliably, but it seems like an odd design.

The odd part of it is what Gleb mentioned.

> Also, the one and only native feature flag I tested (rdtscp) actually
> does work: RDTSCP seems to send #UD if QEMU is passed -cpu
> host,-rdtscp.

True, and I'm not sure why.  There are a couple others.  I was thinking
more of things like SSE, AVX or DE (that affects the availability of a
bit in CR4).

Paolo
