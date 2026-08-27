Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227563CDBD7;
	Thu, 27 Aug 2026 23:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787873892; cv=none; b=BrwQqDDQnfwoQqiVlTNKIVt5f21txI6z1uSvSE1Hmr63ISyX9eCviYJPTgBOezFZrXtyAcqBP+En4gF5DuJc+YoK2zJ8h/oCOw3DHM0gRKCPT6UUEyAegfpD81J7N+V2GlAXP3EYNCSqXgor8FKKPaRXAgL0No/h0g5SunQWdIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787873892; c=relaxed/simple;
	bh=u9uSB5C9l0sYaylZRTtAj6/bhy3iGcTQlWoLbvkmzic=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nX+mzvuxRA6wIrUfJ9o4d3LPMvU16hFPT9SKVo9i5lAH24n43qngtuDUanjCHWJzq654isvo6qUzz4/3ZQlO8ee1qzWfCZiWexgiyflM8bkyAaut4fmcyNMj1ef+e6Bbb3xZPM6uVhlmtk07ZiYKb9MXOP2gyvcLZTdEQl1Aijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=U2Fk+P1Y; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="U2Fk+P1Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1787873887; x=1788133087;
	bh=IGbPUBi9oyDRfhnaGZFqJaZREQhYPBXk4OHpYnu9Zps=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=U2Fk+P1YIx3TDVmSX56N9BzUumOv+klshlV60TtHjJBR+1WBvspxhataYqtD8WS5A
	 PJ7SwSm4jHDlrlxlSCHnpnBSktqcbrPyzfhrt9ZCLHAZ6nNT/ewTm/hopVYFfghk9b
	 liJ1TYewrrqMngO7nJUlA3seprnseAqaCej0eb2ClELR76uCCrYWVjEBOerHXzUcrL
	 zUSHl2Wboy1hFF6NK2epChRWvvMKDk/KatqjR9Y/JtQTwWLPkPl+FJZ4pYyjfwWRYF
	 pHf6CbZoRVuZZxvLEME0oLoe3z9OPAjyhCsNj3euJo31Z8RBFFZ+xE57zYcNSAPzie
	 E9fWOwB1BOBnw==
Date: Thu, 27 Aug 2026 23:38:02 +0000
To: Miklos Szeredi <miklos@szeredi.hu>, Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, German Maglione <gmaglione@redhat.com>, Shuah Khan <shuah@kernel.org>
From: Aaron Paterson <apaterson@pm.me>
Cc: =?utf-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, Aaron Paterson <apaterson@pm.me>
Subject: [PATCH 4/5] selftests/fuse: cover a request refused for a live nodeid
Message-ID: <15e12ddd18fa9bfecdb454391e6684664d8da653.1787873791.git.apaterson@pm.me>
In-Reply-To: <cover.1787873791.git.apaterson@pm.me>
References: <cover.1787873791.git.apaterson@pm.me>
Feedback-ID: 6356313:user:proton
X-Pm-Message-ID: 9839bd7b55eee69534519bf70eeede290c9cf289
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add a test that mounts a libfuse3 server which can be told to refuse a
request for an inode the client still holds a reference to, and check
that the caller recovers instead of being told the file is gone.

The server answers ENOENT on demand for each request the fix converts,
FUSE_OPEN, FUSE_GETATTR, FUSE_SETATTR, FUSE_READLINK and FUSE_STATFS,
while continuing to serve every other request for the same inode, which
is how a server that releases an inode too early behaves. open(), stat(),
chmod(), readlink() and statfs() are then expected to succeed, having
resolved the name again under LOOKUP_REVAL, and the request counters
confirm the retry happened rather than the answer being served from
cache.

Each of those requests carries a nodeid, so an ENOENT answering one of
them describes a handle rather than a name. FUSE_LOOKUP is the exception
and is covered the other way round: a name the server does not have must
still report ENOENT, since there the refusal is the answer.

Signed-off-by: Aaron Paterson <apaterson@pm.me>
---
 .../selftests/filesystems/fuse/.gitignore     |   1 +
 .../selftests/filesystems/fuse/Makefile       |   4 +
 .../filesystems/fuse/fuse_estale_test.c       | 450 ++++++++++++++++++
 3 files changed, 455 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_estale_te=
st.c

diff --git a/tools/testing/selftests/filesystems/fuse/.gitignore b/tools/te=
sting/selftests/filesystems/fuse/.gitignore
index 25c779065806..9cb3048128d5 100644
--- a/tools/testing/selftests/filesystems/fuse/.gitignore
+++ b/tools/testing/selftests/filesystems/fuse/.gitignore
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 fuse_acl_cache_test
 fuse_mnt
+fuse_estale_test
 fusectl_test
 write_extend_eof_test
diff --git a/tools/testing/selftests/filesystems/fuse/Makefile b/tools/test=
ing/selftests/filesystems/fuse/Makefile
index 1ea87008ef9e..f564cb37b3a5 100644
--- a/tools/testing/selftests/filesystems/fuse/Makefile
+++ b/tools/testing/selftests/filesystems/fuse/Makefile
@@ -11,6 +11,7 @@ FUSE3_CFLAGS :=3D $(shell pkg-config fuse3 --cflags 2>/de=
v/null)
 FUSE3_LDLIBS :=3D $(shell pkg-config fuse3 --libs 2>/dev/null)
 ifneq ($(FUSE3_CFLAGS),)
 TEST_GEN_PROGS +=3D fuse_acl_cache_test
+TEST_GEN_PROGS +=3D fuse_estale_test
 endif
=20
 include ../../lib.mk
@@ -32,3 +33,6 @@ $(OUTPUT)/fuse_mnt: LDLIBS +=3D $(VAR_LDLIBS)
=20
 $(OUTPUT)/fuse_acl_cache_test: CFLAGS +=3D $(FUSE3_CFLAGS)
 $(OUTPUT)/fuse_acl_cache_test: LDLIBS +=3D $(FUSE3_LDLIBS)
+
+$(OUTPUT)/fuse_estale_test: CFLAGS +=3D $(FUSE3_CFLAGS)
+$(OUTPUT)/fuse_estale_test: LDLIBS +=3D $(FUSE3_LDLIBS)
diff --git a/tools/testing/selftests/filesystems/fuse/fuse_estale_test.c b/=
tools/testing/selftests/filesystems/fuse/fuse_estale_test.c
new file mode 100644
index 000000000000..82b842d3a5f7
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/fuse_estale_test.c
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test: a request refused for an inode the client still holds a reference=
 to
+ *
+ * FUSE_OPEN, FUSE_GETATTR, FUSE_SETATTR, FUSE_READLINK and FUSE_STATFS ca=
rry a
+ * nodeid rather than a path.  The client only sends them for an inode it =
has
+ * already looked up and holds a reference to, and a server owes the clien=
t that
+ * inode until it is sent FUSE_FORGET.  A server that lets the inode go ea=
rly,
+ * as one backing a shared directory does when the name is renamed over, a=
nswers
+ * with ENOENT.
+ *
+ * On an unfixed kernel that ENOENT is passed out unchanged.  The path wal=
k has
+ * no reason to doubt it and the caller is told a file is missing when it =
never
+ * stopped existing.  Callers that read a missing file as an empty one act=
 on
+ * the emptiness.
+ *
+ * Fixed (fs/fuse/file.c and fs/fuse/dir.c): ENOENT becomes ESTALE, which
+ * describes the handle rather than the name.  filename_lookup() and
+ * do_filp_open() already retry with LOOKUP_REVAL on ESTALE, so the name i=
s
+ * resolved again and the inode it refers to now is used.  A name that has
+ * genuinely gone away fails the retried lookup, so ENOENT still reaches a
+ * caller that deserves it.
+ *
+ * Only requests reachable through a path walk are covered, because the re=
try
+ * is what makes ESTALE useful and the walk is what performs it.  An opera=
tion
+ * on a descriptor already open has no equivalent recovery.
+ *
+ * Test outline:
+ *  1. Mount a minimal FUSE fs holding one file.
+ *  2. The server refuses the first request of the kind under test and all=
ows
+ *     every one after it, standing in for a server that released the inod=
e and
+ *     has since resolved the name again.
+ *  3. openat() the file.
+ *     Buggy:  ENOENT reaches the caller, one open was asked for.  FAIL.
+ *     Fixed:  the walk retries, the second open is allowed, the descripto=
r is
+ *             returned, two opens were asked for.  PASS.
+ *  4. stat(), chmod(), readlink() and statfs() by name, which are the sam=
e
+ *     recovery through FUSE_GETATTR, FUSE_SETATTR, FUSE_READLINK and
+ *     FUSE_STATFS.  Each is reached through a path walk, which is what ma=
kes
+ *     the retry available.
+ *  5. Open a name the server does not have at all.
+ *     Both:   ENOENT, because the lookup fails rather than the open, and =
a
+ *             file that is absent must still look absent.
+ */
+
+#define _GNU_SOURCE
+#define FUSE_USE_VERSION 34
+
+#include <errno.h>
+#include <fcntl.h>
+#include <fuse_lowlevel.h>
+#include <linux/limits.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/statvfs.h>
+#include <sys/vfs.h>
+#include <unistd.h>
+
+#include "../../kselftest_harness.h"
+
+#define FILE_NAME=09"held"
+#define LINK_NAME=09"held-link"
+#define ABSENT_NAME=09"no-such-file"
+#define FILE_INO=092
+#define LINK_INO=093
+#define CONTENTS=09"present\n"
+#define LINK_TARGET=09FILE_NAME
+
+/*
+ * Which request the server refuses, and how many times.  Shared with the
+ * daemon thread; one test runs at a time, so plain ints.
+ *
+ * Every one of these names an inode by nodeid rather than by name, so a
+ * refusal of any of them is describing a handle rather than a missing fil=
e.
+ * FUSE_LOOKUP is deliberately absent: it carries a name, so its ENOENT is=
 an
+ * answer rather than a fault, and absent_name_still_reports_absent covers=
 it.
+ */
+enum refuse_what {
+=09REFUSE_NOTHING,
+=09REFUSE_OPEN,
+=09REFUSE_GETATTR,
+=09REFUSE_SETATTR,
+=09REFUSE_READLINK,
+=09REFUSE_STATFS,
+};
+
+static struct {
+=09enum refuse_what what;
+=09int refusals_left;
+=09int opens_seen;
+=09int getattrs_seen;
+=09int setattrs_seen;
+=09int readlinks_seen;
+=09int statfss_seen;
+} g_ds;
+
+/* True once, for the request under test, and then never again. */
+static bool refuse_now(enum refuse_what what)
+{
+=09if (g_ds.what !=3D what || g_ds.refusals_left <=3D 0)
+=09=09return false;
+=09g_ds.refusals_left--;
+=09return true;
+}
+
+static void fill_attr(fuse_ino_t ino, struct stat *st)
+{
+=09memset(st, 0, sizeof(*st));
+=09st->st_ino =3D ino;
+=09/*
+=09 * Owned by whoever runs the test, so that chmod() is a request the
+=09 * kernel will carry through to the server rather than refuse itself.
+=09 */
+=09st->st_uid =3D getuid();
+=09st->st_gid =3D getgid();
+=09if (ino =3D=3D FUSE_ROOT_ID) {
+=09=09st->st_mode =3D S_IFDIR | 0755;
+=09=09st->st_nlink =3D 2;
+=09} else if (ino =3D=3D LINK_INO) {
+=09=09st->st_mode =3D S_IFLNK | 0777;
+=09=09st->st_nlink =3D 1;
+=09=09st->st_size =3D sizeof(LINK_TARGET) - 1;
+=09} else {
+=09=09st->st_mode =3D S_IFREG | 0644;
+=09=09st->st_nlink =3D 1;
+=09=09st->st_size =3D sizeof(CONTENTS) - 1;
+=09}
+}
+
+static void t_lookup(fuse_req_t req, fuse_ino_t parent, const char *name)
+{
+=09struct fuse_entry_param e;
+=09fuse_ino_t ino;
+
+=09if (parent !=3D FUSE_ROOT_ID)
+=09=09ino =3D 0;
+=09else if (!strcmp(name, FILE_NAME))
+=09=09ino =3D FILE_INO;
+=09else if (!strcmp(name, LINK_NAME))
+=09=09ino =3D LINK_INO;
+=09else
+=09=09ino =3D 0;
+
+=09if (!ino) {
+=09=09fuse_reply_err(req, ENOENT);
+=09=09return;
+=09}
+
+=09memset(&e, 0, sizeof(e));
+=09e.ino =3D ino;
+=09e.attr_timeout =3D 0;
+=09e.entry_timeout =3D 0;
+=09fill_attr(ino, &e.attr);
+=09fuse_reply_entry(req, &e);
+}
+
+static void t_getattr(fuse_req_t req, fuse_ino_t ino,
+=09=09      struct fuse_file_info *fi)
+{
+=09struct stat st;
+
+=09(void)fi;
+=09/* The root is left alone; refusing it would break the mount itself. */
+=09if (ino =3D=3D FILE_INO) {
+=09=09g_ds.getattrs_seen++;
+=09=09if (refuse_now(REFUSE_GETATTR)) {
+=09=09=09fuse_reply_err(req, ENOENT);
+=09=09=09return;
+=09=09}
+=09}
+=09fill_attr(ino, &st);
+=09fuse_reply_attr(req, &st, 0);
+}
+
+static void t_open(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *=
fi)
+{
+=09if (ino !=3D FILE_INO) {
+=09=09fuse_reply_err(req, ENOENT);
+=09=09return;
+=09}
+
+=09g_ds.opens_seen++;
+=09if (refuse_now(REFUSE_OPEN)) {
+=09=09/*
+=09=09 * The inode is gone as far as this server is concerned, even
+=09=09 * though the client is holding a reference to it and asked by
+=09=09 * nodeid rather than by name.
+=09=09 */
+=09=09fuse_reply_err(req, ENOENT);
+=09=09return;
+=09}
+=09fuse_reply_open(req, fi);
+}
+
+static void t_read(fuse_req_t req, fuse_ino_t ino, size_t size, off_t off,
+=09=09   struct fuse_file_info *fi)
+{
+=09size_t len =3D sizeof(CONTENTS) - 1;
+
+=09(void)fi;
+=09if (ino !=3D FILE_INO) {
+=09=09fuse_reply_err(req, ENOENT);
+=09=09return;
+=09}
+=09if ((size_t)off >=3D len) {
+=09=09fuse_reply_buf(req, NULL, 0);
+=09=09return;
+=09}
+=09if (off + size > len)
+=09=09size =3D len - off;
+=09fuse_reply_buf(req, CONTENTS + off, size);
+}
+
+static void t_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
+=09=09      int to_set, struct fuse_file_info *fi)
+{
+=09struct stat st;
+
+=09(void)attr;
+=09(void)to_set;
+=09(void)fi;
+=09if (ino =3D=3D FILE_INO) {
+=09=09g_ds.setattrs_seen++;
+=09=09if (refuse_now(REFUSE_SETATTR)) {
+=09=09=09fuse_reply_err(req, ENOENT);
+=09=09=09return;
+=09=09}
+=09}
+=09fill_attr(ino, &st);
+=09fuse_reply_attr(req, &st, 0);
+}
+
+static void t_readlink(fuse_req_t req, fuse_ino_t ino)
+{
+=09if (ino !=3D LINK_INO) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
+=09g_ds.readlinks_seen++;
+=09if (refuse_now(REFUSE_READLINK)) {
+=09=09fuse_reply_err(req, ENOENT);
+=09=09return;
+=09}
+=09fuse_reply_readlink(req, LINK_TARGET);
+}
+
+static void t_statfs(fuse_req_t req, fuse_ino_t ino)
+{
+=09struct statvfs sfs;
+
+=09(void)ino;
+=09g_ds.statfss_seen++;
+=09if (refuse_now(REFUSE_STATFS)) {
+=09=09fuse_reply_err(req, ENOENT);
+=09=09return;
+=09}
+
+=09memset(&sfs, 0, sizeof(sfs));
+=09sfs.f_bsize =3D 512;
+=09sfs.f_frsize =3D 512;
+=09sfs.f_namemax =3D NAME_MAX;
+=09fuse_reply_statfs(req, &sfs);
+}
+
+static const struct fuse_lowlevel_ops fs_ops =3D {
+=09.lookup=09=09=3D t_lookup,
+=09.getattr=09=3D t_getattr,
+=09.setattr=09=3D t_setattr,
+=09.readlink=09=3D t_readlink,
+=09.statfs=09=09=3D t_statfs,
+=09.open=09=09=3D t_open,
+=09.read=09=09=3D t_read,
+};
+
+static void *run_daemon(void *arg)
+{
+=09fuse_session_loop((struct fuse_session *)arg);
+=09return NULL;
+}
+
+/* ---- kselftest harness ------------------------------------------------=
--- */
+
+FIXTURE(open_estale) {
+=09struct fuse_session *se;
+=09char                 mountpoint[PATH_MAX];
+=09char                 file_path[PATH_MAX];
+=09char                 link_path[PATH_MAX];
+=09char                 absent_path[PATH_MAX];
+=09pthread_t            thread;
+};
+
+FIXTURE_SETUP(open_estale)
+{
+=09char *fuse_argv[] =3D { "fuse_estale_test", NULL };
+=09struct fuse_args args =3D FUSE_ARGS_INIT(1, fuse_argv);
+
+=09memset(&g_ds, 0, sizeof(g_ds));
+=09g_ds.what =3D REFUSE_NOTHING;
+=09g_ds.refusals_left =3D 1;
+
+=09strcpy(self->mountpoint, "/tmp/open_estale_test_XXXXXX");
+=09if (!mkdtemp(self->mountpoint))
+=09=09SKIP(return, "mkdtemp: %s", strerror(errno));
+
+=09snprintf(self->file_path, sizeof(self->file_path),
+=09=09 "%s/" FILE_NAME, self->mountpoint);
+=09snprintf(self->link_path, sizeof(self->link_path),
+=09=09 "%s/" LINK_NAME, self->mountpoint);
+=09snprintf(self->absent_path, sizeof(self->absent_path),
+=09=09 "%s/" ABSENT_NAME, self->mountpoint);
+
+=09self->se =3D fuse_session_new(&args, &fs_ops, sizeof(fs_ops), NULL);
+=09if (!self->se) {
+=09=09rmdir(self->mountpoint);
+=09=09SKIP(return, "fuse_session_new failed");
+=09}
+
+=09if (fuse_session_mount(self->se, self->mountpoint)) {
+=09=09fuse_session_destroy(self->se);
+=09=09rmdir(self->mountpoint);
+=09=09SKIP(return, "fuse_session_mount failed (no fusermount3 or no privil=
eges)");
+=09}
+
+=09if (pthread_create(&self->thread, NULL, run_daemon, self->se)) {
+=09=09fuse_session_unmount(self->se);
+=09=09fuse_session_destroy(self->se);
+=09=09rmdir(self->mountpoint);
+=09=09SKIP(return, "pthread_create: %s", strerror(errno));
+=09}
+
+=09fuse_opt_free_args(&args);
+}
+
+FIXTURE_TEARDOWN(open_estale)
+{
+=09fuse_session_exit(self->se);
+=09fuse_session_unmount(self->se);
+=09pthread_join(self->thread, NULL);
+=09fuse_session_destroy(self->se);
+=09rmdir(self->mountpoint);
+}
+
+TEST_F(open_estale, refused_open_is_retried)
+{
+=09int fd;
+
+=09g_ds.what =3D REFUSE_OPEN;
+
+=09fd =3D open(self->file_path, O_RDONLY);
+
+=09/*
+=09 * The refusal describes a handle the server should have honoured, so
+=09 * the walk is entitled to resolve the name again and open what it
+=09 * refers to now. Reporting the file missing instead ends the walk.
+=09 */
+=09ASSERT_GE(fd, 0) {
+=09=09TH_LOG("open failed with %s after %d open request(s)",
+=09=09       strerror(errno), g_ds.opens_seen);
+=09}
+=09EXPECT_EQ(2, g_ds.opens_seen);
+=09close(fd);
+}
+
+TEST_F(open_estale, refused_getattr_on_path_is_retried)
+{
+=09struct stat st;
+
+=09g_ds.what =3D REFUSE_GETATTR;
+
+=09/*
+=09 * Reached by name, so the walk can resolve it again and ask a second
+=09 * time, the same recovery the open gets.
+=09 */
+=09ASSERT_EQ(0, stat(self->file_path, &st)) {
+=09=09TH_LOG("stat failed with %s after %d getattr request(s)",
+=09=09       strerror(errno), g_ds.getattrs_seen);
+=09}
+=09EXPECT_GT(g_ds.getattrs_seen, 1);
+}
+
+TEST_F(open_estale, refused_setattr_on_path_is_retried)
+{
+=09g_ds.what =3D REFUSE_SETATTR;
+
+=09/*
+=09 * chmod() reaches the inode by name, so the same retry applies: the
+=09 * refusal describes a handle and the walk may resolve the name again.
+=09 */
+=09ASSERT_EQ(0, chmod(self->file_path, 0600)) {
+=09=09TH_LOG("chmod failed with %s after %d setattr request(s)",
+=09=09       strerror(errno), g_ds.setattrs_seen);
+=09}
+=09EXPECT_GT(g_ds.setattrs_seen, 1);
+}
+
+TEST_F(open_estale, refused_readlink_on_path_is_retried)
+{
+=09char buf[PATH_MAX];
+=09ssize_t n;
+
+=09g_ds.what =3D REFUSE_READLINK;
+
+=09n =3D readlink(self->link_path, buf, sizeof(buf) - 1);
+=09ASSERT_GE(n, 0) {
+=09=09TH_LOG("readlink failed with %s after %d readlink request(s)",
+=09=09       strerror(errno), g_ds.readlinks_seen);
+=09}
+=09buf[n] =3D '\0';
+=09EXPECT_STREQ(LINK_TARGET, buf);
+=09EXPECT_GT(g_ds.readlinks_seen, 1);
+}
+
+TEST_F(open_estale, refused_statfs_on_path_is_retried)
+{
+=09struct statfs sfs;
+
+=09g_ds.what =3D REFUSE_STATFS;
+
+=09/*
+=09 * statfs() describes the mount rather than the file, but it is still
+=09 * reached through a path walk, so a refusal that names a handle is
+=09 * retried the same way.
+=09 */
+=09ASSERT_EQ(0, statfs(self->file_path, &sfs)) {
+=09=09TH_LOG("statfs failed with %s after %d statfs request(s)",
+=09=09       strerror(errno), g_ds.statfss_seen);
+=09}
+=09EXPECT_GT(g_ds.statfss_seen, 1);
+}
+
+TEST_F(open_estale, absent_name_still_reports_absent)
+{
+=09int fd;
+
+=09/*
+=09 * Here it is the lookup that fails rather than the open, so nothing is
+=09 * being described as stale and the caller must still be told the name
+=09 * is not there.
+=09 */
+=09fd =3D open(self->absent_path, O_RDONLY);
+=09ASSERT_LT(fd, 0);
+=09EXPECT_EQ(ENOENT, errno);
+}
+
+TEST_HARNESS_MAIN
--=20
2.55.0.553.g4ad8c266be


