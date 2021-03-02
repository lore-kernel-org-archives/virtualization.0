Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22599C433E0
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 04:14:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B7B61490
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 04:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B7B61490
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EB9E6067E;
	Tue,  2 Mar 2021 04:14:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id geH5MBR8zh1y; Tue,  2 Mar 2021 04:14:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1089360673;
	Tue,  2 Mar 2021 04:14:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E989DC000B;
	Tue,  2 Mar 2021 04:14:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D00CC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 04:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E60D60673
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 04:14:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tqzIALmhCJNn
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 04:14:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6719C60668
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 04:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614658473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DTs5bTdT/130awTFS1tu5ijWxNu0Rt9MlaERqm9NUPU=;
 b=exvsORoxsheubC+CIm1xbrEzodG1sq0d3jV2NACEp1AYvPrWgEcNg7XSqQAVLRR0CHVmwA
 0PB9E1Ewd7x5NHteq2zq1PkO3HdU1k/h2mvxvn19+/5xuGDlKuWetU1+4vJ9oSKmMFcogJ
 KOeX00K7WZoJYg4wwOdVErizW4EJ5PU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-O1ppRP1lMXWwFuAq_kwXYA-1; Mon, 01 Mar 2021 23:14:32 -0500
X-MC-Unique: O1ppRP1lMXWwFuAq_kwXYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43D3A1868405;
 Tue,  2 Mar 2021 04:14:31 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-215.pek2.redhat.com
 [10.72.13.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A424D5C730;
 Tue,  2 Mar 2021 04:14:22 +0000 (UTC)
Subject: Re: [RFC PATCH 01/10] vdpa: add get_config_size callback in
 vdpa_config_ops
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210216094454.82106-1-sgarzare@redhat.com>
 <20210216094454.82106-2-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5de4cd5b-04cb-46ca-1717-075e5e8542fd@redhat.com>
Date: Tue, 2 Mar 2021 12:14:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210216094454.82106-2-sgarzare@redhat.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

Ck9uIDIwMjEvMi8xNiA1OjQ0IOS4i+WNiCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IFRo
aXMgbmV3IGNhbGxiYWNrIGlzIHVzZWQgdG8gZ2V0IHRoZSBzaXplIG9mIHRoZSBjb25maWd1cmF0
aW9uIHNwYWNlCj4gb2YgdkRQQSBkZXZpY2VzLgo+Cj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBH
YXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+IC0tLQo+ICAgaW5jbHVkZS9saW51eC92
ZHBhLmggICAgICAgICAgICAgIHwgNCArKysrCj4gICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZf
bWFpbi5jICAgfCA2ICsrKysrKwo+ICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
IHwgNiArKysrKysKPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jICB8IDkgKysr
KysrKysrCj4gICA0IGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gaW5kZXgg
NGFiNTQ5NDUwM2E4Li5mZGRmNDJiMTc1NzMgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC92
ZHBhLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+IEBAIC0xNTAsNiArMTUwLDkgQEAg
c3RydWN0IHZkcGFfaW92YV9yYW5nZSB7Cj4gICAgKiBAc2V0X3N0YXR1czoJCQlTZXQgdGhlIGRl
dmljZSBzdGF0dXMKPiAgICAqCQkJCUB2ZGV2OiB2ZHBhIGRldmljZQo+ICAgICoJCQkJQHN0YXR1
czogdmlydGlvIGRldmljZSBzdGF0dXMKPiArICogQGdldF9jb25maWdfc2l6ZToJCUdldCB0aGUg
c2l6ZSBvZiB0aGUgY29uZmlndXJhdGlvbiBzcGFjZQo+ICsgKgkJCQlAdmRldjogdmRwYSBkZXZp
Y2UKPiArICoJCQkJUmV0dXJucyBzaXplX3Q6IGNvbmZpZ3VyYXRpb24gc2l6ZQoKClJldGhpbmsg
YWJvdXQgdGhpcywgaG93IG11Y2ggd2UgY291bGQgZ2FpbiBieSBpbnRyb2R1Y2luZyBhIGRlZGlj
YXRlZCAKb3BzIGhlcmU/IEUuZyB3b3VsZCBpdCBiZSBzaW1wbGVyIGlmIHdlIHNpbXBseSBpbnRy
b2R1Y2UgYSAKbWF4X2NvbmZpZ19zaXplIHRvIHZkcGEgZGV2aWNlPwoKVGhhbmtzCgoKPiAgICAq
IEBnZXRfY29uZmlnOgkJCVJlYWQgZnJvbSBkZXZpY2Ugc3BlY2lmaWMgY29uZmlndXJhdGlvbiBz
cGFjZQo+ICAgICoJCQkJQHZkZXY6IHZkcGEgZGV2aWNlCj4gICAgKgkJCQlAb2Zmc2V0OiBvZmZz
ZXQgZnJvbSB0aGUgYmVnaW5uaW5nIG9mCj4gQEAgLTIzMSw2ICsyMzQsNyBAQCBzdHJ1Y3QgdmRw
YV9jb25maWdfb3BzIHsKPiAgIAl1MzIgKCpnZXRfdmVuZG9yX2lkKShzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkZXYpOwo+ICAgCXU4ICgqZ2V0X3N0YXR1cykoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2
KTsKPiAgIAl2b2lkICgqc2V0X3N0YXR1cykoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1OCBz
dGF0dXMpOwo+ICsJc2l6ZV90ICgqZ2V0X2NvbmZpZ19zaXplKShzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkZXYpOwo+ICAgCXZvaWQgKCpnZXRfY29uZmlnKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYs
IHVuc2lnbmVkIGludCBvZmZzZXQsCj4gICAJCQkgICB2b2lkICpidWYsIHVuc2lnbmVkIGludCBs
ZW4pOwo+ICAgCXZvaWQgKCpzZXRfY29uZmlnKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVu
c2lnbmVkIGludCBvZmZzZXQsCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2
Zl9tYWluLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gaW5kZXggN2M4YmJm
Y2Y2YzNlLi4yNDQzMjcxZTE3ZDIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lm
Y3ZmX21haW4uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiBAQCAt
MzMyLDYgKzMzMiwxMSBAQCBzdGF0aWMgdTMyIGlmY3ZmX3ZkcGFfZ2V0X3ZxX2FsaWduKHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4gICAJcmV0dXJuIElGQ1ZGX1FVRVVFX0FMSUdOTUVO
VDsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgc2l6ZV90IGlmY3ZmX3ZkcGFfZ2V0X2NvbmZpZ19zaXpl
KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4gK3sKPiArCXJldHVybiBzaXplb2Yoc3Ry
dWN0IHZpcnRpb19uZXRfY29uZmlnKTsKPiArfQo+ICsKPiAgIHN0YXRpYyB2b2lkIGlmY3ZmX3Zk
cGFfZ2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2LAo+ICAgCQkJCSAgdW5z
aWduZWQgaW50IG9mZnNldCwKPiAgIAkJCQkgIHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGxlbikK
PiBAQCAtMzkyLDYgKzM5Nyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3Bz
IGlmY192ZHBhX29wcyA9IHsKPiAgIAkuZ2V0X2RldmljZV9pZAk9IGlmY3ZmX3ZkcGFfZ2V0X2Rl
dmljZV9pZCwKPiAgIAkuZ2V0X3ZlbmRvcl9pZAk9IGlmY3ZmX3ZkcGFfZ2V0X3ZlbmRvcl9pZCwK
PiAgIAkuZ2V0X3ZxX2FsaWduCT0gaWZjdmZfdmRwYV9nZXRfdnFfYWxpZ24sCj4gKwkuZ2V0X2Nv
bmZpZ19zaXplCT0gaWZjdmZfdmRwYV9nZXRfY29uZmlnX3NpemUsCj4gICAJLmdldF9jb25maWcJ
PSBpZmN2Zl92ZHBhX2dldF9jb25maWcsCj4gICAJLnNldF9jb25maWcJPSBpZmN2Zl92ZHBhX3Nl
dF9jb25maWcsCj4gICAJLnNldF9jb25maWdfY2IgID0gaWZjdmZfdmRwYV9zZXRfY29uZmlnX2Ni
LAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2
ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBpbmRleCAxMGU5YjA5OTMyZWIuLjc4MDQz
ZWU1NjdiNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMK
PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBAQCAtMTgxNCw2ICsx
ODE0LDExIEBAIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRldiwgdTggc3RhdHVzKQo+ICAgCW5kZXYtPm12ZGV2LnN0YXR1cyB8PSBWSVJUSU9f
Q09ORklHX1NfRkFJTEVEOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyBzaXplX3QgbWx4NV92ZHBhX2dl
dF9jb25maWdfc2l6ZShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpCj4gK3sKPiArCXJldHVybiBz
aXplb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnKTsKPiArfQo+ICsKPiAgIHN0YXRpYyB2b2lk
IG1seDVfdmRwYV9nZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQg
aW50IG9mZnNldCwgdm9pZCAqYnVmLAo+ICAgCQkJCSB1bnNpZ25lZCBpbnQgbGVuKQo+ICAgewo+
IEBAIC0xOTAwLDYgKzE5MDUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29w
cyBtbHg1X3ZkcGFfb3BzID0gewo+ICAgCS5nZXRfdmVuZG9yX2lkID0gbWx4NV92ZHBhX2dldF92
ZW5kb3JfaWQsCj4gICAJLmdldF9zdGF0dXMgPSBtbHg1X3ZkcGFfZ2V0X3N0YXR1cywKPiAgIAku
c2V0X3N0YXR1cyA9IG1seDVfdmRwYV9zZXRfc3RhdHVzLAo+ICsJLmdldF9jb25maWdfc2l6ZSA9
IG1seDVfdmRwYV9nZXRfY29uZmlnX3NpemUsCj4gICAJLmdldF9jb25maWcgPSBtbHg1X3ZkcGFf
Z2V0X2NvbmZpZywKPiAgIAkuc2V0X2NvbmZpZyA9IG1seDVfdmRwYV9zZXRfY29uZmlnLAo+ICAg
CS5nZXRfZ2VuZXJhdGlvbiA9IG1seDVfdmRwYV9nZXRfZ2VuZXJhdGlvbiwKPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9z
aW0vdmRwYV9zaW0uYwo+IGluZGV4IGQ1OTQyODQyNDMyZC4uNzc5YWU2YzE0NGQ3IDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gKysrIGIvZHJpdmVycy92
ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiBAQCAtNDM5LDYgKzQzOSwxMyBAQCBzdGF0aWMgdm9p
ZCB2ZHBhc2ltX3NldF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1OCBzdGF0dXMp
Cj4gICAJc3Bpbl91bmxvY2soJnZkcGFzaW0tPmxvY2spOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyBz
aXplX3QgdmRwYXNpbV9nZXRfY29uZmlnX3NpemUoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhKQo+
ICt7Cj4gKwlzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSA9IHZkcGFfdG9fc2ltKHZkcGEpOwo+ICsK
PiArCXJldHVybiB2ZHBhc2ltLT5kZXZfYXR0ci5jb25maWdfc2l6ZTsKPiArfQo+ICsKPiAgIHN0
YXRpYyB2b2lkIHZkcGFzaW1fZ2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHVu
c2lnbmVkIGludCBvZmZzZXQsCj4gICAJCQkgICAgIHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGxl
bikKPiAgIHsKPiBAQCAtNTY2LDYgKzU3Myw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9j
b25maWdfb3BzIHZkcGFzaW1fY29uZmlnX29wcyA9IHsKPiAgIAkuZ2V0X3ZlbmRvcl9pZCAgICAg
ICAgICA9IHZkcGFzaW1fZ2V0X3ZlbmRvcl9pZCwKPiAgIAkuZ2V0X3N0YXR1cyAgICAgICAgICAg
ICA9IHZkcGFzaW1fZ2V0X3N0YXR1cywKPiAgIAkuc2V0X3N0YXR1cyAgICAgICAgICAgICA9IHZk
cGFzaW1fc2V0X3N0YXR1cywKPiArCS5nZXRfY29uZmlnX3NpemUgICAgICAgID0gdmRwYXNpbV9n
ZXRfY29uZmlnX3NpemUsCj4gICAJLmdldF9jb25maWcgICAgICAgICAgICAgPSB2ZHBhc2ltX2dl
dF9jb25maWcsCj4gICAJLnNldF9jb25maWcgICAgICAgICAgICAgPSB2ZHBhc2ltX3NldF9jb25m
aWcsCj4gICAJLmdldF9nZW5lcmF0aW9uICAgICAgICAgPSB2ZHBhc2ltX2dldF9nZW5lcmF0aW9u
LAo+IEBAIC01OTMsNiArNjAxLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19v
cHMgdmRwYXNpbV9iYXRjaF9jb25maWdfb3BzID0gewo+ICAgCS5nZXRfdmVuZG9yX2lkICAgICAg
ICAgID0gdmRwYXNpbV9nZXRfdmVuZG9yX2lkLAo+ICAgCS5nZXRfc3RhdHVzICAgICAgICAgICAg
ID0gdmRwYXNpbV9nZXRfc3RhdHVzLAo+ICAgCS5zZXRfc3RhdHVzICAgICAgICAgICAgID0gdmRw
YXNpbV9zZXRfc3RhdHVzLAo+ICsJLmdldF9jb25maWdfc2l6ZSAgICAgICAgPSB2ZHBhc2ltX2dl
dF9jb25maWdfc2l6ZSwKPiAgIAkuZ2V0X2NvbmZpZyAgICAgICAgICAgICA9IHZkcGFzaW1fZ2V0
X2NvbmZpZywKPiAgIAkuc2V0X2NvbmZpZyAgICAgICAgICAgICA9IHZkcGFzaW1fc2V0X2NvbmZp
ZywKPiAgIAkuZ2V0X2dlbmVyYXRpb24gICAgICAgICA9IHZkcGFzaW1fZ2V0X2dlbmVyYXRpb24s
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
