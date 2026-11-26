Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704450;
	b=kq/K/Xcx2adFTOgU59hOuV8ZUSkYg8rSstXMx3c3d+7JYUliv5yReY7edskh+92g2bPM
	 wkXwghfCv6crdR4Oh2CLHLCjuQkMo7B6I2jTfhGyWUNdcykW3L4jvOOre3peLc/k9m8/x
	 WanBJOJOvkvcQPld76sza4xoSlZMI+Ob31FqiMpRfV3bccq99VMNiJ3futgX7FOIAtMsn
	 gUkkM9eLk35D8nZZHIPg0h5aDLoplJnrSSY8cNI58OSYGTnF0d3+7ueoGN8ZRwK3gMMEd
	 KOo0O/Br1Rpsp0KQ5/4KdBFvn/JknTg7dPr3hSuTgtFavIsOp5ApijF+lJT2Zr9e3jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704450;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=YMtn23cPSjwohaR+qdTwIVB0MrBuoBWTZnklOfs8KQw=;
	b=WmRleo73A8p4bbkJ/xsZc/aseqW8MEjPzmYX/abcljvuX6sUYrb5HfliKLiaGJw0BIIF
	 R3r4GECFuygbu7xpbINFIIIiLGyC4B4lwetqAdMZUE8ZZe2UfgLCUwbcFBEiwSRNI65Kh
	 6NYw8l2HIJDOQ3G4KokvOkkbjsM0bQTwoqE3HEPncXTPBQxFIxiZ1grlFIiTwlhO1tR7N
	 /P1BY4KBqvDpiSW+z5IuczcMWa45y8dB7Ap/AxKdrSVYvdXl3U90eTwiQWJzfsZkoc/PU
	 PSrcnCxNeLI38Z4ZdaqinkU8+aBkBPUDQxs1pe96XFeNMe/U1a9n15pLoxuM2EMPnkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yyj9hibV;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6587B606A338
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 14:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6587B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yyj9hibV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795704449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMtn23cPSjwohaR+qdTwIVB0MrBuoBWTZnklOfs8KQw=;
	b=Yyj9hibV5/FxtHP0zPP8EoicH7UMRsb7XySl3mpqNq6ev4tHOZAivq04Yts2D37+VaUMzS
	Pumn3l3UdrJWHOs4UqXulXCWhEW6OKUTl0rCgWRdLs7cSq3SpslCaCshVRobugbMMFAni5
	jbx0giFz72cFf2q2U+I54HxFMVia+qE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-S5Y_XhJoNI-4u00-UCI-hQ-1; Thu, 26 Nov 2026 14:47:27 +0000
X-MC-Unique: S5Y_XhJoNI-4u00-UCI-hQ-1
X-Mimecast-MFC-AGG-ID: S5Y_XhJoNI-4u00-UCI-hQ_1795704446
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4a3705ea6ccso3965669f8f.2
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 06:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704446; x=1796309246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YMtn23cPSjwohaR+qdTwIVB0MrBuoBWTZnklOfs8KQw=;
        b=bsZXJuEV/dxNkMXX28a9KpXxdzkg/x1H0U1FjRLclKbdnqSlG2tn1uHOSBw4yHulrg
         123o7oOAkROAU7zcJcmHjeLk6+9iR+dW7G5Hjj2sRNtk0yd8xVK2oHE9NmPjMFL9WnZ5
         vP3gxZx1Ay2dhaROrNPmhMPcDEKLmlzHgWc1iWsJBsFsPqzscPgSUtKYsEZWeVo8AskZ
         4dSQ3g1gjHSU8mKu9HX3ZzCKx43KiTaICH36hOK1QjwweDzil88BSpko5WUO9n6/O2n/
         oCCrrf01l+y96ieY31Cum/T81eEgDRuld8WfwDlqJv0/pDX8TEBIp7j0iR4/CzUlNpYk
         zjdw==
X-Forwarded-Encrypted: i=1; AL+hErGAUFSLgzh0BZZCIAXSShncW7yaIm0qd5o0YWvpn10IoDKctAPaa9EA5igSuYXOx0M0SI2gyj1UpZEOm3apcw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+LUsD02SbG1EBwTBnPKVo7uC9mmAtO7t1ZRM2j4xc7c10mYx/Y
	sozRxgJ5tBMWFJXolmncoZkN78E3vxnVmWtHDjwQdmWp3Er4Y1GIEwaRJAERH+tIZZ3WqBoheMl
	TW/qUuWbLaQjBEBMUBNxzE2vLWlT+Zgf19WgMsShio11kAZiNVW6oqfm/H78Dbbr9cOee
X-Gm-Gg: AZFdTZfs9WxiAEcQDWWpQIszXbzLfW0k+vJvOIfwVqS5gUNvQ/UCmbH0xwSfIAwhbqI
	S4ZeWdvmqqVU7vwzHqPzSJQUKPzYfEysFNTXANbgVUn2QUOIbeWUNP0rzPSiE87IXOED4l96ert
	YlDsPkrH6kJcEeGgRG0QQbAissu2SxeKm+2ILcCtxUpF7d9rc6WFpixRP2+Lk27ko7c6rk7SmoS
	4Rl6A0S3UX+VQcGtKTX3P1zO90zqXdmgex9IMul+V1ofV5e/ct4J9sdu2ZjKzWNZ8LhPG90i4jU
	bu+cwA5E2eKaN0JOzHm6/cf6COMv3bD2NfSkD8hviqtxZAwPcpY7LqIV+AtMG2+WrKJbQ3eyDrw
	DS53LSaZBUON30dNvdXPYiG9VF6OghBj5B/sPio3HlNMJsJlGKgbj+cA9FbECR/aw+vNP3tcz/I
	hQ/aqsoyVlOqVkmdHMAGYVbIMV81lPnk9jlOTajw41
X-Received: by 2002:a05:600c:848d:b0:4ac:86c9:b09c with SMTP id 5b1f17b1804b1-4bb88811da9mr444341685e9.13.1795704446327;
        Thu, 26 Nov 2026 06:47:26 -0800 (PST)
X-Received: by 2002:a05:600c:848d:b0:4ac:86c9:b09c with SMTP id 5b1f17b1804b1-4bb88811da9mr444341335e9.13.1795704445882;
        Thu, 26 Nov 2026 06:47:25 -0800 (PST)
Received: from mszeredi-thinkpadt14gen6.redhat.corp (193-226-214-34.pool.digikabel.hu. [193.226.214.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb905f1489sm388114905e9.0.2026.11.26.06.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:47:25 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	virtualization@lists.linux.dev
Cc: Li Wang <liwang@kylinos.cn>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 5/5] virtiofs: fix forget leak on submount unmount
Date: Thu, 26 Nov 2026 15:47:18 +0100
Message-ID: <20261126144719.232329-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126144719.232329-1-mszeredi@redhat.com>
References: <20261126144719.232329-1-mszeredi@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zt8zuztOcVmbmP-T9iCNvxww7wta57wAjQFl7CTD3LU_1795704446
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

generic_shutdown_super() clears SB_ACTIVE before calling evict_inodes(),
so fuse_evict_inode() skipped both the FUSE_FORGET for fi->nlookup and
fuse_cleanup_submount_lookup() for every remaining inode.

For a full unmount that is mostly fine: FUSE_DESTROY has already told the
server to drop everything.  But a submount unmount takes the same path
with the connection still alive: fuse_mount_remove() returns false, so
fuse_conn_destroy() is not called and no FUSE_DESTROY is sent.  The
server then keeps the lookup count of every inode of the submount for the
lifetime of the connection, which can be arbitrarily long if the parent
mount stays around and submounts come and go.

fuse_submount_lookup is worse, because it is freed nowhere else: the
object and its embedded forget are leaked on any unmount, including a
full one, for every inode that has one.

Queue both regardless of SB_ACTIVE.  This is safe on the paths where the
connection is already gone: both fuse_dev_queue_forget() and
virtio_fs_send_forget() just free the link when the queue is
disconnected, and fc->chan stays valid until fuse_free_conn(), well after
evict_inodes().

Fixes: c4d361f66ac9 ("fuse: share lookup state between submount and its parent")
Cc: <stable@vger.kernel.org>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/inode.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 344fcb55a64b..81ee6c96203c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -141,6 +141,7 @@ static void fuse_cleanup_submount_lookup(struct fuse_conn *fc,
 static void fuse_evict_inode(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_conn *fc = get_fuse_conn(inode);
 
 	/* Will write inode on close/munmap and in all other dirtiers */
 	WARN_ON(inode_state_read_once(inode) & I_DIRTY_INODE);
@@ -157,19 +158,27 @@ static void fuse_evict_inode(struct inode *inode)
 	 */
 	if (FUSE_IS_VDAX(inode))
 		fuse_vdax_inode_cleanup(inode);
-	if (inode->i_sb->s_flags & SB_ACTIVE) {
-		struct fuse_conn *fc = get_fuse_conn(inode);
+	/*
+	 * Must be done unconditionally as well: on a submount unmount the
+	 * connection stays alive and no FUSE_DESTROY is sent, so without
+	 * this the server keeps the lookup counts of every inode in the
+	 * submount for the lifetime of the connection.  The
+	 * fuse_submount_lookup object is freed nowhere else, so skipping it
+	 * leaks that too.  If the connection is already gone (full unmount,
+	 * failed mount) fuse_chan_queue_forget() just frees the forget.
+	 */
+	if (fi->nlookup) {
+		fuse_chan_queue_forget(fc->chan, fi->forget, fi->nodeid,
+				       fi->nlookup);
+		fi->forget = NULL;
+	}
 
-		if (fi->nlookup) {
-			fuse_chan_queue_forget(fc->chan, fi->forget, fi->nodeid,
-					       fi->nlookup);
-			fi->forget = NULL;
-		}
+	if (fi->submount_lookup) {
+		fuse_cleanup_submount_lookup(fc, fi->submount_lookup);
+		fi->submount_lookup = NULL;
+	}
 
-		if (fi->submount_lookup) {
-			fuse_cleanup_submount_lookup(fc, fi->submount_lookup);
-			fi->submount_lookup = NULL;
-		}
+	if (inode->i_sb->s_flags & SB_ACTIVE) {
 		/*
 		 * Evict of non-deleted inode may race with outstanding
 		 * LOOKUP/READDIRPLUS requests and result in inconsistency when
-- 
2.56.1

