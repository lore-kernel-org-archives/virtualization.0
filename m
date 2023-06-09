Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB242C7EE29
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 02:30:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C4F683EDD;
	Fri,  9 Jun 2023 02:30:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C4F683EDD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z9rA8n3V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UpVI4rJKiMbm; Fri,  9 Jun 2023 02:30:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8A77A83D1E;
	Fri,  9 Jun 2023 02:30:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A77A83D1E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EEEFC0037;
	Fri,  9 Jun 2023 02:30:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A612BC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 02:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7B2F3610FC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 02:30:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B2F3610FC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z9rA8n3V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wGvVPoJKoq5A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 02:30:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9AB3360AF2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9AB3360AF2
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 02:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686277841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pKgD86aH+Hk476sIqnZ+1f0IUBYFa81TWL41lgouwhA=;
 b=Z9rA8n3VsvlaY7nCrOxaN+zQxU7hadnaCvjdFwd03/SzHauPE0JK/rQ2EhfKWvO4soqOMs
 efCwrqjhRcfy3af6Wx02Es9CLFh0zjr9JsQbxWJqT5rJFWwcLg/QXYwZ8o2Di1GlPIO+dV
 cNoyd4vxfdhoA0gglVGMhRt0nWqsN+4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-Gcr08TdQMTGXmWxlER0_Sw-1; Thu, 08 Jun 2023 22:30:39 -0400
X-MC-Unique: Gcr08TdQMTGXmWxlER0_Sw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b1fa7c9f06so9411101fa.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jun 2023 19:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686277838; x=1688869838;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKgD86aH+Hk476sIqnZ+1f0IUBYFa81TWL41lgouwhA=;
 b=NvYKasUo1TiaZ61KAD3jtj1z8Nz7NbIs5oPpkIrwhyTh3blr1IAzIYkKw+rSHGwtf5
 wTFOfj7py+NfctiS5Afnnf6OYTLPlAF66IwDLnhxYEPrnTgMOLxTW+NRyurA6YaR3Z8G
 gWiEkPfAuLRHBKF9RTRabRxemX8rz4a8DN7Q6A1KJyz/mk68y8asmR+GPtTbCZlDqX3Y
 TD+HHoUPoVQvzBihgFvpcwLn7rw+4VZDHa1/4yA4QO7cS3mlU5e1qXr9qiB+tBCLNmXT
 X84M3VpZP1caWbFoeaY3EcVy5mjqpYIEzyj6M6qbIb9U6ZdS66Hi7VWWHnShA7w25DRk
 wGRQ==
X-Gm-Message-State: AC+VfDyoNZCVSCw2PHpqZNH9bYX//dzSUGnuW8N3WjCbWiDyn1pIS9wN
 xnl3bYt6wsT5B6EwxhbquqEWkgKrfrFfDOZBZN7++gySL/xFuHpZP3pEg9E97Y626VxiBPE5ePd
 i2m8c5/8aivkuGN16JevycZFfNwZgEIat3zhcKzw5D0IWK03dHiixcpkNJw==
X-Received: by 2002:a2e:924d:0:b0:2b1:a89a:5f2b with SMTP id
 v13-20020a2e924d000000b002b1a89a5f2bmr183767ljg.2.1686277838355; 
 Thu, 08 Jun 2023 19:30:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4pevOrBrCsNb1IENdHqkhs641dGBpLXa2ghTiJTJJMM4HdgIkhAjxbOjka9rRk1NwS3K7oNe59vxPgtKSdQhA=
X-Received: by 2002:a2e:924d:0:b0:2b1:a89a:5f2b with SMTP id
 v13-20020a2e924d000000b002b1a89a5f2bmr183760ljg.2.1686277838060; Thu, 08 Jun
 2023 19:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230608090124.1807-1-angus.chen@jaguarmicro.com>
 <20230608154400-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230608154400-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 9 Jun 2023 10:30:27 +0800
Message-ID: <CACGkMEuEXAioOvDAZkkkcKc+vkz5Py29jYrC+uTUVG-bahx8Lw@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device from
 add_config
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Angus Chen <angus.chen@jaguarmicro.com>
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

T24gRnJpLCBKdW4gOSwgMjAyMyBhdCAzOjQ14oCvQU0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUaHUsIEp1biAwOCwgMjAyMyBhdCAwNTowMToyNFBN
ICswODAwLCBBbmd1cyBDaGVuIHdyb3RlOgo+ID4gV2hlbiBhZGQgdmlydGlvX3BjaSB2ZHBhIGRl
dmljZSxjaGVjayB0aGUgdnFzIG51bWJlciBvZiBkZXZpY2UgY2FwCj4gPiBhbmQgbWF4X3ZxX3Bh
aXJzIGZyb20gYWRkX2NvbmZpZy4KPiA+IFNpbXBseSBzdGFydGluZyBmcm9tIGZhaWxpbmcgaWYg
dGhlIHByb3Zpc2lvbmVkICNxcCBpcyBub3QKPiA+IGVxdWFsIHRvIHRoZSBvbmUgdGhhdCBoYXJk
d2FyZSBoYXMuCgpJIHRoaW5rIEkga2luZCBvZiBhZ3JlZSB3aXRoIE1pY2hhZWwsIEkgZG9uJ3Qg
c2VlIGFueSBvYnZpb3VzCmFkdmFudGFnZXMgdG8gYWxsb3cgdXNlcnNhcGNlIHRvIGNvbmZpZ3Vy
ZSBtYXhfdnFwIGlmIGl0IGNhbid0IGJlCnByb3Zpc2lvbmVkIGR5bmFtaWNhbGx5LiBXaGF0J3Mg
d3JvbmcgaWYgd2UganVzdCBzdGljayB0aGUgY3VycmVudAphcHByb2FjaCB0aGF0IGRvZXNuJ3Qg
YWNjZXB0IG1heF92cXA/CgpBIGJldHRlciBhcHByb2FjaCBpcyB0byB0d2VhayB0aGUgdmRwYSB0
b29sIHRvIGRpc3BsYXkgdGhlIGxlZ2FsCmF0dHJpYnV0ZXMgdGhhdCBjYW4gYmUgcHJvdmlzaW9u
ZWQuCgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFy
bWljcm8uY29tPgo+Cj4gSSBhbSBub3Qgc3VyZSBhYm91dCB0aGlzIG9uZS4gSG93IGRvZXMgdXNl
cnNwYWNlIGtub3cKPiB3aGljaCB2YWx1ZXMgYXJlIGxlZ2FsPwoKdmRwYSBtZ210ZGV2IHNob3cg
Y2FuIGdpdmVzIGhpbnRzIGxpa2U6CgptYXhfc3VwcG9ydGVkX3ZxcyAzCgo+Cj4gSWYgdGhlcmUn
cyBubyB3YXkgdGhlbiBtYXliZSB3ZSBzaG91bGQganVzdCBjYXAgdGhlIHZhbHVlCj4gdG8gd2hh
dCBkZXZpY2UgY2FuIHN1cHBvcnQgYnV0IG90aGVyd2lzZSBrZWVwIHRoZSBkZXZpY2UKPiB3b3Jr
aW5nLgoKVGhpcyBzZWVtcyBjb25mbGljdCB0byBob3cgb3RoZXIgZHJpdmVycyAobGlrZSBtbHg1
KSBkaWQ6CgogICAgICAgIGlmIChhZGRfY29uZmlnLT5tYXNrICYgQklUX1VMTChWRFBBX0FUVFJf
REVWX05FVF9DRkdfTUFYX1ZRUCkpIHsKICAgICAgICAgICAgICAgIGlmIChhZGRfY29uZmlnLT5u
ZXQubWF4X3ZxX3BhaXJzID4gbWF4X3ZxcyAvIDIpCiAgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOwogICAgICAgICAgICAgICAgbWF4X3ZxcyA9IG1pbl90KHUzMiwgbWF4X3Zx
cywgMiAqIGFkZF9jb25maWctPm5ldC5tYXhfdnFfcGFpcnMpOwogICAgICAgIH0gZWxzZSB7CiAg
ICAgICAgICAgICAgICBtYXhfdnFzID0gMjsKICAgICAgICB9CgpUaGFua3MKCj4KPiA+IC0tLQo+
ID4gdjE6IFVzZSBtYXhfdnFzIGZyb20gYWRkX2NvbmZpZwo+ID4gdjI6IEp1c3QgcmV0dXJuIGZh
aWwgaWYgbWF4X3ZxcyBmcm9tIGFkZF9jb25maWcgaXMgbm90IHNhbWUgYXMgZGV2aWNlCj4gPiAg
ICAgICBjYXAuIFN1Z2dlc3RlZCBieSBqYXNvbi4KPiA+Cj4gPiAgZHJpdmVycy92ZHBhL3ZpcnRp
b19wY2kvdnBfdmRwYS5jIHwgMzUgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKPiA+Cj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jIGIvZHJpdmVy
cy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jCj4gPiBpbmRleCAyODEyODdmYWU4OWYuLmMxZmI2
OTYzZGExMiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEu
Ywo+ID4gKysrIGIvZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jCj4gPiBAQCAtNDgw
LDMyICs0ODAsMzkgQEAgc3RhdGljIGludCB2cF92ZHBhX2Rldl9hZGQoc3RydWN0IHZkcGFfbWdt
dF9kZXYgKnZfbWRldiwgY29uc3QgY2hhciAqbmFtZSwKPiA+ICAgICAgIHU2NCBkZXZpY2VfZmVh
dHVyZXM7Cj4gPiAgICAgICBpbnQgcmV0LCBpOwo+ID4KPiA+IC0gICAgIHZwX3ZkcGEgPSB2ZHBh
X2FsbG9jX2RldmljZShzdHJ1Y3QgdnBfdmRwYSwgdmRwYSwKPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBkZXYsICZ2cF92ZHBhX29wcywgMSwgMSwgbmFtZSwgZmFsc2UpOwo+
ID4gLQo+ID4gLSAgICAgaWYgKElTX0VSUih2cF92ZHBhKSkgewo+ID4gLSAgICAgICAgICAgICBk
ZXZfZXJyKGRldiwgInZwX3ZkcGE6IEZhaWxlZCB0byBhbGxvY2F0ZSB2RFBBIHN0cnVjdHVyZVxu
Iik7Cj4gPiAtICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKHZwX3ZkcGEpOwo+ID4gKyAgICAg
aWYgKGFkZF9jb25maWctPm1hc2sgJiBCSVRfVUxMKFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQVhf
VlFQKSkgewo+ID4gKyAgICAgICAgICAgICBpZiAoYWRkX2NvbmZpZy0+bmV0Lm1heF92cV9wYWly
cyAhPSAodl9tZGV2LT5tYXhfc3VwcG9ydGVkX3ZxcyAvIDIpKSB7Cj4gPiArICAgICAgICAgICAg
ICAgICAgICAgZGV2X2VycigmcGRldi0+ZGV2LCAibWF4IHZxcyAweCV4IHNob3VsZCBiZSBlcXVh
bCB0byAweCV4IHdoaWNoIGRldmljZSBoYXNcbiIsCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBhZGRfY29uZmlnLT5uZXQubWF4X3ZxX3BhaXJzKjIsIHZfbWRldi0+bWF4X3N1cHBv
cnRlZF92cXMpOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ID4g
KyAgICAgICAgICAgICB9Cj4gPiAgICAgICB9Cj4gPgo+ID4gLSAgICAgdnBfdmRwYV9tZ3RkZXYt
PnZwX3ZkcGEgPSB2cF92ZHBhOwo+ID4gLQo+ID4gLSAgICAgdnBfdmRwYS0+dmRwYS5kbWFfZGV2
ID0gJnBkZXYtPmRldjsKPiA+IC0gICAgIHZwX3ZkcGEtPnF1ZXVlcyA9IHZwX21vZGVybl9nZXRf
bnVtX3F1ZXVlcyhtZGV2KTsKPiA+IC0gICAgIHZwX3ZkcGEtPm1kZXYgPSBtZGV2Owo+ID4gLQo+
ID4gICAgICAgZGV2aWNlX2ZlYXR1cmVzID0gdnBfbW9kZXJuX2dldF9mZWF0dXJlcyhtZGV2KTsK
PiA+ICAgICAgIGlmIChhZGRfY29uZmlnLT5tYXNrICYgQklUX1VMTChWRFBBX0FUVFJfREVWX0ZF
QVRVUkVTKSkgewo+ID4gICAgICAgICAgICAgICBpZiAoYWRkX2NvbmZpZy0+ZGV2aWNlX2ZlYXR1
cmVzICYgfmRldmljZV9mZWF0dXJlcykgewo+ID4gLSAgICAgICAgICAgICAgICAgICAgIHJldCA9
IC1FSU5WQUw7Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgZGV2X2VycigmcGRldi0+ZGV2LCAi
VHJ5IHRvIHByb3Zpc2lvbiBmZWF0dXJlcyAiCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAidGhhdCBhcmUgbm90IHN1cHBvcnRlZCBieSB0aGUgZGV2aWNlOiAiCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAiZGV2aWNlX2ZlYXR1cmVzIDB4JWxseCBwcm92aXNpb25l
ZCAweCVsbHhcbiIsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXZpY2VfZmVh
dHVyZXMsIGFkZF9jb25maWctPmRldmljZV9mZWF0dXJlcyk7Cj4gPiAtICAgICAgICAgICAgICAg
ICAgICAgZ290byBlcnI7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7
Cj4gPiAgICAgICAgICAgICAgIH0KPiA+ICAgICAgICAgICAgICAgZGV2aWNlX2ZlYXR1cmVzID0g
YWRkX2NvbmZpZy0+ZGV2aWNlX2ZlYXR1cmVzOwo+ID4gICAgICAgfQo+ID4gKwo+ID4gKyAgICAg
dnBfdmRwYSA9IHZkcGFfYWxsb2NfZGV2aWNlKHN0cnVjdCB2cF92ZHBhLCB2ZHBhLAo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldiwgJnZwX3ZkcGFfb3BzLCAxLCAxLCBu
YW1lLCBmYWxzZSk7Cj4gPiArCj4gPiArICAgICBpZiAoSVNfRVJSKHZwX3ZkcGEpKSB7Cj4gPiAr
ICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAidnBfdmRwYTogRmFpbGVkIHRvIGFsbG9jYXRlIHZE
UEEgc3RydWN0dXJlXG4iKTsKPiA+ICsgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIodnBfdmRw
YSk7Cj4gPiArICAgICB9Cj4gPiArCj4gPiArICAgICB2cF92ZHBhX21ndGRldi0+dnBfdmRwYSA9
IHZwX3ZkcGE7Cj4gPiArCj4gPiArICAgICB2cF92ZHBhLT52ZHBhLmRtYV9kZXYgPSAmcGRldi0+
ZGV2Owo+ID4gKyAgICAgdnBfdmRwYS0+cXVldWVzID0gdl9tZGV2LT5tYXhfc3VwcG9ydGVkX3Zx
czsKPiA+ICsgICAgIHZwX3ZkcGEtPm1kZXYgPSBtZGV2Owo+ID4gICAgICAgdnBfdmRwYS0+ZGV2
aWNlX2ZlYXR1cmVzID0gZGV2aWNlX2ZlYXR1cmVzOwo+ID4KPiA+ICAgICAgIHJldCA9IGRldm1f
YWRkX2FjdGlvbl9vcl9yZXNldChkZXYsIHZwX3ZkcGFfZnJlZV9pcnFfdmVjdG9ycywgcGRldik7
Cj4gPiAtLQo+ID4gMi4yNS4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
