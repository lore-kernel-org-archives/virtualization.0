Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752ECCE7A8E
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 03:34:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1941F813EC;
	Tue, 26 Sep 2023 03:34:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1941F813EC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=agTa3w8R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fH2RgE3N3plP; Tue, 26 Sep 2023 03:34:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7820480E70;
	Tue, 26 Sep 2023 03:34:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7820480E70
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D891C0039;
	Tue, 26 Sep 2023 03:34:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9D03C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B4CA361395
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:34:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B4CA361395
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=agTa3w8R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EMkARO-L7Wav
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:34:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD8C66132B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:34:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD8C66132B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695699272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RLZ2Sm0jXt4JgiR3KwyVKPulSJY09nranm6CqIMSjuQ=;
 b=agTa3w8RJwWoJ6JXZAjrINx5D0AgrQfWxaNMz2hZxUtoVg1eQzQX7H0GIGYZzaL0keidEk
 gSy0j0xT6Q7BAENykDHgMYd33tojZyxeMMwd6z7uQWvX1ubNK6nBX80RTifHp6sLWmUNTq
 cMUKPk0p5aV0pzd20LbJeVhS5TIpLhM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-6XzQEhMdOpSFOghg8SAYbg-1; Mon, 25 Sep 2023 23:34:31 -0400
X-MC-Unique: 6XzQEhMdOpSFOghg8SAYbg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-503269edbb3so10747682e87.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 20:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695699269; x=1696304069;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RLZ2Sm0jXt4JgiR3KwyVKPulSJY09nranm6CqIMSjuQ=;
 b=hkEfKP2NAnQxcXXWyk81bqTMcffAwCE4UR6x1JrieEiEZOOxJb43R6mH3aOjULBFyH
 FJ0m1hpCUPGPjfdW3eIXmOl6C2vED5RZGuMMxbbZ8toqim+E+THr56xqYdyON3H21L6r
 wpJTnHDr4pv6JLOJ20Jc47Z8XXuQdpuZkxEf88MbMQy56XEsnifTxhWIuSZiKbgREYXW
 oDbcitc1w4hzfYCokUSUknW3g6MFyWjbhUKtQ0YPblJTqB7MwQmOhdNWQv7RVRziCaWa
 F+kuCOnuWVx3QHsCgsPJeAL1VfT+hWxwkzhGYgtoQYEXcGUDis9E1yDcZWbV/rIARqyY
 O+DA==
X-Gm-Message-State: AOJu0Yw2g4UqsS1BrjkWpVAD00jDzXQroUnoM9/dUc4ud7Ar0WwZErs9
 9EBdyZqwM0PMoSp9KsQvS1XgsIdsq2D7YCAQgVzMn+zVSVrgt5BBt6DaSHKOiL7l9Dj4UKY1urD
 EZ7ZTljy+4rWo5mREL7qoScQxV1QBk463ZvNXYL2dIVgJ0YetYdjgvpRE2w==
X-Received: by 2002:a19:2d56:0:b0:500:9ab8:b790 with SMTP id
 t22-20020a192d56000000b005009ab8b790mr5797367lft.60.1695699269584; 
 Mon, 25 Sep 2023 20:34:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqiM7aXmdkd2xeWF1oHQRrgm7Uv/ibMILXTfqsfhbYcfRo+PtW2EkI9b5YBS6E53q1EhEpn7fGVgQida+c7dg=
X-Received: by 2002:a19:2d56:0:b0:500:9ab8:b790 with SMTP id
 t22-20020a192d56000000b005009ab8b790mr5797349lft.60.1695699269194; Mon, 25
 Sep 2023 20:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230912130132.561193-1-dtatulea@nvidia.com>
 <20230912130132.561193-9-dtatulea@nvidia.com>
In-Reply-To: <20230912130132.561193-9-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 11:34:18 +0800
Message-ID: <CACGkMEu9axhdajJ2qsjHqrYBX2L7HUqXEXAk3f3X9hv93+iq=w@mail.gmail.com>
Subject: Re: [PATCH 08/16] vdpa/mlx5: Rename mr destroy functions
To: Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>
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

T24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgOTowMuKAr1BNIERyYWdvcyBUYXR1bGVhIDxkdGF0dWxl
YUBudmlkaWEuY29tPiB3cm90ZToKPgo+IE1ha2UgbWx4NV9kZXN0cm95X21yIHN5bW1ldHJpYyB0
byBtbHg1X2NyZWF0ZV9tci4KPgo+IFNpZ25lZC1vZmYtYnk6IERyYWdvcyBUYXR1bGVhIDxkdGF0
dWxlYUBudmlkaWEuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+CgpUaGFua3MKCj4gLS0tCj4gIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgg
fCAgNCArKy0tCj4gIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyAgICAgICAgfCAgNiArKyst
LS0KPiAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jICB8IDEyICsrKysrKy0tLS0t
LQo+ICAzIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmggYi9kcml2
ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCj4gaW5kZXggNTU0ODk5YTgwMjQxLi5lMWU2
ZTdhYmE1MGUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEu
aAo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKPiBAQCAtMTE4LDgg
KzExOCw4IEBAIGludCBtbHg1X3ZkcGFfaGFuZGxlX3NldF9tYXAoc3RydWN0IG1seDVfdmRwYV9k
ZXYgKm12ZGV2LCBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBib29sICpjaGFuZ2VfbWFwLCB1bnNpZ25lZCBpbnQgYXNpZCk7Cj4gIGludCBtbHg1
X3ZkcGFfY3JlYXRlX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IHZob3N0
X2lvdGxiICppb3RsYiwKPiAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgYXNp
ZCk7Cj4gLXZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12
ZGV2KTsKPiAtdm9pZCBtbHg1X3ZkcGFfZGVzdHJveV9tcl9hc2lkKHN0cnVjdCBtbHg1X3ZkcGFf
ZGV2ICptdmRldiwgdW5zaWduZWQgaW50IGFzaWQpOwo+ICt2b2lkIG1seDVfdmRwYV9kZXN0cm95
X21yX3Jlc291cmNlcyhzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpOwo+ICt2b2lkIG1seDVf
dmRwYV9kZXN0cm95X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdW5zaWduZWQgaW50
IGFzaWQpOwo+ICBpbnQgbWx4NV92ZHBhX3VwZGF0ZV9jdnFfaW90bGIoc3RydWN0IG1seDVfdmRw
YV9kZXYgKm12ZGV2LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZo
b3N0X2lvdGxiICppb3RsYiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2ln
bmVkIGludCBhc2lkKTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5j
IGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCj4gaW5kZXggZmRlMDA0OTdmNGFkLi4wMGRj
Y2UxOTBhMWYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCj4gKysr
IGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCj4gQEAgLTUwNyw3ICs1MDcsNyBAQCBzdGF0
aWMgdm9pZCBfbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2
LCB1bnNpZ25lZCBpbnQgYXNpZAo+ICAgICAgICAgbXItPmluaXRpYWxpemVkID0gZmFsc2U7Cj4g
IH0KPgo+IC12b2lkIG1seDVfdmRwYV9kZXN0cm95X21yX2FzaWQoc3RydWN0IG1seDVfdmRwYV9k
ZXYgKm12ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCkKPiArdm9pZCBtbHg1X3ZkcGFfZGVzdHJveV9t
cihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGludCBhc2lkKQo+ICB7Cj4g
ICAgICAgICBzdHJ1Y3QgbWx4NV92ZHBhX21yICptciA9ICZtdmRldi0+bXI7Cj4KPiBAQCAtNTE4
LDkgKzUxOCw5IEBAIHZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXJfYXNpZChzdHJ1Y3QgbWx4NV92
ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGludCBhc2lkKQo+ICAgICAgICAgbXV0ZXhfdW5sb2Nr
KCZtci0+bWtleV9tdHgpOwo+ICB9Cj4KPiAtdm9pZCBtbHg1X3ZkcGFfZGVzdHJveV9tcihzdHJ1
Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpCj4gK3ZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXJfcmVz
b3VyY2VzKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldikKPiAgewo+IC0gICAgICAgbWx4NV92
ZHBhX2Rlc3Ryb3lfbXJfYXNpZChtdmRldiwgbXZkZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBBX0RB
VEFWUV9HUk9VUF0pOwo+ICsgICAgICAgbWx4NV92ZHBhX2Rlc3Ryb3lfbXIobXZkZXYsIG12ZGV2
LT5ncm91cDJhc2lkW01MWDVfVkRQQV9EQVRBVlFfR1JPVVBdKTsKPiAgICAgICAgIHBydW5lX2lv
dGxiKG12ZGV2KTsKPiAgfQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IGluZGV4IDA2
MWQ4ZjdhNjYxYS4uNGQ3NTlhYjk2MzE5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
Ywo+IEBAIC0yNjQ0LDcgKzI2NDQsNyBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9jaGFuZ2VfbWFw
KHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKPiAgICAgICAgICAgICAgICAgZ290byBlcnJf
bXI7Cj4KPiAgICAgICAgIHRlYXJkb3duX2RyaXZlcihuZGV2KTsKPiAtICAgICAgIG1seDVfdmRw
YV9kZXN0cm95X21yX2FzaWQobXZkZXYsIGFzaWQpOwo+ICsgICAgICAgbWx4NV92ZHBhX2Rlc3Ry
b3lfbXIobXZkZXYsIGFzaWQpOwo+ICAgICAgICAgZXJyID0gbWx4NV92ZHBhX2NyZWF0ZV9tciht
dmRldiwgaW90bGIsIGFzaWQpOwo+ICAgICAgICAgaWYgKGVycikKPiAgICAgICAgICAgICAgICAg
Z290byBlcnJfbXI7Cj4gQEAgLTI2NjAsNyArMjY2MCw3IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBh
X2NoYW5nZV9tYXAoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAo+ICAgICAgICAgcmV0dXJu
IDA7Cj4KPiAgZXJyX3NldHVwOgo+IC0gICAgICAgbWx4NV92ZHBhX2Rlc3Ryb3lfbXJfYXNpZCht
dmRldiwgYXNpZCk7Cj4gKyAgICAgICBtbHg1X3ZkcGFfZGVzdHJveV9tcihtdmRldiwgYXNpZCk7
Cj4gIGVycl9tcjoKPiAgICAgICAgIHJldHVybiBlcnI7Cj4gIH0KPiBAQCAtMjc5Nyw3ICsyNzk3
LDcgQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZGV2LCB1OCBzdGF0dXMpCj4gIGVycl9kcml2ZXI6Cj4gICAgICAgICB1bnJlZ2lzdGVyX2xp
bmtfbm90aWZpZXIobmRldik7Cj4gIGVycl9zZXR1cDoKPiAtICAgICAgIG1seDVfdmRwYV9kZXN0
cm95X21yKCZuZGV2LT5tdmRldik7Cj4gKyAgICAgICBtbHg1X3ZkcGFfZGVzdHJveV9tcl9yZXNv
dXJjZXMoJm5kZXYtPm12ZGV2KTsKPiAgICAgICAgIG5kZXYtPm12ZGV2LnN0YXR1cyB8PSBWSVJU
SU9fQ09ORklHX1NfRkFJTEVEOwo+ICBlcnJfY2xlYXI6Cj4gICAgICAgICB1cF93cml0ZSgmbmRl
di0+cmVzbG9jayk7Cj4gQEAgLTI4MjQsNyArMjgyNCw3IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBh
X3Jlc2V0KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPiAgICAgICAgIHVucmVnaXN0ZXJfbGlu
a19ub3RpZmllcihuZGV2KTsKPiAgICAgICAgIHRlYXJkb3duX2RyaXZlcihuZGV2KTsKPiAgICAg
ICAgIGNsZWFyX3Zxc19yZWFkeShuZGV2KTsKPiAtICAgICAgIG1seDVfdmRwYV9kZXN0cm95X21y
KCZuZGV2LT5tdmRldik7Cj4gKyAgICAgICBtbHg1X3ZkcGFfZGVzdHJveV9tcl9yZXNvdXJjZXMo
Jm5kZXYtPm12ZGV2KTsKPiAgICAgICAgIG5kZXYtPm12ZGV2LnN0YXR1cyA9IDA7Cj4gICAgICAg
ICBuZGV2LT5tdmRldi5zdXNwZW5kZWQgPSBmYWxzZTsKPiAgICAgICAgIG5kZXYtPmN1cl9udW1f
dnFzID0gMDsKPiBAQCAtMjk0NCw3ICsyOTQ0LDcgQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX2Zy
ZWUoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+ICAgICAgICAgbmRldiA9IHRvX21seDVfdmRw
YV9uZGV2KG12ZGV2KTsKPgo+ICAgICAgICAgZnJlZV9yZXNvdXJjZXMobmRldik7Cj4gLSAgICAg
ICBtbHg1X3ZkcGFfZGVzdHJveV9tcihtdmRldik7Cj4gKyAgICAgICBtbHg1X3ZkcGFfZGVzdHJv
eV9tcl9yZXNvdXJjZXMobXZkZXYpOwo+ICAgICAgICAgaWYgKCFpc196ZXJvX2V0aGVyX2FkZHIo
bmRldi0+Y29uZmlnLm1hYykpIHsKPiAgICAgICAgICAgICAgICAgcGZtZGV2ID0gcGNpX2dldF9k
cnZkYXRhKHBjaV9waHlzZm4obXZkZXYtPm1kZXYtPnBkZXYpKTsKPiAgICAgICAgICAgICAgICAg
bWx4NV9tcGZzX2RlbF9tYWMocGZtZGV2LCBuZGV2LT5jb25maWcubWFjKTsKPiBAQCAtMzQ3NCw3
ICszNDc0LDcgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfZGV2X2FkZChzdHJ1Y3QgdmRwYV9tZ210
X2RldiAqdl9tZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+ICBlcnJfcmVzMjoKPiAgICAgICAgIGZy
ZWVfcmVzb3VyY2VzKG5kZXYpOwo+ICBlcnJfbXI6Cj4gLSAgICAgICBtbHg1X3ZkcGFfZGVzdHJv
eV9tcihtdmRldik7Cj4gKyAgICAgICBtbHg1X3ZkcGFfZGVzdHJveV9tcl9yZXNvdXJjZXMobXZk
ZXYpOwo+ICBlcnJfcmVzOgo+ICAgICAgICAgbWx4NV92ZHBhX2ZyZWVfcmVzb3VyY2VzKCZuZGV2
LT5tdmRldik7Cj4gIGVycl9tcGZzOgo+IC0tCj4gMi40MS4wCj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
