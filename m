Return-Path: <SRS0=jrxE=KP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762E1C43460
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 15:47:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA246139A
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 15:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA246139A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B7B260BA4;
	Thu, 20 May 2021 15:47:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4QJ7ASh15DqX; Thu, 20 May 2021 15:47:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3C3760BDF;
	Thu, 20 May 2021 15:47:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 407BFC0022;
	Thu, 20 May 2021 15:47:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F6EAC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 15:47:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6191140179
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 15:47:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9kBQ1xGKOFhB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 15:47:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [207.211.30.44])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8C48F400BD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 15:47:15 +0000 (UTC)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-3MzFbQv4MyK5fa_1GMvdAw-1; Thu, 20 May 2021 11:47:11 -0400
X-MC-Unique: 3MzFbQv4MyK5fa_1GMvdAw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91082107ACE4;
 Thu, 20 May 2021 15:47:09 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-99.ams2.redhat.com [10.36.112.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C710810013C1;
 Thu, 20 May 2021 15:47:07 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v4 2/5] fuse: Call vfs_get_tree() for submounts
Date: Thu, 20 May 2021 17:46:51 +0200
Message-Id: <20210520154654.1791183-3-groug@kaod.org>
In-Reply-To: <20210520154654.1791183-1-groug@kaod.org>
References: <20210520154654.1791183-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

We don't set the SB_BORN flag on submounts superblocks. This is wrong
as these superblocks are then considered as partially constructed or
dying in the rest of the code and can break some assumptions.

One such case is when you have a virtiofs filesystem and you try to
mount it again : virtio_fs_get_tree() tries to obtain a superblock
with sget_fc(). The matching criteria in virtio_fs_test_super() is
the pointer of the underlying virtiofs device, which is shared by
the root mount and its submounts. This means that any submount can
be picked up instead of the root mount. This is itself a bug :
submounts should be ignored in this case. But, most importantly, it
then triggers an infinite loop in sget_fc() because it fails to grab
the superblock (very easy to reproduce).

The only viable solution is to set SB_BORN at some point. This
must be done with vfs_get_tree() because setting SB_BORN requires
special care, i.e. a memory barrier for super_cache_count() which
can check SB_BORN without taking any lock.

This requires to split out some code from fuse_dentry_automount() to
a new dedicated fuse_get_tree_submount().

The fs_private field of the filesystem context isn't used with
submounts : hijack it to pass the FUSE inode of the mount point
down to fuse_get_tree_submount().

Finally, adapt virtiofs to use this.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fs/fuse/dir.c       | 48 +++++++++++----------------------------------
 fs/fuse/fuse_i.h    |  6 ++++++
 fs/fuse/inode.c     | 43 ++++++++++++++++++++++++++++++++++++++++
 fs/fuse/virtio_fs.c |  3 +++
 4 files changed, 63 insertions(+), 37 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index fb2af70596c3..4c8dafe4f69e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -309,12 +309,9 @@ static int fuse_dentry_delete(const struct dentry *dentry)
 static struct vfsmount *fuse_dentry_automount(struct path *path)
 {
 	struct fs_context *fsc;
-	struct fuse_mount *parent_fm = get_fuse_mount_super(path->mnt->mnt_sb);
-	struct fuse_conn *fc = parent_fm->fc;
 	struct fuse_mount *fm;
 	struct vfsmount *mnt;
 	struct fuse_inode *mp_fi = get_fuse_inode(d_inode(path->dentry));
-	struct super_block *sb;
 	int err;
 
 	fsc = fs_context_for_submount(path->mnt->mnt_sb->s_type, path->dentry);
@@ -323,36 +320,19 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
 		goto out;
 	}
 
-	err = -ENOMEM;
-	fm = kzalloc(sizeof(struct fuse_mount), GFP_KERNEL);
-	if (!fm)
+	/*
+	 * Hijack fsc->fs_private to pass the mount point inode to
+	 * fuse_get_tree_submount(). It *must* be NULLified afterwards
+	 * to avoid the inode pointer to be passed to kfree() when
+	 * the context gets freed.
+	 */
+	fsc->fs_private = mp_fi;
+	err = vfs_get_tree(fsc);
+	fsc->fs_private = NULL;
+	if (err)
 		goto out_put_fsc;
 
-	fsc->s_fs_info = fm;
-	sb = sget_fc(fsc, NULL, set_anon_super_fc);
-	if (IS_ERR(sb)) {
-		err = PTR_ERR(sb);
-		kfree(fm);
-		goto out_put_fsc;
-	}
-	fm->fc = fuse_conn_get(fc);
-
-	/* Initialize superblock, making @mp_fi its root */
-	err = fuse_fill_super_submount(sb, mp_fi);
-	if (err) {
-		fuse_conn_put(fc);
-		kfree(fm);
-		goto out_put_sb;
-	}
-
-	sb->s_flags |= SB_ACTIVE;
-	fsc->root = dget(sb->s_root);
-	/* We are done configuring the superblock, so unlock it */
-	up_write(&sb->s_umount);
-
-	down_write(&fc->killsb);
-	list_add_tail(&fm->fc_entry, &fc->mounts);
-	up_write(&fc->killsb);
+	fm = get_fuse_mount_super(fsc->root->d_sb);
 
 	/* Create the submount */
 	mnt = vfs_create_mount(fsc);
@@ -364,12 +344,6 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
 	put_fs_context(fsc);
 	return mnt;
 
-out_put_sb:
-	/*
-	 * Only jump here when fsc->root is NULL and sb is still locked
-	 * (otherwise put_fs_context() will put the superblock)
-	 */
-	deactivate_locked_super(sb);
 out_put_fsc:
 	put_fs_context(fsc);
 out:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7e463e220053..d7fcf59a6a0e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1090,6 +1090,12 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx);
 int fuse_fill_super_submount(struct super_block *sb,
 			     struct fuse_inode *parent_fi);
 
+/*
+ * Get the mountable root for the submount
+ * @fsc: superblock configuration context
+ */
+int fuse_get_tree_submount(struct fs_context *fsc);
+
 /*
  * Remove the mount from the connection
  *
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 393e36b74dc4..74e5205f203c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1313,6 +1313,49 @@ int fuse_fill_super_submount(struct super_block *sb,
 	return 0;
 }
 
+/* Filesystem context private data holds the FUSE inode of the mount point */
+int fuse_get_tree_submount(struct fs_context *fsc)
+{
+	struct fuse_mount *fm;
+	struct fuse_inode *mp_fi = fsc->fs_private;
+	struct fuse_conn *fc = get_fuse_conn(&mp_fi->inode);
+	struct super_block *sb;
+	int err;
+
+	fm = kzalloc(sizeof(struct fuse_mount), GFP_KERNEL);
+	if (!fm)
+		return -ENOMEM;
+
+	fsc->s_fs_info = fm;
+	sb = sget_fc(fsc, NULL, set_anon_super_fc);
+	if (IS_ERR(sb)) {
+		kfree(fm);
+		return PTR_ERR(sb);
+	}
+	fm->fc = fuse_conn_get(fc);
+
+	/* Initialize superblock, making @mp_fi its root */
+	err = fuse_fill_super_submount(sb, mp_fi);
+	if (err) {
+		fuse_conn_put(fc);
+		deactivate_locked_super(sb);
+		kfree(fm);
+		return err;
+	}
+
+	sb->s_flags |= SB_ACTIVE;
+	fsc->root = dget(sb->s_root);
+	/* We are done configuring the superblock, so unlock it */
+	up_write(&sb->s_umount);
+
+	down_write(&fc->killsb);
+	list_add_tail(&fm->fc_entry, &fc->mounts);
+	up_write(&fc->killsb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fuse_get_tree_submount);
+
 int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 {
 	struct fuse_dev *fud = NULL;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index bcb8a02e2d8b..e12e5190352c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1420,6 +1420,9 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	unsigned int virtqueue_size;
 	int err = -EIO;
 
+	if (fsc->purpose == FS_CONTEXT_FOR_SUBMOUNT)
+		return fuse_get_tree_submount(fsc);
+
 	/* This gets a reference on virtio_fs object. This ptr gets installed
 	 * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
 	 * to drop the reference to this object.
-- 
2.26.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
