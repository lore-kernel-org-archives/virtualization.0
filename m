Return-Path: <SRS0=IaGE=IX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A05FC433C1
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 11:25:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7B261A27
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 11:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7B261A27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6E7AB40530;
	Thu, 25 Mar 2021 11:25:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NoGPfXN-vMKc; Thu, 25 Mar 2021 11:25:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id EB92540183;
	Thu, 25 Mar 2021 11:25:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA6F7C000D;
	Thu, 25 Mar 2021 11:25:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34EB7C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 11:25:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2867B40E76
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 11:25:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tO4HfFGJC48b
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 11:25:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7264B40E59
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 11:25:02 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0790861A23;
 Thu, 25 Mar 2021 11:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616671501;
 bh=Fzdx5aZ7zCEqKQPLAHn/8eKtaEqL4xhrG7HXdzrDLGw=;
 h=From:To:Cc:Subject:Date:From;
 b=finq/th1Qi3LP0Dg0D2ILCjo8cf9NS7hHpXq6EQXxT/FjDtU6mXiTTX5WACx3finu
 zxz0kOUCYkjhHEA3HGcboc+b14BQ+pNVjtJbyA8m5M53XFVfkADRD5I5HsalBMw6n0
 ufUCXq1JQCPGWr2jxjChGbojA7AlFEHe1cgOlZlp002Fmh8sWmG7UHO4+CyCdAlJfJ
 UgxfYgtTh2SXAQIfU5U92yRlDQHl3eYJ3uk2KMp6wqDKaff1l5sf3z1JzGgIrGbGlm
 6vK3hWkwuDHpwsCbEkWGGttvDdv/6UdvSHN7ArOR8tSkl0W2aEgv0KSujdOboZOTyJ
 CGgGMoGw4+htw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 01/44] virtiofs: Fail dax mount if device does
 not support it
Date: Thu, 25 Mar 2021 07:24:16 -0400
Message-Id: <20210325112459.1926846-1-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org,
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

From: Vivek Goyal <vgoyal@redhat.com>

[ Upstream commit 3f9b9efd82a84f27e95d0414f852caf1fa839e83 ]

Right now "mount -t virtiofs -o dax myfs /mnt/virtiofs" succeeds even
if filesystem deivce does not have a cache window and hence DAX can't
be supported.

This gives a false sense to user that they are using DAX with virtiofs
but fact of the matter is that they are not.

Fix this by returning error if dax can't be supported and user has asked
for it.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/virtio_fs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 8868ac31a3c0..4ee6f734ba83 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1324,8 +1324,15 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
 
 	/* virtiofs allocates and installs its own fuse devices */
 	ctx->fudptr = NULL;
-	if (ctx->dax)
+	if (ctx->dax) {
+		if (!fs->dax_dev) {
+			err = -EINVAL;
+			pr_err("virtio-fs: dax can't be enabled as filesystem"
+			       " device does not support it.\n");
+			goto err_free_fuse_devs;
+		}
 		ctx->dax_dev = fs->dax_dev;
+	}
 	err = fuse_fill_super_common(sb, ctx);
 	if (err < 0)
 		goto err_free_fuse_devs;
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
