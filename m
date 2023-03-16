Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6B2C6FD1D
	for <virtualization@archiver.kernel.org>; Thu, 16 Mar 2023 02:50:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E98E840160;
	Thu, 16 Mar 2023 02:50:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E98E840160
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fJWID0wC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JnDG7-rkSYMC; Thu, 16 Mar 2023 02:50:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 354DB400E7;
	Thu, 16 Mar 2023 02:50:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 354DB400E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E96A0C0035;
	Thu, 16 Mar 2023 02:50:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2520C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 02:50:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8BF5140158
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 02:50:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8BF5140158
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3PNbT57gVOby
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 02:50:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 22AB0400E7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 22AB0400E7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 02:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678935013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5B5IYIU86s2aob6VFljejg8YbzWrh+sbQRP82Vq5Ri4=;
 b=fJWID0wCXCyGiNGtknM2lYqNtN4ZvIYpX+2atSXKdU7qyW5CiLWSiNd1vKO0ZOY9FSXxaH
 MIOzcqwuKsqzBIUlUx9Wqyb6hiFWDAzanlv4I6XWHi9YBa1j2DG21kUusxcNJRIcrvu1av
 vddoAkeo/QWe7+25mZGXEoWJ4+ybkl4=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-AJJ5OhmNNKy8jPZoPNvcLA-1; Wed, 15 Mar 2023 22:50:06 -0400
X-MC-Unique: AJJ5OhmNNKy8jPZoPNvcLA-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-17ae1c11a20so361664fac.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 19:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678935005;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5B5IYIU86s2aob6VFljejg8YbzWrh+sbQRP82Vq5Ri4=;
 b=QLuqKmNC5Lt+z0Tyn6kmTBuQzn9P5J/+tkxQLZt3zmP/k1dx+R0PWDnHrCK0y+8YVd
 pA07MqdCLTzmsRhwNk2/yRI9VctnLkmRbZB2N6jO4qoNGQx5c+2Ebbw8EgrfmBEMrBal
 +HeI81d7NNvEsApHue43l4feREyj0IH+A061K/qrcvrlUucWd4cPUDBOID09eLL++Sgw
 4JZ3RhYhB4MpfqBeaVVriY5zfmG3EiCbDXjVN9yQyJyqQigK2rO76BbmTPbqQbDgvLQ/
 8vAHEVC+TnUj89prtT37kHu6RCUy2Vk4ug1VIHpaHpHO58A9KBIcpL64A2KjI2w0FbuK
 qB1Q==
X-Gm-Message-State: AO0yUKUNIaZE2ITFkbG0UCg6gubu86iFP/93NpuJBKRz0/hMdjvObDfF
 y0jLyFo/WJZ41fSNBEcXL26pnH5q8ptOM63hg6Bavgq4QJGbGNhmmvOBPJkeXjg68gVKMCXYFL6
 O5YIjT+NsJXOUFwtRLQ3KFDQPp3PdVvq8tX8v8XS7s06qBx+Km3H8lEXQnw==
X-Received: by 2002:a05:6870:649f:b0:177:9f9c:dc5 with SMTP id
 cz31-20020a056870649f00b001779f9c0dc5mr6486649oab.9.1678935005669; 
 Wed, 15 Mar 2023 19:50:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set+53Pg6M6caCT9uQ2zM1dQXRLBOAZB6RU7G/Dx9dG5RBh3Glb7K+/ysvjoqiqbz2kO8SsHCZocZqI0yNtCTero=
X-Received: by 2002:a05:6870:649f:b0:177:9f9c:dc5 with SMTP id
 cz31-20020a056870649f00b001779f9c0dc5mr6486642oab.9.1678935005326; Wed, 15
 Mar 2023 19:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
 <20230308064443.50639-7-xuanzhuo@linux.alibaba.com>
 <CACGkMEs0bGAVhawHLbR_f1NupAGJfVdo_jVSNx2i74b6Y4nJ=Q@mail.gmail.com>
 <1678785225.2361012-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEu0gRn6tpBQthASnwQtKtkCkgPLDtwi59zn06S4N6Tocg@mail.gmail.com>
 <1678860064.0790339-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1678860064.0790339-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Mar 2023 10:49:54 +0800
Message-ID: <CACGkMEum17=yKRhSHLrj6v5f6a8xqp9=foW+AqYT-kONi_0Ncg@mail.gmail.com>
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

T24gV2VkLCBNYXIgMTUsIDIwMjMgYXQgMjowNuKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gT24gV2VkLCAxNSBNYXIgMjAyMyAxMjo0NzoyOSAr
MDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBPbiBUdWUs
IE1hciAxNCwgMjAyMyBhdCA1OjE34oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGli
YWJhLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIFR1ZSwgMTQgTWFyIDIwMjMgMTU6NTc6MDYg
KzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+IE9u
IFdlZCwgTWFyIDgsIDIwMjMgYXQgMjo0NOKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXgu
YWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+IHZpcnRpbyBjb3JlIG9ubHkg
c3VwcG9ydHMgdmlydHVhbCBhZGRyZXNzZXMsIGRtYSBpcyBjb21wbGV0ZWQgaW4gdmlydGlvCj4g
PiA+ID4gPiBjb3JlLgo+ID4gPiA+ID4KPiA+ID4gPiA+IEluIHNvbWUgc2NlbmFyaW9zIChzdWNo
IGFzIHRoZSBBRl9YRFApLCB0aGUgbWVtb3J5IGlzIGFsbG9jYXRlZAo+ID4gPiA+ID4gYW5kIERN
QSBpcyBjb21wbGV0ZWQgaW4gYWR2YW5jZSwgc28gaXQgaXMgbmVjZXNzYXJ5IGZvciB1cyB0byBz
dXBwb3J0Cj4gPiA+ID4gPiBwYXNzaW5nIHRoZSBETUEgYWRkcmVzcyB0byB2aXJ0aW8gY29yZS4K
PiA+ID4gPiA+Cj4gPiA+ID4gPiBEcml2ZXMgY2FuIHVzZSBzZy0+ZG1hX2FkZHJlc3MgdG8gcGFz
cyB0aGUgbWFwcGVkIGRtYSBhZGRyZXNzIHRvIHZpcnRpbwo+ID4gPiA+ID4gY29yZS4gSWYgb25l
IHNnLT5kbWFfYWRkcmVzcyBpcyB1c2VkIHRoZW4gYWxsIHNncyBtdXN0IHVzZSBzZy0+ZG1hX2Fk
ZHJlc3MsCj4gPiA+ID4gPiBvdGhlcndpc2UgYWxsIGRtYV9hZGRyZXNzIG11c3QgYmUgbnVsbC4K
PiA+ID4gPiA+Cj4gPiA+ID4gPiBPbiB0aGUgaW5kaXJlY3QgcGF0aCwgaWYgZG1hX2FkZHJlc3Mg
aXMgdXNlZCwgZGVzY19zdGF0ZS5pbmRpcl9kZXNjIHdpbGwKPiA+ID4gPiA+IGJlIG1peGVkIHdp
dGggVlJJTkdfSU5ESVJFQ1RfUFJFTUFQUEVELiBTbyB3aGVuIGRvIHVubWFwLCB3ZSBjYW4gcGFz
cyBpdC4KPiA+ID4gPgo+ID4gPiA+IEl0J3MgYmV0dGVyIHRvIG1lbnRpb24gd2h5IGluZGlyZWN0
IGRlc2NyaXB0b3JzIGNhbid0IGJlIGRvbmUgaW4gdGhlCj4gPiA+ID4gc2FtZSB3YXkgd2l0aCBk
aXJlY3QgZGVzY3JpcHRvcnMuCj4gPiA+ID4KPiA+ID4gPiBCdHcsIGlmIHdlIGNoYW5nZSB0aGUg
c2VtYW50aWNzIG9mIGRlc2NfZXh0cmEuZG1hX2FkZHIgYW5kCj4gPiA+ID4gZGVzY19zdGF0ZS5p
bmRpcl9kZXNjLCB3ZSBzaG91bGQgYWRkIGNvbW1lbnRzIHRvIGRlZmluaXRpb25zIG9mIHRob3Nl
Cj4gPiA+ID4gc3RydWN0dXJlcy4KPiA+ID4KPiA+ID4KPiA+ID4gV2lsbCBmaXguCj4gPiA+Cj4g
PiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56
aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiAgZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDI4ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0KPiA+
ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkK
PiA+ID4gPiA+Cj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gPiA+IGluZGV4IDY2YTA3
MWUzYmRlZi4uMTE4MjdkMmU1NmE4IDEwMDY0NAo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYwo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYwo+ID4gPiA+ID4gQEAgLTIzMSw2ICsyMzEsMTggQEAgc3RhdGljIHZvaWQgdnJpbmdfZnJl
ZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpOwo+ID4gPiA+ID4gICAqIEhlbHBlcnMuCj4gPiA+ID4g
PiAgICovCj4gPiA+ID4gPgo+ID4gPiA+ID4gKyNkZWZpbmUgVlJJTkdfSU5ESVJFQ1RfUFJFTUFQ
UEVEICBCSVQoMCkKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsjZGVmaW5lIGRlc2NfbWl4X2RtYV9t
YXAoZG9fbWFwLCBkZXNjKSBcCj4gPiA+ID4gPiArICAgICAgIChkb19tYXAgPyBkZXNjIDogKHR5
cGVvZihkZXNjKSkoKHVuc2lnbmVkIGxvbmcpKGRlc2MpIHwgVlJJTkdfSU5ESVJFQ1RfUFJFTUFQ
UEVEKSkKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsjZGVmaW5lIGRlc2Nfcm1fZG1hX21hcChkZXNj
KSBcCj4gPiA+ID4gPiArICAgICAgICgodHlwZW9mKGRlc2MpKSgodW5zaWduZWQgbG9uZykoZGVz
YykgJiB+VlJJTkdfSU5ESVJFQ1RfUFJFTUFQUEVEKSkKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsj
ZGVmaW5lIGRlc2NfbWFwX2ludGVyKGRlc2MpIFwKPiA+ID4gPiA+ICsgICAgICAgISgodW5zaWdu
ZWQgbG9uZykoZGVzYykgJiBWUklOR19JTkRJUkVDVF9QUkVNQVBQRUQpCj4gPiA+ID4gPiArCj4g
PiA+ID4gPiArCj4gPiA+ID4gPiAgI2RlZmluZSB0b192dnEoX3ZxKSBjb250YWluZXJfb2YoX3Zx
LCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlLCB2cSkKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgc3RhdGlj
IGlubGluZSBib29sIHZpcnRxdWV1ZV91c2VfaW5kaXJlY3Qoc3RydWN0IHZyaW5nX3ZpcnRxdWV1
ZSAqdnEsCj4gPiA+ID4gPiBAQCAtNzI1LDcgKzczNyw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZp
cnRxdWV1ZV9hZGRfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ID4gPiA+ID4gICAgICAg
ICAvKiBTdG9yZSB0b2tlbiBhbmQgaW5kaXJlY3QgYnVmZmVyIHN0YXRlLiAqLwo+ID4gPiA+ID4g
ICAgICAgICB2cS0+c3BsaXQuZGVzY19zdGF0ZVtoZWFkXS5kYXRhID0gZGF0YTsKPiA+ID4gPiA+
ICAgICAgICAgaWYgKGluZGlyZWN0KQo+ID4gPiA+ID4gLSAgICAgICAgICAgICAgIHZxLT5zcGxp
dC5kZXNjX3N0YXRlW2hlYWRdLmluZGlyX2Rlc2MgPSBkZXNjOwo+ID4gPiA+ID4gKyAgICAgICAg
ICAgICAgIHZxLT5zcGxpdC5kZXNjX3N0YXRlW2hlYWRdLmluZGlyX2Rlc2MgPSBkZXNjX21peF9k
bWFfbWFwKGRvX21hcCwgZGVzYyk7Cj4gPiA+ID4KPiA+ID4gPiBTbyB1c2luZyBpbmRpcl9kZXNj
IGlzIGtpbmQgb2YgaGFja3kgKHNpbmNlIHdlIGRvbid0IHVzZSBpbmRpcmVjdCBmb3IKPiA+ID4g
PiByeCB3aXRoIGV4dHJhIGNvbnRleHQpLgo+ID4gPiA+Cj4gPiA+ID4gQnV0IGF0IGxlYXN0IEkg
dGhpbmsgd2Ugc2hvdWxkIHNlZWthIHdheSB0byB1c2UgdGhlIHNhbWUgbWV0YWRhdGEgZm9yCj4g
PiA+ID4gYm90aCBkaXJlY3QgYW5kIGluZGlyZWN0IGRlc2NyaXB0b3JzLgo+ID4gPiA+Cj4gPiA+
ID4gRS5nIGNhbiB3ZSBtYWtlIHRoZW0gYWxsIHRvIHVzZSBpbmRpcl9kZXNjPwo+ID4gPgo+ID4g
PiBJIHRoaW5rIGl0IG1heSBub3QuIE15IG9yaWdpbmFsIGlkZWEgaXMgdG8gdXNlIGluZGlyX2Rl
c2MgdW5pZm9ybWx5LCBidXQKPiA+ID4gZm9yIHRoZSBzY2VuZSBvZiBzYXZpbmcgY3R4LCB3ZSBj
YW5ub3QgZ3VhcmFudGVlIHRoYXQgdGhlIGN0eCBoYXMgc3BhY2UgZm9yIHVzLgo+ID4KPiA+IE9r
LCBidXQgdGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgY29kZSBiZWNhbWUgZXZlbiBtb3JlIGhhY2t5
IChpbWFnaW5lCj4gPiBvbmUgZGF5IHdlIG1heSB3YW50IHRvIHVzZSBpbmRpcmVjdCBmb3IgUlg/
KS4KPgo+Cj4gSSB0aGluayBpdCBtYXkgaGF2ZSBub3RoaW5nIHRvIGRvIHdpdGggUlgsIGJ1dCB3
aGV0aGVyIGN0eCBpcyB1c2VkLiBCZWNhdXNlIGN0eAo+IGFuZCBpbmRpcmVjdCBjYW5ub3QgY29l
eGlzdC4KPgo+ICAgICAgICAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxpdChz
dHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCBzY2F0dGVybGlzdCAqc2dzW10sCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCB0b3RhbF9zZywKPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50
IG91dF9zZ3MsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHVuc2lnbmVkIGludCBpbl9zZ3MsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHZvaWQgKmRhdGEsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHZvaWQgKmN0eCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZ2ZwX3QgZ2ZwKQo+ICAgICAgICAgewo+ICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ICAgICAgICAgICAg
ICAgICBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnOwo+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgdnJp
bmdfZGVzYyAqZGVzYzsKPiAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGksIG4sIGF2YWls
LCBkZXNjc191c2VkLCBwcmV2LCBlcnJfaWR4Owo+ICAgICAgICAgICAgICAgICBpbnQgaGVhZDsK
PiAgICAgICAgICAgICAgICAgYm9vbCBpbmRpcmVjdDsKPgo+ICAgICAgICAgICAgICAgICBTVEFS
VF9VU0UodnEpOwo+Cj4gICAgICAgICAgICAgICAgIEJVR19PTihkYXRhID09IE5VTEwpOwo+ICAg
ICAgICAgPiAgICAgICBCVUdfT04oY3R4ICYmIHZxLT5pbmRpcmVjdCk7Cj4KPiBJZiB3ZSB3YW50
IHRvIHVzZSBjdHggd2l0aCBpbmRpcmVjdCwgd2UgbXVzdCBhZGQgYW4gZGVkaWNhdGVkIG1ldGFk
YXRhIGZvciBjdHguCgpUaGUgcmVhc29uIHRoaXMgQlVHX09OKCkgaXMgdGhhdCB3ZSBkbyBhIGhh
Y2s6CgpGb3IgdGhlIHZxIHRoYXQgdXNlIGN0eCBpdCBjYW4ndCB1c2UgaW5kaXJlY3QuIFRoZSBv
bmx5IHVzZXIgc28gZmFyIGlzCnRoZSBtZXJnZWFibGUgUlggcGF0aC4gVGhpcyBwYXRoIGFkZHMg
b25lIG1vcmUgaGFjayBvbiB0b3AsIHRoaXMgc2VlbXMKYSBidXJkZW4gZm9yIHRoZSBmdXR1cmUg
bWFpbnRlbmFuY2UuIENvbnNpZGVyIG9uZSBkYXkgd2UgbWF5IHdhbnQgdG8KdXNlIGEgdmlydHF1
ZXVlIHdpdGggYm90aCBpbmRpcmVjdCBhbmQgZXh0cmEgY29udGV4dC4KCldlIGNhbiBoZWFyIGZy
b20gb3RoZXJzLgoKVGhhbmtzCgo+Cj4gU28gSSB0aGluayB0aGUgY3VycmVudCBwbGFuIGlzIE9L
Lgo+Cj4gVGhhbmtzLgo+Cj4gPgo+ID4gU28gSSB0ZW5kIHRvIGNoYW5nZSBteSBtaW5kIHRvIGlu
dHJvZHVjZSBkZWRpY2F0ZWQgbWV0YWRhdGEsIGluc3RlYWQKPiA+IG9mIHRyeWluZyB0byBiZSBw
YWNrZWQgd2l0aCB0d28gdHlwZXMgb2YgdGhlIGV4aXN0aW5nIG9uZXMuCj4gPgo+ID4gVGhhbmtz
Cj4gPgo+ID4gPgo+ID4gPiBUaGFua3MuCj4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBUaGFua3MKPiA+
ID4gPgo+ID4gPiA+ID4gICAgICAgICBlbHNlCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgdnEt
PnNwbGl0LmRlc2Nfc3RhdGVbaGVhZF0uaW5kaXJfZGVzYyA9IGN0eDsKPiA+ID4gPiA+Cj4gPiA+
ID4gPiBAQCAtODIwLDIyICs4MzIsMjYgQEAgc3RhdGljIHZvaWQgZGV0YWNoX2J1Zl9zcGxpdChz
dHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwgdW5zaWduZWQgaW50IGhlYWQsCj4gPiA+ID4gPiAg
ICAgICAgIHZxLT52cS5udW1fZnJlZSsrOwo+ID4gPiA+ID4KPiA+ID4gPiA+ICAgICAgICAgaWYg
KHZxLT5pbmRpcmVjdCkgewo+ID4gPiA+ID4gLSAgICAgICAgICAgICAgIHN0cnVjdCB2cmluZ19k
ZXNjICppbmRpcl9kZXNjID0KPiA+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdnEtPnNwbGl0LmRlc2Nfc3RhdGVbaGVhZF0uaW5kaXJfZGVzYzsKPiA+ID4gPiA+ICsgICAg
ICAgICAgICAgICBzdHJ1Y3QgdnJpbmdfZGVzYyAqbWl4ID0gdnEtPnNwbGl0LmRlc2Nfc3RhdGVb
aGVhZF0uaW5kaXJfZGVzYzsKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBzdHJ1Y3QgdnJpbmdf
ZGVzYyAqaW5kaXJfZGVzYzsKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICB1MzIgbGVuOwo+ID4g
PiA+ID4KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAvKiBGcmVlIHRoZSBpbmRpcmVjdCB0YWJs
ZSwgaWYgYW55LCBub3cgdGhhdCBpdCdzIHVubWFwcGVkLiAqLwo+ID4gPiA+ID4gLSAgICAgICAg
ICAgICAgIGlmICghaW5kaXJfZGVzYykKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBpZiAoIW1p
eCkKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybjsKPiA+ID4gPiA+Cj4g
PiA+ID4gPiArICAgICAgICAgICAgICAgaW5kaXJfZGVzYyA9IGRlc2Nfcm1fZG1hX21hcChtaXgp
Owo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gICAgICAgICAgICAgICAgIGxlbiA9IHZxLT5zcGxpdC5k
ZXNjX2V4dHJhW2hlYWRdLmxlbjsKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAg
QlVHX09OKCEodnEtPnNwbGl0LmRlc2NfZXh0cmFbaGVhZF0uZmxhZ3MgJgo+ID4gPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWUklOR19ERVNDX0ZfSU5ESVJFQ1QpKTsKPiA+
ID4gPiA+ICAgICAgICAgICAgICAgICBCVUdfT04obGVuID09IDAgfHwgbGVuICUgc2l6ZW9mKHN0
cnVjdCB2cmluZ19kZXNjKSk7Cj4gPiA+ID4gPgo+ID4gPiA+ID4gLSAgICAgICAgICAgICAgIGZv
ciAoaiA9IDA7IGogPCBsZW4gLyBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2MpOyBqKyspCj4gPiA+
ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICB2cmluZ191bm1hcF9vbmVfc3BsaXRfaW5kaXJl
Y3QodnEsICZpbmRpcl9kZXNjW2pdKTsKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBpZiAoZGVz
Y19tYXBfaW50ZXIobWl4KSkgewo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZm9y
IChqID0gMDsgaiA8IGxlbiAvIHNpemVvZihzdHJ1Y3QgdnJpbmdfZGVzYyk7IGorKykKPiA+ID4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnJpbmdfdW5tYXBfb25lX3NwbGl0
X2luZGlyZWN0KHZxLCAmaW5kaXJfZGVzY1tqXSk7Cj4gPiA+ID4gPiArICAgICAgICAgICAgICAg
fQo+ID4gPiA+ID4KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBrZnJlZShpbmRpcl9kZXNjKTsK
PiA+ID4gPiA+ICAgICAgICAgICAgICAgICB2cS0+c3BsaXQuZGVzY19zdGF0ZVtoZWFkXS5pbmRp
cl9kZXNjID0gTlVMTDsKPiA+ID4gPiA+IC0tCj4gPiA+ID4gPiAyLjMyLjAuMy5nMDExOTVjZjlm
Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+Cj4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
