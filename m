Return-Path: <SRS0=Pjyk=MI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74261C636C8
	for <virtualization@archiver.kernel.org>; Fri, 16 Jul 2021 01:52:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0618E6128A
	for <virtualization@archiver.kernel.org>; Fri, 16 Jul 2021 01:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0618E6128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5B41423CE;
	Fri, 16 Jul 2021 01:52:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MC3ZXIwY9LIS; Fri, 16 Jul 2021 01:52:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1BC8A423C3;
	Fri, 16 Jul 2021 01:52:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1FB5C0010;
	Fri, 16 Jul 2021 01:52:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9662FC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 01:52:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7EC9B607C0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 01:52:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iQtw71VnNRQE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 01:52:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D84DB60792
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 01:52:52 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0Ufw0VTO_1626400369; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0Ufw0VTO_1626400369) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 16 Jul 2021 09:52:50 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: vgoyal@redhat.com
Subject: [PATCH] virtiofsd: support per-file DAX
Date: Fri, 16 Jul 2021 09:52:49 +0800
Message-Id: <20210716015249.86064-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <YPDhv0JJHqbMCyXD@redhat.com>
References: <YPDhv0JJHqbMCyXD@redhat.com>
MIME-Version: 1.0
Cc: linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 bo.liu@linux.alibaba.com, stefanha@redhat.com, miklos@szeredi.hu
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

An example implementation of supporting per-file DAX flag for virtiofsd,
where DAx is enabled for files larger than 1M size.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 contrib/virtiofsd/fuse_kernel.h   | 4 +++-
 contrib/virtiofsd/fuse_lowlevel.c | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/virtiofsd/fuse_kernel.h b/contrib/virtiofsd/fuse_kernel.h
index d2b7ccf96b..9c476b7021 100644
--- a/contrib/virtiofsd/fuse_kernel.h
+++ b/contrib/virtiofsd/fuse_kernel.h
@@ -165,6 +165,8 @@
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
 
+#define FUSE_ATTR_DAX  (1 << 1)
+
 /* Make sure all structures are padded to 64bit boundary, so 32bit
    userspace works under 64bit kernels */
 
@@ -184,7 +186,7 @@ struct fuse_attr {
 	uint32_t	gid;
 	uint32_t	rdev;
 	uint32_t	blksize;
-	uint32_t	padding;
+	uint32_t	flags;
 };
 
 struct fuse_kstatfs {
diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_lowlevel.c
index 046a1b4a02..d8a3873246 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -60,6 +60,9 @@ static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr)
 	attr->atimensec = ST_ATIM_NSEC(stbuf);
 	attr->mtimensec = ST_MTIM_NSEC(stbuf);
 	attr->ctimensec = ST_CTIM_NSEC(stbuf);
+
+	if (stbuf->st_size >= 1048576)
+		attr->flags |= FUSE_ATTR_DAX;
 }
 
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
