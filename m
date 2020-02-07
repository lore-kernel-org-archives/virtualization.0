From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v7 46/78] KVM: introspection: add vCPU related data
Date: Fri,  7 Feb 2020 20:16:04 +0200
Message-ID: <20200207181636.1065-47-alazar@bitdefender.com>
References: <20200207181636.1065-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200207181636.1065-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <sean.j.christopherson@intel.com>, =?UTF-8?q?Mircea=20C=C3=AErjaliu?= <mcirjaliu@bitdefender.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Mircea Cîrjaliu <mcirjaliu@bitdefender.com>

Add an introspection structure to all vCPUs when the VM is hooked.

Signed-off-by: Mircea Cîrjaliu <mcirjaliu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/include/asm/kvmi_host.h |  3 ++
 include/linux/kvm_host.h         |  1 +
 include/linux/kvmi_host.h        |  7 +++++
 virt/kvm/introspection/kvmi.c    | 49 ++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c              |  1 +
 5 files changed, 61 insertions(+)

diff --git a/arch/x86/include/asm/kvmi_host.h b/arch/x86/include/asm/kvmi_host.h
index 38c398262913..360a57dd9019 100644
--- a/arch/x86/include/asm/kvmi_host.h
+++ b/arch/x86/include/asm/kvmi_host.h
@@ -2,6 +2,9 @@
 #ifndef _ASM_X86_KVMI_HOST_H
 #define _ASM_X86_KVMI_HOST_H
 
+struct kvm_vcpu_arch_introspection {
+};
+
 struct kvm_arch_introspection {
 };
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0104cb2c8ee0..52e98720d0f6 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -323,6 +323,7 @@ struct kvm_vcpu {
 	bool ready;
 	struct kvm_vcpu_arch arch;
 	struct dentry *debugfs_dentry;
+	struct kvm_vcpu_introspection *kvmi;
 };
 
 static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
diff --git a/include/linux/kvmi_host.h b/include/linux/kvmi_host.h
index 41b22af771fb..ca2db8043a53 100644
--- a/include/linux/kvmi_host.h
+++ b/include/linux/kvmi_host.h
@@ -5,11 +5,16 @@
 #include <uapi/linux/kvmi.h>
 
 struct kvm;
+struct kvm_vcpu;
 
 #include <asm/kvmi_host.h>
 
 #define KVMI_NUM_COMMANDS KVMI_NUM_MESSAGES
 
+struct kvm_vcpu_introspection {
+	struct kvm_vcpu_arch_introspection arch;
+};
+
 struct kvm_introspection {
 	struct kvm_arch_introspection arch;
 	struct kvm *kvm;
@@ -33,6 +38,7 @@ int kvmi_init(void);
 void kvmi_uninit(void);
 void kvmi_create_vm(struct kvm *kvm);
 void kvmi_destroy_vm(struct kvm *kvm);
+void kvmi_vcpu_uninit(struct kvm_vcpu *vcpu);
 
 int kvmi_ioctl_hook(struct kvm *kvm, void __user *argp);
 int kvmi_ioctl_unhook(struct kvm *kvm);
@@ -46,6 +52,7 @@ static inline int kvmi_init(void) { return 0; }
 static inline void kvmi_uninit(void) { }
 static inline void kvmi_create_vm(struct kvm *kvm) { }
 static inline void kvmi_destroy_vm(struct kvm *kvm) { }
+static inline void kvmi_vcpu_uninit(struct kvm_vcpu *vcpu) { }
 
 #endif /* CONFIG_KVM_INTROSPECTION */
 
diff --git a/virt/kvm/introspection/kvmi.c b/virt/kvm/introspection/kvmi.c
index 9e4e8fb07859..655170ffb574 100644
--- a/virt/kvm/introspection/kvmi.c
+++ b/virt/kvm/introspection/kvmi.c
@@ -59,16 +59,56 @@ void kvmi_uninit(void)
 	kvmi_cache_destroy();
 }
 
+static bool alloc_vcpui(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_introspection *vcpui;
+
+	vcpui = kzalloc(sizeof(*vcpui), GFP_KERNEL);
+	if (!vcpui)
+		return false;
+
+	vcpu->kvmi = vcpui;
+
+	return true;
+}
+
+static int create_vcpui(struct kvm_vcpu *vcpu)
+{
+	if (!alloc_vcpui(vcpu))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void free_vcpui(struct kvm_vcpu *vcpu)
+{
+	kfree(vcpu->kvmi);
+	vcpu->kvmi = NULL;
+}
+
 static void free_kvmi(struct kvm *kvm)
 {
+	struct kvm_vcpu *vcpu;
+	int i;
+
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		free_vcpui(vcpu);
+
 	kfree(kvm->kvmi);
 	kvm->kvmi = NULL;
 }
 
+void kvmi_vcpu_uninit(struct kvm_vcpu *vcpu)
+{
+	free_vcpui(vcpu);
+}
+
 static struct kvm_introspection *
 alloc_kvmi(struct kvm *kvm, const struct kvm_introspection_hook *hook)
 {
 	struct kvm_introspection *kvmi;
+	struct kvm_vcpu *vcpu;
+	int i;
 
 	kvmi = kzalloc(sizeof(*kvmi), GFP_KERNEL);
 	if (!kvmi)
@@ -83,6 +123,15 @@ alloc_kvmi(struct kvm *kvm, const struct kvm_introspection_hook *hook)
 
 	atomic_set(&kvmi->ev_seq, 0);
 
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		int err = create_vcpui(vcpu);
+
+		if (err) {
+			free_kvmi(kvm);
+			return NULL;
+		}
+	}
+
 	kvmi->kvm = kvm;
 
 	return kvmi;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4f83735f2b74..ef7d14ef8e86 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -373,6 +373,7 @@ void kvm_vcpu_uninit(struct kvm_vcpu *vcpu)
 	 * descriptors are already gone.
 	 */
 	put_pid(rcu_dereference_protected(vcpu->pid, 1));
+	kvmi_vcpu_uninit(vcpu);
 	kvm_arch_vcpu_uninit(vcpu);
 	free_page((unsigned long)vcpu->run);
 }
