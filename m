Return-Path: <SRS0=jrxE=KP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DBAC43461
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 15:47:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A957610CC
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 15:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A957610CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F343860BDE;
	Thu, 20 May 2021 15:47:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3dSSCplsdxdZ; Thu, 20 May 2021 15:47:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B018A60BD0;
	Thu, 20 May 2021 15:47:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7909DC000D;
	Thu, 20 May 2021 15:47:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6355C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 15:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7732283CA9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 15:47:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YP-xNiyzTQ3i
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 15:47:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [207.211.30.44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B5A0083DDC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 15:47:17 +0000 (UTC)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-J5b6BXnVM5CEOh3kl5xPKw-1; Thu, 20 May 2021 11:47:15 -0400
X-MC-Unique: J5b6BXnVM5CEOh3kl5xPKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B97B21854E21;
 Thu, 20 May 2021 15:47:13 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-99.ams2.redhat.com [10.36.112.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEE8110013C1;
 Thu, 20 May 2021 15:47:11 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v4 4/5] virtiofs: Skip submounts in sget_fc()
Date: Thu, 20 May 2021 17:46:53 +0200
Message-Id: <20210520154654.1791183-5-groug@kaod.org>
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

All submounts share the same virtio-fs device instance as the root
mount. If the same virtiofs filesystem is mounted again, sget_fc()
is likely to pick up any of these submounts and reuse it instead of
the root mount.

On the server side:

# mkdir ${some_dir}
# mkdir ${some_dir}/mnt1
# mount -t tmpfs none ${some_dir}/mnt1
# touch ${some_dir}/mnt1/THIS_IS_MNT1
# mkdir ${some_dir}/mnt2
# mount -t tmpfs none ${some_dir}/mnt2
# touch ${some_dir}/mnt2/THIS_IS_MNT2

On the client side:

# mkdir /mnt/virtiofs1
# mount -t virtiofs myfs /mnt/virtiofs1
# ls /mnt/virtiofs1
mnt1 mnt2
# grep virtiofs /proc/mounts
myfs /mnt/virtiofs1 virtiofs rw,seclabel,relatime 0 0
none on /mnt/mnt1 type virtiofs (rw,relatime,seclabel)
none on /mnt/mnt2 type virtiofs (rw,relatime,seclabel)

And now remount it again:

# mount -t virtiofs myfs /mnt/virtiofs2
# grep virtiofs /proc/mounts
myfs /mnt/virtiofs1 virtiofs rw,seclabel,relatime 0 0
none on /mnt/mnt1 type virtiofs (rw,relatime,seclabel)
none on /mnt/mnt2 type virtiofs (rw,relatime,seclabel)
myfs /mnt/virtiofs2 virtiofs rw,seclabel,relatime 0 0
# ls /mnt/virtiofs2
THIS_IS_MNT2

Submount mnt2 was picked-up instead of the root mount.

Just skip submounts in virtio_fs_test_super().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fs/fuse/virtio_fs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index e12e5190352c..8962cd033016 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1408,6 +1408,11 @@ static int virtio_fs_test_super(struct super_block *sb,
 	struct fuse_mount *fsc_fm = fsc->s_fs_info;
 	struct fuse_mount *sb_fm = get_fuse_mount_super(sb);
 
+
+	/* Skip submounts */
+	if (!list_is_first(&sb_fm->fc_entry, &sb_fm->fc->mounts))
+		return 0;
+
 	return fsc_fm->fc->iq.priv == sb_fm->fc->iq.priv;
 }
 
-- 
2.26.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
