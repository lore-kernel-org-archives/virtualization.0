Return-Path: <SRS0=KS98=P4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E213C433EF
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 02:55:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960C561279
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 02:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 960C561279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A0004035B;
	Tue,  9 Nov 2021 02:55:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i6uCkGsmSX0a; Tue,  9 Nov 2021 02:55:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E874140272;
	Tue,  9 Nov 2021 02:55:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CABE0C0019;
	Tue,  9 Nov 2021 02:55:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45712C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 02:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 21F1F80DFD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 02:55:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TfDvGqPqOLr2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 02:55:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D31BC80D08
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 02:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636426510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AcTad0s1zvICS8LxeQTrtyxxid2izF1mjCXQxAurXKY=;
 b=C91HZ2ZX4BsaB0N6v2sW+Rwk49icfnfB4ZkSG9/SEgz3IPY/TMaumYr+nS2v6EKKdhg39F
 6/hzKZnLRBM8H4igQp/MEl3kepMukgNDnG12WCBrR0mUadK2gUNGF/k/K7pqp2LgBMit45
 vEHTXaCDmpPyTtqBPQFb28lweyaI5n8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-nam47doHOK-U6ybEwfpkJQ-1; Mon, 08 Nov 2021 21:55:09 -0500
X-MC-Unique: nam47doHOK-U6ybEwfpkJQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 w16-20020a05651c103000b00218c9d46faeso1315004ljm.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Nov 2021 18:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AcTad0s1zvICS8LxeQTrtyxxid2izF1mjCXQxAurXKY=;
 b=m12HMAeOShBHkFSkzGE4M9kL/m+eFtAcWU1Mj0Yfv993GjGleghKO+q0qvfzS5E1/i
 rda4s6r1teKy39Ud85rJ0lsOEKAL9cp+ZpxAOg8dKUVxooZzsHqAvRztlDKm1ouwbk78
 InO5Hxa5cGp02HJkwgt1fHBAwha9oEOzpW8fR8wVBJFCA7cYYAFZopxipL3luGvVZ2gV
 ZVWZ4LvBhJ4qJWBb9LDSiROBD9DF/5M4KEJl5bDT1xybMflQyB2r6AjCfqtn3JtvNxoJ
 YdnLkGc7Y3XpfSignwpDZcxq4nUxV7jbLOdEsr1XnRA1dm7dseJ031mQmHJSl7t9l2kU
 h+Fg==
X-Gm-Message-State: AOAM531LVqKofqUAjI3RvTWlovgiXmpT/SNzBHp6XTfYpiocPYfQaDPT
 paIsLFk2j0ztb+GFtqqJyNlHsLpxejAMkLSRoUIOz5A33Mz9euJ9yYhH7JvNihUcU3GtcQb5DXR
 tXlV/i+kZAPkT0I38MzNOVN2uj5vEJtHedAboduub2GJXMhsF1Yg3SPXLlw==
X-Received: by 2002:a05:6512:32c1:: with SMTP id
 f1mr3929567lfg.498.1636426507723; 
 Mon, 08 Nov 2021 18:55:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzoTxL0Mk4o67I/bfxIlxvjzL7/EGLPXyM6pWuABUduS0GHa/cGuGMSr7Ifk1yQh3rc/WK2uaYSsPUZAeDPfE=
X-Received: by 2002:a05:6512:32c1:: with SMTP id
 f1mr3929546lfg.498.1636426507506; 
 Mon, 08 Nov 2021 18:55:07 -0800 (PST)
MIME-Version: 1.0
References: <f6b2d087ca3840604b4e711a208d35b5d6285cb4.1636301587.git.christophe.jaillet@wanadoo.fr>
 <CACGkMEvN0cgFQhJmLF3xDXHt_EyZ-TnfBM8CnpNwA9sKcwpzBg@mail.gmail.com>
 <393fb7b7-653b-eae6-16bd-5ffc7d600619@wanadoo.fr>
In-Reply-To: <393fb7b7-653b-eae6-16bd-5ffc7d600619@wanadoo.fr>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Nov 2021 10:54:56 +0800
Message-ID: <CACGkMEt3yA+fkFJxKfrXyui-rYVSk78=1AqrT0TYQqzcqTJVyg@mail.gmail.com>
Subject: Re: [PATCH 1/2] eni_vdpa: Fix an error handling path in
 'eni_vdpa_probe()'
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Arnd Bergmann <arnd@arndb.de>, mst <mst@redhat.com>,
 kernel-janitors@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>
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

T24gVHVlLCBOb3YgOSwgMjAyMSBhdCAzOjMyIEFNIENocmlzdG9waGUgSkFJTExFVAo8Y2hyaXN0
b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+IHdyb3RlOgo+Cj4gTGUgMDgvMTEvMjAyMSDDoCAwNjo1
NSwgSmFzb24gV2FuZyBhIMOpY3JpdCA6Cj4gPiBPbiBNb24sIE5vdiA4LCAyMDIxIGF0IDEyOjE1
IEFNIENocmlzdG9waGUgSkFJTExFVAo+ID4gPGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZy
PiB3cm90ZToKPiA+Pgo+ID4+IEluIHRoZSBlcnJvciBoYW5kbGluZyBwYXRoLCBhIHN1Y2Nlc3Nm
dWwgJ3ZwX2xlZ2FjeV9wcm9iZSgpJyBzaG91bGQgYmUKPiA+PiBiYWxhbmNlZCBieSBhIGNvcnJl
c3BvbmRpbmcgJ3ZwX2xlZ2FjeV9yZW1vdmUoKScgY2FsbCwgYXMgYWxyZWFkeSBkb25lIGluCj4g
Pj4gdGhlIHJlbW92ZSBmdW5jdGlvbi4KPiA+Pgo+ID4+IEFkZCB0aGUgbWlzc2luZyBjYWxsIGFu
ZCB1cGRhdGUgZ290b3MgYWNjb3JkaW5nbHkuCj4gPj4KPiA+PiBGaXhlczogZTg1MDg3YmVlZGNh
ICgiZW5pX3ZkcGE6IGFkZCB2RFBBIGRyaXZlciBmb3IgQWxpYmFiYSBFTkkiKQo+ID4+IFNpZ25l
ZC1vZmYtYnk6IENocmlzdG9waGUgSkFJTExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28u
ZnI+Cj4gPj4gLS0tCj4gPj4gICBkcml2ZXJzL3ZkcGEvYWxpYmFiYS9lbmlfdmRwYS5jIHwgNiAr
KysrLS0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pCj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2FsaWJhYmEvZW5pX3ZkcGEu
YyBiL2RyaXZlcnMvdmRwYS9hbGliYWJhL2VuaV92ZHBhLmMKPiA+PiBpbmRleCAzZjc4ODc5NDU3
MWEuLjEyYjNkYjZiNDUxNyAxMDA2NDQKPiA+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvYWxpYmFiYS9l
bmlfdmRwYS5jCj4gPj4gKysrIGIvZHJpdmVycy92ZHBhL2FsaWJhYmEvZW5pX3ZkcGEuYwo+ID4+
IEBAIC01MDEsNyArNTAxLDcgQEAgc3RhdGljIGludCBlbmlfdmRwYV9wcm9iZShzdHJ1Y3QgcGNp
X2RldiAqcGRldiwgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmlkKQo+ID4+ICAgICAgICAg
IGlmICghZW5pX3ZkcGEtPnZyaW5nKSB7Cj4gPj4gICAgICAgICAgICAgICAgICByZXQgPSAtRU5P
TUVNOwo+ID4+ICAgICAgICAgICAgICAgICAgRU5JX0VSUihwZGV2LCAiZmFpbGVkIHRvIGFsbG9j
YXRlIHZpcnRxdWV1ZXNcbiIpOwo+ID4+IC0gICAgICAgICAgICAgICBnb3RvIGVycjsKPiA+PiAr
ICAgICAgICAgICAgICAgZ290byBlcnJfcmVtb3ZlX3ZwX2xlZ2FjeTsKPiA+PiAgICAgICAgICB9
Cj4gPj4KPiA+PiAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgZW5pX3ZkcGEtPnF1ZXVlczsgaSsr
KSB7Cj4gPj4gQEAgLTUxMywxMSArNTEzLDEzIEBAIHN0YXRpYyBpbnQgZW5pX3ZkcGFfcHJvYmUo
c3RydWN0IHBjaV9kZXYgKnBkZXYsIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkKPiA+
PiAgICAgICAgICByZXQgPSB2ZHBhX3JlZ2lzdGVyX2RldmljZSgmZW5pX3ZkcGEtPnZkcGEsIGVu
aV92ZHBhLT5xdWV1ZXMpOwo+ID4+ICAgICAgICAgIGlmIChyZXQpIHsKPiA+PiAgICAgICAgICAg
ICAgICAgIEVOSV9FUlIocGRldiwgImZhaWxlZCB0byByZWdpc3RlciB0byB2ZHBhIGJ1c1xuIik7
Cj4gPj4gLSAgICAgICAgICAgICAgIGdvdG8gZXJyOwo+ID4+ICsgICAgICAgICAgICAgICBnb3Rv
IGVycl9yZW1vdmVfdnBfbGVnYWN5Owo+ID4+ICAgICAgICAgIH0KPiA+Pgo+ID4+ICAgICAgICAg
IHJldHVybiAwOwo+ID4+Cj4gPj4gK2Vycl9yZW1vdmVfdnBfbGVnYWN5Ogo+ID4+ICsgICAgICAg
dnBfbGVnYWN5X3JlbW92ZSgmZW5pX3ZkcGEtPmxkZXYpOwo+ID4KPiA+IFdvbid0IHZwX2xlZ2Fj
eV9yZW1vdmUoKSBiZSB0cmlnZ2VyZWQgYnkgdGhlIHB1dF9kZXZpYygpIGJlbG93Pwo+Cj4gSGks
IEknbSBzb3JyeSBidXQgaSBkb24ndCBzZWUgaG93Lgo+Cj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0
aGF0Ogo+ICAgIC0gb24gInB1dF9kZXZpY2UoJmVuaV92ZHBhLT52ZHBhLmRldik7IiwgdGhlIGNv
cnJlc3BvbmRpbmcgcmVsZWFzZQo+IGZ1bmN0aW9uIHdpbGwgYmUgY2FsbGVkLgo+Cj4gICAgLSBU
aGlzIHJlbGVhc2UgZnVuY3Rpb24gaXMgdGhlIG9uZSByZWNvcmRlZCBpbiB0aGUKPiAnX192ZHBh
X2FsbG9jX2RldmljZSgpJyBmdW5jdGlvbi4KPgo+ICAgIC0gU28gaXQgc2hvdWxkIGJlICd2ZHBh
X3JlbGVhc2VfZGV2KCknLgo+Cj4gICAgLSBUaGlzIGZ1bmN0aW9uLCBBRkFJVSwgaGFzIG5vIGtu
b3dsZWRnZSBvZiAndnBfbGVnYWN5X3JlbW92ZSgpJyBvcgo+IGFueXRoaW5nIHRoYXQgY291bGQg
Y2FsbCBpdC4KPgo+Cj4gVW5sZXNzIEkgbWlzcmVhZCBzb21ldGhpbmcgb3IgbWlzcyBzb21ldGhp
bmcgb2J2aW91cywgSSBkb24ndCBzZWUgaG93Cj4gJ3ZwX2xlZ2FjeV9yZW1vdmUoKSB3b3VsZCBi
ZSBjYWxsZWQuCj4KPgo+IENvdWxkIHlvdSBlbGFib3JhdGU/CgpJIHRoaW5rIHRoZSBkZXZpY2Ug
c2hvdWxkIHJlbGVhc2UgdGhlIGRyaXZlciAoc2VlCmRldmljZV9yZWxlYXNlX2RyaXZlcigpKSBk
dXJpbmcgZHVyaW5nIGl0cyBkZWxldGluZy4KClRoYW5rcwoKPgo+IENKCj4KPiA+Cj4gPiBUaGFu
a3MKPiA+Cj4gPj4gICBlcnI6Cj4gPj4gICAgICAgICAgcHV0X2RldmljZSgmZW5pX3ZkcGEtPnZk
cGEuZGV2KTsKPiA+PiAgICAgICAgICByZXR1cm4gcmV0Owo+ID4+IC0tCj4gPj4gMi4zMC4yCj4g
Pj4KPiA+Cj4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
