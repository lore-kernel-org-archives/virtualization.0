Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4245BC7EE23
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 14:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB6EF81C21;
	Mon, 27 Feb 2023 14:23:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB6EF81C21
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fIq6dRzw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nSLsojNRXcLs; Mon, 27 Feb 2023 14:23:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 46A6E81B23;
	Mon, 27 Feb 2023 14:23:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 46A6E81B23
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21DF4C0033;
	Mon, 27 Feb 2023 14:23:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5B44C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 14:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B0CD481B23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 14:23:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B0CD481B23
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BgbQpreqX5QS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 14:23:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E854A81BB4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E854A81BB4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 14:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677507819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yg76FnkX04HHXW1mHvn8i4mIGRu2T9NZWGFYq1EPWQo=;
 b=fIq6dRzw7JUVYXx9vS6QpguAOdHoIRHGQjViBkwpD7pKABYJgkbBLo6YjlC/AM4IDxwrlx
 UpwcLpOgnCM9ryMqEc8wvVUPwGE9mjyrXP+YOgXKrWnU3enZ24Dsp9qkxGGLv5kR3KBoTy
 SFsvy/iGLSta9EKW1e5Ix2MvX3iGprc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-7dPZkuwNNC6edyeI5CsAig-1; Mon, 27 Feb 2023 09:23:35 -0500
X-MC-Unique: 7dPZkuwNNC6edyeI5CsAig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A5291C0418D;
 Mon, 27 Feb 2023 14:23:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FFABC15BAD;
 Mon, 27 Feb 2023 14:23:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
 Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>
Subject: [RFC][PATCH] splice: Prevent gifting of multipage folios
MIME-Version: 1.0
Content-ID: <2734057.1677507812.1@warthog.procyon.org.uk>
Date: Mon, 27 Feb 2023 14:23:32 +0000
Message-ID: <2734058.1677507812@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

    
Don't let parts of multipage folios be gifted by (vm)splice into a pipe as
the other end may only be expecting single-page gifts (fuse and virtio
console for example).

replace_page_cache_folio(), for example, will do the wrong thing if it
tries to replace a single paged folio with a multipage folio.

Try to avoid this by making add_to_pipe() remove the gift flag on multipage
folios.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: Amit Shah <amit@kernel.org>
cc: linux-fsdevel@vger.kernel.org
cc: virtualization@lists.linux-foundation.org
cc: linux-mm@kvack.org
---
 fs/splice.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 2e76dbb81a8f..33caa28a86e4 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -240,6 +240,8 @@ ssize_t add_to_pipe(struct pipe_inode_info *pipe, struct pipe_buffer *buf)
 	} else if (pipe_full(head, tail, pipe->max_usage)) {
 		ret = -EAGAIN;
 	} else {
+		if (folio_nr_pages(page_folio(buf->page)) > 1)
+			buf->flags &= ~PIPE_BUF_FLAG_GIFT;
 		pipe->bufs[head & mask] = *buf;
 		pipe->head = head + 1;
 		return buf->len;

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
