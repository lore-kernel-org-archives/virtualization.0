Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCE6C636CC
	for <virtualization@archiver.kernel.org>; Tue,  7 Feb 2023 10:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AC7460E48;
	Tue,  7 Feb 2023 10:17:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8AC7460E48
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=pssdcCwv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LIP5vcyCPTT5; Tue,  7 Feb 2023 10:17:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4B77160BE3;
	Tue,  7 Feb 2023 10:17:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B77160BE3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDB28C0032;
	Tue,  7 Feb 2023 10:17:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE73DC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 10:17:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CA3A3405E2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 10:17:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA3A3405E2
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=pssdcCwv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yzOJHPDYez_W
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 10:17:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0E204056D
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com
 [IPv6:2607:f8b0:4864:20::a2e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D0E204056D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 10:17:26 +0000 (UTC)
Received: by mail-vk1-xa2e.google.com with SMTP id g25so38659vkk.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Feb 2023 02:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPrtilAJKVUhxbrBamxio2CjQmx+CrJRcxuPGVzs45k=;
 b=pssdcCwvP27quF2aTGuKZzmApPpisR2l632+QyiiP68had1rAPT5eRROk7FWjFJeMc
 uwMDwWP4rUj9cZ5XQGiLH0gYdVNev8DBDLvN4qdw6blaN2MJoI7V/e2A+Xho2jMqxPdf
 akpeQAPksniPJOz59KARWsf0U92ZvolJ44lrRt1/taSFAnlqNgyiAQhk7J2d2/a4fwTj
 B4teXgtKIZjLSGwjeEuHWJZTzgxjiZfGi1v1elusTIGFRZnRXGLplEkIYR7J5ALqll8d
 zXe5kS88lmBHMR3AK58Q3l1IRHFghxIHavMnNoP8+T/yyVzLbvAq3uLqISme4aFMwfas
 KwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bPrtilAJKVUhxbrBamxio2CjQmx+CrJRcxuPGVzs45k=;
 b=G4ss7GOKnRzWYWoGovZ/L3Q1/M4R1qevCgKa02ux85dMHW3AZDszFfVltO+deDmWG1
 vHMguhpes66EWxPIsn8wbckEFJ8ZbWnqZN0IlaGJq9iMIhtbjSyBlzrzD4WtZI8nXo7v
 n4MckGimfvgcWGrd7F1DsuhSj2WA2sKxHEqKeZHKcquEePROVs3F9iVWlAqpk9r3YCsC
 k2dOOTBdOOY/Tk5HppM530+Lgj6/XZmgOgb9zIqX2mb/eW8ew34Ukt4SvepESTHjpukh
 5ZRTOlPzH3WLIryVqZWydoxxg8fN9zLhUxB4qXmEnIkKoCVuBpRDuNup0K29I3l0HHCn
 cEMw==
X-Gm-Message-State: AO0yUKXuDVQwZPFGUNRQVg4uvA8RfZ3mYOb2v/a/zoAlzi3RAeAlKQyb
 mRM+lHhnkW2t/Z8ISwcMkJ4qnsamNNXZG0bT+SljTA==
X-Google-Smtp-Source: AK7set+9OKX9NitD6L8UNyZEvBjr/8igyirMEC8nb/njn0S4M5nhl04teC5aADC0Ic8fO43SlijMven9RIQ74gvPu1A=
X-Received: by 2002:a05:6122:5ab:b0:3ea:135:e0bd with SMTP id
 w11-20020a05612205ab00b003ea0135e0bdmr350219vko.21.1675765045579; Tue, 07 Feb
 2023 02:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20230203100418.2981144-1-mie@igel.co.jp>
 <20230205050122-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230205050122-mutt-send-email-mst@kernel.org>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Tue, 7 Feb 2023 19:17:14 +0900
Message-ID: <CANXvt5q_qgLuAfF7dxxrqUirT_Ld4B=POCq8JcB9uPRvCGDiKg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP function
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Takanari Hayama <taki@igel.co.jp>, Manivannan Sadhasivam <mani@kernel.org>,
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Ren Zhijie <renzhijie2@huawei.com>,
 Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>
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

MjAyM+W5tDLmnIg15pelKOaXpSkgMTk6MDIgTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0
LmNvbT46Cj4KPiBPbiBGcmksIEZlYiAwMywgMjAyMyBhdCAwNzowNDoxNFBNICswOTAwLCBTaHVu
c3VrZSBNaWUgd3JvdGU6Cj4gPiBUaGlzIHBhdGNoc2V0IGludHJvZHVjZSBhIHZpcnRpby1uZXQg
RVAgZGV2aWNlIGZ1bmN0aW9uLiBJdCBwcm92aWRlcyBhCj4gPiBuZXcgb3B0aW9uIHRvIGNvbW11
bmlhdGUgYmV0d2VlbiBQQ0llIGhvc3QgYW5kIGVuZHBvaW50IG92ZXIgSVAuCj4gPiBBZHZhbnRh
Z2Ugb2YgdGhpcyBvcHRpb24gaXMgdGhhdCB0aGUgZHJpdmVyIGZ1bGx5IHVzZXMgYSBQQ0llIGVt
YmVkZGVkIERNQS4KPiA+IEl0IGlzIHVzZWQgdG8gdHJhbnNwb3J0IGRhdGEgYmV0d2VlbiB2aXJ0
aW8gcmluZyBkaXJlY3RseSBlYWNoIG90aGVyLiBJdAo+ID4gY2FuIGJlIGV4cGVjdGVkIHRvIGJl
dHRlciB0aHJvdWdocHV0Lgo+ID4KPiA+IFRvIHJlYWxpemUgdGhlIGZ1bmN0aW9uLCB0aGlzIHBh
dGNoc2V0IGhhcyBmZXcgY2hhbmdlcyBhbmQgaW50cm9kdWNlcyBhCj4gPiBuZXcgQVBJcyB0byBQ
Q0kgRVAgZnJhbWV3b3JrIHJlbGF0ZWQgdG8gdmlydGlvLiBGdXJ0aGVybW9yZSwgaXQgZGV2aWNl
Cj4gPiBkZXBlbmRzIG9uIHRoZSBzb21lIHBhdGNodGVzIHRoYXQgaXMgZGlzY3Vzc2luZy4gVGhv
c2UgZGVwZW5kZWQgcGF0Y2hzZXQKPiA+IGFyZSBmb2xsb3dpbmc6Cj4gPiAtIFtQQVRDSCAxLzJd
IGRtYWVuZ2luZTogZHctZWRtYTogRml4IHRvIGNoYW5nZSBmb3IgY29udGludW91cyB0cmFuc2Zl
cgo+ID4gbGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZG1hZW5naW5lLzIwMjIxMjIzMDIy
NjA4LjU1MDY5Ny0xLW1pZUBpZ2VsLmNvLmpwLwo+ID4gLSBbUkZDIFBBVENIIDAvM10gRGVhbCB3
aXRoIGFsaWdubWVudCByZXN0cmljdGlvbiBvbiBFUCBzaWRlCj4gPiBsaW5rOiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1wY2kvMjAyMzAxMTMwOTAzNTAuMTEwMzQ5NC0xLW1pZUBpZ2Vs
LmNvLmpwLwo+ID4gLSBbUkZDIFBBVENIIHYyIDAvN10gSW50cm9kdWNlIGEgdnJpbmdoIGFjY2Vz
c29yIGZvciBJTyBtZW1vcnkKPiA+IGxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1
YWxpemF0aW9uLzIwMjMwMjAyMDkwOTM0LjU0OTU1Ni0xLW1pZUBpZ2VsLmNvLmpwLwo+ID4KPiA+
IEFib3V0IHRoaXMgcGF0Y2hzZXQgaGFzIDQgcGF0Y2hlcy4gVGhlIGZpcnN0IG9mIHR3byBwYXRj
aCBpcyBsaXR0bGUgY2hhbmdlcwo+ID4gdG8gdmlydGlvLiBUaGUgdGhpcmQgcGF0Y2ggYWRkIEFQ
SXMgdG8gZWFzaWx5IGFjY2VzcyB2aXJ0aW8gZGF0YSBzdHJ1Y3R1cmUKPiA+IG9uIFBDSWUgSG9z
dCBzaWRlIG1lbW9yeS4gVGhlIGxhc3Qgb25lIGludHJvZHVjZSBhIHZpcnRpby1uZXQgRVAgZGV2
aWNlCj4gPiBmdW5jdGlvbi4gRGV0YWlscyBhcmUgaW4gY29tbWl0IHJlc3BlY3RpdmVseS4KPiA+
Cj4gPiBDdXJyZW50bHkgdGhvc2UgbmV0d29yayBkZXZpY2VzIGFyZSB0ZXN0ZCB1c2luZyBwaW5n
IG9ubHkuIEknbGwgYWRkIGEKPiA+IHJlc3VsdCBvZiBwZXJmb3JtYW5jZSBldmFsdWF0aW9uIHVz
aW5nIGlwZXJmIGFuZCBldGMgdG8gdGhlIGZ1dHVyZSB2ZXJzaW9uCj4gPiBvZiB0aGlzIHBhdGNo
c2V0Lgo+Cj4KPiBBbGwgdGhpcyBmZWVscyBsaWtlIGl0J2QgbmVlZCBhIHZpcnRpbyBzcGVjIGV4
dGVuc2lvbiBidXQgSSdtIG5vdCAxMDAlCj4gc3VyZSB3aXRob3V0IHNwZW5kaW5nIG11Y2ggbW9y
ZSB0aW1lIHVuZGVyc3RhbmRpbmcgdGhpcy4KPiB3aGF0IGRvIHlvdSBzYXk/ClRoaXMgcGF0Y2gg
c2hvd3MgdGhlIHZpcnRpby1uZXQgZGV2aWNlIGFzIHBjaWUgZGV2aWNlLiBDb3VsZCB5b3UgdGVs
bAptZSB3aGF0IHBhcnQKb2YgdGhlIHNwZWMgYXJlIHlvdSBjb25jZXJuZWQgYWJvdXQ/Cgo+ID4g
U2h1bnN1a2UgTWllICg0KToKPiA+ICAgdmlydGlvX3BjaTogYWRkIGEgZGVmaW5pdGlvbiBvZiBx
dWV1ZSBmbGFnIGluIElTUgo+ID4gICB2aXJ0aW9fcmluZzogcmVtb3ZlIGNvbnN0IGZyb20gdnJp
bmcgZ2V0dGVyCj4gPiAgIFBDSTogZW5kcG9pbnQ6IEludHJvZHVjZSB2aXJ0aW8gbGlicmFyeSBm
b3IgRVAgZnVuY3Rpb25zCj4gPiAgIFBDSTogZW5kcG9pbnQ6IGZ1bmN0aW9uOiBBZGQgRVAgZnVu
Y3Rpb24gZHJpdmVyIHRvIHByb3ZpZGUgdmlydGlvIG5ldAo+ID4gICAgIGRldmljZQo+ID4KPiA+
ICBkcml2ZXJzL3BjaS9lbmRwb2ludC9LY29uZmlnICAgICAgICAgICAgICAgICAgfCAgIDcgKwo+
ID4gIGRyaXZlcnMvcGNpL2VuZHBvaW50L01ha2VmaWxlICAgICAgICAgICAgICAgICB8ICAgMSAr
Cj4gPiAgZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL0tjb25maWcgICAgICAgIHwgIDEy
ICsKPiA+ICBkcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvTWFrZWZpbGUgICAgICAgfCAg
IDEgKwo+ID4gIC4uLi9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdm5ldC1lcC5jICB8
IDM0MyArKysrKysrKysrCj4gPiAgLi4uL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12
bmV0LXJjLmMgIHwgNjM1ICsrKysrKysrKysrKysrKysrKwo+ID4gIGRyaXZlcnMvcGNpL2VuZHBv
aW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZuZXQuYyB8IDM4NyArKysrKysrKysrKwo+ID4gIGRyaXZl
cnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZuZXQuaCB8ICA2MiArKwo+ID4gIGRy
aXZlcnMvcGNpL2VuZHBvaW50L3BjaS1lcGYtdmlydGlvLmMgICAgICAgICB8IDExMyArKysrCj4g
PiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyAgICAgICAgICAgICAgICAgIHwgICAyICst
Cj4gPiAgaW5jbHVkZS9saW51eC9wY2ktZXBmLXZpcnRpby5oICAgICAgICAgICAgICAgIHwgIDI1
ICsKPiA+ICBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDIgKy0KPiA+ICBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5oICAgICAgICAgICAgICAg
fCAgIDIgKwo+ID4gIDEzIGZpbGVzIGNoYW5nZWQsIDE1OTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVu
Y3Rpb25zL3BjaS1lcGYtdm5ldC1lcC5jCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
cGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZuZXQtcmMuYwo+ID4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12bmV0LmMKPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1l
cGYtdm5ldC5oCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2VuZHBvaW50L3Bj
aS1lcGYtdmlydGlvLmMKPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9wY2kt
ZXBmLXZpcnRpby5oCj4gPgo+ID4gLS0KPiA+IDIuMjUuMQo+CgpCZXN0LApTaHVuc3VrZQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
