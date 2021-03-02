Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD572C433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 04:05:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BEC1614A7
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 04:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BEC1614A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D555C42C27;
	Tue,  2 Mar 2021 04:05:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BHI8Qt9irOc0; Tue,  2 Mar 2021 04:05:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7FA7740025;
	Tue,  2 Mar 2021 04:05:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6444EC000A;
	Tue,  2 Mar 2021 04:05:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8255C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 04:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BBE6C4EF68
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 04:05:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kJ51eQhHDI-8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 04:05:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A02D54B33B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 04:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614657946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AiqlnBbL124RbFr+ZWPEGMV28LDKcaWTVjjFw6NK3tk=;
 b=IcpbLi6pbx7tXg8V1zCZNZHg/VqgW0379ZAxGz1km3KG/Af3u5L7sE4vgY5jL3/vKXd7nR
 WJnG0gQfqhCI0e7zHGQ7cKO4iI8pmbZJsUFGZFCntMTzY+hLWmuBkgme1qWG0GnOfKlXqw
 LzmTyvgeDRuCkQVH3FqHH+vcem8QXWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-Z7l6R31lOImEgMGWxzuctg-1; Mon, 01 Mar 2021 23:05:43 -0500
X-MC-Unique: Z7l6R31lOImEgMGWxzuctg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BCDC107ACE3;
 Tue,  2 Mar 2021 04:05:42 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-215.pek2.redhat.com
 [10.72.13.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4F5E1A7D9;
 Tue,  2 Mar 2021 04:05:37 +0000 (UTC)
Subject: Re: [RFC PATCH 10/10] vhost/vdpa: return configuration bytes read and
 written to user space
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210216094454.82106-1-sgarzare@redhat.com>
 <20210216094454.82106-11-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4d682ff2-9663-d6ac-d5bf-616b2bf96e1a@redhat.com>
Date: Tue, 2 Mar 2021 12:05:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210216094454.82106-11-sgarzare@redhat.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Ck9uIDIwMjEvMi8xNiA1OjQ0IOS4i+WNiCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IHZk
cGFfZ2V0X2NvbmZpZygpIGFuZCB2ZHBhX3NldF9jb25maWcoKSBub3cgcmV0dXJuIHRoZSBhbW91
bnQKPiBvZiBieXRlcyByZWFkIGFuZCB3cml0dGVuLCBzbyBsZXQncyByZXR1cm4gdGhlbSB0byB0
aGUgdXNlciBzcGFjZS4KPgo+IFdlIGFsc28gbW9kaWZ5IHZob3N0X3ZkcGFfY29uZmlnX3ZhbGlk
YXRlKCkgdG8gcmV0dXJuIDAgKGJ5dGVzIHJlYWQKPiBvciB3cml0dGVuKSBpbnN0ZWFkIG9mIGFu
IGVycm9yLCB3aGVuIHRoZSBidWZmZXIgbGVuZ3RoIGlzIDAuCj4KPiBTaWduZWQtb2ZmLWJ5OiBT
dGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4gLS0tCj4gICBkcml2ZXJz
L3Zob3N0L3ZkcGEuYyB8IDI2ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IGluZGV4IDIx
ZWVhMmJlNWFmYS4uYjc1NGM1MzE3MWE3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRw
YS5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBAQCAtMTkxLDkgKzE5MSw2IEBAIHN0
YXRpYyBzc2l6ZV90IHZob3N0X3ZkcGFfY29uZmlnX3ZhbGlkYXRlKHN0cnVjdCB2aG9zdF92ZHBh
ICp2LAo+ICAgCXN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4gICAJdTMyIHNp
emUgPSB2ZHBhLT5jb25maWctPmdldF9jb25maWdfc2l6ZSh2ZHBhKTsKPiAgIAo+IC0JaWYgKGMt
PmxlbiA9PSAwKQo+IC0JCXJldHVybiAtRUlOVkFMOwo+IC0KPiAgIAlyZXR1cm4gbWluKGMtPmxl
biwgc2l6ZSk7Cj4gICB9Cj4gICAKPiBAQCAtMjA0LDYgKzIwMSw3IEBAIHN0YXRpYyBsb25nIHZo
b3N0X3ZkcGFfZ2V0X2NvbmZpZyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiAgIAlzdHJ1Y3Qgdmhv
c3RfdmRwYV9jb25maWcgY29uZmlnOwo+ICAgCXVuc2lnbmVkIGxvbmcgc2l6ZSA9IG9mZnNldG9m
KHN0cnVjdCB2aG9zdF92ZHBhX2NvbmZpZywgYnVmKTsKPiAgIAlzc2l6ZV90IGNvbmZpZ19zaXpl
Owo+ICsJbG9uZyByZXQ7Cj4gICAJdTggKmJ1ZjsKPiAgIAo+ICAgCWlmIChjb3B5X2Zyb21fdXNl
cigmY29uZmlnLCBjLCBzaXplKSkKPiBAQCAtMjE3LDE1ICsyMTUsMTggQEAgc3RhdGljIGxvbmcg
dmhvc3RfdmRwYV9nZXRfY29uZmlnKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+ICAgCWlmICghYnVm
KQo+ICAgCQlyZXR1cm4gLUVOT01FTTsKPiAgIAo+IC0JdmRwYV9nZXRfY29uZmlnKHZkcGEsIGNv
bmZpZy5vZmYsIGJ1ZiwgY29uZmlnX3NpemUpOwo+IC0KPiAtCWlmIChjb3B5X3RvX3VzZXIoYy0+
YnVmLCBidWYsIGNvbmZpZ19zaXplKSkgewo+IC0JCWt2ZnJlZShidWYpOwo+IC0JCXJldHVybiAt
RUZBVUxUOwo+ICsJcmV0ID0gdmRwYV9nZXRfY29uZmlnKHZkcGEsIGNvbmZpZy5vZmYsIGJ1Ziwg
Y29uZmlnX3NpemUpOwo+ICsJaWYgKHJldCA8IDApIHsKPiArCQlyZXQgPSAtRUZBVUxUOwo+ICsJ
CWdvdG8gb3V0Owo+ICAgCX0KPiAgIAo+ICsJaWYgKGNvcHlfdG9fdXNlcihjLT5idWYsIGJ1Ziwg
Y29uZmlnX3NpemUpKQo+ICsJCXJldCA9IC1FRkFVTFQ7Cj4gKwo+ICtvdXQ6Cj4gICAJa3ZmcmVl
KGJ1Zik7Cj4gLQlyZXR1cm4gMDsKPiArCXJldHVybiByZXQ7Cj4gICB9Cj4gICAKPiAgIHN0YXRp
YyBsb25nIHZob3N0X3ZkcGFfc2V0X2NvbmZpZyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiBAQCAt
MjM1LDYgKzIzNiw3IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0X2NvbmZpZyhzdHJ1Y3Qg
dmhvc3RfdmRwYSAqdiwKPiAgIAlzdHJ1Y3Qgdmhvc3RfdmRwYV9jb25maWcgY29uZmlnOwo+ICAg
CXVuc2lnbmVkIGxvbmcgc2l6ZSA9IG9mZnNldG9mKHN0cnVjdCB2aG9zdF92ZHBhX2NvbmZpZywg
YnVmKTsKPiAgIAlzc2l6ZV90IGNvbmZpZ19zaXplOwo+ICsJbG9uZyByZXQ7Cj4gICAJdTggKmJ1
ZjsKPiAgIAo+ICAgCWlmIChjb3B5X2Zyb21fdXNlcigmY29uZmlnLCBjLCBzaXplKSkKPiBAQCAt
MjQ4LDEwICsyNTAsMTIgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9zZXRfY29uZmlnKHN0cnVj
dCB2aG9zdF92ZHBhICp2LAo+ICAgCWlmIChJU19FUlIoYnVmKSkKPiAgIAkJcmV0dXJuIFBUUl9F
UlIoYnVmKTsKPiAgIAo+IC0JdmRwYV9zZXRfY29uZmlnKHZkcGEsIGNvbmZpZy5vZmYsIGJ1Ziwg
Y29uZmlnX3NpemUpOwo+ICsJcmV0ID0gdmRwYV9zZXRfY29uZmlnKHZkcGEsIGNvbmZpZy5vZmYs
IGJ1ZiwgY29uZmlnX3NpemUpOwo+ICsJaWYgKHJldCA8IDApCj4gKwkJcmV0ID0gLUVGQVVMVDsK
PiAgIAo+ICAgCWt2ZnJlZShidWYpOwo+IC0JcmV0dXJuIDA7Cj4gKwlyZXR1cm4gcmV0Owo+ICAg
fQoKClNvIEkgd29uZGVyIHdoZXRoZXIgaXQncyB3b3J0aCB0byByZXR1cm4gdGhlIG51bWJlciBv
ZiBieXRlcyBzaW5jZSB3ZSAKY2FuJ3QgcHJvcG9nYXRlIHRoZSByZXN1bHQgdG8gZHJpdmVyIG9y
IGRyaXZlciBkb2Vzbid0IGNhcmUgYWJvdXQgdGhhdC4KClRoYW5rcwoKCj4gICAKPiAgIHN0YXRp
YyBsb25nIHZob3N0X3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1NjQg
X191c2VyICpmZWF0dXJlcCkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
