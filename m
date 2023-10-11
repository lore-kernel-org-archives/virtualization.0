Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F74CD98E9
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 03:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F50C82314;
	Wed, 11 Oct 2023 03:18:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F50C82314
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zdg1ziml
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O59jpSDnChPs; Wed, 11 Oct 2023 03:18:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C194C82318;
	Wed, 11 Oct 2023 03:18:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C194C82318
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E9CAC0071;
	Wed, 11 Oct 2023 03:18:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F7C9C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 03:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7330940360
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 03:18:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7330940360
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zdg1ziml
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J1OzZWXZ8dJc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 03:18:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05B0B4031E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 03:18:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 05B0B4031E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696994321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xijA8OQKKxwJQ4dCZ6kmx4etcCusbkgY4bBpmAh8Dog=;
 b=Zdg1zimlRuyhBYG40snTVgMKyCfQhoRgEINuhggrLBCSX0vQLJHnezj2MtWkSllq3xKEUZ
 4Nq279xlPLV5Sjopm6mHbWem8S2G5cNdwJAGUg0jbNP4nPXn+A5+FMagEfE6m53UH0Kjkm
 Qz+qPMVWuoaGo+XRtPNZPPF1Cddsm7Y=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-hy3-YavuOaS4deMIVsXnFQ-1; Tue, 10 Oct 2023 23:18:40 -0400
X-MC-Unique: hy3-YavuOaS4deMIVsXnFQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-503269edbb3so5914916e87.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 20:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696994318; x=1697599118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xijA8OQKKxwJQ4dCZ6kmx4etcCusbkgY4bBpmAh8Dog=;
 b=fA3RqVVkjAAyYAkUEDBZNzuzNpyliiq44/o9Rdp1ObGG46VvSlkZppeSXKJ2SmB5m1
 iFZjIHuvt+YpHrQD/rZQpwKIvz1/jspuSwHz3uoqD9RZSoFG3D5JwQNptJJxYhDeSSI/
 dIju3gWbtZQOTr4CmRgDOVuFi8HT+916+4xmkIUQnpo2BQZHffPVVZnNo2wcO9SUno0k
 rVXmap3p92Hx7t9RdrmDAFPOLvFGUftOhSRkN0QgiRO4iXJSm8Rd0TIY6B30iMkpErBh
 FhUalu2QwU1C/AgkKPFgOHfb/RKv1DG8cqgYzlDQ4V7PyUstkPZx7OFTgPp5D0O7Qyw/
 8DWA==
X-Gm-Message-State: AOJu0Yzb+KFBz+HKhKFSuIMiFVtdsYTfx3KTNYuFb9y3hWceZ5cZrdek
 Vd+i6ve/8DZyikqwnxgUUaZwu5pkO35GgSLe1NzGmxjjh3nA5GFgfJSqgH/5JX2iyi5kjPzR/sd
 3Lg+dcHZ2jD6c9Bw7eISu8TILPqj+xW+tEELD6eu5mtXGw0QwM7ihGy9fDg==
X-Received: by 2002:a05:6512:3e28:b0:500:7f51:d129 with SMTP id
 i40-20020a0565123e2800b005007f51d129mr22781655lfv.34.1696994318338; 
 Tue, 10 Oct 2023 20:18:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvQG0xak6vXbg2OUneajKAYVOTW2UCAtu6Ci4P/1I2WvNiHfiN5uWCXLmSnOhKn18mKUv2p74JegLwDXPCI6U=
X-Received: by 2002:a05:6512:3e28:b0:500:7f51:d129 with SMTP id
 i40-20020a0565123e2800b005007f51d129mr22781636lfv.34.1696994317964; Tue, 10
 Oct 2023 20:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <CAF=yD-LdwcXKK66s5gvJNOH8qCWRt3SvEL-GkkVif=kkOaYGhg@mail.gmail.com>
 <8f4ad5bc-b849-4ef4-ac1f-8d5a796205e9@daynix.com>
 <CAF=yD-+DjDqE9iBu+PvbeBby=C4CCwG=fMFONQONrsErmps3ww@mail.gmail.com>
 <286508a3-3067-456d-8bbf-176b00dcc0c6@daynix.com>
 <CAF=yD-+syCSJz_wp25rEaHTXMFRHgLh1M-uTdNWPb4fnrKgpFw@mail.gmail.com>
 <8711b549-094d-4be2-b7af-bd93b7516c05@daynix.com>
 <CAF=yD-+M75o2=yDy5d03fChuNTeeTRkUU7rPRG1i6O9aZGhLmQ@mail.gmail.com>
 <695a0611-2b19-49f9-8d32-cfea3b7df0b2@daynix.com>
 <CAF=yD-+_PLPt9qfXy1Ljr=Lou0W8hCJLi6HwPcZYCjJy+SKtbA@mail.gmail.com>
 <5baab0cf-7adf-475d-8968-d46ddd179f9a@daynix.com>
 <CAF=yD-KjvycgFrfKu5CgGGWU-3HbyXt_APQy4tqZgNtJwAUKzg@mail.gmail.com>
 <8f3ed081-134c-45a0-9208-c1cab29cdf37@daynix.com>
 <CACGkMEv0tpn4YsJhXXnoispYx2-VBimFAtFmf85Uo=5=6taVuw@mail.gmail.com>
 <8a44e14c-03c4-44e2-8c72-9d751c63dffe@daynix.com>
 <CACGkMEu8m4SRvuMKrJv9_A_Wh_a1OzWkAr_9-+5CyC1zqK=R3Q@mail.gmail.com>
 <0d491319-8ce9-4922-89c9-a48c4c5c03bc@daynix.com>
In-Reply-To: <0d491319-8ce9-4922-89c9-a48c4c5c03bc@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Oct 2023 11:18:27 +0800
Message-ID: <CACGkMEuBbGKssxNv5AfpaPpWQfk2BHR83rM5AHXN-YVMf2NvpQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: songliubraving@fb.com, gustavoars@kernel.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, decui@microsoft.com, ast@kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 steffen.klassert@secunet.com,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 herbert@gondor.apana.org.au, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, yhs@fb.com, pabeni@redhat.com, pablo@netfilter.org,
 elver@google.com, kpsingh@kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>, kuba@kernel.org,
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

T24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgMjoxOeKAr1BNIEFraWhpa28gT2Rha2kgPGFraWhpa28u
b2Rha2lAZGF5bml4LmNvbT4gd3JvdGU6Cj4KPiBPbiAyMDIzLzEwLzEwIDE1OjAwLCBKYXNvbiBX
YW5nIHdyb3RlOgo+ID4gT24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgMTo1MeKAr1BNIEFraWhpa28g
T2Rha2kgPGFraWhpa28ub2Rha2lAZGF5bml4LmNvbT4gd3JvdGU6Cj4gPj4KPiA+PiBPbiAyMDIz
LzEwLzEwIDE0OjQ1LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4+PiBPbiBUdWUsIE9jdCAxMCwgMjAy
MyBhdCA5OjUy4oCvQU0gQWtpaGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXluaXguY29tPiB3
cm90ZToKPiA+Pj4+Cj4gPj4+PiBPbiAyMDIzLzEwLzA5IDE5OjQ0LCBXaWxsZW0gZGUgQnJ1aWpu
IHdyb3RlOgo+ID4+Pj4+IE9uIE1vbiwgT2N0IDksIDIwMjMgYXQgMzoxMuKAr0FNIEFraWhpa28g
T2Rha2kgPGFraWhpa28ub2Rha2lAZGF5bml4LmNvbT4gd3JvdGU6Cj4gPj4+Pj4+Cj4gPj4+Pj4+
IE9uIDIwMjMvMTAvMDkgMTk6MDYsIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6Cj4gPj4+Pj4+PiBP
biBNb24sIE9jdCA5LCAyMDIzIGF0IDM6MDLigK9BTSBBa2loaWtvIE9kYWtpIDxha2loaWtvLm9k
YWtpQGRheW5peC5jb20+IHdyb3RlOgo+ID4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4gT24gMjAyMy8xMC8w
OSAxODo1NywgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiA+Pj4+Pj4+Pj4gT24gTW9uLCBPY3Qg
OSwgMjAyMyBhdCAzOjU34oCvQU0gQWtpaGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXluaXgu
Y29tPiB3cm90ZToKPiA+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+PiBPbiAyMDIzLzEwLzA5IDE3OjA0
LCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+ID4+Pj4+Pj4+Pj4+IE9uIFN1biwgT2N0IDgsIDIw
MjMgYXQgMzo0NuKAr1BNIEFraWhpa28gT2Rha2kgPGFraWhpa28ub2Rha2lAZGF5bml4LmNvbT4g
d3JvdGU6Cj4gPj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+IE9uIDIwMjMvMTAvMDkgNTowOCwg
V2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiA+Pj4+Pj4+Pj4+Pj4+IE9uIFN1biwgT2N0IDgsIDIw
MjMgYXQgMTA6MDTigK9QTSBBa2loaWtvIE9kYWtpIDxha2loaWtvLm9kYWtpQGRheW5peC5jb20+
IHdyb3RlOgo+ID4+Pj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+Pj4gT24gMjAyMy8xMC8wOSA0
OjA3LCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+ID4+Pj4+Pj4+Pj4+Pj4+PiBPbiBTdW4sIE9j
dCA4LCAyMDIzIGF0IDc6MjLigK9BTSBBa2loaWtvIE9kYWtpIDxha2loaWtvLm9kYWtpQGRheW5p
eC5jb20+IHdyb3RlOgo+ID4+Pj4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+Pj4+IHZpcnRp
by1uZXQgaGF2ZSB0d28gdXNhZ2Ugb2YgaGFzaGVzOiBvbmUgaXMgUlNTIGFuZCBhbm90aGVyIGlz
IGhhc2gKPiA+Pj4+Pj4+Pj4+Pj4+Pj4+IHJlcG9ydGluZy4gQ29udmVudGlvbmFsbHkgdGhlIGhh
c2ggY2FsY3VsYXRpb24gd2FzIGRvbmUgYnkgdGhlIFZNTS4KPiA+Pj4+Pj4+Pj4+Pj4+Pj4+IEhv
d2V2ZXIsIGNvbXB1dGluZyB0aGUgaGFzaCBhZnRlciB0aGUgcXVldWUgd2FzIGNob3NlbiBkZWZl
YXRzIHRoZQo+ID4+Pj4+Pj4+Pj4+Pj4+Pj4gcHVycG9zZSBvZiBSU1MuCj4gPj4+Pj4+Pj4+Pj4+
Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5vdGhlciBhcHByb2FjaCBpcyB0byB1c2UgZUJQRiBz
dGVlcmluZyBwcm9ncmFtLiBUaGlzIGFwcHJvYWNoIGhhcwo+ID4+Pj4+Pj4+Pj4+Pj4+Pj4gYW5v
dGhlciBkb3duc2lkZTogaXQgY2Fubm90IHJlcG9ydCB0aGUgY2FsY3VsYXRlZCBoYXNoIGR1ZSB0
byB0aGUKPiA+Pj4+Pj4+Pj4+Pj4+Pj4+IHJlc3RyaWN0aXZlIG5hdHVyZSBvZiBlQlBGLgo+ID4+
Pj4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+Pj4+IEludHJvZHVjZSB0aGUgY29kZSB0byBj
b21wdXRlIGhhc2hlcyB0byB0aGUga2VybmVsIGluIG9yZGVyIHRvIG92ZXJjb21lCj4gPj4+Pj4+
Pj4+Pj4+Pj4+PiB0aHNlIGNoYWxsZW5nZXMuIEFuIGFsdGVybmF0aXZlIHNvbHV0aW9uIGlzIHRv
IGV4dGVuZCB0aGUgZUJQRiBzdGVlcmluZwo+ID4+Pj4+Pj4+Pj4+Pj4+Pj4gcHJvZ3JhbSBzbyB0
aGF0IGl0IHdpbGwgYmUgYWJsZSB0byByZXBvcnQgdG8gdGhlIHVzZXJzcGFjZSwgYnV0IGl0IG1h
a2VzCj4gPj4+Pj4+Pj4+Pj4+Pj4+PiBsaXR0bGUgc2Vuc2UgdG8gYWxsb3cgdG8gaW1wbGVtZW50
IGRpZmZlcmVudCBoYXNoaW5nIGFsZ29yaXRobXMgd2l0aAo+ID4+Pj4+Pj4+Pj4+Pj4+Pj4gZUJQ
RiBzaW5jZSB0aGUgaGFzaCB2YWx1ZSByZXBvcnRlZCBieSB2aXJ0aW8tbmV0IGlzIHN0cmljdGx5
IGRlZmluZWQgYnkKPiA+Pj4+Pj4+Pj4+Pj4+Pj4+IHRoZSBzcGVjaWZpY2F0aW9uLgo+ID4+Pj4+
Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+Pj4+IFRoZSBoYXNoIHZhbHVlIGFscmVhZHkgc3Rv
cmVkIGluIHNrX2J1ZmYgaXMgbm90IHVzZWQgYW5kIGNvbXB1dGVkCj4gPj4+Pj4+Pj4+Pj4+Pj4+
PiBpbmRlcGVuZGVudGx5IHNpbmNlIGl0IG1heSBoYXZlIGJlZW4gY29tcHV0ZWQgaW4gYSB3YXkg
bm90IGNvbmZvcm1hbnQKPiA+Pj4+Pj4+Pj4+Pj4+Pj4+IHdpdGggdGhlIHNwZWNpZmljYXRpb24u
Cj4gPj4+Pj4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQWtp
aGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXluaXguY29tPgo+ID4+Pj4+Pj4+Pj4+Pj4+Pj4g
LS0tCj4gPj4+Pj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+Pj4+PiArc3RhdGljIGNvbnN0IHN0
cnVjdCB0dW5fdm5ldF9oYXNoX2NhcCB0dW5fdm5ldF9oYXNoX2NhcCA9IHsKPiA+Pj4+Pj4+Pj4+
Pj4+Pj4+ICsgICAgICAgLm1heF9pbmRpcmVjdGlvbl90YWJsZV9sZW5ndGggPQo+ID4+Pj4+Pj4+
Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgIFRVTl9WTkVUX0hBU0hfTUFYX0lORElSRUNUSU9OX1RB
QkxFX0xFTkdUSCwKPiA+Pj4+Pj4+Pj4+Pj4+Pj4+ICsKPiA+Pj4+Pj4+Pj4+Pj4+Pj4+ICsgICAg
ICAgLnR5cGVzID0gVklSVElPX05FVF9TVVBQT1JURURfSEFTSF9UWVBFUwo+ID4+Pj4+Pj4+Pj4+
Pj4+Pj4gK307Cj4gPj4+Pj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+Pj4+IE5vIG5lZWQgdG8g
aGF2ZSBleHBsaWNpdCBjYXBhYmlsaXRpZXMgZXhjaGFuZ2UgbGlrZSB0aGlzPyBUdW4gZWl0aGVy
Cj4gPj4+Pj4+Pj4+Pj4+Pj4+IHN1cHBvcnRzIGFsbCBvciBub25lLgo+ID4+Pj4+Pj4+Pj4+Pj4+
Cj4gPj4+Pj4+Pj4+Pj4+Pj4gdHVuIGRvZXMgbm90IHN1cHBvcnQgVklSVElPX05FVF9SU1NfSEFT
SF9UWVBFX0lQX0VYLAo+ID4+Pj4+Pj4+Pj4+Pj4+IFZJUlRJT19ORVRfUlNTX0hBU0hfVFlQRV9U
Q1BfRVgsIGFuZCBWSVJUSU9fTkVUX1JTU19IQVNIX1RZUEVfVURQX0VYLgo+ID4+Pj4+Pj4+Pj4+
Pj4+Cj4gPj4+Pj4+Pj4+Pj4+Pj4gSXQgaXMgYmVjYXVzZSB0aGUgZmxvdyBkaXNzZWN0b3IgZG9l
cyBub3Qgc3VwcG9ydCBJUHY2IGV4dGVuc2lvbnMuIFRoZQo+ID4+Pj4+Pj4+Pj4+Pj4+IHNwZWNp
ZmljYXRpb24gaXMgYWxzbyB2YWd1ZSwgYW5kIGRvZXMgbm90IHRlbGwgaG93IG1hbnkgVExWcyBz
aG91bGQgYmUKPiA+Pj4+Pj4+Pj4+Pj4+PiBjb25zdW1lZCBhdCBtb3N0IHdoZW4gaW50ZXJwcmV0
aW5nIGRlc3RpbmF0aW9uIG9wdGlvbiBoZWFkZXIgc28gSSBjaG9zZQo+ID4+Pj4+Pj4+Pj4+Pj4+
IHRvIGF2b2lkIGFkZGluZyBjb2RlIGZvciB0aGVzZSBoYXNoIHR5cGVzIHRvIHRoZSBmbG93IGRp
c3NlY3Rvci4gSSBkb3VidAo+ID4+Pj4+Pj4+Pj4+Pj4+IGFueW9uZSB3aWxsIGNvbXBsYWluIGFi
b3V0IGl0IHNpbmNlIG5vYm9keSBjb21wbGFpbnMgZm9yIExpbnV4Lgo+ID4+Pj4+Pj4+Pj4+Pj4+
Cj4gPj4+Pj4+Pj4+Pj4+Pj4gSSdtIGFsc28gYWRkaW5nIHRoaXMgc28gdGhhdCB3ZSBjYW4gZXh0
ZW5kIGl0IGxhdGVyLgo+ID4+Pj4+Pj4+Pj4+Pj4+IG1heF9pbmRpcmVjdGlvbl90YWJsZV9sZW5n
dGggbWF5IGdyb3cgZm9yIHN5c3RlbXMgd2l0aCAxMjgrIENQVXMsIG9yCj4gPj4+Pj4+Pj4+Pj4+
Pj4gdHlwZXMgbWF5IGhhdmUgb3RoZXIgYml0cyBmb3IgbmV3IHByb3RvY29scyBpbiB0aGUgZnV0
dXJlLgo+ID4+Pj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+Pj4+
PiAgICAgICAgICAgICAgICAgY2FzZSBUVU5TRVRTVEVFUklOR0VCUEY6Cj4gPj4+Pj4+Pj4+Pj4+
Pj4+PiAtICAgICAgICAgICAgICAgcmV0ID0gdHVuX3NldF9lYnBmKHR1biwgJnR1bi0+c3RlZXJp
bmdfcHJvZywgYXJncCk7Cj4gPj4+Pj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgYnBmX3Jl
dCA9IHR1bl9zZXRfZWJwZih0dW4sICZ0dW4tPnN0ZWVyaW5nX3Byb2csIGFyZ3ApOwo+ID4+Pj4+
Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgIGlmIChJU19FUlIoYnBmX3JldCkpCj4gPj4+Pj4+
Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKGJwZl9yZXQp
Owo+ID4+Pj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgIGVsc2UgaWYgKGJwZl9yZXQpCj4g
Pj4+Pj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICB0dW4tPnZuZXRfaGFzaC5m
bGFncyAmPSB+VFVOX1ZORVRfSEFTSF9SU1M7Cj4gPj4+Pj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+
Pj4+Pj4+IERvbid0IG1ha2Ugb25lIGZlYXR1cmUgZGlzYWJsZSBhbm90aGVyLgo+ID4+Pj4+Pj4+
Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Pj4+PiBUVU5TRVRTVEVFUklOR0VCUEYgYW5kIFRVTlNFVFZO
RVRIQVNIIGFyZSBtdXR1YWxseSBleGNsdXNpdmUKPiA+Pj4+Pj4+Pj4+Pj4+Pj4gZnVuY3Rpb25z
LiBJZiBvbmUgaXMgZW5hYmxlZCB0aGUgb3RoZXIgY2FsbCBzaG91bGQgZmFpbCwgd2l0aCBFQlVT
WQo+ID4+Pj4+Pj4+Pj4+Pj4+PiBmb3IgaW5zdGFuY2UuCj4gPj4+Pj4+Pj4+Pj4+Pj4+Cj4gPj4+
Pj4+Pj4+Pj4+Pj4+PiArICAgICAgIGNhc2UgVFVOU0VUVk5FVEhBU0g6Cj4gPj4+Pj4+Pj4+Pj4+
Pj4+PiArICAgICAgICAgICAgICAgbGVuID0gc2l6ZW9mKHZuZXRfaGFzaCk7Cj4gPj4+Pj4+Pj4+
Pj4+Pj4+PiArICAgICAgICAgICAgICAgaWYgKGNvcHlfZnJvbV91c2VyKCZ2bmV0X2hhc2gsIGFy
Z3AsIGxlbikpIHsKPiA+Pj4+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJl
dCA9IC1FRkFVTFQ7Cj4gPj4+Pj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICBi
cmVhazsKPiA+Pj4+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICB9Cj4gPj4+Pj4+Pj4+Pj4+
Pj4+PiArCj4gPj4+Pj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgaWYgKCgodm5ldF9oYXNo
LmZsYWdzICYgVFVOX1ZORVRfSEFTSF9SRVBPUlQpICYmCj4gPj4+Pj4+Pj4+Pj4+Pj4+PiArICAg
ICAgICAgICAgICAgICAgICAodHVuLT52bmV0X2hkcl9zeiA8IHNpemVvZihzdHJ1Y3QgdmlydGlv
X25ldF9oZHJfdjFfaGFzaCkgfHwKPiA+Pj4+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAhdHVuX2lzX2xpdHRsZV9lbmRpYW4odHVuKSkpIHx8Cj4gPj4+Pj4+Pj4+Pj4+Pj4+PiAr
ICAgICAgICAgICAgICAgICAgICB2bmV0X2hhc2guaW5kaXJlY3Rpb25fdGFibGVfbWFzayA+PQo+
ID4+Pj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgVFVOX1ZORVRfSEFTSF9NQVhf
SU5ESVJFQ1RJT05fVEFCTEVfTEVOR1RIKSB7Cj4gPj4+Pj4+Pj4+Pj4+Pj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICByZXQgPSAtRUlOVkFMOwo+ID4+Pj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgYnJlYWs7Cj4gPj4+Pj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAg
fQo+ID4+Pj4+Pj4+Pj4+Pj4+Pj4gKwo+ID4+Pj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAg
IGFyZ3AgPSAodTggX191c2VyICopYXJncCArIGxlbjsKPiA+Pj4+Pj4+Pj4+Pj4+Pj4+ICsgICAg
ICAgICAgICAgICBsZW4gPSAodm5ldF9oYXNoLmluZGlyZWN0aW9uX3RhYmxlX21hc2sgKyAxKSAq
IDI7Cj4gPj4+Pj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgaWYgKGNvcHlfZnJvbV91c2Vy
KHZuZXRfaGFzaF9pbmRpcmVjdGlvbl90YWJsZSwgYXJncCwgbGVuKSkgewo+ID4+Pj4+Pj4+Pj4+
Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVGQVVMVDsKPiA+Pj4+Pj4+Pj4+
Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4+Pj4+Pj4+Pj4+Pj4+Pj4g
KyAgICAgICAgICAgICAgIH0KPiA+Pj4+Pj4+Pj4+Pj4+Pj4+ICsKPiA+Pj4+Pj4+Pj4+Pj4+Pj4+
ICsgICAgICAgICAgICAgICBhcmdwID0gKHU4IF9fdXNlciAqKWFyZ3AgKyBsZW47Cj4gPj4+Pj4+
Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgbGVuID0gdmlydGlvX25ldF9oYXNoX2tleV9sZW5n
dGgodm5ldF9oYXNoLnR5cGVzKTsKPiA+Pj4+Pj4+Pj4+Pj4+Pj4+ICsKPiA+Pj4+Pj4+Pj4+Pj4+
Pj4+ICsgICAgICAgICAgICAgICBpZiAoY29weV9mcm9tX3VzZXIodm5ldF9oYXNoX2tleSwgYXJn
cCwgbGVuKSkgewo+ID4+Pj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
ID0gLUVGQVVMVDsKPiA+Pj4+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGJy
ZWFrOwo+ID4+Pj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgIH0KPiA+Pj4+Pj4+Pj4+Pj4+
Pj4KPiA+Pj4+Pj4+Pj4+Pj4+Pj4gUHJvYmFibHkgZWFzaWVyIGFuZCBsZXNzIGVycm9yLXByb25l
IHRvIGRlZmluZSBhIGZpeGVkIHNpemUgY29udHJvbAo+ID4+Pj4+Pj4+Pj4+Pj4+PiBzdHJ1Y3Qg
d2l0aCB0aGUgbWF4IGluZGlyZWN0aW9uIHRhYmxlIHNpemUuCj4gPj4+Pj4+Pj4+Pj4+Pj4KPiA+
Pj4+Pj4+Pj4+Pj4+PiBJIG1hZGUgaXRzIHNpemUgdmFyaWFibGUgYmVjYXVzZSB0aGUgaW5kaXJl
Y3Rpb24gdGFibGUgYW5kIGtleSBtYXkgZ3Jvdwo+ID4+Pj4+Pj4+Pj4+Pj4+IGluIHRoZSBmdXR1
cmUgYXMgSSB3cm90ZSBhYm92ZS4KPiA+Pj4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Pj4+Pgo+
ID4+Pj4+Pj4+Pj4+Pj4+PiBCdHc6IHBsZWFzZSB0cmltIHRoZSBDQzogbGlzdCBjb25zaWRlcmFi
bHkgb24gZnV0dXJlIHBhdGNoZXMuCj4gPj4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+PiBJ
J2xsIGRvIHNvIGluIHRoZSBuZXh0IHZlcnNpb24gd2l0aCB0aGUgVFVOU0VUU1RFRVJJTkdFQlBG
IGNoYW5nZSB5b3UKPiA+Pj4+Pj4+Pj4+Pj4+PiBwcm9wb3NlZC4KPiA+Pj4+Pj4+Pj4+Pj4+Cj4g
Pj4+Pj4+Pj4+Pj4+PiBUbyBiZSBjbGVhcjogcGxlYXNlIGRvbid0IGp1c3QgcmVzdWJtaXQgd2l0
aCB0aGF0IG9uZSBjaGFuZ2UuCj4gPj4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Pj4gVGhlIHNr
YiBhbmQgY2IgaXNzdWVzIGFyZSBxdWl0ZSBmdW5kYW1lbnRhbCBpc3N1ZXMgdGhhdCBuZWVkIHRv
IGJlIHJlc29sdmVkLgo+ID4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+IEknZCBsaWtlIHRv
IHVuZGVyc3RhbmQgd2h5IGFkanVzdGluZyB0aGUgZXhpc3RpbmcgQlBGIGZlYXR1cmUgZm9yIHRo
aXMKPiA+Pj4+Pj4+Pj4+Pj4+IGV4YWN0IHB1cnBvc2UgY2Fubm90IGJlIGFtZW5kZWQgdG8gcmV0
dXJuIHRoZSBrZXkgaXQgcHJvZHVjZWQuCj4gPj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+IGVC
UEYgc3RlZXJpbmcgcHJvZ3JhbSBpcyBub3QgZGVzaWduZWQgZm9yIHRoaXMgcGFydGljdWxhciBw
cm9ibGVtIGluIG15Cj4gPj4+Pj4+Pj4+Pj4+IHVuZGVyc3RhbmRpbmcuIEl0IHdhcyBpbnRyb2R1
Y2VkIHRvIGRlcml2ZSBoYXNoIHZhbHVlcyB3aXRoIGFuCj4gPj4+Pj4+Pj4+Pj4+IHVuZGVyc3Rh
bmRpbmcgb2YgYXBwbGljYXRpb24tc3BlY2lmaWMgc2VtYW50aWNzIG9mIHBhY2tldHMgaW5zdGVh
ZCBvZgo+ID4+Pj4+Pj4+Pj4+PiBnZW5lcmljIElQL1RDUC9VRFAgc2VtYW50aWNzLgo+ID4+Pj4+
Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+PiBUaGlzIHByb2JsZW0gaXMgcmF0aGVyIGRpZmZlcmVudCBp
biB0ZXJtcyB0aGF0IHRoZSBoYXNoIGRlcml2YXRpb24gaXMKPiA+Pj4+Pj4+Pj4+Pj4gc3RyaWN0
bHkgZGVmaW5lZCBieSB2aXJ0aW8tbmV0LiBJIGRvbid0IHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRv
Cj4gPj4+Pj4+Pj4+Pj4+IGludHJvZHVjZSB0aGUgY29tcGxleGl0eSBvZiBCUEYgd2hlbiB5b3Ug
YWx3YXlzIHJ1biB0aGUgc2FtZSBjb2RlLgo+ID4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+PiBJ
dCBjYW4gdXRpbGl6ZSB0aGUgZXhpc3RpbmcgZmxvdyBkaXNzZWN0b3IgYW5kIGFsc28gbWFrZSBp
dCBlYXNpZXIgdG8KPiA+Pj4+Pj4+Pj4+Pj4gdXNlIGZvciB0aGUgdXNlcnNwYWNlIGJ5IGltcGxl
bWVudGluZyB0aGlzIGluIHRoZSBrZXJuZWwuCj4gPj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+PiBP
ay4gVGhlcmUgZG9lcyBhcHBlYXIgdG8gYmUgb3ZlcmxhcCBpbiBmdW5jdGlvbmFsaXR5LiBCdXQg
aXQgbWlnaHQgYmUKPiA+Pj4+Pj4+Pj4+PiBlYXNpZXIgdG8gZGVwbG95IHRvIGp1c3QgaGF2ZSBz
dGFuZGFyZCBUb2VwbGl0eiBhdmFpbGFibGUgd2l0aG91dAo+ID4+Pj4+Pj4+Pj4+IGhhdmluZyB0
byBjb21waWxlIGFuZCBsb2FkIGFuIGVCUEYgcHJvZ3JhbS4KPiA+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+
Pj4+Pj4+IEFzIGZvciB0aGUgc2tfYnVmZiBhbmQgY2JbXSBjaGFuZ2VzLiBUaGUgZmlyc3QgaXMg
cmVhbGx5IG5vdCBuZWVkZWQuCj4gPj4+Pj4+Pj4+Pj4gc2tfYnVmZiBzaW1wbHkgd291bGQgbm90
IHNjYWxlIGlmIGV2ZXJ5IGVkZ2UgY2FzZSBuZWVkcyBhIGZldyBiaXRzLgo+ID4+Pj4+Pj4+Pj4K
PiA+Pj4+Pj4+Pj4+IEFuIGFsdGVybmF0aXZlIGlzIHRvIG1vdmUgdGhlIGJpdCB0byBjYltdIGFu
ZCBjbGVhciBpdCBmb3IgZXZlcnkgY29kZQo+ID4+Pj4+Pj4+Pj4gcGF0aHMgdGhhdCBsZWFkIHRv
IG5kb19zdGFydF94bWl0KCksIGJ1dCBJJ20gd29ycmllZCB0aGF0IGl0IGlzIGVycm9yLXByb25l
Lgo+ID4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+IEkgdGhpbmsgd2UgY2FuIHB1dCB0aGUgYml0IGlu
IHNrX2J1ZmYgZm9yIG5vdy4gV2UgY2FuIGltcGxlbWVudCB0aGUKPiA+Pj4+Pj4+Pj4+IGFsdGVy
bmF0aXZlIHdoZW4gd2UgYXJlIHNob3J0IG9mIGJpdHMuCj4gPj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+
IEkgZGlzYWdyZWUuIHNrX2J1ZmYgZmllbGRzIGFkZCBhIGNvc3QgdG8gZXZlcnkgY29kZSBwYXRo
LiBUaGV5IGNhbm5vdAo+ID4+Pj4+Pj4+PiBiZSBhZGRlZCBmb3IgZXZlcnkgZWRnZSBjYXNlLgo+
ID4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4gSXQgb25seSB0YWtlcyBhbiB1bnVzZWQgYml0IGFuZCBkb2Vz
IG5vdCBncm93IHRoZSBza19idWZmIHNpemUgc28gSQo+ID4+Pj4+Pj4+IHRoaW5rIGl0IGhhcyBw
cmFjdGljYWxseSBubyBjb3N0IGZvciBub3cuCj4gPj4+Pj4+Pgo+ID4+Pj4+Pj4gVGhlIHByb2Js
ZW0gaXMgdGhhdCB0aGF0IHRoaW5raW5nIGxlYWRzIHRvIGRlYXRoIGJ5IGEgdGhvdXNhbmQgY3V0
cy4KPiA+Pj4+Pj4+Cj4gPj4+Pj4+PiAiZm9yIG5vdyIgZm9yY2VzIHRoZSBjb3N0IG9mIGhhdmlu
ZyB0byB0aGluayBoYXJkIGhvdyB0byBhdm9pZCBncm93aW5nCj4gPj4+Pj4+PiBza19idWZmIG9u
dG8gdGhlIG5leHQgcGVyc29uLiBMZXQncyBkbyBpdCByaWdodCBmcm9tIHRoZSBzdGFydC4KPiA+
Pj4+Pj4KPiA+Pj4+Pj4gSSBzZWUuIEkgZGVzY3JpYmVkIGFuIGFsdGVybmF0aXZlIHRvIG1vdmUg
dGhlIGJpdCB0byBjYltdIGFuZCBjbGVhciBpdAo+ID4+Pj4+PiBpbiBhbGwgY29kZSBwYXRocyB0
aGF0IGxlYWRzIHRvIG5kb19zdGFydF94bWl0KCkgZWFybGllci4gRG9lcyB0aGF0Cj4gPj4+Pj4+
IHNvdW5kIGdvb2QgdG8geW91Pwo+ID4+Pj4+Cj4gPj4+Pj4gSWYgeW91IHVzZSB0aGUgY29udHJv
bCBibG9jayB0byBwYXNzIGluZm9ybWF0aW9uIGJldHdlZW4KPiA+Pj4+PiBfX2Rldl9xdWV1ZV94
bWl0IG9uIHRoZSB0dW4gZGV2aWNlIGFuZCB0dW5fbmV0X3htaXQsIHVzaW5nIGdzb19za2JfY2Is
Cj4gPj4+Pj4gdGhlIGZpZWxkIGNhbiBiZSBsZWZ0IHVuZGVmaW5lZCBpbiBhbGwgbm9uLXR1biBw
YXRocy4gdHVuX3NlbGVjdF9xdWV1ZQo+ID4+Pj4+IGNhbiBpbml0aWFsaXplLgo+ID4+Pj4KPiA+
Pj4+IFRoZSBwcm9ibGVtIGlzIHRoYXQgdHVuX3NlbGVjdF9xdWV1ZSgpIGlzIG5vdCBhbHdheXMg
Y2FsbGVkLgo+ID4+Pj4gbmV0ZGV2X2NvcmVfcGlja190eCgpIGVuc3VyZXMgZGV2LT5yZWFsX251
bV90eF9xdWV1ZXMgIT0gMSBiZWZvcmUKPiA+Pj4+IGNhbGxpbmcgaXQsIGJ1dCB0aGlzIHZhcmlh
YmxlIG1heSBjaGFuZ2UgbGF0ZXIgYW5kIHJlc3VsdCBpbiBhIHJhY2UKPiA+Pj4+IGNvbmRpdGlv
bi4gQW5vdGhlciBjYXNlIGlzIHRoYXQgWERQIHdpdGggcHJlZGVmaW5lZCBxdWV1ZS4KPiA+Pj4+
Cj4gPj4+Pj4KPiA+Pj4+PiBJIHdvdWxkIHN0aWxsIHVzZSBza2ItPmhhc2ggdG8gZW5jb2RlIHRo
ZSBoYXNoLiBUaGF0IGhhc2ggdHlwZSBvZiB0aGF0Cj4gPj4+Pj4gZmllbGQgaXMgbm90IHN0cmlj
dGx5IGRlZmluZWQuIEl0IGNhbiBiZSBzaXBoYXNoIGZyb20gX19fc2tiX2dldF9oYXNoCj4gPj4+
Pj4gb3IgYSBkZXZpY2UgaGFzaCwgd2hpY2ggbW9zdCBsaWtlbHkgYWxzbyB1c2VzIFRvZXBsaXR6
LiBUaGVuIHlvdSBhbHNvCj4gPj4+Pj4gZG9uJ3QgcnVuIGludG8gdGhlIHByb2JsZW0gb2YgZ3Jv
d2luZyB0aGUgc3RydWN0IHNpemUuCj4gPj4+Pgo+ID4+Pj4gSSdtIGNvbmNlcm5lZCBleGFjdGx5
IGJlY2F1c2UgaXQncyBub3Qgc3RyaWN0bHkgZGVmaW5lZC4gU29tZW9uZSBtYXkKPiA+Pj4+IGRl
Y2lkZSB0byBvdmVyd3JpdGUgaXQgbGF0ZXIgaWYgd2UgYXJlIG5vdCBjYXV0aW91cyBlbm91Z2gu
IHFkaXNjX3NrYl9jYgo+ID4+Pj4gYWxzbyBoYXMgc3VmZmljaWVudCBzcGFjZSB0byBjb250YWlu
IGJvdGggb2YgdGhlIGhhc2ggdmFsdWUgYW5kIHR5cGUuCj4gPj4+Cj4gPj4+IEhvdyBhYm91dCB1
c2luZyBza2IgZXh0ZW5zaW9ucz8KPiA+Pgo+ID4+IEkgdGhpbmsgaXQgd2lsbCB3b3JrLiBJJ2xs
IHRyeSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLgo+ID4KPiA+IEJ0dywgSSBzdGlsbCB0aGluayB1
c2luZyBlQlBGIGZvciBoYXNoIG1pZ2h0IGJlIGJldHRlci4KPiA+Cj4gPiBUaG91Z2ggdGhlIGhh
c2hpbmcgcnVsZSBpcyBkZWZpbmVkIGluIHRoZSBzcGVjLCBpdCBtYXkgYmUgZXh0ZW5kZWQgaW4K
PiA+IHRoZSBmdXR1cmUuIEZvciBleGFtcGxlLCBzZXZlcmFsIGV4dGVuc2lvbnMgaGFzIGJlZW4g
cHJvcG9zZWQ6Cj4gPgo+ID4gMSkgUlNTIGNvbnRleHQKPiA+IDIpIGVuY2Fwc3VsYXRlZCBwYWNr
ZXQgaGFzaGluZwo+Cj4gTG9va2luZyBhdCB0aGUgcHJvcG9zYWxzLCBJJ20gbm93IG1vcmUgaW5j
bGluZWQgdG8gZXh0ZW5kIHRoZSBCUEYKPiBzdGVlcmluZyBwcm9ncmFtLgoKSnVzdCB0byBtYWtl
IHN1cmUgd2UgYXJlIGF0IHRoZSBzYW1lIHBhZ2UuCgpJZiB0aGUgZUJQRiBwcm9ncmFtIG5lZWRz
IHRvIGFjY2VzcyBza2IgZXh0ZW5zaW9ucywgaXQgd291bGQgbm90IGJlIGEKc3RlZXJpbmcgcHJv
Z3JhbSBhbnltb3JlIChub3QgYSBmaWx0ZXIpLgoKT3IgZG8geW91IG1lYW4gaXQgaXMgYSBkZWRp
Y2F0ZWQgZUJQRiBwcm9ncmFtIHRoYXQgY2FsY3VsYXRlcyB0aGUgaGFzaD8KCj4KPiBZdXJpLCB3
aG8gd3JvdGUgdGhlIFJGQyBwYXRjaGVzIHRvIGV4dGVuZCB0aGUgQlBGIHN0ZWVyaW5nIHByb2dy
YW0sIGFsc28KPiByYWlzZWQgYW4gY29uY2VybiB0aGF0IGl0IG1heSBiZWNvbWUgaGFyZCB0byBp
bXBsZW1lbnQgdmlydGlvLW5ldAo+IGV4dGVuc2lvbnMgaW4gdGhlIGZ1dHVyZS4gSXQgaXMgbXVj
aCBlYXNpZXIgdG8gZGVwbG95IGEgbmV3IEJQRiBwcm9ncmFtCj4gdG8gc3VwcG9ydCBleHRlbnNp
b25zIHNpbmNlIGl0IHdpbGwgYmUgaW5jbHVkZWQgaW4gUUVNVSBhbmQgY2FuIGJlCj4gZGVwbG95
ZWQgYXQgb25jZSB3aXRob3V0IGNvbmNlcm5pbmcgb3RoZXIga2VybmVsIHN0dWZmLgo+Cj4gSSB3
YXMgc3RpbGwgbm90IHN1cmUgaG93IGxpa2VseSBzdWNoIGFuIGV4dGVuc2lvbiB3aWxsIGVtZXJn
ZSBlc3BlY2lhbGx5Cj4gd2hlbiB0aGUgaGFyZHdhcmUgUlNTIGNhcGFiaWxpdHkgaXMgbm90IGV2
b2x2aW5nIGZvciBhIGRlY2FkZSBvciBzby4gQnV0Cj4gdGhvc2UgcHJvcG9zYWxzIHNob3cgdGhh
dCB0aGVyZSBhcmUgbW9yZSBkZW1hbmRzIG9mIG5ldyBmZWF0dXJlcyBmb3IKPiB2aXJ0aW8tbmV0
LgoKSXQncyBub3Qgb25seSB0aGUgUlNTLCBpZiB5b3UgdHJhY2sgdmlydGlvIGRldmVsb3BtZW50
LCBmbG93IGRpcmVjdG9ycwphcmUgYWxzbyBiZWluZyBwcm9wb3NlZC4KClRoYW5rcwoKPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
