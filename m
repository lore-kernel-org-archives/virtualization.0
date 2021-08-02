Return-Path: <SRS0=GDYi=MZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B8BC4338F
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 19:52:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405DE61037
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 19:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 405DE61037
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A0B5606F2;
	Mon,  2 Aug 2021 19:52:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m1BYl_-pVluL; Mon,  2 Aug 2021 19:52:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7AAF760793;
	Mon,  2 Aug 2021 19:52:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54315C0010;
	Mon,  2 Aug 2021 19:52:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31508C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 19:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C94240249
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 19:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FdniD4TcQhaz
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 19:52:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B51E40022
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 19:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627933921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mmwKHxtG2S0U2pi/nqhVmXUtbgcGd+lkYJ2sZvKAeeo=;
 b=VjRYHlNHRCNxZMarkfOe0e6xDbsyhIItZwfwJ/sBTwKGnKHITgrB9cX+I0klkKgur2QP2e
 nYhnmC3AoO4kGREdDb1OaK256CIFXmCgrdtcQAkL9I78WPlKW1860l+k3GO663zz0XBTTn
 zvKLgkw/QuN69qdf4AUXC07Sb3msIVY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-6BJenU-sO_-Pa5scbc7fpw-1; Mon, 02 Aug 2021 15:51:58 -0400
X-MC-Unique: 6BJenU-sO_-Pa5scbc7fpw-1
Received: by mail-ej1-f70.google.com with SMTP id
 zp23-20020a17090684f7b02905a13980d522so1070666ejb.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Aug 2021 12:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=mmwKHxtG2S0U2pi/nqhVmXUtbgcGd+lkYJ2sZvKAeeo=;
 b=cDK/aX3ljo2NW/sYu+xL9NXpZO1DdqLrAxtkGWA3QP1PwZcwhYwpk1qXMr64i6NiIx
 TIIcas+V221XwRcp/gj5JTqmeQBryN8gKopfLcI+lfqMKiAAVjhcUEgoBmGLzb1ZAJ1d
 iQAmkl+vzQmbK/52RWCJwqMrNc4b4gSYY3b5mMHH1MP13yuCmNCsIQ89piw33Eu/QxYQ
 xC8h5epQyyLzYTDYxoqE0oa77YAt5aMTP3Fb1YWZM4e7s9aEBNGEMB3WJ69SB0PBwSnp
 4eR3E8qvDXBWAOSPB2/HbzQl/137XXelKLa0ZsRraD+t7vtejgvRB4uj/NWVLY5Ao6Dm
 vgmw==
X-Gm-Message-State: AOAM53269ajTGWyCdDRgCvErgEiXHsyZTIL1RUiI9qPvxE8ceiiu07SB
 Om7F/83X6/xquot4qE3ohkdlz46swkPyZZCDuV8j6o2JW3kiZ6IMYutEN2C2tgl05ECGJvDaYdM
 aJgyXWY76VFzcO/RvKJEOhCDyVxyKnLlsnR/p88VFpw==
X-Received: by 2002:a17:906:95ce:: with SMTP id
 n14mr16036664ejy.130.1627933917749; 
 Mon, 02 Aug 2021 12:51:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgzuVQ2X5lkTn0NRZJV291PXUEVm4IdqJhzxWcLTDMNVlgjQ1Su6NXtD04ebxXLB/2v5rl3A==
X-Received: by 2002:a17:906:95ce:: with SMTP id
 n14mr16036646ejy.130.1627933917571; 
 Mon, 02 Aug 2021 12:51:57 -0700 (PDT)
Received: from redhat.com ([2.55.140.205])
 by smtp.gmail.com with ESMTPSA id nd14sm4854446ejc.113.2021.08.02.12.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Aug 2021 12:51:57 -0700 (PDT)
Date: Mon, 2 Aug 2021 15:51:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ivan <ivan@prestigetransportation.com>
Subject: Re: PROBLEM: virtio_net LRO kernel panics
Message-ID: <20210802154901-mutt-send-email-mst@kernel.org>
References: <CACFia2eH3eCZxtt70LB5zoPbhLXRv=crPh5oOhR=6mY3auDdQA@mail.gmail.com>
 <20210723035713-mutt-send-email-mst@kernel.org>
 <CACFia2fWhWKMGF3g8SfU++2-jQ1rCKtCJo3h08KmhGfMTuZaQQ@mail.gmail.com>
 <20210723080924-mutt-send-email-mst@kernel.org>
 <CACFia2en0JJDFyz3Umk-JTnMT=kjvRogt4PudED4kiLeMjcHFg@mail.gmail.com>
 <CACFia2fx7Lt-4o_uqDznvk-VgdsMtD64qv6RYkrCjKLu2yt8bg@mail.gmail.com>
 <CACFia2eUi4KNRC7MYktzUS9Nq2WcBiesX04Tbn2pTuvuGkY4qA@mail.gmail.com>
 <CACFia2dns1rTe5OQj4H-kpurVm2CTtGfAXz0aOUS0_cs0QUrsA@mail.gmail.com>
 <20210727050944-mutt-send-email-mst@kernel.org>
 <CACFia2dLp19pzJsScSvVYREpQm0n6XCWLieWXzA94=OVYVHTbw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACFia2dLp19pzJsScSvVYREpQm0n6XCWLieWXzA94=OVYVHTbw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

T24gTW9uLCBBdWcgMDIsIDIwMjEgYXQgMDE6MzI6MDVQTSAtMDUwMCwgSXZhbiB3cm90ZToKPiBP
biBUdWUsIEp1bCAyNywgMjAyMSBhdCA0OjExIEFNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJl
ZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIE1vbiwgSnVsIDI2LCAyMDIxIGF0IDA3OjQ0OjQz
UE0gLTA1MDAsIEl2YW4gd3JvdGU6Cj4gPiA+IE9uIFNhdCwgSnVsIDI0LCAyMDIxIGF0IDExOjE4
IFBNIEl2YW4gPGl2YW5AcHJlc3RpZ2V0cmFuc3BvcnRhdGlvbi5jb20+IHdyb3RlOgo+ID4gPiA+
Cj4gPiA+ID4gT24gU2F0LCBKdWwgMjQsIDIwMjEgYXQgNzoxNyBQTSBJdmFuIDxpdmFuQHByZXN0
aWdldHJhbnNwb3J0YXRpb24uY29tPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiBPbiBGcmks
IEp1bCAyMywgMjAyMSBhdCA3OjMzIEFNIEl2YW4gPGl2YW5AcHJlc3RpZ2V0cmFuc3BvcnRhdGlv
bi5jb20+IHdyb3RlOgo+ID4gPiA+ID4+Cj4gPiA+ID4gPj4gT24gRnJpLCBKdWwgMjMsIDIwMjEg
YXQgNzoxMCBBTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+
ID4gPiA+Pj4KPiA+ID4gPiA+Pj4gT24gRnJpLCBKdWwgMjMsIDIwMjEgYXQgMDM6MDY6MDRBTSAt
MDUwMCwgSXZhbiB3cm90ZToKPiA+ID4gPiA+Pj4gPiBPbiBGcmksIEp1bCAyMywgMjAyMSBhdCAy
OjU5IEFNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+
ID4+PiA+ID4KPiA+ID4gPiA+Pj4gPiA+IE9uIFRodSwgSnVsIDIyLCAyMDIxIGF0IDExOjUwOjEx
UE0gLTA1MDAsIEl2YW4gd3JvdGU6Cj4gPiA+ID4gPj4+ID4gPiA+IE9uIFRodSwgSnVsIDIyLCAy
MDIxIGF0IDExOjI1IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+
ID4gPiA+ID4+PiA+ID4gPiA+IOWcqCAyMDIxLzcvMjMg5LiK5Y2IMTA6NTQsIEl2YW4g5YaZ6YGT
Ogo+ID4gPiA+ID4+PiA+ID4gPiA+ID4gT24gVGh1LCBKdWwgMjIsIDIwMjEgYXQgOTozNyBQTSBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+Pj4gPiA+ID4g
PiA+PiBEb2VzIGl0IHdvcmsgaWYgeW91IHR1cm4gb2ZmIGxybyBiZWZvcmUgZW5hYmxpbmcgdGhl
IGZvcndhcmRpbmc/Cj4gPiA+ID4gPj4+ID4gPiA+ID4gPiAwIHJvb3RATnVSYWlkOn4jIGV0aHRv
b2wgLUsgZXRoMCBscm8gb2ZmCj4gPiA+ID4gPj4+ID4gPiA+ID4gPiBBY3R1YWwgY2hhbmdlczoK
PiA+ID4gPiA+Pj4gPiA+ID4gPiA+IHJ4LWxybzogb24gW3JlcXVlc3RlZCBvZmZdCj4gPiA+ID4g
Pj4+ID4gPiA+ID4gPiBDb3VsZCBub3QgY2hhbmdlIGFueSBkZXZpY2UgZmVhdHVyZXMKPiA+ID4g
PiA+Pj4gPiA+ID4gPgo+ID4gPiA+ID4+PiA+ID4gPiA+IE9rLCBpdCBsb29rcyBsaWtlIHRoZSBk
ZXZpY2UgbWlzc2VzIHRoZSBWSVJUSU9fTkVUX0ZfQ1RSTF9HVUVTVF9PRkZMT0FEUwo+ID4gPiA+
ID4+PiA+ID4gPiA+IHdoaWNoIG1ha2VzIGl0IGltcG9zc2libGUgdG8gY2hhbmdlIHRoZSBMUk8g
c2V0dGluZy4KPiA+ID4gPiA+Pj4gPiA+ID4gPgo+ID4gPiA+ID4+PiA+ID4gPiA+IERpZCB5b3Ug
dXNlIHFlbXU/IElmIHllcywgd2hhdCdzIHRoZSBxZW11IHZlcnNpb24geW91J3ZlIHVzZWQ/Cj4g
PiA+ID4gPj4+ID4gPiA+Cj4gPiA+ID4gPj4+ID4gPiA+IFRoZXNlIGFyZSBWaXJ0dWFsQm94IG1h
Y2hpbmVzLCB3aGljaCBJJ3ZlIGJlZW4gdXNpbmcgZm9yIHllYXJzIHdpdGgKPiA+ID4gPiA+Pj4g
PiA+ID4gbG9uZ3Rlcm0ga2VybmVscyA0LjE5LCBhbmQgSSBuZXZlciBoYWQgc3VjaCBhIHByb2Js
ZW0uICBCdXQgbm93IHRoYXQgSQo+ID4gPiA+ID4+PiA+ID4gPiB0cmllZCB1cGdyYWRpbmcgdG8g
a2VybmVscyA1LjEwIG9yIDUuMTMgLS0gdGhlIHBhbmljcyBzdGFydGVkLiAgVGhlc2UKPiA+ID4g
PiA+Pj4gPiA+ID4gYXJlIGp1c3QgZ2VuZXJpYyBrZXJuZWwgYnVpbGRzLCBhbmQgYSBtaW5pbWFs
aXN0aWMgdXNlcnNwYWNlLgo+ID4gPiA+ID4+PiA+ID4KPiA+ID4gPiA+Pj4gPiA+IEkgd291bGQg
YmUgdXNlZnVsIHRvIHNlZSB0aGUgZmVhdHVyZXMgeW91ciB2aXJ0dWFsYm94IGluc3RhbmNlIHBy
b3ZpZGVzCj4gPiA+ID4gPj4+ID4gPgo+ID4gPiA+ID4+PiA+ID4gY2F0IC9zeXMvY2xhc3MvbmV0
L2V0aDAvZGV2aWNlL2ZlYXR1cmVzCj4gPiA+ID4gPj4+ID4KPiA+ID4gPiA+Pj4gPiAjIGNhdCAv
c3lzL2NsYXNzL25ldC9ldGgwL2RldmljZS9mZWF0dXJlcwo+ID4gPiA+ID4+PiA+IDExMDAwMTAx
MTAxMTEwMTExMTExMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAK
PiA+ID4gPiA+Pj4KPiA+ID4gPiA+Pj4gSSB3YXMgYWJsZSB0byByZXByb2R1Y2UgdGhlIHdhcm5p
bmcgYnV0IG5vdCB0aGUgcGFuaWMuCj4gPiA+ID4gPj4+IE9UT0ggaWYgTFJPIHN0YXlzIG9uIHdo
ZW4gZW5hYmxpbmcgZm9yd2FyZGluZyB0aGF0Cj4gPiA+ID4gPj4+IGlzIGFscmVhZHkgYSBwcm9i
bGVtLiBBbnkgY2hhbmNlIHlvdSBjYW4gYmlzZWN0IHRvCj4gPiA+ID4gPj4+IGZpbmQgb3V0IHdo
aWNoIGNoYW5nZSBpbnRyb2R1Y2VkIHRoZSBwYW5pYz8KPiA+ID4gPiA+Pgo+ID4gPiA+ID4+Cj4g
PiA+ID4gPj4gQW55IGtlcm5lbHMgdXAgdG8gNC4xOS4xOTggZG9uJ3QgcGFuaWMuCj4gPiA+ID4g
Pj4gQW55IGtlcm5lbHMgNS4xMCsgcGFuaWMgaW1tZWRpYXRlbHkgdXBvbiBzdGFydGluZyBmb3J3
YXJkaW5nLgo+ID4gPiA+ID4+IEkgaGF2ZSBub3QgdGVzdGVkIGFueSBrZXJuZWxzIGJldHdlZW4g
NC4xOSBhbmQgNS4xMC4KPiA+ID4gPiA+PiBJIGd1ZXNzIEkgY2FuIGJ1aWxkIGEgZmV3IGtlcm5l
bHMgaW5iZXR3ZWVuLCBhbmQgdHJ5IHBpbnBvaW50IHdoZXJlIGl0IHN0YXJ0cy4KPiA+ID4gPiA+
PiBUaGF0IG1heSB0YWtlIGEgZGF5IG9yIHNvLiAgSSdsbCBnZXQgb24gd2l0aCBpdCBub3csIGFu
ZCByZXBvcnQgbXkgZmluZGluZ3MuCj4gPiA+ID4gPgo+ID4gPiA+ID4gU28sIEkgbmFycm93ZWQg
IGl0IGRvd246IHRoZSBwYW5pY3Mgc3RhcnQgd2l0aCBrZXJuZWwgNS4wLXJjLgo+ID4gPiA+Cj4g
PiA+ID4gTW9yZSBuYXJvd2x5LCB0aGUgcHJvYmxlbSBzZWVtcyBiZSBjb21pbmcgZnJvbSBjb21t
aXQKPiA+ID4gPiBhMDJlODk2NGVhZjkyNzFhOGE1ZmNjMGM1NWJkMTNmOTMzYmFmYzU2Lgo+ID4g
PiA+IEp1c3QgdG8gdGVzdCBteSBzdXNwaWNpb24sIEkgZGVsZXRlZCBhIGZldyBsaW5lcyBmcm9t
IHRoYXQgY29kZSwKPiA+ID4gPiBhbmQgdGhlIHBhbmljIHdlbnQgYXdheS4gIEhvcGUgdGhhdCBo
ZWxwcyB5b3UgZ3V5cyBmaWd1cmUgb3V0Cj4gPiA+ID4gd2hhdCB0aGUgcHJvYmxlbSBtaWdodCBi
ZS4KPiA+Cj4gPiBXZWxsIGl0IGRpc2FibGVzIExSTyBidXQgd2Uga25ldyB0aGlzIDooIEknZCBo
ZWxwIGlmIHdlIGtuZXcKPiA+IHdoZXJlIGRvZXMgaXQgcGFuaWMsIGFsbCB3ZSBzZWUgaXQgdGhl
IHdhcm5pbmcgd2hpY2ggaXMKPiA+IHJlbGF0ZWQgZm9yIHN1cmUgYnV0IG5vdCB0aGUgaW1tZWRp
YXRlIHJvb3RjYXVzZSAuLi4KPiA+Cj4gPiA+ID4KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4g
PiBAQCAtMjk3OCwxMSArMjk3OCw2IEBACj4gPiA+ID4gICB9Cj4gPiA+ID4gICBpZiAodmlydGlv
X2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9DU1VNKSkKPiA+ID4gPiAgICAg
IGRldi0+ZmVhdHVyZXMgfD0gTkVUSUZfRl9SWENTVU07Cj4gPiA+ID4gLSBpZiAodmlydGlvX2hh
c19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9UU080KSB8fAo+ID4gPiA+IC0gICAg
dmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9UU082KSkKPiA+ID4g
PiAtICAgIGRldi0+ZmVhdHVyZXMgfD0gTkVUSUZfRl9MUk87Cj4gPiA+ID4gLSBpZiAodmlydGlv
X2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9DVFJMX0dVRVNUX09GRkxPQURTKSkKPiA+
ID4gPiAtICAgIGRldi0+aHdfZmVhdHVyZXMgfD0gTkVUSUZfRl9MUk87Cj4gPiA+ID4KPiA+ID4g
PiAgIGRldi0+dmxhbl9mZWF0dXJlcyA9IGRldi0+ZmVhdHVyZXM7Cj4gPiA+Cj4gPiA+IEp1c3Qg
RllJLCBHb29nbGUgdHVybmVkIHVwIHR3byBzaW1pbGFyIGJ1ZyByZXBvc3RzLi4uCj4gPiA+IEFw
ciAxNCwgMjAyMCAtLSBodHRwczovL2dpdGh1Yi5jb20vY29udGFpbmVycy9wb2RtYW4vaXNzdWVz
LzU4MTUKPiA+ID4gT2N0IDA5LiAyMDIwIC0tIGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9z
aG93X2J1Zy5jZ2k/aWQ9MjA5NTkzCj4gPiA+Cj4gPiA+IElzIHRoZXJlIGFueSBzZW5zaWJsZSB0
aGluZyBJIGNvdWxkIGRvLCB0ZW1wb3JhcmlseSwgdW50aWwgdGhpcwo+ID4gPiBwcm9ibGVtIGlz
IHNvcnRlZCBvdXQ/Cj4gPiA+IE9yIGFtIEkgc2ltcGx5IHN0dWNrIHRvIGtlcm5lbHMgNC4xOSBv
biB0aGVzZSBtYWNoaW5lcyBmb3Igbm93Pwo+ID4KPiA+Cj4gPiBTb21ldGhpbmcgbGlrZSB0aGlz
IEkgZ3Vlc3M6Cj4gPgo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IGluZGV4IDhhNThhMmYwMTNhZi4uY2M1
OTgyMTkzYTQwIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiAr
KysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IEBAIC0zMDYzLDYgKzMwNjMsOCBAQCBz
dGF0aWMgaW50IHZpcnRuZXRfdmFsaWRhdGUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICBfX3ZpcnRpb19jbGVhcl9iaXQodmRldiwgVklSVElP
X05FVF9GX01UVSk7Cj4gPiAgICAgICAgIH0KPiA+Cj4gPiArICAgICAgIF9fdmlydGlvX2NsZWFy
X2JpdCh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNCk7Cj4gPiArICAgICAgIF9fdmlydGlv
X2NsZWFyX2JpdCh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNik7Cj4gPiAgICAgICAgIHJl
dHVybiAwOwo+ID4gIH0KPiAKPiBXaGVuIEkgYXBwbHkgeW91ciBwYXRjaCwgdGhlbiBJIHNlZSBk
cmFzdGljIChtb3JlIHRoYW4gaGFsZikKPiByZWR1Y3Rpb25zIGluIHNwZWVkLiAoY29uZmlybWVk
IHdpdGggaXBlcmYpLgo+IAo+IEJ1dCBpZiBpbnN0ZWFkIEkganVzdCByZW1vdmUgYSBmZXcgbGlu
ZXMgZnJvbSBjb21taXQKPiBhMDJlODk2NGVhZjkyNzFhOGE1ZmNjMGM1NWJkMTNmOTMzYmFmYzU2
Cj4gYXMgaW4gbXkgZWFybGllciBwb3N0LCB0aGVuIEknbSBiYWNrIHRvIGZ1bGwgc3BlZWQKPiAK
PiBJIHVuZGVyc3RhbmQgdGhhdCB0aGlzIGlzIGp1c3QgdGVtcG9yYXJ5IHdvcmthcm91bmQsIHVu
dGlsIHdlIGZpZ3VyZSB0aGlzIG91dC4KCgpPaCB3ZWlyZC4gU28gaXQncyBub3QgYWJvdXQgZ2V0
dGluZyBzb21lIHdlaXJkIExSTyBwYWNrZXQuIFdlIHdpbGwgZ2V0IGl0IHdpdGgKVklSVElPX05F
VF9GX0dVRVNUX1RTTzQgYW55d2F5LiBJdCdzIGFib3V0IHRoZSBMUk8gZmxhZyBiZWluZyBzZXQg
aW4KZmVhdHVyZXMuCgpIb3cgYWJvdXQgdGhpcyB0aGVuPyBKdXN0IHByZXRlbmQgdG8gTGludXgg
dGhhdCB3ZSBkaXNhYmxlZCBMUk8uCgoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwppbmRleCA4YTU4YTJmMDEzYWYuLjhlN2U0
Y2VhMTc2YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCisrKyBiL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwpAQCAtMjY1MSw4ICsyNjUxLDkgQEAgc3RhdGljIGludCB2aXJ0
bmV0X3NldF9mZWF0dXJlcyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAogCQkJCSAgIH5HVUVTVF9P
RkZMT0FEX0xST19NQVNLOwogCiAJCWVyciA9IHZpcnRuZXRfc2V0X2d1ZXN0X29mZmxvYWRzKHZp
LCBvZmZsb2Fkcyk7Ci0JCWlmIChlcnIpCi0JCQlyZXR1cm4gZXJyOworCQlXQVJOX09OKGVycik7
CisJCS8vaWYgKGVycikKKwkJLy8JcmV0dXJuIGVycjsKIAkJdmktPmd1ZXN0X29mZmxvYWRzID0g
b2ZmbG9hZHM7CiAJfQogCiAKCi0tIApNU1QKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
