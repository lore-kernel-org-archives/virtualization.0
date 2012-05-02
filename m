From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH RFC V8 14/17] kvm : Fold pv_unhalt flag into GET_MP_STATE
	ioctl to aid migration
Date: Wed, 02 May 2012 15:39:11 +0530
Message-ID: <20120502100911.13206.63174.sendpatchset@codeblue.in.ibm.com>
References: <20120502100610.13206.40.sendpatchset@codeblue.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120502100610.13206.40.sendpatchset@codeblue.in.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "H. Peter Anvin" <hpa@zytor.com>, Marcelo Tosatti <mtosatti@redhat.com>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>
Cc: Xen Devel <xen-devel@lists.xensource.com>, KVM <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Virtualization <virtualization@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>, Attilio Rao <attilio.rao@citrix.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>

During migration, any vcpu that got kicked but did not become runnable
 (still in halted state) should be runnable after migration.

Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 arch/x86/kvm/x86.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f188cdc..5b09b67 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5691,7 +5691,12 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
-	mp_state->mp_state = vcpu->arch.mp_state;
+	if (vcpu->arch.mp_state == KVM_MP_STATE_HALTED &&
+					vcpu->arch.pv.pv_unhalted)
+		mp_state->mp_state = KVM_MP_STATE_RUNNABLE;
+	else
+		mp_state->mp_state = vcpu->arch.mp_state;
+
 	return 0;
 }
