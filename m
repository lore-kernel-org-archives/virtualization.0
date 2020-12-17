Return-Path: <SRS0=dJY/=FV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B491EC4361B
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 05:31:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2538C23434
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 05:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2538C23434
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9506F2E168;
	Thu, 17 Dec 2020 05:31:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9zkMLdgTdtbS; Thu, 17 Dec 2020 05:30:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D6C972E24D;
	Thu, 17 Dec 2020 05:30:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5886C0893;
	Thu, 17 Dec 2020 05:30:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C47ADC013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 05:30:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8A29B2E24D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 05:30:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FsfeIvwYT6N2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 05:30:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 88C452E168
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 05:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608183051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wY2btsgYqiVS4PQXc7v8Z3T58Klg2+NjtbrlCI9p4QE=;
 b=dpFh4vbRbZ6DJJ+mcuxOB8TLkbwy/fRwkS4Uu4eg7opQFi1EMWQEHAEkn/a8NSRh5ZpHQ+
 zPVoTWQXt7M6H1Xxi2BzyuB/p11Hkoo7P1NGNY3RK5gcbXHJz3qJZMSgtphQBrv40ELkC9
 ppJnsXPMxfNW8v0xvQbSg20S72V0o3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-I715YqmJNjeE8CQLuNAYUA-1; Thu, 17 Dec 2020 00:30:49 -0500
X-MC-Unique: I715YqmJNjeE8CQLuNAYUA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86F2E1572D;
 Thu, 17 Dec 2020 05:30:47 +0000 (UTC)
Received: from [10.72.12.223] (ovpn-12-223.pek2.redhat.com [10.72.12.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07D5B5D9C0;
 Thu, 17 Dec 2020 05:30:32 +0000 (UTC)
Subject: Re: [PATCH v4 12/18] vdpa_sim: add get_config callback in
 vdpasim_dev_attr
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201215144256.155342-1-sgarzare@redhat.com>
 <20201215144256.155342-13-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b2d63567-9bf5-4242-adde-cbbe9cdbd293@redhat.com>
Date: Thu, 17 Dec 2020 13:30:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201215144256.155342-13-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, Shahaf Shuler <shahafs@nvidia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>,
 Oren Duer <oren@nvidia.com>
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

Ck9uIDIwMjAvMTIvMTUg5LiL5Y2IMTA6NDIsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBU
aGUgZ2V0X2NvbmZpZyBjYWxsYmFjayBjYW4gYmUgdXNlZCBieSB0aGUgZGV2aWNlIHRvIGZpbGwg
dGhlCj4gY29uZmlnIHN0cnVjdHVyZS4KPiBUaGUgY2FsbGJhY2sgd2lsbCBiZSBpbnZva2VkIGlu
IHZkcGFzaW1fZ2V0X2NvbmZpZygpIGJlZm9yZSBjb3B5aW5nCj4gYnl0ZXMgaW50byBjYWxsZXIg
YnVmZmVyLgo+Cj4gTW92ZSB2RFBBLW5ldCBjb25maWcgdXBkYXRlcyBmcm9tIHZkcGFzaW1fc2V0
X2ZlYXR1cmVzKCkgaW4gdGhlCj4gbmV3IHZkcGFzaW1fbmV0X2dldF9jb25maWcoKSBjYWxsYmFj
ay4KPiBUaGlzIGlzIHNhZmUgc2luY2UgaW4gdmRwYV9nZXRfY29uZmlnKCkgd2UgYWxyZWFkeSBj
aGVjayB0aGF0Cj4gLnNldF9mZWF0dXJlcygpIGNhbGxiYWNrIGlzIGNhbGxlZCBiZWZvcmUgLmdl
dF9jb25maWcoKS4KPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnph
cmVAcmVkaGF0LmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4KCgo+IC0tLQo+IHY0Ogo+IC0gZXhwbGFpbmVkIGluIHRoZSBjb21taXQgbWVzc2FnZSB0aGF0
IHRoZSBtb3ZpbmcgaXMgc2FmZSBbSmFzb25dCj4KPiB2MzoKPiAtIGNoZWNrZWQgaWYgZ2V0X2Nv
bmZpZyBjYWxsYmFjayBpcyBzZXQgYmVmb3JlIGNhbGwgaXQKPiAtLS0KPiAgIGRyaXZlcnMvdmRw
YS92ZHBhX3NpbS92ZHBhX3NpbS5jIHwgMzUgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyBiL2RyaXZl
cnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gaW5kZXggNGEwYTZjYWRiOWZmLi41ZWFkY2Qx
OWFiNmYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiAr
KysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+IEBAIC02OCw2ICs2OCw4IEBA
IHN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1ZSB7Cj4gICAjZGVmaW5lIFZEUEFTSU1fTkVUX0ZFQVRV
UkVTCShWRFBBU0lNX0ZFQVRVUkVTIHwgXAo+ICAgCQkJCSAoMVVMTCA8PCBWSVJUSU9fTkVUX0Zf
TUFDKSkKPiAgIAo+ICtzdHJ1Y3QgdmRwYXNpbTsKPiArCj4gICBzdHJ1Y3QgdmRwYXNpbV9kZXZf
YXR0ciB7Cj4gICAJdTY0IHN1cHBvcnRlZF9mZWF0dXJlczsKPiAgIAlzaXplX3QgY29uZmlnX3Np
emU7Cj4gQEAgLTc1LDYgKzc3LDcgQEAgc3RydWN0IHZkcGFzaW1fZGV2X2F0dHIgewo+ICAgCXUz
MiBpZDsKPiAgIAo+ICAgCXdvcmtfZnVuY190IHdvcmtfZm47Cj4gKwl2b2lkICgqZ2V0X2NvbmZp
Zykoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0sIHZvaWQgKmNvbmZpZyk7Cj4gICB9Owo+ICAgCj4g
ICAvKiBTdGF0ZSBvZiBlYWNoIHZkcGFzaW0gZGV2aWNlICovCj4gQEAgLTUzMCw4ICs1MzMsNiBA
QCBzdGF0aWMgdTY0IHZkcGFzaW1fZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRw
YSkKPiAgIHN0YXRpYyBpbnQgdmRwYXNpbV9zZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZHBhLCB1NjQgZmVhdHVyZXMpCj4gICB7Cj4gICAJc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0g
PSB2ZHBhX3RvX3NpbSh2ZHBhKTsKPiAtCXN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyAqY29uZmln
ID0KPiAtCQkoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnICopdmRwYXNpbS0+Y29uZmlnOwo+ICAg
Cj4gICAJLyogRE1BIG1hcHBpbmcgbXVzdCBiZSBkb25lIGJ5IGRyaXZlciAqLwo+ICAgCWlmICgh
KGZlYXR1cmVzICYgKDFVTEwgPDwgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNKSkpCj4gQEAgLTUz
OSwxNiArNTQwLDYgQEAgc3RhdGljIGludCB2ZHBhc2ltX3NldF9mZWF0dXJlcyhzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkcGEsIHU2NCBmZWF0dXJlcykKPiAgIAo+ICAgCXZkcGFzaW0tPmZlYXR1cmVz
ID0gZmVhdHVyZXMgJiB2ZHBhc2ltLT5kZXZfYXR0ci5zdXBwb3J0ZWRfZmVhdHVyZXM7Cj4gICAK
PiAtCS8qIFdlIGdlbmVyYWxseSBvbmx5IGtub3cgd2hldGhlciBndWVzdCBpcyB1c2luZyB0aGUg
bGVnYWN5IGludGVyZmFjZQo+IC0JICogaGVyZSwgc28gZ2VuZXJhbGx5IHRoYXQncyB0aGUgZWFy
bGllc3Qgd2UgY2FuIHNldCBjb25maWcgZmllbGRzLgo+IC0JICogTm90ZTogV2UgYWN0dWFsbHkg
cmVxdWlyZSBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0gYWJvdmUgd2hpY2gKPiAtCSAqIGltcGxp
ZXMgVklSVElPX0ZfVkVSU0lPTl8xLCBidXQgbGV0J3Mgbm90IHRyeSB0byBiZSBjbGV2ZXIgaGVy
ZS4KPiAtCSAqLwo+IC0KPiAtCWNvbmZpZy0+bXR1ID0gY3B1X3RvX3ZkcGFzaW0xNih2ZHBhc2lt
LCAxNTAwKTsKPiAtCWNvbmZpZy0+c3RhdHVzID0gY3B1X3RvX3ZkcGFzaW0xNih2ZHBhc2ltLCBW
SVJUSU9fTkVUX1NfTElOS19VUCk7Cj4gLQltZW1jcHkoY29uZmlnLT5tYWMsIG1hY2FkZHJfYnVm
LCBFVEhfQUxFTik7Cj4gLQo+ICAgCXJldHVybiAwOwo+ICAgfQo+ICAgCj4gQEAgLTYwMyw4ICs1
OTQsMTMgQEAgc3RhdGljIHZvaWQgdmRwYXNpbV9nZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRwYSwgdW5zaWduZWQgaW50IG9mZnNldCwKPiAgIHsKPiAgIAlzdHJ1Y3QgdmRwYXNpbSAq
dmRwYXNpbSA9IHZkcGFfdG9fc2ltKHZkcGEpOwo+ICAgCj4gLQlpZiAob2Zmc2V0ICsgbGVuIDwg
dmRwYXNpbS0+ZGV2X2F0dHIuY29uZmlnX3NpemUpCj4gLQkJbWVtY3B5KGJ1ZiwgdmRwYXNpbS0+
Y29uZmlnICsgb2Zmc2V0LCBsZW4pOwo+ICsJaWYgKG9mZnNldCArIGxlbiA+IHZkcGFzaW0tPmRl
dl9hdHRyLmNvbmZpZ19zaXplKQo+ICsJCXJldHVybjsKPiArCj4gKwlpZiAodmRwYXNpbS0+ZGV2
X2F0dHIuZ2V0X2NvbmZpZykKPiArCQl2ZHBhc2ltLT5kZXZfYXR0ci5nZXRfY29uZmlnKHZkcGFz
aW0sIHZkcGFzaW0tPmNvbmZpZyk7Cj4gKwo+ICsJbWVtY3B5KGJ1ZiwgdmRwYXNpbS0+Y29uZmln
ICsgb2Zmc2V0LCBsZW4pOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgdm9pZCB2ZHBhc2ltX3NldF9j
b25maWcoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+IEBA
IC03NDcsNiArNzQzLDE2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIHZk
cGFzaW1fYmF0Y2hfY29uZmlnX29wcyA9IHsKPiAgIAkuZnJlZSAgICAgICAgICAgICAgICAgICA9
IHZkcGFzaW1fZnJlZSwKPiAgIH07Cj4gICAKPiArc3RhdGljIHZvaWQgdmRwYXNpbV9uZXRfZ2V0
X2NvbmZpZyhzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSwgdm9pZCAqY29uZmlnKQo+ICt7Cj4gKwlz
dHJ1Y3QgdmlydGlvX25ldF9jb25maWcgKm5ldF9jb25maWcgPQo+ICsJCShzdHJ1Y3QgdmlydGlv
X25ldF9jb25maWcgKiljb25maWc7Cj4gKwo+ICsJbmV0X2NvbmZpZy0+bXR1ID0gY3B1X3RvX3Zk
cGFzaW0xNih2ZHBhc2ltLCAxNTAwKTsKPiArCW5ldF9jb25maWctPnN0YXR1cyA9IGNwdV90b192
ZHBhc2ltMTYodmRwYXNpbSwgVklSVElPX05FVF9TX0xJTktfVVApOwo+ICsJbWVtY3B5KG5ldF9j
b25maWctPm1hYywgbWFjYWRkcl9idWYsIEVUSF9BTEVOKTsKPiArfQo+ICsKPiAgIHN0YXRpYyBp
bnQgX19pbml0IHZkcGFzaW1fZGV2X2luaXQodm9pZCkKPiAgIHsKPiAgIAlzdHJ1Y3QgdmRwYXNp
bV9kZXZfYXR0ciBkZXZfYXR0ciA9IHt9Owo+IEBAIC03NTUsNiArNzYxLDcgQEAgc3RhdGljIGlu
dCBfX2luaXQgdmRwYXNpbV9kZXZfaW5pdCh2b2lkKQo+ICAgCWRldl9hdHRyLnN1cHBvcnRlZF9m
ZWF0dXJlcyA9IFZEUEFTSU1fTkVUX0ZFQVRVUkVTOwo+ICAgCWRldl9hdHRyLm52cXMgPSBWRFBB
U0lNX1ZRX05VTTsKPiAgIAlkZXZfYXR0ci5jb25maWdfc2l6ZSA9IHNpemVvZihzdHJ1Y3Qgdmly
dGlvX25ldF9jb25maWcpOwo+ICsJZGV2X2F0dHIuZ2V0X2NvbmZpZyA9IHZkcGFzaW1fbmV0X2dl
dF9jb25maWc7Cj4gICAJZGV2X2F0dHIud29ya19mbiA9IHZkcGFzaW1fbmV0X3dvcms7Cj4gICAK
PiAgIAl2ZHBhc2ltX2RldiA9IHZkcGFzaW1fY3JlYXRlKCZkZXZfYXR0cik7CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
