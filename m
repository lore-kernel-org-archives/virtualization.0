Return-Path: <SRS0=RIAz=EB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F01C388F7
	for <virtualization@archiver.kernel.org>; Mon, 26 Oct 2020 03:35:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA87208B3
	for <virtualization@archiver.kernel.org>; Mon, 26 Oct 2020 03:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOMMueea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA87208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C1CC62D002;
	Mon, 26 Oct 2020 03:35:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sQRdZqsRGf8H; Mon, 26 Oct 2020 03:35:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 31CF9276D4;
	Mon, 26 Oct 2020 03:35:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA4B1C088B;
	Mon, 26 Oct 2020 03:35:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B761C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 03:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 772752A128
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 03:35:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U6SoSnUCyVMJ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 03:35:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 6F8CC276D4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 03:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603683309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xpZqq9xg61UBmOXJ8EQECYPW+0Do3I4VYlD4OUNg0Jg=;
 b=eOMMueeaqdaqHx2lXkUkHVgQRglsmVES74lHdvLDIm5DyjHMX973iclCxlfTEeUrogIhhH
 pX8edtmriktcQfOlAVGmSDlWUO9XCkR3n59sr1yh0YrXCzL/C4aPMZSkeAN+QPVVE5Xcw3
 ICFTRPcQRC72mLDsoy3OiQjQt7XaSoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-mMSEYOAYN5uyaIzsDswmRg-1; Sun, 25 Oct 2020 23:35:07 -0400
X-MC-Unique: mMSEYOAYN5uyaIzsDswmRg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B04A8803F4C;
 Mon, 26 Oct 2020 03:35:05 +0000 (UTC)
Received: from [10.72.13.201] (ovpn-13-201.pek2.redhat.com [10.72.13.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E08E50B44;
 Mon, 26 Oct 2020 03:34:52 +0000 (UTC)
Subject: Re: [PATCH 03/17] vhost net: use goto error handling in open
To: Mike Christie <michael.christie@oracle.com>, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, mst@redhat.com,
 pbonzini@redhat.com, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org
References: <1603326903-27052-1-git-send-email-michael.christie@oracle.com>
 <1603326903-27052-4-git-send-email-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8a3779da-74e6-7eff-28c4-5bfd2c981728@redhat.com>
Date: Mon, 26 Oct 2020 11:34:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1603326903-27052-4-git-send-email-michael.christie@oracle.com>
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

Ck9uIDIwMjAvMTAvMjIg5LiK5Y2IODozNCwgTWlrZSBDaHJpc3RpZSB3cm90ZToKPiBJbiB0aGUg
bmV4dCBwYXRjaGVzIHZob3N0X2Rldl9pbml0IHdpbGwgYmUgYWJsZSB0byBmYWlsLiBUaGlzIHBh
dGNoIGhhcwo+IHZob3N0X25ldF9vcGVuIHVzZSBnb3RvIGVycm9yIGhhbmRsaW5nIGxpa2UgaXMg
ZG9uZSBpbiB0aGUgb3RoZXIgdmhvc3QKPiBjb2RlIHRvIG1ha2UgaGFuZGxpbmcgdmhvc3RfZGV2
X2luaXQgZmFpbHVyZXMgZWFzaWVyIHRvIGhhbmRsZSBhbmQKPiBleHRlbmQgaW4gdGhlIGZ1dHVy
ZS4KPgo+IFNpZ25lZC1vZmYtYnk6IE1pa2UgQ2hyaXN0aWUgPG1pY2hhZWwuY2hyaXN0aWVAb3Jh
Y2xlLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+
IC0tLQo+ICAgZHJpdmVycy92aG9zdC9uZXQuYyB8IDI5ICsrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25z
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC9uZXQuYyBiL2RyaXZlcnMvdmhvc3Qv
bmV0LmMKPiBpbmRleCA1MzFhMDBkLi44MzFkODI0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhv
c3QvbmV0LmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L25ldC5jCj4gQEAgLTEyODYsMjcgKzEyODYs
MTggQEAgc3RhdGljIGludCB2aG9zdF9uZXRfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1
Y3QgZmlsZSAqZikKPiAgIAlpZiAoIW4pCj4gICAJCXJldHVybiAtRU5PTUVNOwo+ICAgCXZxcyA9
IGttYWxsb2NfYXJyYXkoVkhPU1RfTkVUX1ZRX01BWCwgc2l6ZW9mKCp2cXMpLCBHRlBfS0VSTkVM
KTsKPiAtCWlmICghdnFzKSB7Cj4gLQkJa3ZmcmVlKG4pOwo+IC0JCXJldHVybiAtRU5PTUVNOwo+
IC0JfQo+ICsJaWYgKCF2cXMpCj4gKwkJZ290byBlcnJfdnFzOwo+ICAgCj4gICAJcXVldWUgPSBr
bWFsbG9jX2FycmF5KFZIT1NUX05FVF9CQVRDSCwgc2l6ZW9mKHZvaWQgKiksCj4gICAJCQkgICAg
ICBHRlBfS0VSTkVMKTsKPiAtCWlmICghcXVldWUpIHsKPiAtCQlrZnJlZSh2cXMpOwo+IC0JCWt2
ZnJlZShuKTsKPiAtCQlyZXR1cm4gLUVOT01FTTsKPiAtCX0KPiArCWlmICghcXVldWUpCj4gKwkJ
Z290byBlcnJfcXVldWU7Cj4gICAJbi0+dnFzW1ZIT1NUX05FVF9WUV9SWF0ucnhxLnF1ZXVlID0g
cXVldWU7Cj4gICAKPiAgIAl4ZHAgPSBrbWFsbG9jX2FycmF5KFZIT1NUX05FVF9CQVRDSCwgc2l6
ZW9mKCp4ZHApLCBHRlBfS0VSTkVMKTsKPiAtCWlmICgheGRwKSB7Cj4gLQkJa2ZyZWUodnFzKTsK
PiAtCQlrdmZyZWUobik7Cj4gLQkJa2ZyZWUocXVldWUpOwo+IC0JCXJldHVybiAtRU5PTUVNOwo+
IC0JfQo+ICsJaWYgKCF4ZHApCj4gKwkJZ290byBlcnJfeGRwOwo+ICAgCW4tPnZxc1tWSE9TVF9O
RVRfVlFfVFhdLnhkcCA9IHhkcDsKPiAgIAo+ICAgCWRldiA9ICZuLT5kZXY7Cj4gQEAgLTEzMzgs
NiArMTMyOSwxNCBAQCBzdGF0aWMgaW50IHZob3N0X25ldF9vcGVuKHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIHN0cnVjdCBmaWxlICpmKQo+ICAgCW4tPnJlZmNudF9iaWFzID0gMDsKPiAgIAo+ICAgCXJl
dHVybiAwOwo+ICsKPiArZXJyX3hkcDoKPiArCWtmcmVlKHF1ZXVlKTsKPiArZXJyX3F1ZXVlOgo+
ICsJa2ZyZWUodnFzKTsKPiArZXJyX3ZxczoKPiArCWt2ZnJlZShuKTsKPiArCXJldHVybiAtRU5P
TUVNOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgc3RydWN0IHNvY2tldCAqdmhvc3RfbmV0X3N0b3Bf
dnEoc3RydWN0IHZob3N0X25ldCAqbiwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
