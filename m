Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE98FC433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 05:23:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FACC221E2
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 05:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FACC221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1242D877AE;
	Mon,  7 Dec 2020 05:23:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oti9oJ-9SnPH; Mon,  7 Dec 2020 05:23:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6FC62875BD;
	Mon,  7 Dec 2020 05:23:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B3F1C0FA7;
	Mon,  7 Dec 2020 05:23:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73746C013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:23:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5A21986EB5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:23:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mbG_134HLw4v
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:23:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4A2EA86D02
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607318582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G3sqomrhyZHKdY0RKEtJNlFIqOnxuyXyHNpvoUxGvEM=;
 b=UcnAEzHTTUlE/JYAq4jkgeimSeZE93dB8e2wukNFpx0Z5J4ji9+wgj12+C//5R2eIT0opG
 NNqiB22rMv0HZEFjAq9LuyCXsHZ0G3RK0hBljGQ2vkTx3F73uWydSouM1RAcfm3E3Kg624
 k+BhWdYyve3mnCGamHuKXgdZQ1rTOIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-F7t2Nj1aMo-RZ8LZo9iGNQ-1; Mon, 07 Dec 2020 00:22:59 -0500
X-MC-Unique: F7t2Nj1aMo-RZ8LZo9iGNQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1498C858181;
 Mon,  7 Dec 2020 05:22:58 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1092C60CED;
 Mon,  7 Dec 2020 05:22:43 +0000 (UTC)
Subject: Re: [PATCH v3 12/19] vdpa_sim: make 'config' generic and usable for
 any device type
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-13-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c32b4030-fccb-3e77-faf0-a53b8a865563@redhat.com>
Date: Mon, 7 Dec 2020 13:22:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203170511.216407-13-sgarzare@redhat.com>
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

Ck9uIDIwMjAvMTIvNCDkuIrljYgxOjA1LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gQWRk
IG5ldyAnY29uZmlnX3NpemUnIGF0dHJpYnV0ZSBpbiAndmRwYXNpbV9kZXZfYXR0cicgYW5kIGFs
bG9jYXRlcwo+ICdjb25maWcnIGR5bmFtaWNhbGx5IHRvIHN1cHBvcnQgYW55IGRldmljZSB0eXBl
cy4KPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0
LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIHwgMTcgKysr
KysrKysrKysrKy0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoK
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgYi9kcml2
ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+IGluZGV4IDk0OWY0MjMxZDA4YS4uZmU3MWVk
Nzg5MGUxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4g
KysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiBAQCAtNjIsNiArNjIsNyBA
QCBzdHJ1Y3QgdmRwYXNpbV92aXJ0cXVldWUgewo+ICAgCj4gICBzdHJ1Y3QgdmRwYXNpbV9kZXZf
YXR0ciB7Cj4gICAJdTY0IHN1cHBvcnRlZF9mZWF0dXJlczsKPiArCXNpemVfdCBjb25maWdfc2l6
ZTsKPiAgIAlpbnQgbnZxczsKPiAgIAl1MzIgaWQ7Cj4gICAKPiBAQCAtNzYsNyArNzcsOCBAQCBz
dHJ1Y3QgdmRwYXNpbSB7Cj4gICAJc3RydWN0IHZkcGFzaW1fZGV2X2F0dHIgZGV2X2F0dHI7Cj4g
ICAJLyogc3BpbmxvY2sgdG8gc3luY2hyb25pemUgdmlydHF1ZXVlIHN0YXRlICovCj4gICAJc3Bp
bmxvY2tfdCBsb2NrOwo+IC0Jc3RydWN0IHZpcnRpb19uZXRfY29uZmlnIGNvbmZpZzsKPiArCS8q
IHZpcnRpbyBjb25maWcgYWNjb3JkaW5nIHRvIGRldmljZSB0eXBlICovCj4gKwl2b2lkICpjb25m
aWc7Cj4gICAJc3RydWN0IHZob3N0X2lvdGxiICppb21tdTsKPiAgIAl2b2lkICpidWZmZXI7Cj4g
ICAJdTMyIHN0YXR1czsKPiBAQCAtMzc2LDYgKzM3OCwxMCBAQCBzdGF0aWMgc3RydWN0IHZkcGFz
aW0gKnZkcGFzaW1fY3JlYXRlKHN0cnVjdCB2ZHBhc2ltX2Rldl9hdHRyICpkZXZfYXR0cikKPiAg
IAkJZ290byBlcnJfaW9tbXU7Cj4gICAJc2V0X2RtYV9vcHMoZGV2LCAmdmRwYXNpbV9kbWFfb3Bz
KTsKPiAgIAo+ICsJdmRwYXNpbS0+Y29uZmlnID0ga3phbGxvYyhkZXZfYXR0ci0+Y29uZmlnX3Np
emUsIEdGUF9LRVJORUwpOwo+ICsJaWYgKCF2ZHBhc2ltLT5jb25maWcpCj4gKwkJZ290byBlcnJf
aW9tbXU7Cj4gKwo+ICAgCXZkcGFzaW0tPnZxcyA9IGtjYWxsb2MoZGV2X2F0dHItPm52cXMsIHNp
emVvZihzdHJ1Y3QgdmRwYXNpbV92aXJ0cXVldWUpLAo+ICAgCQkJICAgICAgIEdGUF9LRVJORUwp
Owo+ICAgCWlmICghdmRwYXNpbS0+dnFzKQo+IEBAIC01MTYsNyArNTIyLDggQEAgc3RhdGljIHU2
NCB2ZHBhc2ltX2dldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEpCj4gICBzdGF0
aWMgaW50IHZkcGFzaW1fc2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwgdTY0
IGZlYXR1cmVzKQo+ICAgewo+ICAgCXN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltID0gdmRwYV90b19z
aW0odmRwYSk7Cj4gLQlzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcgKmNvbmZpZyA9ICZ2ZHBhc2lt
LT5jb25maWc7Cj4gKwlzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcgKmNvbmZpZyA9Cj4gKwkJKHN0
cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyAqKXZkcGFzaW0tPmNvbmZpZzsKPiAgIAo+ICAgCS8qIERN
QSBtYXBwaW5nIG11c3QgYmUgZG9uZSBieSBkcml2ZXIgKi8KPiAgIAlpZiAoIShmZWF0dXJlcyAm
ICgxVUxMIDw8IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkpKQo+IEBAIC01ODgsOCArNTk1LDgg
QEAgc3RhdGljIHZvaWQgdmRwYXNpbV9nZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRw
YSwgdW5zaWduZWQgaW50IG9mZnNldCwKPiAgIHsKPiAgIAlzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNp
bSA9IHZkcGFfdG9fc2ltKHZkcGEpOwo+ICAgCj4gLQlpZiAob2Zmc2V0ICsgbGVuIDwgc2l6ZW9m
KHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZykpCj4gLQkJbWVtY3B5KGJ1ZiwgKHU4ICopJnZkcGFz
aW0tPmNvbmZpZyArIG9mZnNldCwgbGVuKTsKPiArCWlmIChvZmZzZXQgKyBsZW4gPCB2ZHBhc2lt
LT5kZXZfYXR0ci5jb25maWdfc2l6ZSkKPiArCQltZW1jcHkoYnVmLCB2ZHBhc2ltLT5jb25maWcg
KyBvZmZzZXQsIGxlbik7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB2b2lkIHZkcGFzaW1fc2V0X2Nv
bmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHVuc2lnbmVkIGludCBvZmZzZXQsCj4gQEAg
LTY3Niw2ICs2ODMsNyBAQCBzdGF0aWMgdm9pZCB2ZHBhc2ltX2ZyZWUoc3RydWN0IHZkcGFfZGV2
aWNlICp2ZHBhKQo+ICAgCWlmICh2ZHBhc2ltLT5pb21tdSkKPiAgIAkJdmhvc3RfaW90bGJfZnJl
ZSh2ZHBhc2ltLT5pb21tdSk7Cj4gICAJa2ZyZWUodmRwYXNpbS0+dnFzKTsKPiArCWtmcmVlKHZk
cGFzaW0tPmNvbmZpZyk7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9j
b25maWdfb3BzIHZkcGFzaW1fY29uZmlnX29wcyA9IHsKPiBAQCAtNzM4LDYgKzc0Niw3IEBAIHN0
YXRpYyBpbnQgX19pbml0IHZkcGFzaW1fZGV2X2luaXQodm9pZCkKPiAgIAlkZXZfYXR0ci5pZCA9
IFZJUlRJT19JRF9ORVQ7Cj4gICAJZGV2X2F0dHIuc3VwcG9ydGVkX2ZlYXR1cmVzID0gVkRQQVNJ
TV9ORVRfRkVBVFVSRVM7Cj4gICAJZGV2X2F0dHIubnZxcyA9IFZEUEFTSU1fVlFfTlVNOwo+ICsJ
ZGV2X2F0dHIuY29uZmlnX3NpemUgPSBzaXplb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnKTsK
PiAgIAlkZXZfYXR0ci53b3JrX2ZuID0gdmRwYXNpbV9uZXRfd29yazsKPiAgIAo+ICAgCXZkcGFz
aW1fZGV2ID0gdmRwYXNpbV9jcmVhdGUoJmRldl9hdHRyKTsKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
