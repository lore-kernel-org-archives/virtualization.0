From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH RFC V6 2/5] kvm : Fold pv_unhalt flag into GET_MP_STATE ioctl
	to aid migration
Date: Mon, 23 Apr 2012 15:30:02 +0530
Message-ID: <20120423100002.30893.60584.sendpatchset__3357.80267273567$1335177005$gmane$org@codeblue.in.ibm.com>
References: <20120423095937.30893.14776.sendpatchset@codeblue.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120423095937.30893.14776.sendpatchset@codeblue.in.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, Alexander Graf <agraf@suse.de>, Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, Virtualization <virtualization@lists.linux-foundation.org>, Marcelo Tosatti <mtosatti@redhat.com>, Avi Kivity <avi@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Xen <xen-devel@lists.xensource.com>, Sasha Levin <levinsasha928@gmail.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>

Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6faa550..7354c1b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5691,7 +5691,9 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
-	mp_state->mp_state = vcpu->arch.mp_state;
+	mp_state->mp_state = (vcpu->arch.mp_state == KVM_MP_STATE_HALTED &&
+				vcpu->arch.pv.pv_unhalted) ?
+	KVM_MP_STATE_RUNNABLE : vcpu->arch.mp_state;
 	return 0;
 }
