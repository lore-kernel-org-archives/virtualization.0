Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DAE376BD9
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 23:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787873889; cv=none; b=BSh9C4b8DDhCzqNKix8dEcZfEiL4F3/cE3eiRURTd8qbAxWiixQlQEpG0A/EYIGsP92Fld+wHozAYVkK8UT3mKnZAy4x0CxThGg2FutPilw2jdw8ESNKTOzd0hj556Yo3pYfqdY5IMuA5CjinJI2U0B44O8P7bZgi3++imqB/s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787873889; c=relaxed/simple;
	bh=Wn3Kl1Em3pc3rLk/XZ/banG45sEBL5sAFBf8shoDkPk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFgJBYmwOtn5kW7ONOQHzcysHbCKp+MH0IU7qDNJID5/CtVFdmS1yrrrQXjLV22yDYVDq8B6JIIfKP4J6IaV3jv+XLLEsz1d/vvAT88G6+pm6mHDEZPr9msi3lFLGj5Lm0k4efiHtSnI68z3GgfigXscTx6vpb9kdp8/yoEXJbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=p25Vopf0; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="p25Vopf0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1787873878; x=1788133078;
	bh=ZT19WzNgSAsSgc66j/15hWke6DZMz9tpdU2pv3QxgTU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=p25Vopf0CgbgEyUmRKQkhfI3U3EYVlxQAav6CKD/p8phpVBDU76DxJXo38j2hLfur
	 bFgduMRv9YL+oqurWJqp0IUCgBff3gFVKb4wzoVd0dI75ZiIrQAse5REiS2Dx35YYI
	 6Cng2zBh461Y1FsbCIK4oRF0O9xFPiWFXsW1QJq7Wgat/sjIsD2F9K9Mg+nrgcj5YZ
	 NX0cKv28RF5ovyh9qaCla8CLNeA/CMSQn2BsioMv3nzbdpq8GTVIbbjFRT1ku+yGbV
	 uEFjWUEJVAJ/hnXw6J5v+DxVxE7172inwlprjX8YknkZXNQHmfIN/0ATUjhH7jQx61
	 YpKf+L8fHwbmQ==
Date: Thu, 27 Aug 2026 23:37:52 +0000
To: Miklos Szeredi <miklos@szeredi.hu>, Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, German Maglione <gmaglione@redhat.com>, Shuah Khan <shuah@kernel.org>
From: Aaron Paterson <apaterson@pm.me>
Cc: =?utf-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, Aaron Paterson <apaterson@pm.me>
Subject: [PATCH 3/5] fuse: report a request refused for a live nodeid as stale
Message-ID: <409f0fef91d68c38c52ecd77ccf50bf41b79ddad.1787873791.git.apaterson@pm.me>
In-Reply-To: <cover.1787873791.git.apaterson@pm.me>
References: <cover.1787873791.git.apaterson@pm.me>
Feedback-ID: 6356313:user:proton
X-Pm-Message-ID: 6eb734148bb6406ee0747e1afdb5c7e57afcf632
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A request naming a nodeid and nothing else is only sent for an inode the
client has looked up and holds a reference to, and the server owes the
client that inode until it is sent FUSE_FORGET. ENOENT to such a request
describes a handle the server was obliged to honour rather than
something that has gone away, and the caller cannot tell the difference:
a file that never stopped existing is reported missing.

Report it so the caller can recover.

The path opens say EOPENSTALE. fuse has not needed it before, its only
other use of a stale error being fuse_get_dentry(), where ESTALE answers
an export handle that cannot be resolved, which is a different question.
EOPENSTALE is what an open says when the cached information it started
from has gone stale, and path_openat() decides what that means for the
walk in progress, answering ECHILD under LOOKUP_RCU so it drops to
REF-walk and ESTALE otherwise so the name is resolved again under
LOOKUP_REVAL. NFS reports its own stale opens this way, in
nfs4_file_open() and nfs_atomic_open(). The conversion sits at the two
callers that opened by name rather than in fuse_file_open(), which
fuse_priv_ioctl_prepare() also reaches: it opens the inode to serve
FS_IOC_GETFLAGS and FS_IOC_FSGETXATTR and returns what it gets through
vfs_fileattr_get(), with no open behind it to translate the internal
errno.

The getattr, setattr, readlink and statfs paths say ESTALE through one
helper, which retry_estale() answers by repeating the lookup once under
LOOKUP_REVAL. fs/namei.c, fs/open.c, fs/stat.c, fs/statfs.c,
fs/utimes.c and fs/xattr.c all reach it. EOPENSTALE would be wrong for
them, since path_openat() is the only place that translates it and
nothing would outside an open.

Requests carrying a name are left alone, since ENOENT is then ambiguous
and is frequently what the caller asked to be told. fuse already reads
it that way: fuse_unlink() and fuse_rmdir() treat ENOENT as grounds to
invalidate the entry, which is a statement about the name rather than
the inode. The xattr requests belong with those, carrying an attribute
name whose absence a server may report as ENOENT rather than ENODATA.

Requests against an already open descriptor are left alone as well,
having no equivalent retry to reach, and FUSE_IOCTL and FUSE_POLL hand
the server's errno to userspace verbatim.

Observed with virtiofs on macOS, where a server releases an inode as
soon as a rename displaces the name it was looked up by and roughly one
open in eight during a rename race is refused while stat continues to
describe the file.

Signed-off-by: Aaron Paterson <apaterson@pm.me>
---
 fs/fuse/dir.c    | 10 ++++++++++
 fs/fuse/file.c   | 11 +++++++++++
 fs/fuse/fuse_i.h | 19 +++++++++++++++++++
 fs/fuse/inode.c  |  2 +-
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index e49b4e874b15..217a03999050 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1532,6 +1532,8 @@ static int fuse_do_getattr(struct mnt_idmap *idmap, s=
truct inode *inode,
 =09=09=09if (stat)
 =09=09=09=09fuse_fillattr(idmap, inode, &outarg.attr, stat);
 =09=09}
+=09} else {
+=09=09err =3D fuse_stale_inode_err(err);
 =09}
 =09return err;
 }
@@ -1848,6 +1850,7 @@ static int fuse_readlink_folio(struct inode *inode, s=
truct folio *folio)
=20
 =09fuse_invalidate_atime(inode);
=20
+=09res =3D fuse_stale_inode_err(res);
 =09if (res < 0)
 =09=09return res;
=20
@@ -1910,6 +1913,12 @@ static int fuse_dir_open(struct inode *inode, struct=
 file *file)
 =09=09return err;
=20
 =09err =3D fuse_do_open(fm, get_node_id(inode), file, true);
+=09/*
+=09 * As in fuse_open_common(): a path walk stands behind this open,
+=09 * so the refusal is EOPENSTALE for path_openat() to answer.
+=09 */
+=09if (err =3D=3D -ENOENT)
+=09=09err =3D -EOPENSTALE;
 =09if (!err) {
 =09=09struct fuse_file *ff =3D file->private_data;
=20
@@ -2249,6 +2258,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct d=
entry *dentry,
 =09if (err) {
 =09=09if (err =3D=3D -EINTR)
 =09=09=09fuse_invalidate_attr(inode);
+=09=09err =3D fuse_stale_inode_err(err);
 =09=09goto error;
 =09}
=20
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8d6135a6108a..308b15c30f34 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -279,6 +279,17 @@ static int fuse_open(struct inode *inode, struct file =
*file)
 =09=09fuse_set_nowrite(inode);
=20
 =09err =3D fuse_do_open(fm, get_node_id(inode), file, false);
+=09/*
+=09 * This open reached the server through a path walk, so a refusal
+=09 * for the live nodeid is reported as EOPENSTALE rather than the
+=09 * ESTALE the nodeid-only requests say: path_openat() picks the
+=09 * cheapest retry for the walk in progress, ECHILD under LOOKUP_RCU
+=09 * and ESTALE otherwise. fuse_file_open() is left alone because
+=09 * fuse_priv_ioctl_prepare() reaches it to serve FS_IOC_GETFLAGS,
+=09 * with no open behind it to translate the internal errno.
+=09 */
+=09if (err =3D=3D -ENOENT)
+=09=09err =3D -EOPENSTALE;
 =09if (!err) {
 =09=09ff =3D file->private_data;
 =09=09err =3D fuse_finish_open(inode, file);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c8d4c5f3af7e..e6b2597d6dd6 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1250,6 +1250,25 @@ void fuse_inode_uncached_io_end(struct fuse_inode *f=
i);
 int fuse_file_io_open(struct file *file, struct inode *inode);
 void fuse_file_io_release(struct fuse_file *ff, struct inode *inode);
=20
+/*
+ * Report a request refused for a live nodeid as stale.
+ *
+ * A request that names a nodeid and nothing else is only sent for an
+ * inode the client has looked up and holds a reference to, and the
+ * server owes the client that inode until it is sent FUSE_FORGET.
+ * ENOENT from the server describes the inode itself rather than a name
+ * that has gone away. Report the handle as stale, which the caller
+ * answers by resolving the name again under LOOKUP_REVAL and acting on
+ * whatever it refers to now. A name that really has gone fails that
+ * second lookup and the caller still sees ENOENT.
+ */
+static inline int fuse_stale_inode_err(int err)
+{
+=09if (err =3D=3D -ENOENT)
+=09=09return -ESTALE;
+=09return err;
+}
+
 /* file.c */
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 =09=09=09=09 unsigned int open_flags, bool isdir);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e9552be3637b..cde0a5335089 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -666,7 +666,7 @@ static int fuse_statfs(struct dentry *dentry, struct ks=
tatfs *buf)
 =09err =3D fuse_simple_request(fm, &args);
 =09if (!err)
 =09=09convert_fuse_statfs(buf, &outarg.st);
-=09return err;
+=09return fuse_stale_inode_err(err);
 }
=20
 static struct fuse_sync_bucket *fuse_sync_bucket_alloc(void)
--=20
2.55.0.553.g4ad8c266be


