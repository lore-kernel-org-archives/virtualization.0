From: Cong Meng <mc@linux.vnet.ibm.com>
Subject: [PATCH 1/2 v1] blkdrv: Add queue limits parameters for sg block drive
Date: Tue, 21 Aug 2012 16:23:46 +0800
Message-ID: <1345537427-21601-1-git-send-email-mc@linux.vnet.ibm.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: stefanha@linux.vnet.ibm.com, zwanp@cn.ibm.com, linuxram@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Cong Meng <mc@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch adds some queue limit parameters into block drive. And inits them
for sg block drive. Some interfaces are also added for accessing them.

Signed-off-by: Cong Meng <mc@linux.vnet.ibm.com>
---
 block/raw-posix.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 block_int.h       |    4 +++
 blockdev.c        |   15 +++++++++++++
 hw/block-common.h |    3 ++
 4 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/block/raw-posix.c b/block/raw-posix.c
index 0dce089..a086f89 100644
--- a/block/raw-posix.c
+++ b/block/raw-posix.c
@@ -53,6 +53,7 @@
 #include <linux/cdrom.h>
 #include <linux/fd.h>
 #include <linux/fs.h>
+#include <dirent.h>
 #endif
 #ifdef CONFIG_FIEMAP
 #include <linux/fiemap.h>
@@ -829,6 +830,62 @@ static int hdev_probe_device(const char *filename)
     return 0;
 }
 
+static void read_queue_limit(char *path, const char *filename, unsigned int *val)
+{
+    FILE *f;
+    char *tail = path + strlen(path);
+
+    pstrcat(path, MAXPATHLEN, filename);
+    f = fopen(path, "r");
+    if (!f) {
+        goto out;
+    }
+
+    fscanf(f, "%u", val);
+    fclose(f);
+
+out:
+    *tail = 0;
+}
+
+static void sg_get_queue_limits(BlockDriverState *bs, const char *filename)
+{
+    DIR *ffs;
+    struct dirent *d;
+    char path[MAXPATHLEN];
+
+    snprintf(path, MAXPATHLEN,
+             "/sys/class/scsi_generic/sg%s/device/block/",
+             filename + strlen("/dev/sg"));
+
+    ffs = opendir(path);
+    if (!ffs) {
+        return;
+    }
+
+    for (;;) {
+        d = readdir(ffs);
+        if (!d) {
+            return;
+        }
+
+        if (strcmp(d->d_name, ".") == 0 || strcmp(d->d_name, "..") == 0) {
+            continue;
+        }
+
+        break;
+    }
+
+    closedir(ffs);
+
+    pstrcat(path, MAXPATHLEN, d->d_name);
+    pstrcat(path, MAXPATHLEN, "/queue/");
+
+    read_queue_limit(path, "max_sectors_kb", &bs->max_sectors);
+    read_queue_limit(path, "max_segments", &bs->max_segments);
+    read_queue_limit(path, "max_segment_size", &bs->max_segment_size);
+}
+
 static int hdev_open(BlockDriverState *bs, const char *filename, int flags)
 {
     BDRVRawState *s = bs->opaque;
@@ -868,6 +925,7 @@ static int hdev_open(BlockDriverState *bs, const char *filename, int flags)
         temp = realpath(filename, resolved_path);
         if (temp && strstart(temp, "/dev/sg", NULL)) {
             bs->sg = 1;
+            sg_get_queue_limits(bs, temp);
         }
     }
 #endif
diff --git a/block_int.h b/block_int.h
index d72317f..a9d07a2 100644
--- a/block_int.h
+++ b/block_int.h
@@ -333,6 +333,10 @@ struct BlockDriverState {
 
     /* long-running background operation */
     BlockJob *job;
+
+    unsigned int max_sectors;
+    unsigned int max_segments;
+    unsigned int max_segment_size;
 };
 
 int get_tmp_filename(char *filename, int size);
diff --git a/blockdev.c b/blockdev.c
index 3d75015..e17edbf 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1191,3 +1191,18 @@ BlockJobInfoList *qmp_query_block_jobs(Error **errp)
     bdrv_iterate(do_qmp_query_block_jobs_one, &prev);
     return dummy.next;
 }
+
+unsigned int get_queue_max_sectors(BlockDriverState *bs)
+{
+    return (bs->file && bs->file->sg) ? bs->file->max_sectors : 0;
+}
+
+unsigned int get_queue_max_segments(BlockDriverState *bs)
+{
+    return (bs->file && bs->file->sg) ? bs->file->max_segments : 0;
+}
+
+unsigned int get_queue_max_segment_size(BlockDriverState *bs)
+{
+    return (bs->file && bs->file->sg) ? bs->file->max_segment_size : 0;
+}
diff --git a/hw/block-common.h b/hw/block-common.h
index bb808f7..d47fcd7 100644
--- a/hw/block-common.h
+++ b/hw/block-common.h
@@ -76,4 +76,7 @@ void hd_geometry_guess(BlockDriverState *bs,
                        int *ptrans);
 int hd_bios_chs_auto_trans(uint32_t cyls, uint32_t heads, uint32_t secs);
 
+unsigned int get_queue_max_sectors(BlockDriverState *bs);
+unsigned int get_queue_max_segments(BlockDriverState *bs);
+unsigned int get_queue_max_segment_size(BlockDriverState *bs);
 #endif
-- 
1.7.7.6
