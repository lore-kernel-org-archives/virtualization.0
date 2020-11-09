Return-Path: <SRS0=pd2K=EP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9313AC388F7
	for <virtualization@archiver.kernel.org>; Mon,  9 Nov 2020 03:41:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F10320657
	for <virtualization@archiver.kernel.org>; Mon,  9 Nov 2020 03:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtjJHmqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F10320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 937348706C;
	Mon,  9 Nov 2020 03:41:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cD6Sv2POKua2; Mon,  9 Nov 2020 03:41:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8ADD786D51;
	Mon,  9 Nov 2020 03:41:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77FE0C088B;
	Mon,  9 Nov 2020 03:41:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D17E2C016F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 03:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B5B1C82C6A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 03:41:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r3fIZnbzXuWI
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 03:41:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6346B822B4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 03:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604893291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HRUOskoa94Uh3kioUg71hmE2ZG0LYjxl0LleZC6OzXQ=;
 b=XtjJHmqa2zJgeN7W5hwje1Sdhl3UB4itNVAialNVGM1ZgOgzyTMxHLmOZ/Mw+kDrhGcbWB
 0zrVxo5Q44oBBWC9/wtxdJ7bVMHvp60zxHq9orQkIeaW9yiI9pZ1ZCwdFkNWNO2U2RxFiX
 Iy5FWTDZvy+TPHqjL/3XEONTpjDBZ7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-s1z3KCySM8eFabxhqcUzmA-1; Sun, 08 Nov 2020 22:41:30 -0500
X-MC-Unique: s1z3KCySM8eFabxhqcUzmA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 298D81009455;
 Mon,  9 Nov 2020 03:41:29 +0000 (UTC)
Received: from [10.72.12.244] (ovpn-12-244.pek2.redhat.com [10.72.12.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B7405B4CD;
 Mon,  9 Nov 2020 03:41:20 +0000 (UTC)
Subject: Re: [PATCH 05/11] vhost: move vq iovec allocation to dev init time
To: Mike Christie <michael.christie@oracle.com>, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, mst@redhat.com,
 pbonzini@redhat.com, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org
References: <1604528804-2878-1-git-send-email-michael.christie@oracle.com>
 <1604528804-2878-6-git-send-email-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <347657f8-7f2a-0e47-bab7-015ad4290684@redhat.com>
Date: Mon, 9 Nov 2020 11:41:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1604528804-2878-6-git-send-email-michael.christie@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjAvMTEvNSDkuIrljYg2OjI2LCBNaWtlIENocmlzdGllIHdyb3RlOgo+IFRoZSBuZXh0
IHBhdGNoZXMgYWxsb3cgdXMgdG8gY3JlYXRlIHZxcyBvbiBkZW1hbmQgYWZ0ZXIgdmhvc3RfZGV2
X2luaXQKPiBhbmQgdmhvc3RfZGV2X3NldF9vd25lciBoYXZlIGJlZW4gY2FsbGVkLiBGb3Igdmhv
c3Qtc2NzaSB3ZSBkb24ndAo+IGtub3cgdGhlIG51bWJlciBvZiB2cXMgd2UgcmVhbGx5IHdhbnQg
dW50aWwgdGhlIHZyaW5nL3ZxIHNldHVwCj4gb3BlcmF0aW9ucyBoYXZlIHN0YXJ0ZWQgdXAuIEZv
ciBvdGhlciBkZXZpY2VzIHdlIGtub3cgdGhlIG51bWJlciBvZiB2cXMKPiBhdCB2aG9zdF9kZXZf
aW5pdCB0aW1lLCBzbyBmb3IgdGhvc2UgZGV2cyB3ZSBpbml0IHRoZSB2cSBhbmQgYWxsb2NhdGUK
PiB0aGUgbmVlZGVkIGlvdmVjcy4gRm9yIHZob3N0LXNjc2kgd2Ugd2lsbCBkbyBpdCBsYXRlciB3
aGVuIHVzZXJzcGFjZSBoYXMKPiBpbmRpY2F0ZWQgdG8gdXMgdGhhdCBpdCdzIGdvaW5nIHRvIHVz
ZSBhIHZxLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWlrZSBDaHJpc3RpZSA8bWljaGFlbC5jaHJpc3Rp
ZUBvcmFjbGUuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aG9zdC92aG9zdC5jIHwgNzEgKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aG9zdC92aG9zdC5jIGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gaW5kZXgg
YjM1MjI5ZS4uYTRhNDQ1MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiAr
KysgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiBAQCAtMzgzLDI5ICszODMsMjcgQEAgc3RhdGlj
IHZvaWQgdmhvc3RfdnFfZnJlZV9pb3ZlY3Moc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqdnEpCj4g
ICAJdnEtPmhlYWRzID0gTlVMTDsKPiAgIH0KPiAgIAo+IC0vKiBIZWxwZXIgdG8gYWxsb2NhdGUg
aW92ZWMgYnVmZmVycyBmb3IgYWxsIHZxcy4gKi8KPiAtc3RhdGljIGxvbmcgdmhvc3RfZGV2X2Fs
bG9jX2lvdmVjcyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4gK3N0YXRpYyBpbnQgdmhvc3RfdnFf
YWxsb2NfaW92ZWNzKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPiArCQkJCSBzdHJ1Y3Qgdmhvc3Rf
dmlydHF1ZXVlICp2cSkKPiAgIHsKPiAtCXN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZxOwo+IC0J
aW50IGk7Cj4gKwl2cS0+aW5kaXJlY3QgPSBrbWFsbG9jX2FycmF5KFVJT19NQVhJT1YsIHNpemVv
ZigqdnEtPmluZGlyZWN0KSwKPiArCQkJCSAgICAgR0ZQX0tFUk5FTCk7Cj4gKwlpZiAoIXZxLT5p
bmRpcmVjdCkKPiArCQlyZXR1cm4gLUVOT01FTTsKPiArCj4gKwlpZiAoIWRldi0+aW92X2xpbWl0
KQo+ICsJCXJldHVybiAwOwoKClRoaXMgbG9va3MgbGlrZSBhbiBvcHRpbWl6YXRpb24uIExldCdz
IHRyeSB0byBkZWZlciB0aGlzIGludG8gYW5vdGhlciBwYXRjaC4KCgo+ICsKPiArCXZxLT5sb2cg
PSBrbWFsbG9jX2FycmF5KGRldi0+aW92X2xpbWl0LCBzaXplb2YoKnZxLT5sb2cpLCBHRlBfS0VS
TkVMKTsKPiArCXZxLT5oZWFkcyA9IGttYWxsb2NfYXJyYXkoZGV2LT5pb3ZfbGltaXQsIHNpemVv
ZigqdnEtPmhlYWRzKSwKPiArCQkJCSAgR0ZQX0tFUk5FTCk7Cj4gKwlpZiAoIXZxLT5sb2cgfHwg
IXZxLT5oZWFkcykKPiArCQlnb3RvIGVycl9ub21lbTsKPiAgIAo+IC0JZm9yIChpID0gMDsgaSA8
IGRldi0+bnZxczsgKytpKSB7Cj4gLQkJdnEgPSBkZXYtPnZxc1tpXTsKPiAtCQl2cS0+aW5kaXJl
Y3QgPSBrbWFsbG9jX2FycmF5KFVJT19NQVhJT1YsCj4gLQkJCQkJICAgICBzaXplb2YoKnZxLT5p
bmRpcmVjdCksCj4gLQkJCQkJICAgICBHRlBfS0VSTkVMKTsKPiAtCQl2cS0+bG9nID0ga21hbGxv
Y19hcnJheShkZXYtPmlvdl9saW1pdCwgc2l6ZW9mKCp2cS0+bG9nKSwKPiAtCQkJCQlHRlBfS0VS
TkVMKTsKPiAtCQl2cS0+aGVhZHMgPSBrbWFsbG9jX2FycmF5KGRldi0+aW92X2xpbWl0LCBzaXpl
b2YoKnZxLT5oZWFkcyksCj4gLQkJCQkJICBHRlBfS0VSTkVMKTsKPiAtCQlpZiAoIXZxLT5pbmRp
cmVjdCB8fCAhdnEtPmxvZyB8fCAhdnEtPmhlYWRzKQo+IC0JCQlnb3RvIGVycl9ub21lbTsKPiAt
CX0KPiAgIAlyZXR1cm4gMDsKPiAgIAo+ICAgZXJyX25vbWVtOgo+IC0JZm9yICg7IGkgPj0gMDsg
LS1pKQo+IC0JCXZob3N0X3ZxX2ZyZWVfaW92ZWNzKGRldi0+dnFzW2ldKTsKPiArCXZob3N0X3Zx
X2ZyZWVfaW92ZWNzKHZxKTsKPiAgIAlyZXR1cm4gLUVOT01FTTsKPiAgIH0KPiAgIAo+IEBAIC00
NTgsNiArNDU2LDIxIEBAIHN0YXRpYyBzaXplX3Qgdmhvc3RfZ2V0X2Rlc2Nfc2l6ZShzdHJ1Y3Qg
dmhvc3RfdmlydHF1ZXVlICp2cSwKPiAgIAlyZXR1cm4gc2l6ZW9mKCp2cS0+ZGVzYykgKiBudW07
Cj4gICB9Cj4gICAKPiArc3RhdGljIGludCB2aG9zdF92cV9pbml0KHN0cnVjdCB2aG9zdF9kZXYg
KmRldiwgc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqdnEpCj4gK3sKPiArCXZxLT5sb2cgPSBOVUxM
Owo+ICsJdnEtPmluZGlyZWN0ID0gTlVMTDsKPiArCXZxLT5oZWFkcyA9IE5VTEw7Cj4gKwl2cS0+
ZGV2ID0gZGV2Owo+ICsJbXV0ZXhfaW5pdCgmdnEtPm11dGV4KTsKPiArCXZob3N0X3ZxX3Jlc2V0
KGRldiwgdnEpOwo+ICsKPiArCWlmICh2cS0+aGFuZGxlX2tpY2spCj4gKwkJdmhvc3RfcG9sbF9p
bml0KCZ2cS0+cG9sbCwgdnEtPmhhbmRsZV9raWNrLCBFUE9MTElOLCBkZXYpOwo+ICsKPiArCXJl
dHVybiB2aG9zdF92cV9hbGxvY19pb3ZlY3MoZGV2LCB2cSk7Cj4gK30KCgpJZiBpdCdzIHBvc3Np
YmxlLCBJIHdvdWxkIGRvIGEgcGF0Y2ggdG8gaW50cm9kdWNlIHZob3N0X3ZxX2luaXQoKSBhbmQg
CnRoZW4gYWRkIHZob3N0X3ZxX2FsbG9jX2lvdmVjcygpIG9uIHRvcC4KClRoYW5rcwoKCj4gKwo+
ICAgaW50IHZob3N0X2Rldl9pbml0KHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPiAgIAkJICAgc3Ry
dWN0IHZob3N0X3ZpcnRxdWV1ZSAqKnZxcywgaW50IG52cXMsCj4gICAJCSAgIGludCBpb3ZfbGlt
aXQsIGludCB3ZWlnaHQsIGludCBieXRlX3dlaWdodCwKPiBAQCAtNDY1LDcgKzQ3OCw2IEBAIGlu
dCB2aG9zdF9kZXZfaW5pdChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4gICAJCSAgIGludCAoKm1z
Z19oYW5kbGVyKShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4gICAJCQkJICAgICAgc3RydWN0IHZo
b3N0X2lvdGxiX21zZyAqbXNnKSkKPiAgIHsKPiAtCXN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZx
Owo+ICAgCWludCBpOwo+ICAgCj4gICAJZGV2LT52cXMgPSB2cXM7Cj4gQEAgLTQ4OSwxOSArNTAx
LDE2IEBAIGludCB2aG9zdF9kZXZfaW5pdChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4gICAKPiAg
IAo+ICAgCWZvciAoaSA9IDA7IGkgPCBkZXYtPm52cXM7ICsraSkgewo+IC0JCXZxID0gZGV2LT52
cXNbaV07Cj4gLQkJdnEtPmxvZyA9IE5VTEw7Cj4gLQkJdnEtPmluZGlyZWN0ID0gTlVMTDsKPiAt
CQl2cS0+aGVhZHMgPSBOVUxMOwo+IC0JCXZxLT5kZXYgPSBkZXY7Cj4gLQkJbXV0ZXhfaW5pdCgm
dnEtPm11dGV4KTsKPiAtCQl2aG9zdF92cV9yZXNldChkZXYsIHZxKTsKPiAtCQlpZiAodnEtPmhh
bmRsZV9raWNrKQo+IC0JCQl2aG9zdF9wb2xsX2luaXQoJnZxLT5wb2xsLCB2cS0+aGFuZGxlX2tp
Y2ssCj4gLQkJCQkJRVBPTExJTiwgZGV2KTsKPiArCQlpZiAodmhvc3RfdnFfaW5pdChkZXYsIGRl
di0+dnFzW2ldKSkKPiArCQkJZ290byBlcnJfdnFfaW5pdDsKPiAgIAl9Cj4gICAKPiAgIAlyZXR1
cm4gMDsKPiArCj4gK2Vycl92cV9pbml0Ogo+ICsJZm9yICgtLWk7IGkgPj0gMDsgLS1pKQo+ICsJ
CXZob3N0X3ZxX2ZyZWVfaW92ZWNzKGRldi0+dnFzW2ldKTsKPiArCXJldHVybiAtRU5PTUVNOwo+
ICAgfQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwodmhvc3RfZGV2X2luaXQpOwo+ICAgCj4gQEAgLTYw
NiwxMCArNjE1LDYgQEAgbG9uZyB2aG9zdF9kZXZfc2V0X293bmVyKHN0cnVjdCB2aG9zdF9kZXYg
KmRldikKPiAgIAkJCWdvdG8gZXJyX2Nncm91cDsKPiAgIAl9Cj4gICAKPiAtCWVyciA9IHZob3N0
X2Rldl9hbGxvY19pb3ZlY3MoZGV2KTsKPiAtCWlmIChlcnIpCj4gLQkJZ290byBlcnJfY2dyb3Vw
Owo+IC0KPiAgIAlyZXR1cm4gMDsKPiAgIGVycl9jZ3JvdXA6Cj4gICAJaWYgKGRldi0+d29ya2Vy
KSB7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
