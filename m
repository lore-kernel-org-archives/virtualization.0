Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81167C54EAA
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 12:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0701040176;
	Mon, 30 Jan 2023 12:18:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0701040176
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rHWIykN8Ug3R; Mon, 30 Jan 2023 12:18:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A093B40151;
	Mon, 30 Jan 2023 12:18:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A093B40151
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75067C0033;
	Mon, 30 Jan 2023 12:18:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B03C3C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 12:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E50241797
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 12:18:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E50241797
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G4xXxosdG6p2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 12:18:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B1B5241796
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B1B5241796
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 12:18:26 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2E41068B05; Mon, 30 Jan 2023 13:18:21 +0100 (CET)
Date: Mon, 30 Jan 2023 13:18:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 20/23] rxrpc: use bvec_set_page to initialize a bvec
Message-ID: <20230130121820.GA18981@lst.de>
References: <20230130103343.GA11663@lst.de>
 <20230130092157.1759539-21-hch@lst.de> <20230130092157.1759539-1-hch@lst.de>
 <3347459.1675074683@warthog.procyon.org.uk>
 <3351918.1675077855@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3351918.1675077855@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-afs@lists.infradead.org, kvm@vger.kernel.org, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, samba-technical@lists.samba.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, target-devel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 ceph-devel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 devel@lists.orangefs.org
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

On Mon, Jan 30, 2023 at 11:24:15AM +0000, David Howells wrote:
> Seems to be something people want to do quite a lot and don't know about.

Hmm.  Right now there is one case where it would be used, and there's
about three that are and should be using bio_add_page.

> I've seen places where someone allocates a buffer and clears it just to use as
> a source of zeros.  There's at least one place in cifs, for example.  I know
> about it from wrangling arch code, but most people working on Linux haven't
> done that.

But we don't really need a helper for every possible page use for that.
People just need to learn about ZERO_PAGE.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
