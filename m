From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v7 02/78] export kill_pid_info()
Date: Fri,  7 Feb 2020 20:15:20 +0200
Message-ID: <20200207181636.1065-3-alazar@bitdefender.com>
References: <20200207181636.1065-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200207181636.1065-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Mathieu Tarral <mathieu.tarral@protonmail.com>

This function is used by KVMI (KVM introspection sub-system) to
ungracefully shutdown the guest when an introspection tool requests it.

A security application will use it as a last resort in stopping the
spread of a malware from a guest

Signed-off-by: Mathieu Tarral <mathieu.tarral@protonmail.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index bcd46f547db3..461881343991 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1451,6 +1451,7 @@ int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
 		 */
 	}
 }
+EXPORT_SYMBOL(kill_pid_info);
 
 static int kill_proc_info(int sig, struct kernel_siginfo *info, pid_t pid)
 {
