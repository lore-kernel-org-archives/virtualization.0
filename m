Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA80C54EED
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 11:24:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 187BD41768;
	Mon, 30 Jan 2023 11:24:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 187BD41768
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CEV6fE1N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pfQp1HyG_05A; Mon, 30 Jan 2023 11:24:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 66BDC41765;
	Mon, 30 Jan 2023 11:24:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 66BDC41765
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 387D7C0032;
	Mon, 30 Jan 2023 11:24:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74207C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 11:24:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 392F6819F5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 11:24:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 392F6819F5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CEV6fE1N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ff1b2vYf9SX1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 11:24:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5FE6D819E6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5FE6D819E6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 11:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675077862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w9A1bVyZb4er6cTd4zzjsltmhyvgIyU7DAJ3a6jVt6A=;
 b=CEV6fE1NnxI1qd5I5YXmHINlJM3adbaiFD+THEEGsu20P2sS18dgpHbjzYkNlclEEYbtPb
 xiXGLMJuOz0BJYRB1Nc83JJX/Hh9xmoC6iaMN5yBqZvq93x4yQnoPN0IcOdgxgARTMOnOr
 J8SL87nL6kG5n9vVv384IzZ6NLMK3Oo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-JYIlhA5gM_SRvbpUiBK1og-1; Mon, 30 Jan 2023 06:24:18 -0500
X-MC-Unique: JYIlhA5gM_SRvbpUiBK1og-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15A29382C965;
 Mon, 30 Jan 2023 11:24:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27FB8492B05;
 Mon, 30 Jan 2023 11:24:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20230130103343.GA11663@lst.de>
References: <20230130103343.GA11663@lst.de>
 <20230130092157.1759539-21-hch@lst.de> <20230130092157.1759539-1-hch@lst.de>
 <3347459.1675074683@warthog.procyon.org.uk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 20/23] rxrpc: use bvec_set_page to initialize a bvec
MIME-Version: 1.0
Content-ID: <3351917.1675077855.1@warthog.procyon.org.uk>
Date: Mon, 30 Jan 2023 11:24:15 +0000
Message-ID: <3351918.1675077855@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Cc: linux-block@vger.kernel.org, linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-cifs@vger.kernel.org, netdev@vger.kernel.org,
 samba-technical@lists.samba.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, dhowells@redhat.com,
 linux-mm@kvack.org, target-devel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-afs@lists.infradead.org, devel@lists.orangefs.org
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

Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Jan 30, 2023 at 10:31:23AM +0000, David Howells wrote:
> > Christoph Hellwig <hch@lst.de> wrote:
> > 
> > > +		bvec_set_page(&bv, ZERO_PAGE(0), len, 0);
> > 
> > Maybe bvec_set_zero_page()?
> 
> Why?

Seems to be something people want to do quite a lot and don't know about.
I've seen places where someone allocates a buffer and clears it just to use as
a source of zeros.  There's at least one place in cifs, for example.  I know
about it from wrangling arch code, but most people working on Linux haven't
done that.

David

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
