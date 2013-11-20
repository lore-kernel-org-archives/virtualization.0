From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH -tip v3 21/23] notifier: Use NOKPROBE_SYMBOL macro in notifier
Date: Wed, 20 Nov 2013 04:22:41 +0000
Message-ID: <20131120042241.15296.89670.stgit__2549.12383757091$1384921895$gmane$org@kbuild-fedora.novalocal>
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, systemtap@sourceware.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Use NOKPROBE_SYMBOL macro to protect functions from
kprobes instead of __kprobes annotation in notifier.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 kernel/notifier.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/notifier.c b/kernel/notifier.c
index 2d5cc4c..61fc78a 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -71,9 +71,9 @@ static int notifier_chain_unregister(struct notifier_block **nl,
  *	@returns:	notifier_call_chain returns the value returned by the
  *			last notifier function called.
  */
-static int __kprobes notifier_call_chain(struct notifier_block **nl,
-					unsigned long val, void *v,
-					int nr_to_call,	int *nr_calls)
+static int notifier_call_chain(struct notifier_block **nl,
+			       unsigned long val, void *v,
+			       int nr_to_call, int *nr_calls)
 {
 	int ret = NOTIFY_DONE;
 	struct notifier_block *nb, *next_nb;
@@ -102,6 +102,7 @@ static int __kprobes notifier_call_chain(struct notifier_block **nl,
 	}
 	return ret;
 }
+NOKPROBE_SYMBOL(notifier_call_chain);
 
 /*
  *	Atomic notifier chain routines.  Registration and unregistration
@@ -172,9 +173,9 @@ EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
  *	Otherwise the return value is the return value
  *	of the last notifier function called.
  */
-int __kprobes __atomic_notifier_call_chain(struct atomic_notifier_head *nh,
-					unsigned long val, void *v,
-					int nr_to_call, int *nr_calls)
+int __atomic_notifier_call_chain(struct atomic_notifier_head *nh,
+				 unsigned long val, void *v,
+				 int nr_to_call, int *nr_calls)
 {
 	int ret;
 
@@ -184,13 +185,15 @@ int __kprobes __atomic_notifier_call_chain(struct atomic_notifier_head *nh,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__atomic_notifier_call_chain);
+NOKPROBE_SYMBOL(__atomic_notifier_call_chain);
 
-int __kprobes atomic_notifier_call_chain(struct atomic_notifier_head *nh,
-		unsigned long val, void *v)
+int atomic_notifier_call_chain(struct atomic_notifier_head *nh,
+			       unsigned long val, void *v)
 {
 	return __atomic_notifier_call_chain(nh, val, v, -1, NULL);
 }
 EXPORT_SYMBOL_GPL(atomic_notifier_call_chain);
+NOKPROBE_SYMBOL(atomic_notifier_call_chain);
 
 /*
  *	Blocking notifier chain routines.  All access to the chain is
@@ -527,7 +530,7 @@ EXPORT_SYMBOL_GPL(srcu_init_notifier_head);
 
 static ATOMIC_NOTIFIER_HEAD(die_chain);
 
-int notrace __kprobes notify_die(enum die_val val, const char *str,
+int notrace notify_die(enum die_val val, const char *str,
 	       struct pt_regs *regs, long err, int trap, int sig)
 {
 	struct die_args args = {
@@ -540,6 +543,7 @@ int notrace __kprobes notify_die(enum die_val val, const char *str,
 	};
 	return atomic_notifier_call_chain(&die_chain, val, &args);
 }
+NOKPROBE_SYMBOL(notify_die);
 
 int register_die_notifier(struct notifier_block *nb)
 {
