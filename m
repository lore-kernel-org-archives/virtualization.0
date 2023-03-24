Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005DCC6FD1C
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 06:57:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C817403AA;
	Fri, 24 Mar 2023 06:57:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C817403AA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vsQ2tsuezAdM; Fri, 24 Mar 2023 06:57:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 02B7C40236;
	Fri, 24 Mar 2023 06:57:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 02B7C40236
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7AF0C0035;
	Fri, 24 Mar 2023 06:57:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CA6AC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E43F60E24
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:57:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E43F60E24
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C1I8fB6NndMW
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:57:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D1B660E19
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9D1B660E19
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:57:40 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VeWqv5r_1679641055; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VeWqv5r_1679641055) by smtp.aliyun-inc.com;
 Fri, 24 Mar 2023 14:57:35 +0800
Message-ID: <1679640931.657412-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v5 05/11] virtio_ring: packed: support premapped
Date: Fri, 24 Mar 2023 14:55:31 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230324063010.48670-1-xuanzhuo@linux.alibaba.com>
 <20230324063010.48670-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEtoii-vXeFfdcYQ8VMk-PomqNMdpcZ9ymVvZ39zZ=6s0g@mail.gmail.com>
In-Reply-To: <CACGkMEtoii-vXeFfdcYQ8VMk-PomqNMdpcZ9ymVvZ39zZ=6s0g@mail.gmail.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gRnJpLCAyNCBNYXIgMjAyMyAxNDo0Nzo1NiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgMjozMOKAr1BNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IHZpcnRp
byBjb3JlIG9ubHkgc3VwcG9ydHMgdmlydHVhbCBhZGRyZXNzZXMsIGRtYSBpcyBjb21wbGV0ZWQg
aW4gdmlydGlvCj4gPiBjb3JlLgo+ID4KPiA+IEluIHNvbWUgc2NlbmFyaW9zIChzdWNoIGFzIHRo
ZSBBRl9YRFApLCB0aGUgbWVtb3J5IGlzIGFsbG9jYXRlZAo+ID4gYW5kIERNQSBtYXBwaW5nIGlz
IGNvbXBsZXRlZCBpbiBhZHZhbmNlLCBzbyBpdCBpcyBuZWNlc3NhcnkgZm9yIHVzIHRvCj4gPiBz
dXBwb3J0IHBhc3NpbmcgdGhlIERNQSBhZGRyZXNzIHRvIHZpcnRpbyBjb3JlLgo+ID4KPiA+IERy
aXZlcyBjYW4gdXNlIHNnLT5kbWFfYWRkcmVzcyB0byBwYXNzIHRoZSBtYXBwZWQgZG1hIGFkZHJl
c3MgdG8gdmlydGlvCj4gPiBjb3JlLiBJZiBvbmUgc2ctPmRtYV9hZGRyZXNzIGlzIHVzZWQgdGhl
biBhbGwgc2dzIG11c3QgdXNlCj4gPiBzZy0+ZG1hX2FkZHJlc3MsIG90aGVyd2lzZSBhbGwgbXVz
dCBiZSBudWxsIHdoZW4gcGFzc2luZyBpdCB0byB0aGUgQVBJcwo+ID4gb2YgdmlydGlvLgo+ID4K
PiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+
Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMTcgKysrKysrKysr
KysrKystLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+IGluZGV4IDFjMzA4NGE4ZjRlMy4uZGY2
ZDUxNGE2ODFhIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+
ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gQEAgLTc4LDYgKzc4LDcg
QEAgc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfc3BsaXQgewo+ID4gIHN0cnVjdCB2cmluZ19kZXNj
X3N0YXRlX3BhY2tlZCB7Cj4gPiAgICAgICAgIHZvaWQgKmRhdGE7ICAgICAgICAgICAgICAgICAg
ICAgLyogRGF0YSBmb3IgY2FsbGJhY2suICovCj4gPiAgICAgICAgIHN0cnVjdCB2cmluZ19wYWNr
ZWRfZGVzYyAqaW5kaXJfZGVzYzsgLyogSW5kaXJlY3QgZGVzY3JpcHRvciwgaWYgYW55LiAqLwo+
ID4gKyAgICAgICB1NjQgZmxhZ3M7ICAgICAgICAgICAgICAgICAgICAgIC8qIFN0YXRlIGZsYWdz
LiAqLwo+Cj4gSSdkIHVzZSB1MzIgdGhlbiB0aGVyZSB3b3VsZCBiZSBubyBuZWVkIGZvciB0aGUg
Y29tcGlsZXIgdG8gcGFkIHRoZQo+IHN0cnVjdHVyZSBpbiBib3RoIDMyIGFuZCA2NCBiaXQgYXJj
aHMuCgoKT0suCgpJIGp1c3QgdHJ5IHRvIGtlZXAgdGhlIHNhbWUgYXMgc3BsaXQuIE1heWJlIEkg
c2hvdWxkIGFkZCBzb21lIG5vdGVzLAppbmRpY2F0aW5nIHRoYXQgdGhlcmUgaXMgc29tZSBkaWZm
ZXJlbmNlIGJldHdlZW4gc3BsaXQuCgoKVGhhbmtzLgoKCj4KPiBUaGFua3MKPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
