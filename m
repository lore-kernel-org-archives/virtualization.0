Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED4CC04A95
	for <virtualization@archiver.kernel.org>; Wed, 28 Sep 2022 04:04:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B45AF60B57;
	Wed, 28 Sep 2022 04:04:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B45AF60B57
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fGx0uNKm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HNMk0Gb8NDcv; Wed, 28 Sep 2022 04:04:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2D709607F4;
	Wed, 28 Sep 2022 04:04:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D709607F4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08F65C0032;
	Wed, 28 Sep 2022 04:04:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3DF7C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 04:04:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8199860B48
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 04:04:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8199860B48
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xfn_JS11M4w2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 04:04:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2878607F4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2878607F4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 04:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664337891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZCmVV4/17mv21GMTdNuSAm0jpU/hXvj1/osgjLA5Mc=;
 b=fGx0uNKmcHCFsIhmZnEQDI/cwpsGfi0jwNhihXVIKLr+FFzT3Vz9pIJ2GQZsCJ3HAL+NTm
 pCWMRnMVbwSD6Rv+SIUP/8DiWA4A/PDF9bdiXquySvdLjIUcjns61BnA+HaxMh164atMRd
 r9Vy7EtzA5GJ/UlHg7mE+C08x7wmZZk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-26-y8yMRiU2OT6mUIEIvEkYTQ-1; Wed, 28 Sep 2022 00:04:50 -0400
X-MC-Unique: y8yMRiU2OT6mUIEIvEkYTQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 p24-20020a05600c1d9800b003b4b226903dso464015wms.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 21:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date;
 bh=IZCmVV4/17mv21GMTdNuSAm0jpU/hXvj1/osgjLA5Mc=;
 b=lH0JIcEZBUsjp5t0EUkuHrmghPlH777kBy/JPW/0JPMz3xTT935nYg7JjUPONxFHZo
 Ac8s1xKj7aObq3GcydXCTsRjBnalYOuUHG3a1qLJvfvi5FroOjH+nOsH//yde5zeCcWN
 yb/pr1HKOLZPyPZqoDV4x1V8IV+u3GUSRXI8Xt00Jnt7Pbtwc7ge2yEQgCbynKbu7/GF
 SdW16ITRKVfeuDAsH/4YO24r30Dh3PTq9aPxG4E7zqo/uIum300POEIyIra2NABtXyTg
 qNeKawBbMJDD++yA9kGfnqm3frvFImbDNH4+gGtQW41xlze9dIv5c+4+P84iTiPlpq35
 afyg==
X-Gm-Message-State: ACrzQf2NvJwTgUU5sCJYMGpF3J2SazAt12s3bpzQMnO02ZBiaqUkwSek
 7BuPdjeZrsntOuRD22E+hsRW1ioWJUdCv1RKINlZRUINKV6rJN7w4nbFE2wDs+d4bk7mYT1oS80
 D3QI8qe/QxUdeVmFz/dk3MnfzEpmkJZiFZOzztiRznQ==
X-Received: by 2002:a05:6000:156b:b0:22a:a83a:d349 with SMTP id
 11-20020a056000156b00b0022aa83ad349mr19384861wrz.277.1664337889047; 
 Tue, 27 Sep 2022 21:04:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6j10sncy6xaso+VwGsPpFDZwxVXN5J/5wQwepc7moFHObh2SfrjMHSOsx5i3wneOkOpeVlkQ==
X-Received: by 2002:a05:6000:156b:b0:22a:a83a:d349 with SMTP id
 11-20020a056000156b00b0022aa83ad349mr19384849wrz.277.1664337888795; 
 Tue, 27 Sep 2022 21:04:48 -0700 (PDT)
Received: from redhat.com ([2.55.47.213]) by smtp.gmail.com with ESMTPSA id
 k9-20020a5d6289000000b00226dfac0149sm3017721wru.114.2022.09.27.21.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Sep 2022 21:04:48 -0700 (PDT)
Date: Wed, 28 Sep 2022 00:04:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bo Liu =?utf-8?B?KOWImOazoikt5rWq5r2u5L+h5oGv?= <liubo03@inspur.com>
Subject: Re: [PATCH] virtio_ring: remove unnecessary to_vvq() call
Message-ID: <20220928000342-mutt-send-email-mst@kernel.org>
References: <4366e621c74e46bfa642d6802187ad44@inspur.com>
MIME-Version: 1.0
In-Reply-To: <4366e621c74e46bfa642d6802187ad44@inspur.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

T24gV2VkLCBTZXAgMjgsIDIwMjIgYXQgMDI6MjY6MTZBTSArMDAwMCwgQm8gTGl1ICjliJjms6Ip
Lea1qua9ruS/oeaBryB3cm90ZToKPiA+T24gTW9uLCBTZXAgMjYsIDIwMjIgYXQgMDU6MTE6MzBB
TSAtMDQwMCwgQm8gTGl1IHdyb3RlOgo+ID4+IEl0IHBhc3NlcyAnX3ZxJyB0byB2cmluZ19mcmVl
KCksIHdoaWNoIHN0aWxsIGNhbGxzIHRvX3Z2cSgpIHRvIGdldAo+ID4+ICd2cScsIGxldCdzIGRp
cmVjdGx5IHBhc3MgJ3ZxJy4gSXQgY2FuIGF2b2lkIHVubmVjZXNzYXJ5IGNhbGwgb2YKPiA+PiB0
b192dnEoKSBpbiBob3QgcGF0aC4KPiA+Pgo+ID4+IFNpZ25lZC1vZmYtYnk6IEJvIExpdSA8bGl1
Ym8wM0BpbnNwdXIuY29tPgo+ID4KPiA+V2hhdCBpcyB0aGUgcG9pbnQgb2YgdGhpcyBjaGFuZ2U/
Cj4gPgo+ID5fX3ZyaW5nX25ld192aXJ0cXVldWUgcmV0dXJucyBzdHJ1Y3QgdmlydHF1ZXVlICos
IHNvIHZyaW5nX2ZyZWUgbWF0Y2hlcwo+IHRoYXQuCj4gPk5vPwo+ID4KPiAKPiBIaQo+IEluIGZ1
bmN0aW9uIHZyaW5nX2ZyZWUoKSwgdG9fdnZxKCkganMgdW5uZWNlc3NhcnksIHdlIGNhbiBkaXJl
Y3RseSBwYXNzCj4gc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqIHRvIGF2b2lkIHRoaXMgYW5kIHJl
bW92ZSB0aGUgdW5uZWNlc3NhcnkgY29kZS4KCkFuZCBzbz8gSXMgdGhlIHJlc3VsdGluZyBiaW5h
cnkgc21hbGxlcj8KCj4gPj4gLS0tCj4gPj4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMg
fCAxMiArKysrKy0tLS0tLS0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwg
NyBkZWxldGlvbnMoLSkKPiA+Pgo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcmluZy5jCj4gPj4gYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGluZGV4IDg5NzRj
MzRiNDBmZC4uZDZkNzdiZjU4ODAyIDEwMDY0NAo+ID4+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMKPiA+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPj4g
QEAgLTIyMSw3ICsyMjEsNyBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZQo+ID4qX192cmluZ19u
ZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiA+PiAgCQkJCQkgICAgICAgdm9pZCAo
KmNhbGxiYWNrKShzdHJ1Y3QKPiB2aXJ0cXVldWUgKiksCj4gPj4gIAkJCQkJICAgICAgIGNvbnN0
IGNoYXIgKm5hbWUpOwo+ID4+ICBzdGF0aWMgc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKnZyaW5n
X2FsbG9jX2Rlc2NfZXh0cmEodW5zaWduZWQgaW50Cj4gPj4gbnVtKTsgLXN0YXRpYyB2b2lkIHZy
aW5nX2ZyZWUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKTsKPiA+PiArc3RhdGljIHZvaWQgdnJpbmdf
ZnJlZShzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSk7Cj4gPj4KPiA+PiAgLyoKPiA+PiAgICog
SGVscGVycy4KPiA+PiBAQCAtMTE0MCw3ICsxMTQwLDcgQEAgc3RhdGljIGludCB2aXJ0cXVldWVf
cmVzaXplX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUKPiA+Kl92cSwgdTMyIG51bSkKPiA+PiAgCWlm
IChlcnIpCj4gPj4gIAkJZ290byBlcnJfc3RhdGVfZXh0cmE7Cj4gPj4KPiA+PiAtCXZyaW5nX2Zy
ZWUoJnZxLT52cSk7Cj4gPj4gKwl2cmluZ19mcmVlKHZxKTsKPiA+Pgo+ID4+ICAJdmlydHF1ZXVl
X3ZyaW5nX2luaXRfc3BsaXQoJnZyaW5nX3NwbGl0LCB2cSk7Cj4gPj4KPiA+PiBAQCAtMjA1OSw3
ICsyMDU5LDcgQEAgc3RhdGljIGludCB2aXJ0cXVldWVfcmVzaXplX3BhY2tlZChzdHJ1Y3Qgdmly
dHF1ZXVlCj4gPipfdnEsIHUzMiBudW0pCj4gPj4gIAlpZiAoZXJyKQo+ID4+ICAJCWdvdG8gZXJy
X3N0YXRlX2V4dHJhOwo+ID4+Cj4gPj4gLQl2cmluZ19mcmVlKCZ2cS0+dnEpOwo+ID4+ICsJdnJp
bmdfZnJlZSh2cSk7Cj4gPj4KPiA+PiAgCXZpcnRxdWV1ZV92cmluZ19pbml0X3BhY2tlZCgmdnJp
bmdfcGFja2VkLCAhIXZxLT52cS5jYWxsYmFjayk7Cj4gPj4KPiA+PiBAQCAtMjY0OSwxMCArMjY0
OSw4IEBAIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQKPiA+
PiBpbnQgaW5kZXgsICB9ICBFWFBPUlRfU1lNQk9MX0dQTCh2cmluZ19uZXdfdmlydHF1ZXVlKTsK
PiA+Pgo+ID4+IC1zdGF0aWMgdm9pZCB2cmluZ19mcmVlKHN0cnVjdCB2aXJ0cXVldWUgKl92cSkK
PiA+PiArc3RhdGljIHZvaWQgdnJpbmdfZnJlZShzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSkK
PiA+PiAgewo+ID4+IC0Jc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsK
PiA+PiAtCj4gPj4gIAlpZiAodnEtPndlX293bl9yaW5nKSB7Cj4gPj4gIAkJaWYgKHZxLT5wYWNr
ZWRfcmluZykgewo+ID4+ICAJCQl2cmluZ19mcmVlX3F1ZXVlKHZxLT52cS52ZGV2LAo+ID4+IEBA
IC0yNjkzLDcgKzI2OTEsNyBAQCB2b2lkIHZyaW5nX2RlbF92aXJ0cXVldWUoc3RydWN0IHZpcnRx
dWV1ZSAqX3ZxKQo+ID4+ICAJbGlzdF9kZWwoJl92cS0+bGlzdCk7Cj4gPj4gIAlzcGluX3VubG9j
aygmdnEtPnZxLnZkZXYtPnZxc19saXN0X2xvY2spOwo+ID4+Cj4gPj4gLQl2cmluZ19mcmVlKF92
cSk7Cj4gPj4gKwl2cmluZ19mcmVlKHZxKTsKPiA+Pgo+ID4+ICAJa2ZyZWUodnEpOwo+ID4+ICB9
Cj4gPj4gLS0KPiA+PiAyLjI3LjAKPiAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
