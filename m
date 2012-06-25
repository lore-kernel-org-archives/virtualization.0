From: Jason Wang <jasowang@redhat.com>
Subject: [RFC V2 PATCH 1/4] option: introduce qemu_get_opt_all()
Date: Mon, 25 Jun 2012 18:04:14 +0800
Message-ID: <20120625100414.8096.38155.stgit@amd-6168-8-1.englab.nay.redhat.com>
References: <20120625095059.8096.49429.stgit@amd-6168-8-1.englab.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120625095059.8096.49429.stgit@amd-6168-8-1.englab.nay.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: krkumar2@in.ibm.com, habanero@linux.vnet.ibm.com, aliguori@us.ibm.com, rusty@rustcorp.com.au, mst@redhat.com, mashirle@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, tahm@linux.vnet.ibm.com, jwhan@filewood.snu.ac.kr, akong@redhat.com
Cc: kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Sometimes, we need to pass option like -netdev tap,fd=100,fd=101,fd=102 which
can not be properly parsed by qemu_find_opt() because it only returns the first
matched option. So qemu_get_opt_all() were introduced to return an array of
pointers which contains all matched option.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 qemu-option.c |   19 +++++++++++++++++++
 qemu-option.h |    2 ++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/qemu-option.c b/qemu-option.c
index bb3886c..9263125 100644
--- a/qemu-option.c
+++ b/qemu-option.c
@@ -545,6 +545,25 @@ static QemuOpt *qemu_opt_find(QemuOpts *opts, const char *name)
     return NULL;
 }
 
+int qemu_opt_get_all(QemuOpts *opts, const char *name, const char **optp,
+                     int max)
+{
+    QemuOpt *opt;
+    int index = 0;
+
+    QTAILQ_FOREACH_REVERSE(opt, &opts->head, QemuOptHead, next) {
+        if (strcmp(opt->name, name) == 0) {
+            if (index < max) {
+                optp[index++] = opt->str;
+            }
+            if (index == max) {
+                break;
+            }
+        }
+    }
+    return index;
+}
+
 const char *qemu_opt_get(QemuOpts *opts, const char *name)
 {
     QemuOpt *opt = qemu_opt_find(opts, name);
diff --git a/qemu-option.h b/qemu-option.h
index 951dec3..3c9a273 100644
--- a/qemu-option.h
+++ b/qemu-option.h
@@ -106,6 +106,8 @@ struct QemuOptsList {
     QemuOptDesc desc[];
 };
 
+int qemu_opt_get_all(QemuOpts *opts, const char *name, const char **optp,
+                     int max);
 const char *qemu_opt_get(QemuOpts *opts, const char *name);
 bool qemu_opt_get_bool(QemuOpts *opts, const char *name, bool defval);
 uint64_t qemu_opt_get_number(QemuOpts *opts, const char *name, uint64_t defval);
