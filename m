Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82539388E40;
	Thu, 27 Aug 2026 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787873860; cv=none; b=qd7zBitERxxhSB6niNjCasMdh+pEX+JXZAlIFFKwYICJGodN62PDy8cdqy94BcT1c3KSwfRVZHLfN62QtC4KLd+1jYBcbjvqSEnSwrGEDt87muVquT+gJItwzB0XTRXMY2jGZocsXPv/EjCLdtkCdsWX8CxhlHhXXfa6HKWZdkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787873860; c=relaxed/simple;
	bh=roJWN4cAkw3lsWVT+3PPpbj8f+Kp9XmLq5Rgq241830=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=apJOkknm3ZH9ymYASwu4vQfViN3DpctNven8H/lC064G7qUAknHv88+mgcpvYCGqXd4BWedUmg+Tj3vIUZgUVOBsBtCy8z0YENtBLu60wGL7Y/gBinyU8IY3LSTLnogt3KOEvfOozXnMm/4a5BiIEmEAUxcX2sB3nRGhwwpEOdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=TfA53l96; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="TfA53l96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1787873849; x=1788133049;
	bh=yVSYTNeXd6hS3RLPYC9rT3aHpFbl1zbVD5TY6q52Up4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TfA53l96Uh5Xp1XxlEEPe16GU/IynCmD/J07QmuPjhKrHP0/D5VG3QgnS6qxToTga
	 s97bSTpQ8oMj/BdUXtS9DJxen0ErYa5enL1zGExXxFezRybIXgPJDoTT1WDjU0ETZ3
	 QLf6Wiv2L5FWQFvvTMy1NN2YXfTcJs/XShcQ7+Zcc9l6VI1V0dGNS42TGNRCDMUBAV
	 UCidsR8lxMQvJBtS6ItGXiUPkuR9qRY1i79rCUb7jDihsE4zAWdukz3VSvMMjHuXqB
	 5TBteDqUqH4f1mqdeoFX0UeKLhNxKhnP8v8BsQ/doMFQtxc/yCdekD0TDWRfXnCijb
	 /A3D4sFcVqU2A==
Date: Thu, 27 Aug 2026 23:37:24 +0000
To: Miklos Szeredi <miklos@szeredi.hu>, Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, German Maglione <gmaglione@redhat.com>, Shuah Khan <shuah@kernel.org>
From: Aaron Paterson <apaterson@pm.me>
Cc: =?utf-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, Aaron Paterson <apaterson@pm.me>
Subject: [PATCH 0/5] fuse: report a request refused for a live nodeid as stale
Message-ID: <cover.1787873791.git.apaterson@pm.me>
Feedback-ID: 6356313:user:proton
X-Pm-Message-ID: 4f6b556ef2198c8aff6e9b8b3a4ea46157b46f15
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A FUSE request that names a nodeid and nothing else is only sent for an
inode the client has looked up and holds a reference to, and the server
owes the client that inode until it is sent FUSE_FORGET. When a server
answers such a request with ENOENT it is describing a handle it was
obliged to honour, not a file that has gone away, and the client passes
that ENOENT to the caller unchanged: a file that never stopped existing
is reported missing.

This series reports that case as stale instead, so the VFS retries the
lookup rather than handing a spurious ENOENT to userspace. The path
opens say EOPENSTALE, which is what an open says when the cached
information it started from has gone stale and which path_openat()
resolves into ECHILD under LOOKUP_RCU or ESTALE otherwise; everything
else says ESTALE, which retry_estale() answers by repeating the lookup
once under LOOKUP_REVAL. NFS reports its own stale opens the same way.

The conversion is written twice, once in fs/fuse for any transport and
once in fs/fuse/virtio_fs.c at reply completion, and each one fixes the
symptom without the other. They are sent together because they were
found together; if only one is wanted, patch 3 is the general one and
patch 5 is the virtio-specific one, and either can be dropped.

Why it matters, and how it was found: a server that releases an inode
as soon as a rename displaces the name it was looked up by will refuse
opens for inodes the client still holds. On such a server, roughly one
open in eight during a rename race is refused while stat continues to
describe the file. That reaches real programs. git's t5318 fails 52 to
53 subtests per round against such a mount and 0 against local disk on
the same machine in the same alternating run, and the mechanism is
visible underneath it: .git/index opens ending ENOENT are 49 of 116 on
the affected mount against 9 of 157 on local disk, where those 9 are
the legitimate ones a fresh repository makes before an index exists.
The user-visible failure is a destroyed git index.

Measurements. All four arms are one kernel source, 6.18.5, with one
config, built from trees that differ only in whether these patches are
applied, run against the same server with the same probe for the same
duration:

  arm  fs/fuse  virtio_fs  opens    refused
   A   stock    stock      323076   45201 (14.0%)
   B   stock    patched     54378   0
   C   patched  stock      323776   0
   D   patched  patched    315114   0

Every refusal on arm A is the contradiction: open said ENOENT while
stat on the same path still described the file. Arms C and A carry
almost identical open counts against the same server, so the pair
differing only in fs/fuse is 45201 refusals against none. Arms B and C
are why the two conversions are sent together but either can be
dropped: each removes the symptom without the other.

For the record, the same fault measured 12.9% on a 6.8 distro kernel
three weeks earlier, so nothing between 6.8 and 6.18 addressed it, which
is consistent with these patches applying to current mainline with only
hunk-offset movement.

The first two patches are selftest housekeeping that patch 4 needs: a
build artifact that was not ignored, and a rename of the libfuse3
pkg-config variables so a second test can share the same guard. Patch 4
is the test itself, which mounts a libfuse3 server that refuses one
request for a live nodeid and asserts the caller does not see ENOENT.
It skips where libfuse3 or fusermount3 is unavailable.

checkpatch is clean apart from two warnings I believe are false
positives, and I would rather name them than leave them to be
rediscovered: MAINTAINERS already carries
F: tools/testing/selftests/filesystems/fuse/ under FUSE FILESYSTEM
[CORE], so the new selftest needs no MAINTAINERS change; and the
char *fuse_argv[] in the test cannot be static const, because
struct fuse_args carries a plain char **argv that libfuse may modify.

Aaron Paterson (5):
  selftests/fuse: ignore the built acl cache test
  selftests/fuse: name the libfuse3 flags for the library
  fuse: report a request refused for a live nodeid as stale
  selftests/fuse: cover a request refused for a live nodeid
  virtiofs: report a request refused for a live nodeid as stale

 fs/fuse/dir.c                                 |  10 +
 fs/fuse/file.c                                |  11 +
 fs/fuse/fuse_i.h                              |  19 +
 fs/fuse/inode.c                               |   2 +-
 fs/fuse/virtio_fs.c                           |  62 +++
 .../selftests/filesystems/fuse/.gitignore     |   2 +
 .../selftests/filesystems/fuse/Makefile       |  16 +-
 .../filesystems/fuse/fuse_estale_test.c       | 450 ++++++++++++++++++
 8 files changed, 565 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_estale_te=
st.c

--=20
2.55.0.553.g4ad8c266be


