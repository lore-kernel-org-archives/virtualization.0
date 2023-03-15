Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE06C61DA4
	for <virtualization@archiver.kernel.org>; Wed, 15 Mar 2023 04:48:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5B45640482;
	Wed, 15 Mar 2023 04:48:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B45640482
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nr7ryuaf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HoGJAZfx96Sa; Wed, 15 Mar 2023 04:48:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D9A7A403A4;
	Wed, 15 Mar 2023 04:48:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D9A7A403A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2C29C0071;
	Wed, 15 Mar 2023 04:48:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9169C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 04:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E52C403C4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 04:48:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E52C403C4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wele-uhP1ONA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 04:48:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A2107403A4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A2107403A4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 04:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678855704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EnNwH+fUAMnqj7VCCkUZ7KRSDrha+QKNhS3KVcDA0w0=;
 b=Nr7ryuaf+Bs5umUDXnQIaXOocPtPE/besawS/Hnn8aIkITqa58wn0IdpQ7vN2mHGY6luHN
 Jb+xsFfp4oNtIPvtwMdf65FjIZ2aVuJI3n1EXZEvTVD4tvIMPGzseI1xHh7Ww0CnvMrbTB
 Fu6qH+0qkBannR6yYgt9Vr7qkiIev7w=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-v9NbO9eoNfuqu9u2PxBu0Q-1; Wed, 15 Mar 2023 00:47:42 -0400
X-MC-Unique: v9NbO9eoNfuqu9u2PxBu0Q-1
Received: by mail-oo1-f72.google.com with SMTP id
 b21-20020a4ad895000000b005258ecbd618so4810741oov.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 21:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678855662;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EnNwH+fUAMnqj7VCCkUZ7KRSDrha+QKNhS3KVcDA0w0=;
 b=5JaIK2ukv6tnq3F6cIp+tCNASLV/vedfT2dIYLm8lLv+0mrZpSZxNy0vhbbPZqFhG/
 WIHRBfzBAVW3o1oJ+ODBgJ++SPmPg5c6DljB9S2SlV+yJc60T+aASDqdgH9Jqzg9Zzsx
 EHWw6pC5J04dPEw5RYQrSMA96aAB06/But1pKWY/hg2y/4BB9TVbNeOyw78t7KnuRKWI
 wjxEFp8/1eQIDvvzN+fXXYh51SfJXmGJ2LAVrBwamVuXnKbMNnjUpxqDaYclbi26fcLm
 iy93q3Bs6nH6G7R5q/P9Fl9+SA8gJVR/m+AoMPjVWwUHx6fSxGZ6cqTkcw8scJcEg8go
 j2mA==
X-Gm-Message-State: AO0yUKXHHB6W2flSBs9r8nLlfZ/L0yYsrXZKsOslw7FxNxN48JaIUZOh
 PpSnVr4Kf9LD1osAYAcOSDMMmRnovqoPznpL/02cKhcd2l8tamOoYB+SPbiKjeh7tcixFBkcLft
 l49ols/3EB/8Igat42rTY3On5OB6eOtJIJwMNsnSk6didfrBjCFGCQEWLQg==
X-Received: by 2002:aca:220c:0:b0:37f:ab56:ff42 with SMTP id
 b12-20020aca220c000000b0037fab56ff42mr448228oic.9.1678855661656; 
 Tue, 14 Mar 2023 21:47:41 -0700 (PDT)
X-Google-Smtp-Source: AK7set9apmk8a3pBpTI4kZ9+uIYpQRAt5REMIXhOeko44P8ZJPPPjV0k/KXjHXtV2XjKKIBKZz2uB6pu5j8x/C5mFl4=
X-Received: by 2002:aca:220c:0:b0:37f:ab56:ff42 with SMTP id
 b12-20020aca220c000000b0037fab56ff42mr448215oic.9.1678855660673; Tue, 14 Mar
 2023 21:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
 <20230308064443.50639-7-xuanzhuo@linux.alibaba.com>
 <CACGkMEs0bGAVhawHLbR_f1NupAGJfVdo_jVSNx2i74b6Y4nJ=Q@mail.gmail.com>
 <1678785225.2361012-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1678785225.2361012-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Mar 2023 12:47:29 +0800
Message-ID: <CACGkMEu0gRn6tpBQthASnwQtKtkCkgPLDtwi59zn06S4N6Tocg@mail.gmail.com>
Subject: Re: [PATCH vhost v2 06/12] virtio_ring: split-indirect: support
 premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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

T24gVHVlLCBNYXIgMTQsIDIwMjMgYXQgNToxN+KAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCAxNCBNYXIgMjAyMyAxNTo1NzowNiAr
MDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBPbiBXZWQs
IE1hciA4LCAyMDIzIGF0IDI6NDTigK9QTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJh
YmEuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gdmlydGlvIGNvcmUgb25seSBzdXBwb3J0cyB2aXJ0
dWFsIGFkZHJlc3NlcywgZG1hIGlzIGNvbXBsZXRlZCBpbiB2aXJ0aW8KPiA+ID4gY29yZS4KPiA+
ID4KPiA+ID4gSW4gc29tZSBzY2VuYXJpb3MgKHN1Y2ggYXMgdGhlIEFGX1hEUCksIHRoZSBtZW1v
cnkgaXMgYWxsb2NhdGVkCj4gPiA+IGFuZCBETUEgaXMgY29tcGxldGVkIGluIGFkdmFuY2UsIHNv
IGl0IGlzIG5lY2Vzc2FyeSBmb3IgdXMgdG8gc3VwcG9ydAo+ID4gPiBwYXNzaW5nIHRoZSBETUEg
YWRkcmVzcyB0byB2aXJ0aW8gY29yZS4KPiA+ID4KPiA+ID4gRHJpdmVzIGNhbiB1c2Ugc2ctPmRt
YV9hZGRyZXNzIHRvIHBhc3MgdGhlIG1hcHBlZCBkbWEgYWRkcmVzcyB0byB2aXJ0aW8KPiA+ID4g
Y29yZS4gSWYgb25lIHNnLT5kbWFfYWRkcmVzcyBpcyB1c2VkIHRoZW4gYWxsIHNncyBtdXN0IHVz
ZSBzZy0+ZG1hX2FkZHJlc3MsCj4gPiA+IG90aGVyd2lzZSBhbGwgZG1hX2FkZHJlc3MgbXVzdCBi
ZSBudWxsLgo+ID4gPgo+ID4gPiBPbiB0aGUgaW5kaXJlY3QgcGF0aCwgaWYgZG1hX2FkZHJlc3Mg
aXMgdXNlZCwgZGVzY19zdGF0ZS5pbmRpcl9kZXNjIHdpbGwKPiA+ID4gYmUgbWl4ZWQgd2l0aCBW
UklOR19JTkRJUkVDVF9QUkVNQVBQRUQuIFNvIHdoZW4gZG8gdW5tYXAsIHdlIGNhbiBwYXNzIGl0
Lgo+ID4KPiA+IEl0J3MgYmV0dGVyIHRvIG1lbnRpb24gd2h5IGluZGlyZWN0IGRlc2NyaXB0b3Jz
IGNhbid0IGJlIGRvbmUgaW4gdGhlCj4gPiBzYW1lIHdheSB3aXRoIGRpcmVjdCBkZXNjcmlwdG9y
cy4KPiA+Cj4gPiBCdHcsIGlmIHdlIGNoYW5nZSB0aGUgc2VtYW50aWNzIG9mIGRlc2NfZXh0cmEu
ZG1hX2FkZHIgYW5kCj4gPiBkZXNjX3N0YXRlLmluZGlyX2Rlc2MsIHdlIHNob3VsZCBhZGQgY29t
bWVudHMgdG8gZGVmaW5pdGlvbnMgb2YgdGhvc2UKPiA+IHN0cnVjdHVyZXMuCj4KPgo+IFdpbGwg
Zml4Lgo+Cj4gPgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVv
QGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gPiAtLS0KPiA+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMgfCAyOCArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tCj4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPiA+ID4KPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jCj4gPiA+IGluZGV4IDY2YTA3MWUzYmRlZi4uMTE4MjdkMmU1NmE4IDEwMDY0
NAo+ID4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ICsrKyBiL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gQEAgLTIzMSw2ICsyMzEsMTggQEAgc3Rh
dGljIHZvaWQgdnJpbmdfZnJlZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpOwo+ID4gPiAgICogSGVs
cGVycy4KPiA+ID4gICAqLwo+ID4gPgo+ID4gPiArI2RlZmluZSBWUklOR19JTkRJUkVDVF9QUkVN
QVBQRUQgIEJJVCgwKQo+ID4gPiArCj4gPiA+ICsjZGVmaW5lIGRlc2NfbWl4X2RtYV9tYXAoZG9f
bWFwLCBkZXNjKSBcCj4gPiA+ICsgICAgICAgKGRvX21hcCA/IGRlc2MgOiAodHlwZW9mKGRlc2Mp
KSgodW5zaWduZWQgbG9uZykoZGVzYykgfCBWUklOR19JTkRJUkVDVF9QUkVNQVBQRUQpKQo+ID4g
PiArCj4gPiA+ICsjZGVmaW5lIGRlc2Nfcm1fZG1hX21hcChkZXNjKSBcCj4gPiA+ICsgICAgICAg
KCh0eXBlb2YoZGVzYykpKCh1bnNpZ25lZCBsb25nKShkZXNjKSAmIH5WUklOR19JTkRJUkVDVF9Q
UkVNQVBQRUQpKQo+ID4gPiArCj4gPiA+ICsjZGVmaW5lIGRlc2NfbWFwX2ludGVyKGRlc2MpIFwK
PiA+ID4gKyAgICAgICAhKCh1bnNpZ25lZCBsb25nKShkZXNjKSAmIFZSSU5HX0lORElSRUNUX1BS
RU1BUFBFRCkKPiA+ID4gKwo+ID4gPiArCj4gPiA+ICAjZGVmaW5lIHRvX3Z2cShfdnEpIGNvbnRh
aW5lcl9vZihfdnEsIHN0cnVjdCB2cmluZ192aXJ0cXVldWUsIHZxKQo+ID4gPgo+ID4gPiAgc3Rh
dGljIGlubGluZSBib29sIHZpcnRxdWV1ZV91c2VfaW5kaXJlY3Qoc3RydWN0IHZyaW5nX3ZpcnRx
dWV1ZSAqdnEsCj4gPiA+IEBAIC03MjUsNyArNzM3LDcgQEAgc3RhdGljIGlubGluZSBpbnQgdmly
dHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gPiA+ICAgICAgICAgLyog
U3RvcmUgdG9rZW4gYW5kIGluZGlyZWN0IGJ1ZmZlciBzdGF0ZS4gKi8KPiA+ID4gICAgICAgICB2
cS0+c3BsaXQuZGVzY19zdGF0ZVtoZWFkXS5kYXRhID0gZGF0YTsKPiA+ID4gICAgICAgICBpZiAo
aW5kaXJlY3QpCj4gPiA+IC0gICAgICAgICAgICAgICB2cS0+c3BsaXQuZGVzY19zdGF0ZVtoZWFk
XS5pbmRpcl9kZXNjID0gZGVzYzsKPiA+ID4gKyAgICAgICAgICAgICAgIHZxLT5zcGxpdC5kZXNj
X3N0YXRlW2hlYWRdLmluZGlyX2Rlc2MgPSBkZXNjX21peF9kbWFfbWFwKGRvX21hcCwgZGVzYyk7
Cj4gPgo+ID4gU28gdXNpbmcgaW5kaXJfZGVzYyBpcyBraW5kIG9mIGhhY2t5IChzaW5jZSB3ZSBk
b24ndCB1c2UgaW5kaXJlY3QgZm9yCj4gPiByeCB3aXRoIGV4dHJhIGNvbnRleHQpLgo+ID4KPiA+
IEJ1dCBhdCBsZWFzdCBJIHRoaW5rIHdlIHNob3VsZCBzZWVrYSB3YXkgdG8gdXNlIHRoZSBzYW1l
IG1ldGFkYXRhIGZvcgo+ID4gYm90aCBkaXJlY3QgYW5kIGluZGlyZWN0IGRlc2NyaXB0b3JzLgo+
ID4KPiA+IEUuZyBjYW4gd2UgbWFrZSB0aGVtIGFsbCB0byB1c2UgaW5kaXJfZGVzYz8KPgo+IEkg
dGhpbmsgaXQgbWF5IG5vdC4gTXkgb3JpZ2luYWwgaWRlYSBpcyB0byB1c2UgaW5kaXJfZGVzYyB1
bmlmb3JtbHksIGJ1dAo+IGZvciB0aGUgc2NlbmUgb2Ygc2F2aW5nIGN0eCwgd2UgY2Fubm90IGd1
YXJhbnRlZSB0aGF0IHRoZSBjdHggaGFzIHNwYWNlIGZvciB1cy4KCk9rLCBidXQgdGhlIHByb2Js
ZW0gaXMgdGhhdCB0aGUgY29kZSBiZWNhbWUgZXZlbiBtb3JlIGhhY2t5IChpbWFnaW5lCm9uZSBk
YXkgd2UgbWF5IHdhbnQgdG8gdXNlIGluZGlyZWN0IGZvciBSWD8pLgoKU28gSSB0ZW5kIHRvIGNo
YW5nZSBteSBtaW5kIHRvIGludHJvZHVjZSBkZWRpY2F0ZWQgbWV0YWRhdGEsIGluc3RlYWQKb2Yg
dHJ5aW5nIHRvIGJlIHBhY2tlZCB3aXRoIHR3byB0eXBlcyBvZiB0aGUgZXhpc3Rpbmcgb25lcy4K
ClRoYW5rcwoKPgo+IFRoYW5rcy4KPgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+ID4gICAgICAgICBl
bHNlCj4gPiA+ICAgICAgICAgICAgICAgICB2cS0+c3BsaXQuZGVzY19zdGF0ZVtoZWFkXS5pbmRp
cl9kZXNjID0gY3R4Owo+ID4gPgo+ID4gPiBAQCAtODIwLDIyICs4MzIsMjYgQEAgc3RhdGljIHZv
aWQgZGV0YWNoX2J1Zl9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwgdW5zaWduZWQg
aW50IGhlYWQsCj4gPiA+ICAgICAgICAgdnEtPnZxLm51bV9mcmVlKys7Cj4gPiA+Cj4gPiA+ICAg
ICAgICAgaWYgKHZxLT5pbmRpcmVjdCkgewo+ID4gPiAtICAgICAgICAgICAgICAgc3RydWN0IHZy
aW5nX2Rlc2MgKmluZGlyX2Rlc2MgPQo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHZxLT5zcGxpdC5kZXNjX3N0YXRlW2hlYWRdLmluZGlyX2Rlc2M7Cj4gPiA+ICsgICAgICAg
ICAgICAgICBzdHJ1Y3QgdnJpbmdfZGVzYyAqbWl4ID0gdnEtPnNwbGl0LmRlc2Nfc3RhdGVbaGVh
ZF0uaW5kaXJfZGVzYzsKPiA+ID4gKyAgICAgICAgICAgICAgIHN0cnVjdCB2cmluZ19kZXNjICpp
bmRpcl9kZXNjOwo+ID4gPiAgICAgICAgICAgICAgICAgdTMyIGxlbjsKPiA+ID4KPiA+ID4gICAg
ICAgICAgICAgICAgIC8qIEZyZWUgdGhlIGluZGlyZWN0IHRhYmxlLCBpZiBhbnksIG5vdyB0aGF0
IGl0J3MgdW5tYXBwZWQuICovCj4gPiA+IC0gICAgICAgICAgICAgICBpZiAoIWluZGlyX2Rlc2Mp
Cj4gPiA+ICsgICAgICAgICAgICAgICBpZiAoIW1peCkKPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuOwo+ID4gPgo+ID4gPiArICAgICAgICAgICAgICAgaW5kaXJfZGVzYyA9IGRl
c2Nfcm1fZG1hX21hcChtaXgpOwo+ID4gPiArCj4gPiA+ICAgICAgICAgICAgICAgICBsZW4gPSB2
cS0+c3BsaXQuZGVzY19leHRyYVtoZWFkXS5sZW47Cj4gPiA+Cj4gPiA+ICAgICAgICAgICAgICAg
ICBCVUdfT04oISh2cS0+c3BsaXQuZGVzY19leHRyYVtoZWFkXS5mbGFncyAmCj4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgVlJJTkdfREVTQ19GX0lORElSRUNUKSk7Cj4gPiA+
ICAgICAgICAgICAgICAgICBCVUdfT04obGVuID09IDAgfHwgbGVuICUgc2l6ZW9mKHN0cnVjdCB2
cmluZ19kZXNjKSk7Cj4gPiA+Cj4gPiA+IC0gICAgICAgICAgICAgICBmb3IgKGogPSAwOyBqIDwg
bGVuIC8gc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjKTsgaisrKQo+ID4gPiAtICAgICAgICAgICAg
ICAgICAgICAgICB2cmluZ191bm1hcF9vbmVfc3BsaXRfaW5kaXJlY3QodnEsICZpbmRpcl9kZXNj
W2pdKTsKPiA+ID4gKyAgICAgICAgICAgICAgIGlmIChkZXNjX21hcF9pbnRlcihtaXgpKSB7Cj4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBsZW4gLyBzaXplb2Yo
c3RydWN0IHZyaW5nX2Rlc2MpOyBqKyspCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdnJpbmdfdW5tYXBfb25lX3NwbGl0X2luZGlyZWN0KHZxLCAmaW5kaXJfZGVzY1tqXSk7
Cj4gPiA+ICsgICAgICAgICAgICAgICB9Cj4gPiA+Cj4gPiA+ICAgICAgICAgICAgICAgICBrZnJl
ZShpbmRpcl9kZXNjKTsKPiA+ID4gICAgICAgICAgICAgICAgIHZxLT5zcGxpdC5kZXNjX3N0YXRl
W2hlYWRdLmluZGlyX2Rlc2MgPSBOVUxMOwo+ID4gPiAtLQo+ID4gPiAyLjMyLjAuMy5nMDExOTVj
ZjlmCj4gPiA+Cj4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
