From: Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
Subject: Memory Read Only Enforcement: VMM assisted kernel rootkit mitigation
	for KVM V4
Date: Sat, 21 Jul 2018 01:31:27 +0200
Message-ID: <20180720233130.14129-1-ahmedsoliman0x666@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, Kernel Hardening <kernel-hardening@lists.openwall.com>, virtualization@lists.linux-foundation.org, linux-doc@vger.kernel.org, x86@kernel.org, xen-devel@lists.xensource.com
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Kees Cook <keescook@chromium.org>, nathan Corbet <corbet@lwn.net>, David Vrabel <david.vrabel@nutanix.com>, rkrcmar@redhat.com, Boris Lukashev <blukashev@sempervictus.com>, Ingo Molnar <mingo@redhat.com>, nigel.edwards@hpe.com, hpa@zytor.com, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@surriel.com>
List-Id: virtualization@lists.linuxfoundation.org

Here is change log from V3 To V4:
- Fixing spelling/grammar mistakes suggested by Randy Dunlap
- Changing the hypercall interface to be able to process multiple pages
  per one hypercall also suggested by Randy Dunlap. It turns out that
  this will save lots of vmexist/memory slot flushes when protecting many
  pages.

[PATCH RFC V4 1/3] KVM: X86: Memory ROE documentation
[PATCH RFC V4 2/3] KVM: X86: Adding arbitrary data pointer in kvm memslot iterator functions
[PATCH RFC V4 3/3] KVM: X86: Adding skeleton for Memory ROE

Summary:

 Documentation/virtual/kvm/hypercalls.txt |  14 ++++
 arch/x86/include/asm/kvm_host.h          |  11 ++-
 arch/x86/kvm/Kconfig                     |   7 ++
 arch/x86/kvm/mmu.c                       | 127 ++++++++++++++++++++++---------
 arch/x86/kvm/x86.c                       | 104 ++++++++++++++++++++++++-
 include/linux/kvm_host.h                 |   3 +
 include/uapi/linux/kvm_para.h            |   1 +
 virt/kvm/kvm_main.c                      |  29 ++++++-
 8 files changed, 254 insertions(+), 42 deletions(-)
