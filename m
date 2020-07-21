From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [PATCH v9 03/84] KVM: add kvm_vcpu_kick_and_wait()
Date: Wed, 22 Jul 2020 00:08:01 +0300
Message-ID: <20200721210922.7646-4-alazar@bitdefender.com>
References: <20200721210922.7646-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200721210922.7646-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

This function is needed for the KVMI_VCPU_PAUSE command, which sets the
introspection request flag, kicks the vCPU out of guest and returns a
success error code (0). The vCPU will send the KVMI_EVENT_PAUSE event
as soon as possible. Once the introspection tool receives the event, it
knows that the vCPU doesn't run guest code and can handle introspection
commands (until the reply for the pause event is sent).

To implement the "pause VM" command, the userspace code will send a
KVMI_VCPU_PAUSE command for every vCPU. To know when the VM is paused,
userspace has to receive and "parse" all events. For example, with a
4 vCPU VM, if the "pause VM" was sent by userspace while handling an event
from vCPU0 and at the same time a new vCPU was hot-plugged (which could
send another event for vCPU4), the "pause VM" command has to receive
and check all events until it gets the pause events for vCPU1, vCPU2
and vCPU3 before returning to the upper layer.

In order to make it easier for userspace to implement the "pause VM"
command, the KVMI_VCPU_PAUSE has an optional 'wait' parameter. If this is
set, kvm_vcpu_kick_and_wait() will be used instead of kvm_vcpu_kick().
And because this vCPU command (KVMI_VCPU_PAUSE) is handled by the
receiving thread (instead of the vCPU thread), once a string of
KVMI_VCPU_PAUSE commands with the 'wait' flag set is handled, the
introspection tool can consider the VM paused, without the need to wait
and check events.

Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 62ec926c78a0..92490279d65a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -810,6 +810,7 @@ void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu);
 void kvm_vcpu_kick(struct kvm_vcpu *vcpu);
+void kvm_vcpu_kick_and_wait(struct kvm_vcpu *vcpu);
 int kvm_vcpu_yield_to(struct kvm_vcpu *target);
 void kvm_vcpu_on_spin(struct kvm_vcpu *vcpu, bool usermode_vcpu_not_eligible);
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0a68c9d3d3ab..4d965913d347 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2802,6 +2802,16 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
 EXPORT_SYMBOL_GPL(kvm_vcpu_kick);
 #endif /* !CONFIG_S390 */
 
+void kvm_vcpu_kick_and_wait(struct kvm_vcpu *vcpu)
+{
+	if (kvm_vcpu_wake_up(vcpu))
+		return;
+
+	if (kvm_request_needs_ipi(vcpu, KVM_REQUEST_WAIT))
+		smp_call_function_single(vcpu->cpu, ack_flush, NULL, 1);
+}
+EXPORT_SYMBOL_GPL(kvm_vcpu_kick_and_wait);
+
 int kvm_vcpu_yield_to(struct kvm_vcpu *target)
 {
 	struct pid *pid;
