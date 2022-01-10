Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2663C433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 06:14:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6433460BCD;
	Mon, 10 Jan 2022 06:14:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id btc5H1sG8EaN; Mon, 10 Jan 2022 06:14:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F192960B87;
	Mon, 10 Jan 2022 06:14:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C94DBC002F;
	Mon, 10 Jan 2022 06:14:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED8D5C001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D5EA8826EA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:14:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vZvgI00dcLsx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:14:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DDA1A826E7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641795265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jgXD4sawCttacEEpkCSathegDH0wVsgBeAverivRcnY=;
 b=O4NobWA5cqzAs0+x+drdFv9R7XSoukPQuiGLSb6g2meDAxgkGyQnjAwzdtwoBMisB518fa
 6cLIIBSAtboozFqqOP/z1iU2bFab2KtM0Set3Pkj8Lc1yOcCZILiqCGk5Y+CMP/3u8JHwO
 pRk6okRiAyjgCts0POxvvTXcHe4z8KQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-yjQELUl4M-2GrMPEJQkYvg-1; Mon, 10 Jan 2022 01:14:23 -0500
X-MC-Unique: yjQELUl4M-2GrMPEJQkYvg-1
Received: by mail-pj1-f72.google.com with SMTP id
 62-20020a17090a0fc400b001b31e840054so13284279pjz.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 09 Jan 2022 22:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=jgXD4sawCttacEEpkCSathegDH0wVsgBeAverivRcnY=;
 b=nZMNb4KpRn1gIHauvaeQ8ZAxavd9RUhc/ljOiOiomquA7qVlcY89DXov7Oow7fKWCy
 k/Aa4EDp2axcPxaNtFNmmOeiJ8pe6eczOO3oiZbt10U7J8kigoIC54e9TFZ/3qhC+TGC
 2mrKmjJ2z7RzsFlCrDYcINqKNeJztaDGcO9rgz2RUNDkC6hmAtbfi8ZzFGQKA3vYrU89
 YZ3stzJ0Zd9L32/4orB34mxppkBmxUvg7DiGAdePauz97drXEL2Fb5vnRHqQRZPlb0jW
 OJW+g/BuM+PV2r3TkKwPcZlBNLDmQGnbX9cZsaU4qzlt7xPneon8+6Cqs0UEiMjF/WWy
 9b4Q==
X-Gm-Message-State: AOAM5331057VsR25NN7lKeQo73VDvXsS+LDZdv6pzuXFbnhp98IcuRYq
 A4rk376YeRq7Uv29MCsJiX6HmvP6mXrcpBBo2nfxf568S6kF8vTIA7ILNQ7ywlvg1Kb57Ks2E9Z
 U+GWwzI/os3j9kDgYpDBLmGXD/8VNFIHegk+zSXW38A==
X-Received: by 2002:a17:90a:8b04:: with SMTP id
 y4mr10015930pjn.32.1641795261891; 
 Sun, 09 Jan 2022 22:14:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4aPgQKlyDy297NQKXLejUdh9aMnuu1RHCa90y9sWogZhI8ZRQVJ4x/vhe9gBjqQSTC8GRLg==
X-Received: by 2002:a17:90a:8b04:: with SMTP id
 y4mr10015911pjn.32.1641795261619; 
 Sun, 09 Jan 2022 22:14:21 -0800 (PST)
Received: from [10.72.13.131] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id nu18sm8133017pjb.15.2022.01.09.22.14.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jan 2022 22:14:20 -0800 (PST)
Message-ID: <42ba2840-bfa8-d530-4bcf-3eeee9403a31@redhat.com>
Date: Mon, 10 Jan 2022 14:14:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] virtio: Simplify DMA setting
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, mst@redhat.com
References: <fc97319a44d41d8b7eb127e1facdef4139ed77ac.1641625657.git.christophe.jaillet@wanadoo.fr>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <fc97319a44d41d8b7eb127e1facdef4139ed77ac.1641625657.git.christophe.jaillet@wanadoo.fr>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzEvOCDkuIvljYgzOjA4LCBDaHJpc3RvcGhlIEpBSUxMRVQg5YaZ6YGTOgo+IEFz
IHN0YXRlZCBpbiBbMV0sIGRtYV9zZXRfbWFzaygpIHdpdGggYSA2NC1iaXQgbWFzayB3aWxsIG5l
dmVyIGZhaWwgaWYKPiBkZXYtPmRtYV9tYXNrIGlzIG5vbi1OVUxMLgo+IFNvLCBpZiBpdCBmYWls
cywgdGhlIDMyIGJpdHMgY2FzZSB3aWxsIGFsc28gZmFpbCBmb3IgdGhlIHNhbWUgcmVhc29uLgoK
CkknZCBleHBlY3QgdG8gYmUgbW9yZSB2ZXJib3NlIGhlcmUuIEUuZyBJIHNlZSBkbWFfc3VwcG9y
dGVkKCkgd2hvIGhhcyBhIApicnVuY2ggb2YgY2hlY2tzIG5lZWQgdG8gYmUgY2FsbGVkIGlmIGRt
YV9tYXNrIGlzIG5vbi1OVUxMLgoKVGhhbmtzCgoKPgo+IFNpbXBsaWZ5IGNvZGUgYW5kIHJlbW92
ZSBzb21lIGRlYWQgY29kZSBhY2NvcmRpbmdseS4KPgo+Cj4gV2hpbGUgYXQgaXQsIGluY2x1ZGUg
ZGlyZWN0bHkgPGxpbnV4L2RtYS1tYXBwaW5nLmg+IGluc3RlYWQgb24gcmVseWluZyBvbgo+IGlu
ZGlyZWN0IGluY2x1c2lvbi4KPgo+IFsxXTogaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjEvNi83
LzM5OAo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoZSBKQUlMTEVUIDxjaHJpc3RvcGhlLmph
aWxsZXRAd2FuYWRvby5mcj4KPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19tbWlvLmMg
ICAgICAgICAgIHwgNCArLS0tCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeV9k
ZXYuYyB8IDcgKysrLS0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2
LmMgfCA2ICsrLS0tLQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDExIGRl
bGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tbWlvLmMg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jCj4gaW5kZXggNTYxMjhiOWM0NmViLi5hYTFl
ZmE4NTRkZTEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX21taW8uYwo+ICsr
KyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tbWlvLmMKPiBAQCAtNjE3LDkgKzYxNyw3IEBAIHN0
YXRpYyBpbnQgdmlydGlvX21taW9fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikK
PiAgIAkJcmMgPSBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KCZwZGV2LT5kZXYsIERNQV9CSVRf
TUFTSyg2NCkpOwo+ICAgCX0KPiAgIAlpZiAocmMpCj4gLQkJcmMgPSBkbWFfc2V0X21hc2tfYW5k
X2NvaGVyZW50KCZwZGV2LT5kZXYsIERNQV9CSVRfTUFTSygzMikpOwo+IC0JaWYgKHJjKQo+IC0J
CWRldl93YXJuKCZwZGV2LT5kZXYsICJGYWlsZWQgdG8gZW5hYmxlIDY0LWJpdCBvciAzMi1iaXQg
RE1BLiAgVHJ5aW5nIHRvIGNvbnRpbnVlLCBidXQgdGhpcyBtaWdodCBub3Qgd29yay5cbiIpOwo+
ICsJCWRldl93YXJuKCZwZGV2LT5kZXYsICJGYWlsZWQgdG8gZW5hYmxlIERNQS4gIFRyeWluZyB0
byBjb250aW51ZSwgYnV0IHRoaXMgbWlnaHQgbm90IHdvcmsuXG4iKTsKPiAgIAo+ICAgCXBsYXRm
b3JtX3NldF9kcnZkYXRhKHBkZXYsIHZtX2Rldik7Cj4gICAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3lfZGV2LmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpX2xlZ2FjeV9kZXYuYwo+IGluZGV4IDY3N2QxZjY4YmM5Yi4uNTJiMWM0ZGQ0M2ZlIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5X2Rldi5jCj4gKysrIGIv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3lfZGV2LmMKPiBAQCAtMiw2ICsyLDcgQEAK
PiAgIAo+ICAgI2luY2x1ZGUgImxpbnV4L3ZpcnRpb19wY2kuaCIKPiAgICNpbmNsdWRlIDxsaW51
eC92aXJ0aW9fcGNpX2xlZ2FjeS5oPgo+ICsjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4K
PiAgICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KPiAgICNpbmNsdWRlIDxsaW51eC9wY2kuaD4K
PiAgIAo+IEBAIC0yNiw5ICsyNyw3IEBAIGludCB2cF9sZWdhY3lfcHJvYmUoc3RydWN0IHZpcnRp
b19wY2lfbGVnYWN5X2RldmljZSAqbGRldikKPiAgIAkJcmV0dXJuIC1FTk9ERVY7Cj4gICAKPiAg
IAlyYyA9IGRtYV9zZXRfbWFzaygmcGNpX2Rldi0+ZGV2LCBETUFfQklUX01BU0soNjQpKTsKPiAt
CWlmIChyYykgewo+IC0JCXJjID0gZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudCgmcGNpX2Rldi0+
ZGV2LCBETUFfQklUX01BU0soMzIpKTsKPiAtCX0gZWxzZSB7Cj4gKwlpZiAoIXJjKSB7Cj4gICAJ
CS8qCj4gICAJCSAqIFRoZSB2aXJ0aW8gcmluZyBiYXNlIGFkZHJlc3MgaXMgZXhwcmVzc2VkIGFz
IGEgMzItYml0IFBGTiwKPiAgIAkJICogd2l0aCBhIHBhZ2Ugc2l6ZSBvZiAxIDw8IFZJUlRJT19Q
Q0lfUVVFVUVfQUREUl9TSElGVC4KPiBAQCAtMzgsNyArMzcsNyBAQCBpbnQgdnBfbGVnYWN5X3By
b2JlKHN0cnVjdCB2aXJ0aW9fcGNpX2xlZ2FjeV9kZXZpY2UgKmxkZXYpCj4gICAJfQo+ICAgCj4g
ICAJaWYgKHJjKQo+IC0JCWRldl93YXJuKCZwY2lfZGV2LT5kZXYsICJGYWlsZWQgdG8gZW5hYmxl
IDY0LWJpdCBvciAzMi1iaXQgRE1BLiAgVHJ5aW5nIHRvIGNvbnRpbnVlLCBidXQgdGhpcyBtaWdo
dCBub3Qgd29yay5cbiIpOwo+ICsJCWRldl93YXJuKCZwY2lfZGV2LT5kZXYsICJGYWlsZWQgdG8g
ZW5hYmxlIERNQS4gIFRyeWluZyB0byBjb250aW51ZSwgYnV0IHRoaXMgbWlnaHQgbm90IHdvcmsu
XG4iKTsKPiAgIAo+ICAgCXJjID0gcGNpX3JlcXVlc3RfcmVnaW9uKHBjaV9kZXYsIDAsICJ2aXJ0
aW8tcGNpLWxlZ2FjeSIpOwo+ICAgCWlmIChyYykKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21v
ZGVybl9kZXYuYwo+IGluZGV4IGU4YjNmZjJiOWZiYy4uODMwZGMyNjlkNjhmIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuX2Rldi5jCj4gKysrIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMKPiBAQCAtMSw2ICsxLDcgQEAKPiAgIC8v
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4gICAKPiAgICNpbmNs
dWRlIDxsaW51eC92aXJ0aW9fcGNpX21vZGVybi5oPgo+ICsjaW5jbHVkZSA8bGludXgvZG1hLW1h
cHBpbmcuaD4KPiAgICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KPiAgICNpbmNsdWRlIDxsaW51
eC9wY2kuaD4KPiAgIAo+IEBAIC0yNTYsMTAgKzI1Nyw3IEBAIGludCB2cF9tb2Rlcm5fcHJvYmUo
c3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAqbWRldikKPiAgIAo+ICAgCWVyciA9IGRt
YV9zZXRfbWFza19hbmRfY29oZXJlbnQoJnBjaV9kZXYtPmRldiwgRE1BX0JJVF9NQVNLKDY0KSk7
Cj4gICAJaWYgKGVycikKPiAtCQllcnIgPSBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KCZwY2lf
ZGV2LT5kZXYsCj4gLQkJCQkJCURNQV9CSVRfTUFTSygzMikpOwo+IC0JaWYgKGVycikKPiAtCQlk
ZXZfd2FybigmcGNpX2Rldi0+ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSA2NC1iaXQgb3IgMzItYml0
IERNQS4gIFRyeWluZyB0byBjb250aW51ZSwgYnV0IHRoaXMgbWlnaHQgbm90IHdvcmsuXG4iKTsK
PiArCQlkZXZfd2FybigmcGNpX2Rldi0+ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBETUEuICBUcnlp
bmcgdG8gY29udGludWUsIGJ1dCB0aGlzIG1pZ2h0IG5vdCB3b3JrLlxuIik7Cj4gICAKPiAgIAkv
KiBEZXZpY2UgY2FwYWJpbGl0eSBpcyBvbmx5IG1hbmRhdG9yeSBmb3IgZGV2aWNlcyB0aGF0IGhh
dmUKPiAgIAkgKiBkZXZpY2Utc3BlY2lmaWMgY29uZmlndXJhdGlvbi4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
