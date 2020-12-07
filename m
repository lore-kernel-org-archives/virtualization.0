Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A52C4361B
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 05:29:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87F8F227C3
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 05:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F8F227C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0E8938780B;
	Mon,  7 Dec 2020 05:29:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UUr7obGwaUni; Mon,  7 Dec 2020 05:29:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4972F87809;
	Mon,  7 Dec 2020 05:29:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EE2AC0FA7;
	Mon,  7 Dec 2020 05:29:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6C74C013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:29:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CBADE8621D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:29:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l59Cdj3XtFRe
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:29:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1F4608619E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607318971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p9SyX3Wbogf9IuwRBc6i2Dzncrlgn1ZL50RBQLD9/wk=;
 b=Ymu1xTBQRbyOvIWYyTyN5PTUvY77CZnTY1wTJXJtqpyYu1wMc97VdYtMwQ4Ylx+IhaAOsT
 ZGBrxTp7v/GwB+7n1GZrYzrspvHTX4SXcC7haGz2tBCY6Vg0YCOmruOHa9W5CpB6WZ8IoG
 vsOTMMs9KQfOucb57+fNzjANkY0qnjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-ffOF8WXdNR2oi5-NL-dTHA-1; Mon, 07 Dec 2020 00:29:29 -0500
X-MC-Unique: ffOF8WXdNR2oi5-NL-dTHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6703C801B12;
 Mon,  7 Dec 2020 05:29:28 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BACC6614EB;
 Mon,  7 Dec 2020 05:29:18 +0000 (UTC)
Subject: Re: [PATCH v3 13/19] vdpa_sim: add get_config callback in
 vdpasim_dev_attr
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-14-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <829a5026-a68c-6d02-49ef-f237dcae2460@redhat.com>
Date: Mon, 7 Dec 2020 13:29:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203170511.216407-14-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Shahaf Shuler <shahafs@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <elic@nvidia.com>, Oren Duer <oren@nvidia.com>
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

Ck9uIDIwMjAvMTIvNCDkuIrljYgxOjA1LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gVGhl
IGdldF9jb25maWcgY2FsbGJhY2sgY2FuIGJlIHVzZWQgYnkgdGhlIGRldmljZSB0byBmaWxsIHRo
ZQo+IGNvbmZpZyBzdHJ1Y3R1cmUuCj4gVGhlIGNhbGxiYWNrIHdpbGwgYmUgaW52b2tlZCBpbiB2
ZHBhc2ltX2dldF9jb25maWcoKSBiZWZvcmUgY29weWluZwo+IGJ5dGVzIGludG8gY2FsbGVyIGJ1
ZmZlci4KPgo+IE1vdmUgdkRQQS1uZXQgY29uZmlnIHVwZGF0ZXMgZnJvbSB2ZHBhc2ltX3NldF9m
ZWF0dXJlcygpIGluIHRoZQo+IG5ldyB2ZHBhc2ltX25ldF9nZXRfY29uZmlnKCkgY2FsbGJhY2su
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5j
b20+Cj4gLS0tCj4gdjM6Cj4gLSBjaGVja2VkIGlmIGdldF9jb25maWcgY2FsbGJhY2sgaXMgc2V0
IGJlZm9yZSBjYWxsIGl0Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0u
YyB8IDM1ICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRw
YV9zaW0uYwo+IGluZGV4IGZlNzFlZDc4OTBlMS4uZjkzNWFkZTA4MDZiIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3Zk
cGFfc2ltL3ZkcGFfc2ltLmMKPiBAQCAtNjAsNiArNjAsOCBAQCBzdHJ1Y3QgdmRwYXNpbV92aXJ0
cXVldWUgewo+ICAgI2RlZmluZSBWRFBBU0lNX05FVF9GRUFUVVJFUwkoVkRQQVNJTV9GRUFUVVJF
UyB8IFwKPiAgIAkJCQkgKDFVTEwgPDwgVklSVElPX05FVF9GX01BQykpCj4gICAKPiArc3RydWN0
IHZkcGFzaW07Cj4gKwo+ICAgc3RydWN0IHZkcGFzaW1fZGV2X2F0dHIgewo+ICAgCXU2NCBzdXBw
b3J0ZWRfZmVhdHVyZXM7Cj4gICAJc2l6ZV90IGNvbmZpZ19zaXplOwo+IEBAIC02Nyw2ICs2OSw3
IEBAIHN0cnVjdCB2ZHBhc2ltX2Rldl9hdHRyIHsKPiAgIAl1MzIgaWQ7Cj4gICAKPiAgIAl3b3Jr
X2Z1bmNfdCB3b3JrX2ZuOwo+ICsJdm9pZCAoKmdldF9jb25maWcpKHN0cnVjdCB2ZHBhc2ltICp2
ZHBhc2ltLCB2b2lkICpjb25maWcpOwo+ICAgfTsKPiAgIAo+ICAgLyogU3RhdGUgb2YgZWFjaCB2
ZHBhc2ltIGRldmljZSAqLwo+IEBAIC01MjIsOCArNTI1LDYgQEAgc3RhdGljIHU2NCB2ZHBhc2lt
X2dldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEpCj4gICBzdGF0aWMgaW50IHZk
cGFzaW1fc2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwgdTY0IGZlYXR1cmVz
KQo+ICAgewo+ICAgCXN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltID0gdmRwYV90b19zaW0odmRwYSk7
Cj4gLQlzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcgKmNvbmZpZyA9Cj4gLQkJKHN0cnVjdCB2aXJ0
aW9fbmV0X2NvbmZpZyAqKXZkcGFzaW0tPmNvbmZpZzsKPiAgIAo+ICAgCS8qIERNQSBtYXBwaW5n
IG11c3QgYmUgZG9uZSBieSBkcml2ZXIgKi8KPiAgIAlpZiAoIShmZWF0dXJlcyAmICgxVUxMIDw8
IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkpKQo+IEBAIC01MzEsMTYgKzUzMiw2IEBAIHN0YXRp
YyBpbnQgdmRwYXNpbV9zZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1NjQg
ZmVhdHVyZXMpCj4gICAKPiAgIAl2ZHBhc2ltLT5mZWF0dXJlcyA9IGZlYXR1cmVzICYgdmRwYXNp
bS0+ZGV2X2F0dHIuc3VwcG9ydGVkX2ZlYXR1cmVzOwo+ICAgCj4gLQkvKiBXZSBnZW5lcmFsbHkg
b25seSBrbm93IHdoZXRoZXIgZ3Vlc3QgaXMgdXNpbmcgdGhlIGxlZ2FjeSBpbnRlcmZhY2UKPiAt
CSAqIGhlcmUsIHNvIGdlbmVyYWxseSB0aGF0J3MgdGhlIGVhcmxpZXN0IHdlIGNhbiBzZXQgY29u
ZmlnIGZpZWxkcy4KPiAtCSAqIE5vdGU6IFdlIGFjdHVhbGx5IHJlcXVpcmUgVklSVElPX0ZfQUND
RVNTX1BMQVRGT1JNIGFib3ZlIHdoaWNoCj4gLQkgKiBpbXBsaWVzIFZJUlRJT19GX1ZFUlNJT05f
MSwgYnV0IGxldCdzIG5vdCB0cnkgdG8gYmUgY2xldmVyIGhlcmUuCj4gLQkgKi8KPiAtCj4gLQlj
b25maWctPm10dSA9IGNwdV90b192ZHBhc2ltMTYodmRwYXNpbSwgMTUwMCk7Cj4gLQljb25maWct
PnN0YXR1cyA9IGNwdV90b192ZHBhc2ltMTYodmRwYXNpbSwgVklSVElPX05FVF9TX0xJTktfVVAp
Owo+IC0JbWVtY3B5KGNvbmZpZy0+bWFjLCBtYWNhZGRyX2J1ZiwgRVRIX0FMRU4pOwoKClBhdGNo
IGxvb2tzIGdvb2QgdG8gbWUuCgpCdXQgd2UgbmVlZCBNaWNoYWVsIHRvIGNvbmZpcm0gd2hldGhl
ciBkb2luZyBtb3ZpbmcgbGlrZSB0aGlzIGlzIHNhZmUuIEkgCmd1ZXNzIHdoYXQgaGFzIGJlZW4g
ZG9uZSB3ZXJlIHRyeWluZyB0byBtYWtlIHN1cmUgZ2V0X2NvbmZpZygpIGZhaWwgCmJlZm9yZSBz
ZXRfZmVhdHVyZXMoKSwgYnV0IGl0J3Mgbm90IGNsZWFyIHRvIG1lIHdoZXRoZXIgaXQncyB1c2Vm
dWwuCgpUaGFua3MKCgo+IC0KPiAgIAlyZXR1cm4gMDsKPiAgIH0KPiAgIAo+IEBAIC01OTUsOCAr
NTg2LDEzIEBAIHN0YXRpYyB2b2lkIHZkcGFzaW1fZ2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkcGEsIHVuc2lnbmVkIGludCBvZmZzZXQsCj4gICB7Cj4gICAJc3RydWN0IHZkcGFzaW0g
KnZkcGFzaW0gPSB2ZHBhX3RvX3NpbSh2ZHBhKTsKPiAgIAo+IC0JaWYgKG9mZnNldCArIGxlbiA8
IHZkcGFzaW0tPmRldl9hdHRyLmNvbmZpZ19zaXplKQo+IC0JCW1lbWNweShidWYsIHZkcGFzaW0t
PmNvbmZpZyArIG9mZnNldCwgbGVuKTsKPiArCWlmIChvZmZzZXQgKyBsZW4gPiB2ZHBhc2ltLT5k
ZXZfYXR0ci5jb25maWdfc2l6ZSkKPiArCQlyZXR1cm47Cj4gKwo+ICsJaWYgKHZkcGFzaW0tPmRl
dl9hdHRyLmdldF9jb25maWcpCj4gKwkJdmRwYXNpbS0+ZGV2X2F0dHIuZ2V0X2NvbmZpZyh2ZHBh
c2ltLCB2ZHBhc2ltLT5jb25maWcpOwo+ICsKPiArCW1lbWNweShidWYsIHZkcGFzaW0tPmNvbmZp
ZyArIG9mZnNldCwgbGVuKTsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIHZvaWQgdmRwYXNpbV9zZXRf
Y29uZmlnKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwgdW5zaWduZWQgaW50IG9mZnNldCwKPiBA
QCAtNzM5LDYgKzczNSwxNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyB2
ZHBhc2ltX2JhdGNoX2NvbmZpZ19vcHMgPSB7Cj4gICAJLmZyZWUgICAgICAgICAgICAgICAgICAg
PSB2ZHBhc2ltX2ZyZWUsCj4gICB9Owo+ICAgCj4gK3N0YXRpYyB2b2lkIHZkcGFzaW1fbmV0X2dl
dF9jb25maWcoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0sIHZvaWQgKmNvbmZpZykKPiArewo+ICsJ
c3RydWN0IHZpcnRpb19uZXRfY29uZmlnICpuZXRfY29uZmlnID0KPiArCQkoc3RydWN0IHZpcnRp
b19uZXRfY29uZmlnICopY29uZmlnOwo+ICsKPiArCW5ldF9jb25maWctPm10dSA9IGNwdV90b192
ZHBhc2ltMTYodmRwYXNpbSwgMTUwMCk7Cj4gKwluZXRfY29uZmlnLT5zdGF0dXMgPSBjcHVfdG9f
dmRwYXNpbTE2KHZkcGFzaW0sIFZJUlRJT19ORVRfU19MSU5LX1VQKTsKPiArCW1lbWNweShuZXRf
Y29uZmlnLT5tYWMsIG1hY2FkZHJfYnVmLCBFVEhfQUxFTik7Cj4gK30KPiArCj4gICBzdGF0aWMg
aW50IF9faW5pdCB2ZHBhc2ltX2Rldl9pbml0KHZvaWQpCj4gICB7Cj4gICAJc3RydWN0IHZkcGFz
aW1fZGV2X2F0dHIgZGV2X2F0dHIgPSB7fTsKPiBAQCAtNzQ3LDYgKzc1Myw3IEBAIHN0YXRpYyBp
bnQgX19pbml0IHZkcGFzaW1fZGV2X2luaXQodm9pZCkKPiAgIAlkZXZfYXR0ci5zdXBwb3J0ZWRf
ZmVhdHVyZXMgPSBWRFBBU0lNX05FVF9GRUFUVVJFUzsKPiAgIAlkZXZfYXR0ci5udnFzID0gVkRQ
QVNJTV9WUV9OVU07Cj4gICAJZGV2X2F0dHIuY29uZmlnX3NpemUgPSBzaXplb2Yoc3RydWN0IHZp
cnRpb19uZXRfY29uZmlnKTsKPiArCWRldl9hdHRyLmdldF9jb25maWcgPSB2ZHBhc2ltX25ldF9n
ZXRfY29uZmlnOwo+ICAgCWRldl9hdHRyLndvcmtfZm4gPSB2ZHBhc2ltX25ldF93b3JrOwo+ICAg
Cj4gICAJdmRwYXNpbV9kZXYgPSB2ZHBhc2ltX2NyZWF0ZSgmZGV2X2F0dHIpOwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
