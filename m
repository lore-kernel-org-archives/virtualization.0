Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E336BC61DD8
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 04:21:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E187206D8
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 04:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEp32Bem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E187206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0540B868B0;
	Mon, 16 Nov 2020 04:21:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ngLQp1vBfb88; Mon, 16 Nov 2020 04:21:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5686A868A9;
	Mon, 16 Nov 2020 04:21:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F392C0891;
	Mon, 16 Nov 2020 04:21:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCF8FC07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 939AC2041E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:21:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qOTgPqIkKgzP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:21:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 750E5203C7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605500506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jrOtbnB72prq10/Mp21JWfqhwYU9mLgYj1aTjQoBku4=;
 b=XEp32Bemu7d+UpUqHXJYcQQLZM9CRJyoqLWHXyjZ/cQNNC/kwI5CgoP7GGBwnDL9wtD3uB
 0Aaee+rALzj5r398o2tKIHswykons81N54FaD71xrbwi9GFzRfkJKHJvyQf0WpE0iUgWev
 PFUnG19Gv/fqUtbYpP5rnbH8lneh3fM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-2tUIL-GPMayRVNkL3_HVdw-1; Sun, 15 Nov 2020 23:21:44 -0500
X-MC-Unique: 2tUIL-GPMayRVNkL3_HVdw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8840B427FE;
 Mon, 16 Nov 2020 04:21:43 +0000 (UTC)
Received: from [10.72.13.126] (ovpn-13-126.pek2.redhat.com [10.72.13.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3E3C60C43;
 Mon, 16 Nov 2020 04:21:34 +0000 (UTC)
Subject: Re: [PATCH RFC 10/12] vdpa_sim: split vdpasim_virtqueue's iov field
 in riov and wiov
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-11-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f19a5d14-72b4-4185-183d-84966ee2e5b3@redhat.com>
Date: Mon, 16 Nov 2020 12:21:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-11-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

Ck9uIDIwMjAvMTEvMTMg5LiL5Y2IOTo0NywgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IHZy
aW5naF9nZXRkZXNjX2lvdGxiKCkgbWFuYWdlcyAyIGlvdnMgZm9yIHdyaXRhYmxlIGFuZCByZWFk
YWJsZQo+IGRlc2NyaXB0b3JzLiBUaGlzIGlzIHZlcnkgdXNlZnVsIGZvciB0aGUgYmxvY2sgZGV2
aWNlLCB3aGVyZSBmb3IKPiBlYWNoIHJlcXVlc3Qgd2UgaGF2ZSBib3RoIHR5cGVzIG9mIGRlc2Ny
aXB0b3IuCj4KPiBMZXQncyBzcGxpdCB0aGUgdmRwYXNpbV92aXJ0cXVldWUncyBpb3YgZmllbGQg
aW4gcmlvdiBhbmQgd2lvdgo+IHRvIHVzZSB0aGVtIHdpdGggdnJpbmdoX2dldGRlc2NfaW90bGIo
KS4KPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0
LmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0t
LQo+ICAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmggICAgIHwgMyArKy0KPiAgIGRy
aXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYyB8IDYgKysrLS0tCj4gICBkcml2ZXJz
L3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMgfCA4ICsrKystLS0tCj4gICAzIGZpbGVzIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uaCBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92
ZHBhX3NpbS5oCj4gaW5kZXggY2MyMWUwN2FhMmY3Li4wZDQ2Mjk2NzVlNGIgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmgKPiArKysgYi9kcml2ZXJzL3ZkcGEv
dmRwYV9zaW0vdmRwYV9zaW0uaAo+IEBAIC0yNyw3ICsyNyw4IEBAIHN0cnVjdCB2ZHBhc2ltOwo+
ICAgCj4gICBzdHJ1Y3QgdmRwYXNpbV92aXJ0cXVldWUgewo+ICAgCXN0cnVjdCB2cmluZ2ggdnJp
bmc7Cj4gLQlzdHJ1Y3QgdnJpbmdoX2tpb3YgaW92Owo+ICsJc3RydWN0IHZyaW5naF9raW92IHJp
b3Y7Cj4gKwlzdHJ1Y3QgdnJpbmdoX2tpb3Ygd2lvdjsKPiAgIAl1bnNpZ25lZCBzaG9ydCBoZWFk
Owo+ICAgCWJvb2wgcmVhZHk7Cj4gICAJdTY0IGRlc2NfYWRkcjsKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2lt
L3ZkcGFfc2ltX2Jsay5jCj4gaW5kZXggMTIyYTNjMDM5NTA3Li44ZTQxYjNhYjk4ZDUgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jCj4gKysrIGIvZHJp
dmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jCj4gQEAgLTQxLDEzICs0MSwxMyBAQCBz
dGF0aWMgdm9pZCB2ZHBhc2ltX2Jsa193b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiAg
IAkJaWYgKCF2cS0+cmVhZHkpCj4gICAJCQljb250aW51ZTsKPiAgIAo+IC0JCXdoaWxlICh2cmlu
Z2hfZ2V0ZGVzY19pb3RsYigmdnEtPnZyaW5nLCAmdnEtPmlvdiwgJnZxLT5pb3YsCj4gKwkJd2hp
bGUgKHZyaW5naF9nZXRkZXNjX2lvdGxiKCZ2cS0+dnJpbmcsICZ2cS0+cmlvdiwgJnZxLT53aW92
LAo+ICAgCQkJCQkgICAgJnZxLT5oZWFkLCBHRlBfQVRPTUlDKSA+IDApIHsKPiAgIAo+ICAgCQkJ
aW50IHdyaXRlOwo+ICAgCj4gLQkJCXZxLT5pb3YuaSA9IHZxLT5pb3YudXNlZCAtIDE7Cj4gLQkJ
CXdyaXRlID0gdnJpbmdoX2lvdl9wdXNoX2lvdGxiKCZ2cS0+dnJpbmcsICZ2cS0+aW92LCAmc3Rh
dHVzLCAxKTsKPiArCQkJdnEtPndpb3YuaSA9IHZxLT53aW92LnVzZWQgLSAxOwo+ICsJCQl3cml0
ZSA9IHZyaW5naF9pb3ZfcHVzaF9pb3RsYigmdnEtPnZyaW5nLCAmdnEtPndpb3YsICZzdGF0dXMs
IDEpOwo+ICAgCQkJaWYgKHdyaXRlIDw9IDApCj4gICAJCQkJYnJlYWs7Cj4gICAKPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jIGIvZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jCj4gaW5kZXggZDBhMTQwM2Y2NGIyLi43ODNiMWU4NWIw
OWMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jCj4g
KysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jCj4gQEAgLTQ3LDEyICs0
NywxMiBAQCBzdGF0aWMgdm9pZCB2ZHBhc2ltX25ldF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAq
d29yaykKPiAgIAo+ICAgCXdoaWxlICh0cnVlKSB7Cj4gICAJCXRvdGFsX3dyaXRlID0gMDsKPiAt
CQllcnIgPSB2cmluZ2hfZ2V0ZGVzY19pb3RsYigmdHhxLT52cmluZywgJnR4cS0+aW92LCBOVUxM
LAo+ICsJCWVyciA9IHZyaW5naF9nZXRkZXNjX2lvdGxiKCZ0eHEtPnZyaW5nLCAmdHhxLT5yaW92
LCBOVUxMLAo+ICAgCQkJCQkgICAmdHhxLT5oZWFkLCBHRlBfQVRPTUlDKTsKPiAgIAkJaWYgKGVy
ciA8PSAwKQo+ICAgCQkJYnJlYWs7Cj4gICAKPiAtCQllcnIgPSB2cmluZ2hfZ2V0ZGVzY19pb3Rs
YigmcnhxLT52cmluZywgTlVMTCwgJnJ4cS0+aW92LAo+ICsJCWVyciA9IHZyaW5naF9nZXRkZXNj
X2lvdGxiKCZyeHEtPnZyaW5nLCBOVUxMLCAmcnhxLT53aW92LAo+ICAgCQkJCQkgICAmcnhxLT5o
ZWFkLCBHRlBfQVRPTUlDKTsKPiAgIAkJaWYgKGVyciA8PSAwKSB7Cj4gICAJCQl2cmluZ2hfY29t
cGxldGVfaW90bGIoJnR4cS0+dnJpbmcsIHR4cS0+aGVhZCwgMCk7Cj4gQEAgLTYwLDEzICs2MCwx
MyBAQCBzdGF0aWMgdm9pZCB2ZHBhc2ltX25ldF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29y
aykKPiAgIAkJfQo+ICAgCj4gICAJCXdoaWxlICh0cnVlKSB7Cj4gLQkJCXJlYWQgPSB2cmluZ2hf
aW92X3B1bGxfaW90bGIoJnR4cS0+dnJpbmcsICZ0eHEtPmlvdiwKPiArCQkJcmVhZCA9IHZyaW5n
aF9pb3ZfcHVsbF9pb3RsYigmdHhxLT52cmluZywgJnR4cS0+cmlvdiwKPiAgIAkJCQkJCSAgICAg
dmRwYXNpbS0+YnVmZmVyLAo+ICAgCQkJCQkJICAgICBQQUdFX1NJWkUpOwo+ICAgCQkJaWYgKHJl
YWQgPD0gMCkKPiAgIAkJCQlicmVhazsKPiAgIAo+IC0JCQl3cml0ZSA9IHZyaW5naF9pb3ZfcHVz
aF9pb3RsYigmcnhxLT52cmluZywgJnJ4cS0+aW92LAo+ICsJCQl3cml0ZSA9IHZyaW5naF9pb3Zf
cHVzaF9pb3RsYigmcnhxLT52cmluZywgJnJ4cS0+d2lvdiwKPiAgIAkJCQkJCSAgICAgIHZkcGFz
aW0tPmJ1ZmZlciwgcmVhZCk7Cj4gICAJCQlpZiAod3JpdGUgPD0gMCkKPiAgIAkJCQlicmVhazsK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
