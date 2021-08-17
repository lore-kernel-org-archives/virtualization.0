Return-Path: <SRS0=dYih=NI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF88C00144
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 02:22:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E5C60F55
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 02:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96E5C60F55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EE4A8379C;
	Tue, 17 Aug 2021 02:22:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ncga-FA_ZrLN; Tue, 17 Aug 2021 02:22:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4AC4583753;
	Tue, 17 Aug 2021 02:22:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C4D9C0010;
	Tue, 17 Aug 2021 02:22:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2D75C0025
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 02:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E0996079A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 02:22:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eIAnwvYnWB_q
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 02:22:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 94E58607C5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 02:22:25 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UjHTKZC_1629166942; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UjHTKZC_1629166942) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 17 Aug 2021 10:22:22 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: vgoyal@redhat.com,
	stefanha@redhat.com,
	miklos@szeredi.hu
Subject: [PATCH v4 4/8] fuse: negotiate if server/client supports per-file DAX
Date: Tue, 17 Aug 2021 10:22:16 +0800
Message-Id: <20210817022220.17574-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
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

Among the FUSE_INIT phase, server/client shall negotiate if supporting
per-file DAX.

Requirements for server:
- capable of handling SETFLAGS/FSSETXATTR ioctl and storing
  FS_DAX_FL/FS_XFLAG_DAX persistently.
- set FUSE_ATTR_DAX if the file capable of per-file DAX when replying
  FUSE_LOOKUP request accordingly.

Requirements for client:
- capable of handling per-file DAX when receiving FUSE_ATTR_DAX.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/fuse_i.h |  3 +++
 fs/fuse/inode.c  | 12 ++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index a23dd8d0c181..0b21e76a379a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -770,6 +770,9 @@ struct fuse_conn {
 	/* Propagate syncfs() to server */
 	unsigned int sync_fs:1;
 
+	/* Does the filesystem support per-file DAX? */
+	unsigned int perfile_dax:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 0bc0d8af81e1..9d302079281c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1087,10 +1087,12 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 					min_t(unsigned int, fc->max_pages_limit,
 					max_t(unsigned int, arg->max_pages, 1));
 			}
-			if (IS_ENABLED(CONFIG_FUSE_DAX) &&
-			    arg->flags & FUSE_MAP_ALIGNMENT &&
-			    !fuse_dax_check_alignment(fc, arg->map_alignment)) {
-				ok = false;
+			if (IS_ENABLED(CONFIG_FUSE_DAX)) {
+				if (arg->flags & FUSE_MAP_ALIGNMENT &&
+				    !fuse_dax_check_alignment(fc, arg->map_alignment))
+					ok = false;
+				if (arg->flags & FUSE_PERFILE_DAX)
+					fc->perfile_dax = 1;
 			}
 			if (arg->flags & FUSE_HANDLE_KILLPRIV_V2) {
 				fc->handle_killpriv_v2 = 1;
@@ -1145,6 +1147,8 @@ void fuse_send_init(struct fuse_mount *fm)
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		ia->in.flags |= FUSE_MAP_ALIGNMENT;
+	if (fm->fc->dax_mode == FUSE_DAX_INODE)
+		ia->in.flags |= FUSE_PERFILE_DAX;
 #endif
 	if (fm->fc->auto_submounts)
 		ia->in.flags |= FUSE_SUBMOUNTS;
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
