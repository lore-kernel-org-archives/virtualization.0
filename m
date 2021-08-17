Return-Path: <SRS0=dYih=NI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E99C4338F
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 02:24:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23BE060F58
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 02:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 23BE060F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3986583720;
	Tue, 17 Aug 2021 02:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GGXXCwQilCCx; Tue, 17 Aug 2021 02:23:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7B9E583759;
	Tue, 17 Aug 2021 02:23:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DD91C0023;
	Tue, 17 Aug 2021 02:23:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E55F8C0010
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 02:23:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C6D46404B6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 02:23:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EJUehkgNsFN1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 02:23:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 042F1404B3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 02:23:50 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R261e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UjH5Rbe_1629167027; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0UjH5Rbe_1629167027) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 17 Aug 2021 10:23:47 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: vgoyal@redhat.com,
	stefanha@redhat.com,
	miklos@szeredi.hu
Subject: [virtiofsd PATCH v4 0/4] virtiofsd: support per-file DAX
Date: Tue, 17 Aug 2021 10:23:43 +0800
Message-Id: <20210817022347.18098-1-jefflexu@linux.alibaba.com>
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

I mentioned in virtiofsd PATCH v1 that virtiofsd exits once ioctl() is
called. After depper investigation into this issue, I find that it is
because ioctl() is blocked out the whitelist of seccomp of virtiofsd.

To support ioctl, ioctl syscall shall be added into the whitelist (see
patch
1).

And this is the complete workable version for virtiofsd:
- virtiofsd now supports FUSE_IOCTL now, though currently only
  FS_IOC_G[S]ETFLAGS/FS_IOC_FSG[S]ETXATTR are supported.
- During FUSE_INIT, virtiofsd advertise support for per-file DAX only
  when the backend fs is ext4/xfs.
- FS_IOC_SETFLAGS/FS_IOC_FSSETXATTR FUSE_IOCTL will be directed to host,
  so that FS_DAX_FL could be flushed to backed fs persistently.
- During FUSE_LOOKUP, virtiofsd will decide DAX shall be enabled for
  current file according to if this file is marked with FS_DAX_FL in the
  backend fs.


changes since v2/v3:
Patch 4 in v2 is incomplete by mistake and it will fail to be compiled.
I had ever sent a seperate patch 4 of v3. Now I send the whole complete
set in v4. Except for this, there's no other diferrence.

Jeffle Xu (4):
  virtiofsd: add .ioctl() support
  virtiofsd: expand fuse protocol to support per-file DAX
  virtiofsd: support per-file DAX negotiation in FUSE_INIT
  virtiofsd: support per-file DAX in FUSE_LOOKUP

 include/standard-headers/linux/fuse.h |   2 +
 tools/virtiofsd/fuse_common.h         |   5 ++
 tools/virtiofsd/fuse_lowlevel.c       |   6 ++
 tools/virtiofsd/passthrough_ll.c      | 125 ++++++++++++++++++++++++++
 tools/virtiofsd/passthrough_seccomp.c |   1 +
 5 files changed, 139 insertions(+)

-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
