Return-Path: <SRS0=Pjyk=MI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F86C12002
	for <virtualization@archiver.kernel.org>; Fri, 16 Jul 2021 10:48:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5037C613FC
	for <virtualization@archiver.kernel.org>; Fri, 16 Jul 2021 10:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5037C613FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D67042472;
	Fri, 16 Jul 2021 10:48:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UggSVNA1wLfE; Fri, 16 Jul 2021 10:48:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 580274243E;
	Fri, 16 Jul 2021 10:48:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33A61C0010;
	Fri, 16 Jul 2021 10:48:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCFC1C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 10:47:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACC9460D5E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 10:47:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iIiUtPsEbrN7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 10:47:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B362660AB2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 10:47:58 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UfyYkGE_1626432475; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UfyYkGE_1626432475) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 16 Jul 2021 18:47:55 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: vgoyal@redhat.com,
	stefanha@redhat.com,
	miklos@szeredi.hu
Subject: [PATCH v2 4/4] fuse: support changing per-file DAX flag inside guest
Date: Fri, 16 Jul 2021 18:47:53 +0800
Message-Id: <20210716104753.74377-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Cc: linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 bo.liu@linux.alibaba.com, virtualization@lists.linux-foundation.org
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

Fuse client can enable or disable per-file DAX inside guest by
chattr(1). Similarly the new state won't be updated until the file is
closed and reopened later.

It is worth nothing that it is a best-effort style, since whether
per-file DAX is enabled or not is controlled by fuse_attr.flags retrieved
by FUSE LOOKUP routine, while the algorithm constructing fuse_attr.flags
is totally fuse server specific, not to mention ioctl may not be
supported by fuse server at all.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/ioctl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 546ea3d58fb4..172e05c3f038 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -460,6 +460,7 @@ int fuse_fileattr_set(struct user_namespace *mnt_userns,
 	struct fuse_file *ff;
 	unsigned int flags = fa->flags;
 	struct fsxattr xfa;
+	bool newdax;
 	int err;
 
 	ff = fuse_priv_ioctl_prepare(inode);
@@ -467,10 +468,9 @@ int fuse_fileattr_set(struct user_namespace *mnt_userns,
 		return PTR_ERR(ff);
 
 	if (fa->flags_valid) {
+		newdax = flags & FS_DAX_FL;
 		err = fuse_priv_ioctl(inode, ff, FS_IOC_SETFLAGS,
 				      &flags, sizeof(flags));
-		if (err)
-			goto cleanup;
 	} else {
 		memset(&xfa, 0, sizeof(xfa));
 		xfa.fsx_xflags = fa->fsx_xflags;
@@ -479,11 +479,14 @@ int fuse_fileattr_set(struct user_namespace *mnt_userns,
 		xfa.fsx_projid = fa->fsx_projid;
 		xfa.fsx_cowextsize = fa->fsx_cowextsize;
 
+		newdax = fa->fsx_xflags & FS_XFLAG_DAX;
 		err = fuse_priv_ioctl(inode, ff, FS_IOC_FSSETXATTR,
 				      &xfa, sizeof(xfa));
 	}
 
-cleanup:
+	if (!err && IS_ENABLED(CONFIG_FUSE_DAX))
+		fuse_dax_dontcache(inode, newdax);
+
 	fuse_priv_ioctl_cleanup(inode, ff);
 
 	return err;
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
