Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E07FC433F5
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 02:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB67F60DC6;
	Tue, 11 Jan 2022 02:45:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cqHfajOh-w4P; Tue, 11 Jan 2022 02:45:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2DFCE606ED;
	Tue, 11 Jan 2022 02:45:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDCECC0030;
	Tue, 11 Jan 2022 02:45:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56C83C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 02:45:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3AF6860BCE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 02:45:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NLDZ9gi79pEp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 02:45:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 341DD606ED
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 02:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641869106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XWeAmiptQSo3jHiEo9K9eHpziOKVIuqcrOdyW6aJQXo=;
 b=cuvPkCNIZnQGls2kMVwHGN86bX2s75dkh7eC9zD9JJwBdMK8bc+ziGK6AaHuzlPhlCeX69
 47n+hM5Gz1m8oqbDMNy7vOHb8ni7GzKX1mV+kelGBqe1qxlqxZoSp6WzARHvEr7b2AUoZb
 Ee6wSRFuJv+uc77baDlNRZJBbjxMmak=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-Yn_TidYuPhuiTEXZQmr7Nw-1; Mon, 10 Jan 2022 21:45:04 -0500
X-MC-Unique: Yn_TidYuPhuiTEXZQmr7Nw-1
Received: by mail-lf1-f69.google.com with SMTP id
 v7-20020a056512048700b0042d99b3a962so2147007lfq.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 18:45:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XWeAmiptQSo3jHiEo9K9eHpziOKVIuqcrOdyW6aJQXo=;
 b=dYjuc8WKwC7aHDYLrjAk45TpMHPiLRQptSNA6ybgfIekGDpYR4l38CKvci9rjjkLVb
 gfiAZB3ydw4F6v4nvURRk+jeV0020jb7d4xZzcI7sRsGN2ZZl0qb2TLmqHjQ+4hi4bzG
 lASmEbpx3lf+vFV5/ZudcKtTDqVvOSLM54BzH7Twigff8aC0Amwnr6qwVw9lLs3cXmSR
 ViNLSOqvobvtNna+bbqVC05s3eq0+PxAfWUTAzV372DhB4IFLVS5jClOQNgCk9z14omc
 4S9v/eeFqT7kNS7Eok+Hm0X3aF1ROaQpcKm4yc0Orll29wH6C7hJJOBmkO/1q3Bxkpmr
 1SAA==
X-Gm-Message-State: AOAM531bqPY0ySs1oEX7ta5rI4/vzROKsjD1lFYHDK/x3Eoa7+XEtvmj
 it7qGGb3P+wQoSozmU7LKW3fGLBRFf4T8g+VAxnng6sUMJ0osZM2KCuzqadYL7AIIJOtOqy8ql6
 +9GaVylI1M0m63RtBjHNUq5ZdYHelm8syIlZ96T2Xsh8n81iNG0F9yk7hOg==
X-Received: by 2002:a19:760f:: with SMTP id c15mr1838565lff.498.1641869103334; 
 Mon, 10 Jan 2022 18:45:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXfRpViyPXFrA1ePvCdJefXeKFEK/H9Gkz4BjCUU7Dhi6GeDHuvK9+E/MmlJkMsPQCIg6vEwgRUExO/pIl2gY=
X-Received: by 2002:a19:760f:: with SMTP id c15mr1838551lff.498.1641869103108; 
 Mon, 10 Jan 2022 18:45:03 -0800 (PST)
MIME-Version: 1.0
References: <CACGkMEu4MPe9DQbaphMrd3T16V9FF+Pu9uhpBue8-Pz9Q6Jk1A@mail.gmail.com>
 <1641806593.3066823-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1641806593.3066823-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Jan 2022 10:44:52 +0800
Message-ID: <CACGkMEs70FRvHoApEG29L+C47zTS++JOFgM-G7jjbAq5oU9wPw@mail.gmail.com>
Subject: Re: [PATCH 2/6] virtio: split: alloc indirect desc with extra
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgNToyOSBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgMTAgSmFuIDIwMjIgMTY6NTQ6NTggKzA4
MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gT24gTW9uLCBK
YW4gMTAsIDIwMjIgYXQgMzo1OSBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEu
Y29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gTW9uLCAxMCBKYW4gMjAyMiAxNTo0MToyNyArMDgw
MCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gT24gTW9u
LCBKYW4gMTAsIDIwMjIgYXQgMzoyNCBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJh
YmEuY29tPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiBPbiBNb24sIDEwIEphbiAyMDIyIDE0
OjQzOjM5ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4g5ZyoIDIwMjIvMS83IOS4i+WNiDI6MzMsIFh1YW4gWmh1byDl
hpnpgZM6Cj4gPiA+ID4gPiA+ID4gSW4gdGhlIHNjZW5hcmlvIHdoZXJlIGluZGlyZWN0IGlzIG5v
dCB1c2VkLCBlYWNoIGRlc2MgY29ycmVzcG9uZHMgdG8gYW4KPiA+ID4gPiA+ID4gPiBleHRyYSwg
d2hpY2ggaXMgdXNlZCB0byByZWNvcmQgaW5mb3JtYXRpb24gc3VjaCBhcyBkbWEsIGZsYWdzLCBh
bmQKPiA+ID4gPiA+ID4gPiBuZXh0Lgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gSW4gdGhl
IHNjZW5hcmlvIG9mIHVzaW5nIGluZGlyZWN0LCB0aGUgYXNzaWduZWQgZGVzYyBkb2VzIG5vdCBo
YXZlIHRoZQo+ID4gPiA+ID4gPiA+IGNvcnJlc3BvbmRpbmcgZXh0cmEgcmVjb3JkIGRtYSBpbmZv
cm1hdGlvbiwgYW5kIHRoZSBkbWEgaW5mb3JtYXRpb24gbXVzdAo+ID4gPiA+ID4gPiA+IGJlIG9i
dGFpbmVkIGZyb20gdGhlIGRlc2Mgd2hlbiB1bm1hcC4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+IFRoaXMgcGF0Y2ggYWxsb2NhdGVzIHRoZSBjb3JyZXNwb25kaW5nIGV4dHJhIGFycmF5IHdo
ZW4gaW5kaXJlY3QgZGVzYyBpcwo+ID4gPiA+ID4gPiA+IGFsbG9jYXRlZC4gVGhpcyBoYXMgdGhl
c2UgYWR2YW50YWdlczoKPiA+ID4gPiA+ID4gPiAxLiBSZWNvcmQgdGhlIGRtYSBpbmZvcm1hdGlv
biBvZiBkZXNjLCBubyBuZWVkIHRvIHJlYWQgZGVzYyB3aGVuIHVubWFwCj4gPiA+ID4gPiA+ID4g
Mi4gSXQgd2lsbCBiZSBtb3JlIGNvbnZlbmllbnQgYW5kIHVuaWZpZWQgaW4gcHJvY2Vzc2luZwo+
ID4gPiA+ID4gPiA+IDMuIFNvbWUgYWRkaXRpb25hbCBpbmZvcm1hdGlvbiBjYW4gYmUgcmVjb3Jk
ZWQgaW4gZXh0cmEsIHdoaWNoIHdpbGwgYmUKPiA+ID4gPiA+ID4gPiAgICAgdXNlZCBpbiBzdWJz
ZXF1ZW50IHBhdGNoZXMuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFR3byBx
dWVzdGlvbnM6Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IDEpIElzIHRoZXJlIGFueSBwZXJmb3Jt
YW5jZSBudW1iZXIgZm9yIHRoaXMgY2hhbmdlPyBJIGd1ZXNzIGl0IGdpdmVzCj4gPiA+ID4gPiA+
IG1vcmUgc3RyZXNzIG9uIHRoZSBjYWNoZS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBJIHdpbGwgYWRk
IHBlcmZvcm1hbmNlIHRlc3QgZGF0YSBpbiB0aGUgbmV4dCB2ZXJzaW9uLgo+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gMikgSXMgdGhlcmUgYSByZXF1aXJlbWVudCB0byBtaXggdGhlIHByZSBtYXBwZWQg
c2cgd2l0aCB1bm1hcHBlZCBzZz8gSWYKPiA+ID4gPiA+ID4gbm90LCBhIHBlciB2aXJ0cXVldWUg
ZmxhZyBsb29rcyBzdWZmaWNpZW50Cj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhlcmUgaXMgdGhpcyBy
ZXF1aXJlbWVudC4gRm9yIGV4YW1wbGUsIGluIHRoZSBjYXNlIG9mIEFGX1hEUCwgYSBwYXRja2V0
Cj4gPiA+ID4gPiBjb250YWlucyB0d28gcGFydHMsIG9uZSBpcyB2aXJ0aW9fbmV0X2hkciwgYW5k
IHRoZSBvdGhlciBpcyB0aGUgYWN0dWFsIGRhdGEKPiA+ID4gPiA+IHBhY2tldCBmcm9tIEFGX1hE
UC4gVGhlIGZvcm1lciBpcyB1bm1hcHBlZCBzZywgYW5kIHRoZSBsYXR0ZXIgaXMgcHJlIG1hcHBl
ZCBzZy4KPiA+ID4gPgo+ID4gPiA+IEFueSBjaGFuY2UgdG8gbWFwIHZpcnRpb19uZXRfaGRyKCkg
bWFudWFsbHkgYnkgQUZfWERQIHJvdXRpbmUgaW4gdGhpcyBjYXNlPwo+ID4gPgo+ID4gPiBXZWxs
LCBpdCBpcyBpbmRlZWQgcG9zc2libGUgdG8gZG8gc28uIEluIHRoZSBpbmRpcmVjdCBzY2VuYXJp
bywgd2UgY2FuIHJlY29yZCBpdAo+ID4gPiBpbiB2cmluZy0+c3BsaXQuZGVzY19leHRyYVtoZWFk
XS5mbGFncwo+ID4gPgo+ID4gPiBUaGVuIHdlIGhhdmUgdG8gYWdyZWUgdGhhdCB0aGVyZSBjYW4g
YmUgbm8gbWl4ZWQgc2l0dWF0aW9uLgo+ID4KPiA+IEkgdGhpbmsgaXQgd291bGQgYmUgZWFzaWVy
IGFuZCBsZXNzIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24gaWYgd2UgZG9uJ3QKPiA+IGRvIGh1Z2Ug
Y2hhbmdlcyBpbiB0aGUgY29yZSB1bmxlc3MgaXQncyBhIG11c3QuCj4gPgo+Cj4gT2ssIEkgcGxh
biB0byBhZGQgdHdvIG5ldyBpbnRlcmZhY2UgdmlydHF1ZXVlX2FkZF9vdXRidWZfZmxhZygpLAo+
IHZpcnRxdWV1ZV9hZGRfaW5idWZfZmxhZygpIHBhc3MgYSBmbGFnIHBhcmFtZXRlciB0byB2aXJ0
cXVldWVfYWRkKCkgdG8KPiBtYXJrIHNncyBhZGRyIGlzIHByZWRtYS4KPgo+IEkgZG9uJ3Qgd2Fu
dCB0byB1c2Ugc2ctPmRtYV9hZGRyZXNzLCBzbyB3ZSBoYXZlIHRvIGNoZWNrIHdoZXRoZXIgZWFj
aCBzZyB1c2VzCj4gZG1hX2FkZHJlc3MuIElmIGl0IGlzIG5vdCB1bmlmaWVkLCB3ZSB3aWxsIGFs
c28gaGFuZGxlIGV4Y2VwdGlvbi4KPgo+ID4gQnR3LCBJIGZvcmdvdCB0aGUgY29uY2x1c2lvbiBv
ZiB0aGUgbGFzdCBBRl9YRFAgc2VyaWVzLiBXaHkgaXMgaXQKPiA+IGJldHRlciB0byBjaGFuZ2Ug
dmlydGlvX3JpbmcgaW5zdGVhZCBvZiBBRl9YRFAgKHdoaWNoIHNlZW1zIGVhc2llcikuCj4KPiBS
ZWdhcmRpbmcgdGhpcyBxdWVzdGlvbiwgSSdtIGd1ZXNzaW5nIHlvdSBtZWFuIHRvIG1ha2UgQUZf
WERQIG5vdCB1c2UgRE1BCj4gYWRkcmVzc2VzPyBJbnN0ZWFkIHBhc3MgdmlydHVhbCBhZGRyZXNz
ZXMgdG8gdmlydGlvLgo+Cj4gSXQgd291bGQgY2VydGFpbmx5IGJlIHNpbXBsZXIsIGJ1dCBJIHRo
aW5rIHRoZXJlIGlzIGEgcGVyZm9ybWFuY2UgZ2FpbiBpbiBkb2luZwo+IHRoZSBETUEgbWFwcGlu
ZyBhaGVhZCBvZiB0aW1lLgoKQW55IHJlYXNvbiBmb3IgdGhpcz8gSXMgaXQganVzdCBiZWNhdXNl
IEFGX1hEUCBkaWQgYmF0Y2ggbWFwcGluZz8KCkFjdHVhbGx5IHRoZXJlJ3MgYW5vdGhlciBzdWJ0
bGUgZGlmZmVyZW5jZSwgQUZfWERQIHRlbmRzIHRvIHVzZQpETUFfQklESVJFQ1RJT05BTCBidXQg
dGhlIHZpcnRpb19yaW5nIG1hcCBkZXBlbmRzIG9uIHRoZSBpbi9vdXQuCgpUaGFua3MKCj4KPiBU
aGFua3MuCj4KPgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+ID4KPiA+ID4gVGhhbmtzLgo+ID4gPgo+
ID4gPiA+Cj4gPiA+ID4gVGhhbmtzCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGFua3Mu
Cj4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4KPiA+Cj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
