Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489C9C63777
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:25:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C668F20857
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbTyj6CQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C668F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6B2B586D2C;
	Mon, 30 Nov 2020 03:25:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 63gSwOlAn3sN; Mon, 30 Nov 2020 03:25:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BB15586D7D;
	Mon, 30 Nov 2020 03:25:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A291CC163C;
	Mon, 30 Nov 2020 03:25:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCCE6C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C8CDD86519
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:25:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Be_8dX1X71nC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:25:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1ABCE864E6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606706745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PKqxfTAarK2PmpFylMjiQ+MEy5YRoBV5xq5ZWEkarc0=;
 b=FbTyj6CQphG1Zdkly9plqy8glBzJqi28a+iAxlWw0Gcjo6phMnEiWgntos+U3R7+17i6Zp
 DL4TA6BiaTDmYIZ7Eza0jhZd5qfWgk/midw157q8uBm/M13bZ7nYS0zpCajyNk1UsDqKu2
 t3GSZ2ynyUvUllzvlagOhpkQjuMAfq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-Njj5YyWEPbqqoyyntToa0g-1; Sun, 29 Nov 2020 22:25:42 -0500
X-MC-Unique: Njj5YyWEPbqqoyyntToa0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A22371005D65;
 Mon, 30 Nov 2020 03:25:41 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D96B60843;
 Mon, 30 Nov 2020 03:25:32 +0000 (UTC)
Subject: Re: [PATCH v2 12/17] vdpa_sim: add get_config callback in
 vdpasim_dev_attr
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-13-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f8106986-e19d-ea32-436c-14cddd2b6ff4@redhat.com>
Date: Mon, 30 Nov 2020 11:25:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-13-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Ck9uIDIwMjAvMTEvMjYg5LiL5Y2IMTA6NDksIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBU
aGUgZ2V0X2NvbmZpZyBjYWxsYmFjayBjYW4gYmUgdXNlZCBieSB0aGUgZGV2aWNlIHRvIGZpbGwg
dGhlCj4gY29uZmlnIHN0cnVjdHVyZS4KPiBUaGUgY2FsbGJhY2sgd2lsbCBiZSBpbnZva2VkIGlu
IHZkcGFzaW1fZ2V0X2NvbmZpZygpIGJlZm9yZSBjb3B5aW5nCj4gYnl0ZXMgaW50byBjYWxsZXIg
YnVmZmVyLgo+Cj4gTW92ZSB2RFBBLW5ldCBjb25maWcgdXBkYXRlcyBmcm9tIHZkcGFzaW1fc2V0
X2ZlYXR1cmVzKCkgaW4gdGhlCj4gbmV3IHZkcGFzaW1fbmV0X2dldF9jb25maWcoKSBjYWxsYmFj
ay4KPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0
LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIHwgMzMgKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNl
cnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEv
dmRwYV9zaW0vdmRwYV9zaW0uYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4g
aW5kZXggYzA3ZGRmNmFmNzIwLi44Yjg3Y2UwNDg1YjYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92
ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRw
YV9zaW0uYwo+IEBAIC01OCw2ICs1OCw4IEBAIHN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1ZSB7Cj4g
ICAjZGVmaW5lIFZEUEFTSU1fTkVUX0ZFQVRVUkVTCShWRFBBU0lNX0ZFQVRVUkVTIHwgXAo+ICAg
CQkJCSAoMVVMTCA8PCBWSVJUSU9fTkVUX0ZfTUFDKSkKPiAgIAo+ICtzdHJ1Y3QgdmRwYXNpbTsK
PiArCj4gICBzdHJ1Y3QgdmRwYXNpbV9kZXZfYXR0ciB7Cj4gICAJdTY0IHN1cHBvcnRlZF9mZWF0
dXJlczsKPiAgIAlzaXplX3QgY29uZmlnX3NpemU7Cj4gQEAgLTY1LDYgKzY3LDcgQEAgc3RydWN0
IHZkcGFzaW1fZGV2X2F0dHIgewo+ICAgCXUzMiBpZDsKPiAgIAo+ICAgCXdvcmtfZnVuY190IHdv
cmtfZm47Cj4gKwl2b2lkICgqZ2V0X2NvbmZpZykoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0sIHZv
aWQgKmNvbmZpZyk7Cj4gICB9Owo+ICAgCj4gICAvKiBTdGF0ZSBvZiBlYWNoIHZkcGFzaW0gZGV2
aWNlICovCj4gQEAgLTUyMCw4ICs1MjMsNiBAQCBzdGF0aWMgdTY0IHZkcGFzaW1fZ2V0X2ZlYXR1
cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkKPiAgIHN0YXRpYyBpbnQgdmRwYXNpbV9zZXRf
ZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1NjQgZmVhdHVyZXMpCj4gICB7Cj4g
ICAJc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0gPSB2ZHBhX3RvX3NpbSh2ZHBhKTsKPiAtCXN0cnVj
dCB2aXJ0aW9fbmV0X2NvbmZpZyAqY29uZmlnID0KPiAtCQkoc3RydWN0IHZpcnRpb19uZXRfY29u
ZmlnICopdmRwYXNpbS0+Y29uZmlnOwo+ICAgCj4gICAJLyogRE1BIG1hcHBpbmcgbXVzdCBiZSBk
b25lIGJ5IGRyaXZlciAqLwo+ICAgCWlmICghKGZlYXR1cmVzICYgKDFVTEwgPDwgVklSVElPX0Zf
QUNDRVNTX1BMQVRGT1JNKSkpCj4gQEAgLTUyOSwxNSArNTMwLDYgQEAgc3RhdGljIGludCB2ZHBh
c2ltX3NldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHU2NCBmZWF0dXJlcykK
PiAgIAo+ICAgCXZkcGFzaW0tPmZlYXR1cmVzID0gZmVhdHVyZXMgJiB2ZHBhc2ltLT5kZXZfYXR0
ci5zdXBwb3J0ZWRfZmVhdHVyZXM7Cj4gICAKPiAtCS8qIFdlIGdlbmVyYWxseSBvbmx5IGtub3cg
d2hldGhlciBndWVzdCBpcyB1c2luZyB0aGUgbGVnYWN5IGludGVyZmFjZQo+IC0JICogaGVyZSwg
c28gZ2VuZXJhbGx5IHRoYXQncyB0aGUgZWFybGllc3Qgd2UgY2FuIHNldCBjb25maWcgZmllbGRz
Lgo+IC0JICogTm90ZTogV2UgYWN0dWFsbHkgcmVxdWlyZSBWSVJUSU9fRl9BQ0NFU1NfUExBVEZP
Uk0gYWJvdmUgd2hpY2gKPiAtCSAqIGltcGxpZXMgVklSVElPX0ZfVkVSU0lPTl8xLCBidXQgbGV0
J3Mgbm90IHRyeSB0byBiZSBjbGV2ZXIgaGVyZS4KPiAtCSAqLwo+IC0KPiAtCWNvbmZpZy0+bXR1
ID0gY3B1X3RvX3ZkcGFzaW0xNih2ZHBhc2ltLCAxNTAwKTsKPiAtCWNvbmZpZy0+c3RhdHVzID0g
Y3B1X3RvX3ZkcGFzaW0xNih2ZHBhc2ltLCBWSVJUSU9fTkVUX1NfTElOS19VUCk7Cj4gLQltZW1j
cHkoY29uZmlnLT5tYWMsIG1hY2FkZHJfYnVmLCBFVEhfQUxFTik7Cj4gICAKPiAgIAlyZXR1cm4g
MDsKPiAgIH0KPiBAQCAtNTkzLDggKzU4NSwxMiBAQCBzdGF0aWMgdm9pZCB2ZHBhc2ltX2dldF9j
b25maWcoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+ICAg
ewo+ICAgCXN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltID0gdmRwYV90b19zaW0odmRwYSk7Cj4gICAK
PiAtCWlmIChvZmZzZXQgKyBsZW4gPCB2ZHBhc2ltLT5kZXZfYXR0ci5jb25maWdfc2l6ZSkKPiAt
CQltZW1jcHkoYnVmLCB2ZHBhc2ltLT5jb25maWcgKyBvZmZzZXQsIGxlbik7Cj4gKwlpZiAob2Zm
c2V0ICsgbGVuID4gdmRwYXNpbS0+ZGV2X2F0dHIuY29uZmlnX3NpemUpCj4gKwkJcmV0dXJuOwo+
ICsKPiArCXZkcGFzaW0tPmRldl9hdHRyLmdldF9jb25maWcodmRwYXNpbSwgdmRwYXNpbS0+Y29u
ZmlnKTsKPiArCj4gKwltZW1jcHkoYnVmLCB2ZHBhc2ltLT5jb25maWcgKyBvZmZzZXQsIGxlbik7
Cj4gICB9CgoKSSB3b25kZXIgaG93IG11Y2ggdmFsdWUgd2UgY2FuIGdldCBmcm9tIHZkcGFzaW0t
PmNvbmZpZyBjb25zaWRlciB3ZSd2ZSAKYWxyZWFkeSBoYWQgZ2V0X2NvbmZpZygpIG1ldGhvZC4K
CklzIGl0IHBvc3NpYmxlIHRvIGNvcHkgdG8gdGhlIGJ1ZmZlciBkaXJlY3RseSBoZXJlPwoKVGhh
bmtzCgoKPiAgIAo+ICAgc3RhdGljIHZvaWQgdmRwYXNpbV9zZXRfY29uZmlnKHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRwYSwgdW5zaWduZWQgaW50IG9mZnNldCwKPiBAQCAtNzM3LDYgKzczMywxNiBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyB2ZHBhc2ltX2JhdGNoX2NvbmZp
Z19vcHMgPSB7Cj4gICAJLmZyZWUgICAgICAgICAgICAgICAgICAgPSB2ZHBhc2ltX2ZyZWUsCj4g
ICB9Owo+ICAgCj4gK3N0YXRpYyB2b2lkIHZkcGFzaW1fbmV0X2dldF9jb25maWcoc3RydWN0IHZk
cGFzaW0gKnZkcGFzaW0sIHZvaWQgKmNvbmZpZykKPiArewo+ICsJc3RydWN0IHZpcnRpb19uZXRf
Y29uZmlnICpuZXRfY29uZmlnID0KPiArCQkoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnICopY29u
ZmlnOwo+ICsKPiArCW5ldF9jb25maWctPm10dSA9IGNwdV90b192ZHBhc2ltMTYodmRwYXNpbSwg
MTUwMCk7Cj4gKwluZXRfY29uZmlnLT5zdGF0dXMgPSBjcHVfdG9fdmRwYXNpbTE2KHZkcGFzaW0s
IFZJUlRJT19ORVRfU19MSU5LX1VQKTsKPiArCW1lbWNweShuZXRfY29uZmlnLT5tYWMsIG1hY2Fk
ZHJfYnVmLCBFVEhfQUxFTik7Cj4gK30KPiArCj4gICBzdGF0aWMgaW50IF9faW5pdCB2ZHBhc2lt
X2Rldl9pbml0KHZvaWQpCj4gICB7Cj4gICAJc3RydWN0IHZkcGFzaW1fZGV2X2F0dHIgZGV2X2F0
dHIgPSB7fTsKPiBAQCAtNzQ1LDYgKzc1MSw3IEBAIHN0YXRpYyBpbnQgX19pbml0IHZkcGFzaW1f
ZGV2X2luaXQodm9pZCkKPiAgIAlkZXZfYXR0ci5zdXBwb3J0ZWRfZmVhdHVyZXMgPSBWRFBBU0lN
X05FVF9GRUFUVVJFUzsKPiAgIAlkZXZfYXR0ci5udnFzID0gVkRQQVNJTV9WUV9OVU07Cj4gICAJ
ZGV2X2F0dHIuY29uZmlnX3NpemUgPSBzaXplb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnKTsK
PiArCWRldl9hdHRyLmdldF9jb25maWcgPSB2ZHBhc2ltX25ldF9nZXRfY29uZmlnOwo+ICAgCWRl
dl9hdHRyLndvcmtfZm4gPSB2ZHBhc2ltX25ldF93b3JrOwo+ICAgCj4gICAJdmRwYXNpbV9kZXYg
PSB2ZHBhc2ltX2NyZWF0ZSgmZGV2X2F0dHIpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
