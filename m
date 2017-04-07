From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/3] ringtest: support test specific parameters
Date: Fri, 7 Apr 2017 08:50:00 +0300
Message-ID: <1491544049-19108-2-git-send-email-mst@redhat.com>
References: <1491544049-19108-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1491544049-19108-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, brouer@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Add a new flag for passing test-specific parameters.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/ringtest/main.c | 13 +++++++++++++
 tools/virtio/ringtest/main.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/tools/virtio/ringtest/main.c b/tools/virtio/ringtest/main.c
index f31353f..022ae95 100644
--- a/tools/virtio/ringtest/main.c
+++ b/tools/virtio/ringtest/main.c
@@ -20,6 +20,7 @@
 int runcycles = 10000000;
 int max_outstanding = INT_MAX;
 int batch = 1;
+int param = 0;
 
 bool do_sleep = false;
 bool do_relax = false;
@@ -247,6 +248,11 @@ static const struct option longopts[] = {
 		.val = 'b',
 	},
 	{
+		.name = "param",
+		.has_arg = required_argument,
+		.val = 'p',
+	},
+	{
 		.name = "sleep",
 		.has_arg = no_argument,
 		.val = 's',
@@ -274,6 +280,7 @@ static void help(void)
 		" [--run-cycles C (default: %d)]"
 		" [--batch b]"
 		" [--outstanding o]"
+		" [--param p]"
 		" [--sleep]"
 		" [--relax]"
 		" [--exit]"
@@ -328,6 +335,12 @@ int main(int argc, char **argv)
 			assert(c > 0 && c < INT_MAX);
 			max_outstanding = c;
 			break;
+		case 'p':
+			c = strtol(optarg, &endptr, 0);
+			assert(!*endptr);
+			assert(c > 0 && c < INT_MAX);
+			param = c;
+			break;
 		case 'b':
 			c = strtol(optarg, &endptr, 0);
 			assert(!*endptr);
diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
index 14142fa..90b0133 100644
--- a/tools/virtio/ringtest/main.h
+++ b/tools/virtio/ringtest/main.h
@@ -10,6 +10,8 @@
 
 #include <stdbool.h>
 
+extern int param;
+
 extern bool do_exit;
 
 #if defined(__x86_64__) || defined(__i386__)
-- 
MST
