Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8ED3CF694
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 23:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787873879; cv=none; b=NU9lHCr41n+tl4bBWzISukWIFTehgjoWy86E+yMjiAWcVNIqHl0PplAs2ZP7Jx3yzrpeVjNSTnIahfYJsq0iJO8hWuHnKvwubNvTpbTjdeHppzouqfFMz0Ke8LXPGf3kAbGoZHnQsNcrMQ2E1EU85ttAGahluVXQJVFO9bbbp3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787873879; c=relaxed/simple;
	bh=+8Xt3nYlPyrQ87kYXz05YT1UtjZL8RO50P+bbLMB/SY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EW8F1jtRSL5w+jnt6m2QONQhRKDJFmSIp50wsWuuTWWGQicrKvA4eSjY1Bl1ODRAftXPKBIpCdhOB9q9Zuo3cL46EYYdzu+NyeKCVlwjQK2mMb4j1FMDQsk6VBdLsIQbNRr7BUsiXLmqQab2G/eJ8+DUFAAWPGqPURxyHiQb39E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=INQLORai; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="INQLORai"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1787873869; x=1788133069;
	bh=+8Xt3nYlPyrQ87kYXz05YT1UtjZL8RO50P+bbLMB/SY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=INQLORai9suJFTs88qEP3gSXfQxhwG8QyTsxm00cJbET8fw829mz+hslIRZvsY0Br
	 7ohE5Rshqir+dpPYn+C+FokNpB11phpLYps+T4Jp/bBs0T9C3LJtmWcoGscA1KhanU
	 Q3sj6/TyHkBnDtLEs3ti10RS5uBNO5tSOFzvIsjK7AzQaHaNdjVH438pPzJwJ2yR0p
	 WdVxfb4yOGaURV28wKTfskAW68Ajb5w65UxclwRHiEMMPcQZlPquSSn+XrliF0qWRe
	 kS80XOlmKKa9ixa9sMNTpVkH0wdi7Qte4at6TR7aT0XSfNw9hNf0S+V/ns4efuMlNc
	 OuZtoRwAPA4LQ==
Date: Thu, 27 Aug 2026 23:37:43 +0000
To: Miklos Szeredi <miklos@szeredi.hu>, Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, German Maglione <gmaglione@redhat.com>, Shuah Khan <shuah@kernel.org>
From: Aaron Paterson <apaterson@pm.me>
Cc: =?utf-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, Aaron Paterson <apaterson@pm.me>
Subject: [PATCH 2/5] selftests/fuse: name the libfuse3 flags for the library
Message-ID: <1000f6fe22b08168ddebc910d8204cd5ec048fb5.1787873791.git.apaterson@pm.me>
In-Reply-To: <cover.1787873791.git.apaterson@pm.me>
References: <cover.1787873791.git.apaterson@pm.me>
Feedback-ID: 6356313:user:proton
X-Pm-Message-ID: f1115e9b3eacac6d00d08b7420bff58bde6659df
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The flags describe libfuse3 rather than the one test that
currently uses them, so any further test needing the library can share
them.

Signed-off-by: Aaron Paterson <apaterson@pm.me>
---
 tools/testing/selftests/filesystems/fuse/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/filesystems/fuse/Makefile b/tools/test=
ing/selftests/filesystems/fuse/Makefile
index 95a1ee947ca7..1ea87008ef9e 100644
--- a/tools/testing/selftests/filesystems/fuse/Makefile
+++ b/tools/testing/selftests/filesystems/fuse/Makefile
@@ -6,10 +6,10 @@ TEST_GEN_PROGS :=3D fusectl_test
 TEST_GEN_PROGS +=3D write_extend_eof_test
 TEST_GEN_FILES :=3D fuse_mnt
=20
-# fuse_acl_cache_test requires libfuse3; add it only when the library is p=
resent.
-ACL_CFLAGS :=3D $(shell pkg-config fuse3 --cflags 2>/dev/null)
-ACL_LDLIBS :=3D $(shell pkg-config fuse3 --libs 2>/dev/null)
-ifneq ($(ACL_CFLAGS),)
+# These tests require libfuse3; add them only when the library is present.
+FUSE3_CFLAGS :=3D $(shell pkg-config fuse3 --cflags 2>/dev/null)
+FUSE3_LDLIBS :=3D $(shell pkg-config fuse3 --libs 2>/dev/null)
+ifneq ($(FUSE3_CFLAGS),)
 TEST_GEN_PROGS +=3D fuse_acl_cache_test
 endif
=20
@@ -30,5 +30,5 @@ endif
 $(OUTPUT)/fuse_mnt: CFLAGS +=3D $(VAR_CFLAGS)
 $(OUTPUT)/fuse_mnt: LDLIBS +=3D $(VAR_LDLIBS)
=20
-$(OUTPUT)/fuse_acl_cache_test: CFLAGS +=3D $(ACL_CFLAGS)
-$(OUTPUT)/fuse_acl_cache_test: LDLIBS +=3D $(ACL_LDLIBS)
+$(OUTPUT)/fuse_acl_cache_test: CFLAGS +=3D $(FUSE3_CFLAGS)
+$(OUTPUT)/fuse_acl_cache_test: LDLIBS +=3D $(FUSE3_LDLIBS)
--=20
2.55.0.553.g4ad8c266be


