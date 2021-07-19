Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8351CC07E95
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 21:30:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06EB7610C7
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 21:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06EB7610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A47CE40365;
	Mon, 19 Jul 2021 21:30:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fUKiVp_VjaEa; Mon, 19 Jul 2021 21:30:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EF7D440363;
	Mon, 19 Jul 2021 21:30:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFB64C001A;
	Mon, 19 Jul 2021 21:30:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AAC8C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 21:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 17F87402AA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 21:30:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cefKygN_gpg7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 21:30:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 96DEB400B8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 21:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626730212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dG16gNlXaHcUyckB4zj2EV2whasjEhhcwORskpcNxoE=;
 b=VsjcIP5g4EgAUi7RWucOC4j1CMLplZVnyAT5FBm7Sn/b9sBM6yGUsU4H1VEsoUmQvUFRzs
 rlHHHV+ao2UPyIy4SO6Va94L66mSZ0B3NyZTbcQiWnu8BBH/LlMl6ZzncdfTd14eGE16cl
 ru9lIhrdmUpXpJ2Qc/5ldY72b9uvAog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-3m2FqKCxPaiSMo1jWbqsxA-1; Mon, 19 Jul 2021 17:30:11 -0400
X-MC-Unique: 3m2FqKCxPaiSMo1jWbqsxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AB10362F8;
 Mon, 19 Jul 2021 21:30:09 +0000 (UTC)
Received: from horse.redhat.com (ovpn-118-17.rdu2.redhat.com [10.10.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A92535D9D3;
 Mon, 19 Jul 2021 21:30:04 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 32E71223E4F; Mon, 19 Jul 2021 17:30:04 -0400 (EDT)
Date: Mon, 19 Jul 2021 17:30:04 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v2 0/4] virtiofs,fuse: support per-file DAX
Message-ID: <YPXu3BefIi7Ts48I@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: miklos@szeredi.hu, virtualization@lists.linux-foundation.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org
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

On Fri, Jul 16, 2021 at 06:47:49PM +0800, Jeffle Xu wrote:
> This patchset adds support of per-file DAX for virtiofs, which is
> inspired by Ira Weiny's work on ext4[1] and xfs[2].
> 
> There are three related scenarios:
> 1. Alloc inode: get per-file DAX flag from fuse_attr.flags. (patch 3)
> 2. Per-file DAX flag changes when the file has been opened. (patch 3)
> In this case, the dentry and inode are all marked as DONT_CACHE, and
> the DAX state won't be updated until the file is closed and reopened
> later.
> 3. Users can change the per-file DAX flag inside the guest by chattr(1).
> (patch 4)
> 4. Create new files under directories with DAX enabled. When creating
> new files in ext4/xfs on host, the new created files will inherit the
> per-file DAX flag from the directory, and thus the new created files in
> virtiofs will also inherit the per-file DAX flag if the fuse server
> derives fuse_attr.flags from the underlying ext4/xfs inode's per-file
> DAX flag.

Thinking little bit more about this from requirement perspective. I think
we are trying to address two use cases here.

A. Client does not know which files DAX should be used on. Only server
   knows it and server passes this information to client. I suspect
   that's your primary use case.

B. Client is driving which files are supposed to be using DAX. This is
   exactly same as the model ext4/xfs are using by storing a persistent
   flag on inode. 

Current patches seem to be a hybrid of both approach A and B. 

If we were to implement B, then fuse client probably needs to have the
capability to query FS_XFLAG_DAX on inode and decide whether to
enable DAX or not. (Without extra round trip). Or know it indirectly
by extending GETATTR and requesting this explicitly.

If we were only implementing A, then server does not have a way to 
tell client to enable DAX. Server can either look at FS_XFLAG_DAX
and decide to enable DAX or use some other property. Given querying
FS_XFLAG_DAX will be an extra ioctl() on every inode lookup/getattr,
it probably will be a server option. But enabling on server does not
mean client will enable it.

I think my primary concern with this patch right now is trying to
figure out which requirement we are trying to cater to first and how
to connect server and client well so they both understand what mode
they are operating in and interact well.

Vivek

> 
> 
> Any comment is welcome.
> 
> [1] commit 9cb20f94afcd ("fs/ext4: Make DAX mount option a tri-state")
> [2] commit 02beb2686ff9 ("fs/xfs: Make DAX mount option a tri-state")
> 
> 
> changes since v1:
> - add support for changing per-file DAX flags inside guest (patch 4)
> 
> v1:https://www.spinics.net/lists/linux-virtualization/msg51008.html
> 
> Jeffle Xu (4):
>   fuse: add fuse_should_enable_dax() helper
>   fuse: Make DAX mount option a tri-state
>   fuse: add per-file DAX flag
>   fuse: support changing per-file DAX flag inside guest
> 
>  fs/fuse/dax.c             | 36 ++++++++++++++++++++++++++++++++++--
>  fs/fuse/file.c            |  4 ++--
>  fs/fuse/fuse_i.h          | 16 ++++++++++++----
>  fs/fuse/inode.c           |  7 +++++--
>  fs/fuse/ioctl.c           |  9 ++++++---
>  fs/fuse/virtio_fs.c       | 16 ++++++++++++++--
>  include/uapi/linux/fuse.h |  5 +++++
>  7 files changed, 78 insertions(+), 15 deletions(-)
> 
> -- 
> 2.27.0
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
