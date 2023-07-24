Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8C4C001B0
	for <virtualization@archiver.kernel.org>; Mon, 24 Jul 2023 06:53:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7FB560D58;
	Mon, 24 Jul 2023 06:53:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B7FB560D58
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FBDoHLF9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XBSuP9_yrQd6; Mon, 24 Jul 2023 06:53:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B4BE160B97;
	Mon, 24 Jul 2023 06:53:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B4BE160B97
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EE85C0072;
	Mon, 24 Jul 2023 06:53:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 816CDC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 06:53:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E24F60B97
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 06:53:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E24F60B97
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SYXXEwsVj8nn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 06:53:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DCC0D60B65
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 06:53:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DCC0D60B65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690181583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2pKG/QpR2RzRLFZUHbEZEOsoTAlRHGNWkIflkbnf814=;
 b=FBDoHLF90gR6yzb5LXKlLXj8JE/FjdLWSpHffYJDkw5PZYFhVvEU9qf6Oyq1IWQnVg599t
 LbN1zyRxp2ZY/aDkJAr5jwMU20VCe0nnDZZsYwzJ1a9LKQI5mafWBT0sVPDThMd8BzY+np
 OihEAwzfVrpsweAscNrCmjmEPcccXyQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-TTZjh1b8NUiMekb4WB2FrQ-1; Mon, 24 Jul 2023 02:53:02 -0400
X-MC-Unique: TTZjh1b8NUiMekb4WB2FrQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9939495f8so2683731fa.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 23:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690181580; x=1690786380;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2pKG/QpR2RzRLFZUHbEZEOsoTAlRHGNWkIflkbnf814=;
 b=j0WAvuECSYqIzTRhbsMF/b//ASTr4Ll6igd4hnh90K21KWTH0kZcNlAeRPwfph7PMj
 vjAhNVUuxQcWPe6laLIpF4o5xNaRfHQF/Yi64TA/k04m8BqlQmVxAUUcI7rN3cPLKmDc
 mbQ0fvPFGbqOAsdS3V+H7Bb1rfyf40dLix2XEkxL5/vkvUxizEn40LfR74/xfJdORQr2
 Oomp2IIxWAtkRuw8YLCoi94C35VMDUTEs6qrvi0LVNHbPt9DIHJ59GIXC0fedkBM+Ehi
 QzZiT/22l9HRpMCC+kEWSZiQcXRnjufcv04jIAVADDtfYtSKlhqUFCMuV/H15HbaexyT
 /C5Q==
X-Gm-Message-State: ABy/qLb+MwvvF5BFXGKOPTIFD1HjMWyVe0QpXoB34ZI+uf9iX+0pFU8a
 tzNI+NhiOyepMrc63G3Lb+p4k9BTyAjTrXs6Ar8aoA/vLBBXWSbJYH8OdCC7FJRPzo06fjpHDKJ
 0VO/wnLW/o5vt3t/bOlTVvzVIGXOUrT2ZYNhBlhZGCwJykQUpXXhPs0DJ1g==
X-Received: by 2002:a05:651c:205:b0:2b5:9f54:e290 with SMTP id
 y5-20020a05651c020500b002b59f54e290mr4905531ljn.0.1690181580678; 
 Sun, 23 Jul 2023 23:53:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGAmLS3rinVGsLd7AiJM7P6pJi3Om6DIylJcrxKdBPPEYm9eGwGfcqzWBBrKCtsdHC9O5nMYXmIxWSEsqiejcM=
X-Received: by 2002:a05:651c:205:b0:2b5:9f54:e290 with SMTP id
 y5-20020a05651c020500b002b59f54e290mr4905511ljn.0.1690181580374; Sun, 23 Jul
 2023 23:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <20230723053441-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230723053441-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Jul 2023 14:52:49 +0800
Message-ID: <CACGkMEuPcOyjgHkKXrcnofdb5XhYYTrGQeuR3j6Oypr0KZxLMg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, edumazet@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

T24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgMjo0NuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBKdWwgMjEsIDIwMjMgYXQgMTA6MTg6MDNQ
TSArMDIwMCwgTWF4aW1lIENvcXVlbGluIHdyb3RlOgo+ID4KPiA+Cj4gPiBPbiA3LzIxLzIzIDE3
OjEwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+IE9uIEZyaSwgSnVsIDIxLCAyMDIz
IGF0IDA0OjU4OjA0UE0gKzAyMDAsIE1heGltZSBDb3F1ZWxpbiB3cm90ZToKPiA+ID4gPgo+ID4g
PiA+Cj4gPiA+ID4gT24gNy8yMS8yMyAxNjo0NSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
ID4gPiA+ID4gT24gRnJpLCBKdWwgMjEsIDIwMjMgYXQgMDQ6Mzc6MDBQTSArMDIwMCwgTWF4aW1l
IENvcXVlbGluIHdyb3RlOgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBPbiA3
LzIwLzIzIDIzOjAyLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gT24g
VGh1LCBKdWwgMjAsIDIwMjMgYXQgMDE6MjY6MjBQTSAtMDcwMCwgU2hhbm5vbiBOZWxzb24gd3Jv
dGU6Cj4gPiA+ID4gPiA+ID4gPiBPbiA3LzIwLzIzIDE6MzggQU0sIEphc29uIFdhbmcgd3JvdGU6
Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IEFkZGluZyBjb25kX3Jlc2NoZWQo
KSB0byB0aGUgY29tbWFuZCB3YWl0aW5nIGxvb3AgZm9yIGEgYmV0dGVyCj4gPiA+ID4gPiA+ID4g
PiA+IGNvLW9wZXJhdGlvbiB3aXRoIHRoZSBzY2hlZHVsZXIuIFRoaXMgYWxsb3dzIHRvIGdpdmUg
Q1BVIGEgYnJlYXRoIHRvCj4gPiA+ID4gPiA+ID4gPiA+IHJ1biBvdGhlciB0YXNrKHdvcmtxdWV1
ZSkgaW5zdGVhZCBvZiBidXN5IGxvb3Bpbmcgd2hlbiBwcmVlbXB0aW9uIGlzCj4gPiA+ID4gPiA+
ID4gPiA+IG5vdCBhbGxvd2VkIG9uIGEgZGV2aWNlIHdob3NlIENWUSBtaWdodCBiZSBzbG93Lgo+
ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+
IFRoaXMgc3RpbGwgbGVhdmVzIGh1bmcgcHJvY2Vzc2VzLCBidXQgYXQgbGVhc3QgaXQgZG9lc24n
dCBwaW4gdGhlIENQVSBhbnkKPiA+ID4gPiA+ID4gPiA+IG1vcmUuICBUaGFua3MuCj4gPiA+ID4g
PiA+ID4gPiBSZXZpZXdlZC1ieTogU2hhbm5vbiBOZWxzb24gPHNoYW5ub24ubmVsc29uQGFtZC5j
b20+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gSSdkIGxpa2Ug
dG8gc2VlIGEgZnVsbCBzb2x1dGlvbgo+ID4gPiA+ID4gPiA+IDEtIGJsb2NrIHVudGlsIGludGVy
cnVwdAo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBXb3VsZCBpdCBtYWtlIHNlbnNlIHRvIGFsc28g
aGF2ZSBhIHRpbWVvdXQ/Cj4gPiA+ID4gPiA+IEFuZCB3aGVuIHRpbWVvdXQgZXhwaXJlcywgc2V0
IEZBSUxFRCBiaXQgaW4gZGV2aWNlIHN0YXR1cz8KPiA+ID4gPiA+Cj4gPiA+ID4gPiB2aXJ0aW8g
c3BlYyBkb2VzIG5vdCBzZXQgYW55IGxpbWl0cyBvbiB0aGUgdGltaW5nIG9mIHZxCj4gPiA+ID4g
PiBwcm9jZXNzaW5nLgo+ID4gPiA+Cj4gPiA+ID4gSW5kZWVkLCBidXQgSSB0aG91Z2h0IHRoZSBk
cml2ZXIgY291bGQgZGVjaWRlIGl0IGlzIHRvbyBsb25nIGZvciBpdC4KPiA+ID4gPgo+ID4gPiA+
IFRoZSBpc3N1ZSBpcyB3ZSBrZWVwIHdhaXRpbmcgd2l0aCBydG5sIGxvY2tlZCwgaXQgY2FuIHF1
aWNrbHkgbWFrZSB0aGUKPiA+ID4gPiBzeXN0ZW0gdW51c2FibGUuCj4gPiA+Cj4gPiA+IGlmIHRo
aXMgaXMgYSBwcm9ibGVtIHdlIHNob3VsZCBmaW5kIGEgd2F5IG5vdCB0byBrZWVwIHJ0bmwKPiA+
ID4gbG9ja2VkIGluZGVmaW5pdGVseS4KPiA+Cj4gPiBGcm9tIHRoZSB0ZXN0cyBJIGhhdmUgZG9u
ZSwgSSB0aGluayBpdCBpcy4gV2l0aCBPVlMsIGEgcmVjb25maWd1cmF0aW9uIGlzCj4gPiBwZXJm
b3JtZWQgd2hlbiB0aGUgVkRVU0UgZGV2aWNlIGlzIGFkZGVkLCBhbmQgd2hlbiBhIE1MWDUgZGV2
aWNlIGlzCj4gPiBpbiB0aGUgc2FtZSBicmlkZ2UsIGl0IGVuZHMgdXAgZG9pbmcgYW4gaW9jdGwo
KSB0aGF0IHRyaWVzIHRvIHRha2UgdGhlCj4gPiBydG5sIGxvY2suIEluIHRoaXMgY29uZmlndXJh
dGlvbiwgaXQgaXMgbm90IHBvc3NpYmxlIHRvIGtpbGwgT1ZTIGJlY2F1c2UKPiA+IGl0IGlzIHN0
dWNrIHRyeWluZyB0byBhY3F1aXJlIHJ0bmwgbG9jayBmb3IgbWx4NSB0aGF0IGlzIGhlbGQgYnkg
dmlydGlvLQo+ID4gbmV0Lgo+Cj4gU28gZm9yIHN1cmUsIHdlIGNhbiBxdWV1ZSB1cCB0aGUgd29y
ayBhbmQgcHJvY2VzcyBpdCBsYXRlci4KPiBUaGUgc29tZXdoYXQgdHJpY2t5IHBhcnQgaXMgbGlt
aXRpbmcgdGhlIG1lbW9yeSBjb25zdW1wdGlvbi4KCkFuZCBpdCBuZWVkcyB0byBzeW5jIHdpdGgg
cnRubCBzb21laG93LCBlLmcgZGV2aWNlIHVucmVnaXN0ZXJpbmcgd2hpY2gKc2VlbXMgbm90IGVh
c3kuCgpUaGFua3MKCj4KPgo+ID4gPgo+ID4gPiA+ID4gPiA+IDItIHN0aWxsIGhhbmRsZSBzdXJw
cmlzZSByZW1vdmFsIGNvcnJlY3RseSBieSB3YWtpbmcgaW4gdGhhdCBjYXNlCj4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IC0tLQo+ID4g
PiA+ID4gPiA+ID4gPiAgICAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDQgKysrLQo+ID4g
PiA+ID4gPiA+ID4gPiAgICAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4g
PiA+ID4gPiA+ID4gPiBpbmRleCA5ZjNiMWQ2YWMzM2QuLmU3NTMzZjI5YjIxOSAxMDA2NDQKPiA+
ID4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiA+
ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ID4gPiA+ID4gPiBA
QCAtMjMxNCw4ICsyMzE0LDEwIEBAIHN0YXRpYyBib29sIHZpcnRuZXRfc2VuZF9jb21tYW5kKHN0
cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCB1OCBjbGFzcywgdTggY21kLAo+ID4gPiA+ID4gPiA+ID4g
PiAgICAgICAgICAgICAgKiBpbnRvIHRoZSBoeXBlcnZpc29yLCBzbyB0aGUgcmVxdWVzdCBzaG91
bGQgYmUgaGFuZGxlZCBpbW1lZGlhdGVseS4KPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAg
ICovCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgIHdoaWxlICghdmlydHF1ZXVlX2dldF9i
dWYodmktPmN2cSwgJnRtcCkgJiYKPiA+ID4gPiA+ID4gPiA+ID4gLSAgICAgICAgICAgICAgIXZp
cnRxdWV1ZV9pc19icm9rZW4odmktPmN2cSkpCj4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAg
ICAgICF2aXJ0cXVldWVfaXNfYnJva2VuKHZpLT5jdnEpKSB7Cj4gPiA+ID4gPiA+ID4gPiA+ICsg
ICAgICAgICAgICAgICBjb25kX3Jlc2NoZWQoKTsKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgICAgICBjcHVfcmVsYXgoKTsKPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICB9Cj4gPiA+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgIHJldHVybiB2aS0+Y3Ry
bC0+c3RhdHVzID09IFZJUlRJT19ORVRfT0s7Cj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgfQo+ID4g
PiA+ID4gPiA+ID4gPiAtLQo+ID4gPiA+ID4gPiA+ID4gPiAyLjM5LjMKPiA+ID4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiA+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiA+ID4gPiA+ID4gPiA+ID4gVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
Cj4gPiA+ID4gPiA+ID4gPiA+IFZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCj4gPiA+ID4gPiA+ID4gPiA+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9uCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+Cj4g
PiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
