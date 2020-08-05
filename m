Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30187C433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 08:11:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 013C82177B
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 08:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ldy/ymRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013C82177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id ADC47877A5;
	Wed,  5 Aug 2020 08:11:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VZRA3nVBDG1P; Wed,  5 Aug 2020 08:11:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A018F87778;
	Wed,  5 Aug 2020 08:11:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AAB0C0050;
	Wed,  5 Aug 2020 08:11:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9187EC004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 08:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 720E020337
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 08:11:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IxC2tVRDCf1w
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 08:11:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id DCDFA20115
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 08:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596615061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54CekOq5nyKMM7BtMGAhsULPFpA9SluWl2e7PxuQNBc=;
 b=Ldy/ymRaMF+GbqTSDAJvtNZubbdF1WWy1BF53vDNEY+UdgHFwFlTSHDZ2pak6Fxv2ziA50
 /vF/ZukogEh07qpvaOzyXzfwcjxzIAvIrXTwQ7CCANANu6OEhUl4H8Y7SFQ/rfOzOvgFvy
 k/97+vi5BXmCnBoBtrQ+aaDsiEUdIVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-jW_6k5W0NICd4wdnZXdEJA-1; Wed, 05 Aug 2020 04:10:59 -0400
X-MC-Unique: jW_6k5W0NICd4wdnZXdEJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CA748B4279;
 Wed,  5 Aug 2020 08:10:51 +0000 (UTC)
Received: from [10.72.12.225] (ovpn-12-225.pek2.redhat.com [10.72.12.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2765719C4F;
 Wed,  5 Aug 2020 08:10:47 +0000 (UTC)
Subject: Re: [PATCH V4 linux-next 08/12] vdpa: Modify get_vq_state() to return
 error code
To: Eli Cohen <eli@mellanox.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200804162048.22587-1-eli@mellanox.com>
 <20200804162048.22587-9-eli@mellanox.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <972bc164-0d9d-a7fa-6929-daee843f04d7@redhat.com>
Date: Wed, 5 Aug 2020 16:10:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804162048.22587-9-eli@mellanox.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: shahafs@mellanox.com, parav@mellanox.com, saeedm@mellanox.com
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

Ck9uIDIwMjAvOC81IOS4iuWNiDEyOjIwLCBFbGkgQ29oZW4gd3JvdGU6Cj4gTW9kaWZ5IGdldF92
cV9zdGF0ZSgpIHNvIGl0IHJldHVybnMgYW4gZXJyb3IgY29kZS4gSW4gY2FzZSBvZiBoYXJkd2Fy
ZQo+IGFjY2VsZXJhdGlvbiwgdGhlIGF2YWlsYWJsZSBpbmRleCBtYXkgYmUgcmV0cmlldmVkIGZy
b20gdGhlIGRldmljZSwgYW4KPiBvcGVyYXRpb24gdGhhdCBjYW4gcG9zc2libHkgZmFpbC4KPgo+
IFJldmlld2VkLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG1lbGxhbm94LmNvbT4KPiBTaWduZWQt
b2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaUBtZWxsYW5veC5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9tYWluLmMgIHwgNSArKystLQo+ICAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2lt
LmMgfCA1ICsrKy0tCj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyAgICAgICAgICAgICB8IDUgKysr
Ky0KPiAgIGluY2x1ZGUvbGludXgvdmRwYS5oICAgICAgICAgICAgIHwgNCArKy0tCj4gICA0IGZp
bGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyBiL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9tYWluLmMKPiBpbmRleCBkYzMxMWU5NzJiOWUuLjA3NmQ3YWM1ZTcyMyAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gKysrIGIvZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IEBAIC0yMzcsMTIgKzIzNywxMyBAQCBzdGF0aWMgdTE2
IGlmY3ZmX3ZkcGFfZ2V0X3ZxX251bV9tYXgoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldikK
PiAgIAlyZXR1cm4gSUZDVkZfUVVFVUVfTUFYOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyB2b2lkIGlm
Y3ZmX3ZkcGFfZ2V0X3ZxX3N0YXRlKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYsIHUxNiBx
aWQsCj4gLQkJCQkgICAgc3RydWN0IHZkcGFfdnFfc3RhdGUgKnN0YXRlKQo+ICtzdGF0aWMgaW50
IGlmY3ZmX3ZkcGFfZ2V0X3ZxX3N0YXRlKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYsIHUx
NiBxaWQsCj4gKwkJCQkgICBzdHJ1Y3QgdmRwYV92cV9zdGF0ZSAqc3RhdGUpCj4gICB7Cj4gICAJ
c3RydWN0IGlmY3ZmX2h3ICp2ZiA9IHZkcGFfdG9fdmYodmRwYV9kZXYpOwo+ICAgCj4gICAJc3Rh
dGUtPmF2YWlsX2luZGV4ID0gaWZjdmZfZ2V0X3ZxX3N0YXRlKHZmLCBxaWQpOwo+ICsJcmV0dXJu
IDA7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBpbnQgaWZjdmZfdmRwYV9zZXRfdnFfc3RhdGUoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldiwgdTE2IHFpZCwKPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9z
aW0uYwo+IGluZGV4IGYxYzM1MWQ1OTU5Yi4uYzY4NzQxMzYzNjQzIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFf
c2ltL3ZkcGFfc2ltLmMKPiBAQCAtNDY0LDE0ICs0NjQsMTUgQEAgc3RhdGljIGludCB2ZHBhc2lt
X3NldF92cV9zdGF0ZShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHUxNiBpZHgsCj4gICAJcmV0
dXJuIDA7Cj4gICB9Cj4gICAKPiAtc3RhdGljIHZvaWQgdmRwYXNpbV9nZXRfdnFfc3RhdGUoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1MTYgaWR4LAo+IC0JCQkJIHN0cnVjdCB2ZHBhX3ZxX3N0
YXRlICpzdGF0ZSkKPiArc3RhdGljIGludCB2ZHBhc2ltX2dldF92cV9zdGF0ZShzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkcGEsIHUxNiBpZHgsCj4gKwkJCQlzdHJ1Y3QgdmRwYV92cV9zdGF0ZSAqc3Rh
dGUpCj4gICB7Cj4gICAJc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0gPSB2ZHBhX3RvX3NpbSh2ZHBh
KTsKPiAgIAlzdHJ1Y3QgdmRwYXNpbV92aXJ0cXVldWUgKnZxID0gJnZkcGFzaW0tPnZxc1tpZHhd
Owo+ICAgCXN0cnVjdCB2cmluZ2ggKnZyaCA9ICZ2cS0+dnJpbmc7Cj4gICAKPiAgIAlzdGF0ZS0+
YXZhaWxfaW5kZXggPSB2cmgtPmxhc3RfYXZhaWxfaWR4Owo+ICsJcmV0dXJuIDA7Cj4gICB9Cj4g
ICAKPiAgIHN0YXRpYyB1MzIgdmRwYXNpbV9nZXRfdnFfYWxpZ24oc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZHBhKQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhv
c3QvdmRwYS5jCj4gaW5kZXggYzJlMWUyZDU1MDg0Li5hMGI3YzkxOTQ4ZTEgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IEBA
IC0zOTIsNyArMzkyLDEwIEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdnJpbmdfaW9jdGwoc3Ry
dWN0IHZob3N0X3ZkcGEgKnYsIHVuc2lnbmVkIGludCBjbWQsCj4gICAJCW9wcy0+c2V0X3ZxX3Jl
YWR5KHZkcGEsIGlkeCwgcy5udW0pOwo+ICAgCQlyZXR1cm4gMDsKPiAgIAljYXNlIFZIT1NUX0dF
VF9WUklOR19CQVNFOgo+IC0JCW9wcy0+Z2V0X3ZxX3N0YXRlKHYtPnZkcGEsIGlkeCwgJnZxX3N0
YXRlKTsKPiArCQlyID0gb3BzLT5nZXRfdnFfc3RhdGUodi0+dmRwYSwgaWR4LCAmdnFfc3RhdGUp
Owo+ICsJCWlmIChyKQo+ICsJCQlyZXR1cm4gcjsKPiArCj4gICAJCXZxLT5sYXN0X2F2YWlsX2lk
eCA9IHZxX3N0YXRlLmF2YWlsX2luZGV4Owo+ICAgCQlicmVhazsKPiAgIAljYXNlIFZIT1NUX0dF
VF9CQUNLRU5EX0ZFQVRVUkVTOgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBi
L2luY2x1ZGUvbGludXgvdmRwYS5oCj4gaW5kZXggOGY0MTI2MjAwNzFkLi5mZDZlNTYwZDcwZjkg
MTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4
L3ZkcGEuaAo+IEBAIC0xOTIsOCArMTkyLDggQEAgc3RydWN0IHZkcGFfY29uZmlnX29wcyB7Cj4g
ICAJYm9vbCAoKmdldF92cV9yZWFkeSkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4
KTsKPiAgIAlpbnQgKCpzZXRfdnFfc3RhdGUpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2
IGlkeCwKPiAgIAkJCSAgICBjb25zdCBzdHJ1Y3QgdmRwYV92cV9zdGF0ZSAqc3RhdGUpOwo+IC0J
dm9pZCAoKmdldF92cV9zdGF0ZSkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4LAo+
IC0JCQkgICAgIHN0cnVjdCB2ZHBhX3ZxX3N0YXRlICpzdGF0ZSk7Cj4gKwlpbnQgKCpnZXRfdnFf
c3RhdGUpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCwKPiArCQkJICAgIHN0cnVj
dCB2ZHBhX3ZxX3N0YXRlICpzdGF0ZSk7Cj4gICAJc3RydWN0IHZkcGFfbm90aWZpY2F0aW9uX2Fy
ZWEKPiAgIAkoKmdldF92cV9ub3RpZmljYXRpb24pKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwg
dTE2IGlkeCk7Cj4gICAJaW50ICgqZ2V0X3ZxX2lycSkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHYs
IHUxNiBpZHgpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
