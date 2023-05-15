Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B00C77B7D
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 01:06:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B1C183B01;
	Mon, 15 May 2023 01:06:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5B1C183B01
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WUh7Qw1F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UFPYsQnT0Dsb; Mon, 15 May 2023 01:06:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D346C83AFE;
	Mon, 15 May 2023 01:06:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D346C83AFE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD32BC0036;
	Mon, 15 May 2023 01:06:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31E2EC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 01:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA3A040399
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 01:06:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EA3A040399
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WUh7Qw1F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bXVI0kzj1y98
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 01:06:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D0A5402E7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D0A5402E7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 01:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684112768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uv5aIwjLG1oqVCUluD4Q4yzDZrBh0xxmyz40kJIsGCI=;
 b=WUh7Qw1FoIOd2ixZurZWYv7mGDMz4DaYUMhMlU9sItYZbvDLauNxIK5eqAMUrUjevGrVaf
 6HkNg4betYO2zgfZBtfXhazLPFhu81uf4zPBeEwlnTyBuu2F/zCVKXxTMmhqnfdiB9fFyI
 CepK5cSznxZhLz1v8XVqMzWc6SgcSE8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Ai_tH389MoKFLZPFbmM10g-1; Sun, 14 May 2023 21:06:07 -0400
X-MC-Unique: Ai_tH389MoKFLZPFbmM10g-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f225b6dc0dso5523933e87.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 May 2023 18:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684112765; x=1686704765;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uv5aIwjLG1oqVCUluD4Q4yzDZrBh0xxmyz40kJIsGCI=;
 b=iBBqME2I9mbYMG4rtAPaO4hMyBse5aa6iaQjw+zKQI+WTp5NO/XNog6SKc1XB0/cCz
 cD46Ww+wtu/UGvKrUD9tCzMxaBwQ6uHZNwHfWCqGt96zEnyzxrv9wwoNG3KBI74KDZ1w
 w1Kzci5TjJwR2D7s2GErTBYtr4DLxNM3TEUE6n7b6+A+sixvqI35aEt2d9hxhcp0TpRU
 jM185Tp70f+n+PD+Cogc3yrE0PELGTEiofQnc396Hb9oS7QJgozoWoAshRSveuNUVxWe
 0BbqlloetbbX7StFOrqb8JnIUOiUpbImnR8BLumu3pIfpGpTFQwfqET5y5lyWkbjusf+
 cbWw==
X-Gm-Message-State: AC+VfDyaWfCaGukkj7sTw9xYRdudwk96yLFjjHDgQd6NwMO8fQiKThmx
 oX5LoBEkL9ltMeCEv1omljCZafQyQTIXm2DZib4Qtbr73nRBSWr9Lz2Fdu33fE+TXZIyH++A4oB
 vhBPyboiqNxt7ZLd42X8hx+hw+hMCOageWNE/UrBijvOaf/nYvKcD5DBTdg==
X-Received: by 2002:ac2:4c21:0:b0:4ec:8c1e:c816 with SMTP id
 u1-20020ac24c21000000b004ec8c1ec816mr5376375lfq.34.1684112765545; 
 Sun, 14 May 2023 18:06:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5YPiZxBxVtf9zRH0XfAMrcB1fgSrLC9Ac+IoZn18054L1JMAhHHN2gwfb+4PNChIHs918idKFjoqWhSD5pyIM=
X-Received: by 2002:ac2:4c21:0:b0:4ec:8c1e:c816 with SMTP id
 u1-20020ac24c21000000b004ec8c1ec816mr5376369lfq.34.1684112765255; Sun, 14 May
 2023 18:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413064027.13267-2-jasowang@redhat.com>
 <20230413121525-mutt-send-email-mst@kernel.org>
 <CACGkMEunn1Z3n8yjVaWLqdV502yjaCBSAb_LO4KsB0nuxXmV8A@mail.gmail.com>
 <20230414031947-mutt-send-email-mst@kernel.org>
 <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
 <20230510012951-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230510012951-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 May 2023 09:05:54 +0800
Message-ID: <CACGkMEszPydzw_MOUOVJKBBW_8iYn66i_9OFvLDoZMH34hMx=w@mail.gmail.com>
Subject: Re: [PATCH net-next V2 1/2] virtio-net: convert rx mode setting to
 use workqueue
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, edumazet@google.com, maxime.coquelin@redhat.com,
 kuba@kernel.org, pabeni@redhat.com, david.marchand@redhat.com,
 davem@davemloft.net
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

T24gV2VkLCBNYXkgMTAsIDIwMjMgYXQgMTozM+KAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCBBcHIgMTcsIDIwMjMgYXQgMTE6NDA6NThB
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIEZyaSwgQXByIDE0LCAyMDIzIGF0IDM6
MjHigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4K
PiA+ID4gT24gRnJpLCBBcHIgMTQsIDIwMjMgYXQgMDE6MDQ6MTVQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gPiBGb3JnZXQgdG8gY2MgbmV0ZGV2LCBhZGRpbmcuCj4gPiA+ID4KPiA+
ID4gPiBPbiBGcmksIEFwciAxNCwgMjAyMyBhdCAxMjoyNeKAr0FNIE1pY2hhZWwgUy4gVHNpcmtp
biA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+IE9uIFRodSwgQXBy
IDEzLCAyMDIzIGF0IDAyOjQwOjI2UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4g
PiA+IFRoaXMgcGF0Y2ggY29udmVydCByeCBtb2RlIHNldHRpbmcgdG8gYmUgZG9uZSBpbiBhIHdv
cmtxdWV1ZSwgdGhpcyBpcwo+ID4gPiA+ID4gPiBhIG11c3QgZm9yIGFsbG93IHRvIHNsZWVwIHdo
ZW4gd2FpdGluZyBmb3IgdGhlIGN2cSBjb21tYW5kIHRvCj4gPiA+ID4gPiA+IHJlc3BvbnNlIHNp
bmNlIGN1cnJlbnQgY29kZSBpcyBleGVjdXRlZCB1bmRlciBhZGRyIHNwaW4gbG9jay4KPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBJIGRvbid0IGxpa2UgdGhpcyBmcmFua2x5LiBU
aGlzIG1lYW5zIHRoYXQgc2V0dGluZyBSWCBtb2RlIHdoaWNoIHdvdWxkCj4gPiA+ID4gPiBwcmV2
aW91c2x5IGJlIHJlbGlhYmxlLCBub3cgYmVjb21lcyB1bnJlbGlhYmxlLgo+ID4gPiA+Cj4gPiA+
ID4gSXQgaXMgInVucmVsaWFibGUiIGJ5IGRlc2lnbjoKPiA+ID4gPgo+ID4gPiA+ICAgICAgIHZv
aWQgICAgICAgICAgICAgICAgICAgICgqbmRvX3NldF9yeF9tb2RlKShzdHJ1Y3QgbmV0X2Rldmlj
ZSAqZGV2KTsKPiA+ID4gPgo+ID4gPiA+ID4gLSBmaXJzdCBvZiBhbGwgY29uZmlndXJhdGlvbiBp
cyBubyBsb25nZXIgaW1tZWRpYXRlCj4gPiA+ID4KPiA+ID4gPiBJcyBpbW1lZGlhdGUgYSBoYXJk
IHJlcXVpcmVtZW50PyBJIGNhbiBzZWUgYSB3b3JrcXVldWUgaXMgdXNlZCBhdCBsZWFzdDoKPiA+
ID4gPgo+ID4gPiA+IG1seDVlLCBpcG9pYiwgZWZ4LCAuLi4KPiA+ID4gPgo+ID4gPiA+ID4gICBh
bmQgdGhlcmUgaXMgbm8gd2F5IGZvciBkcml2ZXIgdG8gZmluZCBvdXQgd2hlbgo+ID4gPiA+ID4g
ICBpdCBhY3R1YWxseSB0b29rIGVmZmVjdAo+ID4gPiA+Cj4gPiA+ID4gQnV0IHdlIGtub3cgcngg
bW9kZSBpcyBiZXN0IGVmZm9ydCBlLmcgaXQgZG9lc24ndCBzdXBwb3J0IHZob3N0IGFuZCB3ZQo+
ID4gPiA+IHN1cnZpdmUgZnJvbSB0aGlzIGZvciB5ZWFycy4KPiA+ID4gPgo+ID4gPiA+ID4gLSBz
ZWNvbmQsIGlmIGRldmljZSBmYWlscyBjb21tYW5kLCB0aGlzIGlzIGFsc28gbm90Cj4gPiA+ID4g
PiAgIHByb3BhZ2F0ZWQgdG8gZHJpdmVyLCBhZ2FpbiBubyB3YXkgZm9yIGRyaXZlciB0byBmaW5k
IG91dAo+ID4gPiA+ID4KPiA+ID4gPiA+IFZEVVNFIG5lZWRzIHRvIGJlIGZpeGVkIHRvIGRvIHRy
aWNrcyB0byBmaXggdGhpcwo+ID4gPiA+ID4gd2l0aG91dCBicmVha2luZyBub3JtYWwgZHJpdmVy
cy4KPiA+ID4gPgo+ID4gPiA+IEl0J3Mgbm90IHNwZWNpZmljIHRvIFZEVVNFLiBGb3IgZXhhbXBs
ZSwgd2hlbiB1c2luZyB2aXJ0aW8tbmV0IGluIHRoZQo+ID4gPiA+IFVQIGVudmlyb25tZW50IHdp
dGggYW55IHNvZnR3YXJlIGN2cSAobGlrZSBtbHg1IHZpYSB2RFBBIG9yIGNtYQo+ID4gPiA+IHRy
YW5zcG9ydCkuCj4gPiA+ID4KPiA+ID4gPiBUaGFua3MKPiA+ID4KPiA+ID4gSG1tLiBDYW4gd2Ug
ZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIHRoZXNlIHVzZS1jYXNlcz8KPiA+Cj4gPiBJdCBkb2Vzbid0
IGxvb2sgZWFzeSBzaW5jZSB3ZSBhcmUgZHJpdmVycyBmb3IgdmlydGlvIGJ1cy4gVW5kZXJsYXll
cgo+ID4gZGV0YWlscyB3ZXJlIGhpZGRlbiBmcm9tIHZpcnRpby1uZXQuCj4gPgo+ID4gT3IgZG8g
eW91IGhhdmUgYW55IGlkZWFzIG9uIHRoaXM/Cj4gPgo+ID4gVGhhbmtzCj4KPiBJIGRvbid0IGtu
b3csIHBhc3Mgc29tZSBraW5kIG9mIGZsYWcgaW4gc3RydWN0IHZpcnRxdWV1ZT8KPiAgICAgICAg
ICJib29sIHNsb3c7IC8qIFRoaXMgdnEgY2FuIGJlIHZlcnkgc2xvdyBzb21ldGltZXMuIERvbid0
IHdhaXQgZm9yIGl0ISAqLyIKPgo+ID8KPgoKU28gaWYgaXQncyBzbG93LCBzbGVlcCwgb3RoZXJ3
aXNlIHBvbGw/CgpJIGZlZWwgc2V0dGluZyB0aGlzIGZsYWcgbWlnaHQgYmUgdHJpY2t5LCBzaW5j
ZSB0aGUgZHJpdmVyIGRvZXNuJ3QKa25vdyB3aGV0aGVyIG9yIG5vdCBpdCdzIHJlYWxseSBzbG93
LiBFLmcgc21hcnROSUMgdmVuZG9yIG1heSBhbGxvdwp2aXJ0aW8tbmV0IGVtdWxhdGlvbiBvdmVy
IFBDSS4KClRoYW5rcwoKPiAtLQo+IE1TVAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
