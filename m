Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE90CC74A5B
	for <virtualization@archiver.kernel.org>; Wed, 29 Mar 2023 14:39:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 553D741D25;
	Wed, 29 Mar 2023 14:39:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 553D741D25
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I7DsYnxI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wKVtucUBO1Ey; Wed, 29 Mar 2023 14:39:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E40AA4000B;
	Wed, 29 Mar 2023 14:39:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E40AA4000B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9A50C0037;
	Wed, 29 Mar 2023 14:39:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68EF2C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 14:39:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3771884153
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 14:39:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3771884153
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=I7DsYnxI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ysLen3L6EoAU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 14:39:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 74CEC8414E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74CEC8414E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 14:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680100785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eOGvCBK3xTc7UhN8iQW8f99rBt5fCj0lar0/GGKSAUo=;
 b=I7DsYnxIXi+N95JxEr8u3mTDsEOO3Rl0GZAt2maRaaN0hsdWK0xUa7V6pfebfrJYdZhYdN
 bDX2gKAThIpA9TbaQAw78yN0rmH+SuZcOynknYVd4L3pGUxJoVVAGJYJ2eQLKYj202wOZi
 DV2odxcOIVHprMQ3Mqw2nfO/NOT6REU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-OX_M3mnhOyOLIjTwhOpgsw-1; Wed, 29 Mar 2023 10:39:40 -0400
X-MC-Unique: OX_M3mnhOyOLIjTwhOpgsw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52F783C10ED2;
 Wed, 29 Mar 2023 14:39:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 900FA2166B33;
 Wed, 29 Mar 2023 14:39:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <e128356a-f56f-4c02-7437-dfea38e4194b@suse.de>
References: <e128356a-f56f-4c02-7437-dfea38e4194b@suse.de>
 <20230329141354.516864-1-dhowells@redhat.com>
 <20230329141354.516864-49-dhowells@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC PATCH v2 48/48] sock: Remove ->sendpage*() in favour of
 sendmsg(MSG_SPLICE_PAGES)
MIME-Version: 1.0
Content-ID: <518630.1680100773.1@warthog.procyon.org.uk>
Date: Wed, 29 Mar 2023 15:39:33 +0100
Message-ID: <518631.1680100773@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Cc: linux-doc@vger.kernel.org, virtualization@lists.linux-foundation.org,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 linux-sctp@vger.kernel.org, linux-afs@lists.infradead.org,
 rds-devel@oss.oracle.com, linux-x25@vger.kernel.org, dccp@vger.kernel.org,
 linux-rdma@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-hams@vger.kernel.org, mptcp@lists.linux.dev,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 Chuck Lever III <chuck.lever@oracle.com>,
 tipc-discussion@lists.sourceforge.net, linux-crypto@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, linux-wpan@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

Hannes Reinecke <hare@suse.de> wrote:

> > [!] Note: This is a work in progress.  At the moment, some things won't
> >      build if this patch is applied.  nvme, kcm, smc, tls.

Actually, that needs updating.  nvme and smc now build.

> Weelll ... what happens to consumers of kernel_sendpage()?
> (Let's call them nvme ...)
> Should they be moved over, too?

Patch 42 should address NVMe, I think.  I can't test it, though, as I don't
have hardware.

There should be no callers of kernel_sendmsg() by the end of this patchset,
and the only remaining implementors of sendpage are Chelsio-TLS, AF_TLS and
AF_KCM, which as stated in the cover, aren't yet converted and won't build.

> Or what is the general consensus here?
> 
> (And what do we do with TLS? It does have a ->sendpage() version, too ...)

I know.  There are three things left that I need to tackle, but I'd like to
get opinions on some of the other bits and I might need some help with AF_TLS
and AF_KCM.

That said, should I just remove tls_sw_do_sendpage() since presumably the data
is going to get copied(?) and encrypted and the source pages aren't going to
be held onto?

David

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
