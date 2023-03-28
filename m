Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060C4C76195
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 06:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E28F81F9A;
	Tue, 28 Mar 2023 06:14:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E28F81F9A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hQb2tdOb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LToBY1EAfIrk; Tue, 28 Mar 2023 06:14:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0F30181F95;
	Tue, 28 Mar 2023 06:14:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F30181F95
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9309C0036;
	Tue, 28 Mar 2023 06:14:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B625FC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 823CF41825
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:14:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 823CF41825
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hQb2tdOb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ukwwGr3c1L2u
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:14:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 624274180F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 624274180F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679984055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDqF1GrbzQq1+HPSvJYRs4W/bqOwDA7041P8KA7sUJw=;
 b=hQb2tdObMHzFsjULAbtOlZV976wgEgjW1srp7kHgyTZb1lgfzSz0Tsoa7hjmHZs2Xf3qUT
 VcAHmjUqJNf3YlbpvkTh3ofHUoxIWvO7WZJKV7vwORC62FK0DHBHjRe4hvML7LpXIwbMfw
 aPTSizRyWtjkINqTFIQkNhZz8JKP2Lw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-HnC50B0aOdScjq2SQhbLlQ-1; Tue, 28 Mar 2023 02:14:13 -0400
X-MC-Unique: HnC50B0aOdScjq2SQhbLlQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 z14-20020a170903018e00b001a1a2bee58dso7047289plg.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 23:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679984052;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UDqF1GrbzQq1+HPSvJYRs4W/bqOwDA7041P8KA7sUJw=;
 b=qZMQmvH51rkOnThEV6T8XrYcBmYVwR1R5Zcz7ee8RS+b8EkUlZ7WZk0A2JcCF5gHyV
 s7Gws5oucf9/M2iPXI8gPZLVS+Rn9lX/3eLNroxH+fn7Gxd7vPPJwC5PwcPbkoiSWZQ5
 8DbFvlw0z7oRBCrowlVsNYtRavohvzCyTM474j/k9qfvtn7G3Nn4kE6XxqrJjERTge9+
 c8sP4wV9VDHDnKj5/nfj/p3SuwVZQXSmB0fki2GbbsWLQi0zmWXekvV0GYX6Yr8Syq5b
 ZUYD+z2hnP0MdWookbfTvTLI8VoL5j2TaHqsDT0WD4hGRVqZsmNloDUNCyPql6aCm+R8
 hXCA==
X-Gm-Message-State: AAQBX9cs/iP2rk2mrEoPtSDS5U9+Dli1ci0J2QT4mnLD7LGDZKbWF4ql
 a5BNwvzVFZN+G4K3QbEMCg5Mc6uSVVv5qDWTb/5UGpGQ2Lo8faoU/UsOorqE7nxRMqbFEppKQ2c
 MQeeG9plhhY1an8ffQXMpWnt2tPlDSFcdlyw4Et1geA==
X-Received: by 2002:a17:903:410c:b0:1a2:62d7:8c2a with SMTP id
 r12-20020a170903410c00b001a262d78c2amr998872pld.11.1679984052577; 
 Mon, 27 Mar 2023 23:14:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350YCxm+v8tsCs7SvvbxdQdgSa17TenhAG4E2V0AMUT3eHfgR8foPhJ00O1N7zmi2Sqbt6+LHxQ==
X-Received: by 2002:a17:903:410c:b0:1a2:62d7:8c2a with SMTP id
 r12-20020a170903410c00b001a262d78c2amr998855pld.11.1679984052141; 
 Mon, 27 Mar 2023 23:14:12 -0700 (PDT)
Received: from [10.72.13.204] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a1709026b8800b0019ab151eb90sm2552767plk.139.2023.03.27.23.14.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Mar 2023 23:14:11 -0700 (PDT)
Message-ID: <54ac21bb-4a11-13c3-c341-73744138f386@redhat.com>
Date: Tue, 28 Mar 2023 14:14:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v4 05/11] vduse: Support set_vq_affinity callback
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com, tglx@linutronix.de, 
 hch@lst.de
References: <20230323053043.35-1-xieyongji@bytedance.com>
 <20230323053043.35-6-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230323053043.35-6-xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIzLzMvMjMgMTM6MzAsIFhpZSBZb25namkg5YaZ6YGTOgo+IFNpbmNlIHZpcnRpby12
ZHBhIGJ1cyBkcml2ZXIgYWxyZWFkeSBzdXBwb3J0IGludGVycnVwdAo+IGFmZmluaXR5IHNwcmVh
ZGluZyBtZWNoYW5pc20sIGxldCdzIGltcGxlbWVudCB0aGUKPiBzZXRfdnFfYWZmaW5pdHkgY2Fs
bGJhY2sgdG8gYnJpbmcgaXQgdG8gdmR1c2UgZGV2aWNlLgo+IEFmdGVyIHdlIGdldCB0aGUgdmly
dHF1ZXVlJ3MgYWZmaW5pdHksIHdlIGNhbiBzcHJlYWQKPiBJUlFzIGJldHdlZW4gQ1BVcyBpbiB0
aGUgYWZmaW5pdHkgbWFzaywgaW4gYSByb3VuZC1yb2Jpbgo+IG1hbm5lciwgdG8gcnVuIHRoZSBp
cnEgY2FsbGJhY2suCj4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0
ZWRhbmNlLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4K
ClRoYW5rcwoKCj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jIHwg
NjEgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNTQg
aW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zk
cGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9k
ZXYuYwo+IGluZGV4IDk4MzU5ZDg3YTA2Zi4uNDVhYTg3MDNjNGI1IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRw
YV91c2VyL3ZkdXNlX2Rldi5jCj4gQEAgLTQxLDYgKzQxLDggQEAKPiAgICNkZWZpbmUgVkRVU0Vf
SU9WQV9TSVpFICgxMjggKiAxMDI0ICogMTAyNCkKPiAgICNkZWZpbmUgVkRVU0VfTVNHX0RFRkFV
TFRfVElNRU9VVCAzMAo+ICAgCj4gKyNkZWZpbmUgSVJRX1VOQk9VTkQgLTEKPiArCj4gICBzdHJ1
Y3QgdmR1c2VfdmlydHF1ZXVlIHsKPiAgIAl1MTYgaW5kZXg7Cj4gICAJdTE2IG51bV9tYXg7Cj4g
QEAgLTU3LDYgKzU5LDggQEAgc3RydWN0IHZkdXNlX3ZpcnRxdWV1ZSB7Cj4gICAJc3RydWN0IHZk
cGFfY2FsbGJhY2sgY2I7Cj4gICAJc3RydWN0IHdvcmtfc3RydWN0IGluamVjdDsKPiAgIAlzdHJ1
Y3Qgd29ya19zdHJ1Y3Qga2ljazsKPiArCWludCBpcnFfZWZmZWN0aXZlX2NwdTsKPiArCXN0cnVj
dCBjcHVtYXNrIGlycV9hZmZpbml0eTsKPiAgIH07Cj4gICAKPiAgIHN0cnVjdCB2ZHVzZV9kZXY7
Cj4gQEAgLTEyOCw2ICsxMzIsNyBAQCBzdGF0aWMgc3RydWN0IGNsYXNzICp2ZHVzZV9jbGFzczsK
PiAgIHN0YXRpYyBzdHJ1Y3QgY2RldiB2ZHVzZV9jdHJsX2NkZXY7Cj4gICBzdGF0aWMgc3RydWN0
IGNkZXYgdmR1c2VfY2RldjsKPiAgIHN0YXRpYyBzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqdmR1
c2VfaXJxX3dxOwo+ICtzdGF0aWMgc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKnZkdXNlX2lycV9i
b3VuZF93cTsKPiAgIAo+ICAgc3RhdGljIHUzMiBhbGxvd2VkX2RldmljZV9pZFtdID0gewo+ICAg
CVZJUlRJT19JRF9CTE9DSywKPiBAQCAtNzA4LDYgKzcxMywxNSBAQCBzdGF0aWMgdTMyIHZkdXNl
X3ZkcGFfZ2V0X2dlbmVyYXRpb24oc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhKQo+ICAgCXJldHVy
biBkZXYtPmdlbmVyYXRpb247Cj4gICB9Cj4gICAKPiArc3RhdGljIGludCB2ZHVzZV92ZHBhX3Nl
dF92cV9hZmZpbml0eShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHUxNiBpZHgsCj4gKwkJCQkg
ICAgICBjb25zdCBzdHJ1Y3QgY3B1bWFzayAqY3B1X21hc2spCj4gK3sKPiArCXN0cnVjdCB2ZHVz
ZV9kZXYgKmRldiA9IHZkcGFfdG9fdmR1c2UodmRwYSk7Cj4gKwo+ICsJY3B1bWFza19jb3B5KCZk
ZXYtPnZxc1tpZHhdLT5pcnFfYWZmaW5pdHksIGNwdV9tYXNrKTsKPiArCXJldHVybiAwOwo+ICt9
Cj4gKwo+ICAgc3RhdGljIGludCB2ZHVzZV92ZHBhX3NldF9tYXAoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZHBhLAo+ICAgCQkJCXVuc2lnbmVkIGludCBhc2lkLAo+ICAgCQkJCXN0cnVjdCB2aG9zdF9p
b3RsYiAqaW90bGIpCj4gQEAgLTc1OCw2ICs3NzIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZk
cGFfY29uZmlnX29wcyB2ZHVzZV92ZHBhX2NvbmZpZ19vcHMgPSB7Cj4gICAJLmdldF9jb25maWcJ
CT0gdmR1c2VfdmRwYV9nZXRfY29uZmlnLAo+ICAgCS5zZXRfY29uZmlnCQk9IHZkdXNlX3ZkcGFf
c2V0X2NvbmZpZywKPiAgIAkuZ2V0X2dlbmVyYXRpb24JCT0gdmR1c2VfdmRwYV9nZXRfZ2VuZXJh
dGlvbiwKPiArCS5zZXRfdnFfYWZmaW5pdHkJPSB2ZHVzZV92ZHBhX3NldF92cV9hZmZpbml0eSwK
PiAgIAkucmVzZXQJCQk9IHZkdXNlX3ZkcGFfcmVzZXQsCj4gICAJLnNldF9tYXAJCT0gdmR1c2Vf
dmRwYV9zZXRfbWFwLAo+ICAgCS5mcmVlCQkJPSB2ZHVzZV92ZHBhX2ZyZWUsCj4gQEAgLTkxNyw3
ICs5MzIsOCBAQCBzdGF0aWMgdm9pZCB2ZHVzZV92cV9pcnFfaW5qZWN0KHN0cnVjdCB3b3JrX3N0
cnVjdCAqd29yaykKPiAgIH0KPiAgIAo+ICAgc3RhdGljIGludCB2ZHVzZV9kZXZfcXVldWVfaXJx
X3dvcmsoc3RydWN0IHZkdXNlX2RldiAqZGV2LAo+IC0JCQkJICAgIHN0cnVjdCB3b3JrX3N0cnVj
dCAqaXJxX3dvcmspCj4gKwkJCQkgICAgc3RydWN0IHdvcmtfc3RydWN0ICppcnFfd29yaywKPiAr
CQkJCSAgICBpbnQgaXJxX2VmZmVjdGl2ZV9jcHUpCj4gICB7Cj4gICAJaW50IHJldCA9IC1FSU5W
QUw7Cj4gICAKPiBAQCAtOTI2LDcgKzk0MiwxMSBAQCBzdGF0aWMgaW50IHZkdXNlX2Rldl9xdWV1
ZV9pcnFfd29yayhzdHJ1Y3QgdmR1c2VfZGV2ICpkZXYsCj4gICAJCWdvdG8gdW5sb2NrOwo+ICAg
Cj4gICAJcmV0ID0gMDsKPiAtCXF1ZXVlX3dvcmsodmR1c2VfaXJxX3dxLCBpcnFfd29yayk7Cj4g
KwlpZiAoaXJxX2VmZmVjdGl2ZV9jcHUgPT0gSVJRX1VOQk9VTkQpCj4gKwkJcXVldWVfd29yayh2
ZHVzZV9pcnFfd3EsIGlycV93b3JrKTsKPiArCWVsc2UKPiArCQlxdWV1ZV93b3JrX29uKGlycV9l
ZmZlY3RpdmVfY3B1LAo+ICsJCQkgICAgICB2ZHVzZV9pcnFfYm91bmRfd3EsIGlycV93b3JrKTsK
PiAgIHVubG9jazoKPiAgIAl1cF9yZWFkKCZkZXYtPnJ3c2VtKTsKPiAgIAo+IEBAIC0xMDI5LDYg
KzEwNDksMjIgQEAgc3RhdGljIGludCB2ZHVzZV9kZXZfcmVnX3VtZW0oc3RydWN0IHZkdXNlX2Rl
diAqZGV2LAo+ICAgCXJldHVybiByZXQ7Cj4gICB9Cj4gICAKPiArc3RhdGljIHZvaWQgdmR1c2Vf
dnFfdXBkYXRlX2VmZmVjdGl2ZV9jcHUoc3RydWN0IHZkdXNlX3ZpcnRxdWV1ZSAqdnEpCj4gK3sK
PiArCWludCBjdXJyX2NwdSA9IHZxLT5pcnFfZWZmZWN0aXZlX2NwdTsKPiArCj4gKwl3aGlsZSAo
dHJ1ZSkgewo+ICsJCWN1cnJfY3B1ID0gY3B1bWFza19uZXh0KGN1cnJfY3B1LCAmdnEtPmlycV9h
ZmZpbml0eSk7Cj4gKwkJaWYgKGNwdV9vbmxpbmUoY3Vycl9jcHUpKQo+ICsJCQlicmVhazsKPiAr
Cj4gKwkJaWYgKGN1cnJfY3B1ID49IG5yX2NwdV9pZHMpCj4gKwkJCWN1cnJfY3B1ID0gSVJRX1VO
Qk9VTkQ7Cj4gKwl9Cj4gKwo+ICsJdnEtPmlycV9lZmZlY3RpdmVfY3B1ID0gY3Vycl9jcHU7Cj4g
K30KPiArCj4gICBzdGF0aWMgbG9uZyB2ZHVzZV9kZXZfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGUs
IHVuc2lnbmVkIGludCBjbWQsCj4gICAJCQkgICAgdW5zaWduZWQgbG9uZyBhcmcpCj4gICB7Cj4g
QEAgLTExMTEsNyArMTE0Nyw3IEBAIHN0YXRpYyBsb25nIHZkdXNlX2Rldl9pb2N0bChzdHJ1Y3Qg
ZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50IGNtZCwKPiAgIAkJYnJlYWs7Cj4gICAJfQo+ICAgCWNh
c2UgVkRVU0VfREVWX0lOSkVDVF9DT05GSUdfSVJROgo+IC0JCXJldCA9IHZkdXNlX2Rldl9xdWV1
ZV9pcnFfd29yayhkZXYsICZkZXYtPmluamVjdCk7Cj4gKwkJcmV0ID0gdmR1c2VfZGV2X3F1ZXVl
X2lycV93b3JrKGRldiwgJmRldi0+aW5qZWN0LCBJUlFfVU5CT1VORCk7Cj4gICAJCWJyZWFrOwo+
ICAgCWNhc2UgVkRVU0VfVlFfU0VUVVA6IHsKPiAgIAkJc3RydWN0IHZkdXNlX3ZxX2NvbmZpZyBj
b25maWc7Cj4gQEAgLTExOTgsNyArMTIzNCwxMCBAQCBzdGF0aWMgbG9uZyB2ZHVzZV9kZXZfaW9j
dGwoc3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVkIGludCBjbWQsCj4gICAJCQlicmVhazsKPiAg
IAo+ICAgCQlpbmRleCA9IGFycmF5X2luZGV4X25vc3BlYyhpbmRleCwgZGV2LT52cV9udW0pOwo+
IC0JCXJldCA9IHZkdXNlX2Rldl9xdWV1ZV9pcnFfd29yayhkZXYsICZkZXYtPnZxc1tpbmRleF0t
PmluamVjdCk7Cj4gKwo+ICsJCXZkdXNlX3ZxX3VwZGF0ZV9lZmZlY3RpdmVfY3B1KGRldi0+dnFz
W2luZGV4XSk7Cj4gKwkJcmV0ID0gdmR1c2VfZGV2X3F1ZXVlX2lycV93b3JrKGRldiwgJmRldi0+
dnFzW2luZGV4XS0+aW5qZWN0LAo+ICsJCQkJCWRldi0+dnFzW2luZGV4XS0+aXJxX2VmZmVjdGl2
ZV9jcHUpOwo+ICAgCQlicmVhazsKPiAgIAl9Cj4gICAJY2FzZSBWRFVTRV9JT1RMQl9SRUdfVU1F
TTogewo+IEBAIC0xMzY3LDEwICsxNDA2LDEyIEBAIHN0YXRpYyBpbnQgdmR1c2VfZGV2X2luaXRf
dnFzKHN0cnVjdCB2ZHVzZV9kZXYgKmRldiwgdTMyIHZxX2FsaWduLCB1MzIgdnFfbnVtKQo+ICAg
CQkJZ290byBlcnI7Cj4gICAKPiAgIAkJZGV2LT52cXNbaV0tPmluZGV4ID0gaTsKPiArCQlkZXYt
PnZxc1tpXS0+aXJxX2VmZmVjdGl2ZV9jcHUgPSBJUlFfVU5CT1VORDsKPiAgIAkJSU5JVF9XT1JL
KCZkZXYtPnZxc1tpXS0+aW5qZWN0LCB2ZHVzZV92cV9pcnFfaW5qZWN0KTsKPiAgIAkJSU5JVF9X
T1JLKCZkZXYtPnZxc1tpXS0+a2ljaywgdmR1c2VfdnFfa2lja193b3JrKTsKPiAgIAkJc3Bpbl9s
b2NrX2luaXQoJmRldi0+dnFzW2ldLT5raWNrX2xvY2spOwo+ICAgCQlzcGluX2xvY2tfaW5pdCgm
ZGV2LT52cXNbaV0tPmlycV9sb2NrKTsKPiArCQljcHVtYXNrX3NldGFsbCgmZGV2LT52cXNbaV0t
PmlycV9hZmZpbml0eSk7Cj4gICAJfQo+ICAgCj4gICAJcmV0dXJuIDA7Cj4gQEAgLTE4NTgsMTIg
KzE4OTksMTUgQEAgc3RhdGljIGludCB2ZHVzZV9pbml0KHZvaWQpCj4gICAJaWYgKHJldCkKPiAg
IAkJZ290byBlcnJfY2RldjsKPiAgIAo+ICsJcmV0ID0gLUVOT01FTTsKPiAgIAl2ZHVzZV9pcnFf
d3EgPSBhbGxvY193b3JrcXVldWUoInZkdXNlLWlycSIsCj4gICAJCQkJV1FfSElHSFBSSSB8IFdR
X1NZU0ZTIHwgV1FfVU5CT1VORCwgMCk7Cj4gLQlpZiAoIXZkdXNlX2lycV93cSkgewo+IC0JCXJl
dCA9IC1FTk9NRU07Cj4gKwlpZiAoIXZkdXNlX2lycV93cSkKPiAgIAkJZ290byBlcnJfd3E7Cj4g
LQl9Cj4gKwo+ICsJdmR1c2VfaXJxX2JvdW5kX3dxID0gYWxsb2Nfd29ya3F1ZXVlKCJ2ZHVzZS1p
cnEtYm91bmQiLCBXUV9ISUdIUFJJLCAwKTsKPiArCWlmICghdmR1c2VfaXJxX2JvdW5kX3dxKQo+
ICsJCWdvdG8gZXJyX2JvdW5kX3dxOwo+ICAgCj4gICAJcmV0ID0gdmR1c2VfZG9tYWluX2luaXQo
KTsKPiAgIAlpZiAocmV0KQo+IEBAIC0xODc3LDYgKzE5MjEsOCBAQCBzdGF0aWMgaW50IHZkdXNl
X2luaXQodm9pZCkKPiAgIGVycl9tZ210ZGV2Ogo+ICAgCXZkdXNlX2RvbWFpbl9leGl0KCk7Cj4g
ICBlcnJfZG9tYWluOgo+ICsJZGVzdHJveV93b3JrcXVldWUodmR1c2VfaXJxX2JvdW5kX3dxKTsK
PiArZXJyX2JvdW5kX3dxOgo+ICAgCWRlc3Ryb3lfd29ya3F1ZXVlKHZkdXNlX2lycV93cSk7Cj4g
ICBlcnJfd3E6Cj4gICAJY2Rldl9kZWwoJnZkdXNlX2NkZXYpOwo+IEBAIC0xODk2LDYgKzE5NDIs
NyBAQCBzdGF0aWMgdm9pZCB2ZHVzZV9leGl0KHZvaWQpCj4gICB7Cj4gICAJdmR1c2VfbWdtdGRl
dl9leGl0KCk7Cj4gICAJdmR1c2VfZG9tYWluX2V4aXQoKTsKPiArCWRlc3Ryb3lfd29ya3F1ZXVl
KHZkdXNlX2lycV9ib3VuZF93cSk7Cj4gICAJZGVzdHJveV93b3JrcXVldWUodmR1c2VfaXJxX3dx
KTsKPiAgIAljZGV2X2RlbCgmdmR1c2VfY2Rldik7Cj4gICAJZGV2aWNlX2Rlc3Ryb3kodmR1c2Vf
Y2xhc3MsIHZkdXNlX21ham9yKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
