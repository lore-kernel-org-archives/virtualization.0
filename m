Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C496DC77B72
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 04:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 40722400CB;
	Thu, 20 Apr 2023 04:06:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 40722400CB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TcAjbXf4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FKLZo9ntvIJl; Thu, 20 Apr 2023 04:06:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D2B17400D1;
	Thu, 20 Apr 2023 04:06:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D2B17400D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB3A7C0036;
	Thu, 20 Apr 2023 04:06:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0955C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 04:06:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A7737400D1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 04:06:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A7737400D1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WheSgUE5Psj8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 04:06:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD746400CB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD746400CB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 04:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681963599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+PcrQmhA5a7Qy66EfXDRyvtBeGDrU5rKrslFVh6JTc=;
 b=TcAjbXf4nZ8pGoY/SEswOY7SrGgsZ32YD5g6k0WTsOADTt16J3qfVhhCSPWP+d38cr2fPP
 Npxqb7unbb0sSaX8CevxOUI6meXFNmc+bGlOuH5cwzWS4GWlQw62v1doe1CEnXpENiu1Fs
 lqEUeoKm4E5si4KBhjJ788JLFIkzwrA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-Cxs28sAfO92oC50YosNuKw-1; Thu, 20 Apr 2023 00:06:30 -0400
X-MC-Unique: Cxs28sAfO92oC50YosNuKw-1
Received: by mail-oi1-f200.google.com with SMTP id
 q131-20020acaf289000000b0038c2e02a94eso25897oih.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 21:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681963589; x=1684555589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l+PcrQmhA5a7Qy66EfXDRyvtBeGDrU5rKrslFVh6JTc=;
 b=PDxsMI41eQRdmAS8qBagLJahreVr0CM5hmmEcJW27DNl5VzuRsEJpDoLGONUU2dCsX
 UTf/gq8x5fGmJ/S3Xz62kzkTYIGs/H5UxAoXoyiLNQYilSJNIbTruoKU2ApsyWCBdFVv
 b49Xy3XmB517V2mzAoOVosRsJ3rIAOs7K+DTB/64SqBzG38reAPdcL4fF6KreMCL+JO0
 uRx7UTaGGQUYud5uhK6lUD8LJXmptT+CNi4ZwqKvhGctgtq6Aj1itnwDqmYi12/xCW0i
 0cvIO/L/54TBl50K1C/pij9q8m07xZBHHsT3hIiu7akzmLIQZf5lKr6HFAYTvL6Z60O8
 Ut2g==
X-Gm-Message-State: AAQBX9e1+p6q0DjIqaDwdWN596kUWnpUqnRaUTQLmOzKdAG5p+jj3XSv
 ya7B322dsKsUPhx0//nkALpTTv2P3qJCQFlsFCXoGzxf3FSQjB2oX8fJsteMrbSinuQS5YOL7M1
 FvXwDNEkZjqVg+RAl4eOWggtWE1kBNRdkgTfrhG4K7iW1Gt3fJR85N18nDA==
X-Received: by 2002:a4a:4fc5:0:b0:545:c9f3:3aa7 with SMTP id
 c188-20020a4a4fc5000000b00545c9f33aa7mr231998oob.3.1681963589524; 
 Wed, 19 Apr 2023 21:06:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350almE7OZ2hK3i9wG2F1V/HOEwI3f3+Wk4eBkkfDJJpZ3JxHt5qBliBBQkn1VfqZwPfdNNE8xFhWXkirCdQALzI=
X-Received: by 2002:a4a:4fc5:0:b0:545:c9f3:3aa7 with SMTP id
 c188-20020a4a4fc5000000b00545c9f33aa7mr231983oob.3.1681963589276; Wed, 19 Apr
 2023 21:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230419134329.346825-1-maxime.coquelin@redhat.com>
 <20230419134329.346825-2-maxime.coquelin@redhat.com>
In-Reply-To: <20230419134329.346825-2-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Apr 2023 12:06:18 +0800
Message-ID: <CACGkMEtooodqB9pSGTQJx4x55-+RqPhNhT5_4zSDMiCSJXyjVg@mail.gmail.com>
Subject: Re: [RFC 1/2] vduse: validate block features only with block devices
To: Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, eperezma@redhat.com, david.marchand@redhat.com
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

T24gV2VkLCBBcHIgMTksIDIwMjMgYXQgOTo0M+KAr1BNIE1heGltZSBDb3F1ZWxpbgo8bWF4aW1l
LmNvcXVlbGluQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gVGhpcyBwYXRjaCBpcyBwcmVsaW1pbmFy
eSB3b3JrIHRvIGVuYWJsZSBuZXR3b3JrIGRldmljZQo+IHR5cGUgc3VwcG9ydCB0byBWRFVTRS4K
Pgo+IEFzIFZJUlRJT19CTEtfRl9DT05GSUdfV0NFIHNoYXJlcyB0aGUgc2FtZSB2YWx1ZSBhcwo+
IFZJUlRJT19ORVRfRl9IT1NUX1RTTzQsIHdlIG5lZWQgdG8gcmVzdHJpY3QgaXRzIGNoZWNrCj4g
dG8gVmlydGlvLWJsayBkZXZpY2UgdHlwZS4KPgo+IFNpZ25lZC1vZmYtYnk6IE1heGltZSBDb3F1
ZWxpbiA8bWF4aW1lLmNvcXVlbGluQHJlZGhhdC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvdmRwYS92
ZHBhX3VzZXIvdmR1c2VfZGV2LmMgfCA5ICsrKysrLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRw
YS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rl
di5jCj4gaW5kZXggMGMzYjQ4NjE2YTlmLi42ZmE1OThhMDNkOGUgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBh
X3VzZXIvdmR1c2VfZGV2LmMKPiBAQCAtMTQxNiwxMyArMTQxNiwxNCBAQCBzdGF0aWMgYm9vbCBk
ZXZpY2VfaXNfYWxsb3dlZCh1MzIgZGV2aWNlX2lkKQo+ICAgICAgICAgcmV0dXJuIGZhbHNlOwo+
ICB9Cj4KPiAtc3RhdGljIGJvb2wgZmVhdHVyZXNfaXNfdmFsaWQodTY0IGZlYXR1cmVzKQo+ICtz
dGF0aWMgYm9vbCBmZWF0dXJlc19pc192YWxpZChzdHJ1Y3QgdmR1c2VfZGV2X2NvbmZpZyAqY29u
ZmlnKQo+ICB7Cj4gLSAgICAgICBpZiAoIShmZWF0dXJlcyAmICgxVUxMIDw8IFZJUlRJT19GX0FD
Q0VTU19QTEFURk9STSkpKQo+ICsgICAgICAgaWYgKCEoY29uZmlnLT5mZWF0dXJlcyAmICgxVUxM
IDw8IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkpKQo+ICAgICAgICAgICAgICAgICByZXR1cm4g
ZmFsc2U7Cj4KPiAgICAgICAgIC8qIE5vdyB3ZSBvbmx5IHN1cHBvcnQgcmVhZC1vbmx5IGNvbmZp
Z3VyYXRpb24gc3BhY2UgKi8KPiAtICAgICAgIGlmIChmZWF0dXJlcyAmICgxVUxMIDw8IFZJUlRJ
T19CTEtfRl9DT05GSUdfV0NFKSkKPiArICAgICAgIGlmICgoY29uZmlnLT5kZXZpY2VfaWQgPT0g
VklSVElPX0lEX0JMT0NLKSAmJgo+ICsgICAgICAgICAgICAgICAgICAgICAgIChjb25maWctPmZl
YXR1cmVzICYgKDFVTEwgPDwgVklSVElPX0JMS19GX0NPTkZJR19XQ0UpKSkKClRoZSByZWFzb24g
d2UgZmlsdGVyIFdDRSBvdXQgaXMgdG8gYXZvaWQgd3JpdGFibGUgY29uZmlnIHNwYWNlIHdoaWNo
Cm1pZ2h0IGJsb2NrIHRoZSBkcml2ZXIgd2l0aCBhIGJ1Z2d5IHVzZXJzcGFjZS4KCkZvciBuZXR3
b3JraW5nLCBJIGd1ZXNzIHdlIHNob3VsZCBmYWlsIGlmIFZFUlNJT05fMSBpcyBub3QgbmVnb3Rp
YXRlZCwKdGhlbiB3ZSBjYW4gYXZvaWQgc2V0dGluZyBtYWMgYWRkcmVzc2VzIHZpYSB0aGUgY29u
ZmlnIHNwYWNlLgoKVGhhbmtzCgo+ICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7Cj4KPiAg
ICAgICAgIHJldHVybiB0cnVlOwo+IEBAIC0xNDQ2LDcgKzE0NDcsNyBAQCBzdGF0aWMgYm9vbCB2
ZHVzZV92YWxpZGF0ZV9jb25maWcoc3RydWN0IHZkdXNlX2Rldl9jb25maWcgKmNvbmZpZykKPiAg
ICAgICAgIGlmICghZGV2aWNlX2lzX2FsbG93ZWQoY29uZmlnLT5kZXZpY2VfaWQpKQo+ICAgICAg
ICAgICAgICAgICByZXR1cm4gZmFsc2U7Cj4KPiAtICAgICAgIGlmICghZmVhdHVyZXNfaXNfdmFs
aWQoY29uZmlnLT5mZWF0dXJlcykpCj4gKyAgICAgICBpZiAoIWZlYXR1cmVzX2lzX3ZhbGlkKGNv
bmZpZykpCj4gICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsKPgo+ICAgICAgICAgcmV0dXJu
IHRydWU7Cj4gLS0KPiAyLjM5LjIKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
