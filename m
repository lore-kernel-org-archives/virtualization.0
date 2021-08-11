Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C21CC4320A
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 06:56:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2230460FC3
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 06:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2230460FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E400A826E7;
	Wed, 11 Aug 2021 06:56:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vh5k6nwhqhGZ; Wed, 11 Aug 2021 06:56:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6F39A827A8;
	Wed, 11 Aug 2021 06:56:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44F54C0010;
	Wed, 11 Aug 2021 06:56:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10FDBC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 06:56:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA34F607CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 06:56:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MAmPAnWkTx46
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 06:56:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DCBE4607E4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 06:56:25 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R431e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UifQe5o_1628664982; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UifQe5o_1628664982) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 11 Aug 2021 14:56:22 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: vgoyal@redhat.com,
	stefanha@redhat.com,
	miklos@szeredi.hu
Subject: [virtiofsd PATCH v2 1/4] virtiofsd: add .ioctl() support
Date: Wed, 11 Aug 2021 14:56:18 +0800
Message-Id: <20210811065621.12737-2-jefflexu@linux.alibaba.com>
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

Add .ioctl() support for passthrough, in prep for the following support
for following per-file DAX feature.

Once advertising support for per-file DAX feature, virtiofsd should
support storing FS_DAX_FL flag persistently passed by
FS_IOC_SETFLAGS/FS_IOC_FSSETXATTR ioctl, and set FUSE_ATTR_DAX in
FUSE_LOOKUP accordingly if the file is capable of per-file DAX.

When it comes to passthrough, it passes corresponding ioctls to host
directly. Currently only these ioctls that are needed for per-file DAX
feature, i.e., FS_IOC_GETFLAGS/FS_IOC_SETFLAGS and
FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR are supported. Later we can restrict
the flags/attributes allowed to be set to reinforce the security, or
extend the scope of allowed ioctls if it is really needed later.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 tools/virtiofsd/passthrough_ll.c      | 53 +++++++++++++++++++++++++++
 tools/virtiofsd/passthrough_seccomp.c |  1 +
 2 files changed, 54 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index b76d878509..e170b17adb 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -54,6 +54,7 @@
 #include <sys/wait.h>
 #include <sys/xattr.h>
 #include <syslog.h>
+#include <linux/fs.h>
 
 #include "qemu/cutils.h"
 #include "passthrough_helpers.h"
@@ -2105,6 +2106,57 @@ out:
     fuse_reply_err(req, saverr);
 }
 
+static void lo_ioctl(fuse_req_t req, fuse_ino_t ino, unsigned int cmd, void *arg,
+                  struct fuse_file_info *fi, unsigned flags, const void *in_buf,
+                  size_t in_bufsz, size_t out_bufsz)
+{
+    int fd = lo_fi_fd(req, fi);
+    int res;
+    int saverr = ENOSYS;
+
+    fuse_log(FUSE_LOG_DEBUG, "lo_ioctl(ino=%" PRIu64 ", cmd=0x%x, flags=0x%x, "
+	     "in_bufsz = %lu, out_bufsz = %lu)\n",
+	     ino, cmd, flags, in_bufsz, out_bufsz);
+
+    /* unrestricted ioctl is not supported yet */
+    if (flags & FUSE_IOCTL_UNRESTRICTED)
+        goto out;
+
+    /*
+     * Currently only those ioctls needed to support per-file DAX feature,
+     * i.e., FS_IOC_GETFLAGS/FS_IOC_SETFLAGS and
+     * FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR are supported.
+     */
+    if (cmd == FS_IOC_SETFLAGS || cmd == FS_IOC_FSSETXATTR) {
+        res = ioctl(fd, cmd, in_buf);
+        if (res < 0)
+            goto out_err;
+
+	fuse_reply_ioctl(req, 0, NULL, 0);
+    }
+    else if (cmd == FS_IOC_GETFLAGS || cmd == FS_IOC_FSGETXATTR) {
+	/* reused for 'unsigned int' for FS_IOC_GETFLAGS */
+	struct fsxattr attr;
+
+        res = ioctl(fd, cmd, &attr);
+        if (res < 0)
+            goto out_err;
+
+        fuse_reply_ioctl(req, 0, &attr, out_bufsz);
+    }
+    else {
+	fuse_log(FUSE_LOG_DEBUG, "Unsupported ioctl 0x%x\n", cmd);
+	goto out;
+    }
+
+    return;
+
+out_err:
+	saverr = errno;
+out:
+	fuse_reply_err(req, saverr);
+}
+
 static void lo_fsyncdir(fuse_req_t req, fuse_ino_t ino, int datasync,
                         struct fuse_file_info *fi)
 {
@@ -3279,6 +3331,7 @@ static struct fuse_lowlevel_ops lo_oper = {
     .create = lo_create,
     .getlk = lo_getlk,
     .setlk = lo_setlk,
+    .ioctl = lo_ioctl,
     .open = lo_open,
     .release = lo_release,
     .flush = lo_flush,
diff --git a/tools/virtiofsd/passthrough_seccomp.c b/tools/virtiofsd/passthrough_seccomp.c
index 62441cfcdb..2a5f7614fc 100644
--- a/tools/virtiofsd/passthrough_seccomp.c
+++ b/tools/virtiofsd/passthrough_seccomp.c
@@ -62,6 +62,7 @@ static const int syscall_allowlist[] = {
     SCMP_SYS(gettid),
     SCMP_SYS(gettimeofday),
     SCMP_SYS(getxattr),
+    SCMP_SYS(ioctl),
     SCMP_SYS(linkat),
     SCMP_SYS(listxattr),
     SCMP_SYS(lseek),
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
