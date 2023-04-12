Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50F2C77B6E
	for <virtualization@archiver.kernel.org>; Wed, 12 Apr 2023 07:56:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 476F161167;
	Wed, 12 Apr 2023 07:56:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 476F161167
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OUOX/hJn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O6jtyy2XqSLa; Wed, 12 Apr 2023 07:56:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A6BA7613CF;
	Wed, 12 Apr 2023 07:56:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6BA7613CF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C465C0037;
	Wed, 12 Apr 2023 07:56:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 445ABC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Apr 2023 07:56:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0BFA8613CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Apr 2023 07:56:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0BFA8613CF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RTl5UAcaTYFn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Apr 2023 07:56:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 339FD61167
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 339FD61167
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Apr 2023 07:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681286194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D866SOkr+JAupKOXFjicwr/I17LLrDFfMaetFGueasA=;
 b=OUOX/hJnSrdQN0ClsooqY8dUlk2n/Ydbsb7Gpl/f+2mFMfxN0OsK+Sx7qsWC0GVtZ/wFzO
 iUeasq4eaV/m9YF6CKEWIklRYFmJrx+a4lMdPCBqRY3psHODDgZhe9BZwR7Xrou0kERbGF
 axPOxgOl46pXqRT2A6s+8zh4y6XWGQU=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-Lfm8-dePPHSKYeOszHL_Iw-1; Wed, 12 Apr 2023 03:56:32 -0400
X-MC-Unique: Lfm8-dePPHSKYeOszHL_Iw-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-1842ab38ebcso6272795fac.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Apr 2023 00:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681286192; x=1683878192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D866SOkr+JAupKOXFjicwr/I17LLrDFfMaetFGueasA=;
 b=emtopmwUrnLt1zaMLmq+1WA3ng6cBZN7PZRYWtBh3zXHVW6jUwjxBpkKmkVaWsI9y3
 widSUA9Swbs+/8ydixn2QSRwh1Uy/74voVFKTlfuljLbNmdjc2fKDoUoFXQquZjp7pvh
 EHfAMRVowgyOyRmx770tYVNv/ClxmXFzDdZxb3oZjbnKc2px6PcqgySSbImtaUzMT5Cs
 CoKf0WJjuD1F//xwkbs7y9Pp6369Yxps04V8haSdSsGHKXujrq/yZeSNDVRn784GoWpk
 4tpJ+Bohv5P3Q/91naUFnuJw0fysi6L3IZ6xJk6au18IIp9p74Ss/dQ3pDsU/FT6uywj
 DxOQ==
X-Gm-Message-State: AAQBX9dBbRpqlP5y32fPalZnYkWypcTkKG3juxRVeIlCNWXnxJL2RPDl
 MUq3yapgIcaK9QmPzbrHaFn4PFvx/IOEfrN1UDro5zOiEpDduTo+1Y/x0p7vkNkU4Lp0Pa5rAew
 TZAnAc8A2ntLX5tWXyEAK766vJWmLWouWwWKXzU2jMUToRmTeYhE9eRiEIA==
X-Received: by 2002:a05:6870:96a3:b0:184:4c39:fe30 with SMTP id
 o35-20020a05687096a300b001844c39fe30mr4212785oaq.9.1681286192138; 
 Wed, 12 Apr 2023 00:56:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yryo9LOvWqhRK+XN6CNya9XVqX9B13PbIks0divbT6iy3MHXePtFWudbQ4VE+eafJgIHDjimxPp2wZcZ8oDrk=
X-Received: by 2002:a05:6870:96a3:b0:184:4c39:fe30 with SMTP id
 o35-20020a05687096a300b001844c39fe30mr4212780oaq.9.1681286191914; Wed, 12 Apr
 2023 00:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230328021717.42268-1-michael.christie@oracle.com>
 <20230328021717.42268-12-michael.christie@oracle.com>
 <CACGkMEuvAGKHVtg_tdiGJRN4+5utdDVbvnkycN97eb2fE2Ddsg@mail.gmail.com>
 <faeaa023-c1ee-cd81-3397-edecc0579e8a@oracle.com>
 <CACGkMEvrvpu-xdJTzm5mVq-9JGuXRnsXZHEU7tgwfsz6qqFc4g@mail.gmail.com>
 <0ce314ff-0a1d-223d-0ccf-d2cb876b4306@oracle.com>
 <CACGkMEs5GdXuoMaOiZjWytG=JHqhzdZmCu=dK7GRRvYcx8t2+A@mail.gmail.com>
 <c7da1c60-1b89-5fab-942a-1e74214f03d5@oracle.com>
In-Reply-To: <c7da1c60-1b89-5fab-942a-1e74214f03d5@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Apr 2023 15:56:20 +0800
Message-ID: <CACGkMEsYK5yWuFECrUM-_fLA1V4H=WayxfovT2ezMeQCmwcDoQ@mail.gmail.com>
Subject: Re: [PATCH v6 11/11] vhost: allow userspace to create workers
To: Mike Christie <michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 mst@redhat.com
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

T24gV2VkLCBBcHIgMTIsIDIwMjMgYXQgNjoxNeKAr0FNIE1pa2UgQ2hyaXN0aWUKPG1pY2hhZWwu
Y2hyaXN0aWVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4KPiBPbiA0LzEwLzIzIDEwOjAwIFBNLCBKYXNv
biBXYW5nIHdyb3RlOgo+ID4+PiB2aG9zdF96ZXJvY29weV9jYWxsYmFjaygpLiBCdXQgc2luY2Ug
eW91IHdhbnQgdG8gbGltaXQgdGhlIGNhbGwgYmVmb3JlCj4gPj4+IHNldF9iYWNrZW5kLCBhbm90
aGVyIHF1ZXN0aW9uIGNvbWVzLCBkbyB3ZSByZWFsbHkgbmVlZCB0aGUgZHluYW1pYwo+ID4+PiBh
dHRhY2hpbmcvY3JlYXRpbmcgaW4gdGhpcyBjYXNlPyBIb3cgYWJvdXQgYSBzaW1wbGUgb25lIGlv
Y3RsIHRoYXQgaXMKPiA+Pj4gdXNlZCB0byBidWlsZCB0aGUgcXVldWUgdG8gd29ya2VycyBtYXBw
aW5nIGluc3RlYWQ/Cj4gPj4KPiA+Pgo+ID4+IEkgZGlkbid0IHRoaW5rIHdlIG5lZWQgdGhlIGR5
bmFtaWMgY2FzZS4gSXQgd2FzIGZyb20gYSByZXZpZXcgY29tbWVudC4KPiA+Cj4gPiBSaWdodCwg
c28gd2UgYWN0dWFsbHkgZG9uJ3QgbmVlZCB0aHJlZSBuZXcgaW9jdGxzIGJ1dCBvbmx5IGEgc2lu
Z2xlIGlzCj4gPiBzdWZmaWNpZW50Pwo+ID4KPiA+IHN0cnVjdCB2aG9zdF93b3JrZXJfc3RhdGUg
ewo+ID4gICAgICAgX191MTYgd29ya2VyczsKPiA+ICAgICAgIF9fdTE2IHF1ZXVlX3RvX3dvcmtf
bWFwW107Cj4gPiB9Owo+ID4KPiA+IEFuZCBsaW1pdGluZyB0aGlzIHRvIGJlIGNhbGxlZCBiZWZv
cmUgZGF0YXBhdGggY2FuIHJ1biBpcyBzdWZmaWNpZW50Pwo+ID4gKHNvcnJ5IEkgbWlzc2VkIHNv
bWUgb2YgdGhlIHByZXZpb3VzIGNvbW1lbnRzKS4KPgo+IEl0J3MgYmVlbiBsaWtlIDMgeWVhcnMg
c2luY2UgdGhpcyB3YXMgbGFzdCBkaXNjdXNzZWQgc28gbm8gcHJvYmxlbSA6KQo+CgpJJ20gcmVh
bGx5IHNvcnJ5IGZvciB0aGF0LCAtRU5PTUVNIDooCgo+IFllYWgsIHdoYXQgeW91IGRlc2NyaWJl
IGlzIGFsbCBJIG5lZWQuIE9yaWdpbmFsbHkgSSBqdXN0IGhhZCB0aGUgb25lCj4gaW9jdGw6Cj4K
PiArI2RlZmluZSBWSE9TVF9TRVRfVlJJTkdfV09SS0VSIF9JT1dSKFZIT1NUX1ZJUlRJTywgMHgx
NSwgc3RydWN0IHZob3N0X3ZyaW5nX3dvcmtlcikKPgo+IFRoZSBWSE9TVF9TRVRfVlJJTkdfV09S
S0VSIGNyZWF0ZWQgYSB3b3JrZXIgb24gdGhlIHZpcnRxdWV1ZSBpbiB0aGUKPiB2aG9zdF92cmlu
Z193b3JrZXIuCj4KPgo+ID4+Pj4KPiA+Pj4+Pj4gLSAgICAgICBkZWZhdWx0Ogo+ID4+Pj4+PiAr
ICAgICAgIGNhc2UgVkhPU1RfQVRUQUNIX1ZSSU5HX1dPUktFUjoKPiA+Pj4+Pj4gKyAgICAgICAg
ICAgICAgIGlmIChjb3B5X2Zyb21fdXNlcigmdywgYXJncCwgc2l6ZW9mKHcpKSkgewo+ID4+Pj4+
PiArICAgICAgICAgICAgICAgICAgICAgICByID0gLUVGQVVMVDsKPiA+Pj4+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgYnJlYWs7Cj4gPj4+Pj4+ICsgICAgICAgICAgICAgICB9Cj4gPj4+Pj4+
ICsgICAgICAgICAgICAgICByID0gdmhvc3RfdnFfYXR0YWNoX3dvcmtlcih2cSwgJncpOwo+ID4+
Pj4+PiArICAgICAgICAgICAgICAgaWYgKCFyICYmIGNvcHlfdG9fdXNlcihhcmdwLCAmdywgc2l6
ZW9mKHcpKSkKPiA+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgciA9IC1FRkFVTFQ7Cj4g
Pj4+Pj4+ICsgICAgICAgICAgICAgICBicmVhazsKPiA+Pj4+Pgo+ID4+Pj4+IEl0J3MgYSBsaXR0
bGUgb2RkIHRoYXQgd2UgaGF2ZSBuZXcgYW5kIGF0dGFjaCBidXQgb25seSBhIGZyZWUuCj4gPj4+
Pgo+ID4+Pj4gRG8geW91IG1lYW4gd2Ugd291bGQgYWxzbyB3YW50IGEgZGV0YWNoPyBJJ3ZlIGJl
ZW4gZGViYXRpbmcgdGhhdC4KPiA+Pj4+IEknbSBub3Qgc3VyZSB3aGF0IHRoZSB1c2VyIHdhbnRl
ZCB0aG91Z2guCj4gPj4+Pgo+ID4+Pj4gV291bGQgaXQgbGVhdmUgdGhlIHZpcnRxdWV1ZSB3aXRo
IG5vIHdvcmtlcj8gT3IsIGRvZXMgaXQgcGljayB0aGUgZmlyc3QKPiA+Pj4+IHdvcmtlciBpdCBm
aW5kcz8gSWYgdGhlcmUgaXMgbm8gd29ya2VyIGJlY2F1c2Ugd2UgZGlkIHRoZSBmb3JtZXIgb3IK
PiA+Pj4+IGJlY2F1c2UgdXNlcnNwYWNlIGRldGFjaGVkIGFsbCBvZiB0aGVtLCB0aGVuIGRvIHdl
IGp1c3QgZHJvcCB3b3JrIHRoYXQKPiA+Pj4+IGdldHMgcXVldWVkPwo+ID4+Pj4KPiA+Pj4+IEl0
IHNlZW1lZCBsaWtlIGEgdXNlciB3b3VsZCBuZXZlciB3YW50IHRvIGRyb3Agd29yaywgc28gSSBt
YWRlIGl0IHNvCj4gPj4+PiB5b3UgY2FuIG9ubHkgdGVsbCBpdCB0byB1c2UgbmV3IHdvcmtlcnMg
KGF0dGFjaCB3aGljaCBJIGd1ZXNzIGlzIG1vcmUKPiA+Pj4+IGxpa2UgYSBzd2FwIHdvcmtlcikK
PiA+Pj4KPiA+Pj4gc3dhcCBhbmQgZnJlZSBvbGQgd29ya2VyIGluZGVlZD8KPiA+Pgo+ID4+IEkg
ZGlkbid0IHVuZGVyc3RhbmQgdGhlIHF1ZXN0aW9uLgo+ID4KPiA+IEkgbWVhbiBpZiBJIHVuZGVy
c3RhbmQgdGhlIGNvZGUgY29ycmVjdGx5LCB0aGUgY29kZSB0cmllcyB0byBkcm9wCj4gPiByZWZj
bnQgYW5kIGZyZWUgdGhlIG9sZCB3b3JrZXIgZHVyaW5nIGF0dGFjaC4KPgo+IEkgc2VlLiBXZSBh
Y3R1YWxseSBkb24ndCBmcmVlIHVudGlsIFZIT1NUX0ZSRUVfV09SS0VSLgo+Cj4gV2hlbiB3ZSBj
cmVhdGUgdGhlIHdvcmtlciBmcm9tIFZIT1NUX05FV19XT1JLRVIgd2Ugc2V0IHRoZSByZWZjb3Vu
dAo+IHRvIDEuIFRoZW4gZWFjaCB0aW1lIGEgdmlydHF1ZXVlIGFuZCB3b3JrZXIgYXJlIGF0dGFj
aGVkIHRvIGVhY2ggb3RoZXIKPiB3ZSBpbmNyZWFzZSB0aGUgcmVmY291bnQuCj4KPiBXaGVuIHlv
dSBkbyB2aG9zdF92cV9kZXRhY2hfd29ya2VyIHRoZW4gaXQgZHJvcHMgdGhlIHJlZmNvdW50IGZy
b20gdGhlCj4gYXR0YWNoLiBUaGVuIGlmIHlvdSBkZXRhY2hlZCB0aGUgd29ya2VyIGZyb20gYWxs
IHRoZSB2aXJ0cXVldWVzIHlvdQo+IHN0aWxsIGhhdmUgdGhlIHJlZmNvdW50PTEgZnJvbSB0aGUg
VkhPU1RfTkVXX1dPUktFUiBjYWxsLgo+Cj4gVGhlIHJlZmNvdW50IGRlY3JlbWVudCBpbiBWSE9T
VF9GUkVFX1dPUktFUiB2aWEgdmhvc3Rfd29ya2VyX3B1dCB3b3VsZAo+IGJlIHRoZSBmaW5hbCBw
dXQuIE5vdGUgdGhhdCBpZiB1c2Vyc3BhY2UganVzdCBjbG9zZXMgdGhlIGRldiB3aXRob3V0Cj4g
ZG9pbmcgYSBwdXQsIHRoZW4gd2UgZG8gdGhlIGZpbmFsIHB1dHMgZm9yIGl0LgoKUmlnaHQsIEkg
bWlzLXJlYWQgdGhlIGNvZGUsIHlvdSBkaWQKCiAgICAgICAgLyoKICAgICAgICAgKiBXZSBjYW4g
ZnJlZSB0aGUgd29ya2VyIGlmIGl0J3Mgbm90IGF0dGFjaGVkIHRvIGFueSB2aXJ0cXVldWVzLgog
ICAgICAgICAqLwogICAgICAgIGlmIChyZWZjb3VudF9yZWFkKCZ3b3JrZXItPnJlZmNvdW50KSAh
PSAxKQogICAgICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsKCkFuZCBJIHRob3VnaHQgaXQgd2Fz
IGEgZGVjIGFuZCB0ZXN0LgoKPgo+IE5vdGUgdGhhdCBJIG9yaWdpbmFsbHkgZGlkbid0IGhhdmUg
dGhlIGZyZWUuIEkgZG9uJ3QgbmVlZCBpdCBmb3IgYW55Cj4gc3BlY2lmaWMgcmVhc29uLiBJdCB3
YXMganVzdCBmcm9tIGEgcmV2aWV3IGNvbW1lbnQuIEkgb3JpZ2luYWxseSBqdXN0IGhhZAo+IHRo
ZSBvbmUgY3JlYXRlIHdvcmtlciB0eXBlIG9mIGlvY3RsLiBUaGVuIGl0IHdhcyBzdWdnZXN0ZWQg
dG8gZG8gdGhlIHNwbGl0Cj4gYXR0YWNoL25ldy9mcmVlIGRlc2lnbi4KCkkgc2VlLgoKPgo+IEkg
Y2FuIHNwaW4gYW5vdGhlciBwYXRjaHNldCB3aXRoIHRoZSBzaW5nbGUgaW9jdGwgZGVzaWduIHNv
IHdlIGNhbiBjb21wYXJlLgoKU28gSSdtIGZpbmUgd2l0aCB0aGlzIGFwcHJvYWNoLiBPbmUgbGFz
dCBxdWVzdGlvbiwgSSBzZWUgdGhpczoKCi8qIEJ5IGRlZmF1bHQsIGEgZGV2aWNlIGdldHMgb25l
IHZob3N0X3dvcmtlciB0aGF0IGl0cyB2aXJ0cXVldWVzIHNoYXJlLiBUaGlzICovCgpJJ20gd29u
ZGVyaW5nIGlmIGl0IGlzIGJldHRlciB0byBoYXZlIGEgdmhvc3RfZ2V0X3dvcmtlcigpIHRvIHJl
dHVybgp0aGUgd29ya2VyX2lkIG9mIGEgc3BlY2lmaWMgcXVldWUuIEluIHRoZSBmdXR1cmUsIHRo
aXMgbWlnaHQgYmUgdXNlZnVsCmZvciBkZXZpY2VzIHRoYXQgaGF2ZSBtdWx0aXBsZSB3b3JrZXJz
IGJ5IGRlZmF1bHQ/CgpUaGFua3MKCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
