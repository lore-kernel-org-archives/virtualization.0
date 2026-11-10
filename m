Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322377;
	b=SaNE6TgnGCN2f0iduq2mx0egBRbQkULqkczHxuBw63IPFR3SFl3y34/qsRdCyl6RQwHF
	 YbtKq7+2g2TYltixhLVRAC+LH8rsJewR9nZR4skIPoewMGWMV0Ftt0+LiQLoLTXm6ZYqw
	 lbjIZ6lDKPFBi58UOPjxmnRA0UibH+F1rgKeD1jImBRcQExK4czA+oTlGNc/+2aFYyoNi
	 +aYHOpJizepEihmCznbvBls8O5qYkHO5oLiXa2xC83RpvMGbSjZEyGSgm2ztnNqNQU48G
	 YMJh/8itGRes0wR2ugcFQ8V5Adnm3ZlUlMUcguwkairxFtHE2C9E1f6e5FwuNZTxGog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322377;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BwatasSyxzcSR5rQ2WiN2NCOOtGU337FRGLRO/rHFE8=;
	b=RikOLg5JJwbkTGVw1tPk3vONfPLo+luYUzozsCq9XH4l5dQoOJgKY0bb+ZyWzn2Yg/lF
	 W62gi0bl1C4FrfLIBeBZsCPPFi+soXRMcbJDN1luN9Of7NnjcF7IgXdBdWUsN/bWvQtNY
	 6kG8YYti9UivUM67Lz4YkJZujGnC3LDneynCdubI6S/rdSKFCIAFtOsaRMfEaD/VUJ+xI
	 xsLgyvo4RP3jTUmML4YlVpfpYVNXEweipq+GDUKKv8hs25OJVj8E5DEdipffxlrg64oGO
	 UvyP7KAV6FUU7lqWOebQVTFdXtJD2B+rQdnsHMwXuG1ARejrldUzIaECC5kPGx31XPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U08LJBR0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DAE60A3820;
	Tue, 10 Nov 2026 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U08LJBR0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2628C1F008A2;
	Tue, 10 Nov 2026 14:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322376;
	bh=BwatasSyxzcSR5rQ2WiN2NCOOtGU337FRGLRO/rHFE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U08LJBR0OuX1nz4DK16aA9v3n6TjjOh2hm3zDewsjElsJ5cCoiDihlI+Pdp6xDEz2
	 dJXrO+SUuqwjnTHuHOvUAoagDmnb4u+qEKchDwHwE2RGq4jEPeMaKgykUf3kl0qTnx
	 joQG2qmHqKuL0VZ4aD+dATQycavsyejdWMODFIJOAI4GQCim+gEsPGlmYRTlo2Nu3R
	 FaJKAS3gOJLlMhkzT0FWvaOr1EYJMKJc1RBrAiDNQ+m0jToH30PNZQgZaqPid98ncI
	 tNbGZZ68XYedD2eo2DsJbThXn4y/G1fbQeGPGMFbhU5la0yqkdZ8G2bjUJgDANistx
	 KiYJ4zZBDi3Kg==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 663A11980047;
	Tue, 10 Nov 2026 09:52:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 10 Nov 2026 09:52:52 -0500
X-ME-Sender: <xms:wS_zak2W15IeFWn6kiyZTKk_0WwBxL9eKgrsBBFJORWUCTtbi7-08Q>
    <xme:wS_zavMM2PnWiv-kvgrNmh_7ZbXZrCvUZjOBqfMrGl5_tizfJQ5VrbbI9PHrD3z4m
    IEBWjWChULmn7DArkv60t8ZxFGiLMayYZZYDsbqkXHbzP3bozL9XrCo>
X-ME-Received: <xmr:wS_zaqszeiG2xVxpOI5pnM0D7M68peht3izRM5FN63Gqq2bMAt2oxnowDvE>
X-ME-Proxy-Cause: dmFkZTF+Cn+fSgda5ibRlg8z0HHd47AdQqgPs/uBN4NgEssRGADLpXszo7EdJ4hc6xz2Ef
    EUmaDyZaXcY+YL0D35VcXklWSGO8Ug1cC0CybUOo3mwF9pj0hl/2YQ82hQmzmrFF0mRvwv
    gl679KsfUxnSOavz6lY9EBi8U3CsSXr4Qnl0BS5Rjmt6ZpTTzNrlaWD4twI7L0h6db8KXe
    hL7mENu+NTXE/lgl7zKZ9G10X0CMpXoxVLVIFrzoEBolZB0xMHBwNm+EeoQ0TpWfQSdq79
    aWiko1YyVPAhQzDQdIdJfHn8x09SHcsYyBmY2iIQ7sfSmOyy2AqqhOBitTCqCwP/4fGaI0
    XAaUzKekg4g5tv+R3G/J8OgkJRg9K6kNgoFNH+6Oy5Q7CcgTDen2gesRc62jCx+fjrLQ3K
    2exx18ViYCt6lbV6J24anM3UtlAkUjkngmjn9FUZijG1U2klJLxsqPn/kUMOUAEGiFpYrj
    OmRQdmGlCGksTx5ePE0T6RF2aRHEPgskEVJZXZpTlDZPiTuaoAqQfRkg7/Bg14Z7++dpwB
    SbwlTGt4xiBzrauvN2gFWqvxlrwBjsEu+xnbV+fNgH9vS87ZH0+8a558EIaVVvFotxIcgc
    ipM7UkzR4MenaTa2sJ5cP+Rz55HMVinydGQ70cCSY6Q3tFL4HhSWy9nTppMw
X-ME-Proxy: <xmx:wS_zaiHhDIsmgyNP81PC0H1Q7IfNyS-g10JBq9zAvIUESBWt-MKB8w>
    <xmx:wS_zalQvRUnfbzsKrRN4lLJsJkcphv-zz0_tiCgtm4R_d7bHP_bY8Q>
    <xmx:wS_zamiS8IMRsBzbbfQ1rdhM9UuJzkM474EIMj--zuKpuwNHRR--2g>
    <xmx:wS_zapbsSVzo7a-eRELIHRz4o6nUtAzAPgYE_RcXz3jFzrJe0NQdaA>
    <xmx:wS_zanWB491OLGGbLJ0DXsP-bXV7GHeVBZEJMR_pyA8jGu0_H-ow4j2u>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 09:52:49 -0500 (EST)
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
Subject: [PATCH 1/4] virtio_console: copy pipe buffers in splice_write()
Date: Tue, 10 Nov 2026 14:52:36 +0000
Message-ID: <20261110145241.536019-2-kas@kernel.org>
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

pipe_to_sg() tries to steal the page of each pipe buffer and pass it to
the host as it is.  When the steal fails, it copies the data into a page
of its own.

Pages written into the pipe with write(), gifted user pages and page
cache pages can be stolen.  The ftrace ring buffer pages that
virtio-trace splices cannot, so that in-tree user always gets the copy.

Always copy.  The data that reaches the host does not change.

Preparation for removing ->try_steal() from pipe buffers.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 drivers/char/virtio_console.c | 39 +++++++++++++----------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 019bcae81af5..b1b1aaf43e07 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -891,45 +891,34 @@ static int pipe_to_sg(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
 {
 	struct sg_list *sgl = sd->u.data;
 	unsigned int offset, len;
+	struct page *page;
+	char *src;
 
 	if (sgl->n == sgl->size)
 		return 0;
 
-	/* Try lock this page */
-	if (pipe_buf_try_steal(pipe, buf)) {
-		/* Get reference and unlock page for moving */
-		get_page(buf->page);
-		unlock_page(buf->page);
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
 
-		len = min(buf->len, sd->len);
-		sg_set_page(&(sgl->sg[sgl->n]), buf->page, len, buf->offset);
-	} else {
-		/* Failback to copying a page */
-		struct page *page = alloc_page(GFP_KERNEL);
-		char *src;
+	offset = sd->pos & ~PAGE_MASK;
 
-		if (!page)
-			return -ENOMEM;
+	len = sd->len;
+	if (len + offset > PAGE_SIZE)
+		len = PAGE_SIZE - offset;
 
-		offset = sd->pos & ~PAGE_MASK;
+	src = kmap_local_page(buf->page);
+	memcpy(page_address(page) + offset, src + buf->offset, len);
+	kunmap_local(src);
 
-		len = sd->len;
-		if (len + offset > PAGE_SIZE)
-			len = PAGE_SIZE - offset;
-
-		src = kmap_local_page(buf->page);
-		memcpy(page_address(page) + offset, src + buf->offset, len);
-		kunmap_local(src);
-
-		sg_set_page(&(sgl->sg[sgl->n]), page, len, offset);
-	}
+	sg_set_page(&sgl->sg[sgl->n], page, len, offset);
 	sgl->n++;
 	sgl->len += len;
 
 	return len;
 }
 
-/* Faster zero-copy write by splicing */
+/* Write by splicing, copying the data from the pipe */
 static ssize_t port_fops_splice_write(struct pipe_inode_info *pipe,
 				      struct file *filp, loff_t *ppos,
 				      size_t len, unsigned int flags)
-- 
2.54.0

