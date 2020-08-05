Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A30C433E1
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 06:14:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73CA121744
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 06:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGS9a+Bd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CA121744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 02DC887727;
	Wed,  5 Aug 2020 06:14:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yW0Z0HZUNIPg; Wed,  5 Aug 2020 06:14:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 46C8E87715;
	Wed,  5 Aug 2020 06:14:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D2B2C0050;
	Wed,  5 Aug 2020 06:14:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84BF7C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 06:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6E3F48771B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 06:14:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MhvT+6Zy6swI
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 06:14:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5499587715
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 06:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596608056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aaWmcHGY7Cv+glGIbRLTWs4HjQHo9NpEf8CpRt6EP8g=;
 b=BGS9a+BdMejA82D1I3on4hV1LuDfRZKaXXVZechw+EdlSmXHhccrXJLY9f05UODzLYi48O
 VBQ7NihObijhVSprw2LEhhmgxEsCi7+8vYxROg9iEeRnBv0I3UoWcfshIm7mSnndwnrfGe
 xHPtYkrYRUvFq1jm74jbqpCYALd9RjQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-fHKCIQLmNaat0cgWcRBf1Q-1; Wed, 05 Aug 2020 02:14:14 -0400
X-MC-Unique: fHKCIQLmNaat0cgWcRBf1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1942D1902EA0;
 Wed,  5 Aug 2020 06:14:13 +0000 (UTC)
Received: from [10.72.12.225] (ovpn-12-225.pek2.redhat.com [10.72.12.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1799A71D1D;
 Wed,  5 Aug 2020 06:14:08 +0000 (UTC)
Subject: Re: [PATCH v2 19/24] vdpa: make sure set_features in invoked for
 legacy
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-20-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9e47d227-f220-4651-dcb9-7a11f059a715@redhat.com>
Date: Wed, 5 Aug 2020 14:14:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-20-mst@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvOC80IOS4iuWNiDU6MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBTb21l
IGxlZ2FjeSBndWVzdHMganVzdCBhc3N1bWUgZmVhdHVyZXMgYXJlIDAgYWZ0ZXIgcmVzZXQuCj4g
V2UgZGV0ZWN0IHRoYXQgY29uZmlnIHNwYWNlIGlzIGFjY2Vzc2VkIGJlZm9yZSBmZWF0dXJlcyBh
cmUKPiBzZXQgYW5kIHNldCBmZWF0dXJlcyB0byAwIGF1dG9tYXRpY2FsbHkuCj4gTm90ZTogc29t
ZSBsZWdhY3kgZ3Vlc3RzIG1pZ2h0IG5vdCBldmVuIGFjY2VzcyBjb25maWcgc3BhY2UsIGlmIHRo
aXMgaXMKPiByZXBvcnRlZCBpbiB0aGUgZmllbGQgd2UgbWlnaHQgbmVlZCB0byBjYXRjaCBhIGtp
Y2sgdG8gaGFuZGxlIHRoZXNlLgoKCkkgd29uZGVyIHdoZXRoZXIgaXQncyBlYXNpZXIgdG8ganVz
dCBzdXBwb3J0IG1vZGVybiBkZXZpY2U/CgpUaGFua3MKCgo+Cj4gU2lnbmVkLW9mZi1ieTogTWlj
aGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS92
ZHBhLmMgIHwgIDEgKwo+ICAgaW5jbHVkZS9saW51eC92ZHBhLmggfCAzNCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCj4gICAyIGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMo
KykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYS5jIGIvZHJpdmVycy92ZHBhL3Zk
cGEuYwo+IGluZGV4IGRlMjExZWYzNzM4Yy4uNzEwNTI2NWU0NzkzIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvdmRwYS92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4gQEAgLTk2LDYg
Kzk2LDcgQEAgc3RydWN0IHZkcGFfZGV2aWNlICpfX3ZkcGFfYWxsb2NfZGV2aWNlKHN0cnVjdCBk
ZXZpY2UgKnBhcmVudCwKPiAgIAl2ZGV2LT5kZXYucmVsZWFzZSA9IHZkcGFfcmVsZWFzZV9kZXY7
Cj4gICAJdmRldi0+aW5kZXggPSBlcnI7Cj4gICAJdmRldi0+Y29uZmlnID0gY29uZmlnOwo+ICsJ
dmRldi0+ZmVhdHVyZXNfdmFsaWQgPSBmYWxzZTsKPiAgIAo+ICAgCWVyciA9IGRldl9zZXRfbmFt
ZSgmdmRldi0+ZGV2LCAidmRwYSV1IiwgdmRldi0+aW5kZXgpOwo+ICAgCWlmIChlcnIpCj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiBp
bmRleCAyMzlkYjc5NDM1N2MuLjI5YjgyOTZmMTQxNCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xp
bnV4L3ZkcGEuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gQEAgLTMzLDEyICszMywx
NCBAQCBzdHJ1Y3QgdmRwYV9ub3RpZmljYXRpb25fYXJlYSB7Cj4gICAgKiBAZG1hX2RldjogdGhl
IGFjdHVhbCBkZXZpY2UgdGhhdCBpcyBwZXJmb3JtaW5nIERNQQo+ICAgICogQGNvbmZpZzogdGhl
IGNvbmZpZ3VyYXRpb24gb3BzIGZvciB0aGlzIGRldmljZS4KPiAgICAqIEBpbmRleDogZGV2aWNl
IGluZGV4Cj4gKyAqIEBmZWF0dXJlc192YWxpZDogd2VyZSBmZWF0dXJlcyBpbml0aWFsaXplZD8g
Zm9yIGxlZ2FjeSBndWVzdHMKPiAgICAqLwo+ICAgc3RydWN0IHZkcGFfZGV2aWNlIHsKPiAgIAlz
dHJ1Y3QgZGV2aWNlIGRldjsKPiAgIAlzdHJ1Y3QgZGV2aWNlICpkbWFfZGV2Owo+ICAgCWNvbnN0
IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKmNvbmZpZzsKPiAgIAl1bnNpZ25lZCBpbnQgaW5kZXg7
Cj4gKwlib29sIGZlYXR1cmVzX3ZhbGlkOwo+ICAgfTsKPiAgIAo+ICAgLyoqCj4gQEAgLTI2Niw0
ICsyNjgsMzYgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgZGV2aWNlICp2ZHBhX2dldF9kbWFfZGV2
KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPiAgIHsKPiAgIAlyZXR1cm4gdmRldi0+ZG1hX2Rl
djsKPiAgIH0KPiArCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCB2ZHBhX3Jlc2V0KHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRldikKPiArewo+ICsgICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19v
cHMgKm9wcyA9IHZkZXYtPmNvbmZpZzsKPiArCj4gKwl2ZGV2LT5mZWF0dXJlc192YWxpZCA9IGZh
bHNlOwo+ICsgICAgICAgIG9wcy0+c2V0X3N0YXR1cyh2ZGV2LCAwKTsKPiArfQo+ICsKPiArc3Rh
dGljIGlubGluZSBpbnQgdmRwYV9zZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2
LCB1NjQgZmVhdHVyZXMpCj4gK3sKPiArICAgICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdf
b3BzICpvcHMgPSB2ZGV2LT5jb25maWc7Cj4gKwo+ICsJdmRldi0+ZmVhdHVyZXNfdmFsaWQgPSB0
cnVlOwo+ICsgICAgICAgIHJldHVybiBvcHMtPnNldF9mZWF0dXJlcyh2ZGV2LCBmZWF0dXJlcyk7
Cj4gK30KPiArCj4gKwo+ICtzdGF0aWMgaW5saW5lIHZvaWQgdmRwYV9nZXRfY29uZmlnKHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQgb2Zmc2V0LAo+ICsJCQkJICAgdm9pZCAqYnVm
LCB1bnNpZ25lZCBpbnQgbGVuKQo+ICt7Cj4gKyAgICAgICAgY29uc3Qgc3RydWN0IHZkcGFfY29u
ZmlnX29wcyAqb3BzID0gdmRldi0+Y29uZmlnOwo+ICsKPiArCS8qCj4gKwkgKiBDb25maWcgYWNj
ZXNzZXMgYXJlbid0IHN1cHBvc2VkIHRvIHRyaWdnZXIgYmVmb3JlIGZlYXR1cmVzIGFyZSBzZXQu
Cj4gKwkgKiBJZiBpdCBkb2VzIGhhcHBlbiB3ZSBhc3N1bWUgYSBsZWdhY3kgZ3Vlc3QuCj4gKwkg
Ki8KPiArCWlmICghdmRldi0+ZmVhdHVyZXNfdmFsaWQpCj4gKwkJdmRwYV9zZXRfZmVhdHVyZXMo
dmRldiwgMCk7Cj4gKwlvcHMtPmdldF9jb25maWcodmRldiwgb2Zmc2V0LCBidWYsIGxlbik7Cj4g
K30KPiArCj4gICAjZW5kaWYgLyogX0xJTlVYX1ZEUEFfSCAqLwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
