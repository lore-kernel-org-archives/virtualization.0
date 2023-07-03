Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70882EB64DC
	for <virtualization@archiver.kernel.org>; Mon,  3 Jul 2023 06:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2B4B41477;
	Mon,  3 Jul 2023 06:45:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D2B4B41477
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PiKIt3UU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P0Tta9IkZiMV; Mon,  3 Jul 2023 06:45:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2A598409A2;
	Mon,  3 Jul 2023 06:45:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A598409A2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0173DC0072;
	Mon,  3 Jul 2023 06:45:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFE4CC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 06:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 87658400CF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 06:45:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 87658400CF
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PiKIt3UU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fERAOrnBR0A6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 06:45:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8EA91400B9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8EA91400B9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 06:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688366699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ovluAHTmtFvydqG5OYZ6GVGeRDsdOvDwQZe/fLVcLSo=;
 b=PiKIt3UUtdh9SKfsUFd3OdUxoUgcBdbJXWDUac3NH1zd2eYkmx+0xPnoPzPgXRIfEEEOW0
 +jZxhEUvEfGSPnYiOYWY6VRPs1dX9LEuDjL6wnTm0g3ES3Cd2hab4j5f4b9ySx9On8oAAA
 jzs7DbF7ijtwAysEK+CTBh4zMfJ720E=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-SIbBgqY5NZWnTzz3pSnp5Q-1; Mon, 03 Jul 2023 02:44:58 -0400
X-MC-Unique: SIbBgqY5NZWnTzz3pSnp5Q-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b699c5f238so32979371fa.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 02 Jul 2023 23:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688366696; x=1690958696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ovluAHTmtFvydqG5OYZ6GVGeRDsdOvDwQZe/fLVcLSo=;
 b=XCQCWoZt0ScCZD//wyKwrM1llFGw7EvRnE9c3n8Yxhi73N6tDzOXav6ih87DvhR7ZM
 5vIugjbpar4Vz533fqXIG1a1wnu6P2H8D4LDRipWRZkW5W8cR+1RYD7KVpzzmUOdMD3g
 P/kfZut/gbQXZonV3FLgOsuYlZZ1ULjDnVcwK2uBA0LUX2Zy3zXYtlzMppzh6Xsx+iXJ
 6kH564LjItOd4HtRaUHxlmsg9vzjhzZuL6Y5N7Lkfj3z5Br6heK7Ck7gBy0EMLsLDSlH
 DoIW2sF54H+yqBr743mZEkjql7iPyuIaCWV7cEJ93u3yTzzBjIxzegl9MJLmDGWlWlOe
 SVCw==
X-Gm-Message-State: ABy/qLYz8lt8d6fysNdF39NGYXnjQfasXqvJYGmygxmg9RsVFCZC6Uiw
 +4anLAC3T8xH6eKqb9+RZQrG0qij3dKeELMTgsWVkIJhQNWmCFxL5KH31ZrAtzubgidXu8BWqNr
 Jfw3QBoKazJ831bycuGoS5vMOTb7BNKeMc6DRc/DSbaaqA188sD2JhPjkaQ==
X-Received: by 2002:a2e:910c:0:b0:2b6:a22f:9fb9 with SMTP id
 m12-20020a2e910c000000b002b6a22f9fb9mr6009895ljg.27.1688366696673; 
 Sun, 02 Jul 2023 23:44:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHlynqGGlx9Jhthcs4p2/VB3UnNVeBKpKxmHTXOyGfI54rO4NRmFnzaCGXKfgksJmq0cNXrTsUIyES6jnl+V9A=
X-Received: by 2002:a2e:910c:0:b0:2b6:a22f:9fb9 with SMTP id
 m12-20020a2e910c000000b002b6a22f9fb9mr6009887ljg.27.1688366696399; Sun, 02
 Jul 2023 23:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
 <20230702093530-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230702093530-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 3 Jul 2023 14:44:45 +0800
Message-ID: <CACGkMEtoW0nW8w6_Ew8qckjvpNGN_idwpU3jwsmX6JzbDknmQQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com, eperezma@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Maxime Coquelin <maxime.coquelin@redhat.com>, david.marchand@redhat.com
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

T24gU3VuLCBKdWwgMiwgMjAyMyBhdCA5OjM34oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEp1biAyNywgMjAyMyBhdCAwMTozNjo1MFBN
ICswMjAwLCBNYXhpbWUgQ29xdWVsaW4gd3JvdGU6Cj4gPiBUaGlzIHNtYWxsIHNlcmllcyBlbmFi
bGVzIHZpcnRpby1uZXQgZGV2aWNlIHR5cGUgaW4gVkRVU0UuCj4gPiBXaXRoIGl0LCBiYXNpYyBv
cGVyYXRpb24gaGF2ZSBiZWVuIHRlc3RlZCwgYm90aCB3aXRoCj4gPiB2aXJ0aW8tdmRwYSBhbmQg
dmhvc3QtdmRwYSB1c2luZyBEUERLIFZob3N0IGxpYnJhcnkgc2VyaWVzCj4gPiBhZGRpbmcgVkRV
U0Ugc3VwcG9ydCB1c2luZyBzcGxpdCByaW5ncyBsYXlvdXQgKG1lcmdlZCBpbgo+ID4gRFBESyB2
MjMuMDctcmMxKS4KPiA+Cj4gPiBDb250cm9sIHF1ZXVlIHN1cHBvcnQgKGFuZCBzbyBtdWx0aXF1
ZXVlKSBoYXMgYWxzbyBiZWVuCj4gPiB0ZXN0ZWQsIGJ1dCByZXF1aXJlcyBhIEtlcm5lbCBzZXJp
ZXMgZnJvbSBKYXNvbiBXYW5nCj4gPiByZWxheGluZyBjb250cm9sIHF1ZXVlIHBvbGxpbmcgWzFd
IHRvIGZ1bmN0aW9uIHJlbGlhYmx5Lgo+ID4KPiA+IFsxXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC9DQUNHa01FdGdyeE4zUFB3c0RvNG9Pc25zU0xKZkVtQkVaMFd2akdScjN3aFUrUWFz
VWdAbWFpbC5nbWFpbC5jb20vVC8KPgo+IEphc29uIHByb21pc2VkIHRvIHBvc3QgYSBuZXcgdmVy
c2lvbiBvZiB0aGF0IHBhdGNoLgo+IFJpZ2h0IEphc29uPwoKWWVzLgoKPiBGb3Igbm93IGxldCdz
IG1ha2Ugc3VyZSBDVlEgZmVhdHVyZSBmbGFnIGlzIG9mZj8KCldlIGNhbiBkbyB0aGF0IGFuZCBy
ZWxheCBvbiB0b3Agb2YgbXkgcGF0Y2guCgpUaGFua3MKCj4KPiA+IFJGQyAtPiB2MSBjaGFuZ2Vz
Ogo+ID4gPT09PT09PT09PT09PT09PT09Cj4gPiAtIEZhaWwgZGV2aWNlIGluaXQgaWYgaXQgZG9l
cyBub3Qgc3VwcG9ydCBWRVJTSU9OXzEgKEphc29uKQo+ID4KPiA+IE1heGltZSBDb3F1ZWxpbiAo
Mik6Cj4gPiAgIHZkdXNlOiB2YWxpZGF0ZSBibG9jayBmZWF0dXJlcyBvbmx5IHdpdGggYmxvY2sg
ZGV2aWNlcwo+ID4gICB2ZHVzZTogZW5hYmxlIFZpcnRpby1uZXQgZGV2aWNlIHR5cGUKPiA+Cj4g
PiAgZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyB8IDE1ICsrKysrKysrKysrLS0t
LQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+
ID4KPiA+IC0tCj4gPiAyLjQxLjAKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
