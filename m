From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [PATCH v9 30/84] KVM: x86: export kvm_vcpu_ioctl_x86_get_xsave()
Date: Wed, 22 Jul 2020 00:08:28 +0300
Message-ID: <20200721210922.7646-31-alazar@bitdefender.com>
References: <20200721210922.7646-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200721210922.7646-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Nicu=C8=99or=20C=C3=AE=C8=9Bu?= <ncitu@bitdefender.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Nicușor Cîțu <ncitu@bitdefender.com>

This function is needed for the KVMI_VCPU_GET_XSAVE command.

Signed-off-by: Nicușor Cîțu <ncitu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/kvm/x86.c       | 4 ++--
 include/linux/kvm_host.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 52181eb131dd..4d5be48b5239 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4207,8 +4207,8 @@ static void load_xsave(struct kvm_vcpu *vcpu, u8 *src)
 	}
 }
 
-static void kvm_vcpu_ioctl_x86_get_xsave(struct kvm_vcpu *vcpu,
-					 struct kvm_xsave *guest_xsave)
+void kvm_vcpu_ioctl_x86_get_xsave(struct kvm_vcpu *vcpu,
+				  struct kvm_xsave *guest_xsave)
 {
 	if (boot_cpu_has(X86_FEATURE_XSAVE)) {
 		memset(guest_xsave, 0, sizeof(struct kvm_xsave));
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 01628f7bcbcd..f138d56450c0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -883,6 +883,8 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu);
 int kvm_arch_vcpu_set_guest_debug(struct kvm_vcpu *vcpu,
 				  struct kvm_guest_debug *dbg);
+void kvm_vcpu_ioctl_x86_get_xsave(struct kvm_vcpu *vcpu,
+				  struct kvm_xsave *guest_xsave);
 
 int kvm_arch_init(void *opaque);
 void kvm_arch_exit(void);
