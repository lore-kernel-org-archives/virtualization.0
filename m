Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E13AC47092
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 02:11:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A726139A
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 02:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A726139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3ABE6063F;
	Wed,  2 Jun 2021 02:11:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k3Q--PdjJ0BN; Wed,  2 Jun 2021 02:11:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43D066062F;
	Wed,  2 Jun 2021 02:11:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A552C000D;
	Wed,  2 Jun 2021 02:11:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA6E0C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 02:11:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9CA2E40249
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 02:11:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ph07bfkrAgCO
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 02:11:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A16D40236
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 02:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622599907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZVFPtcnihzw6Crkb+n7RJjTscY9buzOxvek+kEcgCo=;
 b=iJYsArkuXGrt8fgAI1VT07R6JPu075ZTO0hF6VS8U9ESOeS7TLf3AYxxjGehwdvSCitmDv
 U8Rxm6NLXr5C5kJiyRocNbQpOslm/gMzm5vaFgBi7rzdhFQVyYZRAObwJ2YVe7Z3yF+F2j
 YHx1jAQ2Mhbj4pI2141mDwx+9XsaIRs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-6Rzabc09MFO5sR5JuZkOCw-1; Tue, 01 Jun 2021 22:11:46 -0400
X-MC-Unique: 6Rzabc09MFO5sR5JuZkOCw-1
Received: by mail-pg1-f199.google.com with SMTP id
 w21-20020a637b150000b029021ff120107fso698916pgc.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Jun 2021 19:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=lZVFPtcnihzw6Crkb+n7RJjTscY9buzOxvek+kEcgCo=;
 b=aTZZa0+YpM3xTjN4I8TsDsVec+zlxyf+QopLBRuYSCW3c8S3eHTn0cKs64phVeEHKI
 1YGax9iqOTaH1MwqJidi2XZdWqvvG0ZloxMbSClt5+1o5wdLJdpyDrXPql9b16DTs+2/
 T9xrgjSQhFZIAXDInbkARvj+QwvGitmbp946twvmY2a1s3BrCvUXTLexrrNlgRgNFcvt
 x5ek8RPM+uI57Y49MWocRD3epGyLCIMZHH9HJw8xZAnHW3H2AeP97o0f7ExpdvPeb308
 yd4YcSgnYE0Ih4gXrLsnkRPlnwPM77HGh2mX76Hx97vMvJO1XUFxadMnd1Vkl/pBfWao
 kGXg==
X-Gm-Message-State: AOAM531jFrxfoq+PeslyMZSRSOaelfTjC4vMXT7hV47ioVZcVaJsEIZv
 FzD6bHOE1k19Rqu5EXr95nxAEzqUZboWW5EsKC6LGUrfiOdJ9keaGyq0WSrw8ZZgTBleScIj5eF
 +qvBAQ9zVYC8X/mxS7PiAN4FtbsTRsvPz2iHNpKFa7w==
X-Received: by 2002:a17:90a:9411:: with SMTP id
 r17mr27751154pjo.49.1622599904796; 
 Tue, 01 Jun 2021 19:11:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7jaPg4i0ubXcEyXL3E/szYzG3vyar8Ms/jhzMDyREusEWUIsRPjx8+473wjnPnqHfhg3W0Q==
X-Received: by 2002:a17:90a:9411:: with SMTP id
 r17mr27751135pjo.49.1622599904510; 
 Tue, 01 Jun 2021 19:11:44 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w2sm14759633pjq.5.2021.06.01.19.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jun 2021 19:11:43 -0700 (PDT)
Subject: Re: [PATCH 1/4] vdpa: support packed virtqueue for set/get_vq_state()
To: Eli Cohen <elic@nvidia.com>
References: <20210601084503.34724-1-jasowang@redhat.com>
 <20210601084503.34724-2-jasowang@redhat.com>
 <20210601104711.GD215954@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <da410b5f-8603-8aa5-d2c7-89bf06a40de3@redhat.com>
Date: Wed, 2 Jun 2021 10:11:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601104711.GD215954@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eli@mellanox.com
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

CtTaIDIwMjEvNi8xIM/Czuc2OjQ3LCBFbGkgQ29oZW4g0LS1wDoKPiBPbiBUdWUsIEp1biAwMSwg
MjAyMSBhdCAwNDo0NTowMFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBUaGlzIHBhdGNo
IGV4dGVuZHMgdGhlIHZkcGFfdnFfc3RhdGUgdG8gc3VwcG9ydCBwYWNrZWQgdmlydHF1ZXVlCj4+
IHN0YXRlIHdoaWNoIGlzIGJhc2ljYWxseSB0aGUgZGV2aWNlL2RyaXZlciByaW5nIHdyYXAgY291
bnRlcnMgYW5kIHRoZQo+PiBhdmFpbCBhbmQgdXNlZCBpbmRleC4gVGhpcyB3aWxsIGJlIHVzZWQg
Zm9yIHRoZSB2aXJpdG8tdmRwYSBzdXBwb3J0Cj4+IGZvciB0aGUgcGFja2VkIHZpcnRxdWV1ZSBh
bmQgdGhlIGZ1dHVyZSB2aG9zdC92aG9zdC12ZHBhIHN1cHBvcnQgZm9yCj4+IHRoZSBwYWNrZWQg
dmlydHF1ZXVlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPgo+IFlvdSBjaGFuZ2VkIGludGVyZmFjZSBidXQgZGlkIG5vdCBtb2RpZnkgbWx4NS4g
RG9lcyB0aGlzIGNvbXBpbGUgb24geW91cgo+IHN5c3RlbT8KCgpZZXMgYnV0IEknbSB1c2luZyBh
IG1pbmltYWwgY29uZmlnIHdpdGhvdXQgbWx4NSBlbmFibGVkIDooCgpWMiBpcyBwb3N0ZWQuCgpU
aGFua3MKCgo+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgIHwg
IDQgKystLQo+PiAgIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIHwgIDQgKystLQo+
PiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAgICAgICAgIHwgIDQgKystLQo+PiAgIGluY2x1
ZGUvbGludXgvdmRwYS5oICAgICAgICAgICAgIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKyst
LQo+PiAgIDQgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkK
Pj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgYi9kcml2
ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+IGluZGV4IGFiMGFiNWNmMGY2ZS4uNWQzODkx
YjFjYTI4IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+
ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4gQEAgLTI2NCw3ICsyNjQs
NyBAQCBzdGF0aWMgaW50IGlmY3ZmX3ZkcGFfZ2V0X3ZxX3N0YXRlKHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRwYV9kZXYsIHUxNiBxaWQsCj4+ICAgewo+PiAgIAlzdHJ1Y3QgaWZjdmZfaHcgKnZmID0g
dmRwYV90b192Zih2ZHBhX2Rldik7Cj4+ICAgCj4+IC0Jc3RhdGUtPmF2YWlsX2luZGV4ID0gaWZj
dmZfZ2V0X3ZxX3N0YXRlKHZmLCBxaWQpOwo+PiArCXN0YXRlLT5zcGxpdC5hdmFpbF9pbmRleCA9
IGlmY3ZmX2dldF92cV9zdGF0ZSh2ZiwgcWlkKTsKPj4gICAJcmV0dXJuIDA7Cj4+ICAgfQo+PiAg
IAo+PiBAQCAtMjczLDcgKzI3Myw3IEBAIHN0YXRpYyBpbnQgaWZjdmZfdmRwYV9zZXRfdnFfc3Rh
dGUoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldiwgdTE2IHFpZCwKPj4gICB7Cj4+ICAgCXN0
cnVjdCBpZmN2Zl9odyAqdmYgPSB2ZHBhX3RvX3ZmKHZkcGFfZGV2KTsKPj4gICAKPj4gLQlyZXR1
cm4gaWZjdmZfc2V0X3ZxX3N0YXRlKHZmLCBxaWQsIHN0YXRlLT5hdmFpbF9pbmRleCk7Cj4+ICsJ
cmV0dXJuIGlmY3ZmX3NldF92cV9zdGF0ZSh2ZiwgcWlkLCBzdGF0ZS0+c3BsaXQuYXZhaWxfaW5k
ZXgpOwo+PiAgIH0KPj4gICAKPj4gICBzdGF0aWMgdm9pZCBpZmN2Zl92ZHBhX3NldF92cV9jYihz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2LCB1MTYgcWlkLAo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRw
YV9zaW0uYwo+PiBpbmRleCA5OGY3OTNiYzkzNzYuLjE0ZTAyNGRlNWNiZiAxMDA2NDQKPj4gLS0t
IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPj4gKysrIGIvZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPj4gQEAgLTM3NCw3ICszNzQsNyBAQCBzdGF0aWMgaW50IHZk
cGFzaW1fc2V0X3ZxX3N0YXRlKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwgdTE2IGlkeCwKPj4g
ICAJc3RydWN0IHZyaW5naCAqdnJoID0gJnZxLT52cmluZzsKPj4gICAKPj4gICAJc3Bpbl9sb2Nr
KCZ2ZHBhc2ltLT5sb2NrKTsKPj4gLQl2cmgtPmxhc3RfYXZhaWxfaWR4ID0gc3RhdGUtPmF2YWls
X2luZGV4Owo+PiArCXZyaC0+bGFzdF9hdmFpbF9pZHggPSBzdGF0ZS0+c3BsaXQuYXZhaWxfaW5k
ZXg7Cj4+ICAgCXNwaW5fdW5sb2NrKCZ2ZHBhc2ltLT5sb2NrKTsKPj4gICAKPj4gICAJcmV0dXJu
IDA7Cj4+IEBAIC0zODcsNyArMzg3LDcgQEAgc3RhdGljIGludCB2ZHBhc2ltX2dldF92cV9zdGF0
ZShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHUxNiBpZHgsCj4+ICAgCXN0cnVjdCB2ZHBhc2lt
X3ZpcnRxdWV1ZSAqdnEgPSAmdmRwYXNpbS0+dnFzW2lkeF07Cj4+ICAgCXN0cnVjdCB2cmluZ2gg
KnZyaCA9ICZ2cS0+dnJpbmc7Cj4+ICAgCj4+IC0Jc3RhdGUtPmF2YWlsX2luZGV4ID0gdnJoLT5s
YXN0X2F2YWlsX2lkeDsKPj4gKwlzdGF0ZS0+c3BsaXQuYXZhaWxfaW5kZXggPSB2cmgtPmxhc3Rf
YXZhaWxfaWR4Owo+PiAgIAlyZXR1cm4gMDsKPj4gICB9Cj4+ICAgCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+IGluZGV4IGZiNDFk
YjNkYTYxMS4uMjEwYWIzNWE3ZWJmIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEu
Ywo+PiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+PiBAQCAtMzgzLDcgKzM4Myw3IEBAIHN0
YXRpYyBsb25nIHZob3N0X3ZkcGFfdnJpbmdfaW9jdGwoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHVu
c2lnbmVkIGludCBjbWQsCj4+ICAgCQlpZiAocikKPj4gICAJCQlyZXR1cm4gcjsKPj4gICAKPj4g
LQkJdnEtPmxhc3RfYXZhaWxfaWR4ID0gdnFfc3RhdGUuYXZhaWxfaW5kZXg7Cj4+ICsJCXZxLT5s
YXN0X2F2YWlsX2lkeCA9IHZxX3N0YXRlLnNwbGl0LmF2YWlsX2luZGV4Owo+PiAgIAkJYnJlYWs7
Cj4+ICAgCX0KPj4gICAKPj4gQEAgLTQwMSw3ICs0MDEsNyBAQCBzdGF0aWMgbG9uZyB2aG9zdF92
ZHBhX3ZyaW5nX2lvY3RsKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1bnNpZ25lZCBpbnQgY21kLAo+
PiAgIAkJYnJlYWs7Cj4+ICAgCj4+ICAgCWNhc2UgVkhPU1RfU0VUX1ZSSU5HX0JBU0U6Cj4+IC0J
CXZxX3N0YXRlLmF2YWlsX2luZGV4ID0gdnEtPmxhc3RfYXZhaWxfaWR4Owo+PiArCQl2cV9zdGF0
ZS5zcGxpdC5hdmFpbF9pbmRleCA9IHZxLT5sYXN0X2F2YWlsX2lkeDsKPj4gICAJCWlmIChvcHMt
PnNldF92cV9zdGF0ZSh2ZHBhLCBpZHgsICZ2cV9zdGF0ZSkpCj4+ICAgCQkJciA9IC1FSU5WQUw7
Cj4+ICAgCQlicmVhazsKPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5j
bHVkZS9saW51eC92ZHBhLmgKPj4gaW5kZXggZjMxMWQyMjdhYTFiLi4zMzU3YWM5ODg3OGQgMTAw
NjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvdmRwYS5oCj4+ICsrKyBiL2luY2x1ZGUvbGludXgv
dmRwYS5oCj4+IEBAIC0yOCwxMyArMjgsMzQgQEAgc3RydWN0IHZkcGFfbm90aWZpY2F0aW9uX2Fy
ZWEgewo+PiAgIH07Cj4+ICAgCj4+ICAgLyoqCj4+IC0gKiBzdHJ1Y3QgdmRwYV92cV9zdGF0ZSAt
IHZEUEEgdnFfc3RhdGUgZGVmaW5pdGlvbgo+PiArICogc3RydWN0IHZkcGFfdnFfc3RhdGVfc3Bs
aXQgLSB2RFBBIHNwbGl0IHZpcnRxdWV1ZSBzdGF0ZQo+PiAgICAqIEBhdmFpbF9pbmRleDogYXZh
aWxhYmxlIGluZGV4Cj4+ICAgICovCj4+IC1zdHJ1Y3QgdmRwYV92cV9zdGF0ZSB7Cj4+ICtzdHJ1
Y3QgdmRwYV92cV9zdGF0ZV9zcGxpdCB7Cj4+ICAgCXUxNglhdmFpbF9pbmRleDsKPj4gICB9Owo+
PiAgIAo+PiArLyoqCj4+ICsgKiBzdHJ1Y3QgdmRwYV92cV9zdGF0ZV9wYWNrZWQgLSB2RFBBIHBh
Y2tlZCB2aXJ0cXVldWUgc3RhdGUKPj4gKyAqIEBsYXN0X2F2YWlsX2NvdW50ZXI6IGxhc3QgZHJp
dmVyIHJpbmcgd3JhcCBjb3VudGVyIG9ic2VydmVkIGJ5IGRldmljZQo+PiArICogQGxhc3RfYXZh
aWxfaWR4OiBkZXZpY2UgYXZhaWxhYmxlIGluZGV4Cj4+ICsgKiBAbGFzdF91c2VkX2NvdW50ZXI6
IGRldmljZSByaW5nIHdyYXAgY291bnRlcgo+PiArICogQGxhc3RfdXNlZF9pZHg6IHVzZWQgaW5k
ZXgKPj4gKyAqLwo+PiArc3RydWN0IHZkcGFfdnFfc3RhdGVfcGFja2VkIHsKPj4gKyAgICAgICAg
dTE2CWxhc3RfYXZhaWxfY291bnRlcjoxOwo+PiArICAgICAgICB1MTYJbGFzdF9hdmFpbF9pZHg6
MTU7Cj4+ICsgICAgICAgIHUxNglsYXN0X3VzZWRfY291bnRlcjoxOwo+PiArICAgICAgICB1MTYJ
bGFzdF91c2VkX2lkeDoxNTsKPj4gK307Cj4+ICsKPj4gK3N0cnVjdCB2ZHBhX3ZxX3N0YXRlIHsK
Pj4gKyAgICAgdW5pb24gewo+PiArICAgICAgICAgIHN0cnVjdCB2ZHBhX3ZxX3N0YXRlX3NwbGl0
IHNwbGl0Owo+PiArICAgICAgICAgIHN0cnVjdCB2ZHBhX3ZxX3N0YXRlX3BhY2tlZCBwYWNrZWQ7
Cj4+ICsgICAgIH07Cj4+ICt9Owo+PiArCj4+ICAgc3RydWN0IHZkcGFfbWdtdF9kZXY7Cj4+ICAg
Cj4+ICAgLyoqCj4+IC0tIAo+PiAyLjI1LjEKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
