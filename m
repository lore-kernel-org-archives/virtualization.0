Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BD7C19F2C
	for <virtualization@archiver.kernel.org>; Wed,  3 Aug 2022 08:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57A06401F0;
	Wed,  3 Aug 2022 08:01:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 57A06401F0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=BmF1aN/3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mOjcJ28QcAMX; Wed,  3 Aug 2022 08:01:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B5FFB400A4;
	Wed,  3 Aug 2022 08:01:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B5FFB400A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B9E0C0032;
	Wed,  3 Aug 2022 08:01:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A816C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 08:01:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6446D40A30
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 08:01:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6446D40A30
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=BmF1aN/3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VGVvy2frN30o
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 08:01:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 365FE40101
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 365FE40101
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 08:01:02 +0000 (UTC)
Received: from localhost (unknown [213.194.152.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 5AADB6601AC9;
 Wed,  3 Aug 2022 09:01:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1659513660;
 bh=D3WfteFQraQ9dA2WneDzidiQ8srag39d4teEo4npJL4=;
 h=From:To:Cc:Subject:References:In-reply-to:Date:From;
 b=BmF1aN/3nnzXpqgWVLgVnNKa0S05JoVstEXzwX/K8Of2W6893kNhO54C4BCqhGWke
 HVr/Ka5TRqbHFoNZtai1FB5eeVHf2Zp36sGEBIryGh8ZV5FboE7SKscV7vbUMw0N6c
 86eAkIQ3YDU9Gl0BwOcSy3USQBBqw7QchF8cLp5w/UmYMp8AsZbVtzeaVzwyZJOSsc
 JmV2vQT4D93MY5OTABkcAlxryPnDJhnfdxJTkoRbn/X38HylHExbSui1xKH1yPiM2t
 d/dyleGHqO2F1Pn70BQXOs1D0TuwXT3jEeu4jFyBpJZF+Z9EovDqg3Bq865baZbA1f
 Ya8bv1z6+Jr3w==
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] docs: driver-api: virtio: virtio on Linux
References: <20220802124222.3563378-1-ricardo.canuelo@collabora.com>
 <20220802090507-mutt-send-email-mst@kernel.org>
In-reply-to: <20220802090507-mutt-send-email-mst@kernel.org>
Date: Wed, 03 Aug 2022 10:00:56 +0200
Message-ID: <87r11xrc1z.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Cc: virtualization@lists.linux-foundation.org, kernel@collabora.com,
 linux-doc@vger.kernel.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGkgTWljaGFlbCwgdGhhbmtzIGZvciByZXZpZXdpbmcgdGhlIHBhdGNoLiBDb21tZW50cyBiZWxv
dzoKCk9uIG1pw6ksIGFnbyAwMyAyMDIyIGF0IDAyOjU0OjI4LCAiTWljaGFlbCBTLiBUc2lya2lu
IiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+IFNvIEknbSBva2F5IHdpdGggYSBoaWdoIGxldmVs
IG92ZXJ2aWV3IHVwIHRvIHRoaXMgcG9pbnQuCj4gQmVsb3cgc3RhcnRzIGdldHRpbmcgaW50byBk
ZXRhaWxzIGFuZCB0aGV5IGFyZSBub3QgdXAgdG8gZGF0ZQo+IGFuZCBJIGRvbid0IHRoaW5rIHdl
IHdhbnQgdG8gbWFpbnRhaW4gYSBjb3B5IGhlcmUuCgpJIGFncmVlIEkgbWlnaHQgaGF2ZSBnb25l
IHRvbyBtdWNoIGludG8gY29kZSBkZXRhaWxzLCBidXQgSSBhc3N1bWVkCnRob3NlIHdlcmUgcHJl
dHR5IG11Y2ggdGhlIGVsZW1lbnRhcnkgYW5kICJmaXhlZCIgcGFydHMgb2YgdGhlCnN1YnN5c3Rl
bSwgd2l0aCBhIHNsb3cgcmF0ZSBvZiBjaGFuZ2VzIGluIHRoZSBmdW5kYW1lbnRhbCBzdHVmZi4K
CklmIHRoZSBjb2RlIGlzIHByb25lIHRvIGZ1dHVyZSBjaGFuZ2VzIG9yIGlzIG91dGRhdGVkIGl0
J3MgdHJ1ZSB3ZSBkb24ndAp3YW50IGl0IG1lbnRpb25lZCBoZXJlIGJ1dCBsZWF2aW5nIHRoaXMg
ZG9jIGFzIGEgc2hvcnQgaW50cm8gdG8gdmlydGlvCndvbid0IGFkZCBtdWNoIHRvIHdoYXQncyBh
bHJlYWR5IGF2YWlsYWJsZSBpbiBvdGhlciByZXNvdXJjZXMuCgpUaGUgaW50ZW50aW9uIHdhcyBt
b3N0bHkgdG8gaWxsdXN0cmF0ZSB0aGUgYmFzaWMgdmlydGlvIGNvbmNlcHRzIHdpdGgKdGhlIGNv
bmNyZXRlIGltcGxlbWVudGF0aW9uIGluIHRoZSBrZXJuZWwuIEknbGwgc2VlIGlmIEkgY2FuIGZp
bmQgYSB3YXkKdG8gZG8gdGhhdCB3aXRob3V0IHJlbHlpbmcgc28gbXVjaCBvbiBzcGVjaWZpYyBj
b2RlIGZyYWdtZW50cy4KCgo+IHRoZSBwYXJ0IGFib3ZlIGlzIGR1cGxpY2F0aW5nIHRvbyBtdWNo
IGZyb20gdGhlIHNwZWMgSSB0aGluay4KCkFjay4KCj4gVGhlIHJlZmVyZW5jZSB0byBCQVJzIHNl
ZW1zIGJvZ3VzLgoKR290IGl0LgoKPiB3aHkgZ2l0bGFiPyB3aHkgbm90IGh0dHBzOi8vZ2l0LnFl
bXUub3JnLyB0aGVuPwoKQWNjb3JkaW5nIHRvIHRoZSBRRU1VIHdlYnNpdGUgdGhlIG9mZmljaWFs
IHJlcG8gbGl2ZXMgaW4gZ2l0bGFiLgoKPiAxLjIgaXMgb3V0LgoKVGhhbmtzLCBJIGRpZG4ndCBz
ZWUgaXQgd2hlbiBzZWFyY2hpbmcgZm9yIHRoZSBzcGVjLgoKQ2hlZXJzLApSaWNhcmRvCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
