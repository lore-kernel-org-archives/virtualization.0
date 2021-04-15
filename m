Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03EEC433ED
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 06:31:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3F661152
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 06:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3F661152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C69440FA8;
	Thu, 15 Apr 2021 06:31:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k1-BG6e4Bsgt; Thu, 15 Apr 2021 06:31:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FFAE40FA3;
	Thu, 15 Apr 2021 06:31:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32CE2C000C;
	Thu, 15 Apr 2021 06:31:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74495C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:31:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 484FA40204
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:31:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Si0FIsfjVK8G
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:30:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 736DD401E4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618468255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5s82uP8bq8dgb0cLJfpozOWx/f1TAjgt4f2klLLOJS4=;
 b=Ee9rcG9xCXn6pl9aYw9+wSO+Osma4G+uvweZYWVV8ndATgTL41c9kkJp8/TIfr3zVaX2o4
 uXr1FA+SKHNJwh1s1QbskbYPNSZw5+WgCPNRvYVQfERavkMC46xCnC2uW9Uv4LE+oHZf2J
 47SyQf34wokYf7tHd55ybhomMpawO/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-LjC3GfYoPIyzhDQTFgw6Tg-1; Thu, 15 Apr 2021 02:30:53 -0400
X-MC-Unique: LjC3GfYoPIyzhDQTFgw6Tg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C8835212;
 Thu, 15 Apr 2021 06:30:52 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-61.pek2.redhat.com
 [10.72.12.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4CCE2B3C5;
 Thu, 15 Apr 2021 06:30:43 +0000 (UTC)
Subject: Re: [PATCH 1/3] vDPA/ifcvf: deduce VIRTIO device ID when probe
To: Zhu Lingshan <lingshan.zhu@linux.intel.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 leonro@nvidia.com
References: <20210414091832.5132-1-lingshan.zhu@intel.com>
 <20210414091832.5132-2-lingshan.zhu@intel.com>
 <85483ff1-cf98-ad05-0c53-74caa2464459@redhat.com>
 <ccf7001b-27f0-27ea-40d2-52ca3cc2386b@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ffd2861d-2395-de51-a227-f1ef33f74322@redhat.com>
Date: Thu, 15 Apr 2021 14:30:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <ccf7001b-27f0-27ea-40d2-52ca3cc2386b@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzQvMTUg5LiL5Y2IMTo1MiwgWmh1IExpbmdzaGFuIOWGmemBkzoKPgo+Cj4gT24g
NC8xNS8yMDIxIDExOjMwIEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiDlnKggMjAyMS80LzE0
IOS4i+WNiDU6MTgsIFpodSBMaW5nc2hhbiDlhpnpgZM6Cj4+PiBUaGlzIGNvbW1pdCBkZWR1Y2Vz
IFZJUlRJTyBkZXZpY2UgSUQgYXMgZGV2aWNlIHR5cGUgd2hlbiBwcm9iZSwKPj4+IHRoZW4gaWZj
dmZfdmRwYV9nZXRfZGV2aWNlX2lkKCkgY2FuIHNpbXBseSByZXR1cm4gdGhlIElELgo+Pj4gaWZj
dmZfdmRwYV9nZXRfZmVhdHVyZXMoKSBhbmQgaWZjdmZfdmRwYV9nZXRfY29uZmlnX3NpemUoKQo+
Pj4gY2FuIHdvcmsgcHJvcGVybHkgYmFzZWQgb24gdGhlIGRldmljZSBJRC4KPj4+Cj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4+PiAtLS0K
Pj4+IMKgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggfMKgIDEgKwo+Pj4gwqAgZHJp
dmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDIyICsrKysrKysrKystLS0tLS0tLS0tLS0K
Pj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0p
Cj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggCj4+
PiBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPj4+IGluZGV4IGIyZWViMTZiOWMy
Yy4uMWMwNGNkMjU2ZmE3IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3Zm
X2Jhc2UuaAo+Pj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+Pj4gQEAg
LTg0LDYgKzg0LDcgQEAgc3RydWN0IGlmY3ZmX2h3IHsKPj4+IMKgwqDCoMKgwqAgdTMyIG5vdGlm
eV9vZmZfbXVsdGlwbGllcjsKPj4+IMKgwqDCoMKgwqAgdTY0IHJlcV9mZWF0dXJlczsKPj4+IMKg
wqDCoMKgwqAgdTY0IGh3X2ZlYXR1cmVzOwo+Pj4gK8KgwqDCoCB1MzIgZGV2X3R5cGU7Cj4+PiDC
oMKgwqDCoMKgIHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgX19pb21lbSAqY29tbW9uX2Nm
ZzsKPj4+IMKgwqDCoMKgwqAgdm9pZCBfX2lvbWVtICpuZXRfY2ZnOwo+Pj4gwqDCoMKgwqDCoCBz
dHJ1Y3QgdnJpbmdfaW5mbyB2cmluZ1tJRkNWRl9NQVhfUVVFVUVfUEFJUlMgKiAyXTsKPj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIAo+Pj4gYi9kcml2ZXJz
L3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+PiBpbmRleCA0NGQ3NTg2MDE5ZGEuLjk5YjBhNmI0
YzIyNyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4+
ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4+IEBAIC0zMjMsMTkgKzMy
Myw5IEBAIHN0YXRpYyB1MzIgaWZjdmZfdmRwYV9nZXRfZ2VuZXJhdGlvbihzdHJ1Y3QgCj4+PiB2
ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4+PiDCoCDCoCBzdGF0aWMgdTMyIGlmY3ZmX3ZkcGFfZ2V0
X2RldmljZV9pZChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+Pj4gwqAgewo+Pj4gLcKg
wqDCoCBzdHJ1Y3QgaWZjdmZfYWRhcHRlciAqYWRhcHRlciA9IHZkcGFfdG9fYWRhcHRlcih2ZHBh
X2Rldik7Cj4+PiAtwqDCoMKgIHN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gYWRhcHRlci0+cGRldjsK
Pj4+IC3CoMKgwqAgdTMyIHJldCA9IC1FTk9ERVY7Cj4+PiAtCj4+PiAtwqDCoMKgIGlmIChwZGV2
LT5kZXZpY2UgPCAweDEwMDAgfHwgcGRldi0+ZGV2aWNlID4gMHgxMDdmKQo+Pj4gLcKgwqDCoMKg
wqDCoMKgIHJldHVybiByZXQ7Cj4+PiAtCj4+PiAtwqDCoMKgIGlmIChwZGV2LT5kZXZpY2UgPCAw
eDEwNDApCj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0ID3CoCBwZGV2LT5zdWJzeXN0ZW1fZGV2aWNl
Owo+Pj4gLcKgwqDCoCBlbHNlCj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0ID3CoCBwZGV2LT5kZXZp
Y2UgLTB4MTA0MDsKPj4+ICvCoMKgwqAgc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IHZkcGFfdG9fdmYo
dmRwYV9kZXYpOwo+Pj4gwqAgLcKgwqDCoCByZXR1cm4gcmV0Owo+Pj4gK8KgwqDCoCByZXR1cm4g
dmYtPmRldl90eXBlOwo+Pj4gwqAgfQo+Pj4gwqAgwqAgc3RhdGljIHUzMiBpZmN2Zl92ZHBhX2dl
dF92ZW5kb3JfaWQoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldikKPj4+IEBAIC00NjYsNiAr
NDU2LDE0IEBAIHN0YXRpYyBpbnQgaWZjdmZfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsIAo+
Pj4gY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmlkKQo+Pj4gwqDCoMKgwqDCoCBwY2lfc2V0
X2RydmRhdGEocGRldiwgYWRhcHRlcik7Cj4+PiDCoCDCoMKgwqDCoMKgIHZmID0gJmFkYXB0ZXIt
PnZmOwo+Pj4gK8KgwqDCoCBpZiAocGRldi0+ZGV2aWNlIDwgMHgxMDAwIHx8IHBkZXYtPmRldmlj
ZSA+IDB4MTA3ZikKPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVPUE5PVFNVUFA7Cj4+PiAr
Cj4+PiArwqDCoMKgIGlmIChwZGV2LT5kZXZpY2UgPCAweDEwNDApCj4+PiArwqDCoMKgwqDCoMKg
wqAgdmYtPmRldl90eXBlID3CoCBwZGV2LT5zdWJzeXN0ZW1fZGV2aWNlOwo+Pj4gK8KgwqDCoCBl
bHNlCj4+PiArwqDCoMKgwqDCoMKgwqAgdmYtPmRldl90eXBlID3CoCBwZGV2LT5kZXZpY2UgLSAw
eDEwNDA7Cj4+Cj4+Cj4+IFNvIGEgcXVlc3Rpb24gaGVyZSwgaXMgdGhlIGRldmljZSBhIHRyYW5z
dGlvbmFsIGRldmljZSBvciBtb2Rlcm4gb25lPwo+Pgo+PiBJZiBpdCdzIGEgdHJhbnNpdG9uYWwg
b25lLCBjYW4gaXQgc3d0aWNoIGVuZGlhbmVzcyBhdXRvbWF0aWNhbGx5IG9yIG5vdD8KPj4KPj4g
VGhhbmtzCj4gSGkgSmFzb24sCj4KPiBUaGlzIGRyaXZlciBzaG91bGQgZHJpdmUgYm90aCBtb2Rl
cm4gYW5kIHRyYW5zaXRpb25hbCBkZXZpY2VzIGFzIHdlIAo+IGRpc2N1c3NlZCBiZWZvcmUuCj4g
SWYgaXQncyBhIHRyYW5zaXRpb25hbCBvbmUsIGl0IHdpbGwgYWN0IGFzIGEgbW9kZXJuIGRldmlj
ZSBieSBkZWZhdWx0LCAKPiBsZWdhY3kgbW9kZSBpcyBhIGZhaWwtb3ZlciBwYXRoLgoKCk5vdGUg
dGhhdCBsZWdhY3kgZHJpdmVyIHVzZSBuYXRpdmUgZW5kaWFuLCBzdXBwb3J0IGxlZ2FjeSBkcml2
ZXIgCnJlcXVpcmVzIHRoZSBkZXZpY2UgdG8ga25vdyBuYXRpdmUgZW5kaWFuIHdoaWNoIEknbSBu
b3Qgc3VyZSB5b3VyIGRldmljZSAKY2FuIGRvIHRoYXQuCgpUaGFua3MKCgo+IEZvciB2RFBBLCBp
dCBoYXMgdG8gc3VwcG9ydCBWSVJUSU9fMSBhbmQgQUNDRVNTX1BMQVRGT1JNLCBzbyBpdCBtdXN0
IAo+IGluIG1vZGVybiBtb2RlLgo+IEkgdGhpbmsgd2UgZG9uJ3QgbmVlZCB0byB3b3JyeSBhYm91
dCBlbmRpYW5lc3MgZm9yIGxlZ2FjeSBtb2RlLgo+Cj4gVGhhbmtzCj4gWmh1IExpbmdzaGFuCj4+
Cj4+Cj4+PiArCj4+PiDCoMKgwqDCoMKgIHZmLT5iYXNlID0gcGNpbV9pb21hcF90YWJsZShwZGV2
KTsKPj4+IMKgIMKgwqDCoMKgwqAgYWRhcHRlci0+cGRldiA9IHBkZXY7Cj4+Cj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
