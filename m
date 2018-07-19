From: Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
Subject: Memory Read Only Enforcement: VMM assisted kernel rootkit mitigation
	for KVM
Date: Thu, 19 Jul 2018 23:37:59 +0200
Message-ID: <20180719213802.17161-1-ahmedsoliman0x666@gmail.com>
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
To: kvm@vger.kernel.org, Kernel Hardening <kernel-hardening@lists.openwall.com>, virtualization@lists.linux-foundation.org, linux-doc@vger.kernel.org, x86@kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Kees Cook <keescook@chromium.org>, nathan Corbet <corbet@lwn.net>, David Vrabel <david.vrabel@nutanix.com>, rkrcmar@redhat.com, Boris Lukashev <blukashev@sempervictus.com>, Ingo Molnar <mingo@redhat.com>, nigel.edwards@hpe.com, hpa@zytor.com, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@surriel.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

This is my first set of patches that works as I would expect, and the
third revision I sent to mailing lists.

Following up with my previous discussions about kernel rootkit mitigation
via placing R/O protection on critical data structure, static data,
privileged registers with static content. These patches present the
first part where it is only possible to place these protections on
memory pages. Feature-wise, this set of patches is incomplete in the sense of:
- They still don't protect privileged registers
- They don't protect guest TLB from malicious gva -> gpa page mappings.
But they provide sketches for a basic working design. Note that I am totally
noob and it took lots of time and effort to get to this point. So sorry in
advance if I overlooked something.

[PATCH 1/3] [RFC V3] KVM: X86: Memory ROE documentation
[PATCH 2/3] [RFC V3] KVM: X86: Adding arbitrary data pointer in kvm memslot itterator functions
[PATCH 3/3] [RFC V3] KVM: X86: Adding skeleton for Memory ROE

Summery:

 Documentation/virtual/kvm/hypercalls.txt |  14 ++++
 arch/x86/include/asm/kvm_host.h          |  11 ++-
 arch/x86/kvm/Kconfig                     |   7 ++
 arch/x86/kvm/mmu.c                       | 127 ++++++++++++++++++++++---------
 arch/x86/kvm/x86.c                       |  82 +++++++++++++++++++-
 include/linux/kvm_host.h                 |   3 +
 include/uapi/linux/kvm_para.h            |   1 +
 virt/kvm/kvm_main.c                      |  29 ++++++-
 8 files changed, 232 insertions(+), 42 deletions(-)
