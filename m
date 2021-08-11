Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240A5C432BE
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 06:56:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86FCE6024A
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 06:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 86FCE6024A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 414C9403EF;
	Wed, 11 Aug 2021 06:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oB07tp1vdxcS; Wed, 11 Aug 2021 06:56:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C082740493;
	Wed, 11 Aug 2021 06:56:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84F92C0024;
	Wed, 11 Aug 2021 06:56:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51171C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 06:56:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0D2E7607E4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 06:56:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c1bu5tCPVtMY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 06:56:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 212B960832
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 06:56:25 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=jefflexu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0UifQe5z_1628664982; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UifQe5z_1628664982) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 11 Aug 2021 14:56:23 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: vgoyal@redhat.com,
	stefanha@redhat.com,
	miklos@szeredi.hu
Subject: [virtiofsd PATCH v2 3/4] virtiofsd: support per-file DAX negotiation
 in FUSE_INIT
Date: Wed, 11 Aug 2021 14:56:20 +0800
Message-Id: <20210811065621.12737-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210811065621.12737-1-jefflexu@linux.alibaba.com>
References: <20210804070653.118123-1-jefflexu@linux.alibaba.com>
 <20210811065621.12737-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Cc: linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
 bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

In FUSE_INIT negotiating phase, server/client should advertise if it
supports per-file DAX.

Once advertising support for per-file DAX feature, virtiofsd should
support storing FS_DAX_FL flag persistently passed by
FS_IOC_SETFLAGS/FS_IOC_FSSETXATTR ioctl, and set FUSE_ATTR_DAX in
FUSE_LOOKUP accordingly if the file is capable of per-file DAX.

Currently only ext4/xfs since linux kernel v5.8 support storing
FS_DAX_FL flag persistently, and thus advertise support for per-file
DAX feature only when the backend fs type is ext4 and xfs.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 tools/virtiofsd/fuse_common.h    |  5 +++++
 tools/virtiofsd/fuse_lowlevel.c  |  6 ++++++
 tools/virtiofsd/passthrough_ll.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/tools/virtiofsd/fuse_common.h b/tools/virtiofsd/fuse_common.h
index 8a75729be9..ee6fc64c23 100644
--- a/tools/virtiofsd/fuse_common.h
+++ b/tools/virtiofsd/fuse_common.h
@@ -372,6 +372,11 @@ struct fuse_file_info {
  */
 #define FUSE_CAP_HANDLE_KILLPRIV_V2 (1 << 28)
 
+/**
+ * Indicates support for per-file DAX.
+ */
+#define FUSE_CAP_PERFILE_DAX (1 << 29)
+
 /**
  * Ioctl flags
  *
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
index 50fc5c8d5a..04a4f17423 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2065,6 +2065,9 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid,
     if (arg->flags & FUSE_HANDLE_KILLPRIV_V2) {
         se->conn.capable |= FUSE_CAP_HANDLE_KILLPRIV_V2;
     }
+    if (arg->flags & FUSE_PERFILE_DAX) {
+        se->conn.capable |= FUSE_CAP_PERFILE_DAX;
+    }
 #ifdef HAVE_SPLICE
 #ifdef HAVE_VMSPLICE
     se->conn.capable |= FUSE_CAP_SPLICE_WRITE | FUSE_CAP_SPLICE_MOVE;
@@ -2180,6 +2183,9 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid,
     if (se->conn.want & FUSE_CAP_POSIX_ACL) {
         outarg.flags |= FUSE_POSIX_ACL;
     }
+    if (se->op.ioctl && (se->conn.want & FUSE_CAP_PERFILE_DAX)) {
+        outarg.flags |= FUSE_PERFILE_DAX;
+    }
     outarg.max_readahead = se->conn.max_readahead;
     outarg.max_write = se->conn.max_write;
     if (se->conn.max_background >= (1 << 16)) {
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index e170b17adb..5b6228210f 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -53,8 +53,10 @@
 #include <sys/syscall.h>
 #include <sys/wait.h>
 #include <sys/xattr.h>
+#include <sys/vfs.h>
 #include <syslog.h>
 #include <linux/fs.h>
+#include <linux/magic.h>
 
 #include "qemu/cutils.h"
 #include "passthrough_helpers.h"
@@ -136,6 +138,13 @@ enum {
     SANDBOX_CHROOT,
 };
 
+/* capability of storing DAX flag persistently */
+enum {
+    DAX_CAP_NONE,  /* not supported */
+    DAX_CAP_FLAGS, /* stored in flags (FS_IOC_GETFLAGS/FS_IOC_SETFLAGS) */
+    DAX_CAP_XATTR, /* stored in xflags (FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR) */
+};
+
 typedef struct xattr_map_entry {
     char *key;
     char *prepend;
@@ -161,6 +170,7 @@ struct lo_data {
     int readdirplus_clear;
     int allow_direct_io;
     int announce_submounts;
+    int perfile_dax_cap; /* capability of backend fs */
     bool use_statx;
     struct lo_inode root;
     GHashTable *inodes; /* protected by lo->mutex */
@@ -703,6 +713,10 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
         conn->want &= ~FUSE_CAP_HANDLE_KILLPRIV_V2;
         lo->killpriv_v2 = 0;
     }
+
+    if (conn->capable & FUSE_CAP_PERFILE_DAX && lo->perfile_dax_cap ) {
+        conn->want |= FUSE_CAP_PERFILE_DAX;
+    }
 }
 
 static void lo_getattr(fuse_req_t req, fuse_ino_t ino,
@@ -3800,6 +3814,7 @@ static void setup_root(struct lo_data *lo, struct lo_inode *root)
     int fd, res;
     struct stat stat;
     uint64_t mnt_id;
+    struct statfs statfs;
 
     fd = open("/", O_PATH);
     if (fd == -1) {
@@ -3826,6 +3841,20 @@ static void setup_root(struct lo_data *lo, struct lo_inode *root)
         root->posix_locks = g_hash_table_new_full(
             g_direct_hash, g_direct_equal, NULL, posix_locks_value_destroy);
     }
+
+    /*
+     * Currently only ext4/xfs since linux kernel v5.8 support storing
+     * FS_DAX_FL flag persistently. Ext4 accesses this flag through
+     * FS_IOC_G[S]ETFLAGS ioctl, while xfs accesses this flag through
+     * FS_IOC_FSG[S]ETXATTR ioctl.
+     */
+    res = fstatfs(fd, &statfs);
+    if (!res) {
+	if (statfs.f_type == EXT4_SUPER_MAGIC)
+	    lo->perfile_dax_cap = DAX_CAP_FLAGS;
+	else if (statfs.f_type == XFS_SUPER_MAGIC)
+	    lo->perfile_dax_cap = DAX_CAP_XATTR;
+    }
 }
 
 static guint lo_key_hash(gconstpointer key)
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
