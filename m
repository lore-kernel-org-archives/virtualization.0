From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: GET_RNG_SEED hypercall ABI? (Re: [PATCH v5 0/5] random,x86,kvm:
	Rework arch RNG seeds and get some from kvm)
Date: Wed, 27 Aug 2014 00:07:32 -0700
Message-ID: <53FD83B4.1030507@zytor.com>
References: <CALCETrV5U61C-gkikZtddd5RtZWFVRpkjVk69B+ymvy=xauLaQ@mail.gmail.com>
	<53FD81F5.6030701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53FD81F5.6030701@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@amacapital.net>
Cc: X86 ML <x86@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Gleb Natapov <gleb@kernel.org>, Andrew Honig <ahonig@google.com>, Haiyang Zhang <haiyangz@microsoft.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Daniel Borkmann <dborkman@redhat.com>, Bandan Das <bsd@redhat.com>, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/27/2014 12:00 AM, Paolo Bonzini wrote:
> Il 27/08/2014 01:58, Andy Lutomirski ha scritto:
>> hpa pointed out that the ABI that I chose (an MSR from the KVM range
>> and a KVM cpuid bit) is unnecessarily KVM-specific.  It would be nice
>> to allocate an MSR that everyone involved can agree on and, rather
>> than relying on a cpuid bit, just have the guest probe for the MSR.
>>
>> This leads to a few questions:
>>
>> 1. How do we allocate an MSR?  (For background, this would be an MSR
>> that either returns 64 bits of best-effort cryptographically secure
>> random data or fails with #GP.)
> 
> Ask Intel? :)

I'm going to poke around internally.  Intel might as a matter of policy
be reluctant to assign an MSR index specifically for software use, but
I'll try to find out.

	-hpa
