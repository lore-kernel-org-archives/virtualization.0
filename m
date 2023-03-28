Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AE9C76195
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 06:27:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9B93821A3;
	Tue, 28 Mar 2023 06:27:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B9B93821A3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CKb2/zrd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RouvOxunp8CF; Tue, 28 Mar 2023 06:27:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1753582197;
	Tue, 28 Mar 2023 06:27:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1753582197
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3354C0036;
	Tue, 28 Mar 2023 06:27:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82777C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:27:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D0B582194
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:27:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D0B582194
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vMCkPStImNOv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:27:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 80B668216F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 80B668216F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679984840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T6pvJOsC6SA6t64s3bzmjJw0XD2OF+cI58obnVlUyDs=;
 b=CKb2/zrdBtEkMQUYzDTJK0ZqaExfaxVBFeLM6H1HAkbwGAxy4G7ZvmNrHrXuANYDzLvamE
 TW+GRoICZ8VYn+PzS0dsFrDNLIbDvbIUAoAKL7H73ilKbLoT2TCKX8C0Pdy40L1gXHYRm1
 j3Q3xDstS8VBEnQGbS4sh3pncmujDM4=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587--2L1NMSyPha1MTy4LtTnuA-1; Tue, 28 Mar 2023 02:27:15 -0400
X-MC-Unique: -2L1NMSyPha1MTy4LtTnuA-1
Received: by mail-ot1-f72.google.com with SMTP id
 h17-20020a9d3e51000000b006a1209a8030so3403907otg.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 23:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679984835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T6pvJOsC6SA6t64s3bzmjJw0XD2OF+cI58obnVlUyDs=;
 b=uuRV1UTcmyPgUeQlJcri6TJPw4g3DPswCq5M+N5I1+0WhyWSlP4sb7Dky/uxNxZvCr
 yl6ziOVOYGJ37mWYd6fZdSGgXg5UaDr9zH+lyEnZKluH8F+9afw6t3qRdh8LFInsFs8K
 auCYk06bMD3kldOT25PPuEEEcWdE7hhv7haYR/aidwrNAF8kHVCFFynGgO2kpFAy3M0G
 /j9RsNoIp+MMh8PbKZxgpMirXvQ2sg6+tUUu80KBjPmc32nrUfjIQLMf5n0lf4JdaGma
 t/6bWPThZnjLwaEx7QeC/psrhnTiilN4mWlJ0wUM4RXDI80l3UuTNJobPUVAafWNaiqK
 WEuA==
X-Gm-Message-State: AO0yUKX7e10p9XdVoOeysGOhPfX691Nhm9mOSSE6nMrDL8g07UXtyUc3
 sjCXM0JFSIsJGV8AfrhYm10LtyTcYylpT1x/FwSyR8P6zCMc6KZQWB0gnnTL0seBIsYfBPY76SW
 TU2lv4plQm77bNF9wZR3+o+wc+YhUG63S89xte8j1tPljuSXv7grxY6Ybyg==
X-Received: by 2002:aca:916:0:b0:383:fad3:d19 with SMTP id
 22-20020aca0916000000b00383fad30d19mr4176985oij.9.1679984835198; 
 Mon, 27 Mar 2023 23:27:15 -0700 (PDT)
X-Google-Smtp-Source: AK7set+bQtKb8yzEHS+v7x9uCwzRtHVvDqFQHcj9BLREZChaVGP7d2Or4qc7XRtq8K0lPaQT2gnyinwuCzv6kBn05rs=
X-Received: by 2002:aca:916:0:b0:383:fad3:d19 with SMTP id
 22-20020aca0916000000b00383fad30d19mr4176980oij.9.1679984834876; 
 Mon, 27 Mar 2023 23:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230327040536.48338-1-xuanzhuo@linux.alibaba.com>
 <20230327040536.48338-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230327040536.48338-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Mar 2023 14:27:03 +0800
Message-ID: <CACGkMEuKuUVRkbBxXrqonv-Wpcz+ZVCbT2xSCmCUHG6VR4gq_Q@mail.gmail.com>
Subject: Re: [PATCH vhost v6 04/11] virtio_ring: split: support premapped
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

T24gTW9uLCBNYXIgMjcsIDIwMjMgYXQgMTI6MDXigK9QTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IHZpcnRpbyBjb3JlIG9ubHkgc3VwcG9ydHMgdmly
dHVhbCBhZGRyZXNzZXMsIGRtYSBpcyBjb21wbGV0ZWQgaW4gdmlydGlvCj4gY29yZS4KPgo+IElu
IHNvbWUgc2NlbmFyaW9zIChzdWNoIGFzIHRoZSBBRl9YRFApLCB0aGUgbWVtb3J5IGlzIGFsbG9j
YXRlZAo+IGFuZCBETUEgbWFwcGluZyBpcyBjb21wbGV0ZWQgaW4gYWR2YW5jZSwgc28gaXQgaXMg
bmVjZXNzYXJ5IGZvciB1cyB0bwo+IHN1cHBvcnQgcGFzc2luZyB0aGUgRE1BIGFkZHJlc3MgdG8g
dmlydGlvIGNvcmUuCj4KPiBEcml2ZXMgY2FuIHVzZSBzZy0+ZG1hX2FkZHJlc3MgdG8gcGFzcyB0
aGUgbWFwcGVkIGRtYSBhZGRyZXNzIHRvIHZpcnRpbwo+IGNvcmUuIElmIG9uZSBzZy0+ZG1hX2Fk
ZHJlc3MgaXMgdXNlZCB0aGVuIGFsbCBzZ3MgbXVzdCB1c2UKPiBzZy0+ZG1hX2FkZHJlc3MsIG90
aGVyd2lzZSBhbGwgbXVzdCBiZSBudWxsIHdoZW4gcGFzc2luZyBpdCB0byB0aGUgQVBJcwo+IG9m
IHZpcnRpby4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxp
YmFiYS5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRo
YW5rcwoKPiAtLS0KPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDMxICsrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMo
KyksIDggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCAzYWRhMzBiNDc1
ZDIuLjlkNmFjZDU5ZTNlMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC02Nyw5ICs2Nywx
MyBAQAo+ICAjZGVmaW5lIExBU1RfQUREX1RJTUVfSU5WQUxJRCh2cSkKPiAgI2VuZGlmCj4KPiAr
I2RlZmluZSBWUklOR19TVEFURV9GX01BUF9JTlRFUk5BTCBCSVQoMCkKPiArCj4gIHN0cnVjdCB2
cmluZ19kZXNjX3N0YXRlX3NwbGl0IHsKPiAgICAgICAgIHZvaWQgKmRhdGE7ICAgICAgICAgICAg
ICAgICAgICAgLyogRGF0YSBmb3IgY2FsbGJhY2suICovCj4gICAgICAgICBzdHJ1Y3QgdnJpbmdf
ZGVzYyAqaW5kaXJfZGVzYzsgIC8qIEluZGlyZWN0IGRlc2NyaXB0b3IsIGlmIGFueS4gKi8KPiAr
ICAgICAgIHUzMiBmbGFnczsgICAgICAgICAgICAgICAgICAgICAgLyogU3RhdGUgZmxhZ3MuICov
Cj4gKyAgICAgICB1MzIgcGFkZGluZzsKPiAgfTsKPgo+ICBzdHJ1Y3QgdnJpbmdfZGVzY19zdGF0
ZV9wYWNrZWQgewo+IEBAIC00NDgsNyArNDUyLDcgQEAgc3RhdGljIHZvaWQgdnJpbmdfdW5tYXBf
b25lX3NwbGl0X2luZGlyZWN0KGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ICB9
Cj4KPiAgc3RhdGljIHVuc2lnbmVkIGludCB2cmluZ191bm1hcF9vbmVfc3BsaXQoY29uc3Qgc3Ry
dWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdW5zaWduZWQgaW50IGkpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGksIGJvb2wgZG1hX21hcF9pbnRlcm5hbCkKPiAg
ewo+ICAgICAgICAgc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKmV4dHJhID0gdnEtPnNwbGl0LmRl
c2NfZXh0cmE7Cj4gICAgICAgICB1MTYgZmxhZ3M7Cj4gQEAgLTQ2NSw2ICs0NjksOSBAQCBzdGF0
aWMgdW5zaWduZWQgaW50IHZyaW5nX3VubWFwX29uZV9zcGxpdChjb25zdCBzdHJ1Y3QgdnJpbmdf
dmlydHF1ZXVlICp2cSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoZmxhZ3Mg
JiBWUklOR19ERVNDX0ZfV1JJVEUpID8KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBETUFfRlJPTV9ERVZJQ0UgOiBETUFfVE9fREVWSUNFKTsKPiAgICAgICAgIH0gZWxzZSB7Cj4g
KyAgICAgICAgICAgICAgIGlmICghZG1hX21hcF9pbnRlcm5hbCkKPiArICAgICAgICAgICAgICAg
ICAgICAgICBnb3RvIG91dDsKPiArCj4gICAgICAgICAgICAgICAgIGRtYV91bm1hcF9wYWdlKHZy
aW5nX2RtYV9kZXYodnEpLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBleHRyYVtp
XS5hZGRyLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBleHRyYVtpXS5sZW4sCj4g
QEAgLTYxNSw3ICs2MjIsNyBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3NwbGl0
KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiAgICAgICAgIHN0cnVjdCBzY2F0dGVybGlzdCAqc2c7
Cj4gICAgICAgICBzdHJ1Y3QgdnJpbmdfZGVzYyAqZGVzYzsKPiAgICAgICAgIHVuc2lnbmVkIGlu
dCBpLCBuLCBhdmFpbCwgZGVzY3NfdXNlZCwgcHJldjsKPiAtICAgICAgIGJvb2wgaW5kaXJlY3Q7
Cj4gKyAgICAgICBib29sIGluZGlyZWN0LCBkbWFfbWFwX2ludGVybmFsOwo+ICAgICAgICAgaW50
IGhlYWQ7Cj4KPiAgICAgICAgIFNUQVJUX1VTRSh2cSk7Cj4gQEAgLTY2OCw3ICs2NzUsOCBAQCBz
dGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92
cSwKPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9TUEM7Cj4gICAgICAgICB9Cj4KPiAtICAg
ICAgIGlmICh2aXJ0cXVldWVfbWFwX3Nncyh2cSwgc2dzLCB0b3RhbF9zZywgb3V0X3NncywgaW5f
c2dzKSkKPiArICAgICAgIGRtYV9tYXBfaW50ZXJuYWwgPSAhc2dzWzBdLT5kbWFfYWRkcmVzczsK
PiArICAgICAgIGlmIChkbWFfbWFwX2ludGVybmFsICYmIHZpcnRxdWV1ZV9tYXBfc2dzKHZxLCBz
Z3MsIHRvdGFsX3NnLCBvdXRfc2dzLCBpbl9zZ3MpKQo+ICAgICAgICAgICAgICAgICBnb3RvIGVy
cl9tYXA7Cj4KPiAgICAgICAgIGZvciAobiA9IDA7IG4gPCBvdXRfc2dzOyBuKyspIHsKPiBAQCAt
NzM1LDYgKzc0Myw4IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfc3BsaXQoc3Ry
dWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ICAgICAgICAgZWxzZQo+ICAgICAgICAgICAgICAgICB2cS0+
c3BsaXQuZGVzY19zdGF0ZVtoZWFkXS5pbmRpcl9kZXNjID0gY3R4Owo+Cj4gKyAgICAgICB2cS0+
c3BsaXQuZGVzY19zdGF0ZVtoZWFkXS5mbGFncyA9IGRtYV9tYXBfaW50ZXJuYWwgPyBWUklOR19T
VEFURV9GX01BUF9JTlRFUk5BTCA6IDA7Cj4gKwo+ICAgICAgICAgLyogUHV0IGVudHJ5IGluIGF2
YWlsYWJsZSBhcnJheSAoYnV0IGRvbid0IHVwZGF0ZSBhdmFpbC0+aWR4IHVudGlsIHRoZXkKPiAg
ICAgICAgICAqIGRvIHN5bmMpLiAqLwo+ICAgICAgICAgYXZhaWwgPSB2cS0+c3BsaXQuYXZhaWxf
aWR4X3NoYWRvdyAmICh2cS0+c3BsaXQudnJpbmcubnVtIC0gMSk7Cj4gQEAgLTc1OSw3ICs3Njks
OCBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3NwbGl0KHN0cnVjdCB2aXJ0cXVl
dWUgKl92cSwKPiAgICAgICAgIHJldHVybiAwOwo+Cj4gIHVubWFwX3JlbGVhc2U6Cj4gLSAgICAg
ICB2aXJ0cXVldWVfdW5tYXBfc2dzKHZxLCBzZ3MsIHRvdGFsX3NnLCBvdXRfc2dzLCBpbl9zZ3Mp
Owo+ICsgICAgICAgaWYgKGRtYV9tYXBfaW50ZXJuYWwpCj4gKyAgICAgICAgICAgICAgIHZpcnRx
dWV1ZV91bm1hcF9zZ3ModnEsIHNncywgdG90YWxfc2csIG91dF9zZ3MsIGluX3Nncyk7Cj4KPiAg
ZXJyX21hcDoKPiAgICAgICAgIGlmIChpbmRpcmVjdCkKPiBAQCAtODA1LDIwICs4MTYsMjIgQEAg
c3RhdGljIHZvaWQgZGV0YWNoX2J1Zl9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwg
dW5zaWduZWQgaW50IGhlYWQsCj4gIHsKPiAgICAgICAgIHVuc2lnbmVkIGludCBpLCBqOwo+ICAg
ICAgICAgX192aXJ0aW8xNiBuZXh0ZmxhZyA9IGNwdV90b192aXJ0aW8xNih2cS0+dnEudmRldiwg
VlJJTkdfREVTQ19GX05FWFQpOwo+ICsgICAgICAgYm9vbCBkbWFfbWFwX2ludGVybmFsOwo+Cj4g
ICAgICAgICAvKiBDbGVhciBkYXRhIHB0ci4gKi8KPiAgICAgICAgIHZxLT5zcGxpdC5kZXNjX3N0
YXRlW2hlYWRdLmRhdGEgPSBOVUxMOwo+ICsgICAgICAgZG1hX21hcF9pbnRlcm5hbCA9ICEhKHZx
LT5zcGxpdC5kZXNjX3N0YXRlW2hlYWRdLmZsYWdzICYgVlJJTkdfU1RBVEVfRl9NQVBfSU5URVJO
QUwpOwo+Cj4gICAgICAgICAvKiBQdXQgYmFjayBvbiBmcmVlIGxpc3Q6IHVubWFwIGZpcnN0LWxl
dmVsIGRlc2NyaXB0b3JzIGFuZCBmaW5kIGVuZCAqLwo+ICAgICAgICAgaSA9IGhlYWQ7Cj4KPiAg
ICAgICAgIHdoaWxlICh2cS0+c3BsaXQudnJpbmcuZGVzY1tpXS5mbGFncyAmIG5leHRmbGFnKSB7
Cj4gLSAgICAgICAgICAgICAgIHZyaW5nX3VubWFwX29uZV9zcGxpdCh2cSwgaSk7Cj4gKyAgICAg
ICAgICAgICAgIHZyaW5nX3VubWFwX29uZV9zcGxpdCh2cSwgaSwgZG1hX21hcF9pbnRlcm5hbCk7
Cj4gICAgICAgICAgICAgICAgIGkgPSB2cS0+c3BsaXQuZGVzY19leHRyYVtpXS5uZXh0Owo+ICAg
ICAgICAgICAgICAgICB2cS0+dnEubnVtX2ZyZWUrKzsKPiAgICAgICAgIH0KPgo+IC0gICAgICAg
dnJpbmdfdW5tYXBfb25lX3NwbGl0KHZxLCBpKTsKPiArICAgICAgIHZyaW5nX3VubWFwX29uZV9z
cGxpdCh2cSwgaSwgZG1hX21hcF9pbnRlcm5hbCk7Cj4gICAgICAgICB2cS0+c3BsaXQuZGVzY19l
eHRyYVtpXS5uZXh0ID0gdnEtPmZyZWVfaGVhZDsKPiAgICAgICAgIHZxLT5mcmVlX2hlYWQgPSBo
ZWFkOwo+Cj4gQEAgLTg0MCw4ICs4NTMsMTAgQEAgc3RhdGljIHZvaWQgZGV0YWNoX2J1Zl9zcGxp
dChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwgdW5zaWduZWQgaW50IGhlYWQsCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBWUklOR19ERVNDX0ZfSU5ESVJFQ1QpKTsKPiAgICAg
ICAgICAgICAgICAgQlVHX09OKGxlbiA9PSAwIHx8IGxlbiAlIHNpemVvZihzdHJ1Y3QgdnJpbmdf
ZGVzYykpOwo+Cj4gLSAgICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBsZW4gLyBzaXplb2Yo
c3RydWN0IHZyaW5nX2Rlc2MpOyBqKyspCj4gLSAgICAgICAgICAgICAgICAgICAgICAgdnJpbmdf
dW5tYXBfb25lX3NwbGl0X2luZGlyZWN0KHZxLCAmaW5kaXJfZGVzY1tqXSk7Cj4gKyAgICAgICAg
ICAgICAgIGlmIChkbWFfbWFwX2ludGVybmFsKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAg
Zm9yIChqID0gMDsgaiA8IGxlbiAvIHNpemVvZihzdHJ1Y3QgdnJpbmdfZGVzYyk7IGorKykKPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZyaW5nX3VubWFwX29uZV9zcGxpdF9pbmRp
cmVjdCh2cSwgJmluZGlyX2Rlc2Nbal0pOwo+ICsgICAgICAgICAgICAgICB9Cj4KPiAgICAgICAg
ICAgICAgICAga2ZyZWUoaW5kaXJfZGVzYyk7Cj4gICAgICAgICAgICAgICAgIHZxLT5zcGxpdC5k
ZXNjX3N0YXRlW2hlYWRdLmluZGlyX2Rlc2MgPSBOVUxMOwo+IC0tCj4gMi4zMi4wLjMuZzAxMTk1
Y2Y5Zgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
