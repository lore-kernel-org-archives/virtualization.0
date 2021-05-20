Return-Path: <SRS0=jrxE=KP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFA5C433ED
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 15:53:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E308C610CC
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 15:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E308C610CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A55EA404D1;
	Thu, 20 May 2021 15:53:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xdZKbqLZhSQp; Thu, 20 May 2021 15:53:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 67AD540179;
	Thu, 20 May 2021 15:53:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43246C000D;
	Thu, 20 May 2021 15:53:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D09DAC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 15:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B185B842CD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 15:53:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id buRxKWmDLwXV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 15:53:27 +0000 (UTC)
X-Greylist: delayed 00:06:16 by SQLgrey-1.8.0
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A19883CB9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 15:53:27 +0000 (UTC)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-vupLqh65Oji912do6_HGVA-1; Thu, 20 May 2021 11:47:05 -0400
X-MC-Unique: vupLqh65Oji912do6_HGVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA3DA79EC4;
 Thu, 20 May 2021 15:47:04 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-99.ams2.redhat.com [10.36.112.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2DE310016F4;
 Thu, 20 May 2021 15:46:55 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v4 0/5] virtiofs: propagate sync() to file server
Date: Thu, 20 May 2021 17:46:49 +0200
Message-Id: <20210520154654.1791183-1-groug@kaod.org>
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

This was a single patch until v3. Some preliminary cleanups were
introduced for submounts in this v4.

This can be tested with a custom virtiofsd implementing FUSE_SYNCFS, here:

https://gitlab.com/gkurz/qemu/-/tree/fuse-sync

v4: - submount fixes
    - set nodeid of the superblock in the request (Miklos)

v3: - just keep a 64-bit padding field in the arg struct (Vivek)

v2: - clarify compatibility with older servers in changelog (Vivek)
    - ignore the wait == 0 case (Miklos)
    - 64-bit aligned argument structure (Vivek, Miklos)

Greg Kurz (5):
  fuse: Fix leak in fuse_dentry_automount() error path
  fuse: Call vfs_get_tree() for submounts
  fuse: Make fuse_fill_super_submount() static
  virtiofs: Skip submounts in sget_fc()
  virtiofs: propagate sync() to file server

 fs/fuse/dir.c             | 45 +++++---------------
 fs/fuse/fuse_i.h          | 12 +++---
 fs/fuse/inode.c           | 87 ++++++++++++++++++++++++++++++++++++++-
 fs/fuse/virtio_fs.c       |  9 ++++
 include/uapi/linux/fuse.h | 10 ++++-
 5 files changed, 120 insertions(+), 43 deletions(-)

-- 
2.26.3


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
