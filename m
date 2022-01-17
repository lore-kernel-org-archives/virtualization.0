Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315D7C433FE
	for <virtualization@archiver.kernel.org>; Mon, 17 Jan 2022 06:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BB9BF4026A;
	Mon, 17 Jan 2022 06:32:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0lcVpXI8d1sp; Mon, 17 Jan 2022 06:32:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E8B75400C1;
	Mon, 17 Jan 2022 06:31:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4138C0039;
	Mon, 17 Jan 2022 06:31:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7D97C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C21A56064D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:31:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l1d5Go3ZfjS8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:31:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 050F56059F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 06:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642401116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ermpWLzpnf2+eleUkI4QP6TV2e0rXLT1tCR2h6immvo=;
 b=Dbm3yQlWZTRM22P1PEXwk//n4CfIGWxmQ3Ub+ejKubuPc87saaImL7R3xdW7jtWPu/z0K4
 Uo7YCZEBCYm06eLBrLAMWJw0zXetm+aehEsVrYDjtEDnvGaaDMywtkjROJXOWNf6QmfI8J
 wcY3pL6FpMNj1hc5w7UT0b4ub6Y4VhQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-6yZlLh-fPJe7YWxolkpYsA-1; Mon, 17 Jan 2022 01:31:55 -0500
X-MC-Unique: 6yZlLh-fPJe7YWxolkpYsA-1
Received: by mail-pj1-f72.google.com with SMTP id
 x11-20020a17090a6b4b00b001b404624896so12984417pjl.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Jan 2022 22:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ermpWLzpnf2+eleUkI4QP6TV2e0rXLT1tCR2h6immvo=;
 b=YDbNsQmVgAfW7D5RxpoEWTi5tvEvw8hRcNT6KFXCpfD7Y8/1ePzyZGQFuiCt8+AA1H
 jGj9KPhaKbNtOMxR9UvT+YIP/kCThfxRpar3HxpOxbFVQepZNi94n3O0lsYk3DSlsOuG
 y4YQDW6Szz/fak4frGP8fwFZYG4SewhodYEOy9sof2iM7wDAYliA7vf8PMfE9ouBO+ud
 ckXupgcLEclML9Zjoa9yveKAckn4xQZZrcg4tSvxKcdPPoomquiEOSvK/052eL1uv2WH
 zCJfo1kAP3DexBm9HR45VDUDS4NuGpYn01DHdeKzxQbx54n+LV6/C8GIXpTioM/Eifkm
 z2bg==
X-Gm-Message-State: AOAM531dRcgHWvS9o/Z8/KC64R37nXg0ylj3NkWHs2RvD0k6J481jdDS
 N8r47hbnLPgF5nXn6YC4iaXRjMgkrTGFQMe9PSdTiieJ/QkI6Tgfw7eV7qDexMg7S1rsth73sc0
 lnycqkmvaGLubxit/w4y0eSN1/iQZSVToPw2S+z8lYg==
X-Received: by 2002:a17:902:7d93:b0:14a:bf7b:926d with SMTP id
 a19-20020a1709027d9300b0014abf7b926dmr2435715plm.22.1642401113977; 
 Sun, 16 Jan 2022 22:31:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLp3KK5P487dKrJwjLXyn+WyRptyT5BInGR0/0DC3SjMnJck3fOlyrG7lDXwsfJXpGMaMLlA==
X-Received: by 2002:a17:902:7d93:b0:14a:bf7b:926d with SMTP id
 a19-20020a1709027d9300b0014abf7b926dmr2435694plm.22.1642401113728; 
 Sun, 16 Jan 2022 22:31:53 -0800 (PST)
Received: from [10.72.13.251] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o184sm12743628pfb.90.2022.01.16.22.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jan 2022 22:31:53 -0800 (PST)
Message-ID: <d6c4e521-1538-bbbf-30e6-f658a095b3ae@redhat.com>
Date: Mon, 17 Jan 2022 14:31:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] virtio: acknowledge all features before access
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20220114200744.150325-1-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220114200744.150325-1-mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzEvMTUg5LiK5Y2INDowOSwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiBU
aGUgZmVhdHVyZSBuZWdvdGlhdGlvbiB3YXMgZGVzaWduZWQgaW4gYSB3YXkgdGhhdAo+IG1ha2Vz
IGl0IHBvc3NpYmxlIGZvciBkZXZpY2VzIHRvIGtub3cgd2hpY2ggY29uZmlnCj4gZmllbGRzIHdp
bGwgYmUgYWNjZXNzZWQgYnkgZHJpdmVycy4KPgo+IFRoaXMgaXMgYnJva2VuIHNpbmNlIGNvbW1p
dCA0MDQxMjNjMmRiNzkgKCJ2aXJ0aW86IGFsbG93IGRyaXZlcnMgdG8KPiB2YWxpZGF0ZSBmZWF0
dXJlcyIpIHdpdGggZmFsbG91dCBpbiBhdCBsZWFzdCBibG9jayBhbmQgbmV0Lgo+IFdlIGhhdmUg
YSBwYXJ0aWFsIHdvcmstYXJvdW5kIGluIGNvbW1pdCAyZjlhMTc0ZjkxOGUgKCJ2aXJ0aW86IHdy
aXRlCj4gYmFjayBGX1ZFUlNJT05fMSBiZWZvcmUgdmFsaWRhdGUiKSB3aGljaCBhdCBsZWFzdCBs
ZXRzIGRldmljZXMKPiBmaW5kIG91dCB3aGljaCBmb3JtYXQgc2hvdWxkIGNvbmZpZyBzcGFjZSBo
YXZlLCBidXQgdGhpcwo+IGlzIGEgcGFydGlhbCBmaXg6IGd1ZXN0cyBzaG91bGQgbm90IGFjY2Vz
cyBjb25maWcgc3BhY2UKPiB3aXRob3V0IGFja25vd2xlZGdpbmcgZmVhdHVyZXMgc2luY2Ugb3Ro
ZXJ3aXNlIHdlJ2xsIG5ldmVyCj4gYmUgYWJsZSB0byBjaGFuZ2UgdGhlIGNvbmZpZyBzcGFjZSBm
b3JtYXQuCj4KPiBBcyBhIHNpZGUgZWZmZWN0LCB0aGlzIGFsc28gcmVkdWNlcyB0aGUgYW1vdW50
IG9mIGh5cGVydmlzb3IgYWNjZXNzZXMgLQo+IHdlIG5vdyBvbmx5IGFja25vd2xlZGdlIGZlYXR1
cmVzIG9uY2UgdW5sZXNzIHdlIGFyZSBjbGVhcmluZyBhbnkKPiBmZWF0dXJlcyB3aGVuIHZhbGlk
YXRpbmcuCj4KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+IEZpeGVzOiA0MDQxMjNjMmRi
NzkgKCJ2aXJ0aW86IGFsbG93IGRyaXZlcnMgdG8gdmFsaWRhdGUgZmVhdHVyZXMiKQo+IEZpeGVz
OiAyZjlhMTc0ZjkxOGUgKCJ2aXJ0aW86IHdyaXRlIGJhY2sgRl9WRVJTSU9OXzEgYmVmb3JlIHZh
bGlkYXRlIikKPiBDYzogIkhhbGlsIFBhc2ljIiA8cGFzaWNAbGludXguaWJtLmNvbT4KPiBTaWdu
ZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+IC0tLQo+Cj4g
SGFsaWwsIEkgdGhvdWdodCBoYXJkIGFib3V0IG91ciBzaXR1YXRpb24gd2l0aCB0cmFuc2l0aW9u
YWwgYW5kCj4gdG9kYXkgSSBmaW5hbGx5IHRob3VnaHQgb2Ygc29tZXRoaW5nIEkgYW0gaGFwcHkg
d2l0aC4KPiBQbHMgbGV0IG1lIGtub3cgd2hhdCB5b3UgdGhpbmsuIFRlc3Rpbmcgb24gYmlnIGVu
ZGlhbiB3b3VsZAo+IGFsc28gYmUgbXVjaCBhcHByZWNpYXRlZCEKPgo+ICAgZHJpdmVycy92aXJ0
aW8vdmlydGlvLmMgfCAzMSArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCj4gICAxIGZp
bGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW8uYwo+
IGluZGV4IGQ4OTFiMGEzNTRiMC4uMmVkNmUyNDUxZmQ4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
dmlydGlvL3ZpcnRpby5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvLmMKPiBAQCAtMTY4
LDEyICsxNjgsMTAgQEAgRVhQT1JUX1NZTUJPTF9HUEwodmlydGlvX2FkZF9zdGF0dXMpOwo+ICAg
Cj4gICBzdGF0aWMgaW50IHZpcnRpb19maW5hbGl6ZV9mZWF0dXJlcyhzdHJ1Y3QgdmlydGlvX2Rl
dmljZSAqZGV2KQo+ICAgewo+IC0JaW50IHJldCA9IGRldi0+Y29uZmlnLT5maW5hbGl6ZV9mZWF0
dXJlcyhkZXYpOwo+ICAgCXVuc2lnbmVkIHN0YXR1czsKPiArCWludCByZXQ7Cj4gICAKPiAgIAlt
aWdodF9zbGVlcCgpOwo+IC0JaWYgKHJldCkKPiAtCQlyZXR1cm4gcmV0Owo+ICAgCj4gICAJcmV0
ID0gYXJjaF9oYXNfcmVzdHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2VzcygpOwo+ICAgCWlmIChy
ZXQpIHsKPiBAQCAtMjQ0LDE3ICsyNDIsNiBAQCBzdGF0aWMgaW50IHZpcnRpb19kZXZfcHJvYmUo
c3RydWN0IGRldmljZSAqX2QpCj4gICAJCWRyaXZlcl9mZWF0dXJlc19sZWdhY3kgPSBkcml2ZXJf
ZmVhdHVyZXM7Cj4gICAJfQo+ICAgCj4gLQkvKgo+IC0JICogU29tZSBkZXZpY2VzIGRldGVjdCBs
ZWdhY3kgc29sZWx5IHZpYSBGX1ZFUlNJT05fMS4gV3JpdGUKPiAtCSAqIEZfVkVSU0lPTl8xIHRv
IGZvcmNlIExFIGNvbmZpZyBzcGFjZSBhY2Nlc3NlcyBiZWZvcmUgRkVBVFVSRVNfT0sgZm9yCj4g
LQkgKiB0aGVzZSB3aGVuIG5lZWRlZC4KPiAtCSAqLwo+IC0JaWYgKGRydi0+dmFsaWRhdGUgJiYg
IXZpcnRpb19sZWdhY3lfaXNfbGl0dGxlX2VuZGlhbigpCj4gLQkJCSAgJiYgZGV2aWNlX2ZlYXR1
cmVzICYgQklUX1VMTChWSVJUSU9fRl9WRVJTSU9OXzEpKSB7Cj4gLQkJZGV2LT5mZWF0dXJlcyA9
IEJJVF9VTEwoVklSVElPX0ZfVkVSU0lPTl8xKTsKPiAtCQlkZXYtPmNvbmZpZy0+ZmluYWxpemVf
ZmVhdHVyZXMoZGV2KTsKPiAtCX0KPiAtCj4gICAJaWYgKGRldmljZV9mZWF0dXJlcyAmICgxVUxM
IDw8IFZJUlRJT19GX1ZFUlNJT05fMSkpCj4gICAJCWRldi0+ZmVhdHVyZXMgPSBkcml2ZXJfZmVh
dHVyZXMgJiBkZXZpY2VfZmVhdHVyZXM7Cj4gICAJZWxzZQo+IEBAIC0yNjUsMTAgKzI1MiwyMiBA
QCBzdGF0aWMgaW50IHZpcnRpb19kZXZfcHJvYmUoc3RydWN0IGRldmljZSAqX2QpCj4gICAJCWlm
IChkZXZpY2VfZmVhdHVyZXMgJiAoMVVMTCA8PCBpKSkKPiAgIAkJCV9fdmlydGlvX3NldF9iaXQo
ZGV2LCBpKTsKPiAgIAo+ICsJZXJyID0gZGV2LT5jb25maWctPmZpbmFsaXplX2ZlYXR1cmVzKGRl
dik7Cj4gKwlpZiAoZXJyKQo+ICsJCWdvdG8gZXJyOwo+ICsKPiAgIAlpZiAoZHJ2LT52YWxpZGF0
ZSkgewo+ICsJCXU2NCBmZWF0dXJlcyA9IGRldi0+ZmVhdHVyZXM7Cj4gKwo+ICAgCQllcnIgPSBk
cnYtPnZhbGlkYXRlKGRldik7Cj4gICAJCWlmIChlcnIpCj4gICAJCQlnb3RvIGVycjsKPiArCj4g
KwkJaWYgKGZlYXR1cmVzICE9IGRldi0+ZmVhdHVyZXMpIHsKPiArCQkJZXJyID0gZGV2LT5jb25m
aWctPmZpbmFsaXplX2ZlYXR1cmVzKGRldik7Cj4gKwkJCWlmIChlcnIpCj4gKwkJCQlnb3RvIGVy
cjsKPiArCQl9Cj4gICAJfQo+ICAgCj4gICAJZXJyID0gdmlydGlvX2ZpbmFsaXplX2ZlYXR1cmVz
KGRldik7Cj4gQEAgLTQ5NSw2ICs0OTQsMTAgQEAgaW50IHZpcnRpb19kZXZpY2VfcmVzdG9yZShz
dHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KQo+ICAgCS8qIFdlIGhhdmUgYSBkcml2ZXIhICovCj4g
ICAJdmlydGlvX2FkZF9zdGF0dXMoZGV2LCBWSVJUSU9fQ09ORklHX1NfRFJJVkVSKTsKPiAgIAo+
ICsJcmV0ID0gZGV2LT5jb25maWctPmZpbmFsaXplX2ZlYXR1cmVzKGRldik7Cj4gKwlpZiAocmV0
KQo+ICsJCWdvdG8gZXJyOwoKCklzIHRoaXMgcGFydCBvZiBjb2RlIHJlbGF0ZWQ/CgpUaGFua3MK
Cgo+ICsKPiAgIAlyZXQgPSB2aXJ0aW9fZmluYWxpemVfZmVhdHVyZXMoZGV2KTsKPiAgIAlpZiAo
cmV0KQo+ICAgCQlnb3RvIGVycjsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
