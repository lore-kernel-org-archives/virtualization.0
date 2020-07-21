From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [PATCH v9 01/84] signal: export kill_pid_info()
Date: Wed, 22 Jul 2020 00:07:59 +0300
Message-ID: <20200721210922.7646-2-alazar@bitdefender.com>
References: <20200721210922.7646-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200721210922.7646-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Mathieu Tarral <mathieu.tarral@protonmail.com>

This function is used by VM introspection code to ungracefully shutdown
a guest at the request of the introspection tool.

A security application will use this as the last resort to stop the
spread of a malware from a guest.

Signed-off-by: Mathieu Tarral <mathieu.tarral@protonmail.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 5ca48cc5da76..c3af81d7b62a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1456,6 +1456,7 @@ int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
 		 */
 	}
 }
+EXPORT_SYMBOL(kill_pid_info);
 
 static int kill_proc_info(int sig, struct kernel_siginfo *info, pid_t pid)
 {
