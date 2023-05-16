Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F303EC77B7A
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 05:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01E4860E62;
	Tue, 16 May 2023 05:56:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01E4860E62
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I2hmVjHS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z16-6PyyLnTi; Tue, 16 May 2023 05:56:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0210260F46;
	Tue, 16 May 2023 05:56:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0210260F46
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAAC6C0037;
	Tue, 16 May 2023 05:56:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23FEFC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 05:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DEBA860F46
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 05:56:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DEBA860F46
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OpmBfY9WH8PE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 05:56:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C27C560E62
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C27C560E62
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 05:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684216590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xE2vX9E3wrj8UcSGbMoNwC1q+B39hVP/OfNafMgz0vs=;
 b=I2hmVjHSNEsIjmC2Lx5wzjtxkPOi33cCsEF43VuJ7EeJYM5q8BYUgP0kxr0/fUW4UOB++r
 zHNHWrnnptisoFR2RX5xnPsd/kZ9mgmcpcPO7nA+Lr/Svh6f05lUIAyPi2jc85Bjoclz9D
 Sn1ZjyoYSedYHMHWvLfLU6EYWduaKHE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-yiMuRVpuPX6336i6A_W0QQ-1; Tue, 16 May 2023 01:56:28 -0400
X-MC-Unique: yiMuRVpuPX6336i6A_W0QQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-306281812d6so5346081f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 22:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684216587; x=1686808587;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xE2vX9E3wrj8UcSGbMoNwC1q+B39hVP/OfNafMgz0vs=;
 b=KOkXWirv+RNwzmrss7bMGi7bRXizM2XsV5hrdW4umtp30wsbZuWkUuxTFcTJeSPodc
 ykv01rwkZZjf0hjqbTfCf/kc1oikOshGmHxwx+3wTIzu7aUrTAst82Eh/WlcgGOYq6eL
 BKCSJQSw33OPHDH4E2Q+CcNYqFKlgm6wrRNnthf1mdCjIz8+Km8Lfx46w12eR5bRvPPP
 QwfIaH99pWogusVM08RvrxMa95j5CRT1EOebcmp/vbysae2/7lRUPanKARkQ2K3CLyKl
 ++ujG7IPoJodXe0p9uZVNsUEYscnHo/eINdkU6JZJrYevpaNUGBZCFSHvNsH6VVUNSad
 A6YQ==
X-Gm-Message-State: AC+VfDzrDPkz7gePVTgJ4m1U6aN4IlqtbiESloF1xtLQ3pWaks9FpSGz
 avcotPczSbAkk9cb0aCdOQda6oafkrU1saotBHCd1kxFlbM63M7ACpOckAgncMVpVqPDPad7F79
 2JNa77PMho7U/f1SVY8wuibCi7B7RW52pDyZll5ASJQ==
X-Received: by 2002:adf:e88a:0:b0:2ef:bada:2f25 with SMTP id
 d10-20020adfe88a000000b002efbada2f25mr23481278wrm.67.1684216587766; 
 Mon, 15 May 2023 22:56:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6VOYlL8HQ+iOu5OwzIWQzrbzMHDIe+8lZ375iEzXfw1aZ3CniP6q9reUDXiExA4a5y7ChjZg==
X-Received: by 2002:adf:e88a:0:b0:2ef:bada:2f25 with SMTP id
 d10-20020adfe88a000000b002efbada2f25mr23481259wrm.67.1684216587465; 
 Mon, 15 May 2023 22:56:27 -0700 (PDT)
Received: from redhat.com ([2.52.26.5]) by smtp.gmail.com with ESMTPSA id
 k15-20020a05600c0b4f00b003f4247fbb5fsm1067384wmr.10.2023.05.15.22.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 22:56:26 -0700 (PDT)
Date: Tue, 16 May 2023 01:56:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next V2 1/2] virtio-net: convert rx mode setting to
 use workqueue
Message-ID: <20230516015514-mutt-send-email-mst@kernel.org>
References: <20230414031947-mutt-send-email-mst@kernel.org>
 <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
 <20230510012951-mutt-send-email-mst@kernel.org>
 <CACGkMEszPydzw_MOUOVJKBBW_8iYn66i_9OFvLDoZMH34hMx=w@mail.gmail.com>
 <20230515004422-mutt-send-email-mst@kernel.org>
 <CACGkMEv+Q2UoBarNOzKSrc3O=Wb2_73O2j9cZXFdAiLBm1qY-Q@mail.gmail.com>
 <20230515061455-mutt-send-email-mst@kernel.org>
 <CACGkMEt8QkK1PnTrRUjDbyJheBurdibr4--Es8P0Y9NZM659pQ@mail.gmail.com>
 <20230516000829-mutt-send-email-mst@kernel.org>
 <CACGkMEvCHQLFbtB2fbF27oCd5fNSjUtUOS0q-Lx7=MeYR8KzRA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvCHQLFbtB2fbF27oCd5fNSjUtUOS0q-Lx7=MeYR8KzRA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

T24gVHVlLCBNYXkgMTYsIDIwMjMgYXQgMTI6MTc6NTBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUdWUsIE1heSAxNiwgMjAyMyBhdCAxMjoxM+KAr1BNIE1pY2hhZWwgUy4gVHNpcmtp
biA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFR1ZSwgTWF5IDE2LCAyMDIzIGF0
IDEwOjQ0OjQ1QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IE9uIE1vbiwgTWF5IDE1
LCAyMDIzIGF0IDY6MTfigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3
cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9uIE1vbiwgTWF5IDE1LCAyMDIzIGF0IDAxOjEzOjMzUE0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiBPbiBNb24sIE1heSAxNSwgMjAyMyBh
dCAxMjo0NeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBPbiBNb24sIE1heSAxNSwgMjAyMyBhdCAwOTowNTo1NEFN
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9uIFdlZCwgTWF5IDEwLCAy
MDIzIGF0IDE6MzPigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90
ZToKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBPbiBNb24sIEFwciAxNywgMjAyMyBh
dCAxMTo0MDo1OEFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiBP
biBGcmksIEFwciAxNCwgMjAyMyBhdCAzOjIx4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
PiBPbiBGcmksIEFwciAxNCwgMjAyMyBhdCAwMTowNDoxNVBNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gRm9yZ2V0IHRvIGNjIG5ldGRldiwgYWRkaW5nLgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIEZyaSwgQXByIDE0
LCAyMDIzIGF0IDEyOjI14oCvQU0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9u
IFRodSwgQXByIDEzLCAyMDIzIGF0IDAyOjQwOjI2UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhpcyBwYXRjaCBjb252ZXJ0IHJ4IG1vZGUgc2V0
dGluZyB0byBiZSBkb25lIGluIGEgd29ya3F1ZXVlLCB0aGlzIGlzCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gYSBtdXN0IGZvciBhbGxvdyB0byBzbGVlcCB3aGVuIHdhaXRpbmcgZm9yIHRoZSBj
dnEgY29tbWFuZCB0bwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHJlc3BvbnNlIHNpbmNlIGN1
cnJlbnQgY29kZSBpcyBleGVjdXRlZCB1bmRlciBhZGRyIHNwaW4gbG9jay4KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IEkgZG9uJ3QgbGlrZSB0aGlzIGZyYW5rbHkuIFRoaXMgbWVh
bnMgdGhhdCBzZXR0aW5nIFJYIG1vZGUgd2hpY2ggd291bGQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gcHJldmlvdXNseSBiZSByZWxpYWJsZSwgbm93IGJlY29tZXMgdW5yZWxpYWJsZS4KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBJdCBpcyAidW5yZWxpYWJsZSIg
YnkgZGVzaWduOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAg
ICAgIHZvaWQgICAgICAgICAgICAgICAgICAgICgqbmRvX3NldF9yeF9tb2RlKShzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2KTsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IC0gZmlyc3Qgb2YgYWxsIGNvbmZpZ3VyYXRpb24gaXMgbm8gbG9uZ2VyIGltbWVkaWF0ZQo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IElzIGltbWVkaWF0ZSBh
IGhhcmQgcmVxdWlyZW1lbnQ/IEkgY2FuIHNlZSBhIHdvcmtxdWV1ZSBpcyB1c2VkIGF0IGxlYXN0
Ogo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IG1seDVlLCBpcG9p
YiwgZWZ4LCAuLi4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ICAgYW5kIHRoZXJlIGlzIG5vIHdheSBmb3IgZHJpdmVyIHRvIGZpbmQgb3V0IHdoZW4KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gICBpdCBhY3R1YWxseSB0b29rIGVmZmVjdAo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEJ1dCB3ZSBrbm93IHJ4IG1vZGUgaXMgYmVz
dCBlZmZvcnQgZS5nIGl0IGRvZXNuJ3Qgc3VwcG9ydCB2aG9zdCBhbmQgd2UKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IHN1cnZpdmUgZnJvbSB0aGlzIGZvciB5ZWFycy4KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC0gc2Vjb25kLCBpZiBkZXZpY2UgZmFpbHMgY29t
bWFuZCwgdGhpcyBpcyBhbHNvIG5vdAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgIHByb3BhZ2F0
ZWQgdG8gZHJpdmVyLCBhZ2FpbiBubyB3YXkgZm9yIGRyaXZlciB0byBmaW5kIG91dAo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBWRFVTRSBuZWVkcyB0byBi
ZSBmaXhlZCB0byBkbyB0cmlja3MgdG8gZml4IHRoaXMKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
d2l0aG91dCBicmVha2luZyBub3JtYWwgZHJpdmVycy4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBJdCdzIG5vdCBzcGVjaWZpYyB0byBWRFVTRS4gRm9yIGV4YW1w
bGUsIHdoZW4gdXNpbmcgdmlydGlvLW5ldCBpbiB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFVQ
IGVudmlyb25tZW50IHdpdGggYW55IHNvZnR3YXJlIGN2cSAobGlrZSBtbHg1IHZpYSB2RFBBIG9y
IGNtYQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdHJhbnNwb3J0KS4KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gPiA+IEhtbS4gQ2FuIHdlIGRpZmZlcmVudGlhdGUgYmV0d2VlbiB0aGVzZSB1
c2UtY2FzZXM/Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IEl0IGRvZXNuJ3Qg
bG9vayBlYXN5IHNpbmNlIHdlIGFyZSBkcml2ZXJzIGZvciB2aXJ0aW8gYnVzLiBVbmRlcmxheWVy
Cj4gPiA+ID4gPiA+ID4gPiA+IGRldGFpbHMgd2VyZSBoaWRkZW4gZnJvbSB2aXJ0aW8tbmV0Lgo+
ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBPciBkbyB5b3UgaGF2ZSBhbnkgaWRl
YXMgb24gdGhpcz8KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gVGhhbmtzCj4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gSSBkb24ndCBrbm93LCBwYXNzIHNvbWUga2lu
ZCBvZiBmbGFnIGluIHN0cnVjdCB2aXJ0cXVldWU/Cj4gPiA+ID4gPiA+ID4gPiAgICAgICAgICJi
b29sIHNsb3c7IC8qIFRoaXMgdnEgY2FuIGJlIHZlcnkgc2xvdyBzb21ldGltZXMuIERvbid0IHdh
aXQgZm9yIGl0ISAqLyIKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA/Cj4gPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gU28gaWYgaXQncyBzbG93LCBzbGVl
cCwgb3RoZXJ3aXNlIHBvbGw/Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBJIGZlZWwgc2V0
dGluZyB0aGlzIGZsYWcgbWlnaHQgYmUgdHJpY2t5LCBzaW5jZSB0aGUgZHJpdmVyIGRvZXNuJ3QK
PiA+ID4gPiA+ID4gPiBrbm93IHdoZXRoZXIgb3Igbm90IGl0J3MgcmVhbGx5IHNsb3cuIEUuZyBz
bWFydE5JQyB2ZW5kb3IgbWF5IGFsbG93Cj4gPiA+ID4gPiA+ID4gdmlydGlvLW5ldCBlbXVsYXRp
b24gb3ZlciBQQ0kuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gZHJpdmVyIHdpbGwgaGF2ZSB0aGUgY2hvaWNlLCBkZXBlbmRpbmcgb24g
d2hldGhlcgo+ID4gPiA+ID4gPiB2cSBpcyBkZXRlcm1pbmlzdGljIG9yIG5vdC4KPiA+ID4gPiA+
Cj4gPiA+ID4gPiBPaywgYnV0IHRoZSBwcm9ibGVtIGlzLCBzdWNoIGJvb2xlYW5zIGFyZSBvbmx5
IHVzZWZ1bCBmb3IgdmlydGlvIHJpbmcKPiA+ID4gPiA+IGNvZGVzLiBCdXQgaW4gdGhpcyBjYXNl
LCB2aXJ0aW8tbmV0IGtub3dzIHdoYXQgdG8gZG8gZm9yIGN2cS4gU28gSSdtCj4gPiA+ID4gPiBu
b3Qgc3VyZSB3aG8gdGhlIHVzZXIgaXMuCj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhhbmtzCj4gPiA+
ID4KPiA+ID4gPiBDaXJjbGluZyBiYWNrLCB3aGF0IGV4YWN0bHkgZG9lcyB0aGUgYXJjaGl0ZWN0
dXJlIHlvdSBhcmUgdHJ5aW5nCj4gPiA+ID4gdG8gZml4IGxvb2sgbGlrZT8gV2hvIGlzIGdvaW5n
IHRvIGludHJvZHVjZSB1bmJvdW5kZWQgbGF0ZW5jeT8KPiA+ID4gPiBUaGUgaHlwZXJ2aXNvcj8K
PiA+ID4KPiA+ID4gSHlwZXJ2aXNvciBpcyBvbmUgb2YgdGhlIHBvc3NpYmxlIHJlYXNvbiwgd2Ug
aGF2ZSBtYW55IG1vcmU6Cj4gPiA+Cj4gPiA+IEhhcmR3YXJlIGRldmljZSB0aGF0IHByb3ZpZGVz
IHZpcnRpby1wY2kgZW11bGF0aW9uLgo+ID4gPiBVc2Vyc3BhY2UgZGV2aWNlcyBsaWtlIFZEVVNF
Lgo+ID4KPiA+IFNvIGxldCdzIHN0YXJ0IGJ5IGFkZHJlc3NpbmcgVkRVU0UgbWF5YmU/Cj4gCj4g
SXQncyByZXBvcnRlZCBieSBhdCBsZWFzdCBvbmUgaGFyZHdhcmUgdmVuZG9yIGFzIHdlbGwuIEkg
cmVtZW1iZXIgaXQKPiB3YXMgQWx2YXJvIHdobyByZXBvcnRlZCB0aGlzIGZpcnN0IGluIHRoZSBw
YXN0Lgo+IAo+ID4KPiA+ID4gPiBJZiBzbyBkbyB3ZSBub3QgbWF5YmUgd2FudCBhIG5ldyBmZWF0
dXJlIGJpdAo+ID4gPiA+IHRoYXQgZG9jdW1lbnRzIHRoaXM/IEh5cGVydmlzb3IgdGhlbiBjYW4g
ZGV0ZWN0IG9sZCBndWVzdHMKPiA+ID4gPiB0aGF0IHNwaW4gYW5kIGRlY2lkZSB3aGF0IHRvIGRv
LCBlLmcuIHByaW9yaXRpc2UgY3ZxIG1vcmUsCj4gPiA+ID4gb3IgZmFpbCBGRUFUVVJFU19PSy4K
PiA+ID4KPiA+ID4gV2Ugc3VmZmVyIGZyb20gdGhpcyBmb3IgYmFyZSBtZXRhbCBhcyB3ZWxsLgo+
ID4gPgo+ID4gPiBCdXQgYSBxdWVzdGlvbiBpcyB3aGF0J3Mgd3Jvbmcgd2l0aCB0aGUgYXBwcm9h
Y2ggdGhhdCBpcyB1c2VkIGluIHRoaXMKPiA+ID4gcGF0Y2g/IEkndmUgYW5zd2VyZWQgdGhhdCBz
ZXRfcnhfbW9kZSBpcyBub3QgcmVsaWFibGUsIHNvIGl0IHNob3VsZCBiZQo+ID4gPiBmaW5lIHRv
IHVzZSB3b3JrcXVldWUuIEV4Y2VwdCBmb3IgdGhpcywgYW55IG90aGVyIHRoaW5nIHRoYXQgd29y
cmllcwo+ID4gPiB5b3U/Cj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4KPiA+IEl0J3Mgbm90IHJlbGlh
YmxlIGZvciBvdGhlciBkcml2ZXJzIGJ1dCBoYXMgYmVlbiByZWxpYWJsZSBmb3IgdmlydGlvLgo+
ID4gSSB3b3JyeSBzb21lIHNvZnR3YXJlIHJlbGllZCBvbiB0aGlzLgo+IAo+IEl0J3MgcHJvYmFi
bHkgZmluZSBzaW5jZSBzb21lIGRldmljZSBsaWtlIHZob3N0IGRvZXNuJ3Qgc3VwcG9ydCB0aGlz
Cj4gYXQgYWxsIGFuZCB3ZSBtYW5hZ2UgdG8gc3Vydml2ZSBmb3Igc2V2ZXJhbCB5ZWFycy4KCnZo
b3N0IGlzIG9mdGVuIGNvbm5lY3RlZCB0byBhIGNsZXZlciBsZWFybmluZyBiYWNrZW5kCnN1Y2gg
YXMgYSBicmlkZ2Ugd2hpY2ggd2lsbCBEVFJUIHdpdGhvdXQgZ3Vlc3QgY29uZmlndXJpbmcKYW55
dGhpbmcgYXQgYWxsIHRob3VnaCwgdGhpcyBjb3VsZCBiZSB3aHkgaXQgd29ya3MuCgoKCj4gPiBZ
b3UgYXJlIG1ha2luZyBnb29kIHBvaW50cyB0aG91Z2ggLi4uIGNvdWxkIHdlIGdldCBzb21lCj4g
PiBtYWludGFpbmVyJ3MgZmVlZGJhY2sgb24gdGhpcz8KPiAKPiBUaGF0IHdvdWxkIGJlIGhlbHBm
dWwuIEpha3ViLCBhbnkgaW5wdXQgb24gdGhpcz8KPiAKPiBUaGFua3MKPiAKPiA+Cj4gPiA+ID4K
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IC0tCj4gPiA+ID4gPiA+ID4g
PiBNU1QKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4KPiA+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
