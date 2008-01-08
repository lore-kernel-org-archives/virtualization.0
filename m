From: Marcelo Tosatti <marcelo@kvack.org>
Subject: [PATCH] KVM: add KVM_SYNC_SHADOW_WITH_USER ioctl
Date: Tue, 8 Jan 2008 13:39:15 -0200
Message-ID: <20080108153915.GB21726__30260.2360760377$1199824409$gmane$org@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, kvm-devel <kvm-devel@lists.sourceforge.net>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Dor Laor <dor.laor@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org


The host needs to zap its shadow entries before performing an inflate
operation to avoid the guest from using stale ones.

So add an ioctl to interface with kvm_mmu_zap_all().

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: kvm.quilt/arch/x86/kvm/x86.c
===================================================================
--- kvm.quilt.orig/arch/x86/kvm/x86.c
+++ kvm.quilt/arch/x86/kvm/x86.c
@@ -680,6 +680,7 @@ int kvm_dev_ioctl_check_extension(long e
 	case KVM_CAP_USER_MEMORY:
 	case KVM_CAP_SET_TSS_ADDR:
 	case KVM_CAP_EXT_CPUID:
+	case KVM_CAP_SYNC_SHADOW_WITH_USER:
 		r = 1;
 		break;
 	case KVM_CAP_VAPIC:
Index: kvm.quilt/include/linux/kvm.h
===================================================================
--- kvm.quilt.orig/include/linux/kvm.h
+++ kvm.quilt/include/linux/kvm.h
@@ -249,6 +249,7 @@ struct kvm_vapic_addr {
 #define KVM_CAP_SET_TSS_ADDR 4
 #define KVM_CAP_EXT_CPUID 5
 #define KVM_CAP_VAPIC 6
+#define KVM_CAP_SYNC_SHADOW_WITH_USER 7
 
 /*
  * ioctls for VM fds
@@ -267,6 +268,7 @@ struct kvm_vapic_addr {
 #define KVM_GET_DIRTY_LOG         _IOW(KVMIO, 0x42, struct kvm_dirty_log)
 #define KVM_SET_MEMORY_ALIAS      _IOW(KVMIO, 0x43, struct kvm_memory_alias)
 #define KVM_GET_SUPPORTED_CPUID   _IOWR(KVMIO, 0x48, struct kvm_cpuid2)
+#define KVM_SYNC_SHADOW_WITH_USER _IO(KVMIO, 0x49)
 /* Device model IOC */
 #define KVM_CREATE_IRQCHIP	  _IO(KVMIO,  0x60)
 #define KVM_IRQ_LINE		  _IOW(KVMIO, 0x61, struct kvm_irq_level)
Index: kvm.quilt/virt/kvm/kvm_main.c
===================================================================
--- kvm.quilt.orig/virt/kvm/kvm_main.c
+++ kvm.quilt/virt/kvm/kvm_main.c
@@ -971,6 +971,11 @@ static long kvm_vm_ioctl(struct file *fi
 			goto out;
 		break;
 	}
+	case KVM_SYNC_SHADOW_WITH_USER: {
+		r = 0;
+		kvm_mmu_zap_all(kvm);
+		break;
+	}
 	default:
 		r = kvm_arch_vm_ioctl(filp, ioctl, arg);
 	}
