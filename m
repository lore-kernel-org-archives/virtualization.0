Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE57EC10F1B
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 07:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9580460BCA;
	Tue, 27 Dec 2022 07:57:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9580460BCA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=mDjhdOb+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OznXcTHZTIbO; Tue, 27 Dec 2022 07:57:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1A0F660B9F;
	Tue, 27 Dec 2022 07:57:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A0F660B9F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE90EC0035;
	Tue, 27 Dec 2022 07:57:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE448C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:57:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9618381385
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:57:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9618381385
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=mDjhdOb+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g8CHEYwiwszQ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:57:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C8C7A81340
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C8C7A81340
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:57:24 +0000 (UTC)
Received: by mail-ua1-x930.google.com with SMTP id z3so2781477uao.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7v/WSJyZmtBjH1RduwJIBnIVDn9u078UD/StpnslVx0=;
 b=mDjhdOb+37hZkSU5zz/DbB2FXU0Pc/729sq2tkWFJiYAVkgTfJKuUpOSXeo0P8EzEI
 bhvix75DeyyFatTBY3VZFtz+3N0uYxzvYQyIRe3J2bhYKTyltbqH3tHftOLiqj30uybe
 u4Ctr0Gk9w3V2DMnaAWShGbvxy33VSLGYTfcJXxyi0g6ADHstijwy8Mb6Ux2lh5SlkIF
 ylW1Upb/0Njy0ENduTaULY90gM/vB/jM/88JULcTRxcNXIchHnvyUw6EzkLggnuEyXNi
 nNZ9AVJDThH5Gy1xpZyGD5iPmx+Ez0gJ4ZgmpLUj6TOx1lWdtd2mxwaRoFaJNuny/6aF
 3XNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7v/WSJyZmtBjH1RduwJIBnIVDn9u078UD/StpnslVx0=;
 b=GFOP/gUKcYdMN4sRO+HQfmXGe/PZMZeGI0UBACbaF8ftRpzWpGJz/1SfHKw3DbbMnB
 nVlOfDNw3UTqKeM7qBRjNTvV8OvIPyNd0gpPm2jIdOE8PxMzDDb+nQ9rLwKerjf41vvp
 REW2AfVhImrDkblYf+f+AFIgZv/i85SDuOEB2IFbQMUmCDehmypAfL79w4faCPkGtkGC
 75o+WhU/RPGlkNyl58WnzBLDgW8XPk06eXAGYeT/dBjM/WgiSqhUX08It707pGnKUN+0
 FBZmOXyhcqPreUin1QnVukqEVlrU+Wg+xe4EvnIsNMCb+omfT/2F5EIg1cXdCq3D3NQl
 WxzA==
X-Gm-Message-State: AFqh2ko294P2GQMKVG5vudwnJ/ug40J5bAbhUWvY8oGEdpAncfMcsDRN
 Ft5CxEafbF0khZCFa4UK9wYqi9GFJxBByLf65Xjz8w==
X-Google-Smtp-Source: AMrXdXsR/ThovcjSI43AaK4Fos8vXu6n0K3qiqUEOlotWF5yGcagJgxiHP0FtJUsV9OnUNvEQSj+hEYwL6OSgTbFwqU=
X-Received: by 2002:ab0:2398:0:b0:3fe:c0cb:aa43 with SMTP id
 b24-20020ab02398000000b003fec0cbaa43mr1886262uan.72.1672127843661; Mon, 26
 Dec 2022 23:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20221227022528.609839-1-mie@igel.co.jp>
 <20221227022528.609839-3-mie@igel.co.jp>
 <CACGkMEtAaYpuZtS0gx_m931nFzcvqSNK9BhvUZH_tZXTzjgQCg@mail.gmail.com>
 <20221227020425-mutt-send-email-mst@kernel.org>
 <CANXvt5pXkS=TTOU0+Lkx6CjcV7xvDHRS6FbFikJ4Ww8832sg8g@mail.gmail.com>
 <20221227025534-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221227025534-mutt-send-email-mst@kernel.org>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Tue, 27 Dec 2022 16:57:12 +0900
Message-ID: <CANXvt5qh885mi7shJ9jiZbCBeSVR7=bDhx29GnpL1ZHymb_Rxw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] vringh: remove vringh_iov and unite to vringh_kiov
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

MjAyMuW5tDEy5pyIMjfml6Uo54GrKSAxNjo1NiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRo
YXQuY29tPjoKPgo+IE9uIFR1ZSwgRGVjIDI3LCAyMDIyIGF0IDA0OjEzOjQ5UE0gKzA5MDAsIFNo
dW5zdWtlIE1pZSB3cm90ZToKPiA+IDIwMjLlubQxMuaciDI35pelKOeBqykgMTY6MDUgTWljaGFl
bCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT46Cj4gPiA+Cj4gPiA+IE9uIFR1ZSwgRGVjIDI3
LCAyMDIyIGF0IDAyOjA0OjAzUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gT24g
VHVlLCBEZWMgMjcsIDIwMjIgYXQgMTA6MjUgQU0gU2h1bnN1a2UgTWllIDxtaWVAaWdlbC5jby5q
cD4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gc3RydWN0IHZyaW5naF9pb3YgaXMgZGVmaW5l
ZCB0byBob2xkIHVzZXJsYW5kIGFkZHJlc3Nlcy4gSG93ZXZlciwgdG8gdXNlCj4gPiA+ID4gPiBj
b21tb24gZnVuY3Rpb24sIF9fdnJpbmdfaW92LCBmaW5hbGx5IHRoZSB2cmluZ2hfaW92IGNvbnZl
cnRzIHRvIHRoZQo+ID4gPiA+ID4gdnJpbmdoX2tpb3Ygd2l0aCBzaW1wbGUgY2FzdC4gSXQgaW5j
bHVkZXMgY29tcGlsZSB0aW1lIGNoZWNrIGNvZGUgdG8gbWFrZQo+ID4gPiA+ID4gc3VyZSBpdCBj
YW4gYmUgY2FzdCBjb3JyZWN0bHkuCj4gPiA+ID4gPgo+ID4gPiA+ID4gVG8gc2ltcGxpZnkgdGhl
IGNvZGUsIHRoaXMgcGF0Y2ggcmVtb3ZlcyB0aGUgc3RydWN0IHZyaW5naF9pb3YgYW5kIHVuaWZp
ZXMKPiA+ID4gPiA+IEFQSXMgdG8gc3RydWN0IHZyaW5naF9raW92Lgo+ID4gPiA+ID4KPiA+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IFNodW5zdWtlIE1pZSA8bWllQGlnZWwuY28uanA+Cj4gPiA+ID4K
PiA+ID4gPiBXaGlsZSBhdCB0aGlzLCBJIHdvbmRlciBpZiB3ZSBuZWVkIHRvIGdvIGZ1cnRoZXIs
IHRoYXQgaXMsIHN3aXRjaCB0bwo+ID4gPiA+IHVzaW5nIGFuIGlvdiBpdGVyYXRvciBpbnN0ZWFk
IG9mIGEgdnJpbmdoIGN1c3RvbWl6ZWQgb25lLgo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtzCj4gPiA+
Cj4gPiA+IFBvc3NpYmx5LCBidXQgd2hlbiBkb2luZyBjaGFuZ2VzIGxpa2UgdGhpcyBvbmUgbmVl
ZHMgdG8gYmUgY2FyZWZ1bAo+ID4gPiB0byBhdm9pZCBicmVha2luZyBhbGwgdGhlIGlubGluaW5n
IHRyaWNrcyB2cmluZ2ggcmVsaWVzIG9uIGZvcgo+ID4gPiBwZXJmb3JtYW5jZS4KPiA+IERlZmlu
aXRlbHksIEknbSBldmFsdWF0aW5nIHRoZSBwZXJmb3JtYW5jZSB1c2luZyB2cmluZ2hfdGVzdC4g
SSdsbCBhZGQgYQo+ID4gcmVzdWx0IG9mIHRoZSBldmFsdWF0aW9uLiBCdXQsIElmIHRoZXJlIGFy
ZSBvdGhlciBldmFsdWF0aW9uIG1ldGhvZHMsIGNvdWxkIHlvdQo+ID4gcGxlYXNlIHRlbGwgbWU/
Cj4KPiBoaWdoIGxldmVsIHRlc3RzIG92ZXIgdmlydGlvIGJsayBhbmQgbmV0IGFyZSBwb3NzaWJs
ZSwgYnV0IGxldCdzCj4gc3RhcnQgd2l0aCB2cmluZ2hfdGVzdC4KT2ssIEknbGwgZG8gaXQuCj4g
PiA+IC0tCj4gPiA+IE1TVAo+ID4gPgo+ID4KPiA+IEJlc3QsCj4gPiBTaHVuc3VrZQo+Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
