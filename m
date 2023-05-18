Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B26C7EE23
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 07:34:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 37E824028D;
	Thu, 18 May 2023 07:34:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 37E824028D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bssVNmBw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tAnSO0sJsE4p; Thu, 18 May 2023 07:34:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 84BD340436;
	Thu, 18 May 2023 07:34:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 84BD340436
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38230C0037;
	Thu, 18 May 2023 07:34:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FC5AC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 07:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E137160FD9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 07:34:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E137160FD9
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bssVNmBw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rYT7-xIWnQYv
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 07:34:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6E23C60AF2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E23C60AF2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 07:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684395281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGfYYZuZY/f63iG6V5m88rsKvN/sC7BR/61qrQbXORk=;
 b=bssVNmBw7m6yx3aloMiw9NIYz11lCZiDIPyiIVlC/Q6nJMl6vZOJlJFCf1omMOkZv97U4+
 Q910YfpFPyhDH21cSdBWP8KZmFBq1dC9KSao+e3/BpMwfXiv8N3RjmNyORMKZQnBV89I+e
 X5tYQTHkUGLCccDcBrlcvsLS0b2f/PU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-D6RUYb3vNzSLIu90HVJdEQ-1; Thu, 18 May 2023 03:34:37 -0400
X-MC-Unique: D6RUYb3vNzSLIu90HVJdEQ-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-561ceb5b584so28323787b3.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 00:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684395276; x=1686987276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xGfYYZuZY/f63iG6V5m88rsKvN/sC7BR/61qrQbXORk=;
 b=QnDRQujggGOqjrW4jnFWcp3U6tIPViUe5zeQCBUqFcqp2Tm10OhtNy5D2pWLm/qFm5
 uB5JjsoGm0pZU4W9hHBZmih8T1z/MZ3f2/KTvvTOxUJ0qmsu7zR8cIhb+a0s/LIOc+ce
 5fsWohOQJS55thKwW1oZK3HFc2WczTWFYBv++RnkuhY8BDMHqRE0ZyYPzxhPB58z6C5B
 4Zyac1QEQCMQc4XzsO0ETJr+PV+0tQkLJJR+s+Ru4xhXJIOllnQk90Ks3j3aw15xtG/m
 xgcsfAjb8ybAhGtRD88iLgUwXxNkQLrFmry293yEorYbZn0IaRjZL6V8v9Rdmeg5bUdr
 /whA==
X-Gm-Message-State: AC+VfDz2osmmAd0kXWy43OTIzBkV384bgraCuaOIjgPFehjYKdDjDlEk
 I3SluDh+XRtXs+uPUlmlVM87S8OG8LmHzuPeGOttIRHRZQsa5B/8eZ7uoCHP9AlVIX8zk7qjvv/
 zxBblJZfGdN1zBNCALACUGFiswSsAzBm2sSJNSEY4f8lCSRb7o4UWMCMGVsLFNgc7B2Yv
X-Received: by 2002:a81:6fd7:0:b0:544:9180:3104 with SMTP id
 k206-20020a816fd7000000b0054491803104mr583420ywc.34.1684395276554; 
 Thu, 18 May 2023 00:34:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5nvsZGf/9E5jDJFGZKaIWKsnErvr/AMNpi4hd54dbNyr9HSeGE9UWhOM7qqnmNix7I1z+nj+B75F1XvYHahRs=
X-Received: by 2002:a81:6fd7:0:b0:544:9180:3104 with SMTP id
 k206-20020a816fd7000000b0054491803104mr583409ywc.34.1684395276316; Thu, 18
 May 2023 00:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230424225031.18947-1-shannon.nelson@amd.com>
 <20230424225031.18947-3-shannon.nelson@amd.com>
 <ogzrlfid7jwfzgk42zffegaq4xhdsrpi6vu22333ub4bkmvpc3@3pa2eyzub3jn>
 <58f93ced-2f2b-dba1-b8a3-96bdb755d54e@amd.com>
 <q6cmfha36sdkgflwwd3pr4sw7rgajag4ahgjbpfjrr76w4o2b6@3yc7zs5u65s4>
 <dcfb15e6-a4c9-cb91-becd-a1e56e14d340@amd.com>
 <CACGkMEsNo4O0uAdO5koXgYbgQLoOWp81KNjsaZYSuQ7YzjvPbA@mail.gmail.com>
 <CAGxU2F4kwnGq41q99nx879Y4Br=0aeZsf2bjx2ZqpOc93G_gDQ@mail.gmail.com>
 <CACGkMEsi0Vu21ZX2WZuEWNKQ4KTGA1iNb6+8SHeCb+Penqxr8g@mail.gmail.com>
In-Reply-To: <CACGkMEsi0Vu21ZX2WZuEWNKQ4KTGA1iNb6+8SHeCb+Penqxr8g@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 18 May 2023 09:34:25 +0200
Message-ID: <CAGxU2F63yQuc-eefSkEKZKZUxpnS4myGhNP2Bkj+QQk01Pi_yg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] vhost: support PACKED when setting-getting
 vring_base
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: drivers@pensando.io, mst@redhat.com,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVGh1LCBNYXkgMTgsIDIwMjMgYXQgNzoyNOKAr0FNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gV2VkLCBNYXkgMTcsIDIwMjMgYXQgMzowMOKAr1BNIFN0
ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24g
V2VkLCBNYXkgMTcsIDIwMjMgYXQgNzoyNuKAr0FNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBXZWQsIE1heSAxNywgMjAyMyBhdCAyOjI24oCv
QU0gU2hhbm5vbiBOZWxzb24gPHNoYW5ub24ubmVsc29uQGFtZC5jb20+IHdyb3RlOgo+ID4gPiA+
Cj4gPiA+ID4gT24gNS8xNi8yMyAxMjo0OSBBTSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+
ID4gPiA+ID4gT24gTW9uLCBNYXkgMTUsIDIwMjMgYXQgMDE6NDE6MTJQTSAtMDcwMCwgU2hhbm5v
biBOZWxzb24gd3JvdGU6Cj4gPiA+ID4gPj4gT24gNS85LzIzIDE6NDYgQU0sIFN0ZWZhbm8gR2Fy
emFyZWxsYSB3cm90ZToKPiA+ID4gPiA+Pj4gT24gTW9uLCBBcHIgMjQsIDIwMjMgYXQgMDM6NTA6
MzBQTSAtMDcwMCwgU2hhbm5vbiBOZWxzb24gdmlhCj4gPiA+ID4gPj4+IFZpcnR1YWxpemF0aW9u
IHdyb3RlOgo+ID4gPiA+ID4+Pj4gVXNlIHRoZSByaWdodCBzdHJ1Y3RzIGZvciBQQUNLRUQgb3Ig
c3BsaXQgdnFzIHdoZW4gc2V0dGluZyBhbmQKPiA+ID4gPiA+Pj4+IGdldHRpbmcgdGhlIHZyaW5n
IGJhc2UuCj4gPiA+ID4gPj4+Pgo+ID4gPiA+ID4+Pj4gU2lnbmVkLW9mZi1ieTogU2hhbm5vbiBO
ZWxzb24gPHNoYW5ub24ubmVsc29uQGFtZC5jb20+Cj4gPiA+ID4gPj4+PiAtLS0KPiA+ID4gPiA+
Pj4+IGRyaXZlcnMvdmhvc3Qvdmhvc3QuYyB8IDE4ICsrKysrKysrKysrKystLS0tLQo+ID4gPiA+
ID4+Pj4gZHJpdmVycy92aG9zdC92aG9zdC5oIHwgIDggKysrKysrLS0KPiA+ID4gPiA+Pj4+IDIg
ZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPiA+ID4gPiA+
Pj4+Cj4gPiA+ID4gPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92aG9zdC5jIGIvZHJp
dmVycy92aG9zdC92aG9zdC5jCj4gPiA+ID4gPj4+PiBpbmRleCBmMTFiZGJlNGMyYzUuLmY2NGVm
ZGE0OGYyMSAxMDA2NDQKPiA+ID4gPiA+Pj4+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+
ID4gPiA+ID4+Pj4gKysrIGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gPiA+ID4gPj4+PiBAQCAt
MTYzMywxNyArMTYzMywyNSBAQCBsb25nIHZob3N0X3ZyaW5nX2lvY3RsKHN0cnVjdCB2aG9zdF9k
ZXYKPiA+ID4gPiA+Pj4+ICpkLCB1bnNpZ25lZCBpbnQgaW9jdGwsIHZvaWQgX191c2VyICphcmcK
PiA+ID4gPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICByID0gLUVGQVVMVDsKPiA+ID4gPiA+
Pj4+ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+ID4gPiA+Pj4+ICAgICAgICAgICAg
ICAgfQo+ID4gPiA+ID4+Pj4gLSAgICAgICAgICAgICAgaWYgKHMubnVtID4gMHhmZmZmKSB7Cj4g
PiA+ID4gPj4+PiAtICAgICAgICAgICAgICAgICAgICAgIHIgPSAtRUlOVkFMOwo+ID4gPiA+ID4+
Pj4gLSAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+ID4gPiA+Pj4+ICsgICAgICAgICAg
ICAgIGlmICh2aG9zdF9oYXNfZmVhdHVyZSh2cSwgVklSVElPX0ZfUklOR19QQUNLRUQpKSB7Cj4g
PiA+ID4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgIHZxLT5sYXN0X2F2YWlsX2lkeCA9IHMu
bnVtICYgMHhmZmZmOwo+ID4gPiA+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICB2cS0+bGFz
dF91c2VkX2lkeCA9IChzLm51bSA+PiAxNikgJiAweGZmZmY7Cj4gPiA+ID4gPj4+PiArICAgICAg
ICAgICAgICB9IGVsc2Ugewo+ID4gPiA+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICBpZiAo
cy5udW0gPiAweGZmZmYpIHsKPiA+ID4gPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICByID0gLUVJTlZBTDsKPiA+ID4gPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBicmVhazsKPiA+ID4gPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgfQo+ID4gPiA+
ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICB2cS0+bGFzdF9hdmFpbF9pZHggPSBzLm51bTsK
PiA+ID4gPiA+Pj4+ICAgICAgICAgICAgICAgfQo+ID4gPiA+ID4+Pj4gLSAgICAgICAgICAgICAg
dnEtPmxhc3RfYXZhaWxfaWR4ID0gcy5udW07Cj4gPiA+ID4gPj4+PiAgICAgICAgICAgICAgIC8q
IEZvcmdldCB0aGUgY2FjaGVkIGluZGV4IHZhbHVlLiAqLwo+ID4gPiA+ID4+Pj4gICAgICAgICAg
ICAgICB2cS0+YXZhaWxfaWR4ID0gdnEtPmxhc3RfYXZhaWxfaWR4Owo+ID4gPiA+ID4+Pj4gICAg
ICAgICAgICAgICBicmVhazsKPiA+ID4gPiA+Pj4+ICAgICAgIGNhc2UgVkhPU1RfR0VUX1ZSSU5H
X0JBU0U6Cj4gPiA+ID4gPj4+PiAgICAgICAgICAgICAgIHMuaW5kZXggPSBpZHg7Cj4gPiA+ID4g
Pj4+PiAtICAgICAgICAgICAgICBzLm51bSA9IHZxLT5sYXN0X2F2YWlsX2lkeDsKPiA+ID4gPiA+
Pj4+ICsgICAgICAgICAgICAgIGlmICh2aG9zdF9oYXNfZmVhdHVyZSh2cSwgVklSVElPX0ZfUklO
R19QQUNLRUQpKQo+ID4gPiA+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICBzLm51bSA9ICh1
MzIpdnEtPmxhc3RfYXZhaWxfaWR4IHwKPiA+ID4gPiA+Pj4+ICgodTMyKXZxLT5sYXN0X3VzZWRf
aWR4IDw8IDE2KTsKPiA+ID4gPiA+Pj4+ICsgICAgICAgICAgICAgIGVsc2UKPiA+ID4gPiA+Pj4+
ICsgICAgICAgICAgICAgICAgICAgICAgcy5udW0gPSB2cS0+bGFzdF9hdmFpbF9pZHg7Cj4gPiA+
ID4gPj4+Cj4gPiA+ID4gPj4+IFRoZSBjaGFuZ2VzIExHVE0sIGJ1dCBzaW5jZSB3ZSBhcmUgY2hh
bmdpbmcgdGhlIFVBUEksIHNob3VsZCB3ZQo+ID4gPiA+ID4+PiB1cGRhdGUgdGhlIGRvY3VtZW50
YXRpb24gb2YgVkhPU1RfU0VUX1ZSSU5HX0JBU0UgYW5kCj4gPiA+ID4gPj4+IFZIT1NUX0dFVF9W
UklOR19CQVNFIGluIGluY2x1ZGUvdWFwaS9saW51eC92aG9zdC5oPwo+ID4gPiA+ID4+Cj4gPiA+
ID4gPj4gQ29ycmVjdCBtZSBpZiBJJ20gd3JvbmcsIGJ1dCBJIGRvbid0IHRoaW5rIHdlJ3JlIGNo
YW5naW5nIGFueXRoaW5nIGluCj4gPiA+ID4gPj4gdGhlIFVBUEkgaGVyZSwganVzdCBmaXhpbmcg
Y29kZSB0byB3b3JrIGNvcnJlY3RseSB3aXRoIHdoYXQgaXMgYWxyZWFkeQo+ID4gPiA+ID4+IGhh
cHBlbmluZy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBJSVVDIGJlZm9yZSB0aGlzIHBhdGNoIFZIT1NU
X0dFVF9WUklOR19CQVNFIGFuZCBWSE9TVF9TRVRfVlJJTkdfQkFTRQo+ID4gPiA+ID4gbmV2ZXIg
d29ya2VkIHdpdGggcGFja2VkIHZpcnRxdWV1ZSwgc2luY2Ugd2Ugd2VyZSBvbmx5IGhhbmRsaW5n
Cj4gPiA+ID4gPiBsYXN0X2F2YWlsX2lkeC4gTm93IHdlIGFyZSBzdXBwb3J0aW5nIHBhY2tlZCB2
aXJ0cXVldWUsIGhhbmRsaW5nCj4gPiA+ID4gPiBpbiB2aG9zdF92cmluZ19zdGF0ZS5udW0gYm90
aCBsYXN0X2F2YWlsX2lkeCBhbmQgbGFzdF91c2VkX2lkeCAod2l0aAo+ID4gPiA+ID4gd3JhcCBj
b3VudGVycykuCj4gPiA+ID4gPgo+ID4gPiA+ID4gRm9yIGV4YW1wbGUgZm9yIFZIT1NUX0dFVF9W
UklOR19CQVNFIHdoZXJlIGlzIGRvY3VtZW50ZWQgdGhhdCB0aGUgZmlyc3QKPiA+ID4gPiA+IDE1
IGJpdHMgYXJlIGxhc3RfYXZhaWxfaWR4LCB0aGUgMTZ0aCB0aGUgYXZhaWxfd3JhcF9jb3VudGVy
LCBhbmQgdGhlCj4gPiA+ID4gPiBvdGhlcnMgYXJlIGxhc3RfdXNlZF9pZHggYW5kIHVzZWRfd3Jh
cF9jb3VudGVyPwo+ID4gPiA+ID4KPiA+ID4gPiA+IE1heWJlIEkgbWlzc2VkIHNvbWV0aGluZywg
YnV0IHNpbmNlIHRoaXMgaXMgVUFQSSwgSU1ITyB3ZSBzaG91bGQKPiA+ID4gPiA+IGRvY3VtZW50
IHRoZSBwYXJhbWV0ZXJzIG9mIGlvY3RscyBhdCBsZWFzdCBpbgo+ID4gPiA+ID4gaW5jbHVkZS91
YXBpL2xpbnV4L3Zob3N0LmguCj4gPiA+ID4KPiA+ID4gPiBQZXJoYXBzIEphc29uIGFscmVhZHkg
aGFzIHNvbWV0aGluZyB3cml0dGVuIHVwIHRoYXQgY291bGQgYmUgcHV0IGluIGhlcmUKPiA+ID4g
PiBmcm9tIHdoZW4gaGUgZmlyc3QgYWRkZWQgdGhlIHdyYXBfY291bnRlciBhIGNvdXBsZSBvZiB5
ZWFycyBhZ28/Cj4gPiA+Cj4gPiA+IElmIHlvdSBtZWFudCB0aGUgdmlydGlvIGRyaXZlciBzdXBw
b3J0IGZvciBwYWNrZWQsIEkgdGhpbmsgaXQncwo+ID4gPiBkaWZmZXJlbnQgZnJvbSB0aGUgY29u
dGV4dCB3aGljaCBpcyB2aG9zdCBoZXJlLgo+ID4gPgo+ID4gPiBJIGFncmVlIHdpdGggU3RlZmFu
byB0aGF0IHdlIG5lZWQgdG8gdXBkYXRlIHRoZSBjb21tZW50cyBhcm91bmQKPiA+ID4gR0VUX1ZS
SU5HX0JBU0UgYW5kIFNFVF9WUklOR19CQVNFLCB0aGVuIHdlIGFyZSBmaW5lLgo+ID4KPiA+IEkn
bSB0aGlua2luZyBpZiB3ZSBzaG91bGQgYWxzbyBhZGQgYSBuZXcgVkhPU1RfQkFDS0VORF9GX1JJ
TkdfUEFDS0VECj4gPiBmZWF0dXJlIChvciBzb21ldGhpbmcgc2ltaWxhcikgdG8gaW5mb3JtIHRo
ZSB1c2VyIHNwYWNlIHRoYXQgbm93IHdlCj4gPiBhcmUgYWJsZSB0byBoYW5kbGUgcGFja2VkIHZp
cnRxdWV1ZSB0aHJvdWdoIHZob3N0IElPQ1RMcywgb3RoZXJ3aXNlCj4gPiBob3cgY2FuIHRoZSB1
c2Vyc3BhY2Uga25vdyBpZiBpdCBpcyBzdXBwb3J0ZWQgb3Igbm90Pwo+Cj4gSSBwcm9iYWJseSB1
bmRlcnN0YW5kIHRoaXMgYnV0IEkgdGhpbmsgaXQgc2hvdWxkIGJlIGRvbmUgdmlhCj4gVkhPU1Rf
R0VUX0ZFQUVUVVJFUy4gSXQgd291bGQgYmUgYSBidXJkZW4gaWYgd2UgbWF0aWFuaW5nIGR1cGxp
Y2F0ZWQKPiBmZWF0dXJlcy4KCkdvb2QgcG9pbnQsIEkgc2VlLgoKSSB0aGluayB3ZSBzaG91bGQg
ZG8gb25lIG9mIHRoZXNlIHRoaW5ncywgdGhvdWdoOgotIG1hc2sgVklSVElPX0ZfUklOR19QQUNL
RUQgaW4gdGhlIHN0YWJsZSBrZXJuZWxzIHdoZW4KVkhPU1RfR0VUX0ZFQUVUVVJFUyBpcyBjYWxs
ZWQKLSBiYWNrcG9ydCB0aGlzIHBhdGNoIG9uIGFsbCBzdGFibGUga2VybmVscyB0aGF0IHN1cHBv
cnQgdmhvc3QtdmRwYQoKTWF5YmUgdGhlIGxhc3Qgb25lIG1ha2VzIG1vcmUgc2Vuc2UuCgpUaGFu
a3MsClN0ZWZhbm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
