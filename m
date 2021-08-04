Return-Path: <SRS0=5nkl=M3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53491C4338F
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 07:07:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02EA760F35
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 07:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 02EA760F35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C5EF640266;
	Wed,  4 Aug 2021 07:07:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oDIHYZqfDkF4; Wed,  4 Aug 2021 07:07:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 12B63401FD;
	Wed,  4 Aug 2021 07:07:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D68A0C001A;
	Wed,  4 Aug 2021 07:07:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A3E4C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 07:07:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08CAF40209
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 07:07:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bvhpaYpoPfqI
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 07:06:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 755F1401E7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 07:06:58 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04420; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UhwYsm6_1628060815; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UhwYsm6_1628060815) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 04 Aug 2021 15:06:55 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: vgoyal@redhat.com,
	stefanha@redhat.com,
	miklos@szeredi.hu
Subject: [PATCH v3 6/8] fuse: mark inode DONT_CACHE when per-file DAX
 indication changes
Date: Wed,  4 Aug 2021 15:06:51 +0800
Message-Id: <20210804070653.118123-7-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210804070653.118123-1-jefflexu@linux.alibaba.com>
References: <20210804070653.118123-1-jefflexu@linux.alibaba.com>
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

When the per-file DAX indication changes while the file is still
*opened*, it is quite complicated and maybe fragile to dynamically
change the DAX state.

Hence mark the inode and corresponding dentries as DONE_CACHE once the
per-file DAX indication changes, so that the inode instance will be
evicted and freed as soon as possible once the file is closed and the
last reference to the inode is put. And then when the file gets reopened
next time, the inode will reflect the new DAX state.

In summary, when the per-file DAX indication changes for an *opened*
file, the state of the file won't be updated until this file is closed
and reopened later.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/dax.c    | 9 +++++++++
 fs/fuse/fuse_i.h | 1 +
 fs/fuse/inode.c  | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 30833f8d37dd..14bc5b9a0576 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1364,6 +1364,15 @@ void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
 	inode->i_data.a_ops = &fuse_dax_file_aops;
 }
 
+void fuse_dax_dontcache(struct inode *inode, bool newdax)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	if (fc->dax_mode == FUSE_DAX_INODE &&
+	    fc->perfile_dax && IS_DAX(inode) != newdax)
+		d_mark_dontcache(inode);
+}
+
 bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment)
 {
 	if (fc->dax && (map_alignment > FUSE_DAX_SHIFT)) {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7b7b4c208af2..56fe1c4d2136 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1260,6 +1260,7 @@ void fuse_dax_conn_free(struct fuse_conn *fc);
 bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
 void fuse_dax_inode_init(struct inode *inode, unsigned int flags);
 void fuse_dax_inode_cleanup(struct inode *inode);
+void fuse_dax_dontcache(struct inode *inode, bool newdax);
 bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
 void fuse_dax_cancel_work(struct fuse_conn *fc);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 882c376f188b..9108d8ab39bc 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -269,6 +269,9 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 		if (inval)
 			invalidate_inode_pages2(inode->i_mapping);
 	}
+
+	if (IS_ENABLED(CONFIG_FUSE_DAX))
+		fuse_dax_dontcache(inode, attr->flags & FUSE_ATTR_DAX);
 }
 
 static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
