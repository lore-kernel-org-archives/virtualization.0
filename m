Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5F4E95A96
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 10:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD3AA60DCA;
	Mon,  9 Oct 2023 10:33:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD3AA60DCA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cBKLdxtS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EH6HOWCN5oqq; Mon,  9 Oct 2023 10:33:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 182B461143;
	Mon,  9 Oct 2023 10:33:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 182B461143
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0516C0071;
	Mon,  9 Oct 2023 10:33:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE172C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:33:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B29940134
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:33:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B29940134
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=cBKLdxtS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7iutpwngufyl
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:33:13 +0000 (UTC)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 167BB40A59
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:33:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 167BB40A59
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-49dd647a477so1601598e0c.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 03:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696847592; x=1697452392;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rT1rH97yMTf0notAyuO1uE+7xlHDEM8gJWBeBFRun/4=;
 b=cBKLdxtS68mQSAKlmCVGQiPI1pDS/oBkcr2RPKi6UZXAeh1WmeSBHKtfsbipwguo1v
 Ln329fL+Wo4kzQjcB8ywMVphRmC1w00L2bWW9aMwUd7/PUybUI/VmHtgbucrAlrC/A12
 5Q48pndESIoCjHvviF+l7jMVfx9ceE1SD39+7HNa9DmvrZJWtUu6k1PGq/1XO2wJUQKq
 Zw5Tw5DSILESWiPk9gVZBQaq6bNv1BxJJ5jqjeYAU6DyFKuQKN+CNW+FE45ObA8wqcVf
 oGWYUvOUxz1iMFS1YZ+tP7Pi9whqKGKkf3lg31WWAOlGCa5KRigiMnwqkas2DoRcXs3o
 CJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696847592; x=1697452392;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rT1rH97yMTf0notAyuO1uE+7xlHDEM8gJWBeBFRun/4=;
 b=pvNb54OoHBEifHxSqLR4Zz6HHHcF9omX88E3S/Znve3T7xMySsYuYSgSErZqdy6wTx
 IyqN1cGDg8NEZEhbqGGCz+/Yz7FldolHacWyLZqS8iTb4TSGb5ycBleh9/4rHW7SdtEG
 2SXWBvBTZvvucEsYlivCAS92k7lDSHqDgID7dakPQFp7SyK39izNko+DfiWmkd0WGV41
 ZKMFFk9GG2r1XW4g+bo+ZdpW469qtM3zRRjubofvlFYvqDAusFl3yTmkGw4UxLBUx/61
 ArdsjDZBls3YguukrcLSiX95FxepMxpH/wJCq/HCp1PrZkHXwOJkU3RHM7cpeawwkIcf
 DO0g==
X-Gm-Message-State: AOJu0YwcG4yfXv1cOqSEdAYWyzRPG9ou+RSGlVMUfzqdxvCsQg5vAMN8
 Y3pskAwPFdr0XENqLUVybsdpJ6tsrMvpeoF+BEk=
X-Google-Smtp-Source: AGHT+IHE+bLXnKSnxxU/KTXcPWxDAmkZwBaU9nQyxeRMxaOL1S5mD7d5OmMEdKfRaLaQMD1aS0xEm5VGTb84Y71ZDqI=
X-Received: by 2002:a05:6122:7c9:b0:49d:c216:873d with SMTP id
 l9-20020a05612207c900b0049dc216873dmr13801907vkr.8.1696847591769; Mon, 09 Oct
 2023 03:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com>
 <CAF=yD-K2MQt4nnfwJrx6h6Nii_rho7j1o6nb_jYaSwcWY45pPw@mail.gmail.com>
 <48e20be1-b658-4117-8856-89ff1df6f48f@daynix.com>
 <CAF=yD-K4bCBpUVtDR_cv=bagRL+vM4Rusez+uHFTb4_kR8XkpA@mail.gmail.com>
 <6a698c99-6f02-4cfb-a709-ba02296a05f7@daynix.com>
 <CAF=yD-+WFy8us0wUWo-0KpZUKHx2Q82cJ8teO0qRkK-_R1e0cA@mail.gmail.com>
 <eab359ec-3bb9-4245-8ac3-097d66ef30a9@daynix.com>
In-Reply-To: <eab359ec-3bb9-4245-8ac3-097d66ef30a9@daynix.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 9 Oct 2023 03:32:33 -0700
Message-ID: <CAF=yD-LPMK4eOTABU5EPOOnSCBo=jQNPuNXLLa6qZy_jHSxyMg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: songliubraving@fb.com, gustavoars@kernel.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, decui@microsoft.com, ast@kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, yhs@fb.com,
 pabeni@redhat.com, pablo@netfilter.org, elver@google.com, kpsingh@kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>, cai@lca.pw, kuba@kernel.org,
 willemb@google.com, netdev@vger.kernel.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, nogikh@google.com,
 bpf@vger.kernel.org, kafai@fb.com
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

T24gTW9uLCBPY3QgOSwgMjAyMyBhdCAzOjEx4oCvQU0gQWtpaGlrbyBPZGFraSA8YWtpaGlrby5v
ZGFraUBkYXluaXguY29tPiB3cm90ZToKPgo+IE9uIDIwMjMvMTAvMDkgMTk6MDcsIFdpbGxlbSBk
ZSBCcnVpam4gd3JvdGU6Cj4gPiBPbiBNb24sIE9jdCA5LCAyMDIzIGF0IDM6MDXigK9BTSBBa2lo
aWtvIE9kYWtpIDxha2loaWtvLm9kYWtpQGRheW5peC5jb20+IHdyb3RlOgo+ID4+Cj4gPj4KPiA+
Pgo+ID4+IE9uIDIwMjMvMTAvMDkgMTg6NTQsIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6Cj4gPj4+
IE9uIE1vbiwgT2N0IDksIDIwMjMgYXQgMzo0NOKAr0FNIEFraWhpa28gT2Rha2kgPGFraWhpa28u
b2Rha2lAZGF5bml4LmNvbT4gd3JvdGU6Cj4gPj4+Pgo+ID4+Pj4gT24gMjAyMy8xMC8wOSAxNzox
MywgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiA+Pj4+PiBPbiBTdW4sIE9jdCA4LCAyMDIzIGF0
IDEyOjIy4oCvQU0gQWtpaGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXluaXguY29tPiB3cm90
ZToKPiA+Pj4+Pj4KPiA+Pj4+Pj4gdmlydGlvLW5ldCBoYXZlIHR3byB1c2FnZSBvZiBoYXNoZXM6
IG9uZSBpcyBSU1MgYW5kIGFub3RoZXIgaXMgaGFzaAo+ID4+Pj4+PiByZXBvcnRpbmcuIENvbnZl
bnRpb25hbGx5IHRoZSBoYXNoIGNhbGN1bGF0aW9uIHdhcyBkb25lIGJ5IHRoZSBWTU0uCj4gPj4+
Pj4+IEhvd2V2ZXIsIGNvbXB1dGluZyB0aGUgaGFzaCBhZnRlciB0aGUgcXVldWUgd2FzIGNob3Nl
biBkZWZlYXRzIHRoZQo+ID4+Pj4+PiBwdXJwb3NlIG9mIFJTUy4KPiA+Pj4+Pj4KPiA+Pj4+Pj4g
QW5vdGhlciBhcHByb2FjaCBpcyB0byB1c2UgZUJQRiBzdGVlcmluZyBwcm9ncmFtLiBUaGlzIGFw
cHJvYWNoIGhhcwo+ID4+Pj4+PiBhbm90aGVyIGRvd25zaWRlOiBpdCBjYW5ub3QgcmVwb3J0IHRo
ZSBjYWxjdWxhdGVkIGhhc2ggZHVlIHRvIHRoZQo+ID4+Pj4+PiByZXN0cmljdGl2ZSBuYXR1cmUg
b2YgZUJQRi4KPiA+Pj4+Pj4KPiA+Pj4+Pj4gSW50cm9kdWNlIHRoZSBjb2RlIHRvIGNvbXB1dGUg
aGFzaGVzIHRvIHRoZSBrZXJuZWwgaW4gb3JkZXIgdG8gb3ZlcmNvbWUKPiA+Pj4+Pj4gdGhzZSBj
aGFsbGVuZ2VzLiBBbiBhbHRlcm5hdGl2ZSBzb2x1dGlvbiBpcyB0byBleHRlbmQgdGhlIGVCUEYg
c3RlZXJpbmcKPiA+Pj4+Pj4gcHJvZ3JhbSBzbyB0aGF0IGl0IHdpbGwgYmUgYWJsZSB0byByZXBv
cnQgdG8gdGhlIHVzZXJzcGFjZSwgYnV0IGl0IG1ha2VzCj4gPj4+Pj4+IGxpdHRsZSBzZW5zZSB0
byBhbGxvdyB0byBpbXBsZW1lbnQgZGlmZmVyZW50IGhhc2hpbmcgYWxnb3JpdGhtcyB3aXRoCj4g
Pj4+Pj4+IGVCUEYgc2luY2UgdGhlIGhhc2ggdmFsdWUgcmVwb3J0ZWQgYnkgdmlydGlvLW5ldCBp
cyBzdHJpY3RseSBkZWZpbmVkIGJ5Cj4gPj4+Pj4+IHRoZSBzcGVjaWZpY2F0aW9uLgo+ID4+Pj4+
Pgo+ID4+Pj4+PiBUaGUgaGFzaCB2YWx1ZSBhbHJlYWR5IHN0b3JlZCBpbiBza19idWZmIGlzIG5v
dCB1c2VkIGFuZCBjb21wdXRlZAo+ID4+Pj4+PiBpbmRlcGVuZGVudGx5IHNpbmNlIGl0IG1heSBo
YXZlIGJlZW4gY29tcHV0ZWQgaW4gYSB3YXkgbm90IGNvbmZvcm1hbnQKPiA+Pj4+Pj4gd2l0aCB0
aGUgc3BlY2lmaWNhdGlvbi4KPiA+Pj4+Pj4KPiA+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQWtpaGlr
byBPZGFraSA8YWtpaGlrby5vZGFraUBkYXluaXguY29tPgo+ID4+Pj4+Cj4gPj4+Pj4+IEBAIC0y
MTE2LDMxICsyMTcyLDQ5IEBAIHN0YXRpYyBzc2l6ZV90IHR1bl9wdXRfdXNlcihzdHJ1Y3QgdHVu
X3N0cnVjdCAqdHVuLAo+ID4+Pj4+PiAgICAgICAgICAgIH0KPiA+Pj4+Pj4KPiA+Pj4+Pj4gICAg
ICAgICAgICBpZiAodm5ldF9oZHJfc3opIHsKPiA+Pj4+Pj4gLSAgICAgICAgICAgICAgIHN0cnVj
dCB2aXJ0aW9fbmV0X2hkciBnc287Cj4gPj4+Pj4+ICsgICAgICAgICAgICAgICB1bmlvbiB7Cj4g
Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2hkciBoZHI7
Cj4gPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2hkcl92
MV9oYXNoIHYxX2hhc2hfaGRyOwo+ID4+Pj4+PiArICAgICAgICAgICAgICAgfSBoZHI7Cj4gPj4+
Pj4+ICsgICAgICAgICAgICAgICBpbnQgcmV0Owo+ID4+Pj4+Pgo+ID4+Pj4+PiAgICAgICAgICAg
ICAgICAgICAgaWYgKGlvdl9pdGVyX2NvdW50KGl0ZXIpIDwgdm5ldF9oZHJfc3opCj4gPj4+Pj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ID4+Pj4+Pgo+ID4+
Pj4+PiAtICAgICAgICAgICAgICAgaWYgKHZpcnRpb19uZXRfaGRyX2Zyb21fc2tiKHNrYiwgJmdz
bywKPiA+Pj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0
dW5faXNfbGl0dGxlX2VuZGlhbih0dW4pLCB0cnVlLAo+ID4+Pj4+PiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZsYW5faGxlbikpIHsKPiA+Pj4+Pj4gKyAgICAg
ICAgICAgICAgIGlmICgoUkVBRF9PTkNFKHR1bi0+dm5ldF9oYXNoLmZsYWdzKSAmIFRVTl9WTkVU
X0hBU0hfUkVQT1JUKSAmJgo+ID4+Pj4+PiArICAgICAgICAgICAgICAgICAgIHZuZXRfaGRyX3N6
ID49IHNpemVvZihoZHIudjFfaGFzaF9oZHIpICYmCj4gPj4+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgc2tiLT50dW5fdm5ldF9oYXNoKSB7Cj4gPj4+Pj4KPiA+Pj4+PiBJc24ndCB2bmV0X2hkcl9z
eiBndWFyYW50ZWVkIHRvIGJlID49IGhkci52MV9oYXNoX2hkciwgYnkgdmlydHVlIG9mCj4gPj4+
Pj4gdGhlIHNldCBoYXNoIGlvY3RsIGZhaWxpbmcgb3RoZXJ3aXNlPwo+ID4+Pj4+Cj4gPj4+Pj4g
U3VjaCBjaGVja3Mgc2hvdWxkIGJlIGxpbWl0ZWQgdG8gY29udHJvbCBwYXRoIHdoZXJlIHBvc3Np
YmxlCj4gPj4+Pgo+ID4+Pj4gVGhlcmUgaXMgYSBwb3RlbnRpYWwgcmFjZSBzaW5jZSB0dW4tPnZu
ZXRfaGFzaC5mbGFncyBhbmQgdm5ldF9oZHJfc3ogYXJlCj4gPj4+PiBub3QgcmVhZCBhdCBvbmNl
Lgo+ID4+Pgo+ID4+PiBJdCBzaG91bGQgbm90IGJlIHBvc3NpYmxlIHRvIGRvd25ncmFkZSB0aGUg
aGRyX3N6IG9uY2UgdjEgaXMgc2VsZWN0ZWQuCj4gPj4KPiA+PiBJIHNlZSBub3RoaW5nIHRoYXQg
cHJldmVudHMgc2hyaW5raW5nIHRoZSBoZWFkZXIgc2l6ZS4KPiA+Pgo+ID4+IHR1bi0+dm5ldF9o
YXNoLmZsYWdzIGlzIHJlYWQgYWZ0ZXIgdm5ldF9oZHJfc3ogc28gdGhlIHJhY2UgY2FuIGhhcHBl
bgo+ID4+IGV2ZW4gZm9yIHRoZSBjYXNlIHRoZSBoZWFkZXIgc2l6ZSBncm93cyB0aG91Z2ggdGhp
cyBjYW4gYmUgZml4ZWQgYnkKPiA+PiByZW9yZGVyaW5nIHRoZSB0d28gcmVhZHMuCj4gPgo+ID4g
T25lIG9wdGlvbiBpcyB0byBmYWlsIGFueSBjb250cm9sIHBhdGggdGhhdCB0cmllcyB0byByZS1u
ZWdvdGlhdGUKPiA+IGhlYWRlciBzaXplIG9uY2UgdGhpcyBoYXNoIG9wdGlvbiBpcyBlbmFibGVk
Pwo+ID4KPiA+IFRoZXJlIGlzIG5vIHByYWN0aWNhbCByZWFzb24gdG8gYWxsb3cgZmVhdHVyZSBy
ZS1uZWdvdGlhdGlvbiBhdCBhbnkKPiA+IGFyYml0cmFyeSB0aW1lLgo+Cj4gSSB0aGluayBpdCdz
IGEgYml0IGF3a3dhcmQgaW50ZXJmYWNlIGRlc2lnbiBzaW5jZSB0dW4gYWxsb3dzIHRvCj4gcmVj
b25maWd1cmUgYW55IG9mIGl0cyBwYXJhbWV0ZXJzLCBidXQgaXQncyBjZXJ0YWlubHkgcG9zc2li
bGUuCgpJZiB0aGlzIHdvdWxkIGJlIHRoZSBvbmx5IGV4Y2VwdGlvbiB0byB0aGF0IHJ1bGUsIGFu
ZCB0aGlzIGlzIHRoZSBvbmx5CnBsYWNlIHRoYXQgbmVlZHMgYSBkYXRhcGF0aCBjaGVjaywgdGhl
biBpdCdzIGZpbmUgdG8gbGVhdmUgYXMgaXMuCgpJbiBnZW5lcmFsLCB0aGlzIHJ1bnRpbWUgY29u
ZmlndXJhYmlsaXR5IHNlcnZlcyBsaXR0bGUgcHVycG9zZSBidXQgdG8KaGVscCBzeXpib3QgZXhl
cmNpc2UgY29kZSBwYXRocyBubyByZWFsIGFwcGxpY2F0aW9uIHdvdWxkIGF0dGVtcHQuIEJ1dApJ
IHdvbid0IGFzayB0byBkaXZlcmdlIGZyb20gd2hhdGV2ZXIgdHVuIGFscmVhZHkgZG9lcy4gV2Ug
anVzdCBoYXZlIHRvCmJlIG1vcmUgY2FyZWZ1bCBhYm91dCB0aGUgcG9zc2libGUgcmFjZXMgaXQg
YnJpbmdzLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
