Return-Path: <SRS0=GMN+=KG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD5BC43461
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 09:21:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33EE66161F
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 09:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EE66161F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B821F84564;
	Tue, 11 May 2021 09:21:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uOy4_jPEpWhZ; Tue, 11 May 2021 09:21:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4832584503;
	Tue, 11 May 2021 09:21:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23913C000D;
	Tue, 11 May 2021 09:21:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB482C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 09:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A96C760D5A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 09:21:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ceVeJ7chJro1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 09:21:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C6CC607FE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 09:21:17 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id z3so17218190oib.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 02:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SpuzP5dD89015IuaoQUypVRri84Ral9X2cBH7/+h6B0=;
 b=EJZPKRTPNk0sadX+CdnzrZDhkw4Zupn/oAC4s8Xy/pdkvPNEJUfpTYqnMa/X4Z+fAN
 BAEsRNsd0/uWgG1OhOWCGb7+V+f4tw9l6CsbbJ4VwId+/4PrV2HHZ9NDSRFHr+rrtYpz
 MLaWeEhBurHu8pnY+SoVgpIM5SaHZ4m2+3eOhp9olv+0Gh9zqH2pWsNW/S/Caj5a93T3
 D4gMSdUhjoOSwmxDO3MgOiAIe84SOqaO8clT1T21M90BgAdmyJJmmBnTJpf6ApIvM2Fx
 1amz9mJyQe3eOZ0NJGDnvXTr/E67EQCoRdJLPdKOFZT61ssBQZuKRbvQtJ3f40obRIbv
 /EXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SpuzP5dD89015IuaoQUypVRri84Ral9X2cBH7/+h6B0=;
 b=A4uySbQTU/93V6J3a+5V9yi9N2i/gqCPZG526+8mf5ULE42G22c+OIiHXc2etwAAlo
 db+plL0MewE7TDp4S//pTyW9dXo7hbgq5LM2o5xSnTzEv7xuNArZbHXQPEhgY5Xnvwl4
 PClKRcVuZu/6KrxYnOwYr53p2jcltRhBHvzoU2yw7WHxprJXYMAMEri60ReW0++i5m1z
 8/+kc/3Z2GsIXizWqe3C30qV/hHEH3uQT4MPkA7jZYjAEMZESvYs+XybkozrzmbYca41
 aNnKEpkh8rRtYQEFEgID65JoV7ONfdfRDasF4onnIwRVymf6FQWIqxJk4J9DFWX0qy4W
 pYKg==
X-Gm-Message-State: AOAM531xoLsWTM4s0fUr6gzQXl2DGQKnYfys60QSohHUHWYcOF3H5GqB
 Pl9AY4y/tujHMzhH9ycCxj1MevChTrKoSjsJ1TINmg==
X-Google-Smtp-Source: ABdhPJyafaXyIkykLjYRRydc5zqSCnCbYc4lexHHectPWvV2uB9PGFbQwIt/YYm59WbO+bJqIioASXZVBuj+bdHr32g=
X-Received: by 2002:aca:ad06:: with SMTP id w6mr2807257oie.54.1620724876444;
 Tue, 11 May 2021 02:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-2-yuri.benditovich@daynix.com>
 <40938c20-5851-089b-c3c0-074bbd636970@redhat.com>
 <CAOEp5OdgYtP+W1thGsTGnvEPWrJ02s1HemskQpnMTUyYbsX4jQ@mail.gmail.com>
 <CACGkMEuk3-iP+AxsvhT16t+5dXXtVMGoWPovM=Msm0kvo3LR2Q@mail.gmail.com>
In-Reply-To: <CACGkMEuk3-iP+AxsvhT16t+5dXXtVMGoWPovM=Msm0kvo3LR2Q@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 11 May 2021 12:21:04 +0300
Message-ID: <CAOEp5OfAEb4=C7GK_EJvJnoTTk-ebdg0RygShPwbn3O67ucQ2Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio-net: add definitions for host USO feature
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCBNYXkgMTEsIDIwMjEgYXQgMTE6MjQgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIE1heSAxMSwgMjAyMSBhdCA0OjEyIFBNIFl1cmkg
QmVuZGl0b3ZpY2gKPiA8eXVyaS5iZW5kaXRvdmljaEBkYXluaXguY29tPiB3cm90ZToKPiA+Cj4g
PiBPbiBUdWUsIE1heSAxMSwgMjAyMSBhdCA5OjQ3IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPgo+ID4gPiDlnKggMjAyMS81LzExIOS4i+WNiDEy
OjQyLCBZdXJpIEJlbmRpdG92aWNoIOWGmemBkzoKPiA+ID4gPiBEZWZpbmUgZmVhdHVyZSBiaXQg
YW5kIEdTTyB0eXBlIGFjY29yZGluZyB0byB0aGUgVklSVElPCj4gPiA+ID4gc3BlY2lmaWNhdGlv
bi4KPiA+ID4gPgo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFl1cmkgQmVuZGl0b3ZpY2ggPHl1cmku
YmVuZGl0b3ZpY2hAZGF5bml4LmNvbT4KPiA+ID4gPiAtLS0KPiA+ID4gPiAgIGluY2x1ZGUvdWFw
aS9saW51eC92aXJ0aW9fbmV0LmggfCAyICsrCj4gPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspCj4gPiA+ID4KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xp
bnV4L3ZpcnRpb19uZXQuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fbmV0LmgKPiA+ID4g
PiBpbmRleCAzZjU1YTQyMTVmMTEuLmE1NTZhYzczNWQ3ZiAxMDA2NDQKPiA+ID4gPiAtLS0gYS9p
bmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oCj4gPiA+ID4gKysrIGIvaW5jbHVkZS91YXBp
L2xpbnV4L3ZpcnRpb19uZXQuaAo+ID4gPiA+IEBAIC01Nyw2ICs1Nyw3IEBACj4gPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBTdGVlcmluZyAqLwo+ID4gPiA+
ICAgI2RlZmluZSBWSVJUSU9fTkVUX0ZfQ1RSTF9NQUNfQUREUiAyMyAgICAgICAvKiBTZXQgTUFD
IGFkZHJlc3MgKi8KPiA+ID4gPgo+ID4gPiA+ICsjZGVmaW5lIFZJUlRJT19ORVRfRl9IT1NUX1VT
TyAgICAgNTYgLyogSG9zdCBjYW4gaGFuZGxlIFVTTyBwYWNrZXRzICovCj4gPgo+ID4gVGhpcyBp
cyB0aGUgdmlydGlvLW5ldCBmZWF0dXJlCj4KPiBSaWdodCwgSSBtaXNzIHRoaXMgcGFydC4KPgo+
ID4KPiA+ID4gPiAgICNkZWZpbmUgVklSVElPX05FVF9GX0hBU0hfUkVQT1JUICA1NyAgICAgICAg
LyogU3VwcG9ydHMgaGFzaCByZXBvcnQgKi8KPiA+ID4gPiAgICNkZWZpbmUgVklSVElPX05FVF9G
X1JTUyAgICAgIDYwICAgIC8qIFN1cHBvcnRzIFJTUyBSWCBzdGVlcmluZyAqLwo+ID4gPiA+ICAg
I2RlZmluZSBWSVJUSU9fTkVUX0ZfUlNDX0VYVCAgICAgICAgICA2MSAgICAvKiBleHRlbmRlZCBj
b2FsZXNjaW5nIGluZm8gKi8KPiA+ID4gPiBAQCAtMTMwLDYgKzEzMSw3IEBAIHN0cnVjdCB2aXJ0
aW9fbmV0X2hkcl92MSB7Cj4gPiA+ID4gICAjZGVmaW5lIFZJUlRJT19ORVRfSERSX0dTT19UQ1BW
NCAgICAxICAgICAgIC8qIEdTTyBmcmFtZSwgSVB2NCBUQ1AgKFRTTykgKi8KPiA+ID4gPiAgICNk
ZWZpbmUgVklSVElPX05FVF9IRFJfR1NPX1VEUCAgICAgICAgICAgICAgMyAgICAgICAvKiBHU08g
ZnJhbWUsIElQdjQgVURQIChVRk8pICovCj4gPiA+ID4gICAjZGVmaW5lIFZJUlRJT19ORVRfSERS
X0dTT19UQ1BWNiAgICA0ICAgICAgIC8qIEdTTyBmcmFtZSwgSVB2NiBUQ1AgKi8KPiA+ID4gPiAr
I2RlZmluZSBWSVJUSU9fTkVUX0hEUl9HU09fVURQX0w0ICAgIDUgICAgICAgLyogR1NPIGZyYW1l
LCBJUHY0IFVEUCAoVVNPKSAqLwo+ID4KPiA+IFRoaXMgaXMgcmVzcGVjdGl2ZSBHU08gdHlwZQo+
ID4KPiA+ID4KPiA+ID4KPiA+ID4gVGhpcyBpcyB0aGUgZ3NvX3R5cGUgbm90IHRoZSBmZWF0dXJl
IGFjdHVhbGx5Lgo+ID4gPgo+ID4gPiBJIHdvbmRlciB3aGF0J3MgdGhlIHJlYXNvbiBmb3Igbm90
Cj4gPiA+Cj4gPiA+IDEpIGludHJvZHVjaW5nIGEgZGVkaWNhdGVkIHZpcnRpby1uZXQgZmVhdHVy
ZSBiaXQgZm9yIHRoaXMKPiA+ID4gKFZJUlRJT19ORVRfRl9HVUVTVF9HU09fVURQX0w0Lgo+ID4K
PiA+IFRoaXMgc2VyaWVzIGlzIG5vdCBmb3IgR1VFU1QncyBmZWF0dXJlLCBpdCBpcyBvbmx5IGZv
ciBob3N0IGZlYXR1cmUuCj4gPgo+ID4gPiAyKSB0b2dnbGUgdGhlIE5FVElGX0ZfR1NPX1VEUF9M
NCAgZmVhdHVyZSBmb3IgdHVudGFwIGJhc2VkIG9uIHRoZQo+ID4gPiBuZWdvdGlhdGVkIGZlYXR1
cmUuCj4gPgo+ID4gVGhlIE5FVElGX0ZfR1NPX1VEUF9MNCB3b3VsZCBiZSByZXF1aXJlZCBmb3Ig
dGhlIGd1ZXN0IFJYIHBhdGguCj4gPiBUaGUgZ3Vlc3QgVFggcGF0aCBkb2VzIG5vdCByZXF1aXJl
IGFueSBmbGFncyB0byBiZSBwcm9wYWdhdGVkLCBpdCBvbmx5Cj4gPiBhbGxvd3MgdGhlIGd1ZXN0
IHRvIHRyYW5zbWl0IGxhcmdlIFVEUCBwYWNrZXRzIGFuZCBoYXZlIHRoZW0KPiA+IGF1dG9tYXRp
Y2FsbHkgc3BsaXR0ZWQuCj4gPiAoVGhpcyBpcyBzaW1pbGFyIHRvIEhPU1RfVUZPIGJ1dCBkb2Vz
IHBhY2tldCBzZWdtZW50YXRpb24gaW5zdGVhZCBvZgo+ID4gZnJhZ21lbnRhdGlvbi4gR1VFU1Rf
VUZPIGluZGVlZCByZXF1aXJlcyBhIHJlc3BlY3RpdmUgTkVUSUYgZmxhZywgYXMKPiA+IGl0IGlz
IHVuY2xlYXIgd2hldGhlciB0aGUgZ3Vlc3QgaXMgY2FwYWJsZSBvZiByZWNlaXZpbmcgc3VjaCBw
YWNrZXRzKS4KPgo+IFNvIEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gaW1wbGVtZW50IFRYL1JYIGlu
IHRoZSBzYW1lIHNlcmllcyB1bmxlc3MKPiB0aGVyZSdzIHNvbWV0aGluZyBtaXNzZWQ6Cj4KPiBG
b3IgR3Vlc3QgVFgsIE5FVElGX0ZfR1NPX1VEUF9MNCBuZWVkcyB0byBiZSBlbmFibGVkIGluIHRo
ZSBndWVzdAo+IHZpcnRpby1uZXQgb25seSB3aGVuIFZJUlRJT19ORVRfRl9IT1NUX1VTTyBpcyBu
ZWdvdGlhdGVkLgoKSSB1bmRlcnN0YW5kIHRoYXQgdGhpcyBpcyB3aGF0IHNob3VsZCBiZSBkb25l
IHdoZW4gdGhpcyBmZWF0dXJlIHdpbGwKYmUgYWRkZWQgdG8gTGludXggdmlydGlvLW5ldCBkcml2
ZXIuCkJ1dCBhdCB0aGUgbW9tZW50IHdlIGRvIG5vdCBoYXZlIGVub3VnaCByZXNvdXJjZXMgdG8g
d29yayBvbiBpdC4KQ3VycmVudGx5IHdlIGhhdmUgYSBjbGVhciB1c2UgY2FzZSBhbmQgYWJpbGl0
eSB0byB0ZXN0IGluIG9uIFdpbmRvd3MgZ3Vlc3QuClJlc3BlY3RpdmUgUUVNVSBjaGFuZ2VzIGFy
ZSBwZW5kaW5nIGZvciBrZXJuZWwgcGF0Y2hlcywgY3VycmVudApyZWZlcmVuY2UgaXMgaHR0cHM6
Ly9naXRodWIuY29tL2RheW5peC9xZW11L3RyZWUvdXNvCgo+IEZvciBndWVzdCBSWCwgTkVUSUZf
Rl9HU09fVURQX0w0IG5lZWRzIHRvIGJlIGVuYWJsZWQgb24gdGhlIGhvc3QKPiB0dW50YXAgb25s
eSB3aGVuIFZJUlRJT19ORVRfRl9HVUVTVF9VU08gaXMgbmVvZ2lhdGVkLgoKQ3VycmVudGx5IHdl
IGFyZSBub3QgYWJsZSB0byB1c2UgZ3Vlc3QgUlggVURQIEdTTy4KSW4gb3JkZXIgdG8gZG8gdGhh
dCB3ZSBhdCBsZWFzdCBzaG91bGQgYmUgYWJsZSB0byBidWlsZCBvdXIgV2luZG93cwpkcml2ZXJz
IHdpdGggdGhlIG1vc3QgdXBkYXRlZCBkcml2ZXIgZGV2ZWxvcG1lbnQga2l0ICgyMDA0KykuCkF0
IHRoZSBtb21lbnQgd2UgY2FuJ3QsIHRoaXMgdGFzayBpcyBpbiBhIHBsYW4gYnV0IGNhbiB0YWtl
IHNldmVyYWwKbW9udGhzLiBTbyB3ZSBkbyBub3QgaGF2ZSBhIHRlc3QvdXNlIGNhc2Ugd2l0aCBX
aW5kb3dzIFZNLgoKCj4KPiBUaGFua3MKPgo+ID4KPiA+ID4KPiA+ID4gVGhhbmtzCj4gPiA+Cj4g
PiA+Cj4gPiA+ID4gICAjZGVmaW5lIFZJUlRJT19ORVRfSERSX0dTT19FQ04gICAgICAgICAgICAg
IDB4ODAgICAgLyogVENQIGhhcyBFQ04gc2V0ICovCj4gPiA+ID4gICAgICAgX191OCBnc29fdHlw
ZTsKPiA+ID4gPiAgICAgICBfX3ZpcnRpbzE2IGhkcl9sZW47ICAgICAvKiBFdGhlcm5ldCArIElQ
ICsgdGNwL3VkcCBoZHJzICovCj4gPiA+Cj4gPgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
