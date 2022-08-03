Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470AEC19F2C
	for <virtualization@archiver.kernel.org>; Wed,  3 Aug 2022 12:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AC41841BF3;
	Wed,  3 Aug 2022 12:29:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC41841BF3
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=A427Az3Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ICPzmtmNbRje; Wed,  3 Aug 2022 12:29:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 356ED40A9C;
	Wed,  3 Aug 2022 12:29:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 356ED40A9C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC130C0032;
	Wed,  3 Aug 2022 12:29:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80DEFC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 12:29:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4D8F441496
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 12:29:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D8F441496
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=A427Az3Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ehm6MyuYV-UW
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 12:29:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1237741295
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1237741295
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 12:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=E180s6CR6wzNu92DGCX8oKdkGcM5/g3jotE81kgtv04=; b=A427Az3ZNMojBwwhPcJmf8bFeI
 52bnlX2e9804xOgiCz9irxqrkbbhGpCFRArB8qtpHind/CwjihKTRnRhXK3zWrgwIX1FsmisnC+pg
 J0k1XfIKPnG3/2um9pu5cql/JkYKb8ExWKl7OX5XKBKamB8dKrEQyc8JpaDqm9Eg4siW3Y85vi7eX
 905yGJZe+G4X/W09pLY++ktq+jAyEIqkhERyTZDrnd4lSbzm8Th3K3MZUrzIRsA+IF7NjHJn/ytcm
 Holz80tRpytx5Dy1VqU1epHPSOPFGFGNz+rUFHCSEp6IaqBPAkew1Nay9qMXQc2d+Z74PNclqomVh
 55GTQBjg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1oJDUl-009GF6-1m; Wed, 03 Aug 2022 12:29:03 +0000
Date: Wed, 3 Aug 2022 13:29:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ricardo =?iso-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>
Subject: Re: [PATCH] docs: driver-api: virtio: virtio on Linux
Message-ID: <YupqD5I4uTnk/MY8@casper.infradead.org>
References: <20220802124222.3563378-1-ricardo.canuelo@collabora.com>
 <YulJQKL22sB31lfU@casper.infradead.org>
 <87y1w5rdq6.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87y1w5rdq6.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com,
 kernel@collabora.com, linux-doc@vger.kernel.org
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Aug 03, 2022 at 09:24:49AM +0200, Ricardo Ca=F1uelo wrote:
> Hi Matthew,
> =

> On mar, ago 02 2022 at 16:56:48, Matthew Wilcox <willy@infradead.org> wro=
te:
> > You don't need to use :c:func:`foo`.  You can just write foo() and the
> > tooling will convert it into :c:func:`foo` for you.
> =

> Thanks for the tip. However, I did some tests and the results aren't
> quite the same. For functions with kerneldocs that are referenced in the
> same document (.. kernel-doc::) the tool does efectively link to the
> generated documentation, but for all the other functions using
> c:func:`foo` generates a different formatting than `foo`, which does no
> formatting at all.

I didn't say `foo`, I said foo().  This is handled by
Documentation/sphinx/automarkup.py.  To quote the doc-guide:

Please note that there is no need to use ``c:func:`` to generate cross
references to function documentation.  Due to some Sphinx extension magic,
the documentation build system will automatically turn a reference to
``function()`` into a cross reference if an index entry for the given
function name exists.  If you see ``c:func:`` use in a kernel document,
please feel free to remove it.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
