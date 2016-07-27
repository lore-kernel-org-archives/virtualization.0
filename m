From: Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 2/7] pstore/ram: Set pstore flags dynamically
Date: Thu, 28 Jul 2016 00:08:26 +0900
Message-ID: <1469632111-23260-3-git-send-email-namhyung@kernel.org>
References: <1469632111-23260-1-git-send-email-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1469632111-23260-1-git-send-email-namhyung@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
Cc: Tony Luck <tony.luck@intel.com>, Anton Vorontsov <anton@enomsg.org>, LKML <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Colin Cross <ccross@android.com>
List-Id: virtualization@lists.linuxfoundation.org

The ramoops can be configured to enable each pstore type by setting
their size.  In that case, it'd be better not to register disabled types
in the first place.

Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 fs/pstore/ram.c        | 8 +++++++-
 include/linux/pstore.h | 2 --
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index ba19a74e95bc..6c93268f7ced 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -624,7 +624,13 @@ static int ramoops_probe(struct platform_device *pdev)
 		goto fail_clear;
 	}
 
-	cxt->pstore.flags = PSTORE_FLAGS_ALL;
+	cxt->pstore.flags = PSTORE_FLAGS_DMESG;
+	if (cxt->console_size)
+		cxt->pstore.flags |= PSTORE_FLAGS_CONSOLE;
+	if (cxt->ftrace_size)
+		cxt->pstore.flags |= PSTORE_FLAGS_FTRACE;
+	if (cxt->pmsg_size)
+		cxt->pstore.flags |= PSTORE_FLAGS_PMSG;
 
 	err = pstore_register(&cxt->pstore);
 	if (err) {
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 069b96faf478..9790904de6d2 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -79,8 +79,6 @@ struct pstore_info {
 #define PSTORE_FLAGS_FTRACE	(1 << 2)
 #define PSTORE_FLAGS_PMSG	(1 << 3)
 
-#define PSTORE_FLAGS_ALL	((1 << 4) - 1)
-
 extern int pstore_register(struct pstore_info *);
 extern void pstore_unregister(struct pstore_info *);
 extern bool pstore_cannot_block_path(enum kmsg_dump_reason reason);
-- 
2.8.0
