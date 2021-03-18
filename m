Return-Path: <SRS0=KYCx=IQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5660C433DB
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 03:21:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CCE764E89
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 03:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCE764E89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B187B4EDD8;
	Thu, 18 Mar 2021 03:21:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7TXh_LI2CXhk; Thu, 18 Mar 2021 03:21:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id F394E4ED8A;
	Thu, 18 Mar 2021 03:21:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5640C000B;
	Thu, 18 Mar 2021 03:21:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3B7FC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 03:21:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C6DE4ED90
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 03:21:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f4sFLRPjTtQ0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 03:21:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 81FC54ED8A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 03:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616037713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5BT+nyobozNFdq5yfy7SyD1H7/XRWbsPpCZgxk5rh1U=;
 b=XgisLkuLWuzteGJARcJ1ww5Jcqcs0pjPDugz1Q++lMS0G2ESTVUdUXRy5yCX0FvaBEIEuN
 JJHVycHggJ/VtFEj4O46EkkBq4QpEWfW6vo5fYs53A/pLJEbV/b/RVMbqRy9vqFaIhaMgM
 xulDi4FZo6unFRwJF6CPOWwkziuNbgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-1ZSKFoxxP1CgTNolxexCQg-1; Wed, 17 Mar 2021 23:21:51 -0400
X-MC-Unique: 1ZSKFoxxP1CgTNolxexCQg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7460C81620;
 Thu, 18 Mar 2021 03:21:49 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-131.pek2.redhat.com
 [10.72.13.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA61666A05;
 Thu, 18 Mar 2021 03:21:38 +0000 (UTC)
Subject: Re: [PATCH v4 08/14] vdpa: add get_config_size callback in
 vdpa_config_ops
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210315163450.254396-1-sgarzare@redhat.com>
 <20210315163450.254396-9-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ce53cce5-bbb5-53cd-a927-b44ffe0509a7@redhat.com>
Date: Thu, 18 Mar 2021 11:21:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315163450.254396-9-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xie Yongji <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvMy8xNiDJz87nMTI6MzQsIFN0ZWZhbm8gR2FyemFyZWxsYSDQtLXAOgo+IFRoaXMg
bmV3IGNhbGxiYWNrIGlzIHVzZWQgdG8gZ2V0IHRoZSBzaXplIG9mIHRoZSBjb25maWd1cmF0aW9u
IHNwYWNlCj4gb2YgdkRQQSBkZXZpY2VzLgo+Cj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6
YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCAgICAgICAg
ICAgICAgfCA0ICsrKysKPiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgICB8IDYg
KysrKysrCj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCA2ICsrKysrKwo+
ICAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgIHwgOSArKysrKysrKysKPiAgIGRy
aXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYyB8IDggKysrKysrKysKPiAgIDUgZmlsZXMg
Y2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
dmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiBpbmRleCAxNWZhMDg1ZmFiMDUuLjFiMDk0
YzE1MzFmMiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ICsrKyBiL2luY2x1
ZGUvbGludXgvdmRwYS5oCj4gQEAgLTE1MCw2ICsxNTAsOSBAQCBzdHJ1Y3QgdmRwYV9pb3ZhX3Jh
bmdlIHsKPiAgICAqIEBzZXRfc3RhdHVzOgkJCVNldCB0aGUgZGV2aWNlIHN0YXR1cwo+ICAgICoJ
CQkJQHZkZXY6IHZkcGEgZGV2aWNlCj4gICAgKgkJCQlAc3RhdHVzOiB2aXJ0aW8gZGV2aWNlIHN0
YXR1cwo+ICsgKiBAZ2V0X2NvbmZpZ19zaXplOgkJR2V0IHRoZSBzaXplIG9mIHRoZSBjb25maWd1
cmF0aW9uIHNwYWNlCj4gKyAqCQkJCUB2ZGV2OiB2ZHBhIGRldmljZQo+ICsgKgkJCQlSZXR1cm5z
IHNpemVfdDogY29uZmlndXJhdGlvbiBzaXplCj4gICAgKiBAZ2V0X2NvbmZpZzoJCQlSZWFkIGZy
b20gZGV2aWNlIHNwZWNpZmljIGNvbmZpZ3VyYXRpb24gc3BhY2UKPiAgICAqCQkJCUB2ZGV2OiB2
ZHBhIGRldmljZQo+ICAgICoJCQkJQG9mZnNldDogb2Zmc2V0IGZyb20gdGhlIGJlZ2lubmluZyBv
Zgo+IEBAIC0yMzEsNiArMjM0LDcgQEAgc3RydWN0IHZkcGFfY29uZmlnX29wcyB7Cj4gICAJdTMy
ICgqZ2V0X3ZlbmRvcl9pZCkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KTsKPiAgIAl1OCAoKmdl
dF9zdGF0dXMpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldik7Cj4gICAJdm9pZCAoKnNldF9zdGF0
dXMpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTggc3RhdHVzKTsKPiArCXNpemVfdCAoKmdl
dF9jb25maWdfc2l6ZSkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KTsKPiAgIAl2b2lkICgqZ2V0
X2NvbmZpZykoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+
ICAgCQkJICAgdm9pZCAqYnVmLCB1bnNpZ25lZCBpbnQgbGVuKTsKPiAgIAl2b2lkICgqc2V0X2Nv
bmZpZykoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIGIvZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX21haW4uYwo+IGluZGV4IGQ1NTVhNmE1ZDFiYS4uMDE3YWIwNzA0MGM3IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiArKysgYi9kcml2
ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gQEAgLTMzMiw2ICszMzIsMTEgQEAgc3RhdGlj
IHUzMiBpZmN2Zl92ZHBhX2dldF92cV9hbGlnbihzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2
KQo+ICAgCXJldHVybiBJRkNWRl9RVUVVRV9BTElHTk1FTlQ7Cj4gICB9Cj4gICAKPiArc3RhdGlj
IHNpemVfdCBpZmN2Zl92ZHBhX2dldF9jb25maWdfc2l6ZShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
cGFfZGV2KQo+ICt7Cj4gKwlyZXR1cm4gc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyk7
Cj4gK30KPiArCj4gICBzdGF0aWMgdm9pZCBpZmN2Zl92ZHBhX2dldF9jb25maWcoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZHBhX2RldiwKPiAgIAkJCQkgIHVuc2lnbmVkIGludCBvZmZzZXQsCj4gICAJ
CQkJICB2b2lkICpidWYsIHVuc2lnbmVkIGludCBsZW4pCj4gQEAgLTM5Miw2ICszOTcsNyBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyBpZmNfdmRwYV9vcHMgPSB7Cj4gICAJ
LmdldF9kZXZpY2VfaWQJPSBpZmN2Zl92ZHBhX2dldF9kZXZpY2VfaWQsCj4gICAJLmdldF92ZW5k
b3JfaWQJPSBpZmN2Zl92ZHBhX2dldF92ZW5kb3JfaWQsCj4gICAJLmdldF92cV9hbGlnbgk9IGlm
Y3ZmX3ZkcGFfZ2V0X3ZxX2FsaWduLAo+ICsJLmdldF9jb25maWdfc2l6ZQk9IGlmY3ZmX3ZkcGFf
Z2V0X2NvbmZpZ19zaXplLAo+ICAgCS5nZXRfY29uZmlnCT0gaWZjdmZfdmRwYV9nZXRfY29uZmln
LAo+ICAgCS5zZXRfY29uZmlnCT0gaWZjdmZfdmRwYV9zZXRfY29uZmlnLAo+ICAgCS5zZXRfY29u
ZmlnX2NiICA9IGlmY3ZmX3ZkcGFfc2V0X2NvbmZpZ19jYiwKPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVf
dm5ldC5jCj4gaW5kZXggNzEzOTdmZGFmYTZhLi5mNmUwM2JmNDllM2UgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gKysrIGIvZHJpdmVycy92ZHBhL21s
eDUvbmV0L21seDVfdm5ldC5jCj4gQEAgLTE4MTQsNiArMTgxNCwxMSBAQCBzdGF0aWMgdm9pZCBt
bHg1X3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU4IHN0YXR1cykK
PiAgIAluZGV2LT5tdmRldi5zdGF0dXMgfD0gVklSVElPX0NPTkZJR19TX0ZBSUxFRDsKPiAgIH0K
PiAgIAo+ICtzdGF0aWMgc2l6ZV90IG1seDVfdmRwYV9nZXRfY29uZmlnX3NpemUoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZGV2KQo+ICt7Cj4gKwlyZXR1cm4gc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fbmV0
X2NvbmZpZyk7Cj4gK30KPiArCj4gICBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfZ2V0X2NvbmZpZyhz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBvZmZzZXQsIHZvaWQgKmJ1ZiwK
PiAgIAkJCQkgdW5zaWduZWQgaW50IGxlbikKPiAgIHsKPiBAQCAtMTkwMCw2ICsxOTA1LDcgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgbWx4NV92ZHBhX29wcyA9IHsKPiAg
IAkuZ2V0X3ZlbmRvcl9pZCA9IG1seDVfdmRwYV9nZXRfdmVuZG9yX2lkLAo+ICAgCS5nZXRfc3Rh
dHVzID0gbWx4NV92ZHBhX2dldF9zdGF0dXMsCj4gICAJLnNldF9zdGF0dXMgPSBtbHg1X3ZkcGFf
c2V0X3N0YXR1cywKPiArCS5nZXRfY29uZmlnX3NpemUgPSBtbHg1X3ZkcGFfZ2V0X2NvbmZpZ19z
aXplLAo+ICAgCS5nZXRfY29uZmlnID0gbWx4NV92ZHBhX2dldF9jb25maWcsCj4gICAJLnNldF9j
b25maWcgPSBtbHg1X3ZkcGFfc2V0X2NvbmZpZywKPiAgIAkuZ2V0X2dlbmVyYXRpb24gPSBtbHg1
X3ZkcGFfZ2V0X2dlbmVyYXRpb24sCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3Np
bS92ZHBhX3NpbS5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiBpbmRleCAx
NGRjMmQzZDk4M2UuLjk4Zjc5M2JjOTM3NiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRw
YV9zaW0vdmRwYV9zaW0uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5j
Cj4gQEAgLTQ2Miw2ICs0NjIsMTMgQEAgc3RhdGljIHZvaWQgdmRwYXNpbV9zZXRfc3RhdHVzKHN0
cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwgdTggc3RhdHVzKQo+ICAgCXNwaW5fdW5sb2NrKCZ2ZHBh
c2ltLT5sb2NrKTsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgc2l6ZV90IHZkcGFzaW1fZ2V0X2NvbmZp
Z19zaXplKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkKPiArewo+ICsJc3RydWN0IHZkcGFzaW0g
KnZkcGFzaW0gPSB2ZHBhX3RvX3NpbSh2ZHBhKTsKPiArCj4gKwlyZXR1cm4gdmRwYXNpbS0+ZGV2
X2F0dHIuY29uZmlnX3NpemU7Cj4gK30KPiArCj4gICBzdGF0aWMgdm9pZCB2ZHBhc2ltX2dldF9j
b25maWcoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+ICAg
CQkJICAgICB2b2lkICpidWYsIHVuc2lnbmVkIGludCBsZW4pCj4gICB7Cj4gQEAgLTU5OCw2ICs2
MDUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyB2ZHBhc2ltX2NvbmZp
Z19vcHMgPSB7Cj4gICAJLmdldF92ZW5kb3JfaWQgICAgICAgICAgPSB2ZHBhc2ltX2dldF92ZW5k
b3JfaWQsCj4gICAJLmdldF9zdGF0dXMgICAgICAgICAgICAgPSB2ZHBhc2ltX2dldF9zdGF0dXMs
Cj4gICAJLnNldF9zdGF0dXMgICAgICAgICAgICAgPSB2ZHBhc2ltX3NldF9zdGF0dXMsCj4gKwku
Z2V0X2NvbmZpZ19zaXplICAgICAgICA9IHZkcGFzaW1fZ2V0X2NvbmZpZ19zaXplLAo+ICAgCS5n
ZXRfY29uZmlnICAgICAgICAgICAgID0gdmRwYXNpbV9nZXRfY29uZmlnLAo+ICAgCS5zZXRfY29u
ZmlnICAgICAgICAgICAgID0gdmRwYXNpbV9zZXRfY29uZmlnLAo+ICAgCS5nZXRfZ2VuZXJhdGlv
biAgICAgICAgID0gdmRwYXNpbV9nZXRfZ2VuZXJhdGlvbiwKPiBAQCAtNjI1LDYgKzYzMyw3IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIHZkcGFzaW1fYmF0Y2hfY29uZmln
X29wcyA9IHsKPiAgIAkuZ2V0X3ZlbmRvcl9pZCAgICAgICAgICA9IHZkcGFzaW1fZ2V0X3ZlbmRv
cl9pZCwKPiAgIAkuZ2V0X3N0YXR1cyAgICAgICAgICAgICA9IHZkcGFzaW1fZ2V0X3N0YXR1cywK
PiAgIAkuc2V0X3N0YXR1cyAgICAgICAgICAgICA9IHZkcGFzaW1fc2V0X3N0YXR1cywKPiArCS5n
ZXRfY29uZmlnX3NpemUgICAgICAgID0gdmRwYXNpbV9nZXRfY29uZmlnX3NpemUsCj4gICAJLmdl
dF9jb25maWcgICAgICAgICAgICAgPSB2ZHBhc2ltX2dldF9jb25maWcsCj4gICAJLnNldF9jb25m
aWcgICAgICAgICAgICAgPSB2ZHBhc2ltX3NldF9jb25maWcsCj4gICAJLmdldF9nZW5lcmF0aW9u
ICAgICAgICAgPSB2ZHBhc2ltX2dldF9nZW5lcmF0aW9uLAo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMgYi9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92
ZHBhLmMKPiBpbmRleCAxMzIxYTJmY2QwODguLmRjMjdlYzk3MDg4NCAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmly
dGlvX3BjaS92cF92ZHBhLmMKPiBAQCAtMjk1LDYgKzI5NSwxMyBAQCBzdGF0aWMgdTMyIHZwX3Zk
cGFfZ2V0X3ZxX2FsaWduKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkKPiAgIAlyZXR1cm4gUEFH
RV9TSVpFOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyBzaXplX3QgdnBfdmRwYV9nZXRfY29uZmlnX3Np
emUoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhKQo+ICt7Cj4gKwlzdHJ1Y3QgdmlydGlvX3BjaV9t
b2Rlcm5fZGV2aWNlICptZGV2ID0gdmRwYV90b19tZGV2KHZkcGEpOwo+ICsKPiArCXJldHVybiBt
ZGV2LT5kZXZpY2VfbGVuOwo+ICt9Cj4gKwo+ICAgc3RhdGljIHZvaWQgdnBfdmRwYV9nZXRfY29u
ZmlnKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwKPiAgIAkJCSAgICAgICB1bnNpZ25lZCBpbnQg
b2Zmc2V0LAo+ICAgCQkJICAgICAgIHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGxlbikKPiBAQCAt
MzU0LDYgKzM2MSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIHZwX3Zk
cGFfb3BzID0gewo+ICAgCS5nZXRfZGV2aWNlX2lkCT0gdnBfdmRwYV9nZXRfZGV2aWNlX2lkLAo+
ICAgCS5nZXRfdmVuZG9yX2lkCT0gdnBfdmRwYV9nZXRfdmVuZG9yX2lkLAo+ICAgCS5nZXRfdnFf
YWxpZ24JPSB2cF92ZHBhX2dldF92cV9hbGlnbiwKPiArCS5nZXRfY29uZmlnX3NpemUgPSB2cF92
ZHBhX2dldF9jb25maWdfc2l6ZSwKPiAgIAkuZ2V0X2NvbmZpZwk9IHZwX3ZkcGFfZ2V0X2NvbmZp
ZywKPiAgIAkuc2V0X2NvbmZpZwk9IHZwX3ZkcGFfc2V0X2NvbmZpZywKPiAgIAkuc2V0X2NvbmZp
Z19jYiAgPSB2cF92ZHBhX3NldF9jb25maWdfY2IsCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
