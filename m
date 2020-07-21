From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [PATCH v9 02/84] KVM: UAPI: add error codes used by the VM introspection code
Date: Wed, 22 Jul 2020 00:08:00 +0300
Message-ID: <20200721210922.7646-3-alazar@bitdefender.com>
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

These new error codes help the introspection tool to identify the cause
of the introspection command failure and to recover from some error
cases or to give more information to the user.

Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 include/uapi/linux/kvm_para.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
index 8b86609849b9..3ce388249682 100644
--- a/include/uapi/linux/kvm_para.h
+++ b/include/uapi/linux/kvm_para.h
@@ -17,6 +17,10 @@
 #define KVM_E2BIG		E2BIG
 #define KVM_EPERM		EPERM
 #define KVM_EOPNOTSUPP		95
+#define KVM_EAGAIN		11
+#define KVM_ENOENT		ENOENT
+#define KVM_ENOMEM		ENOMEM
+#define KVM_EBUSY		EBUSY
 
 #define KVM_HC_VAPIC_POLL_IRQ		1
 #define KVM_HC_MMU_OP			2
