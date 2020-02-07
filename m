From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v7 01/78] sched/swait: add swait_event_killable_exclusive()
Date: Fri,  7 Feb 2020 20:15:19 +0200
Message-ID: <20200207181636.1065-2-alazar@bitdefender.com>
References: <20200207181636.1065-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200207181636.1065-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <sean.j.christopherson@intel.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

When a vCPU is introspected, it waits for introspection commands or event
replies. If the introspection channel is closed, the receiving thread
will wake-up the vCPU threads. With this function the vCPU thread will
wake-up on SIGKILL too.

Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 include/linux/swait.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 73e06e9986d4..9c53383219f6 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -297,4 +297,15 @@ do {									\
 	__ret;								\
 })
 
+#define __swait_event_killable(wq, condition)				\
+	___swait_event(wq, condition, TASK_KILLABLE, 0,	schedule())
+
+#define swait_event_killable_exclusive(wq, condition)			\
+({									\
+	int __ret = 0;							\
+	if (!(condition))						\
+		__ret = __swait_event_killable(wq, condition);		\
+	__ret;								\
+})
+
 #endif /* _LINUX_SWAIT_H */
