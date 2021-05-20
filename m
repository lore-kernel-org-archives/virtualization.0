Return-Path: <SRS0=jrxE=KP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADBBC433ED
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 15:47:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE07C610CC
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 15:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE07C610CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74ADD60BD7;
	Thu, 20 May 2021 15:47:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IZsR6300eEls; Thu, 20 May 2021 15:47:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31B3560BA1;
	Thu, 20 May 2021 15:47:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08CF1C000D;
	Thu, 20 May 2021 15:47:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E02CC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 15:47:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 373B340EE2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 15:47:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fp2zHWFazLdT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 15:47:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [207.211.30.44])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 462B940E9B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 15:47:14 +0000 (UTC)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-1lUyBVChNhe7Z27CTXJhgg-1; Thu, 20 May 2021 11:47:09 -0400
X-MC-Unique: 1lUyBVChNhe7Z27CTXJhgg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E956107ACCA;
 Thu, 20 May 2021 15:47:07 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-99.ams2.redhat.com [10.36.112.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FAE610016F4;
 Thu, 20 May 2021 15:47:04 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v4 1/5] fuse: Fix leak in fuse_dentry_automount() error path
Date: Thu, 20 May 2021 17:46:50 +0200
Message-Id: <20210520154654.1791183-2-groug@kaod.org>
In-Reply-To: <20210520154654.1791183-1-groug@kaod.org>
References: <20210520154654.1791183-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Cc: linux-kernel@vger.kernel.org, Max Reitz <mreitz@redhat.com>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Vivek Goyal <vgoyal@redhat.com>
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

Some rollback was forgotten during the addition of crossmounts.

Fixes: bf109c64040f ("fuse: implement crossmounts")
Cc: mreitz@redhat.com
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fs/fuse/dir.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1b6c001a7dd1..fb2af70596c3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -339,8 +339,11 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
 
 	/* Initialize superblock, making @mp_fi its root */
 	err = fuse_fill_super_submount(sb, mp_fi);
-	if (err)
+	if (err) {
+		fuse_conn_put(fc);
+		kfree(fm);
 		goto out_put_sb;
+	}
 
 	sb->s_flags |= SB_ACTIVE;
 	fsc->root = dget(sb->s_root);
-- 
2.26.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
