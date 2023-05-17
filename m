Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2080C7EE23
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 07:00:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3918742006;
	Wed, 17 May 2023 07:00:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3918742006
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fs0nBC22
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZDMiTrmaiWu6; Wed, 17 May 2023 07:00:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4387342028;
	Wed, 17 May 2023 07:00:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4387342028
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BBC0C008A;
	Wed, 17 May 2023 07:00:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C26EC008B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 07:00:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D3F978426E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 07:00:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D3F978426E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fs0nBC22
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QA6QVaznLBSK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 07:00:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 141578426F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 141578426F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 07:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684306851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRWFI7cjs6b3B5+znN0s1qziBwdSZ/qyJ0GgmJJYZ1w=;
 b=fs0nBC22xr8bOMrs87zHUEqNCwm6j7pTFn+kJPfSj6dNB1L7ul536uu6FVKNtba+1BytTn
 r9EbW02oguPzUap5NfFcwFG2tmtq1JrRRKH7rN/VVgjx6XF+mDMh8utVrPr4KC8RiwpJ9a
 vu5GnLS0KeDJAqHsiSPVlD1BNeCov8Y=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-SIHCF_pjNIqyxWd7pfi5PA-1; Wed, 17 May 2023 03:00:49 -0400
X-MC-Unique: SIHCF_pjNIqyxWd7pfi5PA-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-ba2b9ecfadaso617548276.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 00:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684306849; x=1686898849;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fRWFI7cjs6b3B5+znN0s1qziBwdSZ/qyJ0GgmJJYZ1w=;
 b=Nl5o/dcHE9+gOJ2J5po9kdEp9PDMB7SPYHn6xTWpTK748GEVOobrvdtE/dqd2P6zNO
 VPdIHeVvv+GXaUyMHw7/YZgbULDH1XXDWRKausTQkOaPClsQLH/qRJ7PJIa42GsKkGqX
 cctI+H8kIuocZdfF0vtfa29YLlbP9If67juz457x29wBikULRxj/6VJlYzEv71rMNeaA
 9haBaIiFUR4BC6lDMHo8tfT5rcplKn0QMTDxVX49iw1gzEuQtOtstE+a64RnAqDTx9rK
 KH0ZGAXm26V1OIf41E1zXV7Mh+BZ4dk/k/JvGgOVN5ZvDDgVY8WH48pxPGwAuTDLrVkE
 HMIQ==
X-Gm-Message-State: AC+VfDxNgydu9kS7D0GoilTZfFKtKgGS4fnVn/0+GZy6IC4IF3tmnUlH
 ElgUBOh4HVX9G7a+ptblRo8tcv+gj15LXtih/xa3xzm+HB2uNTcD+HxYsTtvAZ6IH/Q56cTIo7V
 v5WHbL218XTyD0j8+HrkL5bbONNafCs/YBwbcnATYnKqVSMwB59kF8RHs1A==
X-Received: by 2002:a05:6902:1008:b0:b94:bbf1:fec7 with SMTP id
 w8-20020a056902100800b00b94bbf1fec7mr37731435ybt.47.1684306849070; 
 Wed, 17 May 2023 00:00:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4BZe/emPZ+D2+iKiNue7ocgtGgwEhfvWqMZMQ79c1gGGs7IYQcAppTuYuDbmqUBPpwN+W1hiphb6mxTijC4ew=
X-Received: by 2002:a05:6902:1008:b0:b94:bbf1:fec7 with SMTP id
 w8-20020a056902100800b00b94bbf1fec7mr37731420ybt.47.1684306848761; Wed, 17
 May 2023 00:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230424225031.18947-1-shannon.nelson@amd.com>
 <20230424225031.18947-3-shannon.nelson@amd.com>
 <ogzrlfid7jwfzgk42zffegaq4xhdsrpi6vu22333ub4bkmvpc3@3pa2eyzub3jn>
 <58f93ced-2f2b-dba1-b8a3-96bdb755d54e@amd.com>
 <q6cmfha36sdkgflwwd3pr4sw7rgajag4ahgjbpfjrr76w4o2b6@3yc7zs5u65s4>
 <dcfb15e6-a4c9-cb91-becd-a1e56e14d340@amd.com>
 <CACGkMEsNo4O0uAdO5koXgYbgQLoOWp81KNjsaZYSuQ7YzjvPbA@mail.gmail.com>
In-Reply-To: <CACGkMEsNo4O0uAdO5koXgYbgQLoOWp81KNjsaZYSuQ7YzjvPbA@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 17 May 2023 09:00:37 +0200
Message-ID: <CAGxU2F4kwnGq41q99nx879Y4Br=0aeZsf2bjx2ZqpOc93G_gDQ@mail.gmail.com>
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

T24gV2VkLCBNYXkgMTcsIDIwMjMgYXQgNzoyNuKAr0FNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gV2VkLCBNYXkgMTcsIDIwMjMgYXQgMjoyNuKAr0FNIFNo
YW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiA1
LzE2LzIzIDEyOjQ5IEFNLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gPiA+IE9uIE1vbiwg
TWF5IDE1LCAyMDIzIGF0IDAxOjQxOjEyUE0gLTA3MDAsIFNoYW5ub24gTmVsc29uIHdyb3RlOgo+
ID4gPj4gT24gNS85LzIzIDE6NDYgQU0sIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiA+ID4+
PiBPbiBNb24sIEFwciAyNCwgMjAyMyBhdCAwMzo1MDozMFBNIC0wNzAwLCBTaGFubm9uIE5lbHNv
biB2aWEKPiA+ID4+PiBWaXJ0dWFsaXphdGlvbiB3cm90ZToKPiA+ID4+Pj4gVXNlIHRoZSByaWdo
dCBzdHJ1Y3RzIGZvciBQQUNLRUQgb3Igc3BsaXQgdnFzIHdoZW4gc2V0dGluZyBhbmQKPiA+ID4+
Pj4gZ2V0dGluZyB0aGUgdnJpbmcgYmFzZS4KPiA+ID4+Pj4KPiA+ID4+Pj4gU2lnbmVkLW9mZi1i
eTogU2hhbm5vbiBOZWxzb24gPHNoYW5ub24ubmVsc29uQGFtZC5jb20+Cj4gPiA+Pj4+IC0tLQo+
ID4gPj4+PiBkcml2ZXJzL3Zob3N0L3Zob3N0LmMgfCAxOCArKysrKysrKysrKysrLS0tLS0KPiA+
ID4+Pj4gZHJpdmVycy92aG9zdC92aG9zdC5oIHwgIDggKysrKysrLS0KPiA+ID4+Pj4gMiBmaWxl
cyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+ID4gPj4+Pgo+ID4g
Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92aG9zdC5jIGIvZHJpdmVycy92aG9zdC92
aG9zdC5jCj4gPiA+Pj4+IGluZGV4IGYxMWJkYmU0YzJjNS4uZjY0ZWZkYTQ4ZjIxIDEwMDY0NAo+
ID4gPj4+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiA+ID4+Pj4gKysrIGIvZHJpdmVy
cy92aG9zdC92aG9zdC5jCj4gPiA+Pj4+IEBAIC0xNjMzLDE3ICsxNjMzLDI1IEBAIGxvbmcgdmhv
c3RfdnJpbmdfaW9jdGwoc3RydWN0IHZob3N0X2Rldgo+ID4gPj4+PiAqZCwgdW5zaWduZWQgaW50
IGlvY3RsLCB2b2lkIF9fdXNlciAqYXJnCj4gPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICBy
ID0gLUVGQVVMVDsKPiA+ID4+Pj4gICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4gPj4+
PiAgICAgICAgICAgICAgIH0KPiA+ID4+Pj4gLSAgICAgICAgICAgICAgaWYgKHMubnVtID4gMHhm
ZmZmKSB7Cj4gPiA+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgciA9IC1FSU5WQUw7Cj4gPiA+
Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gPiA+Pj4+ICsgICAgICAgICAgICAg
IGlmICh2aG9zdF9oYXNfZmVhdHVyZSh2cSwgVklSVElPX0ZfUklOR19QQUNLRUQpKSB7Cj4gPiA+
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgdnEtPmxhc3RfYXZhaWxfaWR4ID0gcy5udW0gJiAw
eGZmZmY7Cj4gPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgdnEtPmxhc3RfdXNlZF9pZHgg
PSAocy5udW0gPj4gMTYpICYgMHhmZmZmOwo+ID4gPj4+PiArICAgICAgICAgICAgICB9IGVsc2Ug
ewo+ID4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgIGlmIChzLm51bSA+IDB4ZmZmZikgewo+
ID4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgciA9IC1FSU5WQUw7Cj4gPiA+
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+ID4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICB9Cj4gPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgdnEtPmxh
c3RfYXZhaWxfaWR4ID0gcy5udW07Cj4gPiA+Pj4+ICAgICAgICAgICAgICAgfQo+ID4gPj4+PiAt
ICAgICAgICAgICAgICB2cS0+bGFzdF9hdmFpbF9pZHggPSBzLm51bTsKPiA+ID4+Pj4gICAgICAg
ICAgICAgICAvKiBGb3JnZXQgdGhlIGNhY2hlZCBpbmRleCB2YWx1ZS4gKi8KPiA+ID4+Pj4gICAg
ICAgICAgICAgICB2cS0+YXZhaWxfaWR4ID0gdnEtPmxhc3RfYXZhaWxfaWR4Owo+ID4gPj4+PiAg
ICAgICAgICAgICAgIGJyZWFrOwo+ID4gPj4+PiAgICAgICBjYXNlIFZIT1NUX0dFVF9WUklOR19C
QVNFOgo+ID4gPj4+PiAgICAgICAgICAgICAgIHMuaW5kZXggPSBpZHg7Cj4gPiA+Pj4+IC0gICAg
ICAgICAgICAgIHMubnVtID0gdnEtPmxhc3RfYXZhaWxfaWR4Owo+ID4gPj4+PiArICAgICAgICAg
ICAgICBpZiAodmhvc3RfaGFzX2ZlYXR1cmUodnEsIFZJUlRJT19GX1JJTkdfUEFDS0VEKSkKPiA+
ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICBzLm51bSA9ICh1MzIpdnEtPmxhc3RfYXZhaWxf
aWR4IHwKPiA+ID4+Pj4gKCh1MzIpdnEtPmxhc3RfdXNlZF9pZHggPDwgMTYpOwo+ID4gPj4+PiAr
ICAgICAgICAgICAgICBlbHNlCj4gPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgcy5udW0g
PSB2cS0+bGFzdF9hdmFpbF9pZHg7Cj4gPiA+Pj4KPiA+ID4+PiBUaGUgY2hhbmdlcyBMR1RNLCBi
dXQgc2luY2Ugd2UgYXJlIGNoYW5naW5nIHRoZSBVQVBJLCBzaG91bGQgd2UKPiA+ID4+PiB1cGRh
dGUgdGhlIGRvY3VtZW50YXRpb24gb2YgVkhPU1RfU0VUX1ZSSU5HX0JBU0UgYW5kCj4gPiA+Pj4g
VkhPU1RfR0VUX1ZSSU5HX0JBU0UgaW4gaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0Lmg/Cj4gPiA+
Pgo+ID4gPj4gQ29ycmVjdCBtZSBpZiBJJ20gd3JvbmcsIGJ1dCBJIGRvbid0IHRoaW5rIHdlJ3Jl
IGNoYW5naW5nIGFueXRoaW5nIGluCj4gPiA+PiB0aGUgVUFQSSBoZXJlLCBqdXN0IGZpeGluZyBj
b2RlIHRvIHdvcmsgY29ycmVjdGx5IHdpdGggd2hhdCBpcyBhbHJlYWR5Cj4gPiA+PiBoYXBwZW5p
bmcuCj4gPiA+Cj4gPiA+IElJVUMgYmVmb3JlIHRoaXMgcGF0Y2ggVkhPU1RfR0VUX1ZSSU5HX0JB
U0UgYW5kIFZIT1NUX1NFVF9WUklOR19CQVNFCj4gPiA+IG5ldmVyIHdvcmtlZCB3aXRoIHBhY2tl
ZCB2aXJ0cXVldWUsIHNpbmNlIHdlIHdlcmUgb25seSBoYW5kbGluZwo+ID4gPiBsYXN0X2F2YWls
X2lkeC4gTm93IHdlIGFyZSBzdXBwb3J0aW5nIHBhY2tlZCB2aXJ0cXVldWUsIGhhbmRsaW5nCj4g
PiA+IGluIHZob3N0X3ZyaW5nX3N0YXRlLm51bSBib3RoIGxhc3RfYXZhaWxfaWR4IGFuZCBsYXN0
X3VzZWRfaWR4ICh3aXRoCj4gPiA+IHdyYXAgY291bnRlcnMpLgo+ID4gPgo+ID4gPiBGb3IgZXhh
bXBsZSBmb3IgVkhPU1RfR0VUX1ZSSU5HX0JBU0Ugd2hlcmUgaXMgZG9jdW1lbnRlZCB0aGF0IHRo
ZSBmaXJzdAo+ID4gPiAxNSBiaXRzIGFyZSBsYXN0X2F2YWlsX2lkeCwgdGhlIDE2dGggdGhlIGF2
YWlsX3dyYXBfY291bnRlciwgYW5kIHRoZQo+ID4gPiBvdGhlcnMgYXJlIGxhc3RfdXNlZF9pZHgg
YW5kIHVzZWRfd3JhcF9jb3VudGVyPwo+ID4gPgo+ID4gPiBNYXliZSBJIG1pc3NlZCBzb21ldGhp
bmcsIGJ1dCBzaW5jZSB0aGlzIGlzIFVBUEksIElNSE8gd2Ugc2hvdWxkCj4gPiA+IGRvY3VtZW50
IHRoZSBwYXJhbWV0ZXJzIG9mIGlvY3RscyBhdCBsZWFzdCBpbgo+ID4gPiBpbmNsdWRlL3VhcGkv
bGludXgvdmhvc3QuaC4KPiA+Cj4gPiBQZXJoYXBzIEphc29uIGFscmVhZHkgaGFzIHNvbWV0aGlu
ZyB3cml0dGVuIHVwIHRoYXQgY291bGQgYmUgcHV0IGluIGhlcmUKPiA+IGZyb20gd2hlbiBoZSBm
aXJzdCBhZGRlZCB0aGUgd3JhcF9jb3VudGVyIGEgY291cGxlIG9mIHllYXJzIGFnbz8KPgo+IElm
IHlvdSBtZWFudCB0aGUgdmlydGlvIGRyaXZlciBzdXBwb3J0IGZvciBwYWNrZWQsIEkgdGhpbmsg
aXQncwo+IGRpZmZlcmVudCBmcm9tIHRoZSBjb250ZXh0IHdoaWNoIGlzIHZob3N0IGhlcmUuCj4K
PiBJIGFncmVlIHdpdGggU3RlZmFubyB0aGF0IHdlIG5lZWQgdG8gdXBkYXRlIHRoZSBjb21tZW50
cyBhcm91bmQKPiBHRVRfVlJJTkdfQkFTRSBhbmQgU0VUX1ZSSU5HX0JBU0UsIHRoZW4gd2UgYXJl
IGZpbmUuCgpJJ20gdGhpbmtpbmcgaWYgd2Ugc2hvdWxkIGFsc28gYWRkIGEgbmV3IFZIT1NUX0JB
Q0tFTkRfRl9SSU5HX1BBQ0tFRApmZWF0dXJlIChvciBzb21ldGhpbmcgc2ltaWxhcikgdG8gaW5m
b3JtIHRoZSB1c2VyIHNwYWNlIHRoYXQgbm93IHdlCmFyZSBhYmxlIHRvIGhhbmRsZSBwYWNrZWQg
dmlydHF1ZXVlIHRocm91Z2ggdmhvc3QgSU9DVExzLCBvdGhlcndpc2UKaG93IGNhbiB0aGUgdXNl
cnNwYWNlIGtub3cgaWYgaXQgaXMgc3VwcG9ydGVkIG9yIG5vdD8KClRoYW5rcywKU3RlZmFubwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
