From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: [PATCH] lguest: fix paths in comments
Date: Wed, 6 Mar 2013 15:40:28 +0800
Message-ID: <1362555628-22852-1-git-send-email-gaowanlong@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

After commit 07fe997, lguest tool has already moved from
Documentation/virtual/lguest/ to tools/lguest/.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/lguest/Kconfig  | 5 ++---
 tools/lguest/lguest.txt | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/lguest/Kconfig b/drivers/lguest/Kconfig
index 89875ea..ee035ec 100644
--- a/drivers/lguest/Kconfig
+++ b/drivers/lguest/Kconfig
@@ -5,10 +5,9 @@ config LGUEST
 	---help---
 	  This is a very simple module which allows you to run
 	  multiple instances of the same Linux kernel, using the
-	  "lguest" command found in the Documentation/virtual/lguest
-	  directory.
+	  "lguest" command found in the tools/lguest directory.
 
 	  Note that "lguest" is pronounced to rhyme with "fell quest",
-	  not "rustyvisor". See Documentation/virtual/lguest/lguest.txt.
+	  not "rustyvisor". See tools/lguest/lguest.txt.
 
 	  If unsure, say N.  If curious, say M.  If masochistic, say Y.
diff --git a/tools/lguest/lguest.txt b/tools/lguest/lguest.txt
index 7203ace..06e1f46 100644
--- a/tools/lguest/lguest.txt
+++ b/tools/lguest/lguest.txt
@@ -70,7 +70,7 @@ Running Lguest:
 
 - Run an lguest as root:
 
-      Documentation/virtual/lguest/lguest 64 vmlinux --tunnet=192.168.19.1 \
+      tools/lguest/lguest 64 vmlinux --tunnet=192.168.19.1 \
         --block=rootfile root=/dev/vda
 
    Explanation:
-- 
1.8.2.rc2
