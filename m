Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322392;
	b=aLvKvzsSgyDG1kN0kt4A0kIgwloVM56od4wxCcYpdIWOclU0/pv89v1w0HbpAqIEk6X7
	 fjRp5KmQvaPzKEijprs1dlMOzEsRMq6u5O8zrAQXGEbr6IZwEON/Awvv8C2EvzbQKIhtz
	 vosUTsUD7krFdMaLa7O3XIknHEgTncHQnyTHOxt6ZZRq1vonQkv3l1bkvjHsuTPAFVHyF
	 zZcnRtBkz/ZyYaYVjAOpn72yLpMEHh5IGztEDKvVG+zQQgrrNWZJ+VkFzgQuedNu9bBiu
	 qejsvAcZrK0W4md1TtBahxFXjkMrjCpz1IG5LEhSBNUXKO0dLnY6ASyVNwqXfkfKP7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322392;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4AWesagrBNDvfdI2Zrx2GdO8Neuv0xeD/dEdr3QPpV4=;
	b=sDwmKrQcJOh8EWbfex9zAOWcEe368U/rKZbwimPwkgep+d73nog+4aMNog9XhD2miaGH
	 DiqMG4xdltYCG7k1DfTSLIlT/Vz3GeOzKdv6VsJHoXF5as8AhwKdydsRwjvAgYwm7mp/H
	 1O8maO28OMI/ojWUy+VeouLtn3GreH4Zthu2UGbmeZf1yQ24rdeiY7v4HM0idXvajrT6j
	 CcLiC3t7Mj/yRKPexBNfoUqdmaGnCnZSKb566LNpx36GK99sTKAnH2BF1I00ItvvEhNrP
	 Ues9IMBikJ9RBDoNtylBU+nyjziBPQDGiBgceHwASc/84gxC68ACMrnmf3ELQJPyZAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X0BILfpy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099E860A261D;
	Tue, 10 Nov 2026 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X0BILfpy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2C51F008AB;
	Tue, 10 Nov 2026 14:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322391;
	bh=4AWesagrBNDvfdI2Zrx2GdO8Neuv0xeD/dEdr3QPpV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X0BILfpyhkI1twzshQY1CBbkAf9gPmYBCjF2zMtdK47xceH4aBn/beep5dQeDIyFi
	 37/OPZOTQzO9ghxDDdqVTFUlv/z6+/42EoudlTU+FrV2waaQklZzqig/w+ymiOHvX5
	 FmlelIuLweuSVFNKrYNDiol2gEZBZmpFLxV9YFkCVboevwU/djbdK1eEDVyi3Qjg0F
	 Cu6R3wn8LjuwlMF7KGQPz+Oz7fhNho2ouHxTTVoXReJ5xri1k/S027jfZ9I6m3V1lf
	 i0AYo4HjI6F6L1BNWsv0EApQPcmUk32gBJp5zh75BpI7FFUC2cQbksy4yjGArkqB01
	 rRKyhckYjkjrA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id A0A541980047;
	Tue, 10 Nov 2026 09:53:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 10 Nov 2026 09:53:08 -0500
X-ME-Sender: <xms:0i_zalTYoDMGGwfGOcj7NFVWzH10MzzR7E4etw4bM108qMV0Ea6UxA>
    <xme:0i_zau5zTzFmPi1hYQSfuP-dz83bs2BZpo5tFfBzaZW_auKGV7ew6b0BKTb_KMWqL
    eX5sdFfb9ah-wNTD94HPi2dUWaHxQxasqVLAijxEvPq-lCyc9KwypAQ>
X-ME-Received: <xmr:0i_zaoqOOp8SxW4JGrZJ-WN_xb6XFInYPyMH93ZmUbEL7eFukgoXBO4skZM>
X-ME-Proxy-Cause: dmFkZTF/GFwh3rJdTHG+m4r/9nusArKB1/s/hEpKI5zPgz/j0NVs9fG+TFrQQtAuHGmWgA
    1tbmW3cxIzETgFcEkRf1jbRH09C/7wAmZtr7m1PAmHObJ0oPHKuJRs7OjPD+Yu1tUwWEfJ
    1waEsEuvglqdq+285oX/U2cWR/80QeQcu1jy8nii0+pJH8NB4DjUh758N4RM3iv10TIYNc
    uUKUSJga2KhUyfObbaC1KG0agxblxhp0nCVf8eCx7DFBKYc8e72YJYcOR0tezufCSh/yQK
    AwHzdksBbKWava7E3bJ7mWP5dEA/52o2Vw+Ypoga3ieMrWz9YkgBgJBGSf9TaMGUhbVwHN
    i9mgZDSMBr/kJlbNNSoHt3C10F31V9EDA1mhOk/6BT4QesLc7dExast3CNoDPurrsYIQLD
    bhc9hYCfCjasTg/8a4p0LzrPB3hejJgMh7PKRRrOUxihmv8TOc66WU/NmJdY2qRzM2QNYh
    1YayCPgJIn8kSsPpMnXZLo0JNHPXeuEval8vfDzG94/MmVT+kbaDQ+lmqPCJfZIjBWGMCr
    0FlkMJ1FP7f7GXGFRwgTPnofBkjrKYB5efCsSnvl0y0QjGGFZiPZGsk9HwKsqQRXd9XmjZ
    GFghtwH5ZbE7GACYhuOt2og4KnmM6jqwikwaIF0v5VpX+wniaYTn199C4DzQ
X-ME-Proxy: <xmx:0i_zahTsKw9rvhh6OOwTNOjiqYih3Fbvnlhk8jJOle4RBf__EuWzVg>
    <xmx:0i_zassqV0D2roeDBKn_2laU7WeGaevNL_liV8bY39pn6RZSS3nzPQ>
    <xmx:0i_zahOOOeKmxVT0lDwJqrl4pIkGIOiH8X_Cjb1B4Wp8KXZ0Di2Ojg>
    <xmx:0i_zamW2HF-ReEBeOE7_h0swvMseBB3aOND-fH2ZJirHhIJXXQSLWw>
    <xmx:0i_zaphox_-Bc3Xu-2j9WCASmv-rJKu99hChxOC0s84PeCuzS-Lj1AQQ>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 09:53:05 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amit Shah <amit@kernel.org>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Zi Yan <ziy@nvidia.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 4/4] splice: replace nosteal_pipe_buf_ops with default_pipe_buf_ops
Date: Tue, 10 Nov 2026 14:52:39 +0000
Message-ID: <20261110145241.536019-5-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110145241.536019-1-kas@kernel.org>
References: <20261110145241.536019-1-kas@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without ->try_steal(), nosteal_pipe_buf_ops and default_pipe_buf_ops are
the same: generic_pipe_buf_release() and generic_pipe_buf_get().

Keep default_pipe_buf_ops, and use it in skb_splice_bits() and
fuse_dev_splice_read().  Export it in place of nosteal_pipe_buf_ops,
since fuse can be built as a module.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 fs/fuse/dev.c             | 2 +-
 fs/splice.c               | 8 +-------
 include/linux/pipe_fs_i.h | 2 --
 net/core/skbuff.c         | 2 +-
 4 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e7238eed21fb..a5c08a00cf83 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1627,7 +1627,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
 		 * Need to be careful about this.  Having buf->ops in module
 		 * code can Oops if the buffer persists after module unload.
 		 */
-		bufs[page_nr].ops = &nosteal_pipe_buf_ops;
+		bufs[page_nr].ops = &default_pipe_buf_ops;
 		bufs[page_nr].flags = 0;
 		ret = add_to_pipe(pipe, &bufs[page_nr++]);
 		if (unlikely(ret < 0))
diff --git a/fs/splice.c b/fs/splice.c
index ba8f6f9aa3f0..e9e0c6a7b23c 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -333,13 +333,7 @@ const struct pipe_buf_operations default_pipe_buf_ops = {
 	.release	= generic_pipe_buf_release,
 	.get		= generic_pipe_buf_get,
 };
-
-/* Pipe buffer operations for a socket and similar. */
-const struct pipe_buf_operations nosteal_pipe_buf_ops = {
-	.release	= generic_pipe_buf_release,
-	.get		= generic_pipe_buf_get,
-};
-EXPORT_SYMBOL(nosteal_pipe_buf_ops);
+EXPORT_SYMBOL(default_pipe_buf_ops);
 
 static void wakeup_pipe_writers(struct pipe_inode_info *pipe)
 {
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index fb6570e80d01..95f6236c5c5b 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -302,8 +302,6 @@ void free_pipe_info(struct pipe_inode_info *);
 bool generic_pipe_buf_get(struct pipe_inode_info *, struct pipe_buffer *);
 void generic_pipe_buf_release(struct pipe_inode_info *, struct pipe_buffer *);
 
-extern const struct pipe_buf_operations nosteal_pipe_buf_ops;
-
 unsigned long account_pipe_buffers(struct user_struct *user,
 				   unsigned long old, unsigned long new);
 bool too_many_pipe_buffers_soft(unsigned long user_bufs);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 48f676411724..e063241b2005 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3281,7 +3281,7 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		.pages = pages,
 		.partial = partial,
 		.nr_pages_max = MAX_SKB_FRAGS,
-		.ops = &nosteal_pipe_buf_ops,
+		.ops = &default_pipe_buf_ops,
 		.spd_release = sock_spd_release,
 	};
 	int ret = 0;
-- 
2.54.0

