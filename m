Return-Path: <SRS0=ctfp=KQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F33C433B4
	for <virtualization@archiver.kernel.org>; Fri, 21 May 2021 08:08:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAFDE6135B
	for <virtualization@archiver.kernel.org>; Fri, 21 May 2021 08:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFDE6135B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8AB1140208;
	Fri, 21 May 2021 08:08:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lgmT7PXfE0Ae; Fri, 21 May 2021 08:08:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2274940207;
	Fri, 21 May 2021 08:08:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E96CBC000E;
	Fri, 21 May 2021 08:08:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D969DC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 May 2021 08:08:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C629B404CA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 May 2021 08:08:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k98-QXSZ9Axe
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 May 2021 08:08:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 503D9403F7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 May 2021 08:08:52 +0000 (UTC)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-ZvW3bxJ4O5CppUscs7yADQ-1; Fri, 21 May 2021 04:08:46 -0400
X-MC-Unique: ZvW3bxJ4O5CppUscs7yADQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 621E3BD124;
 Fri, 21 May 2021 08:08:45 +0000 (UTC)
Received: from bahia.lan (ovpn-112-49.ams2.redhat.com [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 743A15C1C4;
 Fri, 21 May 2021 08:08:36 +0000 (UTC)
Date: Fri, 21 May 2021 10:08:35 +0200
From: Greg Kurz <groug@kaod.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 1/5] fuse: Fix leak in fuse_dentry_automount() error
 path
Message-ID: <20210521100835.52506623@bahia.lan>
In-Reply-To: <YKa8SZ8s6QeKZ4XP@zeniv-ca.linux.org.uk>
References: <20210520154654.1791183-1-groug@kaod.org>
 <20210520154654.1791183-2-groug@kaod.org>
 <YKa8SZ8s6QeKZ4XP@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org,
 Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
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

On Thu, 20 May 2021 19:45:13 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Thu, May 20, 2021 at 05:46:50PM +0200, Greg Kurz wrote:
> > Some rollback was forgotten during the addition of crossmounts.
> 
> Have you actually tested that?  Because I strongly suspect that
> by that point the ownership of fc and fm is with sb and those
> should be taken care of by deactivate_locked_super().

My bad, I didn't test but now I did and the issue is actually
worse than just a memory leak. This error path crashes upstream
without this patch:

[   26.206673] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   26.209560] #PF: supervisor read access in kernel mode
[   26.211699] #PF: error_code(0x0000) - not-present page
[   26.214574] PGD 0 P4D 0 
[   26.216016] Oops: 0000 [#1] SMP PTI
[   26.217451] CPU: 0 PID: 3380 Comm: ls Kdump: loaded Not tainted 5.13.0-virtio-fs-sync+ #30
[   26.220839] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   26.226362] RIP: 0010:__list_del_entry_valid+0x25/0x90
[   26.228449] Code: c3 0f 1f 40 00 48 8b 17 4c 8b 47 08 48 b8 00 01 00 00 00 00 ad de 48 39 c2 74 26 48 b8 22 01 00 00 00 00 ad de 49 39 c0 74 2b <49> 8b 30 48 39 fe 75 3a 48 8b 52 08 48 39 f2 75 48 b8 01 00 00 00
[   26.234256] RSP: 0018:ffffaa37006cbb18 EFLAGS: 00010217
[   26.235473] RAX: dead000000000122 RBX: ffff8f6844098200 RCX: 0000000000000000
[   26.236922] RDX: 0000000000000000 RSI: ffffffff99264e92 RDI: ffff8f6844098210
[   26.238401] RBP: ffff8f68420b3c00 R08: 0000000000000000 R09: 000000000000002a
[   26.239852] R10: 0000000000000000 R11: ffff8f6840402480 R12: ffff8f6844098210
[   26.241160] R13: ffff8f68420b3da8 R14: ffff8f6844098200 R15: 0000000000000000
[   26.242398] FS:  00007f547b93f200(0000) GS:ffff8f687bc00000(0000) knlGS:0000000000000000
[   26.243698] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.244693] CR2: 0000000000000000 CR3: 0000000104e50000 CR4: 00000000000006f0
[   26.245936] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   26.246961] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   26.247938] Call Trace:
[   26.248300]  fuse_mount_remove+0x2c/0x70 [fuse]
[   26.248892]  virtio_kill_sb+0x22/0x160 [virtiofs]
[   26.249487]  deactivate_locked_super+0x36/0xa0
[   26.250077]  fuse_dentry_automount+0x178/0x1a0 [fuse]


The crash happens because we're assuming fm was already added to
fc->mounts...

bool fuse_mount_remove(struct fuse_mount *fm)
{
	struct fuse_conn *fc = fm->fc;
	bool last = false;

	down_write(&fc->killsb);
	list_del_init(&fm->fc_entry); <=== HERE
	if (list_empty(&fc->mounts))
		last = true;
	up_write(&fc->killsb);

	return last;
}

but fm is added to fc->mounts much later after the superblock is fully
configured. Looking again at what is done for the root mount in
virtio_fs_get_tree(), I now realize sb->s_fs_info is used as a flag
to decide whether fuse_mount_remove() should be called:

static int virtio_fs_get_tree(struct fs_context *fsc)
{
...
	if (!sb->s_root) {
		err = virtio_fs_fill_super(sb, fsc);
		if (err) {
			fuse_conn_put(fc);
			kfree(fm);
CLEARED HERE =>		sb->s_fs_info = NULL;
			deactivate_locked_super(sb);
			return err;
		}

		sb->s_flags |= SB_ACTIVE;
	}
...
}

static void virtio_kill_sb(struct super_block *sb)
{
	struct fuse_mount *fm = get_fuse_mount_super(sb);

I.E. sb->s_fs_info

	bool last;

	/* If mount failed, we can still be called without any fc */
	if (fm) {

TESTED HERE ^^

		last = fuse_mount_remove(fm);
		if (last)
			virtio_fs_conn_destroy(fm);
	}
	kill_anon_super(sb);
}

The natural fix is to do the same in the automount case : take
back the ownership on fm by clearing sb->s_fs_info, which thus
implies to do the freeing.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
