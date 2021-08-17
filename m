Return-Path: <SRS0=dYih=NI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667DAC4338F
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 02:22:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A86460E78
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 02:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2A86460E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7FBA404B0;
	Tue, 17 Aug 2021 02:22:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NTNP7dtiwWqk; Tue, 17 Aug 2021 02:22:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AEADC404B6;
	Tue, 17 Aug 2021 02:22:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F2B5C0023;
	Tue, 17 Aug 2021 02:22:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A8BCC0023
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 02:22:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 32DB6402C9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 02:22:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GwPfz05d2fXY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 02:22:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9EE1040012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 02:22:24 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R981e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UjH7KAY_1629166940; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UjH7KAY_1629166940) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 17 Aug 2021 10:22:21 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: vgoyal@redhat.com,
	stefanha@redhat.com,
	miklos@szeredi.hu
Subject: [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
Date: Tue, 17 Aug 2021 10:22:12 +0800
Message-Id: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
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

This patchset adds support of per-file DAX for virtiofs, which is
inspired by Ira Weiny's work on ext4[1] and xfs[2].

Any comment is welcome.

[1] commit 9cb20f94afcd ("fs/ext4: Make DAX mount option a tri-state")
[2] commit 02beb2686ff9 ("fs/xfs: Make DAX mount option a tri-state")


changes since v3:
- bug fix (patch 6): s/"IS_DAX(inode) != newdax"/"!!IS_DAX(inode) != newdax"
- during FUSE_INIT, advertise capability for per-file DAX only when
  mounted as "-o dax=inode" (patch 4)

changes since v2:
- modify fuse_show_options() accordingly to make it compatible with
  new tri-state mount option (patch 2)
- extract FUSE protocol changes into one seperate patch (patch 3)
- FUSE server/client need to negotiate if they support per-file DAX
  (patch 4)
- extract DONT_CACHE logic into patch 6/7

v3: https://www.spinics.net/lists/linux-fsdevel/msg200852.html
v2: https://www.spinics.net/lists/linux-fsdevel/msg199584.html
v1: https://www.spinics.net/lists/linux-virtualization/msg51008.html

Jeffle Xu (8):
  fuse: add fuse_should_enable_dax() helper
  fuse: Make DAX mount option a tri-state
  fuse: support per-file DAX
  fuse: negotiate if server/client supports per-file DAX
  fuse: enable per-file DAX
  fuse: mark inode DONT_CACHE when per-file DAX indication changes
  fuse: support changing per-file DAX flag inside guest
  fuse: show '-o dax=inode' option only when FUSE server supports

 fs/fuse/dax.c             | 32 +++++++++++++++++++++++++++++---
 fs/fuse/file.c            |  4 ++--
 fs/fuse/fuse_i.h          | 22 ++++++++++++++++++----
 fs/fuse/inode.c           | 27 +++++++++++++++++++--------
 fs/fuse/ioctl.c           | 15 +++++++++++++--
 fs/fuse/virtio_fs.c       | 16 ++++++++++++++--
 include/uapi/linux/fuse.h |  9 ++++++++-
 7 files changed, 103 insertions(+), 22 deletions(-)

-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
