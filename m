Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EED43DDAFE;
	Thu, 27 Aug 2026 23:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787873901; cv=none; b=cBkXuaK7tF5Nmpg2pCDbmW1l4iCYHRDbgZ2QSLgda0iH2Pz+ww27x5velS5M482QJJxBGrvBrDgmL/gs2Zq1xorPCRaizMzEpwJuuxNcPNPqiFLkw5KcAns+6ECEYiBNynfxE2L/tz6sqDTf6QBuOsgkOh+mY1GDcGrvAICSogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787873901; c=relaxed/simple;
	bh=1RwU5fvHVJ9sE/KHEQbCOKdjhF2yFRswREVupkyZDLc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VizD8RI/CH3O4/Mi3rXNK1QdtCTQdn8H9nMM89050g0dSQCrLRMgHtt0WLhBdnvHWCfWJulfmTVRwkIDkz35MENQIWd3MfIq+9qX4mg0QBjC1n5ZUVGx3Kkd5fy9xJwdmCl36fop+YufKEgg4QfEKU3nQDsYQ3Y6l53+DL0gBag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=rPbrrgIA; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="rPbrrgIA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1787873898; x=1788133098;
	bh=GhkKQ/yNTlAm89/vtdaJit4+1X2iL5wuRhao6qGXmxk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rPbrrgIAABo5avGB3RGOdf27pddP+IENsOpgQR8pInOse2RqMFWg9kl3FdpC2Ec8A
	 z1OfXYbndNEcEmoSEZ9MFosfEH1jMJrkjjOa/A0fCvL5hl+O9lofK6wA0y8OQw2ZSK
	 oqSRtmTg01KwUaRoBnDs1mY5GgSjWWboEFH1NzI9xE7J79XrbYQ05tEELMzz6ZUyik
	 ehFZI+RmwraM2dSa73vx4ldYcjgPD01CsuiTHdvDNsTQCFDbouP3w6nAcLsm9ypItz
	 v9qvk9cuF0ow2flFE+i80pQikUrpq6PdnU6la94IBBW3sjveZTmfHALdBoS2bGd+FL
	 rw+SgvLLHIfFA==
Date: Thu, 27 Aug 2026 23:38:11 +0000
To: Miklos Szeredi <miklos@szeredi.hu>, Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, German Maglione <gmaglione@redhat.com>, Shuah Khan <shuah@kernel.org>
From: Aaron Paterson <apaterson@pm.me>
Cc: =?utf-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, Aaron Paterson <apaterson@pm.me>
Subject: [PATCH 5/5] virtiofs: report a request refused for a live nodeid as stale
Message-ID: <aa359b6b96737a97e92dd091f0817221916e2ebe.1787873791.git.apaterson@pm.me>
In-Reply-To: <cover.1787873791.git.apaterson@pm.me>
References: <cover.1787873791.git.apaterson@pm.me>
Feedback-ID: 6356313:user:proton
X-Pm-Message-ID: 65c8d97bb95cda0d9675916e00fdfd03930ac4db
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
something that has gone away, and the caller cannot tell the difference.

Report it at request completion so the caller can recover.

The opens say EOPENSTALE, which is what an open says when the cached
information it started from has gone stale. path_openat() decides what
that means for the walk in progress, answering ECHILD under LOOKUP_RCU
so it drops to REF-walk and ESTALE otherwise so the name is resolved
again under LOOKUP_REVAL. NFS reports its own stale opens the same way.

The rest say ESTALE, which retry_estale() answers by repeating the
lookup once under LOOKUP_REVAL. fs/namei.c, fs/open.c, fs/stat.c,
fs/statfs.c, fs/utimes.c and fs/xattr.c all reach it. EOPENSTALE would
be wrong for these, since path_openat() is the only place that
translates it and nothing would outside an open.

Converted: FUSE_OPEN, FUSE_OPENDIR, FUSE_GETATTR, FUSE_SETATTR,
FUSE_READLINK and FUSE_STATFS, the last sending no payload beside the
nodeid.

Not converted:

- Requests carrying a name, where ENOENT is ambiguous and is often what
  the caller asked to be told. FUSE_LOOKUP reports a missing name in a
  living directory and the directory operations carry a parent nodeid
  beside one. The xattr requests carry an attribute name, and a server
  answering ENOENT rather than ENODATA for a missing attribute would
  have a correct reply turned into a retry that cannot succeed.

- Requests against an already open descriptor, which have no equivalent
  retry to reach, and FUSE_IOCTL and FUSE_POLL, which hand the server's
  errno to userspace verbatim.

commit 68b69fa0edb2 ("virtiofs: add FUSE protocol validation") already
inspects replies at this point for servers that break the protocol.
Nodeid lifetime is another rule a server can break.

Found with a server that releases an inode as soon as a rename displaces
the name it was looked up by, where roughly one open in eight during a
rename race is refused while stat continues to describe the file.

Signed-off-by: Aaron Paterson <apaterson@pm.me>
---
 fs/fuse/virtio_fs.c | 62 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index f15e516ebcb5..7b03bf87c2ae 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -780,6 +780,66 @@ static bool virtio_fs_verify_response(struct fuse_req =
*req, unsigned int len)
 =09return true;
 }
=20
+/*
+ * Report a request refused for a live nodeid as stale.
+ *
+ * These requests carry a nodeid and no name, so the client only sends the=
m for
+ * an inode it has already looked up and holds a reference to, and a serve=
r owes
+ * the client that inode until it is sent FUSE_FORGET. A server answering =
with
+ * ENOENT is describing a handle it was obliged to honour rather than a na=
me
+ * that has gone away, and the caller has no reason to doubt it.
+ *
+ * Saying the handle is stale is something the caller knows how to answer:=
 it
+ * repeats the lookup under LOOKUP_REVAL and acts on whatever the name ref=
ers to
+ * now. A name that genuinely has gone fails the retried lookup, so a call=
er
+ * still learns it is gone. retry_estale() is what does this, and fs/namei=
.c,
+ * fs/open.c, fs/stat.c, fs/statfs.c, fs/utimes.c and fs/xattr.c all reach=
 it,
+ * which is what makes the conversion useful rather than a rename of the e=
rror.
+ *
+ * A request that names something which can itself be absent is left alone=
,
+ * because ENOENT is then ambiguous and is frequently the answer the calle=
r
+ * asked for. FUSE_LOOKUP reports a missing name in a living directory and=
 the
+ * directory operations carry a parent nodeid beside one, so neither can b=
e
+ * read as a statement about the inode. The extended attribute requests be=
long
+ * with them: they carry an attribute name, and while a server should repo=
rt a
+ * missing attribute as ENODATA, one that answers ENOENT instead would hav=
e a
+ * correct reply turned into a retry that cannot succeed.
+ *
+ * Requests against an already open descriptor are also left alone, since =
there
+ * is no equivalent retry to reach and converting the error would rename a
+ * failure rather than repair it, and FUSE_IOCTL and FUSE_POLL hand the
+ * server's errno to userspace verbatim.
+ */
+static void virtio_fs_fixup_stale_error(struct fuse_req *req)
+{
+=09if (req->out.h.error !=3D -ENOENT)
+=09=09return;
+
+=09switch (req->in.h.opcode) {
+=09case FUSE_OPEN:
+=09case FUSE_OPENDIR:
+=09=09/*
+=09=09 * An open says EOPENSTALE, and path_openat() decides what the
+=09=09 * walk in progress should make of it: ECHILD under LOOKUP_RCU
+=09=09 * so it drops to REF-walk, ESTALE otherwise so the name is
+=09=09 * resolved again under LOOKUP_REVAL. Naming ESTALE here would
+=09=09 * take the second in both cases and skip a cheaper retry.
+=09=09 */
+=09=09req->out.h.error =3D -EOPENSTALE;
+=09=09break;
+=09case FUSE_GETATTR:
+=09case FUSE_SETATTR:
+=09case FUSE_READLINK:
+=09case FUSE_STATFS:
+=09=09/*
+=09=09 * Nothing translates EOPENSTALE outside the open path, so
+=09=09 * these say ESTALE directly, which retry_estale() answers.
+=09=09 */
+=09=09req->out.h.error =3D -ESTALE;
+=09=09break;
+=09}
+}
+
 /* Work function for request completion */
 static void virtio_fs_request_complete(struct fuse_req *req,
 =09=09=09=09       struct virtio_fs_vq *fsvq)
@@ -810,6 +870,8 @@ static void virtio_fs_request_complete(struct fuse_req =
*req,
=20
 =09clear_bit(FR_SENT, &req->flags);
=20
+=09virtio_fs_fixup_stale_error(req);
+
 =09fuse_request_end(req);
 =09spin_lock(&fsvq->lock);
 =09dec_in_flight_req(fsvq);
--=20
2.55.0.553.g4ad8c266be


