Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D74C74A44
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 05:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 532AE4185F;
	Tue, 14 Mar 2023 05:31:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 532AE4185F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XMy8TV/0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YrO8Pyij1bPK; Tue, 14 Mar 2023 05:31:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4B06D4185E;
	Tue, 14 Mar 2023 05:31:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B06D4185E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23F36C0035;
	Tue, 14 Mar 2023 05:31:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66A1BC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 05:31:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4244261007
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 05:31:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4244261007
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XMy8TV/0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kOahu9k1YmAA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 05:31:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A088606E6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A088606E6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 05:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678771912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jyUBoPolIWIdJ1iODF+bsaf4nIiYQ/NV9Gc2xnehBsk=;
 b=XMy8TV/0C8cGhfMaFvJBQYNiFKbh4tNqTEyyDitII74+my8KZPGEIRh1/zmvRH51GkxgmS
 qac0Fw2LXCN+pqvErgoAjN9REp5XTZLmf7OvrnsfFBKL4FZiQ1nMrAkS9+k8gJ7YkwLSMX
 kyjkcJpwQaTL9aR2xRwBqQjDQca8g3E=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-26ig3kRTOfCeP1igB6c_eg-1; Tue, 14 Mar 2023 01:31:50 -0400
X-MC-Unique: 26ig3kRTOfCeP1igB6c_eg-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-17270774b8fso8484813fac.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 22:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678771909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jyUBoPolIWIdJ1iODF+bsaf4nIiYQ/NV9Gc2xnehBsk=;
 b=S6ninl/R6tjl6cXnnU3YB3uPCzgXNV3O0K5ZOIWirWgDdZ3zHWFeVpa549+YrfqLtx
 gCB2S3ztHfIuB+FctI5EeaxZ9m9A19aknjvyDnRQjD9wnkancHwePSpyqR21hxHPCt9j
 JLPIS88OEmD+BtCrkEWzUV64W05kpck8F0otu1Vy97HbQ9TTatNFnmoATzQaQNRj4w5C
 z7P2AL8DufFGPK1bgruPZL1/xE3EsPwaIsLP759y9SFJMYutC12aEt31L3urZOrB1Vm2
 bvLC7jgR+wj2M7DnvpZ0R7zjEzzlObPn+UIgG+XVE0sgZKgJO39BC52DcFXdwkkHibJX
 ggZA==
X-Gm-Message-State: AO0yUKW13ErHA6tkRJo4g+CgkJR+ek6XzlAWQwTttEvgLS0ubqoUGcAB
 SlIFTkFaJPRhigTVlPxlVr0jhaZLyfmkbmwZicOduVeeFiueYYkstY7CGw831xU2tliNLAgSv+d
 5h/p+PPPFkRf9203Yqv7JHiu48sv4XOPlOJmn3wYhycEt3wbhx4Y4tLc0xFzgr0xTKz9F
X-Received: by 2002:a05:6870:1110:b0:17a:adbe:2ba4 with SMTP id
 16-20020a056870111000b0017aadbe2ba4mr206963oaf.9.1678771909520; 
 Mon, 13 Mar 2023 22:31:49 -0700 (PDT)
X-Google-Smtp-Source: AK7set/6fO95dK426XWuh5jUuIFpmqvpj5E0M3mNetmj/iPdAKEwidMc3TkD2je67h5nibAYAxs+plvrkjI57ZStLJc=
X-Received: by 2002:a05:6870:1110:b0:17a:adbe:2ba4 with SMTP id
 16-20020a056870111000b0017aadbe2ba4mr206950oaf.9.1678771909283; Mon, 13 Mar
 2023 22:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230302113421.174582-1-sgarzare@redhat.com>
 <20230302113421.174582-7-sgarzare@redhat.com>
In-Reply-To: <20230302113421.174582-7-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Mar 2023 13:31:38 +0800
Message-ID: <CACGkMEt8VY-udr=5e9SUJ+Wt+TBVvfPgWuMUDC550VybtSngVQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] vdpa_sim: use kthread worker
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

T24gVGh1LCBNYXIgMiwgMjAyMyBhdCA3OjM14oCvUE0gU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2Fy
emFyZUByZWRoYXQuY29tPiB3cm90ZToKPgo+IExldCdzIHVzZSBvdXIgb3duIGt0aHJlYWQgdG8g
cnVuIGRldmljZSBqb2JzLgo+IFRoaXMgYWxsb3dzIHVzIG1vcmUgZmxleGliaWxpdHksIGVzcGVj
aWFsbHkgd2UgY2FuIGF0dGFjaCB0aGUga3RocmVhZAo+IHRvIHRoZSB1c2VyIGFkZHJlc3Mgc3Bh
Y2Ugd2hlbiB2RFBBIHVzZXMgdXNlcidzIFZBLgo+Cj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBH
YXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGph
c293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCgoKPiAtLS0KPiAgZHJpdmVycy92ZHBhL3ZkcGFf
c2ltL3ZkcGFfc2ltLmggfCAgMyArKy0KPiAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2lt
LmMgfCAxNyArKysrKysrKysrKystLS0tLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFf
c2ltL3ZkcGFfc2ltLmggYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uaAo+IGluZGV4
IGFjZWUyMGZhYWY2YS4uY2U4M2Y5MTMwYTVkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92
ZHBhX3NpbS92ZHBhX3NpbS5oCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2lt
LmgKPiBAQCAtNTcsNyArNTcsOCBAQCBzdHJ1Y3QgdmRwYXNpbV9kZXZfYXR0ciB7Cj4gIHN0cnVj
dCB2ZHBhc2ltIHsKPiAgICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSB2ZHBhOwo+ICAgICAgICAg
c3RydWN0IHZkcGFzaW1fdmlydHF1ZXVlICp2cXM7Cj4gLSAgICAgICBzdHJ1Y3Qgd29ya19zdHJ1
Y3Qgd29yazsKPiArICAgICAgIHN0cnVjdCBrdGhyZWFkX3dvcmtlciAqd29ya2VyOwo+ICsgICAg
ICAgc3RydWN0IGt0aHJlYWRfd29yayB3b3JrOwo+ICAgICAgICAgc3RydWN0IHZkcGFzaW1fZGV2
X2F0dHIgZGV2X2F0dHI7Cj4gICAgICAgICAvKiBzcGlubG9jayB0byBzeW5jaHJvbml6ZSB2aXJ0
cXVldWUgc3RhdGUgKi8KPiAgICAgICAgIHNwaW5sb2NrX3QgbG9jazsKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0v
dmRwYV9zaW0uYwo+IGluZGV4IGE2ZWU4MzBlZmMzOC4uNmZlYjI5NzI2YzJhIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gKysrIGIvZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiBAQCAtMTEsOCArMTEsOCBAQAo+ICAjaW5jbHVkZSA8bGlu
dXgvbW9kdWxlLmg+Cj4gICNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4KPiAgI2luY2x1ZGUgPGxp
bnV4L2tlcm5lbC5oPgo+ICsjaW5jbHVkZSA8bGludXgva3RocmVhZC5oPgo+ICAjaW5jbHVkZSA8
bGludXgvc2xhYi5oPgo+IC0jaW5jbHVkZSA8bGludXgvc2NoZWQuaD4KPiAgI2luY2x1ZGUgPGxp
bnV4L2RtYS1tYXAtb3BzLmg+Cj4gICNpbmNsdWRlIDxsaW51eC92cmluZ2guaD4KPiAgI2luY2x1
ZGUgPGxpbnV4L3ZkcGEuaD4KPiBAQCAtMTE2LDcgKzExNiw3IEBAIHN0YXRpYyB2b2lkIHZkcGFz
aW1fZG9fcmVzZXQoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0pCj4gIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgdmRwYV9jb25maWdfb3BzIHZkcGFzaW1fY29uZmlnX29wczsKPiAgc3RhdGljIGNvbnN0IHN0
cnVjdCB2ZHBhX2NvbmZpZ19vcHMgdmRwYXNpbV9iYXRjaF9jb25maWdfb3BzOwo+Cj4gLXN0YXRp
YyB2b2lkIHZkcGFzaW1fd29ya19mbihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4gK3N0YXRp
YyB2b2lkIHZkcGFzaW1fd29ya19mbihzdHJ1Y3Qga3RocmVhZF93b3JrICp3b3JrKQo+ICB7Cj4g
ICAgICAgICBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSA9IGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1
Y3QgdmRwYXNpbSwgd29yayk7Cj4KPiBAQCAtMTU5LDcgKzE1OSwxMyBAQCBzdHJ1Y3QgdmRwYXNp
bSAqdmRwYXNpbV9jcmVhdGUoc3RydWN0IHZkcGFzaW1fZGV2X2F0dHIgKmRldl9hdHRyLAo+Cj4g
ICAgICAgICB2ZHBhc2ltID0gdmRwYV90b19zaW0odmRwYSk7Cj4gICAgICAgICB2ZHBhc2ltLT5k
ZXZfYXR0ciA9ICpkZXZfYXR0cjsKPiAtICAgICAgIElOSVRfV09SSygmdmRwYXNpbS0+d29yaywg
dmRwYXNpbV93b3JrX2ZuKTsKPiArCj4gKyAgICAgICBrdGhyZWFkX2luaXRfd29yaygmdmRwYXNp
bS0+d29yaywgdmRwYXNpbV93b3JrX2ZuKTsKPiArICAgICAgIHZkcGFzaW0tPndvcmtlciA9IGt0
aHJlYWRfY3JlYXRlX3dvcmtlcigwLCAidkRQQSBzaW0gd29ya2VyOiAlcyIsCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2X2F0dHItPm5hbWUpOwo+
ICsgICAgICAgaWYgKElTX0VSUih2ZHBhc2ltLT53b3JrZXIpKQo+ICsgICAgICAgICAgICAgICBn
b3RvIGVycl9pb21tdTsKPiArCj4gICAgICAgICBzcGluX2xvY2tfaW5pdCgmdmRwYXNpbS0+bG9j
ayk7Cj4gICAgICAgICBzcGluX2xvY2tfaW5pdCgmdmRwYXNpbS0+aW9tbXVfbG9jayk7Cj4KPiBA
QCAtMjEyLDcgKzIxOCw3IEBAIEVYUE9SVF9TWU1CT0xfR1BMKHZkcGFzaW1fY3JlYXRlKTsKPgo+
ICB2b2lkIHZkcGFzaW1fc2NoZWR1bGVfd29yayhzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSkKPiAg
ewo+IC0gICAgICAgc2NoZWR1bGVfd29yaygmdmRwYXNpbS0+d29yayk7Cj4gKyAgICAgICBrdGhy
ZWFkX3F1ZXVlX3dvcmsodmRwYXNpbS0+d29ya2VyLCAmdmRwYXNpbS0+d29yayk7Cj4gIH0KPiAg
RVhQT1JUX1NZTUJPTF9HUEwodmRwYXNpbV9zY2hlZHVsZV93b3JrKTsKPgo+IEBAIC02MTIsNyAr
NjE4LDggQEAgc3RhdGljIHZvaWQgdmRwYXNpbV9mcmVlKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRw
YSkKPiAgICAgICAgIHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltID0gdmRwYV90b19zaW0odmRwYSk7
Cj4gICAgICAgICBpbnQgaTsKPgo+IC0gICAgICAgY2FuY2VsX3dvcmtfc3luYygmdmRwYXNpbS0+
d29yayk7Cj4gKyAgICAgICBrdGhyZWFkX2NhbmNlbF93b3JrX3N5bmMoJnZkcGFzaW0tPndvcmsp
Owo+ICsgICAgICAga3RocmVhZF9kZXN0cm95X3dvcmtlcih2ZHBhc2ltLT53b3JrZXIpOwo+Cj4g
ICAgICAgICBmb3IgKGkgPSAwOyBpIDwgdmRwYXNpbS0+ZGV2X2F0dHIubnZxczsgaSsrKSB7Cj4g
ICAgICAgICAgICAgICAgIHZyaW5naF9raW92X2NsZWFudXAoJnZkcGFzaW0tPnZxc1tpXS5vdXRf
aW92KTsKPiAtLQo+IDIuMzkuMgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
