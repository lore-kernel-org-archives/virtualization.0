From: Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
Subject: [PATCH RFC V4 1/3] KVM: X86: Memory ROE documentation
Date: Sat, 21 Jul 2018 01:31:28 +0200
Message-ID: <20180720233130.14129-2-ahmedsoliman0x666__28994.8159283542$1532129459$gmane$org@gmail.com>
References: <20180720233130.14129-1-ahmedsoliman0x666@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180720233130.14129-1-ahmedsoliman0x666@gmail.com>
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

Following up with my previous threads on KVM assisted Anti rootkit
protections.
The current version doesn't address the attacks involving pages
remapping. It is still design in progress, nevertheless, it will be in
my later patch sets.

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
---
 Documentation/virtual/kvm/hypercalls.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/virtual/kvm/hypercalls.txt b/Documentation/virtual/kvm/hypercalls.txt
index a890529c63ed..affd997eabfe 100644
--- a/Documentation/virtual/kvm/hypercalls.txt
+++ b/Documentation/virtual/kvm/hypercalls.txt
@@ -121,3 +121,17 @@ compute the CLOCK_REALTIME for its clock, at the same instant.
 
 Returns KVM_EOPNOTSUPP if the host does not use TSC clocksource,
 or if clock type is different than KVM_CLOCK_PAIRING_WALLCLOCK.
+
+7. KVM_HC_HMROE
+----------------
+Architecture: x86
+Status: active
+Purpose: Hypercall used to apply Read-Only Enforcement to guest pages
+Usage:
+     a0: Start address aligned to page boundary.
+     a1: Number of pages to be protected.
+This hypercall lets a guest kernel have part of its read/write memory
+converted into read-only.  This action is irreversible. KVM_HC_HMROE can
+not be triggered from guest Ring 3 (user mode). The reason is that user
+mode malicious software can make use of it to enforce read only protection
+on an arbitrary memory page thus crashing the kernel.
-- 
2.16.4
