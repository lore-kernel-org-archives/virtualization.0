Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA829C7EE23
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 14:45:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79D2E416D2;
	Mon, 27 Feb 2023 14:45:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 79D2E416D2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=nhM1whik
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FHGIfM_3vizb; Mon, 27 Feb 2023 14:45:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BB212416AD;
	Mon, 27 Feb 2023 14:45:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB212416AD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F38CC0033;
	Mon, 27 Feb 2023 14:45:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2473C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 14:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DAA4360F8C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 14:45:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DAA4360F8C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=nhM1whik
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7eE1-yCz10eX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 14:45:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 019E260C0B
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 019E260C0B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 14:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=WHlGPMlhmQhls5CrvpHbn4RzyZ0OA10s0RB2VJXkfDc=; b=nhM1whikAgFj+vbpfnVeXY4oZY
 2vaGmpG5WPadKmsXWSJvTVN0HGNsG938uwJMOoDec3U3tmmvMz9KN2imgIYkuSrRWKIoAt1uINXkf
 d6QPAqlGXaY5YcU5bipS0QEKB8oquvo9rYL6pH7LG40EsaeFQB6pUUcBv2bGKIvEIhmD7ybmp58bK
 fy2rfHjPwEzaXBLcuV+UvfMepAY8tZPZ+RbaVLwstFi6isym9EmPKSGrq0gvhWAh0zGmHGwx+EcKB
 reCDUiICba0ySCfvlJkiDN/ho6hmwanYd9S7kNGnEUr87rIQQr09fuptXLjkwQDMyqp9Nv1Y6mi0G
 tQgqfF8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1pWekp-000BPv-2R; Mon, 27 Feb 2023 14:45:27 +0000
Date: Mon, 27 Feb 2023 14:45:27 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [RFC][PATCH] splice: Prevent gifting of multipage folios
Message-ID: <Y/zCB43mmeZ/vSbz@casper.infradead.org>
References: <2734058.1677507812@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2734058.1677507812@warthog.procyon.org.uk>
Cc: Amit Shah <amit@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
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

On Mon, Feb 27, 2023 at 02:23:32PM +0000, David Howells wrote:
>     
> Don't let parts of multipage folios be gifted by (vm)splice into a pipe as
> the other end may only be expecting single-page gifts (fuse and virtio
> console for example).
> 
> replace_page_cache_folio(), for example, will do the wrong thing if it
> tries to replace a single paged folio with a multipage folio.
> 
> Try to avoid this by making add_to_pipe() remove the gift flag on multipage
> folios.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

What should the Fixes: here be?  This was already possible with THPs
(both anon and tmpfs backed) long before I introduced folios.

> cc: Matthew Wilcox <willy@infradead.org>
> cc: Miklos Szeredi <miklos@szeredi.hu>
> cc: Amit Shah <amit@kernel.org>
> cc: linux-fsdevel@vger.kernel.org
> cc: virtualization@lists.linux-foundation.org
> cc: linux-mm@kvack.org
> ---
>  fs/splice.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/splice.c b/fs/splice.c
> index 2e76dbb81a8f..33caa28a86e4 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -240,6 +240,8 @@ ssize_t add_to_pipe(struct pipe_inode_info *pipe, struct pipe_buffer *buf)
>  	} else if (pipe_full(head, tail, pipe->max_usage)) {
>  		ret = -EAGAIN;
>  	} else {
> +		if (folio_nr_pages(page_folio(buf->page)) > 1)
> +			buf->flags &= ~PIPE_BUF_FLAG_GIFT;

		if (PageCompound(buf->page))
			buf->flags &= ~PIPE_BUF_FLAG_GIFT;

would be simpler and more backportable.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
