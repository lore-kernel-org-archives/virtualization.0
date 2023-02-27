Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676F5C7EE23
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 15:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E88B66101F;
	Mon, 27 Feb 2023 15:51:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E88B66101F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PLXiBi+o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OWHz8JLG1MQZ; Mon, 27 Feb 2023 15:51:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6075660FE4;
	Mon, 27 Feb 2023 15:51:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6075660FE4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 441B9C0032;
	Mon, 27 Feb 2023 15:51:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0639DC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 15:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2DE081A95
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 15:51:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2DE081A95
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PLXiBi+o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JTTWmCVxoPGV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 15:51:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 089DE81987
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 089DE81987
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 15:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677513069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jNvg4E8Z6zMANFNmdTK5jx0RNqeAkDBts5LT2tbeeH0=;
 b=PLXiBi+oiPV4s3QlswrQ5x/7v5YobicIdipeBbBm+TA99yYpdMtsSP/Wfxn/uECp00Qh7I
 5STMd6MnyTUsAgXdq5bYLum8K6METXih8xryA4AGKunIdkfzRDpDwVA5BII0OgBblofx4P
 hEWSIEKVm+Yt7b823+FVBwBRdKh3pfs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-kuoRm_BlMQqWkCB96-PoRw-1; Mon, 27 Feb 2023 10:51:05 -0500
X-MC-Unique: kuoRm_BlMQqWkCB96-PoRw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0683857F40;
 Mon, 27 Feb 2023 15:51:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC6B61121314;
 Mon, 27 Feb 2023 15:51:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Jens Axboe <axboe@suse.de>, Matthew Wilcox <willy@infradead.org>,
 Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>
Subject: [RFC][PATCH v2] splice: Prevent gifting of multipage folios
MIME-Version: 1.0
Content-ID: <2740800.1677513063.1@warthog.procyon.org.uk>
Date: Mon, 27 Feb 2023 15:51:03 +0000
Message-ID: <2740801.1677513063@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

    
Don't let parts of compound pages/multipage folios be gifted by (vm)splice
into a pipe as the other end may only be expecting single-page gifts (fuse
and virtio console for example).

replace_page_cache_folio(), for example, will do the wrong thing if it
tries to replace a single paged folio with a multipage folio.

Try to avoid this by making add_to_pipe() remove the gift flag on multipage
folios.

Fixes: 7afa6fd037e5 ("[PATCH] vmsplice: allow user to pass in gift pages")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jens Axboe <axboe@suse.de>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: Amit Shah <amit@kernel.org>
cc: linux-fsdevel@vger.kernel.org
cc: virtualization@lists.linux-foundation.org
cc: linux-mm@kvack.org
---
 fs/splice.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 2e76dbb81a8f..8bbd7794d9f0 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -240,6 +240,8 @@ ssize_t add_to_pipe(struct pipe_inode_info *pipe, struct pipe_buffer *buf)
 	} else if (pipe_full(head, tail, pipe->max_usage)) {
 		ret = -EAGAIN;
 	} else {
+		if (PageCompound(buf->page))
+			buf->flags &= ~PIPE_BUF_FLAG_GIFT;
 		pipe->bufs[head & mask] = *buf;
 		pipe->head = head + 1;
 		return buf->len;

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
