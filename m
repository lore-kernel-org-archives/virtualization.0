Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51620C433DB
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 03:27:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8535E64F92
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 03:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8535E64F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 272CF872D7;
	Fri,  5 Feb 2021 03:27:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hPoCFPj4D0MH; Fri,  5 Feb 2021 03:27:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7A334872BF;
	Fri,  5 Feb 2021 03:27:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EA54C07FD;
	Fri,  5 Feb 2021 03:27:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DA58C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 62859872D6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:27:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g-L2SpSrXJ-F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:27:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6F566872BF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612495669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j6n+ZLbkq+mLCc6aBqP6EMe2QS0ih77l0I/R5zi2Q/k=;
 b=hNIOuusE0v0u5dbg2LhTUG8zoJTVbHGni45640C8V7VwYsu1jm8UYjczKryB/IqMnvbgvL
 nL/NOliuJlw6ZfzJr7Ur7eDlpfOqhqPUUrs2cM/DOjacqOW7ghQtoW07Eo3YBM7H7zdqsZ
 AcefRoqjepO+uAejLQ06c+Xf8s8CPRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-GXHq2iLTMEGLcKpW42pIgQ-1; Thu, 04 Feb 2021 22:27:45 -0500
X-MC-Unique: GXHq2iLTMEGLcKpW42pIgQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 171DE195D560;
 Fri,  5 Feb 2021 03:27:44 +0000 (UTC)
Received: from [10.72.12.112] (ovpn-12-112.pek2.redhat.com [10.72.12.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90BAA60937;
 Fri,  5 Feb 2021 03:27:33 +0000 (UTC)
Subject: Re: [PATCH v3 09/13] vhost/vdpa: remove vhost_vdpa_config_validate()
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210204172230.85853-1-sgarzare@redhat.com>
 <20210204172230.85853-10-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6919d2d4-cc8e-2b67-2385-35803de5e38b@redhat.com>
Date: Fri, 5 Feb 2021 11:27:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210204172230.85853-10-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

Ck9uIDIwMjEvMi81IOS4iuWNiDE6MjIsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBnZXRf
Y29uZmlnKCkgYW5kIHNldF9jb25maWcoKSBjYWxsYmFja3MgaW4gdGhlICdzdHJ1Y3QgdmRwYV9j
b25maWdfb3BzJwo+IHVzdWFsbHkgYWxyZWFkeSB2YWxpZGF0ZWQgdGhlIGlucHV0cy4gQWxzbyBu
b3cgdGhleSBjYW4gcmV0dXJuIGFuIGVycm9yLAo+IHNvIHdlIGRvbid0IG5lZWQgdG8gdmFsaWRh
dGUgdGhlbSBoZXJlIGFueW1vcmUuCj4KPiBMZXQncyB1c2UgdGhlIHJldHVybiB2YWx1ZSBvZiB0
aGVzZSBjYWxsYmFja3MgYW5kIHJldHVybiBpdCBpbiBjYXNlIG9mCj4gZXJyb3IgaW4gdmhvc3Rf
dmRwYV9nZXRfY29uZmlnKCkgYW5kIHZob3N0X3ZkcGFfc2V0X2NvbmZpZygpLgo+Cj4gT3JpZ2lu
YWxseS1ieTogWGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5dGVkYW5jZS5jb20+Cj4gU2lnbmVkLW9m
Zi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+IC0tLQo+ICAg
ZHJpdmVycy92aG9zdC92ZHBhLmMgfCA0MSArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDI4IGRlbGV0
aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92
aG9zdC92ZHBhLmMKPiBpbmRleCBlZjY4OGM4YzBlMGUuLmQ2MWU3NzkwMDBhOCAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4g
QEAgLTE4NSw1MSArMTg1LDM1IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0X3N0YXR1cyhz
dHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTggX191c2VyICpzdGF0dXNwKQo+ICAgCXJldHVybiAwOwo+
ICAgfQo+ICAgCj4gLXN0YXRpYyBpbnQgdmhvc3RfdmRwYV9jb25maWdfdmFsaWRhdGUoc3RydWN0
IHZob3N0X3ZkcGEgKnYsCj4gLQkJCQkgICAgICBzdHJ1Y3Qgdmhvc3RfdmRwYV9jb25maWcgKmMp
Cj4gLXsKPiAtCWxvbmcgc2l6ZSA9IDA7Cj4gLQo+IC0Jc3dpdGNoICh2LT52aXJ0aW9faWQpIHsK
PiAtCWNhc2UgVklSVElPX0lEX05FVDoKPiAtCQlzaXplID0gc2l6ZW9mKHN0cnVjdCB2aXJ0aW9f
bmV0X2NvbmZpZyk7Cj4gLQkJYnJlYWs7Cj4gLQl9Cj4gLQo+IC0JaWYgKGMtPmxlbiA9PSAwKQo+
IC0JCXJldHVybiAtRUlOVkFMOwo+IC0KPiAtCWlmIChjLT5sZW4gPiBzaXplIC0gYy0+b2ZmKQo+
IC0JCXJldHVybiAtRTJCSUc7Cj4gLQo+IC0JcmV0dXJuIDA7Cj4gLX0KPiAtCj4gICBzdGF0aWMg
bG9uZyB2aG9zdF92ZHBhX2dldF9jb25maWcoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gICAJCQkJ
ICBzdHJ1Y3Qgdmhvc3RfdmRwYV9jb25maWcgX191c2VyICpjKQo+ICAgewo+ICAgCXN0cnVjdCB2
ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4gICAJc3RydWN0IHZob3N0X3ZkcGFfY29uZmln
IGNvbmZpZzsKPiAgIAl1bnNpZ25lZCBsb25nIHNpemUgPSBvZmZzZXRvZihzdHJ1Y3Qgdmhvc3Rf
dmRwYV9jb25maWcsIGJ1Zik7Cj4gKwlsb25nIHJldDsKPiAgIAl1OCAqYnVmOwo+ICAgCj4gICAJ
aWYgKGNvcHlfZnJvbV91c2VyKCZjb25maWcsIGMsIHNpemUpKQo+ICAgCQlyZXR1cm4gLUVGQVVM
VDsKPiAtCWlmICh2aG9zdF92ZHBhX2NvbmZpZ192YWxpZGF0ZSh2LCAmY29uZmlnKSkKPiArCWlm
IChjb25maWcubGVuID09IDApCj4gICAJCXJldHVybiAtRUlOVkFMOwo+ICAgCWJ1ZiA9IGt2emFs
bG9jKGNvbmZpZy5sZW4sIEdGUF9LRVJORUwpOwoKClRoZW4gaXQgbWVhbnMgdXNlcnNhcGNlIGNh
biBhbGxvY2F0ZSBhIHZlcnkgbGFyZ2UgbWVtb3J5LgoKUmV0aGluayBhYm91dCB0aGlzLCB3ZSBz
aG91bGQgbGltaXQgdGhlIHNpemUgaGVyZSAoZS5nIFBBR0VfU0laRSkgb3IgCmZldGNoIHRoZSBj
b25maWcgc2l6ZSBmaXJzdCAoZWl0aGVyIHRocm91Z2ggYSBjb25maWcgb3BzIGFzIHlvdSAKc3Vn
Z2VzdGVkIG9yIGEgdmFyaWFibGUgaW4gdGhlIHZkcGEgZGV2aWNlIHRoYXQgaXMgaW5pdGlhbGl6
ZWQgZHVyaW5nIApkZXZpY2UgY3JlYXRpb24pLgoKVGhhbmtzCgo+ICAgCWlmICghYnVmKQo+ICAg
CQlyZXR1cm4gLUVOT01FTTsKPiAgIAo+IC0JdmRwYV9nZXRfY29uZmlnKHZkcGEsIGNvbmZpZy5v
ZmYsIGJ1ZiwgY29uZmlnLmxlbik7Cj4gKwlyZXQgPSB2ZHBhX2dldF9jb25maWcodmRwYSwgY29u
ZmlnLm9mZiwgYnVmLCBjb25maWcubGVuKTsKPiArCWlmIChyZXQpCj4gKwkJZ290byBvdXQ7Cj4g
ICAKPiAgIAlpZiAoY29weV90b191c2VyKGMtPmJ1ZiwgYnVmLCBjb25maWcubGVuKSkgewo+IC0J
CWt2ZnJlZShidWYpOwo+IC0JCXJldHVybiAtRUZBVUxUOwo+ICsJCXJldCA9IC1FRkFVTFQ7Cj4g
KwkJZ290byBvdXQ7Cj4gICAJfQo+ICAgCj4gK291dDoKPiAgIAlrdmZyZWUoYnVmKTsKPiAtCXJl
dHVybiAwOwo+ICsJcmV0dXJuIHJldDsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIGxvbmcgdmhvc3Rf
dmRwYV9zZXRfY29uZmlnKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+IEBAIC0yMzksMjEgKzIyMywy
MiBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3NldF9jb25maWcoc3RydWN0IHZob3N0X3ZkcGEg
KnYsCj4gICAJY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmln
Owo+ICAgCXN0cnVjdCB2aG9zdF92ZHBhX2NvbmZpZyBjb25maWc7Cj4gICAJdW5zaWduZWQgbG9u
ZyBzaXplID0gb2Zmc2V0b2Yoc3RydWN0IHZob3N0X3ZkcGFfY29uZmlnLCBidWYpOwo+ICsJbG9u
ZyByZXQ7Cj4gICAJdTggKmJ1ZjsKPiAgIAo+ICAgCWlmIChjb3B5X2Zyb21fdXNlcigmY29uZmln
LCBjLCBzaXplKSkKPiAgIAkJcmV0dXJuIC1FRkFVTFQ7Cj4gLQlpZiAodmhvc3RfdmRwYV9jb25m
aWdfdmFsaWRhdGUodiwgJmNvbmZpZykpCj4gKwlpZiAoY29uZmlnLmxlbiA9PSAwKQo+ICAgCQly
ZXR1cm4gLUVJTlZBTDsKPiAgIAo+ICAgCWJ1ZiA9IHZtZW1kdXBfdXNlcihjLT5idWYsIGNvbmZp
Zy5sZW4pOwo+ICAgCWlmIChJU19FUlIoYnVmKSkKPiAgIAkJcmV0dXJuIFBUUl9FUlIoYnVmKTsK
PiAgIAo+IC0Jb3BzLT5zZXRfY29uZmlnKHZkcGEsIGNvbmZpZy5vZmYsIGJ1ZiwgY29uZmlnLmxl
bik7Cj4gKwlyZXQgPSBvcHMtPnNldF9jb25maWcodmRwYSwgY29uZmlnLm9mZiwgYnVmLCBjb25m
aWcubGVuKTsKPiAgIAo+ICAgCWt2ZnJlZShidWYpOwo+IC0JcmV0dXJuIDA7Cj4gKwlyZXR1cm4g
cmV0Owo+ICAgfQo+ICAgCj4gICBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX2dldF9mZWF0dXJlcyhz
dHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTY0IF9fdXNlciAqZmVhdHVyZXApCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
