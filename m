From: Ahmed Soliman <ahmedsoliman0x666@gmail.com>
Subject: Re: [PATCH 3/3] [RFC V3] KVM: X86: Adding skeleton for Memory ROE
Date: Fri, 20 Jul 2018 02:26:46 +0200
Message-ID: <CAAGnT3aQhvHJ4H1vaTYiYotN022wh1if76=xywTVGqA5o_UQrA@mail.gmail.com>
References: <20180719213802.17161-1-ahmedsoliman0x666@gmail.com>
	<20180719213802.17161-4-ahmedsoliman0x666@gmail.com>
	<CAG48ez3EyU=ROBczUdHEuOYBtZghYqOpq3K16Bs4RQLO1OO6oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAG48ez3EyU=ROBczUdHEuOYBtZghYqOpq3K16Bs4RQLO1OO6oA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jann Horn <jannh@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, David Vrabel <david.vrabel@nutanix.com>, the arch/x86 maintainers <x86@kernel.org>, Boris Lukashev <blukashev@sempervictus.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, nigel.edwards@hpe.com, "H . Peter Anvin" <hpa@zytor.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@surriel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 20 July 2018 at 00:59, Jann Horn <jannh@google.com> wrote:
> On Thu, Jul 19, 2018 at 11:40 PM Ahmed Abd El Mawgood

> Why are you implementing this in the kernel, instead of doing it in
> host userspace?

I thought about implementing it completely in QEMU but It won't be
possible for few reasons:

- After talking to QEMU folks I came up to conclusion that it when it
 comes to managing memory allocated for guest, it is always better to let
 KVM handles everything, unless there is a good reason to play with that
 memory chunk inside QEMU itself.
- But actually there is a good reason for implementing ROE in kernel space,
 it is that ROE is architecture dependent to great extent. I should have
 emphasized that the only currently supported architecture is X86. I am
 not sure how deep the dependency on architecture goes. But as for now
 the current set of patches does a SPTE enumeration as part of the process.
 To my best knowledge, this isn't exposed outside arch/x68/kvm let alone
 having a host user space interface for it. Also the way I am planning to
 protect TLB from malicious gva -> gpa mapping is by knowing that in x86
 it is possible to VMEXIT on page faults, I am not sure if it will safe to
 assume that all kvm supported architectures will behave this way.

For these reasons I thought it will be better if arch dependent stuff (the
mechanism implementation) is kept in arch/*/kvm folder and with minimal
modifications to virt/kvm/* after setting a kconfig variable to enable ROE.
But I left room for the user space app using kvm to decide the rightful policy
for handling ROE violations. The way it works by KVM_EXIT_MMIO error to user
space, keeping all the architectural details hidden away from user space.

A last note is that I didn't create this from scratch, instead I extended
KVM_MEM_READONLY implementation to also allow R/O per page instead
R/O per whole slot which is already done in kernel space.
